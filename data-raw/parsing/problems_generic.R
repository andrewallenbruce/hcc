#' Extract Problems from X12 Indices
#' @param x `<X12Index>` S7 object
#' @param ... dots
#' @returns a character vector of interactions
#' @examples
#' idx9 = index_x12(hcc::x12_837I$sample_837_9)
#' problems(idx9)
#' @export
#' @name problems
problems := S7::new_generic("x")

S7::method(problems, S7::class_any) <- function(x) {
  return(NA)
}

S7::method(problems, S7::class_list) <- function(x) {
  purrr::map(x, problems)
}

S7::method(problems, X12Index) <- function(x) {
  .subset(x@text, x@problems)
}
