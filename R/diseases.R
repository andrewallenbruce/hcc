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
