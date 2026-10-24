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
as_detail306 <- function(x) {
  d <- subset_(x, S7::prop(x, "Details"))
  if (length(d) == 5L) {
    return(
      Detail306(
        BPR = d[[1L]][-1L],
        TRN = d[[2L]][-1L],
        REF38 = NA_character_,
        REFTV = NA_character_,
        N1PE = d[[3L]][3:5],
        N1RM = d[[4L]][3:5],
        PER = d[[5L]][-1L]
      )
    )
  }

  if (length(d) == 6L) {
    return(
      Detail306(
        BPR = d[[1L]][-1L],
        TRN = d[[2L]][-1L],
        REF38 = d[[3L]][3L],
        REFTV = d[[4L]][3L],
        N1PE = d[[5L]][3:5],
        N1RM = d[[6L]][3:5],
        PER = NA_character_
      )
    )
  }
}

#' @noRd
as_detail218 <- function(x) {
  d <- subset_(x, S7::prop(x, "Details"))
  if (length(d) == 5L) {
    return(
      Detail218(
        BPR = d[[1L]][-1L],
        TRN = d[[2L]][-1L],
        REF = d[[3L]][3L],
        NPE = d[[4L]][3:5],
        NPR = d[[5L]][3:5]
      )
    )
  }

  if (length(d) == 9L) {
    return(
      Detail218(
        BPR = d[[1L]][-1L],
        TRN = d[[2L]][-1L],
        REF = d[[3L]][3L],
        NPE = c(d[[4L]][3L], d[[5L]][2L], d[[6L]][-1L]),
        NPR = c(d[[7L]][3L], d[[8L]][2L], d[[9L]][-1L])
      )
    )
  }
  if (length(d[[4L]]) == 3L) {
    return(
      Detail218(
        BPR = d[[1L]][-1L],
        TRN = d[[2L]][-1L],
        REF = d[[3L]][3L],
        NPE = c(d[[4L]][3L], d[[5L]][2L], d[[6L]][-1L]),
        NPR = d[[7L]][3:5]
      )
    )
  }
  if (length(d[[4L]]) == 5L) {
    return(
      Detail218(
        BPR = d[[1L]][-1L],
        TRN = d[[2L]][-1L],
        REF = d[[3L]][3L],
        NPE = d[[4L]][3:5],
        NPR = c(d[[5L]][3L], d[[6L]][2L], d[[7L]][-1L])
      )
    )
  }
}

# payment_order_820_218:     NPE = 1, NPR = 1
# 820_Premium_Payment_NOPMT: NPE = 1, NPR = ALL
# sample_820_01:             NPE = ALL, NPR = ALL
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
