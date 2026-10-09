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
  numbs_ <- c(S7::prop(x, "Type"), bracket(bcyan(length(S7::prop(x, "Text")))))

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
fmt_segment <- function(x) {
  if (charr::str_detect(x, "^N1")) {
    return(charr::str_sub(x, 1L, 5L))
  }
  if (charr::str_detect(x, "^REF")) {
    return(charr::str_sub(x, 1L, 6L))
  }
  if (charr::str_detect(x, "^ISA|^BPR|^BGN|^TRN|^IEA")) {
    return(charr::str_sub(x, 1L, 3L))
  }
  charr::str_sub(x, 1L, 2L)
}

#' @noRd
format_segments <- function(x) {
  x <- list(
    S7::prop(x, "Header"),
    S7::prop(x, "Details"),
    S7::prop(x, "Trailer")
  ) |>
    purrr::map(\(y) {
      purrr::map_chr(
        S7::prop(x, "Text")[y],
        fmt_segment
      ) |>
        charr::str_replace("\\*", dot)
    })

  cli::cat_line(
    cheapr::paste_(
      fright(" "),
      fright(bcyan(c("Header", "Detail", "Trailer"))),
      fright(bracket(bcyan(cheapr::lengths_(x)))),
      fleft(purrr::map_chr(x, arrow)),
      sep = " "
    )
  )
}

#' @noRd
fmt_entity <- function(x) {
  if (charr::str_detect(x, "^ENT")) {
    x <- charr::str_pad(
      charr::str_remove(
        charr::str_sub(x, 5L, 6L),
        "\\*"
      ),
      width = 2L,
      pad = "0"
    )
    return(cheapr::paste_(
      cli::col_yellow("ENT"),
      itred(x),
      sep = " "
    ))
  }
  if (charr::str_detect(x, "^RMR|^REF|^NM1")) {
    return(charr::str_sub(x, 1L, 6L))
  }
  if (charr::str_detect(x, "^DTM|^ADX|^IT|^SLN")) {
    return(charr::str_sub(x, 1L, 3L))
  }
  charr::str_sub(x, 1L, 2L)
}

S7::method(format, Index820) <- function(x) {
  format_head(x)
  format_segments(x)
  cat("", sep = "\n")

  x <- S7::prop(x, "Entity") |>
    purrr::map(\(y) {
      purrr::map_chr(names(y), fmt_entity) |>
        charr::str_replace("\\*", dot)
    })

  cli::cli_rule(
    cheapr::paste_(
      bcyan("Entity"),
      bracket(bcyan(cheapr::unlisted_length(x))),
      sep = " "
    )
  )

  x <- fleft(cli::ansi_strtrim(purrr::map_chr(x, arrow), width = 60))
  cli::cat_line(cheapr::paste_(fright(strrep(" ", 2L)), x, sep = " "))
  cli::cat_rule()
}

S7::method(format, Index834) <- function(x) {
  format_head(x)
  format_segments(x)
  cat("", sep = "\n")
  mem <- purrr::map(
    S7::prop(x, "Member"),
    \(y) {
      purrr::map_chr(
        names(y),
        \(x) {
          if (charr::str_detect(x, "^INS")) {
            return(
              cheapr::paste_(
                cli::col_yellow("INS"),
                itred(
                  charr::str_pad(
                    charr::str_remove(
                      charr::str_sub(x, 5L, 6L),
                      "\\*"
                    ),
                    width = 2L
                  )
                ),
                sep = " "
              )
            )
          }
          if (charr::str_detect(x, "^REF\\*[A-Z0-9]{3}|^DTP")) {
            return(charr::str_sub(x, 1L, 7L))
          }
          if (charr::str_detect(x, "^HD\\*|^REF\\*[A-Z0-9]{2}|^NM1")) {
            return(charr::str_sub(x, 1L, 6L))
          }
          if (
            charr::str_detect(
              x,
              "^DSB|^DMG|^AMT|^ACT|^IDC|^PLA|^COB|^PER|^QTY|^HLH|^LUI"
            )
          ) {
            return(charr::str_sub(x, 1L, 3L))
          }
          charr::str_sub(x, 1L, 2L)
        }
      ) |>
        charr::str_replace("\\*", dot)
    }
  ) |>
    purrr::list_flatten()

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
      fleft(cli::ansi_strwrap(purrr::map_chr(mem, arrow), exdent = 9L)),
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
