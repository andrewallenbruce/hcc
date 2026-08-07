#' Categorize a beneficiary's demographics into risk adjustment categories.
#'
#' This function takes demographic information about a beneficiary and returns a
#' Demographics object containing derived fields used in risk adjustment models.
#'
#' @param age `<int>` Beneficiary age
#' @param sex `<chr>` Beneficiary sex (M/F or 1/2)
#' @param version `<chr>` Version of categorization to use ("V2", "V4", "V6")
#' @param dual `<chr>` Dual eligibility code ("00" - "10")
#' @param orec `<chr>` Original reason for entitlement code ("0" - "3")
#' @param crec `<chr>` Current reason for entitlement code ("0" - "3")
#' @param new `<lgl>` Beneficiary is a **New Enrollee**
#' @param snp `<lgl>` Beneficiary is in a **Special Needs Plan**
#' @param low `<lgl>` Beneficiary is **Low Income** (RxHCC only)
#' @param lti `<lgl>` Beneficiary is Long-Term Institutionalized
#' @param months `<int>` Number of months since transplant (ESRD only)
#' @param prefix `<chr>` Optional prefix to override demographic
#'   detection (e.g., "DI_", "DNE_", "INS_", "CFA_", etc.)
#' @returns <Demographics> object containing derived fields like age/sex
#'   category, disability status, dual status flags, etc.
#' @examples
#' categorize_demographics(age = 48, sex = "1", version = "V2")
#' categorize_demographics(age = 35, sex = "M", version = "V6")
#' categorize_demographics(age = 75, sex = "2", orec = "0", version = "V2")
#' @export
categorize_demographics <- function(
  age,
  sex,
  version = "V2",
  dual = NA,
  orec = NA,
  crec = NA,
  new = FALSE,
  snp = FALSE,
  low = FALSE,
  lti = FALSE,
  months = NULL,
  prefix = NULL
) {
  rlang::check_number_decimal(age, min = 0)
  version <- rlang::arg_match0(version, c("V2", "V4", "V6"))
  sex <- standardize_sex(sex, version)

  # Convert to integer using floor
  age <- as.integer(age)
  non_aged <- age <= 64L

  # Determine if currently disabled or previously disabled
  disabled <- non_aged & (!is.na(orec) & !identical(orec, "0"))
  orig_disabled <- identical(orec, "1") & !disabled

  is_fbd <- is_full_benefit_dual(dual)
  is_pbd <- is_partial_benefit_dual(dual)

  # ESRD detection (2 = ESRD, 3 = DIB+ESRD)
  esrd <- collapse::anyv(c(orec, crec) %in_% c("2", "3"), TRUE)

  # Override demographics based on prefix_override
  if (!is.null(prefix)) {
    if (prefix %in_% ESRD_PREFIXES) {
      esrd = TRUE
    }

    if (prefix %in_% NEW_ENROLLEE_PREFIXES) {
      new = TRUE
    } else if (prefix %in_% c(COMMUNITY_PREFIXES, INSTITUTIONAL_PREFIXES)) {
      new = FALSE
    }

    if (prefix %in_% FULL_BENEFIT_DUAL_PREFIXES) {
      .c(is_fbd, is_pbd) %=% c(TRUE, FALSE)
    } else if (prefix %in_% PARTIAL_BENEFIT_DUAL_PREFIXES) {
      .c(is_fbd, is_pbd) %=% c(FALSE, TRUE)
    } else if (prefix %in_% NON_DUAL_PREFIXES) {
      .c(is_fbd, is_pbd) %=% c(FALSE, FALSE)
    }

    if (prefix %in_% INSTITUTIONAL_PREFIXES) {
      lti = TRUE
    }
  }

  d = Demographics(
    version = version,
    age = age,
    sex = sex,
    non_aged = non_aged,
    orig_disabled = orig_disabled,
    disabled = disabled,
    dual = dual,
    orec = orec,
    crec = crec,
    new = new,
    snp = snp,
    fbd = is_fbd,
    pbd = is_pbd,
    esrd = esrd,
    lti = lti,
    months = months,
    low = low
  )

  # V6 Logic (ACA Population)
  if (version == "V6") {
    category = age_category_V6(age, sex)
  }

  # V2/V4 Logic (Medicare Population)
  if (version %in_% c("V2", "V4")) {
    if (is.na(orec) || identical(orec, "")) {
      orec <- "0"
    }

    if (isTRUE(new)) {
      prefix <- if (sex == "2") "NEF" else "NEM"
    } else {
      prefix <- if (sex == "2") "F" else "M"
    }

    if (isTRUE(new) & isFALSE(esrd)) {
      category = age_category_NEW(age, orec, prefix)
    } else {
      category = age_category_ESRD(age, prefix)
    }
  }
  d$category <- category
  return(d)
}

#' @export
print.demographics <- function(x, ...) {
  cat("<Demographics>", sep = "\n")
  cat(fmt_idx(x), sep = "\n")
  invisible(x)
}

#' @noRd
fmt_idx <- function(x) {
  paste(
    format(
      names(x),
      justify = "right"
    ),
    ":",
    format(
      unname(x),
      justify = "left"
    )
  )
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
    c("M", "F", "1", "2"),
    arg_nm = error_arg,
    error_call = error_call
  )

  if (version %in_% c("V2", "V4")) {
    unname(c("M" = "1", "F" = "2", "1" = "1", "2" = "2")[sex])
  } else {
    unname(c("M" = "M", "F" = "F", "1" = "M", "2" = "F")[sex])
  }
}

#' @noRd
age_category_V6 <- function(age, sex) {
  V6_ACA_age_ranges <- ivs::iv_pairs(
    c(0, 1),
    c(1, 2),
    c(2, 5),
    c(5, 10),
    c(10, 15),
    c(15, 21),
    c(21, 25),
    c(25, 30),
    c(30, 35),
    c(35, 40),
    c(40, 45),
    c(45, 50),
    c(50, 55),
    c(55, 60),
    c(60, Inf)
  )

  V6_ACA_age_labels <- c(
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

  i <- ivs::iv_locate_between(age, V6_ACA_age_ranges)$haystack
  paste0(sex, "AGE_LAST_", V6_ACA_age_labels[i])
}

#' @noRd
age_category_ESRD <- function(age, prefix) {
  ESRD_age_ranges <- ivs::iv_pairs(
    c(0, 35),
    c(35, 45),
    c(45, 55),
    c(55, 60),
    c(60, 65),
    c(65, 70),
    c(70, 75),
    c(75, 80),
    c(80, 85),
    c(85, 90),
    c(90, 95),
    c(95, Inf)
  )

  ESRD_age_labels <- c(
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

  i <- ivs::iv_locate_between(age, ESRD_age_ranges)$haystack
  paste0(prefix, ESRD_age_labels[i])
}

#' @noRd
age_category_NEW <- function(age, orec, prefix) {
  vctrs::vec_case_when(
    conditions = list(
      age <= 34,
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
