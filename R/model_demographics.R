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
#' as_demographics(48, "1", "V2")
#' as_demographics(35, "M", "V6")
#' as_demographics(75, "2", "V2", "0")
#' @export
as_demographics <- function(
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
    if (prefix %in_% PREFIX$ESRD) {
      has_esrd = TRUE
    }

    if (prefix %in_% PREFIX$NEW_ENROLLEE) {
      new = TRUE
    } else if (prefix %in_% c(PREFIX$COMMUNITY, PREFIX$INSTITUTIONAL)) {
      new = FALSE
    }

    if (prefix %in_% PREFIX$DUAL_FULL) {
      .c(is_full, is_part) %=% c(TRUE, FALSE)
    } else if (prefix %in_% PREFIX$DUAL_PARTIAL) {
      .c(is_full, is_part) %=% c(FALSE, TRUE)
    } else if (prefix %in_% PREFIX$DUAL_NON) {
      .c(is_full, is_part) %=% c(FALSE, FALSE)
    }

    if (prefix %in_% PREFIX$INSTITUTIONAL) {
      lti = TRUE
    }
  }

  Demographics(
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
    low = low,
    category = switch(
      version,
      "V2" = ,
      "V4" = {
        if (new & !has_esrd) {
          age_category_NEW(age, sex, orec)
        } else {
          age_category_ESRD(age, sex)
        }
      },
      "V6" = age_category_V6(age, sex)
    )
  )
}

#' @export
print.demographics <- function(x, ...) {
  cat("<Demographics>", sep = "\n")
  cat(fmt_idx(x), sep = "\n")
  invisible(x)
}
