#' @noRd
fright <- function(x, ...) {
  format(x, justify = "right", ...)
}

#' @noRd
fleft <- function(x, ...) {
  format(x, justify = "left", ...)
}

#' @export
X12Index := S7::new_class(
  properties = list(
    type = S7::class_character,
    segments = S7::class_integer,
    problems = S7::class_integer,
    index = S7::class_list,
    text = S7::class_character
  )
)

S7::method(format, X12Index) <- function(x) {
  cli::cli_h1("<hcc::X12Index>")

  probs_ <- S7::prop(x, "problems")
  probs_ <- if (length(probs_) == 1L && all(probs_ == 0L)) {
    NULL
  } else {
    cli::col_red(length(S7::prop(x, "problems")))
  }

  names_ <- fright(c("Type", "Segments", if (!is.null(probs_)) "Problems"))
  numbs_ <- fleft(c(S7::prop(x, "type"), S7::prop(x, "segments"), if (!is.null(probs_)) probs_))

  cli::cat_line(
    cheapr::paste_(
      cli::col_cyan(
        cli::style_bold(names_)
      ),
      ": ",
      numbs_
    )
  )
  cli::cat_rule()

  idx <- S7::prop(x, "index")
  seg <- collapse::vlengths(idx)

  names_ <- fright(cheapr::paste_(names(seg), "[", unname(seg), "]"))
  numbs_ <- fleft(purrr::map_chr(unname(idx), \(x) toString(x, width = 60)))

  cli::cat_line(
    cheapr::paste_(
      cli::col_yellow(
        cli::style_bold(names_)
      ),
      ": ",
      numbs_
    )
  )
}

S7::method(print, X12Index) <- function(x) {
  format(x)
  invisible(x)
}

#' Extract Problems from X12 Indices
#' @param x `<X12Index>` S7 object
#' @param ... dots
#' @returns a character vector of interactions
#' @examples
#' idx9 = index_x12(hcc::x12_837I$sample_837_9)
#' problems(idx9)
#' @export
#' @name problems
problems := S7::new_generic("x")

S7::method(problems, S7::class_any) <- function(x) {
  return(NA)
}

S7::method(problems, S7::class_list) <- function(x) {
  purrr::map(x, problems)
  # p <- problems(i)
  # p <- p[cheapr::which_(purrr::map_lgl(p, rlang::is_empty), TRUE)]
  # p[cheapr::which_(purrr::map_lgl(p, anyNA), TRUE)]
}

S7::method(problems, X12Index) <- function(x) {
  .subset(x@text, x@problems)
}

#' @noRd
class_iv <- S7::new_S3_class(c("ivs_iv", "vctrs_rcrd", "vctrs_vctr"))

#' @noRd
prop_date <- S7::new_property(
  S7::class_Date,
  default = quote(Sys.Date()),
  setter = function(self, name, value) {
    S7::prop(self, name) <- parse_date(value)
    self
  }
)

#' @noRd
prop_integer <- S7::new_property(
  S7::class_integer,
  setter = function(self, name, value) {
    S7::prop(self, name) <- as.integer(value)
    self
  }
)

#' @noRd
DiagnosticCategories := S7::new_class(
  properties = list(
    model = S7::class_character,
    hcc = prop_integer,
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
    age = prop_integer,
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
    esrd_months = prop_integer,
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
#' HCCDetail(
#'  hcc = "203",
#'  label = "Coma, Brain Compression/Anoxic Damage",
#'  is_chronic = TRUE,
#'  coefficient = 0.486
#' )
#' @name HCCDetail
#' @export
HCCDetail := S7::new_class(
  properties = list(
    hcc = prop_integer,
    label = S7::class_character,
    is_chronic = S7::class_logical,
    coefficient = S7::class_double
  )
)
