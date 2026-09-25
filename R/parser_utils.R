#' @noRd
split_1 <- function(
  x,
  i,
  arg = rlang::caller_arg(i),
  call = rlang::caller_env()
) {
  if (is.null(i)) {
    cli::cli_abort(
      "{.arg {arg}} is NULL",
      arg = arg,
      call = call
    )
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
check_text_ <- function(x) {
  if (length(x) > 1L || is.list(x)) {
    paste0(unlist_(x), collapse = "")
  } else {
    x
  }
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
  N <- as.character(seq_along(x))
  i <- whichv_(nchar(N), 1L)
  collapse::setv(N, i, cheapr::paste_("0", N[i]))
  rlang::set_names(as.list(x), N)
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
  strsplit(rm_newline(x), "~", fixed = TRUE)[[1]]
}

#' @noRd
semicolon <- function(x) {
  strsplit(x, ";", fixed = TRUE)[[1]]
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
