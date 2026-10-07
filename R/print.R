BoldRed <- cli::combine_ansi_styles("bold", "red")
BoldCyan <- cli::combine_ansi_styles("bold", "cyan")

#' @noRd
bracket <- function(x) cheapr::paste_("[", x, "]")
#' @noRd
angle <- function(x) cheapr::paste_("<", x, ">")
#' @noRd
colon <- function(x, y) cheapr::paste_(x, ": ", y)
#' @noRd
arrow <- function(x, y) cheapr::paste_(x, collapse = " > ")


S7::method(format, TextEDI) <- function(x) {
  cli::cli_h1("<{attr(x, .c(class))[1]}>")

  names_ <- BoldCyan((c("Type", "Segments")))
  numbs_ <- c(S7::prop(x, "Type"), length(S7::prop(x, "Text")))

  cli::cat_line(colon(fright(names_), fleft(numbs_)))
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

  cli::cat_line(colon(fright(names_), fleft(numbs_)))
  cli::cat_rule()

  vlens <- collapse::vlengths(S7::prop(x, "Index"))
  names_ <- cli::style_bold(names(vlens))
  bracks <- bracket(unname(vlens))
  numbs_ <- purrr::map_chr(unname(S7::prop(x, "Index")), toString, width = 45L)

  cli::cat_line(
    cheapr::paste_(
      fright(names_),
      fright(bracks),
      fleft(numbs_),
      sep = " "
    )
  )
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

  cli::cat_line(colon(fright(nm_), fleft(ns_)))
  cli::cat_rule()

  seg <- list(
    S7::prop(x, "Header"),
    S7::prop(x, "Details"),
    S7::prop(x, "Trailer")
  )
  ele <- purrr::map(seg, \(i) {
    S7::prop(x, "Text")[i] |>
      purrr::map_chr(\(x) gsub("*", "", substr(x, 1, 3), fixed = TRUE)) |>
      cheapr::unique_()
  })

  cli::cat_line(
    cheapr::paste_(
      fright(BoldCyan(c("Header", "Detail", "Trailer"))),
      bracket(cheapr::lengths_(seg)),
      fleft(purrr::map_chr(ele, arrow)),
      sep = " "
    )
  )

  cli::cli_h2("Entity Loop")
  elp <- purrr::map(S7::prop(x, "Entity"), collapse::vlengths)
  ent <- cheapr::table_(purrr::map_int(elp, 2L))
  ent <- cheapr::paste_(
    cli::style_bold(
      bracket(length(ent))
    ),
    cheapr::paste_(
      bracket(unname(ent)),
      angle(names(ent)),
      sep = " ",
      collapse = " "
    )
  )

  rmr <- cheapr::table_(purrr::map_int(elp, 2L))
  rmr <- cheapr::paste_(
    cli::style_bold(
      bracket(length(rmr))
    ),
    cheapr::paste_(
      bracket(unname(rmr)),
      angle(names(rmr)),
      sep = " ",
      collapse = " "
    )
  )

  cli::cat_line(cheapr::paste_(
    fright(BoldCyan(c("Entity", "Remits"))),
    fleft(c(ent, rmr)),
    sep = " "
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
