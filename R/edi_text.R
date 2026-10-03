#' Create an EDI Text Object
#'
#' @details
#' Methods for `edi_index`:
#' `r doclisting::methods_list("edi_text")`
#'
#'
#' @param x raw X12 text input
#' @param ... dots
#' @returns an `<hcc::TextEDI>` S7 object
#' @examples
#' edi_text(x12_EX$`820`$`218`)
#' edi_text(x12_EX$`820`$`306`)
#' @export
edi_text := S7::new_generic("x")

S7::method(edi_text, S7::class_any) <- function(x) {
  return(NA)
}

S7::method(edi_text, TextEDI) <- function(x) {
  return(x)
}

S7::method(edi_text, S7::class_list) <- function(x) {
  purrr::map(x, \(i) edi_text_(cheapr::paste_(i, collapse = "")))
}

S7::method(edi_text, S7::class_character) <- function(x) {
  if (length(x) > 1L) {
    return(edi_text_(cheapr::paste_(x, collapse = "")))
  }
  edi_text_(x)
}

#' @noRd
edi_text_ <- function(x) {
  text <- trimws(x) |>
    strsplit("~", fixed = TRUE) |>
    .subset2(1L)

  x <- .subset(text, perl(text, "^ST")) |>
    strsplit("*", fixed = TRUE) |>
    .subset2(1L) |>
    .subset(-1L)

  type <- cheapr::val_match(
    substr(.subset(x, length(x)), 1L, 10L),
    "005010X218" ~ "820-X218",
    "005010X306" ~ "820-X306",
    "005010X220" ~ "834-X220",
    "005010X222" ~ "837P-X222",
    "005010X223" ~ "837I-X223",
    .default = NA_character_
  )

  switch(
    substr(type, 1L, 3L),
    "820" = Text820(type, text),
    "834" = Text834(type, text),
    "837" = Text837(type, text)
  )
}
