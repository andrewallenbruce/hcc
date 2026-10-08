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
#' x = edi_index(c(x12_EX$`820`$`218`[1:2], x12_EX$`820`$`306`[1:2]))
#' str(edi_parse(x), list.len = 10L)
#' @export
edi_parse <- function(x) {
  if (length(x) > 1L) {
    return(purrr::map(x, parse_820))
  }
  parse_820(x)
}

#' @noRd
subsplit <- function(x, i, name = FALSE) {
  x <- stringfish::sf_split(
    .subset(x, i),
    "*",
    fixed = TRUE,
    nthreads = 4L
  ) |>
    purrr::map(\(x) set_zchar(trimws(x)))

  if (!name) {
    return(x)
  }

  rlang::set_names(
    purrr::map(x, .subset, -1L),
    purrr::map(x, 1L)
  )
}

#' @noRd
parse_820 <- function(x) {
  list(
    header = subsplit(S7::prop(x, "Text"), S7::prop(x, "Header"), TRUE),
    details = subsplit(S7::prop(x, "Text"), S7::prop(x, "Details")),
    entity = purrr::map_depth(
      S7::prop(x, "Entity"),
      1L,
      \(index) {
        subsplit(S7::prop(x, "Text"), index)
      }
    ),
    trailer = subsplit(S7::prop(x, "Text"), S7::prop(x, "Trailer"), TRUE)
  )
}
