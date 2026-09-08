#' @noRd
unlist_df <- function(x) {
  collapse::unlist2d(x, idcols = "id") |>
    collapse::rnm(
      "id.1" = "SEG",
      "id.2" = "PT",
      "V1" = "VALUE"
    )
}

#' @noRd
fill_range <- function(start, end) {
  purrr::map2(start, end, function(a, b) seq.int(from = a, to = b))
}

#' @noRd
subset_sequences <- function(text, start, end) {
  fill_range(start, end) |>
    purrr::map(\(i) .subset(text, i))
}

#' @noRd
name_loop <- function(x) {
  rlang::set_names(x, ~ paste0("L", seq_along(.)))
}

#' @noRd
set_zchar <- function(x) {
  collapse::setv(x, !nzchar(x), NA_character_)
  x
}

#' @noRd
pad_names <- function(x) {
  N <- as.character(seq_along(x))
  i <- collapse::whichv(nchar(N), 1L)
  collapse::setv(N, i, cheapr::paste_("0", N[i]))
  rlang::set_names(as.list(x), N)
}

#' @noRd
post_split <- function(x) {
  pad_names(set_zchar(trimws(x)))
}

#' @noRd
tilde <- function(x) {
  strsplit(x, "~", fixed = TRUE)[[1]]
}

#' @noRd
star <- function(x, i) {
  strsplit(.subset(x, i), "*", fixed = TRUE)
}

#' @noRd
split_i <- function(x, i) {
  star(x, i)[[1]][-1] |>
    post_split()
}

#' @noRd
split_p <- function(x, p) {
  split_i(x, perl(x, p))
}

#' @noRd
split_n <- function(x, i) {
  x <- star(x, i)
  purrr::map(x, \(x) post_split(x[-1])) |>
    rlang::set_names(purrr::map_chr(x, 1L))
}

#' @noRd
x12_837_subtype <- function(x) {
  cheapr::val_match(
    x,
    "005010X222A1" ~ "837P",
    "005010X223A2" ~ "837I",
    "005010X224A2" ~ "837D",
    .default = x
  )
}

#' @examplesIf FALSE
#' x12_type(c(x12_820, x12_834, x12_837))
#' @noRd
x12_type <- function(x) {
  x <- strsplit(unlist_(x), "~", fixed = TRUE)
  x <- strsplit(unlist_elem(x, 3L), "*", fixed = TRUE)
  x <- list(ST01 = unlist_elem(x, 2L), ST03 = unlist_elem(x, 4L))

  if (collapse::anyv(x$ST01, "837")) {
    i <- collapse::whichv(x$ST01, "837")
    x$ST01[i] <- x12_837_subtype(x$ST03[i])
  }
  x
}
