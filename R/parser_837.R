#' X12-837I (X223A3) & X12-837P (X222A2) Health Care Claim Parser
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
#'    - a single `SE`
#'
#' @param x `<chr>` string of raw X12-837 text
#' @returns list
#' @examples
#' idx = purrr::map(c(hcc::x12_837I, hcc::x12_837P), index_x12)
#' purrr::map(idx, parse_837)
#' @export
parse_837 <- function(x) {
  if (!S7::S7_inherits(x, X12Index)) {
    return(NA_character_)
  }

  header <- list(
    ISA = split_i(x@text, x@index$ISA),
    GS = split_i(x@text, x@index$GS)
  )

  transactions <- subset_(x@text, x@index$ST, x@index$SE - 1L)

  trailer <- list(
    SE = split_i(x@text, x@index$SE),
    GE = split_i(x@text, x@index$GE),
    IEA = split_i(x@text, x@index$IEA)
  )

  list(
    Header = header,
    Transactions = transactions,
    Trailer = trailer
  )
}

#' @noRd
index_837I_x223 <- function(x) {
  list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    BHT = perl(x, "^BHT"),
    NM140 = perl(x, r"(^NM1\*40)"),
    NM141 = perl(x, r"(^NM1\*41)"),
    NM171 = perl(x, r"(^NM1\*71)"),
    NM185 = perl(x, r"(^NM1\*85)"),
    NM1IL = perl(x, r"(^NM1\*IL)"),
    NM1PR = perl(x, r"(^NM1\*PR)"),
    NM1QC = perl(x, r"(^NM1\*QC)"),
    PERIC = perl(x, r"(^PER\*IC)"),
    HL = perl(x, "^HL"),
    N3 = perl(x, "^N3"),
    N4 = perl(x, "^N4"),
    REF1G = perl(x, r"(^REF\*1G)"),
    REF2U = perl(x, r"(^REF\*2U)"),
    REF6R = perl(x, r"(^REF\*6R)"),
    REF9A = perl(x, r"(^REF\*9A)"),
    REFD9 = perl(x, r"(^REF\*D9)"),
    REFEI = perl(x, r"(^REF\*EI)"),
    REFG2 = perl(x, r"(^REF\*G2)"),
    REFLU = perl(x, r"(^REF\*LU)"),
    REFY4 = perl(x, r"(^REF\*Y4)"),
    SBRP = perl(x, r"(^SBR\*P\*)"),
    SBRS = perl(x, r"(^SBR\*S\*)"),
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
    DMH = perl(x, "^DMH"),
    CAS = perl(x, "^CAS"),
    OI = perl(x, "^OI"),
    MOA = perl(x, "^MOA"),
    MEA = perl(x, "^MEA"),
    CLM = perl(x, "^CLM"),
    HIABJ = perl(x, r"(^HI\*ABJ)"),
    HIABK = perl(x, r"(^HI\*ABK)"),
    HIBE = perl(x, r"(^HI\*BE)"),
    HIBF = perl(x, r"(^HI\*BF)"),
    HIBG = perl(x, r"(^HI\*BG)"),
    HIBH = perl(x, r"(^HI\*BH)"),
    HIBK = perl(x, r"(^HI\*BK)"),
    HIBN = perl(x, r"(^HI\*BN)"),
    HIPR = perl(x, r"(^HI\*PR)"),
    PRVBI = perl(x, r"(^PRV\*BI)"),
    PRVAT = perl(x, r"(^PRV\*AT)"),
    LX = perl(x, "^LX"),
    SV1 = perl(x, "^SV1"),
    SV2 = perl(x, "^SV2"),
    SV5 = perl(x, "^SV5"),
    DTP096 = perl(x, r"(^DTP\*096)"),
    DTP434 = perl(x, r"(^DTP\*434)"),
    DTP435 = perl(x, r"(^DTP\*435)"),
    DTP472 = perl(x, r"(^DTP\*472)"),
    DTP523 = perl(x, r"(^DTP\*523)"),
    CR8 = perl(x, r"(^CR8)"),
    CL1 = perl(x, "^CL1"),
    NTE = perl(x, "^NTE"),
    CTP = perl(x, "^CTP"),
    LIN = perl(x, "^LIN"),
    LU = perl(x, "^LU"),
    LQ = perl(x, "^LQ"),
    FRM = perl(x, "^FRM"),
    QTY = perl(x, "^QTY"),
    SE = perl(x, "^SE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )
}

#' @noRd
index_837P_x222 <- function(x) {
  list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    HCP = perl(x, "^HCP"),
    AMT = perl(x, "^AMT"),
    OI = perl(x, "^OI"),
    CAS = perl(x, "^CAS"),
    CR1 = perl(x, "^CR1"),
    CRC = perl(x, "^CRC"),
    QTYPT = perl(x, r"(^QTY\*PT)"),
    CR2 = perl(x, "^CR2"),
    PAT = perl(x, "^PAT"),
    PWK = perl(x, "^PWK"),
    CR3 = perl(x, "^CR3"),
    LQUT = perl(x, r"(^LQ\*UT)"),
    FRM = perl(x, "^FRM"),
    MEA = perl(x, "^MEA"),
    NTE = perl(x, "^NTE"),
    DMG = perl(x, "^DMG"),
    PRVBI = perl(x, r"(^PRV\*BI)"),
    PRVPE = perl(x, r"(^PRV\*PE)"),
    LIN = perl(x, "^LIN"),
    CTP = perl(x, "^CTP"),
    N3 = perl(x, "^N3"),
    N4 = perl(x, "^N4"),
    BHT = perl(x, "^BHT"),
    CLM = perl(x, "^CLM"),
    PERIC = perl(x, r"(^PER\*IC)"),
    HL = perl(x, "^HL"),
    LX = perl(x, "^LX"),
    SV1 = perl(x, "^SV1"),
    SVD = perl(x, "^SVD"),
    SBRP = perl(x, r"(^SBR\*P\*)"),
    SBRS = perl(x, r"(^SBR\*S\*)"),
    HIABK = perl(x, r"(^HI\*ABK)"),
    HIBK = perl(x, r"(^HI\*BK)"),
    NM140 = perl(x, r"(^NM1\*40)"),
    NM141 = perl(x, r"(^NM1\*41)"),
    NM145 = perl(x, r"(^NM1\*45)"),
    NM177 = perl(x, r"(^NM1\*77)"),
    NM182 = perl(x, r"(^NM1\*82)"),
    NM185 = perl(x, r"(^NM1\*85)"),
    NM187 = perl(x, r"(^NM1\*87)"),
    NM1DN = perl(x, r"(^NM1\*DN)"),
    NM1DK = perl(x, r"(^NM1\*DK)"),
    NM1IL = perl(x, r"(^NM1\*IL)"),
    NM1PR = perl(x, r"(^NM1\*PR)"),
    NM1PW = perl(x, r"(^NM1\*PW)"),
    NM1QC = perl(x, r"(^NM1\*QC)"),
    REF1G = perl(x, r"(^REF\*1G)"),
    REF6R = perl(x, r"(^REF\*6R)"),
    REF9A = perl(x, r"(^REF\*9A)"),
    REFD9 = perl(x, r"(^REF\*D9)"),
    REFEI = perl(x, r"(^REF\*EI)"),
    REFG2 = perl(x, r"(^REF\*G2)"),
    DTP096 = perl(x, r"(^DTP\*096)"),
    DTP431 = perl(x, r"(^DTP\*431)"),
    DTP434 = perl(x, r"(^DTP\*434)"),
    DTP435 = perl(x, r"(^DTP\*435)"),
    DTP439 = perl(x, r"(^DTP\*439)"),
    DTP453 = perl(x, r"(^DTP\*453)"),
    DTP454 = perl(x, r"(^DTP\*454)"),
    DTP455 = perl(x, r"(^DTP\*455)"),
    DTP461 = perl(x, r"(^DTP\*461)"),
    DTP463 = perl(x, r"(^DTP\*463)"),
    DTP472 = perl(x, r"(^DTP\*472)"),
    DTP573 = perl(x, r"(^DTP\*573)"),
    DTP607 = perl(x, r"(^DTP\*607)"),
    SE = perl(x, "^SE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )
}
