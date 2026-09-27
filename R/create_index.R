#' Create X12 Indices
#'
#' @param x an `<hcc::Text8XX>` S7 object
#' @param ... dots
#' @returns an `<hcc::X12Index>` S7 object
#' @examples
#' c(x12_820[1],
#'   x12_834[1],
#'   x12_837I[1],
#'   x12_837P[1]
#' ) |>
#'   x12_type() |>
#'   create_index()
#' @export
#' @name create_index
create_index := S7::new_generic("x")

S7::method(create_index, S7::class_any) <- function(x) {
  return(NA)
}

S7::method(create_index, S7::class_list) <- function(x) {
  purrr::map(x, create_index)
}

S7::method(create_index, Text820) <- function(x) {
  i <- sort_index(
    switch(
      x@type,
      "820-X306" = index_820_306(x@text),
      "820-X218" = index_820_218(x@text)
    )
  )
  new_index(x, i)
}

S7::method(create_index, Text834) <- function(x) {
  i <- sort_index(index_834_220(x@text))
  new_index(x, i)
}

S7::method(create_index, Text837) <- function(x) {
  i <- sort_index(
    switch(
      x@type,
      "837I-X223" = index_837I_223(x@text),
      "837P-X222" = index_837P_222(x@text)
    )
  )

  new_index(x, i)
}

#' @noRd
sort_index <- function(i) {
  i <- cheapr::sset(i, whichv_(collapse::vlengths(i, FALSE), 0L, TRUE))
  i[names(sort.int(purrr::map_int(i, \(x) x[1])))]
}

#' @noRd
parsing_problems <- function(x, i) {
  if (length(x) != cheapr::unlisted_length(i)) {
    cheapr::setdiff_(seq_along(x), unlist_(i))
  } else {
    NA_integer_
  }
}

#' @noRd
new_index <- function(x, i) {
  X12Index(
    type = x@type,
    text = x@text,
    segments = cheapr::unlisted_length(i),
    problems = parsing_problems(x@text, i),
    index = i
  )
}

#' @noRd
x12_subtype <- function(x) {
  cheapr::val_match(
    x,
    "005010X218" ~ "820-X218",
    "005010X306" ~ "820-X306",
    "005010X220A1" ~ "834-X220",
    "005010X222A1" ~ "837P-X222",
    "005010X223A2" ~ "837I-X223",
    .default = NA_character_
  )
}

#' @noRd
x12_type_ <- function(x) {
  text <- input_(x)

  text <- strsplit(text, "~", fixed = TRUE) |>
    .subset2(1L)

  x <- .subset(text, perl(text, "^ST")) |>
    strsplit("*", fixed = TRUE) |>
    .subset2(1L) |>
    .subset(-1L)

  type <- x12_subtype(.subset(x, length(x)))

  switch(
    substr(type, 1L, 3L),
    "820" = Text820(type, text),
    "834" = Text834(type, text),
    "837" = Text837(type, text)
  )
}

#' X12 Type Class
#'
#' @param x description
#' @export
x12_type <- function(x) {
  if (length(x) == 1L) {
    return(x12_type_(x))
  }
  purrr::map(x, x12_type_)
}
