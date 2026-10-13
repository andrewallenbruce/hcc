#' @noRd
sort_index <- function(i) {
  i <- cheapr::sset(i, whichv_(collapse::vlengths(i, FALSE), 0L, TRUE))
  i[names(sort.int(purrr::map_int(i, \(x) .subset(x, 1L))))]
}

#' @noRd
semi_count <- function(x) {
  length(.subset2(gregexpr(";", text = x, fixed = TRUE), 1L))
}

#' @noRd
split_7 <- function(x, name) {
  .subset(
    split_1(
      S7::prop(x, "text"),
      .subset2(
        S7::prop(x, "index"),
        name
      )
    ),
    -1L
  ) |>
    collapse::na_rm()
}


#' @noRd
split_1 <- function(x, i) {
  if (is.null(i)) {
    return(NULL)
  }

  set_zchar(
    trimws(
      .subset2(
        strsplit(
          .subset(x, i),
          "*",
          fixed = TRUE
        ),
        1L
      )
    )
  )
}

#' @noRd
fill_ <- function(start, end, as_list = FALSE) {
  cheapr::seq_(from = start, to = end, as_list = as_list)
}

#' @noRd
fill_sequence <- function(start, end) {
  purrr::map2(start, end, \(a, b) seq.int(from = a, to = b))
}

#' @noRd
set_zchar <- function(x) {
  collapse::setv(x, !nzchar(x), NA_character_)
  x
}

#' @noRd
pad_names <- function(x) {
  n <- as.character(seq_along(x))
  i <- whichv_(nchar(n), 1L)
  collapse::setv(n, i, cheapr::paste_("0", n[i]))
  n
  # rlang::set_names(as.list(x), N)
}

#' @noRd
rm_newline <- function(x) {
  if (all_(!grepl("\n", x, fixed = TRUE))) {
    return(x)
  }
  gsub("\n", "", x, fixed = TRUE)
}

#' @noRd
tilde <- function(x) {
  .subset2(strsplit(rm_newline(x), "~", fixed = TRUE), 1L)
}

#' @noRd
star <- function(x, i) {
  strsplit(.subset(x, i), "*", fixed = TRUE)
}
