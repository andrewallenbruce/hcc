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
#' edi_text(x12_EX)
#' @export
edi_text := S7::new_generic("x")

S7::method(edi_text, S7::class_any) <- function(x) {
  return(NA)
}

S7::method(edi_text, TextEDI) <- function(x) {
  return(x)
}

S7::method(edi_text, S7::class_list) <- function(x) {
  purrr::map(x, edi_text)
}

S7::method(edi_text, S7::class_character) <- function(x) {
  if (length(x) > 1L) {
    return(edi_text_(cheapr::paste_(x, collapse = "")))
  }
  edi_text_(x)
}

#' @noRd
edi_text_ <- function(x) {
  text <- charr::str_squish(x) |>
    charr::str_split_1("~") |>
    set_zchar() |>
    collapse::na_rm() |>
    charr::str_replace_all(";", "*")

  ST03 <- charr::str_unique(
    charr::str_sub(
      charr::str_split_i(
        charr::str_subset(text, "^ST"),
        "[*]",
        4L
      ),
      end = 10L
    )
  )

  type <- cheapr::val_match(
    ST03,
    "005010X218" ~ "X12 820 (X218)",
    "005010X306" ~ "X12 820 (X306)",
    "005010X220" ~ "X12 834 (X220A1)",
    "005010X222" ~ "X12 837 (X222A1)",
    "005010X223" ~ "X12 837 (X223A2)",
    .default = NA_character_
  )

  switch(
    charr::str_unique(charr::str_sub(type, 5L, 7L)),
    "820" = Text820(type, text),
    "834" = Text834(type, text),
    "837" = Text837(type, text)
  )
}
