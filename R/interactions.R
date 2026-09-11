#' New Enrollee
#' V24/V28 & ESRD V21/V24
#'
#' ## MCAID/NMCAID + ORIGDIS/NORIGDIS
#'    - Looked up with `NE_`/`SNPNE_`
#'    - V24/V28 & ESRD V21
#'
#' ## FBD/ND_PBD + ORIGDIS/NORIGDIS
#'    - Looked up with `DNE_`/`GNE_`
#'    - ESRD V24
#'
#' @noRd
inter_new <- function(new_caid, new_orig, full, category) {
  rlang::set_names(
    list(
      NMCAID_NORIGDIS = mult_(!new_caid, !new_orig),
      NMCAID_ORIGDIS = mult_(!new_caid, new_orig),
      MCAID_NORIGDIS = mult_(new_caid, !new_orig),
      MCAID_ORIGDIS = mult_(new_caid, new_orig),
      FBD_NORIGDIS = mult_(full, !new_orig),
      FBD_ORIGDIS = mult_(full, new_orig),
      ND_PBD_NORIGDIS = mult_(!full, !new_orig),
      ND_PBD_ORIGDIS = mult_(!full, new_orig)
    ),
    paste0,
    "_",
    category
  )
}

#' Original Disability + Aged
#'    - V22/V24/V28 & ESRD V21/V24
#'    - Looked up with Prefix
#'
#' Original Disability + ESRD
#'    - ESRD V21/V24 (Dialysis)
#'    - Looked up with `DI_`
#' @noRd
inter_orig <- function(aged, female, male, orig, esrd) {
  list(
    OriginallyDisabled_Female = mult_(aged, female, orig),
    OriginallyDisabled_Male = mult_(aged, male, orig),
    Originally_ESRD_Female = mult_(aged, female, esrd),
    Originally_ESRD_Male = mult_(aged, male, esrd)
  )
}

#' MCAID + Sex + Age + ESRD V21
#' Dialysis & Community Graft Only
#' @noRd
inter_caid <- function(aged, caid, female, male) {
  list(
    MCAID_Female_Aged = mult_(caid, female, aged),
    MCAID_Female_NonAged = mult_(caid, female, !aged),
    MCAID_Male_Aged = mult_(caid, male, aged),
    MCAID_Male_NonAged = mult_(caid, male, !aged)
  )
}

#' LTI interactions for ESRD models
#'
#' ESRD V24 Dialysis
#' Looked up with `DI_`
#'
#' ESRD V24 Graft Institutional
#' Looked up *WITHOUT* Prefix
#'
#' LTIMCAID V24/V28 Institutional
#' Looked up with `INS_`
#' @noRd
inter_lti <- function(aged, lti, caid) {
  list(
    LTI_Aged = mult_(lti, aged),
    LTI_NonAged = mult_(lti, !aged),
    LTI_GE65 = mult_(lti, aged),
    LTI_LT65 = mult_(lti, !aged),
    LTIMCAID = mult_(lti, caid)
  )
}

#' Functioning Graft Duration
#' Simple Age-Based Transplant Bumps for ESRD models (V21)
#' Looked up WITHOUT prefix
#' @noRd
inter_graft <- function(aged, dur49, dur10) {
  list(
    GE65_DUR4_9 = mult_(dur49, aged),
    LT65_DUR4_9 = mult_(dur49, !aged),
    GE65_DUR10PL = mult_(dur10, aged),
    LT65_DUR10PL = mult_(dur10, !aged)
  )
}

#' Non-Dual (ND) & Partial Benefit Dual (ND_PBD)
#' ESRD V24: FGI (Institutional) & FGC (Community)
#' @noRd
inter_fgic <- function(full, part, aged, dur49, dur10, lti) {
  list(
    FGI_GE65_DUR4_9_ND_PBD = mult_(!full, aged, dur49, lti),
    FGI_GE65_DUR4_9_FBD = mult_(full, aged, dur49, lti),
    FGI_GE65_DUR10PL_ND_PBD = mult_(!full, aged, dur10, lti),
    FGI_GE65_DUR10PL_FBD = mult_(full, aged, dur10, lti),
    FGI_LT65_DUR4_9_ND_PBD = mult_(!full, !aged, dur49, lti),
    FGI_LT65_DUR4_9_FBD = mult_(full, !aged, dur49, lti),
    FGI_LT65_DUR10PL_ND_PBD = mult_(!full, !aged, dur10, lti),
    FGI_LT65_DUR10PL_FBD = mult_(full, !aged, dur10, lti),
    FGI_PBD_GE65_flag = mult_(part, aged, lti),
    FGI_PBD_LT65_flag = mult_(part, !aged, lti),
    FGC_GE65_DUR4_9_ND_PBD = mult_(!full, dur49, aged, !lti),
    FGC_GE65_DUR4_9_FBD = mult_(full, dur49, aged, !lti),
    FGC_GE65_DUR10PL_ND_PBD = mult_(!full, dur10, aged, !lti),
    FGC_GE65_DUR10PL_FBD = mult_(full, dur10, aged, !lti),
    FGC_LT65_DUR4_9_ND_PBD = mult_(!full, dur49, !aged, !lti),
    FGC_LT65_DUR4_9_FBD = mult_(full, dur49, !aged, !lti),
    FGC_LT65_DUR10PL_ND_PBD = mult_(!full, dur10, !aged, !lti),
    FGC_LT65_DUR10PL_FBD = mult_(full, dur10, !aged, !lti),
    FGC_PBD_GE65_flag = mult_(part, aged, !lti),
    FGC_PBD_LT65_flag = mult_(part, !aged, !lti)
  )
}

#' Dual Interactions
#' Determine sex from demographics@sex instead of category
#' Category can start with NEM/NEF for new enrollees, not just M/F
#' @noRd
inter_dual <- function(aged, full, part, male, female) {
  list(
    FBDual_Female_Aged = mult_(full, female, aged),
    FBDual_Female_NonAged = mult_(full, female, !aged),
    FBDual_Male_Aged = mult_(full, male, aged),
    FBDual_Male_NonAged = mult_(full, male, !aged),
    PBDual_Female_Aged = mult_(part, female, aged),
    PBDual_Female_NonAged = mult_(part, female, !aged),
    PBDual_Male_Aged = mult_(part, male, aged),
    PBDual_Male_NonAged = mult_(part, male, !aged)
  )
}

#' Create Interactions
#'
#' Creates interaction variables that are model-agnostic. The coefficient
#' look-up will match only the relevant coefficients for each model.
#'
#' @param x Demographics object
#' @param ... dots
#' @returns a list of interactions
#' @examples
#' interactions(
#'  demographics(
#'    age = 65,
#'    sex = "M",
#'    orec = "2",
#'    dual = "02",
#'    new = TRUE,
#'    lti = TRUE,
#'    months = 10L
#'  )
#' )
#' @export
interactions <- S7::new_generic("interactions", "x")

S7::method(interactions, PatientDemographics) <- function(x) {
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

  x = c(
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

#' Calculate HCC interactions across CMS models.
#'
#' Handles CMS-HCC, ESRD, and RxHCC models.
#'
#' @param diagnostics demographic information for age/sex/disability interactions
#' @param demographics set of HCCs for direct HCC checks
#' @returns `<chr>` vector of interactions
#' @examples
#' apply_interactions(
#'   diagnostics(model = "CMS-HCC Model V24", hcc = c(17L, 85L)),
#'   demographics(age = 64, sex = "F", orec = "1")
#' )
#' @export
apply_interactions <- function(diagnostics, demographics) {
  list(
    demographic_interactions = interactions(demographics),
    disease_categories = disease_interactions(diagnostics, demographics),
    number_hccs = hcc_count(diagnostics@hcc)
  )
}
