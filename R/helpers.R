#' Check if x is between min and max (inclusive)
#'
#' @param x `<int>` Integer vector to check
#' @param min `<int>` Minimum value (inclusive)
#' @param max `<int>` Maximum value (inclusive)
#' @returns Logical vector indicating if each element of x is between min and max
#' @examples
#' in_between(5L, 10L, 15L)
#' in_between(1L, 2L, 3L)
#' in_between(0L, 5L, 10L)
#' @export
in_between <- function(x, min, max) {
  (x - min) * (max - x) >= 0L
}

#' Check if dual eligibility code is Full Benefit Dual
#' @param dual_code description
#' @returns logical
#' @examples
#' is_full_benefit_dual(c("02", "04", "08"))
#' @export
is_full_benefit_dual <- function(dual_code) {
  dual_code %in_% FULL_BENEFIT_DUAL_CODES
}

#' Check if dual eligibility code is Partial Benefit Dual
#' @param dual_code description
#' @returns logical
#' @examples
#' is_partial_benefit_dual(c("01", "03", "05", "06"))
#' @export
is_partial_benefit_dual <- function(dual_code) {
  dual_code %in_% PARTIAL_BENEFIT_DUAL_CODES
}

#' Check if OREC indicates ESRD status
#' @param orec description
#' @returns logical
#' @examples
#' is_esrd_by_orec(c("2", "3"))
#' @export
is_esrd_by_orec <- function(orec) {
  orec %in_% OREC_ESRD_CODES
}

#' Check if CREC indicates ESRD status
#' @param crec description
#' @returns logical
#' @examples
#' is_esrd_by_crec(c("2", "3"))
#' @export
is_esrd_by_crec <- function(crec) {
  crec %in_% CREC_ESRD_CODES
}

#' Normalize Medicare status code (uppercase, no spaces/hyphens)
#' @noRd
normalize_medicare_status_code <- function(status) {
  toupper(gsub("-", "", gsub(" ", "", status, fixed = TRUE), fixed = TRUE))
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
  status <- normalize_medicare_status_code(status)
  i <- collapse::fmatch(status, names(MEDICARE_STATUS_CODE_MAPPING))
  x <- unlist(MEDICARE_STATUS_CODE_MAPPING, use.names = FALSE)[i]
  if (anyNA(x)) {
    x[collapse::whichNA(x)] <- NON_DUAL_CODE
  }
  return(x)
}

#' Map California Medi-Cal aid code to dual eligibility code
#'
#' @param aid_code California aid code (e.g., '4N', '5B')
#' @returns Dual eligibility code ('01'-'08') or '00' if not found
#' @examples
#' map_aid_code_to_dual_status(c("4N", "5B"))
#' @export
map_aid_code_to_dual_status <- function(aid_code) {
  i <- collapse::fmatch(aid_code, names(MEDI_CAL_AID_CODES))
  x <- unlist(MEDI_CAL_AID_CODES, use.names = FALSE)[i]
  if (anyNA(x)) {
    x[collapse::whichNA(x)] <- NON_DUAL_CODE
  }
  return(x)
}
