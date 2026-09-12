#' 2300B Remittance Detail Loop
#' 2000B Per-Member Entity Loop
#' @noRd
entity_loop_820 <- function(x) {
  i <- subset_(x, perl(x, "^RMR"), perl(x, "^DTM\\*582"))

  REMIT <- purrr::map(i, function(x) {
    rlang::list2(
      RMR = split_p(x, "^RMR"),
      !!!split_n(x, perl(x, "^REF")),
      DTM = split_p(x, "^DTM\\*582")
    )
  }) |>
    purrr::list_flatten()

  rlang::list2(
    ENT = split_p(x, "^ENT"),
    NM1 = split_p(x, "^NM1"),
    !!!REMIT,
    ADX = if (any_(perl0(x, "^ADX"))) split_p(x, "^ADX") else NULL
  ) |>
    purrr::compact() |>
    unlist_df()
}

#' 1000A Payee Name Loop
#' 1000B Payer Name Loop
#' @noRd
payee_loop_820 <- function(x) {
  PR <- perl(x, "^N1\\*PR")
  c(
    split_n(x, seq.int(perl(x, "^N1\\*PE"), PR - 1L)),
    split_n(x, seq.int(PR, collapse::fmin(perl(x, "^ENT")) - 1L))
  )
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
#' purrr::map(hcc::x12_820, index_820)
#' purrr::map(hcc::x12_820, parse_820)
#' @export
parse_820 <- function(text) {
  x <- tilde(text)

  header <- list(
    ISA = split_p(x, "^ISA"),
    GS = split_p(x, "^GS"),
    ST = split_p(x, "^ST"),
    BPR = split_p(x, "^BPR"),
    TRN = split_p(x, "^TRN"),
    REF = split_i(x, perl(x, "^TRN") + 1L)
  )

  payee <- payee_loop_820(x)

  ENT <- perl(x, "^ENT")
  SE <- perl(x, "^SE")

  entity <- subset_(x, ENT, c(ENT[-1L], SE) - 1L) |>
    purrr::map(entity_loop_820) |>
    collapse::rowbind()

  trailer <- list(
    SE = split_i(x, SE),
    GE = split_p(x, "^GE"),
    IEA = split_p(x, "^IEA")
  )

  collapse::rowbind(
    unlist_df(header),
    unlist_df(payee),
    entity,
    unlist_df(trailer)
  ) |>
    collapse::qTBL()
}

#' @rdname parse_820
#' @export
index_820 <- function(text) {
  x <- tilde(text)

  i <- list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    BPR = perl(x, "^BPR"),
    TRN = perl(x, "^TRN"),
    `REF*14` = perl(x, r"(REF\*14)"),
    N1 = perl(x, "^N1"),
    N3 = perl(x, "^N3"),
    N4 = perl(x, "^N4"),
    ENT = perl(x, "^ENT"),
    NM1 = perl(x, "^NM1"),
    RMR = perl(x, "^RMR"),
    `REF*18` = perl(x, r"(^REF\*18)"),
    `REF*ZZ` = perl(x, r"(^REF\*ZZ)"),
    DTM = perl(x, "^DTM"),
    ADX = perl(x, "^ADX"),
    SE = perl(x, "^SE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )

  new_x12_index(i, x, text)
}

#' X12-834 Benefit Enrollment Parser
#'
#' The 834 carries *membership events*:
#'    - new enrollment (qualifier 021)
#'    - change (001)
#'    - termination (024)
#'    - audit/reconciliation (030)
#'
#' It transports member demographics, dependents, chosen plan, effective and end
#' dates, premium amounts, occasionally tax elements and primary care provider.
#' It is the system of record for membership on the payer side.
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
#' purrr::map(hcc::x12_834, index_834)
#' purrr::map(hcc::x12_834, parse_834)
#' @export
parse_834 <- function(text) {
  tilde(text)
}

#' @rdname parse_834
#' @export
index_834 <- function(text) {
  x <- tilde(text)

  i <- list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    BGN = perl(x, "^BGN"),
    QTY = perl(x, "^QTY"),
    REF = perl(x, "^REF"),
    DTP = perl(x, "^DTP"),
    N1 = perl(x, "^N1"),
    ACT = perl(x, "^ACT"),
    INS = perl(x, "^INS"),
    NM1 = perl(x, "^NM1"),
    PER = perl(x, "^PER"),
    N3 = perl(x, "^N3"),
    N4 = perl(x, "^N4"),
    DMG = perl(x, "^DMG"),
    EC = perl(x, "^EC"),
    ICM = perl(x, "^ICM"),
    AMT = perl(x, "^AMT"),
    HLH = perl(x, "^HLH"),
    LUI = perl(x, "^LUI"),
    DSB = perl(x, "^DSB"),
    IDC = perl(x, "^IDC"),
    PLA = perl(x, "^PLA"),
    COB = perl(x, "^COB"),
    LS = perl(x, "^LS"),
    LX = perl(x, "^LX"),
    LE = perl(x, "^LE"),
    HD = perl(x, "^HD"),
    SE = perl(x, "^SE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )

  new_x12_index(i, x, text)
}

#' X12-837 Health Care Claim Parser
#'
#' The 837 describes the care event: who (rendering provider, supervising
#' physician, referring), for whom (subscriber, patient), for what (ICD-10
#' diagnosis, CPT/HCPCS procedure), when (service date, units), where (place of
#' service), and how much (charged amount, contractual reference). Three `TR3`s
#' segment the audience:
#'    - `005010X222A1`: **837P** Professional (Physicians, Ambulatory, Telemedicine)
#'    - `005010X223A2`: **837I** Institutional (Hospitals, ED, Hospice)
#'    - `005010X224A2`: **837D** Dental
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
#' purrr::map(hcc::x12_837, index_837)
#' purrr::map(hcc::x12_837, parse_837)
#' @export
parse_837 <- function(text) {
  x <- tilde(text)

  header <- list(
    ISA = split_p(x, "^ISA"),
    GS = split_p(x, "^GS")
  )

  transactions <- subset_(x, perl(x, "^ST"), perl(x, "^SE"))

  trailer <- list(
    GE = split_p(x, "^GE"),
    IEA = split_p(x, "^IEA")
  )

  list(
    HEADER = unlist_df(header),
    TRANSACTIONS = transactions,
    TRAILER = unlist_df(trailer)
  )
}

#' @rdname parse_837
#' @export
index_837 <- function(text) {
  x <- tilde(text)

  i <- list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    BPR = perl(x, "^BHT"),
    NM1 = perl(x, "^NM1"),
    PER = perl(x, "^PER"),
    HL = perl(x, "^HL"),
    N3 = perl(x, "^N3"),
    N4 = perl(x, "^N4"),
    REF = perl(x, "^REF"),
    SBR = perl(x, "^SBR"),
    PAT = perl(x, "^PAT"),
    PWK = perl(x, "^PWK"),
    AMT = perl(x, "^AMT"),
    CN1 = perl(x, "^CN1"),
    K3 = perl(x, "^K3"),
    NTE = perl(x, "^NTE"),
    CR1 = perl(x, "^CR1"),
    CR2 = perl(x, "^CR2"),
    CR3 = perl(x, "^CR3"),
    CRC = perl(x, "^CRC"),
    HCP = perl(x, "^HCP"),
    DMG = perl(x, "^DMG"),
    CAS = perl(x, "^CAS"),
    OI = perl(x, "^OI"),
    MOA = perl(x, "^MOA"),
    MEA = perl(x, "^MEA"),
    CLM = perl(x, "^CLM"),
    HI = perl(x, "^HI"),
    PRV = perl(x, "^PRV"),
    LX = perl(x, "^LX"),
    SV1 = perl(x, "^SV1"),
    SV2 = perl(x, "^SV2"),
    SV5 = perl(x, "^SV5"),
    DTP = perl(x, "^DTP"),
    SE = perl(x, "^SE"),
    NTE = perl(x, "^NTE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )

  new_x12_index(i, x, text)
}
