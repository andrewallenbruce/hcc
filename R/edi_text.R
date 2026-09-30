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

#' Create an EDI Text Object
#'
#' @param x raw X12 text input
#' @returns an `<hcc::TextEDI>` S7 object
#' @examples
#' edi_text(x12_EX$`837`$P222)
#' @export
edi_text <- function(x) {
  if (rlang::is_scalar_character(x)) {
    return(edi_text_(x))
  }
  if (rlang::is_character(x)) {
    return(edi_text_(cheapr::paste_(x, collapse = "")))
  }
  if (rlang::is_bare_list(x)) {
    return(purrr::map(x, \(i) edi_text_(cheapr::paste_(i, collapse = ""))))
  }
  cli::cli_abort("Unknown X12 Type", call = rlang::caller_env())
}
