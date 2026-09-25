#' @noRd
sort_index <- function(i) {
  i <- cheapr::sset(i, whichv_(collapse::vlengths(i, FALSE), 0L, TRUE))
  i[names(sort.int(purrr::map_int(i, \(x) x[1])))]
}

#' @noRd
parsing_problems <- function(x, i) {
  if (length(x) != cheapr::unlisted_length(i)) {
    cheapr::setdiff_(seq_along(x), unlist_(i))
  } else {
    0L
  }
}

#' @noRd
new_X12Index <- function(x, text, index, type) {
  index <- sort_index(index)

  X12Index(
    type = type,
    segments = cheapr::unlisted_length(index),
    problems = parsing_problems(x, index),
    index = index,
    text = x
  )
}

#' X12 Indexer
#'
#' @param text `<chr>` string of raw X12-820 text
#' @returns `<hcc::X12Index>` S7 object
#' @examples
#' purrr::map(
#'   c(hcc::x12_820,
#'     hcc::x12_834,
#'     hcc::x12_837I,
#'     hcc::x12_837P
#'    ),
#'    index_x12
#'  )
#' @export
index_x12 <- function(text) {
  text <- check_text_(text)
  xtype <- x12_type(text)

  VALID_TYPES <- c(
    "820-X306",
    "820-X218",
    "834-X220",
    "837I-X223",
    "837P-X222"
  )

  if (xtype %!in_% VALID_TYPES || cheapr::is_na(xtype)) {
    return(NA)
  }

  x <- tilde(text)

  i <- switch(
    xtype,
    "820-X306" = index_820_x306(x),
    "820-X218" = index_820_x218(x),
    "834-X220" = index_834_x220(x),
    "837I-X223" = index_837I_x223(x),
    "837P-X222" = index_837P_x222(x)
  )

  new_X12Index(
    x = x,
    text = text,
    index = i,
    type = xtype
  )
}
