#' Create an EDI Parse Object
#'
#' @details
#' Methods for `edi_parse`:
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
#' edi_parse(x12_EX$`820`$`306`) |>
#' purrr::map_depth(1L, \(x) S7::prop(x, "Details"))
#' edi_parse(x12_EX$`820`$`218`) |>
#' purrr::map_depth(1L, \(x) S7::prop(x, "Details"))
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
  Parsed820(
    Header = edi_header(x),
    Details = switch(
      x@Type,
      "X12 820 (X218)" = detail_218(x),
      "X12 820 (X306)" = detail_306(x)
    ),
    Entity = S7::prop(x, "Entity") |>
      purrr::map_depth(2L, \(id) subset_(x, id)),
    Trailer = edi_trailer(x)
  )
}

S7::method(edi_parse, Index834) <- function(x) {
  Parsed834(
    Header = edi_header(x),
    Details = as_detail834(x),
    Member = purrr::map_depth(
      S7::prop(x, "Member"),
      1L,
      \(index) {
        subset_(x, index)
      }
    ),
    Trailer = edi_trailer(x)
  )
}

S7::method(edi_parse, Index837) <- function(x) {
  Parsed837(
    Header = edi_header(x),
    Details = subset_(x, S7::prop(x, "Details")),
    Claims = purrr::map_depth(
      S7::prop(x, "Claims"),
      1L,
      \(index) {
        subset_(x, index)
      }
    ),
    Trailer = edi_trailer(x)
  )
}
