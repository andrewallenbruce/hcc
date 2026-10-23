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
#' @examplesIf FALSE
#' PatientDemographics(
#'   age = 75,
#'   sex = "2",
#'   orec_code = "0",
#'   version = "V2"
#' )
#' @export
PatientDemographics := S7::new_class(
  properties = list(
    version = class_string,
    age = prop_integer,
    sex = class_string,
    dual_code = class_string,
    orec_code = prop_integer,
    crec_code = prop_integer,
    new_enrollee = class_boolean,
    has_snp = class_boolean,
    non_aged = class_boolean,
    dis_orig = class_boolean,
    dis_curr = class_boolean,
    dual_full = class_boolean,
    dual_part = class_boolean,
    has_esrd = class_boolean,
    is_lti = class_boolean,
    low_income = class_boolean,
    esrd_months = prop_integer,
    category = class_string
  )
)

#' HCC Category Detail
#'
#' @param hcc `<int>` HCC code (e.g., 18, 85)
#' @param label `<chr>` Human-readable description (e.g., "Diabetes with Chronic
#'   Complications")
#' @param is_chronic `<lgl>` Whether this HCC is considered a chronic condition
#' @param coefficient `<dbl>` The coefficient value applied for this HCC in the
#'   RAF calculation
#' @returns An `<HCCDetail>` S7 object
#' @examplesIf FALSE
#' HCCDetail(
#'  hcc = "203",
#'  label = "Coma, Brain Compression/Anoxic Damage",
#'  is_chronic = TRUE,
#'  coefficient = 0.486
#' )
#' @export
HCCDetail := S7::new_class(
  properties = list(
    hcc = prop_integer,
    label = S7::class_character,
    is_chronic = S7::class_logical,
    coefficient = S7::class_double
  )
)
