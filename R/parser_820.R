#' X12-820 (X306/X218) Payment Order/Remittance Advice Parser
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
#'    - `REF*18`: Rate code (e.g., `957` = PACE rate)
#'    - `REF*ZZ`: Aid code/plan type composite and description
#'    - `DTM*582`: Coverage period date range
#'    - `ADX`: Adjustment amount and reason code
#'
#' Typical loop structure within an `820-X218`:
#'    - Header: `ISA` > `GS` > `ST` > `BPR` > `TRN` > `N1*PE` > `N1*PR`
#'    - Per-member: `ENT` > `NM1` > (`RMR` > `REF*18` > `REF*ZZ` > `REF*ZZ` > `DTM*582` > `ADX`)
#'    - Trailer: `SE` > `GE` > `IEA`
#'
#' @param x `<chr>` string of raw X12-820 text
#' @returns list
#' @examples
#' idx = purrr::map(hcc::x12_820, index_x12)
#' purrr::map(idx[c(10:11, 16L)], parse_820)
#' @export
parse_820 <- function(x) {
  if (!S7::S7_inherits(x, X12Index)) {
    return(NA_character_)
  }
  purrr::compact(
    switch(
      x@type,
      "820-X306" = parse_820_306(x),
      "820-X218" = parse_820_218(x)
    )
  )
}

#' @noRd
parse_TRAILER <- function(x) {
  list(
    SE = split_1(S7::prop(x, "text"), .subset2(S7::prop(x, "index"), "SE")),
    GE = split_1(S7::prop(x, "text"), .subset2(S7::prop(x, "index"), "GE")),
    IEA = split_1(S7::prop(x, "text"), .subset2(S7::prop(x, "index"), "IEA"))
  )
}

#' @noRd
parse_820_ENT <- function(x) {
  ent <- .subset2(S7::prop(x, "index"), "ENT")
  purrr::map(
    fill_sequence(
      ent,
      c(.subset(ent, -1L), .subset2(S7::prop(x, "index"), "SE")) - 1L
    ),
    function(idx) {
      strsplit(.subset(S7::prop(x, "text"), idx), "*", fixed = TRUE)
    }
  ) |>
    rlang::set_names(
      ~ cheapr::paste_(
        "ENT_",
        seq_along(.)
      )
    ) |>
    purrr::list_flatten() |>
    purrr::map(set_zchar)
}

#' @noRd
parse_820_218 <- function(x) {
  header <- list(
    ISA = split_1(x@text, x@index$ISA),
    GS = split_1(x@text, x@index$GS),
    ST = split_1(x@text, x@index$ST),
    BPR = split_1(x@text, x@index$BPR),
    TRN = split_1(x@text, x@index$TRN),
    REF14 = split_1(x@text, x@index$REF14)
  )

  payee <- list(
    N1PE = split_1(x@text, x@index$N1PE),
    N3PE = split_1(x@text, x@index$N3PE),
    N4PE = split_1(x@text, x@index$N4PE)
  )
  payer <- list(
    N1PR = split_1(x@text, x@index$N1PR),
    N3PR = split_1(x@text, x@index$N3PR),
    N4PR = split_1(x@text, x@index$N4PR)
  )

  entity <- parse_820_ENT(x)
  trailer <- parse_TRAILER(x)

  c(header, payee, payer, entity, trailer)
}

#' @noRd
parse_820_306 <- function(x) {
  header <- list(
    ISA = split_1(x@text, x@index$ISA),
    GS = split_1(x@text, x@index$GS),
    ST = split_1(x@text, x@index$ST),
    BPR = split_1(x@text, x@index$BPR),
    N1PE = split_1(x@text, x@index$N1PE),
    N1RM = split_1(x@text, x@index$N1RM),
    PERIC = split_1(x@text, x@index$PERIC)
  )

  entity <- parse_820_ENT(x)
  trailer <- parse_TRAILER(x)

  c(header, entity, trailer)
}

# ST-01 = 820
# ST-03 = 005010X218
# GS-08 = 005010X218
# https://portal.stedi.com/app/guides/view/hipaa/payroll-deducted-and-other-group-premium-payment-for-insurance-products-examples-x218/01GRYB6CPB1S1257NJJP6K497B
#' @noRd
index_820_x218 <- function(x) {
  list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    BPR = perl(x, "^BPR"),
    TRN = perl(x, "^TRN"),
    CUR = perl(x, "^CUR"),
    REF14 = perl(x, "^REF\\*14"),
    N1PE = perl(x, "^N1\\*PE"),
    N3PE = perl(x, "^N1\\*PE") + 1L,
    N4PE = perl(x, "^N1\\*PE") + 2L,
    N1PR = perl(x, "^N1\\*PR"),
    N3PR = perl(x, "^N1\\*PR") + 1L,
    N4PR = perl(x, "^N1\\*PR") + 2L,
    PERIC = perl(x, "^PER\\*IC"),
    ENT = perl(x, "^ENT"),
    NM1 = perl(x, "^NM1\\*(DO|EY|IL|QE)"),
    RMR = perl(x, "^RMR"),
    REF18 = perl(x, "^REF\\*18"),
    REF38 = perl(x, "^REF\\*38"),
    REFTV = perl(x, "^REF\\*TV"),
    REF1L = perl(x, "^REF\\*1L"),
    REFABY = perl(x, "^REF\\*ABY"),
    REFZZ = perl(x, "^REF\\*ZZ"),
    DTM582 = perl(x, "^DTM\\*582"),
    DTM009 = perl(x, "^DTM\\*009"),
    DTM035 = perl(x, "^DTM\\*035"),
    DTMAAG = perl(x, "^DTM\\*AAG"),
    DTM097 = perl(x, "^DTM\\*097"),
    ADX = perl(x, "^ADX"),
    SE = perl(x, "^SE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )
}

# ST-01 = 820
# ST-03 = 005010X306
# GS-08 = 005010X306
# https://portal.stedi.com/app/guides/view/hipaa/health-insurance-exchange-related-payments-x306/01HQ4HZB22GES43ZEA8H62Y77C
#' @noRd
index_820_x306 <- function(x) {
  list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    BPR = perl(x, "^BPR"),
    TRN = perl(x, "^TRN"),
    REFTV = perl(x, "^REF\\*TV"),
    REF18 = perl(x, "^REF\\*18"),
    REFZZ = perl(x, "^REF\\*ZZ"),
    N1PE = perl(x, "^N1\\*PE"),
    REFABY = perl(x, "^REF\\*ABY"),
    N1RM = perl(x, "^N1\\*RM"),
    PERIC = perl(x, "^PER\\*IC"),
    ENT = perl(x, "^ENT"),
    NM1 = perl(x, "^NM1"),
    REF38 = perl(x, "^REF\\*38"),
    REFPOL = perl(x, "^REF\\*POL"),
    REF1L = perl(x, "^REF\\*1L"),
    REFAZ = perl(x, "^REF\\*AZ"),
    REF4A = perl(x, "^REF\\*4A"),
    REF23 = perl(x, "^REF\\*23"),
    REF60 = perl(x, "^REF\\*60"),
    REF1W = perl(x, "^REF\\*1W"),
    REF0F = perl(x, "^REF\\*0F"),
    RMR = perl(x, "^RMR"),
    DTM582 = perl(x, "^DTM\\*582"),
    REF0N = perl(x, "^REF\\*0N"),
    SE = perl(x, "^SE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )
}
