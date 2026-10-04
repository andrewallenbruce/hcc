BoldRed <- cli::combine_ansi_styles("bold", "red")
BoldCyan <- cli::combine_ansi_styles("bold", "cyan")

S7::method(format, TextEDI) <- function(x) {
  cli::cli_h1("<{attr(x, .c(class))[1]}>")

  names_ <- BoldCyan((c("Type", "Segments")))
  numbs_ <- c(S7::prop(x, "Type"), length(S7::prop(x, "Text")))

  cli::cat_line(cheapr::paste_(fright(names_), ": ", fleft(numbs_)))
  cli::cat_rule()
}

S7::method(format, IndexEDI) <- function(x) {
  cli::cli_h1("<{attr(x, .c(class))[1]}>")

  names_ <- BoldCyan((c("Type", "Segments")))
  numbs_ <- c(S7::prop(x, "Type"), length(S7::prop(x, "Text")))

  if (!cheapr::is_na(S7::prop(x, "Problems"))) {
    names_ <- c(names_, BoldRed("Problems"))
    numbs_ <- c(numbs_, BoldRed(length(S7::prop(x, "Problems"))))
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

  nm_ <- BoldCyan((c("Type", "Segments")))
  ns_ <- c(S7::prop(x, "Type"), length(S7::prop(x, "Text")))
  pr_ <- S7::prop(x, "Problems")

  if (!cheapr::is_na(pr_)) {
    nm_ <- c(nm_, BoldRed("Problems"))
    ns_ <- c(ns_, BoldRed(length(pr_)))
  }

  cli::cat_line(cheapr::paste_(fright(nm_)), ": ", fleft(ns_))
  cli::cat_rule()

  seg_nm <- BoldCyan(c("Header", "Detail", "Trailer"))
  seg_pr <- list(
    S7::prop(x, "Header"),
    S7::prop(x, "Details"),
    S7::prop(x, "Trailer")
  )
  seg_el <- purrr::map(seg_pr, \(i) {
    S7::prop(x, "Text")[i] |>
      purrr::map_chr(\(x) gsub("*", "", substr(x, 1, 3), fixed = TRUE)) |>
      cheapr::unique_()
  }) |>
    purrr::map_chr(\(i) cheapr::paste_(i, collapse = " > "))

  cli::cat_line(cheapr::paste_(
    fright(seg_nm),
    " ",
    fright(cheapr::paste_(" [", cheapr::lengths_(seg_pr), "]")),
    " ",
    fleft(seg_el)
  ))

  cli::cli_h2("Entity Loop")

  elp_nm <- BoldCyan(c("Entity", "Remits"))
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

S7::method(format, Index834) <- function(x) {
  cli::cli_h1("<{attr(x, .c(class))[1]}>")

  nm_ <- BoldCyan((c("Type", "Segments")))
  ns_ <- c(S7::prop(x, "Type"), length(S7::prop(x, "Text")))
  pr_ <- S7::prop(x, "Problems")

  if (!cheapr::is_na(pr_)) {
    nm_ <- c(nm_, BoldRed("Problems"))
    ns_ <- c(ns_, BoldRed(length(pr_)))
  }

  cli::cat_line(cheapr::paste_(fright(nm_)), ": ", fleft(ns_))
  cli::cat_rule()

  seg_nm <- BoldCyan(c("Header", "Detail", "Member", "Trailer"))
  seg_pr <- list(
    S7::prop(x, "Header"),
    S7::prop(x, "Details"),
    S7::prop(x, "Member"),
    S7::prop(x, "Trailer")
  )

  seg_el <- purrr::map(seg_pr, \(i) {
    if (is.list(i)) {
      i <- unlist_(i)
    }
    S7::prop(x, "Text")[i] |>
      purrr::map_chr(\(x) gsub("*", "", substr(x, 1, 3), fixed = TRUE)) |>
      cheapr::unique_()
  }) |>
    purrr::map_chr(\(i) cheapr::paste_(i, collapse = " > "))

  seg_pr <- cheapr::paste_(" [", collapse::vlengths(seg_pr), "]")

  cli::cat_line(
    cheapr::paste_(fright(seg_nm), fright(seg_pr), fleft(seg_el), sep = " ")
  )
  cli::cat_rule()
}

S7::method(print, TextEDI | IndexEDI) <- function(x) {
  format(x)
  invisible(x)
}

S7::method(print, Index820 | Index834) <- function(x) {
  format(x)
  invisible(x)
}
