#' @noRd
entity_loop_820 <- function(x) {
  # 2300B Remittance Detail Loop
  seqs <- map_seq(x, perl(x, "^RMR"), perl(x, "^DTM\\*582"))

  loops <- purrr::map(seqs, function(x) {
    rlang::list2(
      RMR = split_p(x, "^RMR"),
      !!!split_N1(x, perl(x, "^REF")),
      DTM = split_p(x, "^DTM\\*582")
    )
  }) |>
    purrr::list_flatten()

  rlang::list2(
    # 2000B Per-Member Entity Loop
    ENT = split_p(x, "^ENT"),
    NM1 = split_p(x, "^NM1"),
    !!!loops,
    ADX = if (any_(grepl("^ADX", x))) split_p(x, "^ADX") else NULL
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
  x <- tilde(text)

  header <- rlang::list2(
    ISA = split_p(x, "^ISA"),
    GS = split_p(x, "^GS"),
    ST = split_p(x, "^ST"),
    BPR = split_p(x, "^BPR"),
    !!!split_TRN(x)
  )

  ENT_start <- perl(x, "^ENT")
  ENT_end <- cheapr::c_(ENT_start[-1L], perl(x, "^SE")) - 1L

  ENT_loop <- map_seq(x, ENT_start, ENT_end)
  ENT_loop <- name_loop(ENT_loop)
  ENT_loop <- purrr::map(ENT_loop, entity_loop_820)

  trailer <- list(
    SE = split_p(x, "^SE"),
    GE = split_p(x, "^GE"),
    IEA = split_p(x, "^IEA")
  )

  collapse::qTBL(
    collapse::rowbind(
      list(
        HEADER = unlist_df(header),
        ENTITY_LOOP = collapse::rowbind(ENT_loop),
        TRAILER = unlist_df(trailer)
      )
    )
  )
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
  tilde(text)
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
  x <- tilde(text)

  header <- list(
    ISA = split_p(x, "^ISA"),
    GS = split_p(x, "^GS"),
    ST = split_p(x, "^ST"),
    BHT = split_p(x, "^BHT")
  )

  # perl(x, "^NM1\\*41") # Submitter Name
  # perl(x, "^PER\\*IC")[1] # Submitter EDI Contact Information
  # perl(x, "^NM1\\*40") # Receiver Name
  # perl(x, "^PER\\*IC")[2] # Receiver EDI Contact Information
  # perl(x, "^HL") # Hierarchical Level
  # perl(x, "^NM1\\*85") # Billing Provider Name
  # perl(x, "^SBR") # Subscriber Information
  # Claim Information
  # c(perl(x, "^CLM"), perl(x, "^SE") - 1L)

  trailer <- list(
    SE = split_p(x, "^SE"),
    GE = split_p(x, "^GE"),
    IEA = split_p(x, "^IEA")
  )

  collapse::qTBL(
    collapse::rowbind(
      list(
        HEADER = unlist_df(header),
        # ENTITY_LOOP = collapse::rowbind(ENT_loop),
        TRAILER = unlist_df(trailer)
      )
    )
  )
}
