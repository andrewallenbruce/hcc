#' X12-834 (X220A1) Benefit Enrollment Parser
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
#' @param x `<chr>` string of raw X12-834 text
#' @returns list
#' @examples
#' idx = purrr::map(hcc::x12_834, index_x12)
#' purrr::map(idx, parse_834)
#' @export
parse_834 <- function(x) {
  if (!S7::S7_inherits(x, X12Index)) {
    return(NA_character_)
  }

  header <- list(
    ISA = split_i(x@text, x@index$ISA),
    GS = split_i(x@text, x@index$GS),
    ST = split_i(x@text, x@index$ST),
    BGN = split_i(x@text, x@index$BGN),
    QTY = if (!is.null(x@index$QTY)) split_i(x@text, x@index$QTY) else NULL
  )

  trailer <- list(
    SE = split_i(x@text, x@index$SE),
    GE = split_i(x@text, x@index$GE),
    IEA = split_i(x@text, x@index$IEA)
  )

  list(
    Header = header,
    Trailer = trailer
  )
}

#' @noRd
index_834_x220 <- function(x) {
  list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    BGN = perl(x, "^BGN"),
    QTY = perl(x, "^QTY"),
    REF38 = perl(x, r"(^REF\*38)"),
    REF0F = perl(x, r"(^REF\*0F)"),
    REF1D = perl(x, r"(^REF\*1D)"),
    REF1L = perl(x, r"(^REF\*1L)"),
    REF17 = perl(x, r"(^REF\*17)"),
    REF23 = perl(x, r"(^REF\*23)"),
    REF3H = perl(x, r"(^REF\*3H)"),
    REF6O = perl(x, r"(^REF\*6O)"),
    REF6P = perl(x, r"(^REF\*6P)"),
    REFQ4 = perl(x, r"(^REF\*Q4)"),
    REFZZ = perl(x, r"(^REF\*ZZ)"),
    REFZX = perl(x, r"(^REF\*ZX)"),
    REFCE = perl(x, r"(^REF\*CE)"),
    REFRB = perl(x, r"(^REF\*RB)"),
    REFDX = perl(x, r"(^REF\*DX)"),
    REFF6 = perl(x, r"(^REF\*F6)"),
    REFQQ = perl(x, r"(^REF\*QQ)"),
    REFAB = perl(x, r"(^REF\*AB\*)"),
    REFABB = perl(x, r"(^REF\*ABB)"),
    REF9V = perl(x, r"(^REF\*9V)"),
    DTP007 = perl(x, r"(^DTP\*007)"),
    DTP303 = perl(x, r"(^DTP\*303)"),
    DTP348 = perl(x, r"(^DTP\*348)"),
    DTP349 = perl(x, r"(^DTP\*349)"),
    DTP351 = perl(x, r"(^DTP\*351)"),
    DTP356 = perl(x, r"(^DTP\*356)"),
    DTP357 = perl(x, r"(^DTP\*357)"),
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
}
