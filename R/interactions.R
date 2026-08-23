#' Create Demographic Interactions
#'
#' Creates interaction variables that are model-agnostic. The coefficient look-up
#' will match only the relevant coefficients for each model.
#'
#' @param x Demographics object
#' @param ... dots
#' @returns a list of interactions
#' @examples
#' x = demographics(
#'   age = 65.1,
#'   sex = "M",
#'   orec_code = "2",
#'   dual_code = "2",
#'   new_enrollee = TRUE,
#'   is_lti = TRUE,
#'   esrd_months = 10L
#'  )
#'
#' x
#'
#' interactions(x)
#'
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

  # create_demographic_interactions ============

  ## New Enrollee interactions for V24, V28, ESRD V21, ESRD V24
  named <- list(
    # V24, V28, ESRD V21: MCAID/NMCAID style
    # looked up with NE_ or SNPNE_ prefix
    NMCAID_NORIGDIS = collapse::fprod(!nemcaid, !ne_origds),
    MCAID_NORIGDIS = collapse::fprod(nemcaid, !ne_origds),
    NMCAID_ORIGDIS = collapse::fprod(!nemcaid, ne_origds),
    MCAID_ORIGDIS = collapse::fprod(nemcaid, ne_origds),

    # ESRD V24: FBD/ND_PBD style
    # looked up with DNE_ or GNE_ prefix
    FBD_NORIGDIS = collapse::fprod(fbd, !ne_origds),
    FBD_ORIGDIS = collapse::fprod(fbd, ne_origds),
    ND_PBD_NORIGDIS = collapse::fprod(!fbd, !ne_origds),
    ND_PBD_ORIGDIS = collapse::fprod(!fbd, ne_origds)
  ) |>
    rlang::set_names(paste0, "_", x@category)

  x <- rlang::list2(
    # Original Disability interactions (V22, V24, V28, ESRD V21, V24)
    # Only for aged (65+) looked up with prefix (e.g., CNA_, DI_)
    OriginallyDisabled_Female = collapse::fprod(aged, x@dis_orig, female),
    OriginallyDisabled_Male = collapse::fprod(aged, x@dis_orig, male),

    # Originally ESRD interactions (ESRD V21, V24 Dialysis)
    # Looked up as DI_Originally_ESRD_*
    Originally_ESRD_Female = collapse::fprod(
      aged,
      is_esrd(x@orec_code),
      female
    ),
    Originally_ESRD_Male = collapse::fprod(aged, is_esrd(x@orec_code), male),

    # MCAID × sex × age interactions
    # (ESRD V21 Dialysis and Community Graft only)
    # V21 used MCAID; V24 uses FBDual/PBDual
    # (handled in create_dual_interactions)
    MCAID_Female_Aged = collapse::fprod(mcaid, female, aged),
    MCAID_Female_NonAged = collapse::fprod(mcaid, female, !aged),
    MCAID_Male_Aged = collapse::fprod(mcaid, male, aged),
    MCAID_Male_NonAged = collapse::fprod(mcaid, male, !aged),

    #==== LTI interactions for ESRD models
    # ESRD V24 Dialysis: looked up as DI_LTI_Aged, DI_LTI_NonAged
    LTI_Aged = collapse::fprod(lti, aged),
    LTI_NonAged = collapse::fprod(lti, !aged),

    # ESRD V24 Graft Institutional
    # looked up WITHOUT prefix as LTI_GE65, LTI_LT65
    LTI_GE65 = collapse::fprod(lti, aged),
    LTI_LT65 = collapse::fprod(lti, !aged),

    # LTIMCAID for V24, V28 Institutional model
    # looked up as INS_LTIMCAID
    LTIMCAID = collapse::fprod(lti, mcaid),

    !!!named,

    #==== Functioning Graft Duration `transplant bumps` for ESRD models
    #==== All looked up WITHOUT prefix - they match directly by name
    # ESRD V21: simple age-based bumps (GE65_DUR4_9, LT65_DUR4_9, etc.)
    GE65_DUR4_9 = collapse::fprod(is_dur4_9, aged),
    LT65_DUR4_9 = collapse::fprod(is_dur4_9, !aged),

    GE65_DUR10PL = collapse::fprod(is_dur10pl, aged),
    LT65_DUR10PL = collapse::fprod(is_dur10pl, !aged),

    # ESRD V24: FGC (Community) / FGI (Institutional) stratified by dual status
    # Non-Dual and Partial Benefit Dual (ND_PBD)

    FGC_GE65_DUR4_9_ND_PBD = collapse::fprod(!fbd, is_dur4_9, aged, !lti),
    FGC_LT65_DUR4_9_ND_PBD = collapse::fprod(!fbd, is_dur4_9, !aged, !lti),
    FGI_GE65_DUR4_9_ND_PBD = collapse::fprod(!fbd, is_dur4_9, aged, lti),
    FGI_LT65_DUR4_9_ND_PBD = collapse::fprod(!fbd, is_dur4_9, !aged, lti),
    FGC_GE65_DUR10PL_ND_PBD = collapse::fprod(!fbd, is_dur10pl, aged, !lti),
    FGC_LT65_DUR10PL_ND_PBD = collapse::fprod(!fbd, is_dur10pl, !aged, !lti),
    FGI_GE65_DUR10PL_ND_PBD = collapse::fprod(!fbd, is_dur10pl, aged, lti),
    FGI_LT65_DUR10PL_ND_PBD = collapse::fprod(!fbd, is_dur10pl, !aged, lti),

    # Extra PBD flag for Partial Benefit Dual members
    FGC_PBD_GE65_flag = collapse::fprod(pbd, aged, !lti),
    FGC_PBD_LT65_flag = collapse::fprod(pbd, !aged, !lti),
    FGI_PBD_GE65_flag = collapse::fprod(pbd, aged, lti),
    FGI_PBD_LT65_flag = collapse::fprod(pbd, !aged, lti),

    FGC_GE65_DUR4_9_FBD = collapse::fprod(fbd, is_dur4_9, aged, !lti),
    FGC_LT65_DUR4_9_FBD = collapse::fprod(fbd, is_dur4_9, !aged, !lti),
    FGI_GE65_DUR4_9_FBD = collapse::fprod(fbd, is_dur4_9, aged, lti),
    FGI_LT65_DUR4_9_FBD = collapse::fprod(fbd, is_dur4_9, !aged, lti),

    FGC_GE65_DUR4_9_FBD = collapse::fprod(fbd, is_dur10pl, aged, !lti),
    FGC_LT65_DUR4_9_FBD = collapse::fprod(fbd, is_dur10pl, !aged, !lti),
    FGI_GE65_DUR4_9_FBD = collapse::fprod(fbd, is_dur10pl, aged, lti),
    FGI_LT65_DUR4_9_FBD = collapse::fprod(fbd, is_dur10pl, !aged, lti),

    # create_dual_interactions ============
    # Determine sex from demographics.sex instead of category
    # Category can start with NEM/NEF for new enrollees, not just M/F
    FBDual_Female_Aged = collapse::fprod(fbd, female, aged),
    FBDual_Female_NonAged = collapse::fprod(fbd, female, !aged),
    FBDual_Male_Aged = collapse::fprod(fbd, male, aged),
    FBDual_Male_NonAged = collapse::fprod(fbd, male, !aged),
    PBDual_Female_Aged = collapse::fprod(pbd, female, aged),
    PBDual_Female_NonAged = collapse::fprod(pbd, female, !aged),
    PBDual_Male_Aged = collapse::fprod(pbd, male, aged),
    PBDual_Male_NonAged = collapse::fprod(pbd, male, !aged)
  )

  names(x)[unlist_(x) == 1L]
}
