#' @noRd
tails_ <- function(x, d = 1L) {
  purrr::map_depth(x, d, function(i) {
    S7::prop(i, "Details")
  })
}

#' Create an EDI Parse Object
#'
#' @details
#' Methods for `edi_parse`:
#' `r doclisting::methods_list("edi_parse")`
#'
#' @param x raw X12 text input
#' @param ... dots
#' @returns an `<hcc::ParsedEDI>` S7 object
#' @examples
#' edi_parse(x12_EX$`820`) |> hcc:::tails_(2L)
#' edi_parse(x12_EX$`834`) |> hcc:::tails_()
#' edi_parse(x12_EX$`837`$I223) |> hcc:::tails_()
#' edi_parse(x12_EX$`837`$P222[c(1:15, 17)]) |> hcc:::tails_()
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
      S7::prop(x, "Type"),
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
    Details = detail_834(x),
    Member = S7::prop(x, "Member") |>
      purrr::map_depth(1L, \(id) subset_(x, id)),
    Trailer = edi_trailer(x)
  )
}

S7::method(edi_parse, Index837) <- function(x) {
  Parsed837(
    Header = edi_header(x),
    Details = detail_837(x),
    Claims = S7::prop(x, "Claims") |>
      purrr::map_depth(1L, \(id) subset_(x, id)),
    Trailer = edi_trailer(x)
  )
}
