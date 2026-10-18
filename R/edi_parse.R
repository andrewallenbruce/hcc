#' Create an EDI Parse Object
#'
#' @details
#' Methods for `edi_parse`:
#' `r doclisting::methods_list("edi_parse")`
#'
#'
#' @param x raw X12 text input
#' @param ... dots
#' @returns an `<hcc::ParsedEDI>` S7 object
#' @examples
#' edi_parse(x12_EX$`837`[[1]][[1]])
#' edi_parse(x12_EX$`837`[[2]][[1]])
#' edi_parse(x12_EX$`834`[[1]])
#' edi_parse(x12_EX$`820`[[1]][[1]])
#' edi_parse(x12_EX$`820`[[2]][[1]])
#' @export
#' @name edi_parse
edi_parse := S7::new_generic("x")

S7::method(edi_parse, S7::class_any) <- function(x) {
  cli::cli_alert_warning(
    "No {.fn hcc::edi_parse} method found for {.obj_type_friendly {x}}",
    call = rlang::caller_env()
  )
  return(NA)
}

S7::method(edi_parse, Parsed820 | Parsed834 | Parsed837) <- function(x) {
  return(x)
}

S7::method(edi_parse, S7::class_list) <- function(x) {
  purrr::map(edi_index(x), edi_parse)
}

S7::method(edi_parse, S7::class_character) <- function(x) {
  edi_parse(edi_index(x))
}

S7::method(edi_parse, Index820) <- function(x) {
  Parsed820(
    Header = as_header(x),
    Details = switch(
      x@Type,
      "X12 820 (X218)" = as_detail218(x),
      "X12 820 (X306)" = as_detail306(x)
    ),
    Entity = S7::prop(x, "Entity") |>
      purrr::map_depth(2L, \(id) subset_(x, id)),
    Trailer = as_trailer(x)
  )
}

S7::method(edi_parse, Index834) <- function(x) {
  Parsed834(
    Header = as_header(x),
    Details = as_detail834(x),
    Member = purrr::map_depth(
      S7::prop(x, "Member"),
      1L,
      \(index) {
        subset_(x, index)
      }
    ),
    Trailer = as_trailer(x)
  )
}

S7::method(edi_parse, Index837) <- function(x) {
  Parsed837(
    Header = as_header(x),
    Details = subset_(x, S7::prop(x, "Details")),
    Claims = purrr::map_depth(
      S7::prop(x, "Claims"),
      1L,
      \(index) {
        subset_(x, index)
      }
    ),
    Trailer = as_trailer(x)
  )
}

#' @noRd
as_header <- function(x) {
  i <- subset_(x, S7::prop(x, "Header"))
  HeaderEDI(
    ISA = i[[1L]][-1L],
    GS = i[[2L]][-1L],
    ST = i[[3L]][-1L]
  )
}

#' @noRd
as_trailer <- function(x) {
  i <- subset_(x, S7::prop(x, "Trailer"))
  TrailerEDI(
    SE = i[[1L]][-1L],
    GE = i[[2L]][-1L],
    IEA = i[[3L]][-1L]
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
        REF14 = d[[3L]][3L],
        N1PE = d[[4L]][3:5],
        N1PR = d[[5L]][3:5]
      )
    )
  }

  if (length(d) == 9L) {
    return(
      Detail218(
        BPR = d[[1L]][-1L],
        TRN = d[[2L]][-1L],
        REF14 = d[[3L]][3L],
        N1PE = c(d[[4L]][3L], d[[5L]][2L], d[[6L]][-1L]),
        N1PR = c(d[[7L]][3L], d[[8L]][2L], d[[9L]][-1L])
      )
    )
  }
  if (length(d[[4L]]) == 3L) {
    return(
      Detail218(
        BPR = d[[1L]][-1L],
        TRN = d[[2L]][-1L],
        REF14 = d[[3L]][3L],
        N1PE = c(d[[4L]][3L], d[[5L]][2L], d[[6L]][-1L]),
        N1PR = d[[7L]][3:5]
      )
    )
  }
  if (length(d[[4L]]) == 5L) {
    return(
      Detail218(
        BPR = d[[1L]][-1L],
        TRN = d[[2L]][-1L],
        REF14 = d[[3L]][3L],
        N1PE = d[[4L]][3:5],
        N1PR = c(d[[5L]][3L], d[[6L]][2L], d[[7L]][-1L])
      )
    )
  }
}

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
