#' Create an EDI Index Object
#'
#' @details
#' Methods for `edi_index`:
#' `r doclisting::methods_list("edi_index")`
#'
#'
#' @param x raw X12 text input
#' @param ... dots
#' @returns an `<hcc::IndexEDI>` S7 object
#' @examples
#' edi_index(x12_EX$`820`$`218`[1:5])
#' edi_index(x12_EX$`820`$`306`[1:5])
#' edi_index(x12_EX$`834`)
#' edi_index(x12_EX$`837`)
#' @export
#' @name edi_index
edi_index := S7::new_generic("x")

S7::method(edi_index, S7::class_any) <- function(x) {
  cli::cli_alert_warning(
    "No {.fn hcc::edi_index} method found for {.obj_type_friendly {x}}",
    call = rlang::caller_env()
  )
  return(NA)
}

S7::method(edi_index, Index820 | Index834 | Index837) <- function(x) {
  return(x)
}

S7::method(edi_index, S7::class_list) <- function(x) {
  purrr::map(edi_text(x), edi_index)
}

S7::method(edi_index, S7::class_character) <- function(x) {
  edi_index(edi_text(x))
}

S7::method(edi_index, Text820) <- function(x) {
  i <- index_820(S7::prop(x, "Text"))
  S7::convert(
    x,
    Index820,
    Problems = problems(x, i),
    Header = i[["header"]],
    Details = i[["details"]],
    Entity = i[["entity"]],
    Trailer = i[["trailer"]]
  )
}

S7::method(edi_index, Text834) <- function(x) {
  i <- index_834(S7::prop(x, "Text"))
  S7::convert(
    x,
    Index834,
    Problems = problems(x, i),
    Header = i[["header"]],
    Details = i[["details"]],
    Member = i[["member"]],
    Trailer = i[["trailer"]]
  )
}

S7::method(edi_index, Text837) <- function(x) {
  i <- index_837(S7::prop(x, "Text"))
  S7::convert(
    x,
    Index837,
    Problems = problems(x, i),
    Header = i[["header"]],
    Details = i[["details"]],
    Claims = i[["claims"]],
    Trailer = i[["trailer"]]
  )
}
