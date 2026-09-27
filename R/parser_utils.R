#' @noRd
semi_count <- function(x) {
  length(.subset2(gregexpr(";", text = x, fixed = TRUE), 1L))
}

#' @noRd
parse_TRAILER <- function(x) {
  list(
    SE = split_7(x, "SE"),
    GE = split_7(x, "GE"),
    IEA = split_7(x, "IEA")
  )
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
input_ <- function(x) {
  if (!rlang::is_scalar_character(x)) {
    cheapr::paste_(x, collapse = "")
  } else {
    x
  }
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
subset_ <- function(text, start, end) {
  fill_sequence(start, end) |>
    purrr::map(\(i) .subset(text, i))
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
post_split <- function(x) {
  pad_names(set_zchar(trimws(x)))
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
