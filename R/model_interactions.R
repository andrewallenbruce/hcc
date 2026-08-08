#' Create Demographic Interactions
#'
#' Creates interaction variables that are model-agnostic. The coefficient lookup
#' will match only the relevant coefficients for each model.
#'
#' @param d Demographics object
#' @returns a list of interactions
#' @examples
#' x = categorize_demographics(
#'   age = 65.1,
#'   sex = "M",
#'   orec = "2",
#'   dual = "2",
#'   new = TRUE,
#'   lti = TRUE,
#'   months = 10
#'  )
#'
#' x
#'
#' create_demographic_interactions(x)
#'
#' @export
create_demographic_interactions <- function(d) {
  act <- list()

  # Demographic flags
  is_female = d$sex %in% c("F", "2")
  is_male = d$sex %in% c("M", "1")
  is_aged = !d$non_aged
  lti = d$lti
  fbd = d$fbd
  pbd = d$pbd
  months = d$months
  mcaid = is_dual_any(d$dual)

  # Original Disability interactions (V22, V24, V28, ESRD V21, V24)
  # Only for aged (65+) looked up with prefix (e.g., CNA_, DI_)
  if (is_aged) {
    act <- cheapr::list_assign(
      act,
      list(
        OriginallyDisabled_Female = d$orig_disabled * is_female,
        OriginallyDisabled_Male = d$orig_disabled * is_male
      )
    )
  }

  # Originally ESRD interactions (ESRD V21, V24 Dialysis) - looked up as DI_Originally_ESRD_*
  if (is_aged & is_esrd(d$orec)) {
    act <- cheapr::list_assign(
      act,
      list(
        Originally_ESRD_Female = as.integer(is_female),
        Originally_ESRD_Male = as.integer(is_male)
      )
    )
  }

  # MCAID × sex × age interactions (ESRD V21 Dialysis and Community Graft only)
  # V21 used MCAID; V24 uses FBDual/PBDual (handled in create_dual_interactions)
  if (mcaid) {
    act <- cheapr::list_assign(
      act,
      list(
        MCAID_Female_Aged = is_female * is_aged,
        MCAID_Female_NonAged = is_female * !is_aged,
        MCAID_Male_Aged = is_male * is_aged,
        MCAID_Male_NonAged = is_male * !is_aged
      )
    )
  }

  # LTI interactions for ESRD models
  if (lti) {
    act <- cheapr::list_assign(
      act,
      list(
        # ESRD V24 Dialysis: looked up as DI_LTI_Aged, DI_LTI_NonAged
        LTI_Aged = as.integer(is_aged),
        LTI_NonAged = as.integer(!is_aged),
        # ESRD V24 Graft Institutional: looked up WITHOUT prefix as LTI_GE65, LTI_LT65
        LTI_GE65 = as.integer(is_aged),
        LTI_LT65 = as.integer(!is_aged)
      )
    )
  }

  # LTIMCAID for V24, V28 Institutional model looked up as INS_LTIMCAID
  if (lti & mcaid) {
    act <- cheapr::list_assign(act, list(LTIMCAID = lti * mcaid))
  }

  # New Enrollee interactions for V24, V28, ESRD V21, ESRD V24
  nemcaid = FALSE

  if (d$new & is_dual_valid(d$dual)) {
    nemcaid = TRUE
    ne_origds = d$age >= 65 & identical(d$orec, "1")

    act <- cheapr::list_assign(
      act,
      list(
        # V24, V28, ESRD V21: MCAID/NMCAID style;
        # looked up with NE_ or SNPNE_ prefix
        NMCAID_NORIGDIS = as.integer(!nemcaid & !ne_origds),
        MCAID_NORIGDIS = as.integer(nemcaid & !ne_origds),
        NMCAID_ORIGDIS = as.integer(!nemcaid & ne_origds),
        MCAID_ORIGDIS = as.integer(nemcaid & ne_origds),
        # ESRD V24: FBD/ND_PBD style;
        # looked up with DNE_ or GNE_ prefix
        FBD_NORIGDIS = as.integer(fbd & !ne_origds),
        FBD_ORIGDIS = as.integer(fbd & ne_origds),
        ND_PBD_NORIGDIS = as.integer(!fbd & !ne_origds),
        ND_PBD_ORIGDIS = as.integer(!fbd & ne_origds)
      ) |>
        rlang::set_names(paste0, "_", d$category)
    )
  }

  # Functioning Graft Duration "transplant bumps" for ESRD models
  # All looked up WITHOUT prefix - they match directly by name
  is_dur4_9 = in_between(months, 4L, 9L)
  is_dur10pl = months >= 10L

  # ESRD V21: simple age-based bumps (GE65_DUR4_9, LT65_DUR4_9, etc.)
  if (is_dur4_9) {
    act <- cheapr::list_assign(
      act,
      list(
        GE65_DUR4_9 = as.integer(is_aged),
        LT65_DUR4_9 = as.integer(!is_aged)
      )
    )
  }

  if (is_dur10pl) {
    act <- cheapr::list_assign(
      act,
      list(
        GE65_DUR10PL = as.integer(is_aged),
        LT65_DUR10PL = as.integer(!is_aged)
      )
    )
  }
  return(act)
}

# ESRD V24: FGC (Community) / FGI (Institutional) stratified by dual status
# if (isFALSE(fbd)) {
#     # Non-Dual and Partial Benefit Dual (ND_PBD)
#     if isTRUE(is_dur4_9) {
#       act <- cheapr::list_assign(
#         act,
#         list(
#           FGC_GE65_DUR4_9_ND_PBD = is_aged * !lti,
#           FGC_LT65_DUR4_9_ND_PBD = !is_aged * !lti,
#           FGI_GE65_DUR4_9_ND_PBD = is_aged * lti,
#           FGI_LT65_DUR4_9_ND_PBD = !is_aged * lti
#         )
#       )
#     }
#   }

# if is_dur10pl:
#   interactions.update({
#     'FGC_GE65_DUR10PL_ND_PBD': as.integer(is_aged) * as.integer(not lti),
#     'FGC_LT65_DUR10PL_ND_PBD': as.integer(not is_aged) * as.integer(not lti),
#     'FGI_GE65_DUR10PL_ND_PBD': as.integer(is_aged) * lti,
#     'FGI_LT65_DUR10PL_ND_PBD': as.integer(not is_aged) * lti,
#   })
# # Extra PBD flag for Partial Benefit Dual members
# if pbd:
#   interactions.update({
#     'FGC_PBD_GE65_flag': as.integer(is_aged) * as.integer(not lti),
#     'FGC_PBD_LT65_flag': as.integer(not is_aged) * as.integer(not lti),
#     'FGI_PBD_GE65_flag': as.integer(is_aged) * lti,
#     'FGI_PBD_LT65_flag': as.integer(not is_aged) * lti,
#   })
# else:
#   # Full Benefit Dual (FBD)
#   if is_dur4_9:
#   interactions.update({
#     'FGC_GE65_DUR4_9_FBD': as.integer(is_aged) * as.integer(not lti),
#     'FGC_LT65_DUR4_9_FBD': as.integer(not is_aged) * as.integer(not lti),
#     'FGI_GE65_DUR4_9_FBD': as.integer(is_aged) * lti,
#     'FGI_LT65_DUR4_9_FBD': as.integer(not is_aged) * lti,
#   })
# if is_dur10pl:
#   interactions.update({
#     'FGC_GE65_DUR10PL_FBD': as.integer(is_aged) * as.integer(not lti),
#     'FGC_LT65_DUR10PL_FBD': as.integer(not is_aged) * as.integer(not lti),
#     'FGI_GE65_DUR10PL_FBD': as.integer(is_aged) * lti,
#     'FGI_LT65_DUR10PL_FBD': as.integer(not is_aged) * lti,
#   })

# # Output only non-zero interactions
# interactions = {k: v for k, v in interactions.items() if v > 0}
#
# return(act)
