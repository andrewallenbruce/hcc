#' @noRd
unlist_ <- function(x, ...) {
  unlist(x, use.names = FALSE, ...)
}

#' @noRd
normalize_status <- function(status) {
  toupper(gsub("-", "", gsub(" ", "", status, fixed = TRUE), fixed = TRUE))
}

#' Is x Between a Minimum and a Maximum?
#'
#' @param x `<int>` vector of candidates
#' @param min `<int>` Minimum value (inclusive)
#' @param max `<int>` Maximum value (inclusive)
#' @returns `<lgl>` vector indicating membership
#' @examplesIf FALSE
#' in_between(5L, 10L, 15L)
#' in_between(1L, 2L, 3L)
#' in_between(0L, 5L, 10L)
#' in_between(0:15, 5L, 10L)
#' @export
in_between <- function(x, min, max) {
  (x - min) * (max - x) >= 0L
}

#' Dual Eligibility Code Checks
#' @param dual_code `<chr>` Dual eligibility code ("00" - "10")
#' @returns `<lgl>` vector indicating membership
#' @name is_dual
NULL

#' @rdname is_dual
#' @examples
#' is_dual_any(c("02", "04", "08"))
#' @export
is_dual_any <- function(dual_code) {
  dual_code %in_% DUAL_CODES$ANY
}

#' @rdname is_dual
#' @examples
#' is_dual_valid(c("02", "04", "08"))
#' @export
is_dual_valid <- function(dual_code) {
  dual_code %in_% DUAL_CODES$VALID
}

#' @rdname is_dual
#' @examples
#' is_dual_full(c("02", "04", "08"))
#' @export
is_dual_full <- function(dual_code) {
  dual_code %in_% DUAL_CODES$FULL
}

#' @rdname is_dual
#' @examples
#' is_dual_partial(c("01", "03", "05", "06"))
#' @export
is_dual_partial <- function(dual_code) {
  dual_code %in_% DUAL_CODES$PARTIAL
}

#' Check if OREC/CREC indicates ESRD status
#' @param rec_code OREC/CREC code
#' @returns logical
#' @examples
#' is_esrd(c("2", "3"))
#' @export
is_esrd <- function(rec_code) {
  rec_code %in_% REC_CODES$ESRD
}

#' Map Medicare status code to dual eligibility code
#
#' @param status Medicare status code (e.g., 'QMB Plus', 'SLMB', 'QI')
#' @returns Dual eligibility code ('01'-'08') or '00' if not found
#' @examples
#' x <- c("QQQ", "QMB", "QMBONLY", "SLMBPLUS", "SLMB+", "QDWI", "QI", "QI1")
#' map_medicare_status_to_dual_code(x)
#' @export
map_medicare_status_to_dual_code <- function(status) {
  i <- collapse::fmatch(
    normalize_status(status),
    names(MEDICARE_STATUS_CODE_MAPPING)
  )

  x <- unlist_(MEDICARE_STATUS_CODE_MAPPING)[i]

  if (anyNA(x)) {
    collapse::setv(x, collapse::whichNA(x), DUAL_CODES$NON_DUAL)
  }
  return(x)
}

#' Map California Medi-Cal Aid Code to Dual Eligibility Code
#'
#' @param aid_code California aid code (e.g., '4N', '5B')
#' @returns Dual eligibility code ('01'-'08') or '00' if not found
#' @examples
#' map_aid_code_to_dual_status(c("4N", "5B"))
#' @export
map_aid_code_to_dual_status <- function(aid_code) {
  i <- collapse::fmatch(aid_code, names(MEDI_CAL_AID_CODES))
  x <- unlist_(MEDI_CAL_AID_CODES)[i]

  if (anyNA(x)) {
    collapse::setv(x, collapse::whichNA(x), DUAL_CODES$NON_DUAL)
  }
  return(x)
}
