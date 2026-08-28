#' @noRd
unlist_ <- function(x, ...) {
  unlist(x, use.names = FALSE, ...)
}

#' @noRd
mult_ <- function(...) {
  collapse::fprod(c(...))
}

#' @noRd
any_ <- function(x) {
  collapse::anyv(x, TRUE)
}

#' @noRd
normalize_ <- function(x) {
  toupper(gsub("-", "", gsub(" ", "", x, fixed = TRUE), fixed = TRUE))
}

#' Is x Between a Minimum and a Maximum?
#'
#' @param x `<int>` vector of candidates
#' @param min `<int>` Minimum value (inclusive)
#' @param max `<int>` Maximum value (inclusive)
#' @returns `<lgl>` vector indicating membership
#' @examplesIf FALSE
#' in_between(5L, 10L, 15L)
#' in_between(1L, 2L, 3L)
#' in_between(0L, 5L, 10L)
#' in_between(0:15, 5L, 10L)
#' @noRd
in_between <- function(x, min, max) {
  (x - min) * (max - x) >= 0L
}
