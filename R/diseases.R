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
