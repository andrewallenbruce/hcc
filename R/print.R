itred <- cli::combine_ansi_styles("italic", "red")
bcyan <- cli::combine_ansi_styles("bold", "cyan")
orange <- cli::combine_ansi_styles("bold", "orange")
dblue <- cli::make_ansi_style("dodgerblue")
brick <- orange
dot <- dblue(cli::symbol$bullet)

#' @noRd
bracket <- function(x) cheapr::paste_("[", x, "]")
#' @noRd
angle <- function(x) cheapr::paste_("<", x, ">")
#' @noRd
colon <- function(x, y) cheapr::paste_(x, ": ", y)
#' @noRd
arrow <- function(x) cheapr::paste_(x, collapse = orange(" > "))


S7::method(format, TextEDI) <- function(x) {
  cli::cli_h1("<{attr(x, .c(class))[1]}>")

  names_ <- bcyan((c("Type", "Segments")))
  numbs_ <- c(S7::prop(x, "Type"), length(S7::prop(x, "Text")))

  cli::cat_line(colon(fright(names_), fleft(numbs_)))
  cli::cat_rule()
}

S7::method(format, IndexEDI) <- function(x) {
  cli::cli_h1("<{attr(x, .c(class))[1]}>")

  names_ <- bcyan((c("Type", "Segments")))
  numbs_ <- c(S7::prop(x, "Type"), length(S7::prop(x, "Text")))

  if (!cheapr::is_na(S7::prop(x, "Problems"))) {
    names_ <- c(names_, itred("Problems"))
    numbs_ <- c(numbs_, itred(length(S7::prop(x, "Problems"))))
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

  nm_ <- bcyan((c("Type", "Segments")))
  ns_ <- c(S7::prop(x, "Type"), bracket(bcyan(length(S7::prop(x, "Text")))))

  if (!cheapr::is_na(S7::prop(x, "Problems"))) {
    nm_ <- c(nm_, itred("Problems"))
    ns_ <- c(ns_, itred(length(S7::prop(x, "Problems"))))
  }

  cli::cat_line(cheapr::paste_(
    fright(strrep(" ", 1L)),
    colon(fright(nm_), fleft(ns_))
  ))
  cli::cat_rule()

  seg <- list(
    S7::prop(x, "Header"),
    S7::prop(x, "Details"),
    S7::prop(x, "Trailer")
  ) |>
    purrr::map(\(y) {
      S7::prop(x, "Text")[y] |>
        purrr::map_chr(\(x) {
          if (perl0(x, "^N1")) {
            return(substr(x, 1L, 5L))
          }
          if (perl0(x, "^REF")) {
            return(substr(x, 1L, 6L))
          }
          if (perl0(x, "^ISA|^BPR|^TRN")) {
            return(substr(x, 1L, 3L))
          }
          substr(x, 1L, 2L)
        }) |>
        charr::str_replace("\\*", dot)
    })

  cli::cat_line(
    cheapr::paste_(
      fright(strrep(" ", 1L)),
      fright(bcyan(c("Header", "Detail", "Trailer"))),
      fright(bracket(bcyan(cheapr::lengths_(seg)))),
      fleft(purrr::map_chr(seg, arrow)),
      sep = " "
    )
  )

  ent <- purrr::map(
    S7::prop(x, "Entity"),
    \(y) {
      purrr::map_chr(
        names(y),
        \(x) {
          if (perl0(x, "^ENT")) {
            return(
              cheapr::paste_(
                cli::col_yellow("ENT"),
                itred(charr::str_pad(
                  charr::str_remove(substr(x, 5L, 6L), "\\*"),
                  width = 2L,
                  pad = "0"
                )),
                sep = " "
              )
            )
          }
          if (perl0(x, "^RMR|^REF|^NM1")) {
            return(substr(x, 1L, 6L))
          }
          if (perl0(x, "^DTM|^ADX|^IT|^SLN")) {
            return(substr(x, 1L, 3L))
          }
          substr(x, 1L, 2L)
        }
      ) |>
        charr::str_replace("\\*", dot)
    }
  ) |>
    purrr::list_flatten()

  cli::cli_text()

  cli::cli_rule(
    cheapr::paste_(
      bcyan("Entity"),
      bracket(bcyan(cheapr::unlisted_length(ent))),
      sep = " "
    )
  )
  cli::cat_line(
    cheapr::paste_(
      fright(strrep(" ", 2L)),
      fleft(cli::ansi_strtrim(purrr::map_chr(ent, arrow), width = 60)),
      sep = " "
    )
  )
  cli::cat_rule()
}

S7::method(format, Index834) <- function(x) {
  cli::cli_h1("<{attr(x, .c(class))[1]}>")

  nm_ <- bcyan((c("Type", "Segments")))
  ns_ <- c(S7::prop(x, "Type"), length(S7::prop(x, "Text")))
  pr_ <- S7::prop(x, "Problems")

  if (!cheapr::is_na(pr_)) {
    nm_ <- c(nm_, itred("Problems"))
    ns_ <- c(ns_, itred(length(pr_)))
  }

  cli::cat_line(cheapr::paste_(fright(nm_)), ": ", fleft(ns_))
  cli::cat_rule()

  seg_nm <- bcyan(c("Header", "Detail", "Member", "Trailer"))
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
