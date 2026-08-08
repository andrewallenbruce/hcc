#' @noRd
unlist_ <- function(x, ...) {
  unlist(x, use.names = FALSE, ...)
}

#' @noRd
normalize_ <- function(x) {
  toupper(gsub("-", "", gsub(" ", "", x, fixed = TRUE), fixed = TRUE))
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
#' @noRd
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

#' Map Codes to Dual Eligibility Codes
#'
#' @description
#' Map California Medi-Cal aid codes or Medicare status codes to CMS Dual Eligibility codes
#'
#' @param code `<chr>` Medi-Cal aid code or Medicare status code
#' @param from `<chr>` Type of code; "medicare" or "medicalaid"
#' @returns Dual eligibility code ('01'-'08') or NA if not found
#' @examples
#' map_to_dual(c("QMB", "QMBONLY", "SLMB+", "QQQ"), "medicare")
#' map_to_dual(c("4N", "5B", "40"), "medicalaid")
#' @export
map_to_dual <- function(code, from = c("medicare", "medicalaid")) {
  from <- switch(
    rlang::arg_match(from),
    medicare = MEDICARE_STATUS_CODE_MAPPING,
    medicalaid = MEDI_CAL_AID_CODES,
  )
  unlist_(from)[collapse::fmatch(normalize_(code), names(from))]
}
