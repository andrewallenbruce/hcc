#' Is any HCC present?
#'
#' @param needles `<int>` hcc(s) being searched for
#' @param haystack `<int>` hcc(s) being searched in
#' @returns `<int>`, `1` = TRUE, `0` = FALSE
#' @examples
#' any_hcc(17:19, 18:21)
#' any_hcc(17:19, 20:22)
#' @noRd
any_hcc <- function(needles, haystack) {
  as.integer(any_(needles %in_% haystack))
}

#' Creates HCC count variables
#'
#' @param hcc hcc
#' @returns a list of interactions
#' @examples
#' create_hcc_counts(17:19)
#' @noRd
create_hcc_counts <- function(hcc) {
  counts = rlang::set_names(rep.int(0L, 9L), paste0("D", 1:9))
  hcc_count = length(hcc)

  for (i in 1:10) {
    counts[i] = as.integer(hcc_count == i)
    counts["D10P"] = as.integer(hcc_count >= 10L)
  }

  counts[cheapr::which_(counts > 0L)]
}

#' Model-Based Disease Categories
#'
#' @param model `<chr>` Model Name
#' @param hcc `<int>` hcc
#' @returns a list of interactions
#' @examples
#' diagnostic_categories("CMS-HCC Model V24", c(17:19, 85L))
#' @noRd
diagnostic_categories <- function(model, hcc) {
  switch(
    model,
    "CMS-HCC Model V28" = list(
      CANCER_V28 = any_hcc(17:23, hcc),
      DIABETES_V28 = any_hcc(35:38, hcc),
      CARD_RESP_FAIL_V28 = any_hcc(211:213, hcc),
      HF_V28 = any_hcc(221:226, hcc),
      CHR_LUNG_V28 = any_hcc(276:280, hcc),
      KIDNEY_V28 = any_hcc(326:329, hcc),
      SEPSIS_V28 = any_hcc(2L, hcc),
      gSubUseDisorder_V28 = any_hcc(135:139, hcc),
      gPsychiatric_V28 = any_hcc(151:155, hcc),
      NEURO_V28 = any_hcc(c(180:182, 190:192, 195:196, 198:199), hcc),
      ULCER_V28 = any_hcc(379:382, hcc)
    ),
    "CMS-HCC Model V24" = list(
      CANCER = any_hcc(8:12, hcc),
      DIABETES = any_hcc(17:19, hcc),
      CARD_RESP_FAIL = any_hcc(82:84, hcc),
      CHF = any_hcc(85L, hcc),
      gCopdCF = any_hcc(110:112, hcc),
      RENAL_V24 = any_hcc(134:138, hcc),
      SEPSIS = any_hcc(2L, hcc),
      gSubstanceUseDisorder_V24 = any_hcc(54:56, hcc),
      gPsychiatric_V24 = any_hcc(57:60, hcc),
      PRESSURE_ULCER = any_hcc(157:159, hcc)
      # added in 2018-11-20
    ),
    "CMS-HCC Model V22" = list(
      CANCER = any_hcc(8:12, hcc),
      DIABETES = any_hcc(17:19, hcc),
      CARD_RESP_FAIL = any_hcc(82:84, hcc),
      CHF = any_hcc(85L, hcc),
      gCopdCF = any_hcc(110:112, hcc),
      RENAL = any_hcc(134:137, hcc),
      SEPSIS = any_hcc(2L, hcc),
      gSubstanceUseDisorder = any_hcc(54:55, hcc),
      gPsychiatric = any_hcc(57:58, hcc),
      PRESSURE_ULCER = any_hcc(157:158, hcc)
      # added in 2012-10-19
    ),
    "CMS-HCC ESRD Model V24" = list(
      CANCER = any_hcc(8:12, hcc),
      DIABETES = any_hcc(17:19, hcc),
      CARD_RESP_FAIL = any_hcc(82:84, hcc),
      CHF = any_hcc(85L, hcc),
      gCopdCF = any_hcc(110:112, hcc),
      RENAL_V24 = any_hcc(134:138, hcc),
      SEPSIS = any_hcc(2L, hcc),
      gSubstanceUseDisorder_V24 = any_hcc(54:56, hcc),
      gPsychiatric_V24 = any_hcc(57:60, hcc),
      PRESSURE_ULCER = any_hcc(157:160, hcc)
      # added in 2018-11-20
    ),
    "CMS-HCC ESRD Model V21" = list(
      CANCER = any_hcc(8:12, hcc),
      DIABETES = any_hcc(17:19, hcc),
      IMMUNE = any_hcc(47L, hcc),
      CARD_RESP_FAIL = any_hcc(82:84, hcc),
      CHF = any_hcc(85L, hcc),
      COPD = any_hcc(110:111, hcc),
      RENAL = any_hcc(134:141, hcc),
      COMPL = any_hcc(176L, hcc),
      SEPSIS = any_hcc(2L, hcc),
      PRESSURE_ULCER = any_hcc(157:160, hcc)
    ),
    # RxModel doesn't seem to have any diagnostic category interactions
    "RxHCC Model V08" = NULL
  )
  # Keep the zero-valued categories; will be filtered out later
}

#' Model-Based Disease Interaction Variables
#'
#' @param model The HCC model version being used
#' @param diagnostics Dictionary of diagnostic categories
#' @param demographics (Optional) demographic information for age/sex/disability interactions
#' @param hcc (Optional) set of HCCs for direct HCC checks
#' @returns Dictionary containing all disease interaction variables
#' @examplesIf FALSE
#' disease_interactions(model, diagnostics, demographics, hcc)
#' @noRd
disease_interactions <- function(
  model,
  diagnostics,
  demographics,
  hcc
) {
  d = diagnostics
  g = demographics

  switch(
    model,
    # Base V28 disease interactions
    "CMS-HCC Model V28" = list(
      DIABETES_HF_V28 = d[["DIABETES_V28"]] * d[["HF_V28"]],
      HF_CHR_LUNG_V28 = d[["HF_V28"]] * d[["CHR_LUNG_V28"]],
      HF_KIDNEY_V28 = d[["HF_V28"]] * d[["KIDNEY_V28"]],
      CHR_LUNG_CARD_RESP_FAIL_V28 = d[["CHR_LUNG_V28"]] *
        d[["CARD_RESP_FAIL_V28"]],
      HF_HCC238_V28 = d[["HF_V28"]] * 238L %in_% hcc,
      gSubUseDisorder_gPsych_V28 = d[["gSubUseDisorder_V28"]] *
        d[["gPsychiatric_V28"]],
      DISABLED_CANCER_V28 = g@dis_curr * d[["CANCER_V28"]],
      DISABLED_NEURO_V28 = g@dis_curr * d[["NEURO_V28"]],
      DISABLED_HF_V28 = g@dis_curr * d[["HF_V28"]],
      DISABLED_CHR_LUNG_V28 = g@dis_curr * d[["CHR_LUNG_V28"]],
      DISABLED_ULCER_V28 = g@dis_curr * d[["ULCER_V28"]]
    ),
    # Base V24/V22 disease interactions
    "CMS-HCC Model V24" = list(
      DIABETES_HF_V28 = d[["DIABETES_V28"]] * d[["HF_V28"]],
      HF_CHR_LUNG_V28 = d[["HF_V28"]] * d[["CHR_LUNG_V28"]],
      HF_KIDNEY_V28 = d[["HF_V28"]] * d[["KIDNEY_V28"]],
      CHR_LUNG_CARD_RESP_FAIL_V28 = d[["CHR_LUNG_V28"]] *
        d[["CARD_RESP_FAIL_V28"]],
      HF_HCC238_V28 = d[["HF_V28"]] * 238L %in% hcc,
      gSubUseDisorder_gPsych_V28 = d[["gSubUseDisorder_V28"]] *
        d[["gPsychiatric_V28"]],
      DISABLED_CANCER_V28 = g@dis_curr * d[["CANCER_V28"]],
      DISABLED_NEURO_V28 = g@dis_curr * d[["NEURO_V28"]],
      DISABLED_HF_V28 = g@dis_curr * d[["HF_V28"]],
      DISABLED_CHR_LUNG_V28 = g@dis_curr * d[["CHR_LUNG_V28"]],
      DISABLED_ULCER_V28 = g@dis_curr * d[["ULCER_V28"]]
    )
  )
}

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
    # V24, V28, ESRD V21 = MCAID/NMCAID style
    # looked up with NE_ or SNPNE_ prefix
    NMCAID_NORIGDIS = mult_(!nemcaid, !ne_origds),
    MCAID_NORIGDIS = mult_(nemcaid, !ne_origds),
    NMCAID_ORIGDIS = mult_(!nemcaid, ne_origds),
    MCAID_ORIGDIS = mult_(nemcaid, ne_origds),

    # ESRD V24 = FBD/ND_PBD style
    # looked up with DNE_ or GNE_ prefix
    FBD_NORIGDIS = mult_(fbd, !ne_origds),
    FBD_ORIGDIS = mult_(fbd, ne_origds),
    ND_PBD_NORIGDIS = mult_(!fbd, !ne_origds),
    ND_PBD_ORIGDIS = mult_(!fbd, ne_origds)
  ) |>
    rlang::set_names(paste0, "_", x@category)

  x <- rlang::list2(
    # Original Disability interactions (V22, V24, V28, ESRD V21, V24)
    # Only for aged (65+) looked up with prefix (e.g., CNA_, DI_)
    OriginallyDisabled_Female = mult_(aged, x@dis_orig, female),
    OriginallyDisabled_Male = mult_(aged, x@dis_orig, male),

    # Originally ESRD interactions (ESRD V21, V24 Dialysis)
    # Looked up as DI_Originally_ESRD_*
    Originally_ESRD_Female = mult_(
      aged,
      is_esrd(x@orec_code),
      female
    ),
    Originally_ESRD_Male = mult_(aged, is_esrd(x@orec_code), male),

    # MCAID × sex × age interactions
    # (ESRD V21 Dialysis and Community Graft only)
    # V21 used MCAID; V24 uses FBDual/PBDual
    # (handled in create_dual_interactions)
    MCAID_Female_Aged = mult_(mcaid, female, aged),
    MCAID_Female_NonAged = mult_(mcaid, female, !aged),
    MCAID_Male_Aged = mult_(mcaid, male, aged),
    MCAID_Male_NonAged = mult_(mcaid, male, !aged),

    #==== LTI interactions for ESRD models
    # ESRD V24 Dialysis
    # looked up as DI_LTI_Aged, DI_LTI_NonAged
    LTI_Aged = mult_(lti, aged),
    LTI_NonAged = mult_(lti, !aged),

    # ESRD V24 Graft Institutional
    # looked up WITHOUT prefix as LTI_GE65, LTI_LT65
    LTI_GE65 = mult_(lti, aged),
    LTI_LT65 = mult_(lti, !aged),

    # LTIMCAID for V24, V28 Institutional model
    # looked up as INS_LTIMCAID
    LTIMCAID = mult_(lti, mcaid),

    !!!named,

    #==== Functioning Graft Duration `transplant bumps` for ESRD models
    #==== All looked up WITHOUT prefix - they match directly by name
    # ESRD V21 = simple age-based bumps (GE65_DUR4_9, LT65_DUR4_9, etc.)
    GE65_DUR4_9 = mult_(is_dur4_9, aged),
    LT65_DUR4_9 = mult_(is_dur4_9, !aged),

    GE65_DUR10PL = mult_(is_dur10pl, aged),
    LT65_DUR10PL = mult_(is_dur10pl, !aged),

    # ESRD V24 = FGC (Community) / FGI (Institutional) stratified by dual status
    # Non-Dual and Partial Benefit Dual (ND_PBD)

    FGC_GE65_DUR4_9_ND_PBD = mult_(!fbd, is_dur4_9, aged, !lti),
    FGC_LT65_DUR4_9_ND_PBD = mult_(!fbd, is_dur4_9, !aged, !lti),
    FGI_GE65_DUR4_9_ND_PBD = mult_(!fbd, is_dur4_9, aged, lti),
    FGI_LT65_DUR4_9_ND_PBD = mult_(!fbd, is_dur4_9, !aged, lti),
    FGC_GE65_DUR10PL_ND_PBD = mult_(!fbd, is_dur10pl, aged, !lti),
    FGC_LT65_DUR10PL_ND_PBD = mult_(!fbd, is_dur10pl, !aged, !lti),
    FGI_GE65_DUR10PL_ND_PBD = mult_(!fbd, is_dur10pl, aged, lti),
    FGI_LT65_DUR10PL_ND_PBD = mult_(!fbd, is_dur10pl, !aged, lti),

    # Extra PBD flag for Partial Benefit Dual members
    FGC_PBD_GE65_flag = mult_(pbd, aged, !lti),
    FGC_PBD_LT65_flag = mult_(pbd, !aged, !lti),
    FGI_PBD_GE65_flag = mult_(pbd, aged, lti),
    FGI_PBD_LT65_flag = mult_(pbd, !aged, lti),

    FGC_GE65_DUR4_9_FBD = mult_(fbd, is_dur4_9, aged, !lti),
    FGC_LT65_DUR4_9_FBD = mult_(fbd, is_dur4_9, !aged, !lti),
    FGI_GE65_DUR4_9_FBD = mult_(fbd, is_dur4_9, aged, lti),
    FGI_LT65_DUR4_9_FBD = mult_(fbd, is_dur4_9, !aged, lti),

    FGC_GE65_DUR4_9_FBD = mult_(fbd, is_dur10pl, aged, !lti),
    FGC_LT65_DUR4_9_FBD = mult_(fbd, is_dur10pl, !aged, !lti),
    FGI_GE65_DUR4_9_FBD = mult_(fbd, is_dur10pl, aged, lti),
    FGI_LT65_DUR4_9_FBD = mult_(fbd, is_dur10pl, !aged, lti),

    # create_dual_interactions ============
    # Determine sex from demographics.sex instead of category
    # Category can start with NEM/NEF for new enrollees, not just M/F
    FBDual_Female_Aged = mult_(fbd, female, aged),
    FBDual_Female_NonAged = mult_(fbd, female, !aged),
    FBDual_Male_Aged = mult_(fbd, male, aged),
    FBDual_Male_NonAged = mult_(fbd, male, !aged),
    PBDual_Female_Aged = mult_(pbd, female, aged),
    PBDual_Female_NonAged = mult_(pbd, female, !aged),
    PBDual_Male_Aged = mult_(pbd, male, aged),
    PBDual_Male_NonAged = mult_(pbd, male, !aged)
  )

  names(x)[unlist_(x) == 1L]
}
