#' @noRd
unlist_df <- function(x) {
  collapse::unlist2d(x, idcols = "id") |>
    collapse::rnm(
      "id.1" = "SEG",
      "id.2" = "PT",
      "V1" = "VALUE"
    )
}

#' @noRd
map_seq <- function(text, start, end) {
  purrr::map(
    purrr::map2(
      start,
      end,
      function(a, b) seq.int(a, b)
    ),
    function(i) text[i]
  )
}

#' @noRd
name_loop <- function(x) {
  rlang::set_names(x, ~ paste0("L", seq_along(.)))
}

#' @noRd
nzchar_na <- function(x) {
  x[!nzchar(x)] <- NA_character_
  x
}

#' @noRd
pad_names <- function(x) {
  # N[i] <- cheapr::paste_("0", N[i])
  N <- as.character(seq_along(x))
  i <- collapse::whichv(nchar(N), 1L)
  collapse::setv(N, i, cheapr::paste_("0", N[i]))
  rlang::set_names(as.list(x), N)
}

#' @noRd
split_tilde <- function(x) {
  strsplit(x, "~", fixed = TRUE)[[1]]
}

#' @noRd
split_star <- function(x, pad = TRUE, replace_na = FALSE) {
  if (!pad) {
    return(strsplit(x, "*", fixed = TRUE)[[1]][-1])
  }

  if (!replace_na) {
    return(pad_names(strsplit(x, "*", fixed = TRUE)[[1]][-1]))
  }
  pad_names(nzchar_na(strsplit(x, "*", fixed = TRUE)[[1]][-1]))
}

#' @noRd
split_ISA <- function(x) {
  strsplit(
    .subset(
      x,
      perl(x, "^ISA")
    ),
    "*",
    fixed = TRUE
  )[[1]][-1] |>
    trimws() |>
    nzchar_na() |>
    pad_names()
}

#' @noRd
split_BPR <- function(x) {
  strsplit(
    .subset(
      x,
      perl(x, "^BPR")
    ),
    "*",
    fixed = TRUE
  )[[1]][-1] |>
    trimws() |>
    nzchar_na() |>
    pad_names()
}

#' @noRd
split_TRN <- function(x) {
  trn <- perl(x, "^TRN")
  ref <- trn + 1L

  pe <- perl(x, "^N1\\*PE")
  pr <- perl(x, "^N1\\*PR")
  p2 <- min(perl(x, "^ENT")) - 1L

  sp <- \(x, i) {
    strsplit(.subset(x, i), "*", fixed = TRUE)[[1]][-1] |>
      trimws() |>
      nzchar_na() |>
      pad_names()
  }

  n1 <- \(x, i) {
    x <- strsplit(.subset(x, i), "*", fixed = TRUE)
    n <- purrr::map_chr(x, 1L)
    purrr::map(x, \(x) {
      pad_names(nzchar_na(trimws(x[-1L])))
    }) |>
      rlang::set_names(n)
  }

  rlang::list2(
    TRN = sp(x, trn),
    REF = sp(x, ref),
    !!!n1(x, seq.int(pe, pr - 1L)),
    !!!n1(x, seq.int(pr, p2))
  )
}

#' @noRd
parse_loop_820 <- function(x) {
  start = perl(x, "^RMR")
  end = perl(x, "^DTM\\*582")
  segments <- map_seq(x, start, end)

  segment_list <- purrr::map(segments, function(x) {
    list(
      RMR = split_star(x[perl(x, "^RMR")], replace_na = TRUE),
      REF = split_star(x[perl(x, "^REF\\*18")]),
      REF = split_star(x[perl(x, "^REF\\*ZZ")][1]),
      REF = split_star(x[perl(x, "^REF\\*ZZ")][2]),
      DTM = split_star(x[perl(x, "^DTM\\*582")], replace_na = TRUE)
    )
  }) |>
    purrr::list_flatten()

  adx <- if (any_(grepl("^ADX", x))) {
    split_star(x[perl(x, "^ADX")])
  } else {
    NULL
  }

  rlang::list2(
    ENT = split_star(x[perl(x, "^ENT")]),
    NM1 = split_star(x[perl(x, "^NM1")], replace_na = TRUE),
    !!!segment_list,
    ADX = adx
  ) |>
    purrr::compact() |>
    unlist_df()
}

#' X12-820 Payment Order/Remittance Advice Parser
#'
#' Parses X12-820 (005010X218) transactions for Medicaid/Medicare capitation and
#' premium payments. Designed for California DHCS PACE capitation remittances
#' but handles the general 820 format used by state Medicaid agencies.
#'
#' Key segments parsed:
#'    - `ISA/GS`: Interchange and group headers (source ID, report date)
#'    - `BPR`: Payment amount and effective date
#'    - `TRN`: EFT/check trace number
#'    - `N1/N3/N4`: Payer and payee name and address
#'    - `ENT`: Per-member entity loop start
#'    - `NM1`: Member name and ID
#'    - `RMR`: Remittance line item (reference number, payment amount)
#'    - `REF*18`: Rate code (e.g., "957" = PACE rate)
#'    - `REF*ZZ`: Aid code/plan type composite and description
#'    - `DTM*582`: Coverage period date range
#'    - `ADX`: Adjustment amount and reason code
#'
#' Typical loop structure within an 820:
#'    - Header: `ISA` > `GS` > `ST` > `BPR` > `TRN` > `N1*PE` > `N1*PR`
#'    - Per-member: `ENT` > `NM1` > (`RMR` > `REF*18` > `REF*ZZ` > `REF*ZZ` > `DTM*582` > `ADX`)
#'    - Trailer: `SE` > `GE` > `IEA`
#'
#' @param text `<chr>` string of raw X12-820 text
#' @returns list
#' @examples
#' purrr::map(hcc::x12_820, parse_820)
#' @export
parse_820 <- function(text) {
  x <- split_tilde(text)

  header <- rlang::list2(
    ISA = split_ISA(x),
    GS = split_star(x[perl(x, "^GS")]),
    ST = split_star(x[perl(x, "^ST")]),
    BPR = split_BPR(x),
    !!!split_TRN(x)
  ) |>
    unlist_df()

  start <- perl(x, "^ENT")
  end <- cheapr::c_(start[-1L], perl(x, "^SE")) - 1L

  loop <- map_seq(x, start, end)
  loop <- purrr::map(name_loop(loop), parse_loop_820)

  trailer <- list(
    SE = split_star(x[perl(x, "^SE")]),
    GE = split_star(x[perl(x, "^GE")]),
    IEA = split_star(x[perl(x, "^IEA")])
  ) |>
    unlist_df()

  collapse::qTBL(collapse::rowbind(list(
    HEADER = header,
    LOOP = collapse::rowbind(loop),
    TRAILER = trailer
  )))
}

#' X12-834 Benefit Enrollment Parser
#'
#' The 834 is heavily used by BPaaS (Benefits Administration as a Service):
#'    - Workday Benefits
#'    - ADP TotalSource
#'    - bswift
#'    - BenefitFocus
#'    - Empyrean
#'
#' It is also the official pipe between ACA state exchanges / marketplaces and
#' payers. The Open Enrollment window (November – December) produces volume
#' spikes that stress overnight batch jobs.
#'
#' Extracts enrollment and demographic data from 834 transactions with focus on:
#'    - Risk adjustment fields (dual eligibility, OREC/CREC, SNP, LTI)
#'    - CA DHCS FAME-specific fields
#'    - HCP (Health Care Plan) coverage history
#'
#' @param text `<chr>` string of raw X12-834 text
#' @returns list
#' @examples
#' purrr::map(hcc::x12_834, parse_834)
#' @export
parse_834 <- function(text) {
  split_tilde(text)
}

#' X12-837 Health Care Claim Parser
#'
#' The 837 is the highest-volume transaction in US healthcare EDI. Every
#' commercial and public payer (Medicare, Medicaid, Tricare) consumes hundreds
#' of millions per month.
#'
#' The entire provider-side billing revolves around its generation: from the EHR
#' (Epic, Cerner, Athenahealth, NextGen) or the PMS (Kareo, AdvancedMD,
#' eClinicalWorks), through a clearinghouse (Availity, Change Healthcare,
#' Waystar, Trizetto), with `277CA`, `999`, and ultimately `835` returns.
#'
#' ## Common segments
#' ### Transaction Set Header
#'    - `BHT`: Beginning of Hierarchical Transaction
#'       - Purpose `00` (Original)
#'       - Transaction type `CH` (Chargeable)
#'       - `RP` Reporting
#'       - Submitter `NM1*41`
#'       - Receiver `NM1*40`
#' ### Detail: Three hierarchical levels
#'    - `2000A` Billing Provider (Practice or Facility, with NPI, Taxonomy, TIN)
#'    - `2000B` Subscriber Loop (Contract Holder)
#'       - `SBR`:
#'          - Subscriber Information with relationship code
#'          - Claim filing indicator (`CI` Commercial Insurance, `MB` Medicare Part B, `MC` Medicaid, etc.)
#'    - `2000C` Patient Loop (the Patient when different from the Subscriber).
#'       - At the claim level, `CLM` Claim Information carries the patient account, total charge, facility code, claim frequency.
#'       - `HI` Health Care Information Codes carries ICD-10 diagnoses (qualifier `ABK` Principal Diagnosis, `ABF` Other Diagnosis).
#'       - The service section groups `LX` + `SV1` (Professional) / `SV2` (Institutional) / `SV3` (Dental) detailing each procedure with its CPT / HCPCS / CDT code, modifiers, units, charge, and service date via `DTP`.
#' ### Summary
#'    — a single `SE`
#'
#' @param text `<chr>` string of raw X12-837 text
#' @returns list
#' @examples
#' purrr::map(hcc::x12_837[1], parse_837)
#' @export
parse_837 <- function(text) {
  x <- split_tilde(text)

  header <- list(
    ISA = split_ISA(x),
    GS = split_star(x[perl(x, "^GS")]),
    ST = split_star(x[perl(x, "^ST")]),
    BHT = split_star(x[perl(x, "^BHT")], replace_na = TRUE)
  ) |>
    unlist_df()
  return(header)

  # list(
  #   `NM1*41` = split_star(x[perl(x, "^NM1\\*41")]),
  #   PER = split_star(x[perl(x, "^PER")], replace_na = TRUE),
  #   `NM1*40` = split_star(x[perl(x, "^NM1\\*40")])
  # )
}
