#' Create an EDI Parse Object
#'
#' @details
#' Methods for `edi_index`:
#' `r doclisting::methods_list("edi_parse")`
#'
#'
#' @param x raw X12 text input
#' @param ... dots
#' @returns an `<hcc::ParsedEDI>` S7 object
#' @examples
#' edi_parse(x12_EX$`837`[[1]][[1]])
#' edi_parse(x12_EX$`837`[[2]][[1]])
#' edi_parse(x12_EX$`834`[[1]])
#' edi_parse(x12_EX$`820`[[1]][[1]])
#' edi_parse(x12_EX$`820`[[2]][[1]])
#' @export
#' @name edi_parse
edi_parse := S7::new_generic("x")

S7::method(edi_parse, S7::class_any) <- function(x) {
  cli::cli_alert_warning(
    "No {.fn hcc::edi_parse} method found for {.obj_type_friendly {x}}",
    call = rlang::caller_env()
  )
  return(NA)
}

S7::method(edi_parse, Parsed820 | Parsed834 | Parsed837) <- function(x) {
  return(x)
}

S7::method(edi_parse, S7::class_list) <- function(x) {
  purrr::map(edi_index(x), edi_parse)
}

S7::method(edi_parse, S7::class_character) <- function(x) {
  edi_parse(edi_index(x))
}

S7::method(edi_parse, Index820) <- function(x) {
  i <- parse_820(x)
  Parsed820(
    Header = HeaderEDI(
      ISA = i[["header"]][["ISA"]],
      GS = i[["header"]][["GS"]],
      ST = i[["header"]][["ST"]]
    ),
    Details = i[["details"]],
    Entity = i[["entity"]],
    Trailer = TrailerEDI(
      SE = i[["trailer"]][["SE"]],
      GE = i[["trailer"]][["GE"]],
      IEA = i[["trailer"]][["IEA"]]
    )
  )
}

S7::method(edi_parse, Index834) <- function(x) {
  i <- parse_834(x)
  Parsed834(
    Header = HeaderEDI(
      ISA = i[["header"]][["ISA"]],
      GS = i[["header"]][["GS"]],
      ST = i[["header"]][["ST"]]
    ),
    Details = i[["details"]],
    Member = i[["member"]],
    Trailer = TrailerEDI(
      SE = i[["trailer"]][["SE"]],
      GE = i[["trailer"]][["GE"]],
      IEA = i[["trailer"]][["IEA"]]
    )
  )
}

S7::method(edi_parse, Index837) <- function(x) {
  i <- parse_837(x)
  Parsed837(
    Header = HeaderEDI(
      ISA = i[["header"]][["ISA"]],
      GS = i[["header"]][["GS"]],
      ST = i[["header"]][["ST"]]
    ),
    Details = i[["details"]],
    Claims = i[["claims"]],
    Trailer = TrailerEDI(
      SE = i[["trailer"]][["SE"]],
      GE = i[["trailer"]][["GE"]],
      IEA = i[["trailer"]][["IEA"]]
    )
  )
}

#' @noRd
subset_ <- function(x, i, name = FALSE) {
  x <- S7::prop(x, "Text") |>
    .subset(i) |>
    charr::str_split("\\*") |>
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
    header = subset_(x, S7::prop(x, "Header"), TRUE),
    details = subset_(x, S7::prop(x, "Details")),
    entity = purrr::map_depth(
      S7::prop(x, "Entity"),
      1L,
      \(index) {
        subset_(x, index)
      }
    ),
    trailer = subset_(x, S7::prop(x, "Trailer"), TRUE)
  )
}

#' @noRd
parse_834 <- function(x) {
  list(
    header = subset_(x, S7::prop(x, "Header"), TRUE),
    details = subset_(x, S7::prop(x, "Details")),
    member = purrr::map_depth(
      S7::prop(x, "Member"),
      1L,
      \(index) {
        subset_(x, index)
      }
    ),
    trailer = subset_(x, S7::prop(x, "Trailer"), TRUE)
  )
}

#' @noRd
parse_837 <- function(x) {
  list(
    header = subset_(x, S7::prop(x, "Header"), TRUE),
    details = subset_(x, S7::prop(x, "Details")),
    claims = purrr::map_depth(
      S7::prop(x, "Claims"),
      1L,
      \(index) {
        subset_(x, index)
      }
    ),
    trailer = subset_(x, S7::prop(x, "Trailer"), TRUE)
  )
}
