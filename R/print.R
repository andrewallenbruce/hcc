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

  nm_ <- cli::col_cyan(cli::style_bold((c("Type", "Segments"))))
  ns_ <- c(S7::prop(x, "Type"), length(S7::prop(x, "Text")))
  pr_ <- S7::prop(x, "Problems")

  if (!cheapr::is_na(pr_)) {
    pr_ <- length(pr_)
    nm_ <- c(nm_, cli::col_red(cli::style_bold("Problems")))
    ns_ <- c(ns_, cli::col_red(cli::style_bold(pr_)))
  }

  cli::cat_line(cheapr::paste_(fright(nm_)), ": ", fleft(ns_))
  cli::cat_rule()

  seg_nm <- cli::col_cyan(cli::style_bold(
    (c("Header", "Detail", "Trailer"))
  ))
  seg_pr <- list(x@Header, x@Details, x@Trailer)
  seg_ln <- cheapr::lengths_(seg_pr)
  seg_el <- purrr::map(seg_pr, \(i) {
    unique(purrr::map_chr(S7::prop(x, "Text")[i], \(x) {
      gsub("*", "", substr(x, 1, 3), fixed = TRUE)
    }))
  }) |>
    purrr::map_chr(\(i) cheapr::paste_(i, collapse = " > "))

  cli::cat_line(cheapr::paste_(
    fright(seg_nm),
    " ",
    fright(cheapr::paste_(" [", seg_ln, "]")),
    " ",
    fleft(seg_el)
  ))

  cli::cli_h2("Entity Loop")

  elp_nm <- cli::col_cyan(cli::style_bold((c("Entity", "Remits"))))
  elp_ln <- purrr::map(S7::prop(x, "Entity"), collapse::vlengths)
  ent_ln <- purrr::map_int(elp_ln, 1L)
  ent_tb <- cheapr::table_(ent_ln)
  ent_tb <- cheapr::paste_(
    "[",
    unname(ent_tb),
    "] <",
    names(ent_tb),
    ">",
    collapse = " "
  )
  ent_ln <- cheapr::paste_("[", length(ent_ln), "] ", ent_tb)

  rmr_ln <- purrr::map_int(elp_ln, 2L)
  rmr_tb <- cheapr::table_(rmr_ln)
  rmr_tb <- cheapr::paste_(
    "[",
    unname(rmr_tb),
    "] <",
    names(rmr_tb),
    ">",
    collapse = " "
  )
  rmr_ln <- cheapr::paste_("[", length(rmr_ln), "] ", rmr_tb)

  cli::cat_line(cheapr::paste_(
    fright(elp_nm),
    " ",
    fleft(c(ent_ln, rmr_ln))
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
