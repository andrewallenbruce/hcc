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

#' @noRd
x12_820_subtype <- function(x) {
  paste0(x[2], "-", substr(x[length(x)], start = 7L, stop = 12L))
}

#' @noRd
x12_834_subtype <- function(x) {
  paste0(x[2], "-", substr(x[length(x)], start = 7L, stop = 10L))
}

#' @noRd
x12_837_subtype <- function(x) {
  cheapr::val_match(
    x,
    "005010X222A1" ~ "837P-X222", # A1
    "005010X223A2" ~ "837I-X223", # A2
    .default = NA_character_
  )
}

#' @examplesIf FALSE
#' x12_type(x = c(x12_820, x12_834, x12_837I, x12_837P))
#' @noRd
x12_type <- function(x) {
  if (length(x) == 1L) {
    x <- strsplit(rm_newline(x), "~", fixed = TRUE)[[1]]
    x <- strsplit(.subset(x, perl(x, "^ST")), "*", fixed = TRUE)[[1]]
    return(
      switch(
        x[2],
        "820" = x12_820_subtype(x),
        "837" = x12_837_subtype(x[length(x)]),
        "834" = x12_834_subtype(x),
        NA_character_
      )
    )
  }

  x <- purrr::map(x, \(x) paste0(unlist_(rm_newline(x)), collapse = ""))
  x <- strsplit(unlist(x), "~", fixed = TRUE)
  i <- unname(purrr::map_int(x, \(x) min(perl(x, "^ST"))))
  x <- unlist_(purrr::map2(x, i, \(x, i) x[i]))
  x <- strsplit(x, "*", fixed = TRUE)

  st01 <- unlist_elem(x, 2L)
  st03 <- purrr::map_chr(x, \(x) x[length(x)])
  st03[whichv_(startsWith(st03, "005010X"), FALSE)] <- NA_character_

  if (anyv_(st01, "820")) {
    i <- whichv_(st01, "820")
    r <- paste0(st01[i], "-", substr(st03[i], start = 7L, stop = 10L))
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

#' @noRd
parse_problems <- function(x, i) {
  if (length(x) != cheapr::unlisted_length(i)) {
    return(cheapr::setdiff_(seq_along(x), unlist_(i)))
  }
  return(integer(0L))
}

#' @noRd
new_x12_index <- function(i, x, text, xtype) {
  z <- whichv_(collapse::vlengths(i, FALSE), 0L, TRUE)
  i <- cheapr::sset(i, z)

  cheapr::attrs_add(
    i,
    characters = nchar(text),
    segments = collapse::vlengths(i),
    problems = parse_problems(x, i),
    text = x,
    type = xtype,
    class = "x12_index"
  )
}

#' @noRd
problems <- function(x) {
  i <- purrr::map_lgl(x, \(x) inherits(x, "x12_index"))
  x <- .subset(x, unname(i))
  .subset(attr(x, "text"), attr(x, "problems"))
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
          a$type,
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
      format(
        paste0(names(a$segments), "[", unname(a$segments), "]"),
        justify = "right"
      ),
      ": ",
      format(
        purrr::map_chr(x[names(a$segments)], \(x) toString(x, width = 70)),
        justify = "left"
      )
    ),
    sep = "\n"
  )
}

#' @export
print.x12_index <- function(x, ...) {
  format(x, ...)
  invisible(x)
}
