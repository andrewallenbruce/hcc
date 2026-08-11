#' @noRd
split_tilde <- function(x) {
  strsplit(x, "~", fixed = TRUE)[[1]]
}

#' @noRd
split_star <- function(x, pad = FALSE, replace_na = FALSE) {
  if (!pad) {
    return(strsplit(x, "*", fixed = TRUE)[[1]][-1])
  }
  pad_names(
    strsplit(x, "*", fixed = TRUE)[[1]][-1],
    replace_na = replace_na
  )
}

#' @noRd
pad_names <- function(x, replace_na = FALSE) {
  if (replace_na) {
    x[!nzchar(x)] <- NA_character_
  }

  N = as.character(seq_along(x))
  i = cheapr::which_(nchar(N) == 1L)
  N[i] = cheapr::paste_("0", N[i])
  rlang::set_names(as.list(x), N)
}

#' X12-820 Payment Order/Remittance Advice Parser
#'
#' Parses X12-820 (005010X218) transactions for Medicaid/Medicare capitation and
#' premium payments. Designed for California DHCS PACE capitation remittances
#' but handles the general 820 format used by state Medicaid agencies.
#'
#' Key segments parsed:
#'    - ISA/GS: Interchange and group headers (source ID, report date)
#'    - BPR: Payment amount and effective date
#'    - TRN: EFT/check trace number
#'    - N1/N3/N4: Payer and payee name and address
#'    - ENT: Per-member entity loop start
#'    - NM1: Member name and ID
#'    - RMR: Remittance line item (reference number, payment amount)
#'    - REF*18: Rate code (e.g., "957" = PACE rate)
#'    - REF*ZZ: Aid code/plan type composite and description
#'    - DTM*582: Coverage period date range
#'    - ADX: Adjustment amount and reason code
#'
#' Typical loop structure within an 820:
#'    - Header: ISA > GS > ST > BPR > TRN > N1(PE) > N1(PR)
#'    - Per-member: ENT > NM1 > (RMR > REF*18 > REF*ZZ > REF*ZZ > DTM*582 > ADX?) +
#'    - Trailer: SE > GE > IEA
#'
#' @param text `<chr>` string of raw X12-820 text
#' @returns list
#' @examples
#' parse_820(hcc::x12_820$sample_820_01)
#' parse_820(hcc::x12_820$sample_820_05)
#' @export
parse_820 <- function(text) {
  x = split_tilde(text)

  # ISA Interchange Control Header - Length = 16
  isa = strsplit(x[1], " ", fixed = TRUE)[[1]]
  isa = unlist_(strsplit(isa[nzchar(isa)], "*", fixed = TRUE))[c(-1, -8, -11)]
  isa = pad_names(isa, replace_na = TRUE)

  # GS Functional Group Header - Length = 8
  gs = split_star(x[2], pad = TRUE)

  # ST 820 Header - Length = 3
  st = split_star(x[3], pad = TRUE)

  # BPR Financial Information - Length = 16
  bpr = split_star(x[4], pad = TRUE, replace_na = TRUE)

  # TRN Reassociation Trace Number - Length = 2
  trn = split_star(x[5], pad = TRUE)

  # REF Reference Identification - Length = 2
  ref = split_star(x[6], pad = TRUE)

  # 1000A Loop: Premium Receiver's Loop
  n1pe = split_star(x[7], pad = TRUE) # N1 Premium Receiver's Name
  n3pe = split_star(x[8], pad = TRUE) # N3 Premium Receiver's Address
  n4pe = split_star(x[9], pad = TRUE) # N4 Premium Receiver's City State ZIP

  # 1000B Loop: Premium Payer's Loop
  n1pr = split_star(x[10], pad = TRUE) # N1 Premium Payer's Name
  n3pr = split_star(x[11], pad = TRUE) # N3 Premium Payer's Address
  n4pr = split_star(x[12], pad = TRUE) # N4 Premium Payer's City State ZIP

  list(
    ISA = isa,
    GS = gs,
    ST = st,
    BPR = bpr,
    TRN = trn,
    REF = ref,
    N1_PE = n1pe,
    N3_PE = n3pe,
    N4_PE = n4pe,
    N1_PR = n1pr,
    N3_PR = n3pr,
    N4_PR = n4pr
  ) |>
    collapse::unlist2d(idcols = "id") |>
    collapse::rnm("id.1" = "SEG", "id.2" = "N", "V1" = "VAL")
}
