x <- interactions(
  PatientDemographics(
    age = 65,
    sex = "F",
    category = "F65",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = TRUE,
    dual_part = FALSE,
    is_lti = FALSE
  )
)

test_that("Demographic interactions work", {
  expect_no_match(x, "OriginallyDisabled_Female")
  expect_no_match(x, "OriginallyDisabled_Male")
  expect_no_match(x, "LTI_Aged")
  expect_no_match(x, "LTI_NonAged")
})

test_that("Dual interactions work", {
  expect_match(x, "FBDual_Female_Aged", all = FALSE)
  expect_no_match(x, "FBDual_Female_NonAged")
  expect_no_match(x, "FBDual_Male_Aged")
  expect_no_match(x, "FBDual_Male_NonAged")
  expect_no_match(x, "PBDual_Female_Aged")
})

test_that("apply_interactions works", {
  x = apply_interactions(
    diagnostics("CMS-HCC Model V24", c(17:18, 85L)),
    PatientDemographics(
      age = 65,
      sex = "F",
      category = "F65",
      dis_curr = FALSE,
      dis_orig = FALSE,
      non_aged = FALSE,
      dual_full = TRUE,
      dual_part = FALSE,
      is_lti = FALSE
    )
  )
  expect_contains(unlist_(x), c("FBDual_Female_Aged", "D3", "DIABETES_CHF"))
})

# =============================================================================
# ESRD V21 Duration Interactions
# =============================================================================
# Test ESRD V21 simple age-based duration interactions.

test_that("Aged patient with 6 months graft should get `GE65_DUR4_9`", {
  x <- PatientDemographics(
    age = 70,
    sex = "F",
    category = "F70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = FALSE,
    dual_part = FALSE,
    is_lti = FALSE,
    esrd_months = 6L,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_contains(x, "GE65_DUR4_9")
  expect_disjoint(x, c("LT65_DUR4_9", "GE65_DUR10PL"))
})

test_that("Non-aged patient with 5 months graft should get `LT65_DUR4_9`", {
  x <- PatientDemographics(
    age = 55,
    sex = "F",
    category = "M55_59",
    dis_curr = TRUE,
    dis_orig = FALSE,
    non_aged = TRUE,
    dual_full = FALSE,
    dual_part = FALSE,
    is_lti = FALSE,
    esrd_months = 5L,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_contains(x, "LT65_DUR4_9")
  expect_disjoint(x, "GE65_DUR4_9")
})

test_that("Aged patient with 15 months graft should get `GE65_DUR10PL`", {
  x <- PatientDemographics(
    age = 72,
    sex = "F",
    category = "F70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = FALSE,
    dual_part = FALSE,
    is_lti = FALSE,
    esrd_months = 15L,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_contains(x, "GE65_DUR10PL")
  expect_disjoint(x, c("LT65_DUR10PL", "GE65_DUR4_9"))
})

test_that("Non-aged patient with 24 months graft should get `LT65_DUR10PL`", {
  x <- PatientDemographics(
    age = 50,
    sex = "M",
    category = "M50_54",
    dis_curr = TRUE,
    dis_orig = FALSE,
    non_aged = TRUE,
    dual_full = FALSE,
    dual_part = FALSE,
    is_lti = FALSE,
    esrd_months = 24L,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_contains(x, "LT65_DUR10PL")
  expect_disjoint(x, "GE65_DUR10PL")
})

test_that("Patient with < 4 months graft should not get any duration interactions", {
  x <- PatientDemographics(
    age = 70,
    sex = "M",
    category = "F70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = FALSE,
    dual_part = FALSE,
    is_lti = FALSE,
    esrd_months = 3L,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_disjoint(
    x,
    c("GE65_DUR4_9", "LT65_DUR4_9", "GE65_DUR10PL", "LT65_DUR10PL")
  )
})

# =============================================================================
# ESRD V24 FGC/FGI Interactions - Non-Dual/Partial Benefit Dual (ND_PBD)
# =============================================================================

# Test ESRD V24 FGC (Community) interactions for ND_PBD
test_that("Aged community patient (not LTI, not FBD) with 6 months graft", {
  x <- PatientDemographics(
    age = 70,
    sex = "F",
    category = "F70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = FALSE,
    dual_part = FALSE,
    is_lti = FALSE,
    esrd_months = 6L,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_contains(x, "FGC_GE65_DUR4_9_ND_PBD")
  expect_disjoint(x, c("FGC_LT65_DUR4_9_ND_PBD", "FGI_GE65_DUR4_9_ND_PBD"))
})

test_that("Non-aged community patient with 12 months graft", {
  x <- PatientDemographics(
    age = 55,
    sex = "M",
    category = "M55_59",
    dis_curr = TRUE,
    dis_orig = FALSE,
    non_aged = TRUE,
    dual_full = FALSE,
    dual_part = FALSE,
    is_lti = FALSE,
    esrd_months = 12L,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_contains(x, "FGC_LT65_DUR10PL_ND_PBD")
  expect_disjoint(x, "FGC_GE65_DUR10PL_ND_PBD")
})

# Test ESRD V24 FGI (Institutional) interactions for ND_PBD
test_that("Aged LTI patient (not FBD) with 6 months graft should get FGI", {
  x <- PatientDemographics(
    age = 70,
    sex = "F",
    category = "F70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = FALSE,
    dual_part = FALSE,
    is_lti = TRUE,
    esrd_months = 6L,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_contains(x, "FGI_GE65_DUR4_9_ND_PBD")
  expect_disjoint(x, "FGC_GE65_DUR4_9_ND_PBD")
})

test_that("Non-aged LTI patient with 15 months graft", {
  x <- PatientDemographics(
    age = 55,
    sex = "M",
    category = "M55_59",
    dis_curr = TRUE,
    dis_orig = FALSE,
    non_aged = TRUE,
    dual_full = FALSE,
    dual_part = FALSE,
    is_lti = TRUE,
    esrd_months = 15L,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_contains(x, "FGI_LT65_DUR10PL_ND_PBD")
  expect_disjoint(x, "FGC_LT65_DUR10PL_ND_PBD")
})

# =============================================================================
# ESRD V24 FGC/FGI Interactions - Full Benefit Dual (FBD)
# =============================================================================

# Test ESRD V24 FGC (Community) interactions for FBD
test_that("Aged FBD community patient with 6 months graft", {
  x <- PatientDemographics(
    age = 70,
    sex = "F",
    category = "F70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = TRUE,
    dual_part = FALSE,
    is_lti = FALSE,
    esrd_months = 6L,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_contains(x, "FGC_GE65_DUR4_9_FBD")
  expect_disjoint(x, c("FGC_LT65_DUR4_9_FBD", "FGC_GE65_DUR4_9_ND_PBD"))
})

test_that("Non-aged FBD community patient with 12 months graft", {
  x <- PatientDemographics(
    age = 55,
    sex = "M",
    category = "M55_59",
    dis_curr = TRUE,
    dis_orig = FALSE,
    non_aged = TRUE,
    dual_full = TRUE,
    dual_part = FALSE,
    is_lti = FALSE,
    esrd_months = 12L,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_contains(x, "FGC_LT65_DUR10PL_FBD")
  expect_disjoint(x, "FGC_GE65_DUR10PL_FBD")
})

# Test ESRD V24 FGI (Institutional) interactions for FBD
test_that("Aged FBD LTI patient with 6 months graft should get FGI_FBD", {
  x <- PatientDemographics(
    age = 70,
    sex = "F",
    category = "F70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = TRUE,
    dual_part = FALSE,
    is_lti = TRUE,
    esrd_months = 6L,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_contains(x, "FGI_GE65_DUR4_9_FBD")
  expect_disjoint(x, "FGC_GE65_DUR4_9_FBD")
})

test_that("Non-aged FBD LTI patient with 15 months graft", {
  x <- PatientDemographics(
    age = 55,
    sex = "M",
    category = "M55_59",
    dis_curr = TRUE,
    dis_orig = FALSE,
    non_aged = TRUE,
    dual_full = TRUE,
    dual_part = FALSE,
    is_lti = TRUE,
    esrd_months = 15L,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_contains(x, "FGI_LT65_DUR10PL_FBD")
  expect_disjoint(x, "FGC_LT65_DUR10PL_FBD")
})

# =============================================================================
# ESRD V24 PBD Flag Coefficients
# =============================================================================

# Test ESRD V24 PBD (Partial Benefit Dual) flag interactions
test_that("PBD aged community patient should get PBD flag", {
  x <- PatientDemographics(
    age = 70,
    sex = "F",
    category = "F70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = FALSE,
    dual_part = TRUE,
    is_lti = FALSE,
    esrd_months = 6L,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_contains(x, "FGC_PBD_GE65_flag")
  expect_disjoint(x, c("FGC_PBD_LT65_flag", "FGI_PBD_GE65_flag"))
})

test_that("PBD non-aged LTI patient should get FGI PBD flag", {
  x <- PatientDemographics(
    age = 55,
    sex = "M",
    category = "M55_59",
    dis_curr = TRUE,
    dis_orig = FALSE,
    non_aged = TRUE,
    dual_full = FALSE,
    dual_part = TRUE,
    is_lti = TRUE,
    esrd_months = 6L,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_contains(x, "FGI_PBD_LT65_flag")
  expect_disjoint(x, "FGC_PBD_LT65_flag")
})

test_that("FBD patient should NOT get PBD flag", {
  x <- PatientDemographics(
    age = 70,
    sex = "F",
    category = "F70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = TRUE,
    dual_part = FALSE,
    is_lti = FALSE,
    esrd_months = 6L,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_disjoint(x, c("FGC_PBD_GE65_flag", "FGC_PBD_LT65_flag"))
})

# =============================================================================
# ESRD V24 LTI_GE65/LTI_LT65 Graft Institutional Interactions
# =============================================================================

# Test ESRD V24 LTI_GE65/LTI_LT65 interactions for Graft Institutional
test_that("Aged LTI patient should get LTI_GE65", {
  x <- PatientDemographics(
    age = 70,
    sex = "F",
    category = "F70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = FALSE,
    dual_part = FALSE,
    is_lti = TRUE,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_contains(x, c("LTI_GE65", "LTI_Aged"))
  expect_disjoint(x, "LTI_LT65")
})

test_that("Non-aged LTI patient should get LTI_LT65", {
  x <- PatientDemographics(
    age = 55,
    sex = "M",
    category = "M55_59",
    dis_curr = TRUE,
    dis_orig = FALSE,
    non_aged = TRUE,
    dual_full = FALSE,
    dual_part = FALSE,
    is_lti = TRUE,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_contains(x, c("LTI_LT65", "LTI_NonAged"))
  expect_disjoint(x, "LTI_GE65")
})

test_that("Non-LTI patient should NOT get LTI interactions", {
  x <- PatientDemographics(
    age = 70,
    sex = "F",
    category = "F70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = FALSE,
    dual_part = FALSE,
    is_lti = FALSE,
    has_esrd = TRUE
  ) |>
    interactions()

  expect_disjoint(x, c("LTI_GE65", "LTI_LT65", "LTI_Aged", "LTI_NonAged"))
})

# =============================================================================
# ESRD V21 Originally ESRD and MCAID Interactions
# =============================================================================

# Test Originally_ESRD interactions for ESRD V21 and V24
test_that("Aged female with OREC = 2 (originally ESRD) should get Originally_ESRD_Female", {
  x <- PatientDemographics(
    age = 70,
    sex = "F",
    category = "F70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = FALSE,
    dual_part = FALSE,
    is_lti = FALSE,
    has_esrd = TRUE,
    orec_code = "2"
  ) |>
    interactions()

  expect_contains(x, "Originally_ESRD_Female")
  expect_disjoint(x, "Originally_ESRD_Male")
})

test_that("Aged male with OREC = 3 should get Originally_ESRD_Male", {
  x <- PatientDemographics(
    age = 70,
    sex = "M",
    category = "M70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = FALSE,
    dual_part = FALSE,
    is_lti = FALSE,
    has_esrd = TRUE,
    orec_code = "3"
  ) |>
    interactions()

  expect_contains(x, "Originally_ESRD_Male")
  expect_disjoint(x, "Originally_ESRD_Female")
})

test_that("Non-aged should NOT get Originally_ESRD interactions", {
  x <- PatientDemographics(
    age = 55,
    sex = "F",
    category = "F55_59",
    dis_curr = TRUE,
    dis_orig = FALSE,
    non_aged = TRUE,
    dual_full = FALSE,
    dual_part = FALSE,
    is_lti = FALSE,
    has_esrd = TRUE,
    orec_code = "2"
  ) |>
    interactions()

  expect_disjoint(x, c("Originally_ESRD_Female", "Originally_ESRD_Male"))
})

test_that("Aged without OREC = 2 or 3 should NOT get Originally_ESRD", {
  x <- PatientDemographics(
    age = 70,
    sex = "F",
    category = "F70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = FALSE,
    dual_part = FALSE,
    is_lti = FALSE,
    has_esrd = TRUE,
    orec_code = "0"
  ) |>
    interactions()

  expect_disjoint(x, "Originally_ESRD_Female")
})

# Test MCAID × sex × age interactions for ESRD V21
test_that("Aged female with Medicaid should get MCAID_Female_Aged", {
  x <- PatientDemographics(
    age = 70,
    sex = "F",
    category = "F70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = TRUE,
    dual_part = FALSE,
    is_lti = FALSE,
    has_esrd = TRUE,
    dual_code = "02"
  ) |>
    interactions()

  expect_contains(x, "MCAID_Female_Aged")
  expect_disjoint(x, c("MCAID_Female_NonAged", "MCAID_Male_Aged"))
})

test_that("Non-aged male with Medicaid should get MCAID_Male_NonAged", {
  x <- PatientDemographics(
    age = 55,
    sex = "M",
    category = "M55_59",
    dis_curr = TRUE,
    dis_orig = FALSE,
    non_aged = TRUE,
    dual_full = FALSE,
    dual_part = TRUE,
    is_lti = FALSE,
    has_esrd = TRUE,
    dual_code = "01"
  ) |>
    interactions()

  expect_contains(x, "MCAID_Male_NonAged")
  expect_disjoint(x, "MCAID_Male_Aged")
})

test_that("Non-Medicaid patient should NOT get MCAID interactions", {
  x <- PatientDemographics(
    age = 70,
    sex = "F",
    category = "F70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = TRUE,
    dual_part = FALSE,
    is_lti = FALSE,
    has_esrd = TRUE,
    dual_code = "00"
  ) |>
    interactions()

  expect_disjoint(
    x,
    c(
      "MCAID_Female_Aged",
      "MCAID_Female_NonAged",
      "MCAID_Male_Aged",
      "MCAID_Male_NonAged"
    )
  )
})

# =============================================================================
# V24/V28 LTIMCAID Institutional Interaction
# =============================================================================

# Test LTIMCAID interaction for CMS-HCC V24/V28 Institutional model
test_that("LTI patient with Medicaid should get LTIMCAID", {
  x <- PatientDemographics(
    age = 70,
    sex = "F",
    category = "F70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = TRUE,
    dual_part = FALSE,
    is_lti = TRUE,
    dual_code = "02"
  ) |>
    interactions()

  expect_contains(x, "LTIMCAID")
})

test_that("LTI patient without Medicaid should NOT get LTIMCAID", {
  x <- PatientDemographics(
    age = 70,
    sex = "F",
    category = "F70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = FALSE,
    dual_part = FALSE,
    is_lti = TRUE,
    dual_code = "00"
  ) |>
    interactions()

  expect_disjoint(x, "LTIMCAID")
})

test_that("Non-LTI patient with Medicaid should NOT get LTIMCAID", {
  x <- PatientDemographics(
    age = 70,
    sex = "F",
    category = "F70_74",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = TRUE,
    dual_part = FALSE,
    is_lti = FALSE,
    dual_code = "02"
  ) |>
    interactions()

  expect_disjoint(x, "LTIMCAID")
})
