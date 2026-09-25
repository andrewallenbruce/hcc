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
    BGN = split_7(x, "BGN")
  )

  middle <- parse_834_MID(x)
  entity <- parse_834_INS(x)
  trailer <- parse_TRAILER(x)

  purrr::compact(c(header, middle, entity, trailer))
}

#' @noRd
parse_834_MID <- function(x) {
  middle <- purrr::map(
    fill_sequence(
      x@index$BGN + 1L,
      collapse::fmax(x@index$N1)
    ),
    function(idx) {
      strsplit(.subset(x@text, idx), "*", fixed = TRUE)
    }
  ) |>
    purrr::list_flatten() |>
    purrr::map(set_zchar)

  rlang::set_names(
    middle,
    purrr::map_chr(middle, \(x) paste0(x[1], x[2]))
  )
}

#' @noRd
parse_834_INS <- function(x) {
  ins <- .subset2(S7::prop(x, "index"), "INS")
  purrr::map(
    fill_sequence(
      ins,
      c(.subset(ins, -1L), .subset2(S7::prop(x, "index"), "SE")) - 1L
    ),
    function(idx) {
      strsplit(.subset(S7::prop(x, "text"), idx), "[;*]", perl = TRUE)
      # strsplit(.subset(S7::prop(x, "text"), idx), "*", fixed = TRUE)
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
index_834_x220 <- function(x) {
  list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    BGN = perl(x, "^BGN"),
    QTY = perl(x, "^QTY"),
    REF38 = perl(x, "^REF\\*38"),
    REF0F = perl(x, "^REF\\*0F"),
    REF1D = perl(x, "^REF\\*1D"),
    REF1L = perl(x, "^REF\\*1L"),
    REF17 = perl(x, "^REF\\*17"),
    REF23 = perl(x, "^REF\\*23"),
    REF3H = perl(x, "^REF\\*3H"),
    REF6O = perl(x, "^REF\\*6O"),
    REF6P = perl(x, "^REF\\*6P"),
    REFQ4 = perl(x, "^REF\\*Q4"),
    REFZZ = perl(x, "^REF\\*ZZ"),
    REFZX = perl(x, "^REF\\*ZX"),
    REFCE = perl(x, "^REF\\*CE"),
    REFRB = perl(x, "^REF\\*RB"),
    REFDX = perl(x, "^REF\\*DX"),
    REFF6 = perl(x, "^REF\\*F6"),
    REFQQ = perl(x, "^REF\\*QQ"),
    REFAB = perl(x, "^REF\\*AB\\*"),
    REFABB = perl(x, "^REF\\*ABB\\*"),
    REF9V = perl(x, "^REF\\*9V"),
    DTP007 = perl(x, "^DTP\\*007"),
    DTP303 = perl(x, "^DTP\\*303"),
    DTP348 = perl(x, "^DTP\\*348"),
    DTP349 = perl(x, "^DTP\\*349"),
    DTP351 = perl(x, "^DTP\\*351"),
    DTP356 = perl(x, "^DTP\\*356"),
    DTP357 = perl(x, "^DTP\\*357"),
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
