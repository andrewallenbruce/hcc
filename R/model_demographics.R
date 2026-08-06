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

#' Categorize a beneficiary's demographics into risk adjustment categories.
#'
#' This function takes demographic information about a beneficiary and returns a
#' Demographics object containing derived fields used in risk adjustment models.
#'
#' @param age `<int>` Beneficiary age (floored to integer)
#' @param sex `<chr>` Beneficiary sex (M/F or 1/2)
#' @param dual_elgbl_cd `<chr>` Dual eligibility code ("00" - "10")
#' @param orec `<chr>` Original reason for entitlement code ("0" - "3")
#' @param crec `<chr>` Current reason for entitlement code ("0" - "3")
#' @param version `<chr>` Version of categorization to use ("V2", "V4", "V6")
#' @param new_enrollee `<lgl>` Whether beneficiary is a **New Enrollee**
#' @param snp `<lgl>` Whether beneficiary is in a **Special Needs Plan**
#' @param low_income `<lgl>` Whether beneficiary is **Low Income** (RxHCC only)
#' @param lti `<lgl>` Whether beneficiary is Long-Term Institutionalized
#' @param graft_months `<int>` Number of months since transplant (ESRD only)
#' @param prefix_override `<chr>` Optional prefix to override demographic
#'   detection (e.g., "DI_", "DNE_", "INS_", "CFA_", etc.)
#' @returns Demographics object containing derived fields like age/sex category,
#'   disability status, dual status flags, etc.
#' @examples
#' categorize_demographics(age = 48, sex = "1", version = "V2")
#' categorize_demographics(age = 35, sex = "M", version = "V6")
#' categorize_demographics(age = 75, sex = "2", orec = "0", version = "V2")
#' @export
categorize_demographics <- function(
  age,
  sex,
  version = "V2",
  dual_elgbl_cd = NA,
  orec = NA,
  crec = NA,
  new_enrollee = FALSE,
  snp = FALSE,
  low_income = FALSE,
  lti = FALSE,
  graft_months = NULL,
  prefix_override = NULL
) {
  rlang::check_number_decimal(age, min = 0)
  version <- rlang::arg_match0(version, c("V2", "V4", "V6"))

  sex <- rlang::arg_match0(sex, c("1", "2", "M", "F"))

  sex <- if (version %in_% c("V2", "V4")) {
    unname(c("M" = "1", "F" = "2", "1" = "1", "2" = "2")[sex])
  } else {
    unname(c("M" = "M", "F" = "F", "1" = "M", "2" = "F")[sex])
  }

  # Convert to integer using floor
  age <- as.integer(age)
  non_aged <- age <= 64L

  # Determine if person is disabled or originally disabled
  disabled <- age < 65L & (!is.na(orec) & !identical(orec, "0"))
  orig_disabled <- (!is.na(orec) & identical(orec, "1")) & !disabled

  is_fbd <- dual_elgbl_cd %in_% FULL_BENEFIT_DUAL_CODES
  is_pbd <- dual_elgbl_cd %in_% PARTIAL_BENEFIT_DUAL_CODES

  # ESRD detection (2 = ESRD, 3 = DIB+ESRD)
  esrd <- orec %in_% OREC_ESRD_CODES | crec %in_% CREC_ESRD_CODES

  # Override demographics based on prefix_override
  if (!is.null(prefix_override)) {
    # Set esrd flag
    if (prefix_override %in_% ESRD_PREFIXES) {
      esrd <- TRUE
    }
    # Set new_enrollee flag
    if (prefix_override %in_% NEW_ENROLLEE_PREFIXES) {
      new_enrollee <- TRUE
    } else if (
      prefix_override %in_% c(COMMUNITY_PREFIXES, INSTITUTIONAL_PREFIXES)
    ) {
      new_enrollee <- FALSE
    }
    # Set dual eligibility flags based on prefix
    if (prefix_override %in_% FULL_BENEFIT_DUAL_PREFIXES) {
      is_fbd <- TRUE
      is_pbd <- FALSE
    } else if (prefix_override %in_% PARTIAL_BENEFIT_DUAL_PREFIXES) {
      is_fbd <- FALSE
      is_pbd <- TRUE
    } else if (prefix_override %in_% NON_DUAL_PREFIXES) {
      is_fbd <- FALSE
      is_pbd <- FALSE
    }
    # Set lti flag based on prefix
    if (prefix_override %in_% INSTITUTIONAL_PREFIXES) {
      lti <- TRUE
    }
  }

  result = list(
    version = version,
    non_aged = non_aged,
    orig_disabled = orig_disabled,
    disabled = disabled,
    age = age,
    sex = sex,
    dual_elgbl_cd = dual_elgbl_cd,
    orec = orec,
    crec = crec,
    new_enrollee = new_enrollee,
    snp = snp,
    fbd = is_fbd,
    pbd = is_pbd,
    esrd = esrd,
    lti = lti,
    graft_months = graft_months,
    low_income = low_income
  )

  # V6 Logic (ACA Population)
  if (version == "V6") {
    result$category <- age_category_V6(age, sex)
    return(result)
  }

  # V2/V4 Logic (Medicare Population)
  if (version %in_% c("V2", "V4")) {
    if (is.null(orec) || identical(orec, "")) {
      orec <- "0"
    }

    if (new_enrollee) {
      prefix <- if (sex == "2") "NEF" else "NEM"
    } else {
      prefix <- if (sex == "2") "F" else "M"
    }

    # Determine prefix based on new_enrollee status
    # prefix <- vctrs::vec_if_else(
    #   new_enrollee,
    #   vctrs::vec_if_else(identical(sex, "2"), "M", "NEM"),
    #   vctrs::vec_if_else(identical(sex, "2"), "F", "NEF")
    # )

    result$category <- if (new_enrollee & !esrd) {
      # CMS-HCC new_enrollee logic
      age_category_NEW(age, orec, prefix)
    } else {
      # Standard non-new-enrollee OR ESRD logic
      age_category_ESRD(age, prefix)
    }

    return(result)
  }
}

# disabled is true if the person is disabled and the age is less than 65
# - basically, the person is in Medicare due to disability not due to age
# orig_disabled is true if the person started Medicare due to disability, but now aged in
# - basically, the person is in Medicare due to age (not disability anymore)
# Reference: https://resdac.org/cms-data/variables/medicare-medicaid-dual-eligibility-code-january
