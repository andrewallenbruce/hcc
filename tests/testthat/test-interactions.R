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
