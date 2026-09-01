#' @noRd
perl <- function(x, rex, negate = FALSE) {
  grep(pattern = rex, x = x, perl = TRUE, invert = negate)
}

#' @noRd
perl0 <- function(x, rex, ...) {
  grepl(pattern = rex, x = x, perl = TRUE, ...)
}

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
  toupper(
    gsub("-", "", gsub(" ", "", x, fixed = TRUE), fixed = TRUE)
  )
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

#' Is any HCC present?
#'
#' @param needles `<int>` hcc(s) being searched for
#' @param haystack `<int>` hcc(s) being searched in
#' @returns `<int>` scalar, `1` (True), `0` (False)
#' @examples
#' any_hcc(17:19, 18:21)
#' any_hcc(17:19, 20:22)
#' @export
any_hcc <- function(needles, haystack) {
  as.integer(any_(needles %in_% haystack))
}

#' Creates HCC count variables
#'
#' @param hcc hcc
#' @returns a named `<int>` vector of counts
#' @examples
#' hcc_count(17:19)
#' hcc_count(c(17:19, 85L))
#' @export
hcc_count <- function(hcc) {
  L <- length(hcc)
  rlang::check_number_whole(L, min = 1)
  if (L <= 9L) {
    return(cheapr::paste_("D", L))
  }
  if (L >= 10L) {
    return("D10P")
  }
}
