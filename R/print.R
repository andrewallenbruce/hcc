S7::method(format, TextEDI) <- function(x) {
  cli::cli_h1("<{attr(x, .c(class))[1]}>")

  names_ <- cli::col_cyan(cli::style_bold(c("Type", "Segments")))
  numbs_ <- c(x@type, length(x@text))

  cli::cat_line(cheapr::paste_(fright(names_), ": ", fleft(numbs_)))
  cli::cat_rule()
}

S7::method(format, IndexEDI) <- function(x) {
  cli::cli_h1("<{attr(x, .c(class))[1]}>")

  names_ <- cli::col_cyan(cli::style_bold((c("Type", "Segments"))))
  numbs_ <- c(x@type, length(x@text))

  if (!is.na(x@problems)) {
    names_ <- c(names_, cli::col_red(cli::style_bold("Problems")))
    numbs_ <- c(numbs_, cli::col_red(cli::style_bold(length(x@problems))))
  }

  cli::cat_line(cheapr::paste_(fright(names_)), ": ", fleft(numbs_))
  cli::cat_rule()

  vlens <- collapse::vlengths(x@index)
  names_ <- cli::style_bold(names(vlens))
  bracks <- cheapr::paste_(" [", unname(vlens), "]")
  numbs_ <- purrr::map_chr(unname(x@index), toString, width = 45L)

  cli::cat_line(cheapr::paste_(
    fright(names_),
    fright(bracks),
    " ",
    fleft(numbs_)
  ))
  cli::cat_rule()
}

S7::method(print, TextEDI) <- function(x) {
  format(x)
  invisible(x)
}

S7::method(print, IndexEDI) <- function(x) {
  format(x)
  invisible(x)
}
