#' Create an EDI Index Object
#'
#' @param x raw X12 text input
#' @param ... dots
#' @returns an `<hcc::IndexEDI>` S7 object
#' @examples
#' edi_index(x12_EX$`820`$`218`)
#' @export
#' @name edi_index
edi_index := S7::new_generic("x")

S7::method(edi_index, S7::class_any) <- function(x) {
  return(NA)
}

S7::method(edi_index, IndexEDI) <- function(x) {
  return(x)
}

S7::method(edi_index, S7::class_list) <- function(x) {
  purrr::map(edi_text(x), edi_index)
}

S7::method(edi_index, S7::class_character) <- function(x) {
  edi_index(edi_text(x))
}

S7::method(edi_index, Text820) <- function(x) {
  new_index(
    x,
    switch(
      x@type,
      "820-X306" = ind_820_306(x@text),
      "820-X218" = i820_218(x@text)
    )
  )
}

S7::method(edi_index, Text834) <- function(x) {
  new_index(x, ind_834(x@text))
}

S7::method(edi_index, Text837) <- function(x) {
  new_index(
    x,
    switch(
      x@type,
      "837I-X223" = ind_837I(x@text),
      "837P-X222" = ind_837P(x@text)
    )
  )
}

#' @noRd
new_index <- function(x, index) {
  IndexEDI(
    type = x@type,
    text = x@text,
    problems = problems(x@text, index),
    index = index
  )
}

#' @noRd
problems <- function(x, i) {
  if (length(x) != cheapr::unlisted_length(i)) {
    cheapr::setdiff_(seq_along(x), unlist_(i))
  } else {
    NA_integer_
  }
}
