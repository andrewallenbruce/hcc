#' @export
X12Index := S7::new_class(
  properties = list(
    type = S7::class_character,
    characters = S7::class_integer,
    segments = S7::class_integer,
    problems = S7::class_integer,
    index = S7::class_list,
    text = S7::class_character
  )
)

S7::method(format, X12Index) <- function(x) {
  cli::cli_h1("<hcc::X12Index>")
  names_ <- format(
    c("Type", "Characters", "Segments", "Problems"),
    justify = "right"
  )
  p <- S7::prop(x, "problems")
  probs_ <- if (length(p) == 1L && all(p == 0L)) p else length(p)
  numbs_ <- format(
    c(
      S7::prop(x, "type"),
      S7::prop(x, "characters"),
      S7::prop(x, "segments"),
      probs_
    ),
    justify = "left"
  )

  cli::cat_line(cheapr::paste_(cli::style_bold(names_), ": ", numbs_))
  cli::cat_rule()

  idx <- S7::prop(x, "index")
  seg <- collapse::vlengths(idx)

  names_ <- format(
    cheapr::paste_(
      names(seg),
      "[", unname(seg), "]"),
    justify = "right"
  )

  numbs_ <- format(
    purrr::map_chr(unname(idx), \(x) toString(x, width = 60)),
    justify = "left"
  )

  cli::cat_line(cheapr::paste_(cli::style_bold(names_), ": ", numbs_))
}

S7::method(print, X12Index) <- function(x) {
  format(x)
  invisible(x)
}

#' @noRd
class_iv <- S7::new_S3_class(c("ivs_iv", "vctrs_rcrd", "vctrs_vctr"))

#' @noRd
prop_date <- S7::new_property(
  S7::class_Date,
  setter = function(self, name, value) {
    S7::prop(self, name) <- parse_date(value)
    self
  }
)

#' @noRd
DiagnosticCategories := S7::new_class(
  properties = list(
    model = S7::class_character,
    hcc = S7::class_integer,
    categories = S7::class_list
  )
)

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
#' @usage NULL
#' @examples
#' PatientDemographics(
#'   age = 75,
#'   sex = "2",
#'   orec_code = "0",
#'   version = "V2"
#' )
#' @name PatientDemographics
#' @export
PatientDemographics := S7::new_class(
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

#' HCC Category Detail
#'
#' @param hcc `<int>` HCC code (e.g., 18, 85)
#' @param label `<chr>` Human-readable description (e.g., "Diabetes with Chronic
#'   Complications")
#' @param is_chronic `<lgl>` Whether this HCC is considered a chronic condition
#' @param coefficient `<dbl>` The coefficient value applied for this HCC in the
#'   RAF calculation
#' @returns An `<HCCDetail>` S7 object
#' @usage NULL
#' @examples
#' HCCDetail( # HCC203
#'  hcc = 203L,
#'  label = "Coma, Brain Compression/Anoxic Damage",
#'  is_chronic = TRUE,
#'  coefficient = 0.486
#' )
#' @name HCCDetail
#' @export
HCCDetail := S7::new_class(
  properties = list(
    hcc = S7::class_integer,
    label = S7::class_character,
    is_chronic = S7::class_logical,
    coefficient = S7::class_double
  )
)
