#' 2300B Remittance Detail Loop
#' 2000B Per-Member Entity Loop
#' @noRd
entity_820_218 <- function(x) {
  ent <- subset_(
    x@text,
    x@index$ENT,
    c(x@index$ENT[-1L], x@index$SE) - 1L
  )
  rmr <- subset_(x@text, x@index$RMR, x@index$DTM582)

  remits <- purrr::map(rmr, function(x) {
    rlang::list2(
      RMR = split_p(x, "^RMR"),
      DTM = split_p(x, "^DTM\\*582")
    )
  }) |>
    purrr::list_flatten()

  rlang::list2(
    ENT = split_i(x@text, x@index$ENT),
    !!!split_n(x, perl(x, "^REF")),
    NM1 = split_i(x@text, x@index$NM1),
    !!!remits,
    ADX = if (!is.null(x@index$ADX)) split_i(x@text, x@index$ADX) else NULL
  ) |>
    purrr::compact()
}

#' @noRd
entity_820_306 <- function(x) {
  ent <- subset_(
    x@text,
    x@index$ENT,
    c(x@index$ENT[-1L], x@index$SE) - 1L
  )
  rmr <- subset_(x@text, x@index$RMR, x@index$DTM582)

  remits <- purrr::map(rmr, function(x) {
    rlang::list2(
      RMR = split_p(x, "^RMR"),
      !!!split_n(x, perl(x, "^REF")),
      DTM = split_p(x, "^DTM\\*582")
    )
  }) |>
    purrr::list_flatten()

  rlang::list2(
    ENT = split_i(x@text, x@index$ENT),
    NM1 = split_i(x@text, x@index$NM1),
    !!!remits,
    ADX = if (!is.null(x@index$ADX)) split_i(x@text, x@index$ADX) else NULL
  ) |>
    purrr::compact()
}

#' 1000A Payee Name Loop
#' 1000B Payer Name Loop
#' @noRd
payee_loop_820 <- function(x) {
  PR <- x@index$N1PR
  PE <- x@index$N1PE
  c(
    split_n(x@text, seq.int(PE, PR - 1L)),
    split_n(x@text, seq.int(PR, collapse::fmin(x@index$ENT) - 1L))
  )
}

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
#' @param x `<chr>` string of raw X12-820 text
#' @returns list
#' @examples
#' # idx = purrr::map(hcc::x12_820, index_x12)
#' # purrr::map(idx, parse_820)
#' @export
parse_820 <- function(x) {
  if (!S7::S7_inherits(x, X12Index)) {
    return(NA_character_)
  }

  header <- list(
    ISA = split_i(x@text, x@index$ISA),
    GS = split_i(x@text, x@index$GS),
    ST = split_i(x@text, x@index$ST),
    BPR = split_i(x@text, x@index$BPR),
    TRN = split_i(x@text, x@index$TRN),
    REF = split_i(x@text, x@index$TRN + 1L)
  )

  trailer <- list(
    SE = split_i(x@text, x@index$SE),
    GE = split_i(x@text, x@index$GE),
    IEA = split_i(x@text, x@index$IEA)
  )

  payee <- payer <- NULL

  if (x@type == "820-X218") {
    payee <- split_n(x@text, seq.int(x@index$N1PE, x@index$N1PR - 1L))
    payer <- split_n(
      x@text,
      seq.int(x@index$N1PR, collapse::fmin(x@index$ENT) - 1L)
    )
  }

  ent_idx <- subset_(
    x@text,
    x@index$ENT,
    c(x@index$ENT[-1L], x@index$SE) - 1L
  )

  # entity <- entity_loop_820(ent_idx)

  list(
    Header = header,
    Payee = payee,
    Payer = payer,
    # Entity = entity,
    Trailer = trailer
  ) |>
    purrr::compact()
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
    REF14 = perl(x, r"(REF\*14)"),
    N1PE = perl(x, r"(N1\*PE)"),
    N3PE = perl(x, r"(N1\*PE)") + 1L,
    N4PE = perl(x, r"(N1\*PE)") + 2L,
    N1PR = perl(x, r"(N1\*PR)"),
    N3PR = perl(x, r"(N1\*PR)") + 1L,
    N4PR = perl(x, r"(N1\*PR)") + 2L,
    PERIC = perl(x, r"(PER\*IC)"),
    ENT = perl(x, "^ENT"),
    NM1 = perl(x, r"(NM1\*(DO|EY|IL|QE))"),
    RMR = perl(x, "^RMR"),
    REF18 = perl(x, r"(^REF\*18)"),
    REF38 = perl(x, r"(REF\*38)"),
    REFTV = perl(x, r"(REF\*TV)"),
    REF1L = perl(x, r"(REF\*1L)"),
    REFABY = perl(x, r"(REF\*ABY)"),
    REFZZ = perl(x, r"(^REF\*ZZ)"),
    DTM582 = perl(x, r"(^DTM\*582)"),
    DTM009 = perl(x, r"(^DTM\*009)"),
    DTM035 = perl(x, r"(^DTM\*035)"),
    DTMAAG = perl(x, r"(^DTM\*AAG)"),
    DTM097 = perl(x, r"(^DTM\*097)"),
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
    REFTV = perl(x, r"(REF\*TV)"),
    REF18 = perl(x, r"(^REF\*18)"),
    REFZZ = perl(x, r"(REF\*ZZ)"),
    N1PE = perl(x, r"(N1\*PE)"),
    REFABY = perl(x, r"(REF\*ABY)"),
    N1RM = perl(x, r"(N1\*RM)"),
    PERIC = perl(x, r"(PER\*IC)"),
    ENT = perl(x, "^ENT"),
    NM1 = perl(x, "^NM1"),
    REF38 = perl(x, r"(REF\*38)"),
    REFPOL = perl(x, r"(REF\*POL)"),
    REF1L = perl(x, r"(REF\*1L)"),
    REFAZ = perl(x, r"(REF\*AZ)"),
    REF4A = perl(x, r"(REF\*4A)"),
    REF23 = perl(x, r"(REF\*23)"),
    REF60 = perl(x, r"(REF\*60)"),
    REF1W = perl(x, r"(REF\*1W)"),
    REF0F = perl(x, r"(REF\*0F)"),
    RMR = perl(x, "^RMR"),
    DTM582 = perl(x, r"(^DTM\*582)"),
    REF0N = perl(x, r"(REF\*0N)"),
    SE = perl(x, "^SE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )
}
