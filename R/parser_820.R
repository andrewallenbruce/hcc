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
#' @returns list of `<hcc::X12_820_218>` S7 objects
#' @examples
#' purrr::map(edi_index(hcc::x12_EX$`820`$`218`[5:7]), hcc:::parse_218) |>
#' str(list.len = 10L)
#' @export
parse_820 <- function(x) {
  if (!S7::S7_inherits(x, IndexEDI) | !S7::S7_inherits(x, Index820)) {
    return(NA_character_)
  }

  switch(
    x@type,
    "820-X306" = parse_820_306(x),
    "820-X218" = parse_218(x)
  )
}

#' @noRd
subsplit <- function(x, i) {
  x <- stringfish::sf_split(
    .subset(x, i),
    "*",
    fixed = TRUE,
    nthreads = 4L
  ) |>
    purrr::map(\(x) set_zchar(trimws(x)))

  rlang::set_names(
    purrr::map(x, .subset, -1L),
    purrr::map(x, 1L)
  )
}

#' @noRd
subsplit2 <- function(x, i) {
  stringfish::sf_split(
    .subset(x, i),
    "*",
    fixed = TRUE,
    nthreads = 4L
  ) |>
    purrr::map(\(x) set_zchar(trimws(x)))
}

#' @noRd
parse_218 <- function(x) {
  list(
    header = subsplit(x@text, x@header),
    details = subsplit(x@text, x@details),
    entity = purrr::map(x@entity, \(index) {
      purrr::map(index, \(i) subsplit(x@text, i))
    }),
    trailer = subsplit(x@text, x@trailer)
  )
}

#' @noRd
parse_820_ENT <- function(x) {
  en <- .subset2(x@index, "ENT")
  ix <- fill_(
    en,
    c(.subset(en, -1L), .subset2(x@index, "SE")) - 1L,
    as_list = TRUE
  )

  ent <- purrr::map(ix, \(i) {
    x <- .subset(x@text, i) |>
      strsplit("[*;]", perl = TRUE)

    # x[[1]] <- x[[1]][-1]

    purrr::map(x, \(e) collapse::na_rm(set_zchar(e)))
  })

  rlang::set_names(ent, seq_along(ent)) |>
    vctrs::vec_c(.name_spec = "{outer}.{inner}")
}

#' @noRd
parse_820_306 <- function(x) {
  header <- list(
    ISA = split_7(x, "ISA"),
    GS = split_7(x, "GS"),
    ST = split_7(x, "ST"),
    BPR = split_7(x, "BPR"),
    N1PE = split_7(x, "N1PE"),
    N1RM = split_7(x, "N1RM"),
    PERIC = split_7(x, "PERIC")
  )

  entity <- parse_820_ENT(x)
  trailer <- parse_TRAILER(x)

  c(header, entity, trailer)
}
