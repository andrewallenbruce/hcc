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
map_seq <- function(text, start, end) {
  purrr::map(
    purrr::map2(
      start,
      end,
      function(a, b) seq.int(a, b)
    ),
    function(i) text[i]
  )
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
split_N1 <- function(x, i) {
  x <- star(x, i)
  purrr::map(x, \(x) post_split(x[-1])) |>
    rlang::set_names(purrr::map_chr(x, 1L))
}

#' @noRd
split_TRN <- function(x) {
  TRN <- perl(x, "^TRN")
  PE1 <- perl(x, "^N1\\*PE")
  PR1 <- perl(x, "^N1\\*PR")
  PR2 <- min(perl(x, "^ENT")) - 1L

  rlang::list2(
    TRN = split_i(x, TRN),
    REF = split_i(x, TRN + 1L),
    # 1000A Payee Name Loop
    !!!split_N1(x, seq.int(PE1, PR1 - 1L)),
    # 1000B Payer Name Loop
    !!!split_N1(x, seq.int(PR1, PR2))
  )
}


#' @examplesIf FALSE
#' x12_type(c(x12_820, x12_834, x12_837))
#' @noRd
x12_type <- function(x) {
  # i <- purrr::map_int(x, \(x) collapse::fmin(perl(x, "^ST")))
  # x <- purrr::map_chr(x, \(x) x[collapse::fmin(perl(x, "^ST"))])

  x <- unlist_(x)
  x <- strsplit(x, "~", fixed = TRUE)
  x <- collapse::get_elem(x, 3L)

  x <- unlist_(x)
  x <- strsplit(x, "*", fixed = TRUE)
  x_1 <- collapse::get_elem(x, 2L)
  x_1 <- unlist_(x_1)

  if (collapse::anyv(x_1, "837")) {
    x_2 <- collapse::get_elem(x, 4L)
    x_2 <- unlist_(x_2)
    x_i <- collapse::whichv(x_1, "837")
    x_1[x_i] <- cheapr::val_match(
      x_2[x_i],
      "005010X222A1" ~ "837P",
      "005010X223A2" ~ "837I",
      "005010X224A2" ~ "837D",
      .default = NA
    )
  }
  x_1
}
