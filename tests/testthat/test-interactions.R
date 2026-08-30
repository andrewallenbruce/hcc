test_that("any_hcc works", {
  expect_equal(any_hcc(17:19, 18:21), 1)
  expect_equal(any_hcc(17:19, 20:22), 0)
})

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

test_that("hcc_count works", {
  x = hcc_count(17:19)
  expect_equal(x, "D3")
  expect_disjoint(x, c("D2", "D10P"))
})

test_that("diagnostic_categories works", {
  x = diagnostic_categories("CMS-HCC Model V24", c(17:19, 85L))
  expect_equal(x$DIABETES, 1)
  expect_equal(x$CHF, 1)
  expect_equal(x$CANCER, 0)
})

test_that("disease_interactions works", {
  x = disease_interactions(
    model = "CMS-HCC Model V24",
    diagnostics = diagnostic_categories("CMS-HCC Model V24", c(17L, 85L)),
    demographics = PatientDemographics(
      age = 65,
      sex = "F",
      category = "F65",
      dis_curr = TRUE,
      dis_orig = FALSE,
      non_aged = FALSE,
      dual_full = FALSE,
      dual_part = FALSE,
      is_lti = FALSE
    ),
    hcc = c(17L, 85L)
  )
  expect_match(x, "DISABLED_HCC85", all = FALSE)
  expect_match(x, "DIABETES_CHF", all = FALSE)
})

test_that("apply_interactions works", {
  x = apply_interactions(
    model = "CMS-HCC Model V24",
    demographics = PatientDemographics(
      age = 65,
      sex = "F",
      category = "F65",
      dis_curr = FALSE,
      dis_orig = FALSE,
      non_aged = FALSE,
      dual_full = TRUE,
      dual_part = FALSE,
      is_lti = FALSE
    ),
    hcc = c(17:18, 85L)
  )
  expect_match(x, "FBDual_Female_Aged", all = FALSE)
  expect_match(x, "D3", all = FALSE)
  expect_match(x, "DIABETES_CHF", all = FALSE)
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
  )

  x <- interactions(x)
  expect_match(x, "GE65_DUR4_9", all = FALSE)
  expect_no_match(x, "LT65_DUR4_9")
  expect_no_match(x, "GE65_DUR10PL")
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
  )

  x <- interactions(x)
  expect_match(x, "LT65_DUR4_9", all = FALSE)
  expect_no_match(x, "GE65_DUR4_9")
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
  )

  x <- interactions(x)
  expect_match(x, "GE65_DUR10PL", all = FALSE)
  expect_no_match(x, "LT65_DUR10PL")
  expect_no_match(x, "GE65_DUR4_9")
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
  )

  x <- interactions(x)
  expect_match(x, "LT65_DUR10PL", all = FALSE)
  expect_no_match(x, "GE65_DUR10PL")
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
  )

  x <- interactions(x)
  expect_no_match(x, "GE65_DUR4_9")
  expect_no_match(x, "LT65_DUR4_9")
  expect_no_match(x, "GE65_DUR10PL")
  expect_no_match(x, "LT65_DUR10PL")
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
  )

  x <- interactions(x)
  expect_match(x, "FGC_GE65_DUR4_9_ND_PBD", all = FALSE)
  expect_no_match(x, "FGC_LT65_DUR4_9_ND_PBD")
  expect_no_match(x, "FGI_GE65_DUR4_9_ND_PBD")
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
  )

  x <- interactions(x)
  expect_match(x, "FGC_LT65_DUR10PL_ND_PBD", all = FALSE)
  expect_no_match(x, "FGC_GE65_DUR10PL_ND_PBD")
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
  )

  x <- interactions(x)
  expect_match(x, "FGI_GE65_DUR4_9_ND_PBD", all = FALSE)
  expect_no_match(x, "FGC_GE65_DUR4_9_ND_PBD")
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
  )

  x <- interactions(x)
  expect_match(x, "FGI_LT65_DUR10PL_ND_PBD", all = FALSE)
  expect_no_match(x, "FGC_LT65_DUR10PL_ND_PBD")
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
  )

  x <- interactions(x)
  expect_match(x, "FGC_GE65_DUR4_9_FBD", all = FALSE)
  expect_no_match(x, "FGC_LT65_DUR4_9_FBD")
  # Should NOT have ND_PBD variants
  expect_no_match(x, "FGC_GE65_DUR4_9_ND_PBD")
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
  )

  x <- interactions(x)
  expect_match(x, "FGC_LT65_DUR10PL_FBD", all = FALSE)
  expect_no_match(x, "FGC_GE65_DUR10PL_FBD")
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
  )

  x <- interactions(x)
  expect_match(x, "FGI_GE65_DUR4_9_FBD", all = FALSE)
  expect_no_match(x, "FGC_GE65_DUR4_9_FBD")
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
  )

  x <- interactions(x)
  expect_match(x, "FGI_LT65_DUR10PL_FBD", all = FALSE)
  expect_no_match(x, "FGC_LT65_DUR10PL_FBD")
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
  )

  x <- interactions(x)
  expect_match(x, "FGC_PBD_GE65_flag", all = FALSE)
  expect_no_match(x, "FGC_PBD_LT65_flag")
  expect_no_match(x, "FGI_PBD_GE65_flag")
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
  )

  x <- interactions(x)
  expect_match(x, "FGI_PBD_LT65_flag", all = FALSE)
  expect_no_match(x, "FGC_PBD_LT65_flag")
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
  )

  x <- interactions(x)
  expect_no_match(x, "FGC_PBD_GE65_flag")
  expect_no_match(x, "FGC_PBD_LT65_flag")
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
  )

  x <- interactions(x)
  expect_match(x, "LTI_GE65", all = FALSE)
  expect_no_match(x, "LTI_LT65")
  # Also should have LTI_Aged (looked up with DI_ prefix)
  expect_match(x, "LTI_Aged", all = FALSE)
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
  )

  x <- interactions(x)
  expect_match(x, "LTI_LT65", all = FALSE)
  expect_no_match(x, "LTI_GE65")
  # Also should have LTI_NonAged
  expect_match(x, "LTI_NonAged", all = FALSE)
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
  )

  x <- interactions(x)
  expect_no_match(x, "LTI_GE65")
  expect_no_match(x, "LTI_LT65")
  expect_no_match(x, "LTI_Aged")
  expect_no_match(x, "LTI_NonAged")
})

# =============================================================================
# ESRD V21 Originally ESRD and MCAID Interactions
# =============================================================================

# Test Originally_ESRD interactions for ESRD V21 and V24
