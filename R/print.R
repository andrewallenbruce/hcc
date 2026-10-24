itred <- cli::combine_ansi_styles("italic", "red")
bcyan <- cli::combine_ansi_styles("bold", "cyan")
orange <- cli::combine_ansi_styles("bold", "orange")
dot <- cli::col_blue(cli::symbol$bullet)
bracket <- \(x) cheapr::paste_("[", x, "]")
angle <- \(x) cheapr::paste_("<", x, ">")
colon <- \(x, y) cheapr::paste_(x, ": ", y)
arrow <- \(x) cheapr::paste_(x, collapse = orange(" > "))
print_class <- \(x) cli::cli_h1("<{attr(x, .c(class))[1]}>")
print_names_ <- bcyan(c("Type", "Segments"))
print_names_2 <- bcyan(c("Header", "Detail", "Trailer"))

S7::method(format, TextEDI) <- function(x) {
  cli::cat_rule(left = angle(attr(x, .c(class))[1]), line = 2L)

  cat(
    colon(
      fright(c("Type", "Segments")),
      fleft(
        c(
          toString(S7::prop(x, "Type")),
          bracket(length(S7::prop(x, "Text")))
        )
      )
    ),
    sep = "\n"
  )
  cli::cat_rule()
}

#' @noRd
format_head <- function(x) {
  print_class(x)
  nm_ <- print_names_
  ns_ <- c(
    toString(S7::prop(x, "Type")),
    bracket(bcyan(length(S7::prop(x, "Text"))))
  )

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
  if (charr::str_detect(x, "^DTP|^REF\\*[A-Z0-9]{3}")) {
    return(charr::str_sub(x, 1L, 7L))
  }
  if (charr::str_detect(x, "^BGN|^QTY|^PER\\*|^REF\\*[A-Z0-9]{2}")) {
    return(charr::str_sub(x, 1L, 6L))
  }
  if (charr::str_detect(x, "^N1|^BPR")) {
    return(charr::str_sub(x, 1L, 5L))
  }
  if (charr::str_detect(x, "^ISA|^TRN|^IEA")) {
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
      fright(print_names_2),
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
      charr::str_sub(x, 4L, 7L),
      width = 3L,
      pad = "0"
    )
    return(cheapr::paste_("ENT", orange(x)))
  }
  if (charr::str_detect(x, "^DTM|^REF\\*[A-Z0-9]{3}")) {
    return(charr::str_sub(x, 1L, 7L))
  }
  if (charr::str_detect(x, "^RMR|^NM1|^REF\\*[A-Z0-9]{2}")) {
    return(charr::str_sub(x, 1L, 6L))
  }
  if (charr::str_detect(x, "^SLN")) {
    return(charr::str_sub(x, 1L, 5L))
  }
  if (charr::str_detect(x, "^ADX|^IT")) {
    return(charr::str_sub(x, 1L, 3L))
  }
  charr::str_sub(x, 1L, 2L)
}

# X12 820 Health Insurance Exchange Related Payments (005010/X306)
# X12 820 Payroll Deducted and Other Group Premium Payment For Insurance Products Examples (005010/X218)
S7::method(format, Index820) <- function(x) {
  format_head(x)
  format_segments(x)
  cat("", sep = "\n")

  x <- S7::prop(x, "Entity") |>
    purrr::map_depth(2L, \(y) {
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

  x <- fleft(cli::ansi_strtrim(
    unlist_(purrr::map_depth(x, 2L, arrow)),
    width = 60
  ))
  cli::cat_line(cheapr::paste_(fright(strrep(" ", 2L)), x, sep = " "))
  cli::cat_rule()
}

#' @noRd
fmt_member <- function(x) {
  if (charr::str_detect(x, "^INS")) {
    return(
      cheapr::paste_(
        cli::col_yellow("INS"),
        itred(charr::str_pad(
          charr::str_remove(charr::str_sub(x, 5L, 6L), "\\*"),
          width = 2L
        )),
        sep = " "
      )
    )
  }
  if (charr::str_detect(x, "^DSB|^DMG|^DTP|^REF\\*[A-Z0-9]{3}")) {
    return(charr::str_sub(x, 1L, 7L))
  }
  if (charr::str_detect(x, "^HD\\*|^NM1|^REF\\*[A-Z0-9]{2}")) {
    return(charr::str_sub(x, 1L, 6L))
  }
  if (charr::str_detect(x, "^AMT|^ACT|^IDC|^PLA|^COB|^PER|^QTY|^HLH|^LUI")) {
    return(charr::str_sub(x, 1L, 3L))
  }
  charr::str_sub(x, 1L, 2L)
}

# X12 834 Benefit Enrollment and Maintenance (005010/X220A1)
S7::method(format, Index834) <- function(x) {
  format_head(x)
  format_segments(x)
  cat("", sep = "\n")

  x <- S7::prop(x, "Member") |>
    purrr::map(\(y) {
      purrr::map_chr(names(y), fmt_member) |>
        charr::str_replace("\\*", dot)
    })

  cli::cli_rule(
    cheapr::paste_(
      bcyan("Member"),
      bracket(bcyan(cheapr::unlisted_length(x))),
      sep = " "
    )
  )

  x <- fleft(cli::ansi_strwrap(
    purrr::map_chr(x, arrow),
    exdent = 9L,
    width = cli::console_width() - 10L
  ))

  cli::cat_line(cheapr::paste_(fright(strrep(" ", 2L)), x, sep = " "))
  cli::cat_rule()
}

S7::method(print, TextEDI | Index820 | Index834) <- function(x) {
  format(x)
  invisible(x)
}
