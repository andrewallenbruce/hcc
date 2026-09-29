#' Create X12 Indices
#'
#' @param x raw X12 text input
#' @param ... dots
#' @returns an `<hcc::IndexX12>` S7 object
#' @examples
#' create_index(x12_EX$`820`$`306`)
#' @export
#' @name create_index
create_index := S7::new_generic("x")

S7::method(create_index, S7::class_any) <- function(x) {
  NA
}

S7::method(create_index, IndexX12) <- function(x) {
  x
}

S7::method(create_index, S7::class_list) <- function(x) {
  purrr::map(x12_type(x), create_index)
}

S7::method(create_index, S7::class_character) <- function(x) {
  create_index(x12_type(x))
}

S7::method(create_index, Text820) <- function(x) {
  new_index(
    x,
    switch(
      x@type,
      "820-X306" = ind_820_306(x@text),
      "820-X218" = ind_820_218(x@text)
    )
  )
}

S7::method(create_index, Text834) <- function(x) {
  new_index(x, ind_834(x@text))
}

S7::method(create_index, Text837) <- function(x) {
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
sort_index <- function(i) {
  i <- cheapr::sset(i, whichv_(collapse::vlengths(i, FALSE), 0L, TRUE))
  i[names(sort.int(purrr::map_int(i, \(x) .subset(x, 1L))))]
}

#' @noRd
problems <- function(x, i) {
  if (length(x) != cheapr::unlisted_length(i)) {
    cheapr::setdiff_(seq_along(x), unlist_(i))
  } else {
    NA_integer_
  }
}

#' @noRd
new_index <- function(x, index) {
  index <- sort_index(index)
  IndexX12(
    type = x@type,
    text = x@text,
    problems = problems(x@text, index),
    index = index
  )
}

#' @noRd
x12_type_ <- function(x) {
  text <- strsplit(x, "~", fixed = TRUE) |>
    .subset2(1L)

  x <- .subset(text, perl(text, "^ST")) |>
    strsplit("*", fixed = TRUE) |>
    .subset2(1L) |>
    .subset(-1L)

  type <- cheapr::val_match(
    .subset(x, length(x)),
    "005010X218" ~ "820-X218",
    "005010X306" ~ "820-X306",
    "005010X220A1" ~ "834-X220",
    "005010X222A1" ~ "837P-X222",
    "005010X223A2" ~ "837I-X223",
    .default = NA_character_
  )

  switch(
    substr(type, 1L, 3L),
    "820" = Text820(type, text),
    "834" = Text834(type, text),
    "837" = Text837(type, text)
  )
}

#' @noRd
x12_type <- function(x) {
  if (rlang::is_scalar_character(x)) {
    return(x12_type_(x))
  }
  if (rlang::is_character(x)) {
    return(x12_type_(cheapr::paste_(x, collapse = "")))
  }
  if (rlang::is_bare_list(x)) {
    return(purrr::map(x, \(i) x12_type_(cheapr::paste_(i, collapse = ""))))
  }
  cli::cli_abort("Unknown X12 Type", call = rlang::caller_env())
}
