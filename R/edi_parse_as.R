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
detail_837 <- function(x) {
  d <- subset_(x, S7::prop(x, "Details"), TRUE)
  n <- names(purrr::map_chr(d, 1L)[2:length(d)])

  if (identical(n, c("NM1", "PER", "NM1"))) {
    return(
      Detail837(
        BHT = d[["BHT"]],
        N41 = d[[2L]],
        P41 = d[[3L]],
        N40 = d[[4L]],
        P40 = NA_character_
      )
    )
  }
  if (identical(n, c("NM1", "NM1", "PER"))) {
    return(
      Detail837(
        BHT = d[["BHT"]],
        N41 = d[[2L]],
        P41 = NA_character_,
        N40 = d[[3L]],
        P40 = d[[4L]]
      )
    )
  }
  if (identical(n, c("NM1", "PER", "NM1", "PER"))) {
    return(
      Detail837(
        BHT = d[["BHT"]],
        N41 = d[[2L]],
        P41 = d[[3L]],
        N40 = d[[4L]],
        P40 = d[[5L]]
      )
    )
  }
}

#' @noRd
detail_834 <- function(x) {
  d <- subset_(x, S7::prop(x, "Details"), TRUE)
  n <- names(purrr::map_chr(d, 1L)[2:length(d)])

  if (identical(n, c("N1", "N1"))) {
    return(
      Detail834(
        BGN = d[["BGN"]],
        REF = NA_character_,
        DTP = NA_character_,
        QTY = NA_character_,
        NP5 = d[[2L]],
        NIN = d[[3L]]
      )
    )
  }

  if (identical(n, c("REF", "N1", "N1"))) {
    return(
      Detail834(
        BGN = d[["BGN"]],
        REF = d[["REF"]],
        DTP = NA_character_,
        QTY = NA_character_,
        NP5 = d[[3L]],
        NIN = d[[4L]]
      )
    )
  }

  if (identical(n, c("QTY", "N1", "N1"))) {
    return(
      Detail834(
        BGN = d[["BGN"]],
        REF = NA_character_,
        DTP = NA_character_,
        QTY = d[["QTY"]],
        NP5 = d[[3L]],
        NIN = d[[4L]]
      )
    )
  }
  if (identical(n, c("REF", "DTP", "N1", "N1"))) {
    return(
      Detail834(
        BGN = d[["BGN"]],
        REF = d[["REF"]],
        DTP = d[["DTP"]],
        QTY = NA_character_,
        NP5 = d[[4L]],
        NIN = d[[5L]]
      )
    )
  }
}

#' @noRd
detail_306 <- function(x) {
  d <- subset_(x, S7::prop(x, "Details"), TRUE)
  n <- unname(purrr::map_chr(d, 1L)[3:length(d)])

  if (identical(n, c("38", "TV", "PE", "RM"))) {
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
  if (identical(n, c("PE", "RM", "IC"))) {
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

  if (identical(n, c("N1", "N1"))) {
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

  if (identical(n, c("N1", "N3", "N4", "N1"))) {
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

  if (identical(n, c("N1", "N1", "N3", "N4"))) {
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

  if (identical(n, c("N1", "N3", "N4", "N1", "N3", "N4"))) {
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
