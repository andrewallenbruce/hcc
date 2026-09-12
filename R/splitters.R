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
  i <- collapse::whichv(nchar(N), 1L)
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
#' x12_type(x = c(x12_820, x12_834, x12_837))
#' @noRd
x12_type <- function(x) {
  x <- rm_newline(x)

  if (length(x) == 1L) {
    x <- strsplit(x, "~", fixed = TRUE)[[1]]
    x <- strsplit(.subset(x, 3L), "*", fixed = TRUE)[[1]]
    if (x[2] == "837") {
      return(x12_837_subtype(x[4]))
    }
    return(x[2])
  }

  x <- strsplit(unlist_(x), "~", fixed = TRUE)
  x <- strsplit(unlist_elem(x, 3L), "*", fixed = TRUE)
  st01 <- unlist_elem(x, 2L)
  st03 <- unlist_elem(x, 4L)

  if (collapse::anyv(st01, "837")) {
    i <- collapse::whichv(st01, "837")
    collapse::setv(st01, i, x12_837_subtype(st03[i]))
  }
  st01
}

#' @noRd
parse_problems <- function(x, i) {
  if (length(x) != cheapr::unlisted_length(i)) {
    return(cheapr::setdiff_(seq_along(x), unlist_(i)))
  }
  return(integer(0L))
}

#' @noRd
new_x12_index <- function(i, x, text) {
  z <- collapse::whichv(collapse::vlengths(i, FALSE), 0L, TRUE)
  i <- cheapr::sset(i, z)

  cheapr::attrs_add(
    i,
    characters = nchar(text),
    segments = collapse::vlengths(i),
    problems = parse_problems(x, i),
    text = x,
    type = x12_type(text),
    class = "x12_index"
  )
}

#' @export
format.x12_index <- function(x, ...) {
  a <- attributes(x)
  cat(paste0("<", a$class, ">"), sep = "\n")

  cat(" ", sep = "\n")

  cat(
    paste0(
      format(
        c("Type", "Characters", "Segments", "Problems"),
        justify = "right"
      ),
      ": ",
      format(
        c(
          paste0("X12-", a$type),
          a$characters,
          sum(unname(a$segments)),
          length(a$problems)
        ),
        justify = "left"
      )
    ),
    sep = "\n"
  )

  cat(" ", sep = "\n")

  cat(
    paste0(
      format(names(a$segments), justify = "right"),
      ": ",
      format(unname(a$segments), justify = "left")
    ),
    sep = "\n"
  )
}

#' @export
print.x12_index <- function(x, ...) {
  format(x, ...)
  invisible(x)
}
