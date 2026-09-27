#' @noRd
x12_820_subtype <- function(x) {
  paste0(x[2], "-", substr(x[length(x)], start = 7L, stop = 12L))
}

#' @noRd
x12_834_subtype <- function(x) {
  paste0(x[2], "-", substr(x[length(x)], start = 7L, stop = 10L))
}

#' x12_type_2(c(x12_820, x12_834, x12_837I, x12_837P))
#' @noRd
x12_type_2 <- function(x) {
  x <- purrr::map(x, \(x) paste0(unlist_(rm_newline(x)), collapse = ""))
  x <- strsplit(unlist(x), "~", fixed = TRUE)
  i <- unname(purrr::map_int(x, \(x) collapse::fmin(perl(x, "^ST"))))
  x <- unlist_(purrr::map2(x, i, \(x, i) .subset(x, i)))
  x <- strsplit(x, "*", fixed = TRUE)

  st01 <- unlist_elem(x, 2L)
  st03 <- purrr::map_chr(x, \(x) .subset(x, length(x)))
  st03[whichv_(startsWith(st03, "005010X"), FALSE)] <- NA_character_

  if (anyv_(st01, "820")) {
    i <- whichv_(st01, "820")
    r <- paste0(st01[i], "-", substr(st03[i], start = 7L, stop = 12L))
    collapse::setv(st01, i, r)
  }

  if (anyv_(st01, "834")) {
    i <- whichv_(st01, "834")
    r <- paste0(st01[i], "-", substr(st03[i], start = 7L, stop = 10L))
    collapse::setv(st01, i, r)
  }

  if (anyv_(st01, "837")) {
    i <- whichv_(st01, "837")
    collapse::setv(st01, i, x12_837_subtype(st03[i]))
  }
  st01
}
