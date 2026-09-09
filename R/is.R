#' @noRd
is_dual_any <- function(dual_code) {
  dual_code %in_% DUAL_CODES$ANY
}

#' @noRd
is_dual_valid <- function(dual_code) {
  dual_code %in_% DUAL_CODES$VALID
}

#' @noRd
is_full <- function(dual_code) {
  dual_code %in_% DUAL_CODES$FULL
}

#' @noRd
is_partial <- function(dual_code) {
  dual_code %in_% DUAL_CODES$PARTIAL
}

#' @noRd
is_esrd <- function(rec_code) {
  rec_code %in_% REC_CODES$ESRD
}

#' @noRd
has_esrd <- function(orec_code, crec_code) {
  any_(is_esrd(c(orec_code, crec_code)))
}

#' @noRd
is_male <- function(sex) {
  sex %in_% SEX$MALE
}

#' @noRd
is_female <- function(sex) {
  sex %in_% SEX$FEMALE
}
