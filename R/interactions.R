#' Create Interactions
#'
#' Creates interaction variables that are model-agnostic. The coefficient
#' look-up will match only the relevant coefficients for each model.
#'
#' @param x `<PatientDemographics>` S7 object
#' @param y `<DiagnosticCategories>` S7 object
#' @param ... dots
#' @returns a character vector of interactions
#' @examples
#' interactions(
#'   demographics(
#'     age = 64,
#'     sex = "F",
#'     orec = "1"
#'   )
#' )
#'
#' interactions(
#'   demographics(age = 64, sex = "F", orec = "1"),
#'   diagnostics("C24", c(17L, 85L))
#' )
#' interactions(
#'   demographics(age = 64, sex = "F", orec = "1"),
#'   diagnostics("R08", 130:133)
#' )
#' @export
#' @name interactions
interactions := S7::new_generic(c("x", "y"))

S7::method(
  interactions,
  list(PatientDemographics, S7::class_missing)
) <- function(x, y) {
  female = is_female(x@sex)
  male = is_male(x@sex)
  aged = !x@non_aged
  lti = x@is_lti
  fbd = x@dual_full
  pbd = x@dual_part
  months = x@esrd_months
  mcaid = is_dual_any(x@dual_code)
  nemcaid = x@new_enrollee & is_dual_valid(x@dual_code)
  ne_origds = x@age >= 65 & identical(x@orec_code, "1")
  is_dur4_9 = in_between(x@esrd_months, 4L, 9L)
  is_dur10pl = x@esrd_months >= 10L
  is_esrd = is_esrd(x@orec_code)

  x <- c(
    inter_new(nemcaid, ne_origds, fbd, x@category),
    inter_orig(aged, female, male, x@dis_orig, is_esrd),
    inter_caid(aged, mcaid, female, male),
    inter_lti(aged, lti, mcaid),
    inter_graft(aged, is_dur4_9, is_dur10pl),
    inter_fgic(fbd, pbd, aged, is_dur4_9, is_dur10pl, lti),
    inter_dual(aged, fbd, pbd, male, female)
  )

  names(x)[unlist_(x) == 1L]
}

S7::method(
  interactions,
  list(PatientDemographics, DiagnosticCategories)
) <- function(x, y) {
  x <- switch(
    y@model,
    "CMS-HCC Model V28" = disease_V28(y@categories, x@dis_curr, y@hcc),
    "CMS-HCC Model V24" = disease_V24(y@categories, x@dis_curr, y@hcc),
    "CMS-HCC Model V22" = disease_V22(y@categories, x@dis_curr, y@hcc),
    "CMS-HCC ESRD Model V24" = disease_ESRD_V24(
      y@categories,
      x@non_aged,
      y@hcc
    ),
    "CMS-HCC ESRD Model V21" = disease_ESRD_V21(
      y@categories,
      x@non_aged,
      y@hcc
    ),
    "RxHCC Model V08" = disease_RxHCC_V8(x@non_aged, y@hcc)
  )

  names(x)[unlist_(x) == 1L]
}

#' Calculate HCC interactions across CMS models.
#'
#' Handles CMS-HCC, ESRD, and RxHCC models.
#'
#' @param diagnostics `<DiagnosticCategories>` object
#' @param demographics `<PatientDemographics>` object
#' @returns `<chr>` vector of interactions
#' @examples
#' apply_interactions(
#'   diagnostics(model = "C24", hcc = c(17L, 85L)),
#'   demographics(age = 64, sex = "F", orec = "1")
#' )
#' @export
apply_interactions <- function(diagnostics, demographics) {
  list(
    demographic = interactions(demographics),
    disease = interactions(demographics, diagnostics),
    number_hccs = hcc_count(diagnostics@hcc)
  )
}
