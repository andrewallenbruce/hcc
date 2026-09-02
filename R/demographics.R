#' Categorize a beneficiary's demographics into risk adjustment categories.
#'
#' This function takes demographic information about a beneficiary and returns a
#' Demographics object containing derived fields used in risk adjustment models.
#'
#' @param version `<chr>` Version of categorization to use (`V2`, `V4`, `V6`)
#' @param age `<num>` Beneficiary age
#' @param sex `<chr>` Beneficiary sex (`M`/`1` or `F`/`2`)
#' @param dual_code `<chr>` Dual eligibility code (`00` - `10`)
#' @param orec_code,crec_code `<chr>` Original/Current reason for entitlement
#'   code (`0` - `3`)
#' @param new_enrollee,has_snp,low_income,is_lti `<lgl>` Beneficiary is a
#' **New Enrollee**, in a **Special Needs Plan**, is **Low Income** (RxHCC only),
#'   and/or is Long-Term Institutionalized
#' @param esrd_months `<int>` Number of months since transplant (ESRD only)
#' @param prefix `<chr>` Optional prefix to override demographic
#'   detection (e.g., `DI_`, `DNE_`, `INS_`, `CFA_`, etc.)
#' @returns A `<PatientDemographics>` S7 object
#' @examples
#' demographics(age = 48, sex = "1")
#' demographics(version = "V6", age = 35, sex = "M")
#' demographics(version = "V2", age = 75, sex = "2", orec_code = "0")
#' @export
demographics <- function(
  version = "V2",
  age,
  sex,
  dual_code = NA_character_,
  orec_code = NA_character_,
  crec_code = NA_character_,
  new_enrollee = FALSE,
  has_snp = FALSE,
  low_income = FALSE,
  is_lti = FALSE,
  esrd_months = 0L,
  prefix = NULL
) {
  rlang::check_number_decimal(age, min = 0)
  version <- rlang::arg_match0(version, c("V2", "V4", "V6"))
  sex <- convert_sex(sex, version)
  age <- as.integer(age)
  non_aged <- age <= 64L

  # Determine if currently disabled or previously disabled
  is_curr <- non_aged & (!is.na(orec_code) & !identical(orec_code, "0"))
  is_orig <- identical(orec_code, "1") & !is_curr
  is_full <- is_dual_full(dual_code)
  is_part <- is_dual_partial(dual_code)
  has_esrd <- has_esrd(orec_code, crec_code)

  # Override demographics based on prefix
  if (!is.null(prefix)) {
    if (prefix %in_% PREFIX$ESRD) {
      has_esrd = TRUE
    }

    if (prefix %in_% PREFIX$NEW_ENROLLEE) {
      new_enrollee = TRUE
    } else if (prefix %in_% c(PREFIX$COMMUNITY, PREFIX$INSTITUTIONAL)) {
      new_enrollee = FALSE
    }

    if (prefix %in_% PREFIX$DUAL_FULL) {
      .c(is_full, is_part) %=% c(TRUE, FALSE)
    } else if (prefix %in_% PREFIX$DUAL_PARTIAL) {
      .c(is_full, is_part) %=% c(FALSE, TRUE)
    } else if (prefix %in_% PREFIX$DUAL_NON) {
      .c(is_full, is_part) %=% c(FALSE, FALSE)
    }

    if (prefix %in_% PREFIX$INSTITUTIONAL) {
      is_lti = TRUE
    }
  }

  PatientDemographics(
    version = version,
    age = age,
    sex = sex,
    dual_code = dual_code,
    orec_code = crec_code,
    crec_code = crec_code,
    non_aged = non_aged,
    new_enrollee = new_enrollee,
    has_snp = has_snp,
    dis_orig = is_orig,
    dis_curr = is_curr,
    dual_full = is_full,
    dual_part = is_part,
    has_esrd = has_esrd,
    is_lti = is_lti,
    low_income = low_income,
    esrd_months = esrd_months,
    category = categorize_age(
      version,
      new_enrollee,
      has_esrd,
      age,
      sex,
      orec_code
    )
  )
}
