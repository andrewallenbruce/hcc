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
unlist_elem <- function(x, i, ...) {
  unlist_(collapse::get_elem(x, elem = i, ...))
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
all_ <- function(x) {
  collapse::allv(x, TRUE)
}

#' @noRd
normalize_ <- function(x) {
  toupper(
    gsub(
      "-",
      "",
      gsub(" ", "", x, fixed = TRUE),
      fixed = TRUE
    )
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
  x <- length(hcc)
  rlang::check_number_whole(x, min = 1)
  if (x <= 9L) {
    return(cheapr::paste_("D", x))
  }
  if (x >= 10L) {
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
  unlist_(from)[collapse::fmatch(normalize_(code), rlang::names2(from))]
}

#' Map Patient Age to Category Interval
#'
#' @param age `<int>` Beneficiary age
#' @param sex `<chr>` Beneficiary sex (`M`/`1` or `F`/`2`)
#' @param orec `<chr>` Original Reason for Entitlement Code (`0` - `3`)
#' @param vers `<chr>` Version of categorization to use (`V2`, `V4`, `V6`)
#' @param new `<lgl>` Beneficiary is a **New Enrollee**
#' @param esrd `<lgl>` Beneficiary has **End Stage Renal Disease**
#' @returns Category label for age range
#' @examplesIf FALSE
#' categorize_age(
#'   age = 64,
#'   sex = "F",
#'   orec = "1",
#'   vers = "V2",
#'   new = TRUE,
#'   esrd = FALSE
#'  )
#' @noRd
categorize_age <- function(age, sex, vers, orec, new, esrd) {
  rlang::check_number_whole(age, min = 0, max = 120)
  rlang::check_bool(new)
  rlang::check_bool(esrd)

  switch(
    vers,
    "V2" = ,
    "V4" = {
      if (new & !esrd) {
        age_category_NEW(age, sex, orec)
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
    if (identical(sex, "2")) "F" else "M",
    AGES$ESRD$LABEL[
      ivs::iv_locate_between(age, AGES$ESRD$RANGE)$haystack
    ]
  )
}

#' @noRd
age_category_NEW <- function(age, sex, orec) {
  orec <- if (cheapr::is_na(orec)) {
    "0"
  } else {
    rlang::arg_match0(orec, REC_CODES$VALID)
  }

  prefix <- if (identical(sex, "2")) "NEF" else "NEM"
  is_aged <- identical(orec, "0")

  label <- vctrs::vec_case_when(
    conditions = list(
      in_between(age, 0L, 34L),
      in_between(age, 35L, 44L),
      in_between(age, 45L, 54L),
      in_between(age, 55L, 59L),
      in_between(age, 60L, 64L) | (age == 64L & !is_aged),
      (age == 64L & is_aged) | age == 65L,
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
    values = as.list(AGES$NEW$LABEL),
    default = NA
  )

  if (cheapr::is_na(label)) {
    return(label)
  }
  paste0(prefix, label)
}

#' Convert YYYYMMDD to ISO YYYY-MM-DD
#' @examplesIf FALSE
#' parse_date("20200202")
#' parse_date("20250108")
#' parse_date("19550315")
#' @noRd
parse_date <- function(x, ...) {
  if (perl0(x, "-")) {
    as.Date(x)
  } else {
    as.Date.character(x, format = "%Y%m%d", ...)
  }
}

#' Convert 6-digit date (YYMMDD) to ISO format
#' @examplesIf FALSE
#' parse_yymmdd("200202")
#' @noRd
parse_yymmdd <- function(x, ...) {
  as.Date.character(x, format = "%y%m%d", ...)
}

#' Parse DTM RD8 Date Range (YYYYMMDD-YYYYMMDD)
#' @examplesIf FALSE
#' parse_date_range("20200202-20200402")
#' @noRd
parse_date_range <- function(x) {
  x <- strsplit(x, "-", fixed = TRUE)[[1]]
  cheapr::c_(parse_date(x[1]), parse_date(x[2]))
}

#' Calculate age from DOB
#' @examplesIf FALSE
#' calculate_age("20200202")
#' calculate_age("1955-03-15", "2025-01-08")
#' calculate_age("1960-08-22", "2025-01-08")
#' @noRd
calculate_age <- function(dob, dos = Sys.Date()) {
  clock::date_count_between(
    parse_date(dob),
    parse_date(dos),
    precision = "year"
  )
}

#' Determine if member is new enrollee
#' (<= 3 months since coverage start)
#' @examplesIf FALSE
#' is_new_enrollee("20200202")
#' is_new_enrollee("2024-11-08", "2025-01-08")
#' is_new_enrollee("2024-10-08", "2025-01-08")
#' is_new_enrollee("2024-09-08", "2025-01-08")
#' is_new_enrollee("2024-01-08", "2025-01-08")
#' @noRd
is_new_enrollee <- function(start, end = Sys.Date()) {
  clock::date_count_between(
    parse_date(start),
    parse_date(end),
    precision = "month"
  ) <=
    3L
}

#' Derive Medi-Cal eligibility status
#' @examplesIf FALSE
#' calculate_age("20200202")
#' calculate_age("1955-03-15", "2025-01-08")
#' calculate_age("1960-08-22", "2025-01-08")
#' @noRd
medi_eligibility_status <- function(
  coverage_end_date,
  report_date = Sys.Date()
) {
  first <- clock::date_start(parse_date(report_date), "month")
  report <- parse_date(coverage_end_date)

  if (report < first) {
    return("Terminated")
  } else {
    return("Active")
  }
}

#' Parse race code from `DMG05`
#'
#' Handles formats like:
#'
#'    - `:RET:2135-2` "Hispanic or Latino"
#'    - `2135-2`: "Hispanic or Latino"
#'    - `2106-3`: "White"
#'
#' @param x Raw race value from DMG segment
#' @examplesIf FALSE
#' parse_race_code(c(":RET:2135-2", "2135-2", "2106-3"))
#' @noRd
parse_race_code <- function(x) {
  x <- strsplit(x, ":", fixed = TRUE)
  o <- x[lengths(x) > 1L][[1]]
  o <- rev(o[nzchar(o)])[1]
  c(o, unlist_(x[lengths(x) == 1L]))
}
