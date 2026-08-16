#' Create Demographic Interactions
#'
#' Creates interaction variables that are model-agnostic. The coefficient lookup
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

  named <- list(
    NMCAID_NORIGDIS = prod(!nemcaid, !ne_origds),
    MCAID_NORIGDIS = prod(nemcaid, !ne_origds),
    NMCAID_ORIGDIS = prod(!nemcaid, ne_origds),
    MCAID_ORIGDIS = prod(nemcaid, ne_origds),
    FBD_NORIGDIS = prod(fbd, !ne_origds),
    FBD_ORIGDIS = prod(fbd, ne_origds),
    ND_PBD_NORIGDIS = prod(!fbd, !ne_origds),
    ND_PBD_ORIGDIS = prod(!fbd, ne_origds)
  ) |>
    rlang::set_names(paste0, "_", x@category)

  x <- rlang::list2(
    OriginallyDisabled_Female = prod(aged, x@dis_orig, female),
    OriginallyDisabled_Male = prod(aged, x@dis_orig, male),
    Originally_ESRD_Female = prod(aged, is_esrd(x@orec_code), female),
    Originally_ESRD_Male = prod(aged, is_esrd(x@orec_code), male),
    MCAID_Female_Aged = prod(mcaid, female, aged),
    MCAID_Female_NonAged = prod(mcaid, female, !aged),
    MCAID_Male_Aged = prod(mcaid, male, aged),
    MCAID_Male_NonAged = prod(mcaid, male, !aged),
    LTI_Aged = prod(lti, aged),
    LTI_NonAged = prod(lti, !aged),
    LTI_GE65 = prod(lti, aged),
    LTI_LT65 = prod(lti, !aged),
    LTIMCAID = prod(lti, mcaid),
    !!!named,
    GE65_DUR4_9 = prod(is_dur4_9, aged),
    LT65_DUR4_9 = prod(is_dur4_9, !aged),
    GE65_DUR10PL = prod(is_dur10pl, aged),
    LT65_DUR10PL = prod(is_dur10pl, !aged),

    FGC_GE65_DUR4_9_ND_PBD = prod(!fbd, is_dur4_9, aged, !lti),
    FGC_LT65_DUR4_9_ND_PBD = prod(!fbd, is_dur4_9, !aged, !lti),
    FGI_GE65_DUR4_9_ND_PBD = prod(!fbd, is_dur4_9, aged, lti),
    FGI_LT65_DUR4_9_ND_PBD = prod(!fbd, is_dur4_9, !aged, lti),
    FGC_GE65_DUR10PL_ND_PBD = prod(!fbd, is_dur10pl, aged, !lti),
    FGC_LT65_DUR10PL_ND_PBD = prod(!fbd, is_dur10pl, !aged, !lti),
    FGI_GE65_DUR10PL_ND_PBD = prod(!fbd, is_dur10pl, aged, lti),
    FGI_LT65_DUR10PL_ND_PBD = prod(!fbd, is_dur10pl, !aged, lti),

    FGC_PBD_GE65_flag = prod(pbd, aged, !lti),
    FGC_PBD_LT65_flag = prod(pbd, !aged, !lti),
    FGI_PBD_GE65_flag = prod(pbd, aged, lti),
    FGI_PBD_LT65_flag = prod(pbd, !aged, lti),

    FGC_GE65_DUR4_9_FBD = prod(fbd, is_dur4_9, aged, !lti),
    FGC_LT65_DUR4_9_FBD = prod(fbd, is_dur4_9, !aged, !lti),
    FGI_GE65_DUR4_9_FBD = prod(fbd, is_dur4_9, aged, lti),
    FGI_LT65_DUR4_9_FBD = prod(fbd, is_dur4_9, !aged, lti),

    FGC_GE65_DUR4_9_FBD = prod(fbd, is_dur10pl, aged, !lti),
    FGC_LT65_DUR4_9_FBD = prod(fbd, is_dur10pl, !aged, !lti),
    FGI_GE65_DUR4_9_FBD = prod(fbd, is_dur10pl, aged, lti),
    FGI_LT65_DUR4_9_FBD = prod(fbd, is_dur10pl, !aged, lti)
  )

  names(x)[unlist_(x) == 1L]
}

#   # Original Disability interactions (V22, V24, V28, ESRD V21, V24)
#   # Only for aged (65+) looked up with prefix (e.g., CNA_, DI_)
#   act <- cheapr::list_assign(
#     act,
#     list(
#       OriginallyDisabled_Female = is_aged * d$orig_disabled * is_female,
#       OriginallyDisabled_Male = is_aged * d$orig_disabled * is_male
#     )
#   )
#
#   # Originally ESRD interactions (ESRD V21, V24 Dialysis) - looked up as DI_Originally_ESRD_*
#   act <- cheapr::list_assign(
#     act,
#     list(
#       Originally_ESRD_Female = is_aged * is_esrd(d$orec) * is_female,
#       Originally_ESRD_Male = is_aged * is_esrd(d$orec) * is_male
#     )
#   )
#
#   # MCAID × sex × age interactions (ESRD V21 Dialysis and Community Graft only)
#   # V21 used MCAID; V24 uses FBDual/PBDual (handled in create_dual_interactions)
#   act <- cheapr::list_assign(
#     act,
#     list(
#       MCAID_Female_Aged = mcaid * is_female * is_aged,
#       MCAID_Female_NonAged = mcaid * is_female * !is_aged,
#       MCAID_Male_Aged = mcaid * is_male * is_aged,
#       MCAID_Male_NonAged = mcaid * is_male * !is_aged
#     )
#   )
#
#   # LTI interactions for ESRD models
#   act <- cheapr::list_assign(
#     act,
#     list(
#       # ESRD V24 Dialysis: looked up as DI_LTI_Aged, DI_LTI_NonAged
#       LTI_Aged = lti * is_aged,
#       LTI_NonAged = lti * !is_aged,
#       # ESRD V24 Graft Institutional: looked up WITHOUT prefix as LTI_GE65, LTI_LT65
#       LTI_GE65 = lti * is_aged,
#       LTI_LT65 = lti * !is_aged
#     )
#   )
#
#   # LTIMCAID for V24, V28 Institutional model looked up as INS_LTIMCAID
#   act <- cheapr::list_assign(act, list(LTIMCAID = lti * mcaid))
#
#   # New Enrollee interactions for V24, V28, ESRD V21, ESRD V24
#   act <- cheapr::list_assign(
#     act,
#     list(
#       # V24, V28, ESRD V21: MCAID/NMCAID style; looked up with NE_ or SNPNE_ prefix
#       NMCAID_NORIGDIS = !nemcaid * !ne_origds,
#       MCAID_NORIGDIS = nemcaid * !ne_origds,
#       NMCAID_ORIGDIS = !nemcaid * ne_origds,
#       MCAID_ORIGDIS = nemcaid * ne_origds,
#       # ESRD V24: FBD/ND_PBD style; looked up with DNE_ or GNE_ prefix
#       FBD_NORIGDIS = fbd * !ne_origds,
#       FBD_ORIGDIS = fbd * ne_origds,
#       ND_PBD_NORIGDIS = !fbd * !ne_origds,
#       ND_PBD_ORIGDIS = !fbd * ne_origds
#     ) |>
#       rlang::set_names(paste0, "_", d$category)
#   )
#
#   # Functioning Graft Duration `transplant bumps` for ESRD models
#   # All looked up WITHOUT prefix - they match directly by name
#
#   # ESRD V21: simple age-based bumps (GE65_DUR4_9, LT65_DUR4_9, etc.)
#   act <- cheapr::list_assign(
#     act,
#     list(
#       GE65_DUR4_9 = is_dur4_9 * is_aged,
#       LT65_DUR4_9 = is_dur4_9 * !is_aged
#     )
#   )
#
#   if (is_dur10pl) {
#     act <- cheapr::list_assign(
#       act,
#       list(
#         GE65_DUR10PL = is_dur10pl * is_aged,
#         LT65_DUR10PL = is_dur10pl * !is_aged
#       )
#     )
#   }
#
#   # ESRD V24: FGC (Community) / FGI (Institutional) stratified by dual status
#   # Non-Dual and Partial Benefit Dual (ND_PBD)
#   act <- cheapr::list_assign(
#     act,
#     list(
#       FGC_GE65_DUR4_9_ND_PBD = !fbd * is_dur4_9 * is_aged * !lti,
#       FGC_LT65_DUR4_9_ND_PBD = !fbd * is_dur4_9 * !is_aged * !lti,
#       FGI_GE65_DUR4_9_ND_PBD = !fbd * is_dur4_9 * is_aged * lti,
#       FGI_LT65_DUR4_9_ND_PBD = !fbd * is_dur4_9 * !is_aged * lti
#     )
#   )
#   act <- cheapr::list_assign(
#     act,
#     list(
#       FGC_GE65_DUR10PL_ND_PBD = !fbd * is_dur10pl * is_aged * !lti,
#       FGC_LT65_DUR10PL_ND_PBD = !fbd * is_dur10pl * !is_aged * !lti,
#       FGI_GE65_DUR10PL_ND_PBD = !fbd * is_dur10pl * is_aged * lti,
#       FGI_LT65_DUR10PL_ND_PBD = !fbd * is_dur10pl * !is_aged * lti
#     )
#   )
#
#   # Extra PBD flag for Partial Benefit Dual members
#   act <- cheapr::list_assign(
#     act,
#     list(
#       FGC_PBD_GE65_flag = pbd * is_aged * !lti,
#       FGC_PBD_LT65_flag = pbd * !is_aged * !lti,
#       FGI_PBD_GE65_flag = pbd * is_aged * lti,
#       FGI_PBD_LT65_flag = pbd * !is_aged * lti
#     )
#   )
#
#   act <- cheapr::list_assign(
#     act,
#     list(
#       FGC_GE65_DUR4_9_FBD = fbd * is_dur4_9 * is_aged * !lti,
#       FGC_LT65_DUR4_9_FBD = fbd * is_dur4_9 * !is_aged * !lti,
#       FGI_GE65_DUR4_9_FBD = fbd * is_dur4_9 * is_aged * lti,
#       FGI_LT65_DUR4_9_FBD = fbd * is_dur4_9 * !is_aged * lti
#     )
#   )
#
#   act <- cheapr::list_assign(
#     act,
#     list(
#       FGC_GE65_DUR4_9_FBD = fbd * is_dur10pl * is_aged * !lti,
#       FGC_LT65_DUR4_9_FBD = fbd * is_dur10pl * !is_aged * !lti,
#       FGI_GE65_DUR4_9_FBD = fbd * is_dur10pl * is_aged * lti,
#       FGI_LT65_DUR4_9_FBD = fbd * is_dur10pl * !is_aged * lti
#     )
#   )
#
#   return(act)
# }
