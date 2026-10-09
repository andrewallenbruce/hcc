itred <- cli::combine_ansi_styles("italic", "red")
bcyan <- cli::combine_ansi_styles("bold", "cyan")
orange <- cli::combine_ansi_styles("bold", "orange")
dot <- cli::col_blue(cli::symbol$bullet)

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

#' @noRd
format_head <- function(x) {
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
}

#' @noRd
format_segment <- function(x) {
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
          if (perl0(x, "^ISA|^BPR|^BGN|^TRN|^IEA")) {
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
}

S7::method(format, Index820) <- function(x) {
  format_head(x)
  format_segment(x)

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
  format_head(x)
  format_segment(x)
  mem <- purrr::map(
    S7::prop(x, "Member"),
    \(y) {
      purrr::map_chr(
        names(y),
        \(x) {
          if (perl0(x, "^INS")) {
            return(
              cheapr::paste_(
                orange("INS"),
                itred(charr::str_pad(
                  charr::str_remove(substr(x, 5L, 6L), "\\*"),
                  width = 2L
                )),
                sep = " "
              )
            )
          }
          if (perl0(x, "^REF\\*[A-Z0-9]{3}|^DTP")) {
            return(substr(x, 1L, 7L))
          }
          if (perl0(x, "^HD\\*")) {
            return(cheapr::paste_("HD", substr(x, 4L, 6L), sep = " "))
          }
          if (perl0(x, "^REF\\*[A-Z0-9]{2}|^NM1")) {
            return(substr(x, 1L, 6L))
          }
          if (perl0(x, "^DSB|^DMG|^AMT|^ACT|^IDC|^PLA|^COB|^PER|^QTY|^HLH|^LUI")) {
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
      bcyan("Member"),
      bracket(bcyan(cheapr::unlisted_length(mem))),
      sep = " "
    )
  )
  cli::cat_line(
    cheapr::paste_(
      fright(strrep(" ", 2L)),
      fleft(cli::ansi_strtrim(purrr::map_chr(mem, arrow), width = 70)),
      sep = " "
    )
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
