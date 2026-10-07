#' @noRd
diag_common <- function(hcc) {
  list(
    CANCER = any_hcc(8:12, hcc),
    DIABETES = any_hcc(17:19, hcc),
    CARD_RESP_FAIL = any_hcc(82:84, hcc),
    CHF = as.integer(85L %in_% hcc),
    SEPSIS = as.integer(2L %in_% hcc)
  )
}

#' @noRd
diag_C28 <- function(hcc) {
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

#' @noRd
diag_C24 <- function(hcc) {
  c(
    diag_common(hcc),
    gCopdCF = any_hcc(110:112, hcc),
    RENAL_V24 = any_hcc(134:138, hcc),
    gSubstanceUseDisorder_V24 = any_hcc(54:56, hcc),
    gPsychiatric_V24 = any_hcc(57:60, hcc),
    PRESSURE_ULCER = any_hcc(157:159, hcc)
  )
}

#' @noRd
diag_C22 <- function(hcc) {
  c(
    diag_common(hcc),
    gCopdCF = any_hcc(110:112, hcc),
    RENAL = any_hcc(134:137, hcc),
    gSubstanceUseDisorder = any_hcc(54:55, hcc),
    gPsychiatric = any_hcc(57:58, hcc),
    PRESSURE_ULCER = any_hcc(157:158, hcc)
  )
}

#' @noRd
diag_D24 <- diag_C24

#' @noRd
diag_D21 <- function(hcc) {
  c(
    diag_common(hcc),
    COPD = any_hcc(110:111, hcc),
    RENAL = any_hcc(134:141, hcc),
    COMPL = as.integer(176L %in_% hcc),
    IMMUNE = as.integer(47L %in_% hcc),
    PRESSURE_ULCER = any_hcc(157:160, hcc)
  )
}

#' @noRd
DiagnosticCategories := S7::new_class(
  properties = list(
    model = S7::class_character,
    hcc = prop_integer,
    category = S7::class_list
  )
)

#' Model-Based Disease Categories
#'
#' @param hcc `<int>` hcc
#' @param model `<chr>` HCC model name:
#'    - `C22`: CMS-HCC Model V22
#'    - `C24`: CMS-HCC Model V24
#'    - `C28`: CMS-HCC Model V28
#'    - `D21`: CMS-HCC ESRD Model V21
#'    - `D24`: CMS-HCC ESRD Model V24
#' @returns `<DiagnosticCategories>` S7 object
#' @examples
#' diagnostics(hcc = c(17:19, 85L), model = "C24")
#' @export
diagnostics <- function(model, hcc) {
  x = switch(
    model,
    "C28" = diag_C28(hcc),
    "C24" = diag_C24(hcc),
    "C22" = diag_C22(hcc),
    "D24" = diag_D24(hcc),
    "D21" = diag_D21(hcc),
    NULL
  )

  DiagnosticCategories(
    hcc = hcc,
    model = convert_model(model),
    category = x %||% list()
  )
}
