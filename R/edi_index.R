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
#' edi_index(x12_EX$`834`)
#' edi_index(purrr::list_flatten(x12_EX$`820`)[1:5])
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

S7::method(edi_index, IndexEDI) <- function(x) {
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
  #   new_index(
  #     x,
  #     switch(
  #       S7::prop(x, "Type"),
  #       "837I-X223" = ind_837I(S7::prop(x, "Text")),
  #       "837P-X222" = ind_837P(S7::prop(x, "Text"))
  #     )
  #   )
}

#' @noRd
split_interval <- function(index, breaks) {
  vctrs::vec_split(
    index,
    findInterval(
      index,
      sort.int(breaks),
      all.inside = TRUE
    )
  )
}

#' @noRd
index_820 <- function(x) {
  ST <- charr::str_which(x, "^ST")
  SE <- charr::str_which(x, "^SE")
  ISA <- charr::str_which(x, "ISA\\*")
  IEA <- charr::str_which(x, "^IEA")

  ENT <- charr::str_which(x, "^ENT")
  RMR <- charr::str_which(x, "^RMR")

  v <- split_interval(
    cheapr::seq_(ENT[1L], SE - 1L),
    c(ENT, RMR, SE - 1L)
  )
  n <- purrr::map_depth(v$val, 1L, \(y) charr::str_sub(x[y], 1L, 7L))

  rlang::list2(
    header = cheapr::seq_(ISA, ST),
    details = cheapr::seq_(ST + 1L, ENT[1L] - 1L),
    entity = purrr::map2(v$val, n, \(s, e) rlang::set_names(s, e)),
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

  v <- split_interval(
    cheapr::seq_(INS[1L], SE - 1L),
    c(INS, REF0F, NM1, HD, SE - 1L)
  )
  n <- purrr::map_depth(v$val, 1L, \(y) charr::str_sub(x[y], 1L, 7L))

  rlang::list2(
    header = cheapr::seq_(ISA, ST),
    details = cheapr::seq_(ST + 1L, INS[1L] - 1L),
    member = purrr::map2(v$val, n, \(s, e) rlang::set_names(s, e)),
    trailer = cheapr::seq_(SE, IEA)
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
