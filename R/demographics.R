#' Categorize a beneficiary's demographics into risk adjustment categories.
#'
#' This function takes demographic information about a beneficiary and returns a
#' Demographics object containing derived fields used in risk adjustment models.
#'
#' @param version `<chr>` Version of categorization to use (`V2`, `V4`, `V6`)
#' @param age `<num>` Beneficiary age
#' @param sex `<chr>` Beneficiary sex (`M`/`1` or `F`/`2`)
#' @param dual `<chr>` Dual eligibility code (`00` - `10`)
#' @param orec,crec `<chr>` Original/Current reason for entitlement
#'   code (`0` - `3`)
#' @param new,snp,low,lti `<lgl>` Beneficiary is a
#' **New Enrollee**, in a **Special Needs Plan**, is **Low Income** (RxHCC only),
#'   and/or is **Long-Term Institutionalized**
#' @param months `<int>` Number of months since transplant (ESRD only)
#' @param prefix `<chr>` Optional prefix to override demographic
#'   detection (e.g., `DI_`, `DNE_`, `INS_`, `CFA_`, etc.)
#' @returns A `<PatientDemographics>` S7 object
#' @examples
#' demographics(age = 48, sex = "1")
#' demographics(version = "V6", age = 35, sex = "M")
#' demographics(version = "V2", age = 75, sex = "2", orec = "0")
#' @export
demographics <- function(
  age,
  sex,
  version = "V2",
  dual = NA_character_,
  orec = NA_character_,
  crec = NA_character_,
  new = FALSE,
  snp = FALSE,
  low = FALSE,
  lti = FALSE,
  months = 0,
  prefix = NULL
) {
  rlang::check_number_decimal(age, min = 0, max = 125)
  rlang::check_number_whole(months, min = 0)
  version <- rlang::arg_match0(version, c("V2", "V4", "V6"))

  if (!cheapr::is_na(dual)) {
    rlang::arg_match(dual, DUAL_CODES$VALID)
  }
  if (!cheapr::is_na(orec)) {
    rlang::arg_match(orec, REC_CODES$VALID)
  }
  if (!cheapr::is_na(crec)) {
    rlang::arg_match(crec, REC_CODES$VALID)
  }

  rlang::check_bool(new)
  rlang::check_bool(snp)
  rlang::check_bool(low)
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
  age <- as.integer(age)
  non <- age <= 64L

  # Determine if currently disabled or previously disabled
  current <- non & orec %in_% c("1", "2", "3")
  previous <- orec %in_% "1" & !current

  PatientDemographics(
    version = version,
    age = age,
    sex = sex,
    dual_code = dual,
    orec_code = orec,
    crec_code = crec,
    non_aged = non,
    new_enrollee = new,
    has_snp = snp,
    dis_orig = previous,
    dis_curr = current,
    dual_full = full,
    dual_part = part,
    has_esrd = esrd,
    is_lti = lti,
    low_income = low,
    esrd_months = as.integer(months),
    category = categorize_age(
      age = age,
      sex = sex,
      vers = version,
      orec = orec,
      new = new,
      esrd = esrd
    )
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
#' categorize_age(64, "F", "V2", "1", TRUE, FALSE)
#' @noRd
categorize_age <- function(age, sex, vers, orec, new, esrd) {
  rlang::check_number_whole(age, min = 0, max = 120)
  rlang::check_bool(new)
  rlang::check_bool(esrd)

  switch(
    rlang::arg_match0(vers, c("V2", "V4", "V6")),
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
