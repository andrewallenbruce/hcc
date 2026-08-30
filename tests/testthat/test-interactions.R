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
