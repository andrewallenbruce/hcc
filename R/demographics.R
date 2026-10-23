#' Categorize a beneficiary's demographics into risk adjustment categories.
#'
#' This function takes demographic information about a beneficiary and returns a
#' Demographics object containing derived fields used in risk adjustment models.
#'
#' @param ver `<chr>` Version of categorization; default is `V2`
#' @param age `<num>` Beneficiary age
#' @param sex `<chr>` Beneficiary sex (`M`/`1` or `F`/`2`)
#' @param dual `<chr>` Dual eligibility code (`00` - `10`)
#' @param orec,crec `<chr>` Original/Current reason for entitlement code:
#'    - `0`: Old Age and Survivors Insurance (OASI)
#'    - `1`: Disability Insurance Benefits (DIB)
#'    - `2`: ESRD - End-Stage Renal Disease
#'    - `3`: DIB and ESRD
#' @param new_enrollee `<lgl>` Beneficiary is a New Enrollee
#' @param snp `<lgl>` Beneficiary is in a Special Needs Plan
#' @param low_income `<lgl>` Beneficiary is Low Income (RxHCC only)
#' @param lti `<lgl>` Beneficiary is Long-Term Institutionalized
#' @param months `<int>` Number of months since transplant (ESRD only)
#' @param prefix `<chr>` Optional prefix to override demographic
#'   detection (e.g., `DI_`, `DNE_`, `INS_`, `CFA_`, etc.)
#' @returns A `<PatientDemographics>` S7 object
#' @examples
#' demographics(age = 48, sex = "1")
#' demographics(age = 35, sex = "M", ver = "V6")
#' demographics(age = 75, sex = "2", orec = 0)
#' @export
demographics <- function(
  age,
  sex,
  ver = "V2",
  dual = NA_character_,
  orec = NA_integer_,
  crec = NA_integer_,
  new_enrollee = FALSE,
  snp = FALSE,
  low_income = FALSE,
  lti = FALSE,
  months = 0,
  prefix = NULL
) {
  rlang::check_number_decimal(age, min = 0, max = 150)
  rlang::check_number_whole(months, min = 0)
  version <- rlang::arg_match0(ver, c("V2", "V4", "V6"))
  check_number_whole(orec, min = 0, max = 3, allow_na = TRUE)
  check_number_whole(crec, min = 0, max = 3, allow_na = TRUE)

  if (!cheapr::is_na(dual)) {
    rlang::arg_match(dual, DUAL_CODES$VALID)
  }

  rlang::check_bool(new_enrollee)
  rlang::check_bool(snp)
  rlang::check_bool(low_income)
  rlang::check_bool(lti)

  esrd <- has_esrd(orec, crec)
  full <- is_full(dual)
  part <- is_partial(dual)

  # Override demographics based on prefix
  if (!is.null(prefix)) {
    if (is_prefix_esrd(prefix)) {
      esrd <- TRUE
    }
    if (is_prefix_new_enrollee(prefix)) {
      new <- TRUE
    } else if (is_prefix_comm_lti(prefix)) {
      new <- FALSE
    }

    if (is_prefix_dual_full(prefix)) {
      .c(full, part) %=% c(TRUE, FALSE)
    } else if (is_prefix_dual_partial(prefix)) {
      .c(full, part) %=% c(FALSE, TRUE)
    } else if (is_prefix_non_dual(prefix)) {
      .c(full, part) %=% c(FALSE, FALSE)
    }

    if (is_prefix_lti(prefix)) {
      lti <- TRUE
    }
  }

  sex <- convert_sex(sex, version)
  non <- age <= 64L

  # Determine if currently disabled or previously disabled
  current <- non & orec %in_% 1:3
  previous <- orec %in_% 1 & !current

  PatientDemographics(
    version = ver,
    age = age,
    sex = sex,
    dual_code = dual,
    orec_code = orec,
    crec_code = crec,
    non_aged = non,
    new_enrollee = new_enrollee,
    has_snp = snp,
    dis_orig = previous,
    dis_curr = current,
    dual_full = full,
    dual_part = part,
    has_esrd = esrd,
    is_lti = lti,
    low_income = low_income,
    esrd_months = months,
    category = categorize_age(
      age = age,
      sex = sex,
      ver = ver,
      orec = orec,
      new = new_enrollee,
      esrd = esrd
    )
  )
}

#' @noRd
age_V6 <- function(age, sex) {
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
age_ESRD <- function(age, sex) {
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
age_NEW <- function(age, sex, orec) {
  check_number_whole(orec, min = 0, max = 3, allow_na = TRUE)

  if (cheapr::is_na(orec)) {
    orec <- 0L
  }

  prefix <- if (sex == "2") "NEF" else "NEM"
  aged__ <- orec == 0L

  label <- vctrs::vec_case_when(
    conditions = list(
      in_between(age, 0L, 34L),
      in_between(age, 35L, 44L),
      in_between(age, 45L, 54L),
      in_between(age, 55L, 59L),
      in_between(age, 60L, 64L) | (age == 64L & !aged__),
      (age == 64L & aged__) | age == 65L,
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

#' Map Patient Age to Category Interval
#'
#' @param age `<int>` Beneficiary age
#' @param sex `<chr>` Beneficiary sex (`M`/`1` or `F`/`2`)
#' @param orec `<chr>` Original Reason for Entitlement Code (`0` - `3`)
#' @param ver `<chr>` Version of categorization to use (`V2`, `V4`, `V6`)
#' @param new `<lgl>` Beneficiary is a **New Enrollee**
#' @param esrd `<lgl>` Beneficiary has **End Stage Renal Disease**
#' @returns Category label for age range
#' @examplesIf FALSE
#' categorize_age(64, "F", "V2", 1, TRUE, FALSE)
#' @noRd
categorize_age <- function(age, sex, ver, orec, new, esrd) {
  rlang::check_number_whole(age, min = 0, max = 150)
  rlang::check_bool(new)
  rlang::check_bool(esrd)

  switch(
    rlang::arg_match0(ver, c("V2", "V4", "V6")),
    "V2" = ,
    "V4" = {
      if (new & !esrd) {
        age_NEW(age, sex, orec)
      } else {
        age_ESRD(age, sex)
      }
    },
    "V6" = age_V6(age, sex)
  )
}

AGES = list(
  V6 = list(
    RANGE = ivs::iv_pairs(
      c(0L, 1L),
      c(1L, 2L),
      c(2L, 5L),
      c(5L, 10L),
      c(10L, 15L),
      c(15L, 21L),
      c(21L, 25L),
      c(25L, 30L),
      c(30L, 35L),
      c(35L, 40L),
      c(40L, 45L),
      c(45L, 50L),
      c(50L, 55L),
      c(55L, 60L),
      c(60L, 105L)
    ),
    LABEL = c(
      "0_0",
      "1_1",
      "2_4",
      "5_9",
      "10_14",
      "15_20",
      "21_24",
      "25_29",
      "30_34",
      "35_39",
      "40_44",
      "45_49",
      "50_54",
      "55_59",
      "60_GT"
    )
  ),
  ESRD = list(
    RANGE = ivs::iv_pairs(
      c(0L, 35L),
      c(35L, 45L),
      c(45L, 55L),
      c(55L, 60L),
      c(60L, 65L),
      c(65L, 70L),
      c(70L, 75L),
      c(75L, 80L),
      c(80L, 85L),
      c(85L, 90L),
      c(90L, 95L),
      c(95L, 105L)
    ),
    LABEL = c(
      "0_34",
      "35_44",
      "45_54",
      "55_59",
      "60_64",
      "65_69",
      "70_74",
      "75_79",
      "80_84",
      "85_89",
      "90_94",
      "95_GT"
    )
  ),
  NEW = list(
    LABEL = c(
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
    )
  )
)
