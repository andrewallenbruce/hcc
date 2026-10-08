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
#' # edi_index(x12_EX$`834`)
#' edi_index(purrr::list_flatten(x12_EX$`820`))
#' @export
#' @name edi_index
edi_index := S7::new_generic("x")

S7::method(edi_index, S7::class_any) <- function(x) {
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
  new_index(
    x,
    switch(
      S7::prop(x, "Type"),
      "837I-X223" = ind_837I(S7::prop(x, "Text")),
      "837P-X222" = ind_837P(S7::prop(x, "Text"))
    )
  )
}

#' @noRd
index_820 <- function(x) {
  ST <- perl(x, "^ST")
  ENT <- perl(x, "^ENT")
  SE <- perl(x, "^SE")

  i <- cheapr::seq_(ENT[1L], SE - 1L)
  b <- sort.int(c(ENT, perl(x, "^RMR"), SE - 1L))
  f <- findInterval(i, b, all.inside = TRUE)
  v <- vctrs::vec_split(i, f)$val
  n <- purrr::map_depth(v, 1L, \(y) substring(x[y], 1L, 7L))

  rlang::list2(
    header = cheapr::seq_(perl(x, "ISA\\*"), ST),
    details = cheapr::seq_(ST + 1L, ENT[1L] - 1L),
    entity = purrr::map2(v, n, \(s, e) rlang::set_names(s, e)),
    trailer = cheapr::seq_(SE, perl(x, "^IEA"))
  )
}

#' @noRd
new_index <- function(x, index) {
  IndexEDI(
    Type = S7::prop(x, "Type"),
    Text = S7::prop(x, "Text"),
    Problems = problems(x, index),
    Index = index
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
index_834 <- function(x) {
  ST <- perl(x, "^ST")
  SE <- perl(x, "^SE")
  INS <- perl(x, "^INS")

  rlang::list2(
    header = fill_(perl(x, "ISA\\*"), ST),
    details = fill_(ST + 1L, INS[1L] - 1L),
    # member = create_entity_index(INS, SE),
    trailer = fill_(SE, perl(x, "^IEA"))
  )
}
