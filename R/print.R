S7::method(format, TextEDI) <- function(x) {
  cli::cli_h1("<{attr(x, .c(class))[1]}>")

  names_ <- cli::col_cyan(cli::style_bold(S7::prop_names(x)))
  numbs_ <- c(S7::prop(x, "Type"), length(S7::prop(x, "Text")))

  cli::cat_line(cheapr::paste_(fright(names_), ": ", fleft(numbs_)))
  cli::cat_rule()
}

S7::method(format, IndexEDI) <- function(x) {
  cli::cli_h1("<{attr(x, .c(class))[1]}>")

  names_ <- cli::col_cyan(cli::style_bold((c("Type", "Segments"))))
  numbs_ <- c(S7::prop(x, "Type"), length(S7::prop(x, "Text")))

  if (!cheapr::is_na(S7::prop(x, "Problems"))) {
    names_ <- c(names_, cli::col_red(cli::style_bold("Problems")))
    numbs_ <- c(
      numbs_,
      cli::col_red(cli::style_bold(length(S7::prop(x, "Problems"))))
    )
  }

  cli::cat_line(cheapr::paste_(fright(names_)), ": ", fleft(numbs_))
  cli::cat_rule()

  vlens <- collapse::vlengths(S7::prop(x, "Index"))
  names_ <- cli::style_bold(names(vlens))
  bracks <- cheapr::paste_(" [", unname(vlens), "]")
  numbs_ <- purrr::map_chr(unname(S7::prop(x, "Index")), toString, width = 45L)

  cli::cat_line(cheapr::paste_(
    fright(names_),
    fright(bracks),
    " ",
    fleft(numbs_)
  ))
  cli::cat_rule()
}

S7::method(format, Index820) <- function(x) {
  cli::cli_h1("<{attr(x, .c(class))[1]}>")

  names_ <- cli::col_cyan(cli::style_bold((c("Type", "Segments"))))
  numbs_ <- c(S7::prop(x, "Type"), length(S7::prop(x, "Text")))

  if (!cheapr::is_na(S7::prop(x, "Problems"))) {
    names_ <- c(names_, cli::col_red(cli::style_bold("Problems")))
    numbs_ <- c(
      numbs_,
      cli::col_red(cli::style_bold(length(S7::prop(x, "Problems"))))
    )
  }

  cli::cat_line(cheapr::paste_(fright(names_)), ": ", fleft(numbs_))
  cli::cat_rule()

  segments_ <- cli::col_cyan(cli::style_bold(
    (c("Header", "Detail", "Trailer"))
  ))
  segmslen_ <- c(length(x@Header), length(x@Details), length(x@Trailer))
  segnames_ <- purrr::map(S7::props(x)[c(4:5, 7)], \(i) {
    unique(purrr::map_chr(x@Text[i], \(x) {
      gsub("*", "", substr(x, 1, 3), fixed = TRUE)
    }))
  })
  segnames_ <- purrr::map(segnames_, \(i) cheapr::paste_(i, collapse = " > "))

  cli::cat_line(cheapr::paste_(
    fright(segments_),
    " ",
    fright(cheapr::paste_(" [", segmslen_, "]")),
    " ",
    fleft(segnames_)
  ))

  cli::cli_h2("Entity Loop")

  entnames_ <- cli::col_cyan(cli::style_bold((c("Entity", "Remittances"))))

  vlen <- purrr::map(x@Entity, \(x) collapse::vlengths(x))
  ent <- purrr::map_int(vlen, 1L)
  ent <- cheapr::paste_("[", length(ent), "] ", "<", unique(ent), ">")
  rmr <- purrr::map_int(vlen, 2L)
  rmr_tb <- cheapr::table_(rmr)
  rmr_tb <- cheapr::paste_(
    "[",
    names(rmr_tb),
    "]<",
    unname(rmr_tb),
    ">",
    collapse = " "
  )
  rmr <- cheapr::paste_("[", length(rmr), "] ", rmr_tb)

  cli::cat_line(cheapr::paste_(
    fright(entnames_),
    " ",
    fleft(c(ent, rmr))
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

S7::method(print, Index820) <- function(x) {
  format(x)
  invisible(x)
}
