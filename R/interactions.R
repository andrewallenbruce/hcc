#' CMS-HCC Model V28
#' @noRd
disease_V28 <- function(x, current, hcc) {
  list(
    DIABETES_HF_V28 = mult_(x[["DIABETES_V28"]], x[["HF_V28"]]),
    HF_CHR_LUNG_V28 = mult_(x[["HF_V28"]], x[["CHR_LUNG_V28"]]),
    HF_KIDNEY_V28 = mult_(x[["HF_V28"]], x[["KIDNEY_V28"]]),
    CHR_LUNG_CARD_RESP_FAIL_V28 = mult_(
      x[["CHR_LUNG_V28"]],
      x[["CARD_RESP_FAIL_V28"]]
    ),
    HF_HCC238_V28 = mult_(x[["HF_V28"]], any_hcc(238L, hcc)),
    gSubUseDisorder_gPsych_V28 = mult_(
      x[["gSubUseDisorder_V28"]],
      x[["gPsychiatric_V28"]]
    ),
    DISABLED_CANCER_V28 = mult_(current, x[["CANCER_V28"]]),
    DISABLED_NEURO_V28 = mult_(current, x[["NEURO_V28"]]),
    DISABLED_HF_V28 = mult_(current, x[["HF_V28"]]),
    DISABLED_CHR_LUNG_V28 = mult_(current, x[["CHR_LUNG_V28"]]),
    DISABLED_ULCER_V28 = mult_(current, x[["ULCER_V28"]])
  )
}

#' CMS-HCC Model V24
#' @noRd
disease_V24 <- function(x, current, hcc) {
  list(
    HCC47_gCancer = mult_(any_hcc(47L, hcc), x[["CANCER"]]),
    DIABETES_CHF = mult_(x[["DIABETES"]], x[["CHF"]]),
    CHF_gCopdCF = mult_(x[["CHF"]], x[["gCopdCF"]]),
    HCC85_gRenal_V24 = mult_(x[["CHF"]], x[["RENAL_V24"]]),
    gCopdCF_CARD_RESP_FAIL = mult_(x[["gCopdCF"]], x[["CARD_RESP_FAIL"]]),
    HCC85_HCC96 = mult_(any_hcc(85L, hcc), any_hcc(96L, hcc)),
    gSubstanceUseDisorder_gPsych = mult_(
      x[["gSubstanceUseDisorder_V24"]],
      x[["gPsychiatric_V24"]]
    ),
    SEPSIS_PRESSURE_ULCER = mult_(x[["SEPSIS"]], x[["PRESSURE_ULCER"]]),
    SEPSIS_ARTIF_OPENINGS = mult_(x[["SEPSIS"]], any_hcc(188L, hcc)),
    ART_OPENINGS_PRESS_ULCER = mult_(any_hcc(188L, hcc), x[["PRESSURE_ULCER"]]),
    gCopdCF_ASP_SPEC_B_PNEUM = mult_(x[["gCopdCF"]], any_hcc(114L, hcc)),
    ASP_SPEC_B_PNEUM_PRES_ULC = mult_(
      any_hcc(114L, hcc),
      x[["PRESSURE_ULCER"]]
    ),
    SEPSIS_ASP_SPEC_BACT_PNEUM = mult_(x[["SEPSIS"]], any_hcc(114L, hcc)),
    SCHIZOPHRENIA_gCopdCF = mult_(any_hcc(57L, hcc), x[["gCopdCF"]]),
    SCHIZOPHRENIA_CHF = mult_(any_hcc(57L, hcc), x[["CHF"]]),
    SCHIZOPHRENIA_SEIZURES = mult_(any_hcc(57L, hcc), any_hcc(79L, hcc)),
    DISABLED_HCC85 = mult_(current, any_hcc(85L, hcc)),
    DISABLED_PRESSURE_ULCER = mult_(current, x[["PRESSURE_ULCER"]]),
    DISABLED_HCC161 = mult_(current, any_hcc(161L, hcc)),
    DISABLED_HCC39 = mult_(current, any_hcc(39L, hcc)),
    DISABLED_HCC77 = mult_(current, any_hcc(77L, hcc)),
    DISABLED_HCC6 = mult_(current, any_hcc(6L, hcc))
  )
}

#' CMS-HCC Model V22
#' @noRd
disease_V22 <- function(x, current, hcc) {
  list(
    HCC47_gCancer = mult_(any_hcc(47L, hcc), x[["CANCER"]]),
    HCC85_gDiabetesMellitus = mult_(any_hcc(85L, hcc), x[["DIABETES"]]),
    HCC85_gCopdCF = mult_(any_hcc(85L, hcc), x[["gCopdCF"]]),
    HCC85_gRenal = mult_(any_hcc(85L, hcc), x[["RENAL"]]),
    gRespDepandArre_gCopdCF = mult_(x[["CARD_RESP_FAIL"]], x[["gCopdCF"]]),
    HCC85_HCC96 = mult_(any_hcc(85L, hcc), any_hcc(188L, hcc)),
    gSubstanceAbuse_gPsychiatric = mult_(
      x[["gSubstanceUseDisorder"]],
      x[["gPsychiatric"]]
    ),
    DIABETES_CHF = mult_(x[["DIABETES"]], x[["CHF"]]),
    CHF_gCopdCF = mult_(x[["CHF"]], x[["gCopdCF"]]),
    gCopdCF_CARD_RESP_FAIL = mult_(x[["gCopdCF"]], x[["CARD_RESP_FAIL"]]),
    SEPSIS_PRESSURE_ULCER = mult_(x[["SEPSIS"]], x[["PRESSURE_ULCER"]]),
    SEPSIS_ARTIF_OPENINGS = mult_(x[["SEPSIS"]], any_hcc(188L, hcc)),
    ART_OPENINGS_PRESSURE_ULCER = mult_(
      any_hcc(188L, hcc),
      x[["PRESSURE_ULCER"]]
    ),
    DIABETES_CHF = mult_(x[["DIABETES"]], x[["CHF"]]),
    gCopdCF_ASP_SPEC_BACT_PNEUM = mult_(x[["gCopdCF"]], any_hcc(114L, hcc)),
    ASP_SPEC_BACT_PNEUM_PRES_ULC = mult_(
      any_hcc(114L, hcc),
      x[["PRESSURE_ULCER"]]
    ),
    SEPSIS_ASP_SPEC_BACT_PNEUM = mult_(x[["SEPSIS"]], any_hcc(114L, hcc)),
    SCHIZOPHRENIA_gCopdCF = mult_(any_hcc(57L, hcc), x[["gCopdCF"]]),
    SCHIZOPHRENIA_CHF = mult_(any_hcc(57L, hcc), x[["CHF"]]),
    SCHIZOPHRENIA_SEIZURES = mult_(any_hcc(57L, hcc), any_hcc(79L, hcc)),
    DISABLED_HCC85 = mult_(current, any_hcc(85L, hcc)),
    DISABLED_PRESSURE_ULCER = mult_(current, x[["PRESSURE_ULCER"]]),
    DISABLED_HCC161 = mult_(current, any_hcc(161L, hcc)),
    DISABLED_HCC39 = mult_(current, any_hcc(39L, hcc)),
    DISABLED_HCC77 = mult_(current, any_hcc(77L, hcc)),
    DISABLED_HCC6 = mult_(current, any_hcc(6L, hcc))
  )
}

#' CMS-HCC ESRD Model V24
#' @noRd
disease_ESRD_V24 <- function(x, non_aged, hcc) {
  list(
    HCC47_gCancer = mult_(any_hcc(47L, hcc), x[["CANCER"]]),
    DIABETES_CHF = mult_(x[["DIABETES"]], x[["CHF"]]),
    CHF_gCopdCF = mult_(x[["CHF"]], x[["gCopdCF"]]),
    HCC85_gRenal_V24 = mult_(any_hcc(85L, hcc), x[["RENAL_V24"]]),
    gCopdCF_CARD_RESP_FAIL = mult_(x[["gCopdCF"]], x[["CARD_RESP_FAIL"]]),
    HCC85_HCC96 = mult_(any_hcc(85L, hcc), any_hcc(96L, hcc)),
    gSubUseDs_gPsych_V24 = mult_(
      x[["gSubstanceUseDisorder_V24"]],
      x[["gPsychiatric_V24"]]
    ),
    NONAGED_gSubUseDs_gPsych = mult_(
      non_aged,
      x[["gSubstanceUseDisorder_V24"]],
      x[["gPsychiatric_V24"]]
    ),
    NONAGED_HCC6 = mult_(non_aged, any_hcc(6L, hcc)),
    NONAGED_HCC34 = mult_(non_aged, any_hcc(34L, hcc)),
    NONAGED_HCC46 = mult_(non_aged, any_hcc(46L, hcc)),
    NONAGED_HCC110 = mult_(non_aged, any_hcc(110L, hcc)),
    NONAGED_HCC176 = mult_(non_aged, any_hcc(176L, hcc)),
    SEPSIS_PRESSURE_ULCER_V24 = mult_(x[["SEPSIS"]], x[["PRESSURE_ULCER"]]),
    SEPSIS_ARTIF_OPENINGS = mult_(x[["SEPSIS"]], any_hcc(188L, hcc)),
    ART_OPENINGS_PRESS_ULCER_V24 = mult_(
      any_hcc(188L, hcc),
      x[["PRESSURE_ULCER"]]
    ),
    gCopdCF_ASP_SPEC_B_PNEUM = mult_(x[["gCopdCF"]], any_hcc(114L, hcc)),
    ASP_SPEC_B_PNEUM_PRES_ULC_V24 = mult_(
      any_hcc(114L, hcc),
      x[["PRESSURE_ULCER"]]
    ),
    SEPSIS_ASP_SPEC_BACT_PNEUM = mult_(x[["SEPSIS"]], any_hcc(114L, hcc)),
    SCHIZOPHRENIA_gCopdCF = mult_(any_hcc(57L, hcc), x[["gCopdCF"]]),
    SCHIZOPHRENIA_CHF = mult_(any_hcc(57L, hcc), x[["CHF"]]),
    SCHIZOPHRENIA_SEIZURES = mult_(any_hcc(57L, hcc), any_hcc(79L, hcc)),
    NONAGED_HCC85 = mult_(non_aged, any_hcc(85L, hcc)),
    NONAGED_PRESSURE_ULCER_V24 = mult_(non_aged, x[["PRESSURE_ULCER"]]),
    NONAGED_HCC161 = mult_(non_aged, any_hcc(161L, hcc)),
    NONAGED_HCC39 = mult_(non_aged, any_hcc(39L, hcc)),
    NONAGED_HCC77 = mult_(non_aged, any_hcc(77L, hcc))
  )
}

#' CMS-HCC ESRD Model V21
#' @noRd
disease_ESRD_V21 <- function(x, non_aged, hcc) {
  list(
    HCC47_gCancer = mult_(any_hcc(47L, hcc), x[["CANCER"]]),
    DIABETES_CHF = mult_(x[["DIABETES"]], x[["CHF"]]),
    CHF_gCopdCF = mult_(x[["CHF"]], x[["gCopdCF"]]),
    HCC85_gRenal_V24 = mult_(any_hcc(85L, hcc), x[["RENAL_V24"]]),
    gCopdCF_CARD_RESP_FAIL = mult_(x[["gCopdCF"]], x[["CARD_RESP_FAIL"]]),
    HCC85_HCC96 = mult_(any_hcc(85L, hcc), any_hcc(96L, hcc)),
    gSubUseDs_gPsych_V24 = mult_(
      x[["gSubstanceUseDisorder_V24"]],
      x[["gPsychiatric_V24"]]
    ),
    NONAGED_gSubUseDs_gPsych = mult_(
      non_aged,
      x[["gSubstanceUseDisorder_V24"]],
      x[["gPsychiatric_V24"]]
    ),
    NONAGED_HCC6 = mult_(non_aged, any_hcc(6L, hcc)),
    NONAGED_HCC34 = mult_(non_aged, any_hcc(34L, hcc)),
    NONAGED_HCC46 = mult_(non_aged, any_hcc(46L, hcc)),
    NONAGED_HCC110 = mult_(non_aged, any_hcc(110L, hcc)),
    NONAGED_HCC176 = mult_(non_aged, any_hcc(176L, hcc)),
    SEPSIS_PRESSURE_ULCER_V24 = mult_(x[["SEPSIS"]], x[["PRESSURE_ULCER"]]),
    SEPSIS_ARTIF_OPENINGS = mult_(x[["SEPSIS"]], any_hcc(188L, hcc)),
    ART_OPENINGS_PRESS_ULCER_V24 = mult_(
      any_hcc(188L, hcc),
      x[["PRESSURE_ULCER"]]
    ),
    gCopdCF_ASP_SPEC_B_PNEUM = mult_(x[["gCopdCF"]], any_hcc(114L, hcc)),
    ASP_SPEC_B_PNEUM_PRES_ULC_V24 = mult_(
      any_hcc(114L, hcc),
      x[["PRESSURE_ULCER"]]
    ),
    SEPSIS_ASP_SPEC_BACT_PNEUM = mult_(x[["SEPSIS"]], any_hcc(114L, hcc)),
    SCHIZOPHRENIA_gCopdCF = mult_(any_hcc(57L, hcc), x[["gCopdCF"]]),
    SCHIZOPHRENIA_CHF = mult_(any_hcc(57L, hcc), x[["CHF"]]),
    SCHIZOPHRENIA_SEIZURES = mult_(any_hcc(57L, hcc), any_hcc(79L, hcc)),
    NONAGED_HCC85 = mult_(non_aged, any_hcc(85L, hcc)),
    NONAGED_PRESSURE_ULCER_V24 = mult_(non_aged, x[["PRESSURE_ULCER"]]),
    NONAGED_HCC161 = mult_(non_aged, any_hcc(161L, hcc)),
    NONAGED_HCC39 = mult_(non_aged, any_hcc(39L, hcc)),
    NONAGED_HCC77 = mult_(non_aged, any_hcc(77L, hcc))
  )
}

#' RxHCC Model V08
#' @noRd
disease_RxHCC_V8 <- function(non_aged, hcc) {
  list(
    NonAged_RXHCC1 = mult_(non_aged, any_hcc(1L, hcc)),
    NonAged_RXHCC130 = mult_(non_aged, any_hcc(130L, hcc)),
    NonAged_RXHCC131 = mult_(non_aged, any_hcc(131L, hcc)),
    NonAged_RXHCC132 = mult_(non_aged, any_hcc(132L, hcc)),
    NonAged_RXHCC133 = mult_(non_aged, any_hcc(133L, hcc)),
    NonAged_RXHCC159 = mult_(non_aged, any_hcc(159L, hcc)),
    NonAged_RXHCC163 = mult_(non_aged, any_hcc(163L, hcc))
  )
}

#' Model-Based Disease Interaction Variables
#'
#' @param diagnostics Dictionary of diagnostic categories
#' @param demographics (Optional) demographic information for age/sex/disability interactions
#' @returns Dictionary containing all disease interaction variables
#' @examples
#' disease_interactions(
#'   diagnostics(model = "CMS-HCC Model V24", hcc = c(17L, 85L)),
#'   demographics(age = 64, sex = "F", orec = "1")
#'  )
#' @export
disease_interactions <- function(
  diagnostics,
  demographics = NULL
) {
  if (is.null(demographics)) {
    demographics <- PatientDemographics(
      dis_curr = FALSE,
      non_aged = FALSE
    )
  }

  x <- switch(
    diagnostics@model,
    "CMS-HCC Model V28" = disease_V28(
      diagnostics@categories,
      demographics@dis_curr,
      diagnostics@hcc
    ),
    "CMS-HCC Model V24" = disease_V24(
      diagnostics@categories,
      demographics@dis_curr,
      diagnostics@hcc
    ),
    "CMS-HCC Model V22" = disease_V22(
      diagnostics@categories,
      demographics@dis_curr,
      diagnostics@hcc
    ),
    "CMS-HCC ESRD Model V24" = disease_ESRD_V24(
      diagnostics@categories,
      demographics@non_aged,
      diagnostics@hcc
    ),
    "CMS-HCC ESRD Model V21" = disease_ESRD_V21(
      diagnostics@categories,
      demographics@non_aged,
      diagnostics@hcc
    ),
    "RxHCC Model V08" = disease_RxHCC_V8(
      demographics@non_aged,
      diagnostics@hcc
    )
  )

  names(x)[unlist_(x) == 1L]
}

#' Create Demographic Interactions
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

  ## New Enrollee [V24/V28/ESRD V21/V24]
  named <- list(
    # [V24/V28/ESRD V21] -> MCAID/NMCAID style
    # looked up with `NE_` or `SNPNE_`
    NMCAID_NORIGDIS = mult_(!nemcaid, !ne_origds),
    NMCAID_ORIGDIS = mult_(!nemcaid, ne_origds),
    MCAID_NORIGDIS = mult_(nemcaid, !ne_origds),
    MCAID_ORIGDIS = mult_(nemcaid, ne_origds),

    # ESRD V24 -> FBD/ND_PBD style
    # looked up with DNE_ or GNE_ prefix
    FBD_NORIGDIS = mult_(fbd, !ne_origds),
    FBD_ORIGDIS = mult_(fbd, ne_origds),
    ND_PBD_NORIGDIS = mult_(!fbd, !ne_origds),
    ND_PBD_ORIGDIS = mult_(!fbd, ne_origds)
  ) |>
    rlang::set_names(paste0, "_", x@category)

  x <- rlang::list2(
    # Original Disability [V22/V24/V28/ESRD V21/V24]
    # Only for aged - looked up with prefix
    OriginallyDisabled_Female = mult_(aged, x@dis_orig, female),
    OriginallyDisabled_Male = mult_(aged, x@dis_orig, male),

    # Originally ESRD [ESRD V21/V24 Dialysis]
    # Looked up as `DI_Originally_ESRD_*`
    Originally_ESRD_Female = mult_(aged, is_esrd, female),
    Originally_ESRD_Male = mult_(aged, is_esrd, male),

    # MCAID × sex × age interactions
    # (ESRD V21 Dialysis and Community Graft only)
    # V21 used MCAID; V24 uses FBDual/PBDual
    # (handled in create_dual_interactions)
    MCAID_Female_Aged = mult_(mcaid, female, aged),
    MCAID_Female_NonAged = mult_(mcaid, female, !aged),
    MCAID_Male_Aged = mult_(mcaid, male, aged),
    MCAID_Male_NonAged = mult_(mcaid, male, !aged),

    # ==== LTI interactions for ESRD models

    # ESRD V24 Dialysis looked up as DI_LTI_Aged, DI_LTI_NonAged
    LTI_Aged = mult_(lti, aged),
    LTI_NonAged = mult_(lti, !aged),

    # ESRD V24 Graft Institutional looked up WITHOUT prefix
    LTI_GE65 = mult_(lti, aged),
    LTI_LT65 = mult_(lti, !aged),

    # LTIMCAID for V24, V28 Institutional model looked up as INS_LTIMCAID
    LTIMCAID = mult_(lti, mcaid),

    !!!named,

    # ==== Functioning Graft Duration `transplant bumps` for ESRD models
    # All looked up WITHOUT prefix - they match directly by name
    # ESRD V21 = simple age-based bumps (GE65_DUR4_9, LT65_DUR4_9, etc.)
    GE65_DUR4_9 = mult_(is_dur4_9, aged),
    LT65_DUR4_9 = mult_(is_dur4_9, !aged),

    GE65_DUR10PL = mult_(is_dur10pl, aged),
    LT65_DUR10PL = mult_(is_dur10pl, !aged),

    # ESRD V24 = FGC (Community) / FGI (Institutional) stratified by dual status
    # Non-Dual and Partial Benefit Dual (ND_PBD)

    FGC_GE65_DUR4_9_ND_PBD = mult_(!fbd, is_dur4_9, aged, !lti),
    FGC_GE65_DUR10PL_ND_PBD = mult_(!fbd, is_dur10pl, aged, !lti),
    FGC_GE65_DUR10PL_FBD = mult_(fbd, is_dur10pl, aged, !lti),
    FGC_GE65_DUR4_9_FBD = mult_(fbd, is_dur4_9, aged, !lti),
    FGC_LT65_DUR4_9_ND_PBD = mult_(!fbd, is_dur4_9, !aged, !lti),
    FGC_LT65_DUR10PL_ND_PBD = mult_(!fbd, is_dur10pl, !aged, !lti),
    FGC_LT65_DUR10PL_FBD = mult_(fbd, is_dur10pl, !aged, !lti),
    FGC_LT65_DUR4_9_FBD = mult_(fbd, is_dur4_9, !aged, !lti),
    FGC_PBD_GE65_flag = mult_(pbd, aged, !lti),
    FGC_PBD_LT65_flag = mult_(pbd, !aged, !lti),

    FGI_GE65_DUR4_9_FBD = mult_(fbd, is_dur4_9, aged, lti),
    FGI_GE65_DUR4_9_ND_PBD = mult_(!fbd, is_dur4_9, aged, lti),
    FGI_GE65_DUR10PL_ND_PBD = mult_(!fbd, is_dur10pl, aged, lti),
    FGI_GE65_DUR10PL_FBD = mult_(fbd, is_dur10pl, aged, lti),
    FGI_LT65_DUR4_9_FBD = mult_(fbd, is_dur4_9, !aged, lti),
    FGI_LT65_DUR4_9_ND_PBD = mult_(!fbd, is_dur4_9, !aged, lti),
    FGI_LT65_DUR10PL_ND_PBD = mult_(!fbd, is_dur10pl, !aged, lti),
    FGI_LT65_DUR10PL_FBD = mult_(fbd, is_dur10pl, !aged, lti),
    FGI_PBD_GE65_flag = mult_(pbd, aged, lti),
    FGI_PBD_LT65_flag = mult_(pbd, !aged, lti),

    # create_dual_interactions
    # Determine sex from demographics@sex instead of category
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
