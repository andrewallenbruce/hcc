#' @noRd
perl <- function(x, rex, negate = FALSE) {
  grep(pattern = rex, x = x, perl = TRUE, invert = negate)
}

#' @noRd
perl0 <- function(x, rex, ...) {
  grepl(pattern = rex, x = x, perl = TRUE, ...)
}

#' @noRd
unlist_ <- function(x, ...) {
  unlist(x, use.names = FALSE, ...)
}

#' @noRd
mult_ <- function(...) {
  collapse::fprod(c(...))
}

#' @noRd
any_ <- function(x) {
  collapse::anyv(x, TRUE)
}

#' @noRd
normalize_ <- function(x) {
  toupper(
    gsub("-", "", gsub(" ", "", x, fixed = TRUE), fixed = TRUE)
  )
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

#' Is any HCC present?
#'
#' @param needles `<int>` hcc(s) being searched for
#' @param haystack `<int>` hcc(s) being searched in
#' @returns `<int>` scalar, `1` (True), `0` (False)
#' @examplesIf FALSE
#' any_hcc(17:19, 18:21)
#' any_hcc(17:19, 20:22)
#' @noRd
any_hcc <- function(needles, haystack) {
  as.integer(any_(needles %in_% haystack))
}

#' Creates HCC count variables
#'
#' @param hcc hcc
#' @returns a named `<int>` vector of counts
#' @examplesIf FALSE
#' hcc_count(17:19)
#' hcc_count(c(17:19, 85L))
#' @noRd
hcc_count <- function(hcc) {
  L <- length(hcc)
  rlang::check_number_whole(L, min = 1)
  if (L <= 9L) {
    return(cheapr::paste_("D", L))
  }
  if (L >= 10L) {
    return("D10P")
  }
}

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
  from <- c(DUAL_CODES$MAP_STATUS, DUAL_CODES$MAP_AID)
  unlist_(from)[collapse::fmatch(normalize_(code), names(from))]
}

#' Map Patient Age to Category Interval
#'
#' @param version `<chr>` Version of categorization to use (`V2`, `V4`, `V6`)
#' @param new_enrollee `<lgl>`
#' @param has_esrd `<lgl>`
#' @param age `<int>` Beneficiary age
#' @param sex `<chr>` Beneficiary sex (`M`/`1` or `F`/`2`)
#' @param orec_code `<chr>` Original reason for entitlement code (`0` - `3`)
#' @returns Category label for age range
#' @examplesIf FALSE
#' categorize_age("V2", TRUE, FALSE, 64, "F", "1")
#' @noRd
categorize_age <- function(
  version,
  new_enrollee,
  has_esrd,
  age,
  sex,
  orec_code
) {
  version <- rlang::arg_match0(version, c("V2", "V4", "V6"))

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
    "V4" = unname(SEX$V2[sex]), # CMS format
    "V6" = unname(SEX$V6[sex])
  )
}

#' @noRd
age_category_V6 <- function(age, sex) {
  if (!ivs::iv_between(age, AGES$V6$RANGE)) {
    return(NA)
  }
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
  if (!ivs::iv_between(age, AGES$ESRD$RANGE)) {
    return(NA)
  }

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
  orec_zero <- identical(orec_code, "0")

  label <- vctrs::vec_case_when(
    conditions = list(
      in_between(age, 0L, 34L),
      in_between(age, 35L, 44L),
      in_between(age, 45L, 54L),
      in_between(age, 55L, 59L),
      in_between(age, 60L, 64L) | (age == 64L & !orec_zero),
      (age == 64L & orec_zero) | age == 65L,
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
      "0_34",
      "35_44",
      "45_54",
      "55_59",
      "60_64",
      "65",
      "66",
      "67",
      "68",
      "69",
      "70_74",
      "75_79",
      "80_84",
      "85_89",
      "95_GT",
      NA
    ),
    default = NA
  )

  if (cheapr::is_na(label)) {
    return(label)
  }
  paste0(prefix, label)
}
