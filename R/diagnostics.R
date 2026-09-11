#' @noRd
DiagnosticCategories <- S7::new_class(
  "DiagnosticCategories",
  properties = list(
    model = S7::class_character,
    hcc = S7::class_integer,
    categories = S7::class_list
  )
)

#' CMS-HCC Model V28
#' @noRd
diagnostic_V28 <- function(hcc) {
  list(
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
  )
}

#' CMS-HCC Model V24
#' @noRd
diagnostic_V24 <- function(hcc) {
  list(
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
  )
}

#' CMS-HCC Model V24
#' @noRd
diagnostic_V22 <- function(hcc) {
  list(
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
  )
}

#' CMS-HCC ESRD Model V24
#' @noRd
diagnostic_ESRD_V24 <- function(hcc) {
  list(
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
  )
}

#' CMS-HCC ESRD Model V21
#' @noRd
diagnostic_ESRD_V21 <- function(hcc) {
  list(
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
  )
}

#' Model-Based Disease Categories
#'
#' @param model `<chr>` Model Name
#' @param hcc `<int>` hcc
#' @returns `<DiagnosticCategories>` S7 object
#' @examples
#' diagnostics(model = "CMS-HCC Model V24", hcc = c(17:19, 85L))
#' @export
diagnostics <- function(model, hcc) {
  DiagnosticCategories(
    model = model,
    hcc = hcc,
    categories = switch(
      model,
      "CMS-HCC Model V28" = diagnostic_V28(hcc),
      "CMS-HCC Model V24" = diagnostic_V24(hcc),
      "CMS-HCC Model V22" = diagnostic_V22(hcc),
      "CMS-HCC Model V22" = diagnostic_V22(hcc),
      "CMS-HCC ESRD Model V24" = diagnostic_ESRD_V24(hcc),
      "CMS-HCC ESRD Model V21" = diagnostic_ESRD_V21(hcc),
      "RxHCC Model V08" = list()
    )
  )
}
