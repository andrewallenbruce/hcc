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
#' @returns Dual eligibility code ('01'-'08') or NA if not found
#' @examples
#' map_to_dual(c("QMB", "QMBONLY", "SLMB+", "QQQ"))
#' map_to_dual(c("4N", "5B", "40"))
#' @export
map_to_dual <- function(code) {
  from <- c(MEDICARE_STATUS_CODE_MAPPING, MEDI_CAL_AID_CODES)
  unlist_(from)[collapse::fmatch(normalize_(code), names(from))]
}

#' @noRd
standardize_sex <- function(
  sex,
  version,
  error_arg = rlang::caller_arg(sex),
  error_call = rlang::caller_env()
) {
  sex <- rlang::arg_match0(
    sex,
    SEX$VALID,
    arg_nm = error_arg,
    error_call = error_call
  )

  switch(
    version,
    "V2" = ,
    "V4" = unname(SEX$V2[sex]),
    "V6" = unname(SEX$V6[sex]),
  )
}

#' @noRd
age_category_V6 <- function(age, sex) {
  paste0(
    sex,
    "AGE_LAST_",
    AGES$V6$LABEL[
      ivs::iv_locate_between(age, AGES$V6$RANGE)$haystack
    ]
  )
}

#' @noRd
age_category_ESRD <- function(age, sex) {
  paste0(
    if (sex == "2") "F" else "M",
    AGES$ESRD$LABEL[
      ivs::iv_locate_between(age, AGES$ESRD$RANGE)$haystack
    ]
  )
}

#' @noRd
age_category_NEW <- function(age, sex, orec) {
  prefix <- if (sex == "2") "NEF" else "NEM"
  orec <- if (cheapr::is_na(orec)) "0" else orec

  vctrs::vec_case_when(
    conditions = list(
      in_between(age, 0L, 34L),
      in_between(age, 35L, 44L),
      in_between(age, 45L, 54L),
      in_between(age, 55L, 59L),
      in_between(age, 60L, 64L) | (age == 64L & !identical(orec, "0")),
      (age == 64L & identical(orec, "0")) | age == 65L,
      age == 66L,
      age == 67L,
      age == 68L,
      age == 69L,
      in_between(age, 70L, 74L),
      in_between(age, 75L, 79L),
      in_between(age, 80L, 84L),
      in_between(age, 85L, 89L),
      age >= 95L,
      vctrs::vec_detect_missing(age)
    ),
    values = list(
      paste0(prefix, "0_34"),
      paste0(prefix, "35_44"),
      paste0(prefix, "45_54"),
      paste0(prefix, "55_59"),
      paste0(prefix, "60_64"),
      paste0(prefix, "65"),
      paste0(prefix, "66"),
      paste0(prefix, "67"),
      paste0(prefix, "68"),
      paste0(prefix, "69"),
      paste0(prefix, "70_74"),
      paste0(prefix, "75_79"),
      paste0(prefix, "80_84"),
      paste0(prefix, "85_89"),
      paste0(prefix, "95_GT"),
      NA_character_
    ),
    default = NA_character_
  )
}
