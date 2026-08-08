#' Categorize a beneficiary's demographics into risk adjustment categories.
#'
#' This function takes demographic information about a beneficiary and returns a
#' Demographics object containing derived fields used in risk adjustment models.
#'
#' @param age `<int>` Beneficiary age
#' @param sex `<chr>` Beneficiary sex (M/F or 1/2)
#' @param version `<chr>` Version of categorization to use ("V2", "V4", "V6")
#' @param orec `<chr>` Original reason for entitlement code ("0" - "3")
#' @param crec `<chr>` Current reason for entitlement code ("0" - "3")
#' @param dual `<chr>` Dual eligibility code ("00" - "10")
#' @param new `<lgl>` Beneficiary is a **New Enrollee**
#' @param snp `<lgl>` Beneficiary is in a **Special Needs Plan**
#' @param low `<lgl>` Beneficiary is **Low Income** (RxHCC only)
#' @param lti `<lgl>` Beneficiary is Long-Term Institutionalized
#' @param months `<int>` Number of months since transplant (ESRD only)
#' @param prefix `<chr>` Optional prefix to override demographic
#'   detection (e.g., "DI_", "DNE_", "INS_", "CFA_", etc.)
#' @returns A <Demographics> object containing derived fields like age/sex
#'   category, disability status, dual status flags, etc.
#' @examples
#' categorize_demographics(48, "1", "V2")
#' categorize_demographics(35, "M", "V6")
#' categorize_demographics(75, "2", "V2", "0")
#' @export
categorize_demographics <- function(
  age,
  sex,
  version = "V2",
  orec = NA,
  crec = NA,
  dual = NA,
  new = FALSE,
  snp = FALSE,
  low = FALSE,
  lti = FALSE,
  months = 0L,
  prefix = NULL
) {
  rlang::check_number_decimal(age, min = 0)
  version <- rlang::arg_match0(version, c("V2", "V4", "V6"))
  sex <- standardize_sex(sex, version)
  age <- as.integer(age)
  non_aged <- age <= 64L

  # Determine if currently disabled or previously disabled
  is_current <- non_aged & (!is.na(orec) & !identical(orec, "0"))
  is_original <- identical(orec, "1") & !is_current
  is_full <- is_dual_full(dual)
  is_part <- is_dual_partial(dual)
  has_esrd <- any(is_esrd(c(orec, crec)))

  # Override demographics based on prefix
  if (!is.null(prefix)) {
    if (prefix %in_% ESRD_PREFIXES) {
      has_esrd = TRUE
    }

    if (prefix %in_% NEW_ENROLLEE_PREFIXES) {
      new = TRUE
    } else if (prefix %in_% c(COMMUNITY_PREFIXES, INSTITUTIONAL_PREFIXES)) {
      new = FALSE
    }

    if (prefix %in_% FULL_BENEFIT_DUAL_PREFIXES) {
      .c(is_full, is_part) %=% c(TRUE, FALSE)
    } else if (prefix %in_% PARTIAL_BENEFIT_DUAL_PREFIXES) {
      .c(is_full, is_part) %=% c(FALSE, TRUE)
    } else if (prefix %in_% NON_DUAL_PREFIXES) {
      .c(is_full, is_part) %=% c(FALSE, FALSE)
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
    orig_disabled = is_original,
    disabled = is_current,
    dual = dual,
    orec = orec,
    crec = crec,
    new = new,
    snp = snp,
    fbd = is_full,
    pbd = is_part,
    esrd = has_esrd,
    lti = lti,
    months = months,
    low = low
  )
  d$category <- switch(
    version,
    "V2" = ,
    "V4" = {
      if (new) {
        prefix <- if (sex == "2") "NEF" else "NEM"
      } else {
        prefix <- if (sex == "2") "F" else "M"
      }

      if (new & !has_esrd) {
        age_category_NEW(age, orec, prefix)
      } else {
        age_category_ESRD(age, prefix)
      }
    },
    "V6" = age_category_V6(age, sex)
  )

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
