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
    Problems = problems(S7::prop(x, "Text"), i),
    Header = i$header,
    Details = i$details,
    Entity = i$entity,
    Trailer = i$trailer
  )
}

S7::method(edi_index, Text834) <- function(x) {
  i <- index_834(S7::prop(x, "Text"))
  S7::convert(
    x,
    Index834,
    Problems = problems(S7::prop(x, "Text"), i),
    Header = i$header,
    Details = i$details,
    Member = i$member,
    Trailer = i$trailer
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
new_index <- function(x, index) {
  IndexEDI(
    Type = S7::prop(x, "Type"),
    Text = S7::prop(x, "Text"),
    Problems = problems(S7::prop(x, "Text"), index),
    Index = index
  )
}

#' @noRd
problems <- function(x, i) {
  if (length(x) != cheapr::unlisted_length(i)) {
    cheapr::setdiff_(seq_along(x), unlist_(i))
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
    member = create_entity_index(INS, SE),
    trailer = fill_(SE, perl(x, "^IEA"))
  )
}

#' @noRd
index_820 <- function(x) {
  ST <- perl(x, "^ST")
  SE <- perl(x, "^SE")
  ENT <- perl(x, "^ENT")
  NM1 <- perl(x, "^NM1") %0% 0L

  if (length(ENT) != length(NM1)) {
    emp <- cheapr::new_integer(length(ENT), seq_along(ENT))
    emp[grep("^NM1", x[ENT + 1L])] <- NM1
    NM1 <- unname(emp)
  }

  rlang::list2(
    header = fill_(perl(x, "ISA\\*"), ST),
    details = fill_(ST + 1L, ENT[1L] - 1L),
    entity = map_entity_index(ENT, SE, NM1),
    trailer = fill_(SE, perl(x, "^IEA"))
  )
}

#' @noRd
create_entity_index <- function(ENT, SE) {
  index <- sort.int(
    c(
      ENT[1L],
      ENT[-1] - 1L,
      ENT[-1],
      SE - 1L
    )
  )

  half <- vctrs::vec_size(index) / 2L
  runs <- vctrs::vec_rep_each(seq(half), rep(2L, half))

  purrr::map(
    vctrs::vec_split(index, runs)$val,
    \(x) fill_(start = x[1], end = x[2])
  )
}

#' @noRd
map_entity_index <- function(ENT, SE, NM1) {
  purrr::map2(
    create_entity_index(ENT, SE),
    as.list(NM1),
    function(x, nm) {
      if (!nm) {
        return(list(x[1], c(x[2:length(x)])))
      }
      list(x[1:2], c(x[3:length(x)]))
    }
  )
}
