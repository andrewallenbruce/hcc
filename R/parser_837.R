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
    ISA = split_7(x, "ISA"),
    GS = split_7(x, "GS"),
    ST = split_7(x, "ST")
  )

  transactions <- subset_(x@text, x@index$ST, x@index$SE - 1L)

  trailer <- parse_TRAILER(x)

  c(header, transactions, trailer)
}

#' @noRd
index_837I_x223 <- function(x) {
  list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    AMT = perl(x, "^AMT"),
    BHT = perl(x, "^BHT"),
    CAS = perl(x, "^CAS"),
    CL1 = perl(x, "^CL1"),
    CLM = perl(x, "^CLM"),
    CN1 = perl(x, "^CN1"),
    CR1 = perl(x, "^CR1"),
    CR2 = perl(x, "^CR2"),
    CR3 = perl(x, "^CR3"),
    CR8 = perl(x, "^CR8"),
    CRC = perl(x, "^CRC"),
    CTP = perl(x, "^CTP"),
    DMG = perl(x, "^DMG"),
    DMH = perl(x, "^DMH"),
    DTP096 = perl(x, "^DTP\\*096"),
    DTP434 = perl(x, "^DTP\\*434"),
    DTP435 = perl(x, "^DTP\\*435"),
    DTP472 = perl(x, "^DTP\\*472"),
    DTP523 = perl(x, "^DTP\\*523"),
    FRM = perl(x, "^FRM"),
    HCP = perl(x, "^HCP"),
    HIABJ = perl(x, "^HI\\*ABJ"),
    HIABK = perl(x, "^HI\\*ABK"),
    HIBE = perl(x, "^HI\\*BE"),
    HIBF = perl(x, "^HI\\*BF"),
    HIBG = perl(x, "^HI\\*BG"),
    HIBH = perl(x, "^HI\\*BH"),
    HIBK = perl(x, "^HI\\*BK"),
    HIBN = perl(x, "^HI\\*BN"),
    HIPR = perl(x, "^HI\\*PR"),
    HL = perl(x, "^HL"),
    K3 = perl(x, "^K3"),
    LIN = perl(x, "^LIN"),
    LQ = perl(x, "^LQ"),
    LU = perl(x, "^LU"),
    LX = perl(x, "^LX"),
    MEA = perl(x, "^MEA"),
    MOA = perl(x, "^MOA"),
    N3 = perl(x, "^N3"),
    N4 = perl(x, "^N4"),
    NM140 = perl(x, "^NM1\\*40"),
    NM141 = perl(x, "^NM1\\*41"),
    NM171 = perl(x, "^NM1\\*71"),
    NM185 = perl(x, "^NM1\\*85"),
    NM1IL = perl(x, "^NM1\\*IL"),
    NM1PR = perl(x, "^NM1\\*PR"),
    NM1QC = perl(x, "^NM1\\*QC"),
    NTE = perl(x, "^NTE"),
    OI = perl(x, "^OI"),
    PAT = perl(x, "^PAT"),
    PERIC = perl(x, "^PER\\*IC"),
    PRVBI = perl(x, "^PRV\\*BI"),
    PRVAT = perl(x, "^PRV\\*AT"),
    PWK = perl(x, "^PWK"),
    QTY = perl(x, "^QTY"),
    REF1G = perl(x, "^REF\\*1G"),
    REF2U = perl(x, "^REF\\*2U"),
    REF6R = perl(x, "^REF\\*6R"),
    REF9A = perl(x, "^REF\\*9A"),
    REFD9 = perl(x, "^REF\\*D9"),
    REFEI = perl(x, "^REF\\*EI"),
    REFG2 = perl(x, "^REF\\*G2"),
    REFLU = perl(x, "^REF\\*LU"),
    REFY4 = perl(x, "^REF\\*Y4"),
    SBRP = perl(x, "^SBR\\*P\\*"),
    SBRS = perl(x, "^SBR\\*S\\*"),
    SV2 = perl(x, "^SV2"),
    SV5 = perl(x, "^SV5"),
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
    AMT = perl(x, "^AMT"),
    BHT = perl(x, "^BHT"),
    CAS = perl(x, "^CAS"),
    CLM = perl(x, "^CLM"),
    CR1 = perl(x, "^CR1"),
    CR2 = perl(x, "^CR2"),
    CR3 = perl(x, "^CR3"),
    CRC = perl(x, "^CRC"),
    CTP = perl(x, "^CTP"),
    DMG = perl(x, "^DMG"),
    DTP096 = perl(x, "^DTP\\*096"),
    DTP431 = perl(x, "^DTP\\*431"),
    DTP434 = perl(x, "^DTP\\*434"),
    DTP439 = perl(x, "^DTP\\*439"),
    DTP435 = perl(x, "^DTP\\*435"),
    DTP453 = perl(x, "^DTP\\*453"),
    DTP454 = perl(x, "^DTP\\*454"),
    DTP455 = perl(x, "^DTP\\*455"),
    DTP461 = perl(x, "^DTP\\*461"),
    DTP463 = perl(x, "^DTP\\*463"),
    DTP472 = perl(x, "^DTP\\*472"),
    DTP523 = perl(x, "^DTP\\*523"),
    DTP573 = perl(x, "^DTP\\*573"),
    DTP607 = perl(x, "^DTP\\*607"),
    FRM = perl(x, "^FRM"),
    HCP = perl(x, "^HCP"),
    HIABK = perl(x, "^HI\\*ABK"),
    HIBK = perl(x, "^HI\\*BK"),
    HL = perl(x, "^HL"),
    LIN = perl(x, "^LIN"),
    LQ = perl(x, "^LQ"),
    LX = perl(x, "^LX"),
    MEA = perl(x, "^MEA"),
    N3 = perl(x, "^N3"),
    N4 = perl(x, "^N4"),
    NM140 = perl(x, "^NM1\\*40"),
    NM141 = perl(x, "^NM1\\*41"),
    NM145 = perl(x, "^NM1\\*45"),
    NM171 = perl(x, "^NM1\\*71"),
    NM177 = perl(x, "^NM1\\*77"),
    NM182 = perl(x, "^NM1\\*82"),
    NM185 = perl(x, "^NM1\\*85"),
    NM187 = perl(x, "^NM1\\*87"),
    NM1DK = perl(x, "^NM1\\*DK"),
    NM1DN = perl(x, "^NM1\\*DN"),
    NM1IL = perl(x, "^NM1\\*IL"),
    NM1PR = perl(x, "^NM1\\*PR"),
    NM1PW = perl(x, "^NM1\\*PW"),
    NM1QC = perl(x, "^NM1\\*QC"),
    NTE = perl(x, "^NTE"),
    OI = perl(x, "^OI"),
    PAT = perl(x, "^PAT"),
    PERIC = perl(x, "^PER\\*IC"),
    PRVBI = perl(x, "^PRV\\*BI"),
    PRVPE = perl(x, "^PRV\\*PE"),
    PWK = perl(x, "^PWK"),
    QTY = perl(x, "^QTY"),
    REF1G = perl(x, "^REF\\*1G"),
    REF6R = perl(x, "^REF\\*6R"),
    REF9A = perl(x, "^REF\\*9A"),
    REFD9 = perl(x, "^REF\\*D9"),
    REFEI = perl(x, "^REF\\*EI"),
    REFG2 = perl(x, "^REF\\*G2"),
    SBRP = perl(x, "^SBR\\*P\\*"),
    SBRS = perl(x, "^SBR\\*S\\*"),
    SV1 = perl(x, "^SV1"),
    SVD = perl(x, "^SVD"),
    SE = perl(x, "^SE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )
}
