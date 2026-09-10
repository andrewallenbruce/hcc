#' Patient Demographics Categorization
#'
#' @param version `<chr>` Version of categorization to use (`V2`, `V4`, `V6`)
#' @param age `<num>` Beneficiary age
#' @param sex `<chr>` Beneficiary sex (`M`/`F` or `1`/`2`)
#' @param dual_code `<chr>` Dual eligibility code (`00` - `10`)
#' @param orec_code `<chr>` Original reason for entitlement (`0` - `3`)
#' @param crec_code `<chr>` Current reason for entitlement (`0` - `3`)
#' @param new_enrollee `<lgl>` Beneficiary is a **New Enrollee**
#' @param has_snp `<lgl>` Beneficiary is in a **Special Needs Plan**
#' @param non_aged `<lgl>` `TRUE` if `age <= 64`
#' @param dis_orig `<lgl>` `TRUE` if originally disabled (`OREC == "1"`) and not
#'   currently disabled
#' @param dis_curr `<lgl>` `TRUE` if currently disabled (`age < 65 & OREC !=
#'   "0"`)
#' @param dual_full `<lgl>` `TRUE` if FBD *(FBD Model)*
#' @param dual_part `<lgl>` `TRUE` if PBD *(PBD Model)*
#' @param has_esrd `<lgl>` `TRUE` if ESRD *(ESRD Model)*
#' @param is_lti `<lgl>` `TRUE` if LTI *(LTI Model)*
#' @param low_income `<lgl>` Beneficiary is **Low Income** *(RxHCC only)*
#' @param esrd_months `<int>` Number of months since transplant *(ESRD only)*
#' @param category `<chr>` Age-sex category code
#' @returns A `<PatientDemographics>` S7 object
#' @examples
#' PatientDemographics(age = 48, sex = "1", version = "V2")
#' PatientDemographics(age = 35, sex = "M", version = "V6")
#' PatientDemographics(age = 75, sex = "2", orec_code = "0", version = "V2")
#' @export
PatientDemographics <- S7::new_class(
  "PatientDemographics",
  properties = list(
    version = S7::class_character,
    age = S7::class_numeric,
    sex = S7::class_character,
    dual_code = S7::class_character,
    orec_code = S7::class_character,
    crec_code = S7::class_character,
    new_enrollee = S7::class_logical,
    has_snp = S7::class_logical,
    non_aged = S7::class_logical,
    dis_orig = S7::class_logical,
    dis_curr = S7::class_logical,
    dual_full = S7::class_logical,
    dual_part = S7::class_logical,
    has_esrd = S7::class_logical,
    is_lti = S7::class_logical,
    low_income = S7::class_logical,
    esrd_months = S7::class_integer,
    category = S7::class_character
  )
)

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
  version <- rlang::arg_match(version, c("V2", "V4", "V6"))

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
    if (prefix %in_% PREFIX[["ESRD"]]) {
      esrd <- TRUE
    }

    if (prefix %in_% PREFIX[["NEW_ENROLLEE"]]) {
      new <- TRUE
    } else if (prefix %in_% PREFIX[["COMMUNITY_INSTITUTIONAL"]]) {
      new <- FALSE
    }

    if (prefix %in_% PREFIX[["DUAL"]][["FULL"]]) {
      .c(full, part) %=% c(TRUE, FALSE)
    } else if (prefix %in_% PREFIX[["DUAL"]][["PARTIAL"]]) {
      .c(full, part) %=% c(FALSE, TRUE)
    } else if (prefix %in_% PREFIX[["DUAL"]][["NON"]]) {
      .c(full, part) %=% c(FALSE, FALSE)
    }

    if (prefix %in_% PREFIX[["INSTITUTIONAL"]]) {
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
