#' Create an EDI Index Object
#'
#' @details
#' Methods for `edi_index`:
#' `r doclisting::methods_list("edi_index")`
#'
#'
#' @param x raw X12 text input
#' @param ... dots
#' @returns an `<hcc::IndexEDI>` S7 object
#' @examples
#' edi_index(x12_EX$`820`$`218`[1:5])
#' edi_index(x12_EX$`834`)
#' edi_index(x12_EX$`837`)
#' @export
#' @name edi_index
edi_index := S7::new_generic("x")

S7::method(edi_index, S7::class_any) <- function(x) {
  cli::cli_alert_warning(
    "No {.fn hcc::edi_index} method found for {.obj_type_friendly {x}}",
    call = rlang::caller_env()
  )
  return(NA)
}

S7::method(edi_index, Index820 | Index834 | Index837) <- function(x) {
  return(x)
}

S7::method(edi_index, S7::class_list) <- function(x) {
  purrr::map(edi_text(x), edi_index)
}

S7::method(edi_index, S7::class_character) <- function(x) {
  edi_index(edi_text(x))
}

S7::method(edi_index, Text820) <- function(x) {
  i <- index_820(S7::prop(x, "Text"))
  S7::convert(
    x,
    Index820,
    Problems = problems(x, i),
    Header = i[["header"]],
    Details = i[["details"]],
    Entity = i[["entity"]],
    Trailer = i[["trailer"]]
  )
}

S7::method(edi_index, Text834) <- function(x) {
  i <- index_834(S7::prop(x, "Text"))
  S7::convert(
    x,
    Index834,
    Problems = problems(x, i),
    Header = i[["header"]],
    Details = i[["details"]],
    Member = i[["member"]],
    Trailer = i[["trailer"]]
  )
}

S7::method(edi_index, Text837) <- function(x) {
  i <- index_837(S7::prop(x, "Text"))
  S7::convert(
    x,
    Index837,
    Problems = problems(x, i),
    Header = i[["header"]],
    Details = i[["details"]],
    Claims = i[["claims"]],
    Trailer = i[["trailer"]]
  )
}

#' @noRd
problems <- function(x, i) {
  if (length(S7::prop(x, "Text")) != cheapr::unlisted_length(i)) {
    cheapr::setdiff_(seq_along(S7::prop(x, "Text")), unlist_(i))
  } else {
    NA_integer_
  }
}

#' @noRd
split_interval <- function(x, start, end, breaks) {
  ind <- cheapr::seq_(from = start, to = end)

  vec <- vctrs::vec_split(
    ind,
    findInterval(
      ind,
      sort.int(breaks),
      all.inside = TRUE
    )
  )

  purrr::map2(
    vec$val,
    purrr::map_depth(vec$val, 1L, function(y) {
      cheapr::if_else_(
        charr::str_starts(x[y], "ENT"),
        charr::str_remove_all(charr::str_sub(x[y], 1L, 6L), "\\*"),
        charr::str_remove_all(charr::str_sub(x[y], 1L, 7L), "\\*$")
      )
    }),
    function(s, e) {
      rlang::set_names(s, e)
    }
  )
}

#' @noRd
split_interval2 <- function(x, start, end, break1, break2) {
  init <- cheapr::seq_(from = start, to = end)

  vec <- vctrs::vec_split(
    init,
    findInterval(
      init,
      sort.int(break1),
      all.inside = TRUE
    )
  )$val

  vec <- purrr::map(vec, \(index) {
    vctrs::vec_split(
      index,
      findInterval(index, sort.int(break2), all.inside = TRUE)
    )$val
  })

  purrr::map_depth(vec, 2L, function(y) {
    rlang::set_names(
      y,
      cheapr::if_else_(
        charr::str_starts(x[y], "ENT"),
        charr::str_remove_all(charr::str_sub(x[y], 1L, 6L), "\\*"),
        charr::str_remove_all(charr::str_sub(x[y], 1L, 7L), "\\*$")
      )
    )
  })
}

#' @noRd
index_820 <- function(x) {
  ST <- charr::str_which(x, "^ST")
  SE <- charr::str_which(x, "^SE")
  ISA <- charr::str_which(x, "ISA\\*")
  IEA <- charr::str_which(x, "^IEA")

  ENT <- charr::str_which(x, "^ENT")
  RMR <- charr::str_which(x, "^RMR")

  rlang::list2(
    header = cheapr::seq_(ISA, ST),
    details = cheapr::seq_(ST + 1L, ENT[1L] - 1L),
    entity = split_interval2(
      x = x,
      start = ENT[1L],
      end = SE - 1L,
      break1 = c(ENT, SE - 1L),
      break2 = c(ENT, RMR, SE - 1L)
    ),
    trailer = cheapr::seq_(SE, IEA)
  )
}

#' @noRd
index_834 <- function(x) {
  ST <- charr::str_which(x, "^ST")
  SE <- charr::str_which(x, "^SE")
  ISA <- charr::str_which(x, "ISA\\*")
  IEA <- charr::str_which(x, "^IEA")

  HD <- charr::str_which(x, "^HD\\*")
  INS <- charr::str_which(x, "^INS")
  NM1 <- charr::str_which(x, "^NM1\\*")
  REF0F <- charr::str_which(x, "^REF\\*0F")

  rlang::list2(
    header = cheapr::seq_(ISA, ST),
    details = cheapr::seq_(ST + 1L, INS[1L] - 1L),
    member = split_interval(
      x,
      INS[1L],
      SE - 1L,
      c(INS, REF0F, NM1, HD, SE - 1L)
    ),
    trailer = cheapr::seq_(SE, IEA)
  )
}

#' @noRd
index_837 <- function(x) {
  ST <- charr::str_which(x, "^ST")
  SE <- charr::str_which(x, "^SE")
  ISA <- charr::str_which(x, "ISA\\*")
  IEA <- charr::str_which(x, "^IEA")

  HL <- charr::str_which(x, "^HL\\*")
  CLM <- charr::str_which(x, "^CLM")
  LX <- charr::str_which(x, "^LX\\*")

  rlang::list2(
    header = cheapr::seq_(ISA, ST),
    details = cheapr::seq_(ST + 1L, HL[1L] - 1L),
    claims = split_interval(
      x,
      HL[1L],
      SE - 1L,
      c(HL, CLM, LX, SE - 1L)
    ),
    trailer = cheapr::seq_(SE, IEA)
  )
}
