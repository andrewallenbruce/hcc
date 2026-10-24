#' @noRd
subset_ <- function(x, i, name = FALSE) {
  x <- S7::prop(x, "Text") |>
    .subset(i) |>
    charr::str_split("\\*") |>
    purrr::map(\(x) set_zchar(trimws(x)))

  if (!name) {
    return(x)
  }

  rlang::set_names(
    purrr::map(x, .subset, -1L),
    purrr::map(x, 1L)
  )
}

#' @noRd
edi_header <- function(x) {
  i <- subset_(x, S7::prop(x, "Header"), TRUE)
  HeaderEDI(
    ISA = i[["ISA"]],
    GS = i[["GS"]],
    ST = i[["ST"]]
  )
}

#' @noRd
edi_trailer <- function(x) {
  i <- subset_(x, S7::prop(x, "Trailer"), TRUE)
  TrailerEDI(
    SE = i[["SE"]],
    GE = i[["GE"]],
    IEA = i[["IEA"]]
  )
}

#' @noRd
as_detail834 <- function(x) {
  d <- subset_(x, S7::prop(x, "Details"))
  if (length(d) == 3L) {
    return(
      Detail834(
        BGN = d[[1L]][-1L],
        N1P5 = d[[2L]][3:5],
        N1IN = d[[3L]][3:5],
        REF38 = NA_character_,
        QTY = NA_character_,
        DTP = NA_character_
      )
    )
  }
  if (length(d) == 5L) {
    return(
      Detail834(
        BGN = d[[1L]][-1L],
        REF38 = d[[2L]][-1L],
        DTP = d[[3L]][-1L],
        N1P5 = d[[4L]][3:5],
        N1IN = d[[5L]][3:5],
        QTY = NA_character_
      )
    )
  }

  if (length(d) == 4L && d[[2]][1] == "QTY") {
    return(
      Detail834(
        BGN = d[[1L]][-1L],
        QTY = d[[2L]][-1L],
        N1P5 = d[[3L]][3:5],
        N1IN = d[[4L]][3:5],
        REF38 = NA_character_,
        DTP = NA_character_
      )
    )
  }
  if (length(d) == 4L && d[[2]][1] == "REF") {
    return(
      Detail834(
        BGN = d[[1L]][-1L],
        REF38 = d[[2L]][-1L],
        N1P5 = d[[3L]][3:5],
        N1IN = d[[4L]][3:5],
        QTY = NA_character_,
        DTP = NA_character_
      )
    )
  }
}

#' @noRd
detail_306 <- function(x) {
  d <- subset_(x, S7::prop(x, "Details"), TRUE)
  n <- unname(purrr::map_chr(d, 1L)[3:length(d)])

  if (setequal(n, c("38", "TV", "PE", "RM"))) {
    return(
      Detail306(
        BPR = d[["BPR"]],
        TRN = d[["TRN"]],
        REF = c(d[[3L]], d[[4L]]),
        NPE = d[[5L]],
        NRM = d[[6L]],
        PER = NA_character_
      )
    )
  }
  if (setequal(n, c("PE", "RM", "IC"))) {
    return(
      Detail306(
        BPR = d[["BPR"]],
        TRN = d[["TRN"]],
        REF = NA_character_,
        NPE = d[[3L]],
        NRM = d[[4L]],
        PER = d[[5L]]
      )
    )
  }
}

#' @noRd
detail_218 <- function(x) {
  d <- subset_(x, S7::prop(x, "Details"), TRUE)
  n <- names(purrr::map_chr(d, 1L)[4:length(d)])

  if (setequal(n, c("N1", "N1"))) {
    return(
      Detail218(
        BPR = d[["BPR"]],
        TRN = d[["TRN"]],
        REF = d[["REF"]],
        NPE = d[[4L]],
        NPR = d[[5L]]
      )
    )
  }

  if (setequal(n, c("N1", "N3", "N4", "N1"))) {
    return(
      Detail218(
        BPR = d[["BPR"]],
        TRN = d[["TRN"]],
        REF = d[["REF"]],
        NPE = c(d[[4L]], d[[5L]], d[[6L]]),
        NPR = d[[7L]]
      )
    )
  }

  if (setequal(n, c("N1", "N1", "N3", "N4"))) {
    return(
      Detail218(
        BPR = d[["BPR"]],
        TRN = d[["TRN"]],
        REF = d[["REF"]],
        NPE = d[[4L]],
        NPR = c(d[[5L]], d[[6L]], d[[7L]])
      )
    )
  }

  if (setequal(n, c("N1", "N3", "N4", "N1", "N3", "N4"))) {
    return(
      Detail218(
        BPR = d[["BPR"]],
        TRN = d[["TRN"]],
        REF = d[["REF"]],
        NPE = c(d[[4L]], d[[5L]], d[[6L]]),
        NPR = c(d[[7L]], d[[8L]], d[[9L]])
      )
    )
  }
}
