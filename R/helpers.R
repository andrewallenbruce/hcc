#' Map Codes to Dual Eligibility Codes
#'
#' @description
#' Map California Medi-Cal aid codes or Medicare status codes to CMS Dual
#' Eligibility codes
#'
#' @param code `<chr>` Medi-Cal aid code or Medicare status code
#' @returns Dual eligibility code ('01'-'08') or NA if not found
#' @examplesIf FALSE
#' map_to_dual(c("QMB", "QMBONLY", "SLMB+", "QQQ"))
#' map_to_dual(c("4N", "5B", "40"))
#' @noRd
map_to_dual <- function(code) {
  from <- c(MEDICARE_STATUS_CODE_MAPPING, MEDI_CAL_AID_CODES)
  unlist_(from)[collapse::fmatch(normalize_(code), names(from))]
}

#' @noRd
is_dual_any <- function(dual_code) {
  dual_code %in_% DUAL_CODES$ANY
}

#' @noRd
is_dual_valid <- function(dual_code) {
  dual_code %in_% DUAL_CODES$VALID
}

#' @noRd
is_dual_full <- function(dual_code) {
  dual_code %in_% DUAL_CODES$FULL
}

#' @noRd
is_dual_partial <- function(dual_code) {
  dual_code %in_% DUAL_CODES$PARTIAL
}

#' @noRd
is_esrd <- function(rec_code) {
  rec_code %in_% REC_CODES$ESRD
}

#' @noRd
has_esrd <- function(orec_code, crec_code) {
  any(is_esrd(c(orec_code, crec_code)))
}

#' @noRd
convert_sex <- function(
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
is_male <- function(sex) {
  sex %in_% SEX$MALE
}

#' @noRd
is_female <- function(sex) {
  sex %in_% SEX$FEMALE
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
age_category_NEW <- function(age, sex, orec_code) {
  prefix <- if (sex == "2") "NEF" else "NEM"
  orec_code <- if (cheapr::is_na(orec_code)) "0" else orec_code

  vctrs::vec_case_when(
    conditions = list(
      in_between(age, 0L, 34L),
      in_between(age, 35L, 44L),
      in_between(age, 45L, 54L),
      in_between(age, 55L, 59L),
      in_between(age, 60L, 64L) | (age == 64L & !identical(orec_code, "0")),
      (age == 64L & identical(orec_code, "0")) | age == 65L,
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

#' @noRd
age_category <- function(
  version,
  new_enrollee,
  has_esrd,
  age,
  sex,
  orec_code
) {
  switch(
    version,
    "V2" = ,
    "V4" = {
      if (new_enrollee & !has_esrd) {
        age_category_NEW(age, sex, orec_code)
      } else {
        age_category_ESRD(age, sex)
      }
    },
    "V6" = age_category_V6(age, sex)
  )
}
