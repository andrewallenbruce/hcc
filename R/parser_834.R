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
#' purrr::map(idx[c(1L, 14L)], parse_834)
#' @export
parse_834 <- function(x) {
  if (!S7::S7_inherits(x, X12Index)) {
    return(NA_character_)
  }

  header <- list(
    ISA = split_7(x, "ISA"),
    GS = split_7(x, "GS"),
    ST = split_7(x, "ST"),
    BGN = split_7(x, "BGN"),
    REF38 = split_7(x, "REF38"),
    DTP007 = split_7(x, "DTP007"),
    QTY = split_7(x, "QTY"),
    N1P5 = split_7(x, "N1P5"),
    N1IN = split_7(x, "N1IN")
  )
  entity <- parse_834_INS(x)
  trailer <- parse_TRAILER(x)

  purrr::compact(c(header, entity, trailer))
}

#' @noRd
parse_834_INS <- function(x) {
  ins <- .subset2(x@index, "INS")
  ise <- .subset2(x@index, "SE")
  purrr::map(
    fill_(
      start = ins,
      end = c(.subset(ins, -1L), ise) - 1L,
      as_list = TRUE
    ),
    function(idx) {
      strsplit(.subset(x@text, idx), "[;*]", perl = TRUE)
    }
  ) |>
    rlang::set_names(
      ~ cheapr::paste_(
        "INS_",
        seq_along(.)
      )
    ) |>
    purrr::list_flatten() |>
    purrr::map(set_zchar)
}

#' @noRd
index_834_220 <- function(x) {
  list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    ACT = perl(x, "^ACT"),
    AMT = perl(x, "^AMT"),
    BGN = perl(x, "^BGN"),
    COB = perl(x, "^COB"),
    DMGD8 = perl(x, "^DMG\\*D8"),
    DTP007 = perl(x, "^DTP\\*007"),
    DTP303 = perl(x, "^DTP\\*303"),
    DTP348 = perl(x, "^DTP\\*348"),
    DTP349 = perl(x, "^DTP\\*349"),
    DTP351 = perl(x, "^DTP\\*351"),
    DTP356 = perl(x, "^DTP\\*356"),
    DTP357 = perl(x, "^DTP\\*357"),
    HD = perl(x, "^HD"),
    HLH = perl(x, "^HLH"),
    ICM = perl(x, "^ICM"),
    IDC = perl(x, "^IDC"),
    INS = perl(x, "^INS"),
    LUILD = perl(x, "^LUI\\*LD"),
    LX = perl(x, "^LX"),
    N1P5 = perl(x, "^N1\\*P5"),
    N1IN = perl(x, "^N1\\*IN"),
    N3 = perl(x, "^N3"),
    N4 = perl(x, "^N4"),
    NM1IL = perl(x, "^NM1\\*IL"),
    NM1M8 = perl(x, "^NM1\\*M8"),
    NM1P3 = perl(x, "^NM1\\*P3"),
    NM131 = perl(x, "^NM1\\*31"),
    NM170 = perl(x, "^NM1\\*70"),
    PERIP = perl(x, "^PER\\*IP"),
    QTY = perl(x, "^QTY"),
    REF17 = perl(x, "^REF\\*17"),
    REF23 = perl(x, "^REF\\*23"),
    REF38 = perl(x, "^REF\\*38"),
    REF0F = perl(x, "^REF\\*0F"),
    REF1D = perl(x, "^REF\\*1D"),
    REF1L = perl(x, "^REF\\*1L"),
    REF3H = perl(x, "^REF\\*3H"),
    REF6O = perl(x, "^REF\\*6O"),
    REF6P = perl(x, "^REF\\*6P"),
    REF9V = perl(x, "^REF\\*9V"),
    REFF6 = perl(x, "^REF\\*F6"),
    REFQ4 = perl(x, "^REF\\*Q4"),
    REFCE = perl(x, "^REF\\*CE"),
    REFZZ = perl(x, "^REF\\*ZZ"),
    REFZX = perl(x, "^REF\\*ZX"),
    REFRB = perl(x, "^REF\\*RB"),
    REFDX = perl(x, "^REF\\*DX"),
    REFQQ = perl(x, "^REF\\*QQ"),
    REFAB = perl(x, "^REF\\*AB\\*"),
    REFABB = perl(x, "^REF\\*ABB\\*"),
    SE = perl(x, "^SE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )
}
