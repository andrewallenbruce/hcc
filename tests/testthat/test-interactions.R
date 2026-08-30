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

test_that("create_hcc_counts works", {
  x = hcc_counts(17:19)
  n = names(x)
  expect_equal(x[["D3"]], 1)
  expect_no_match(n, "D2")
  expect_no_match(n, "D10P")
})

test_that("diagnostic_categories works", {
  x = diagnostic_categories("CMS-HCC Model V24", c(17:19, 85L))
  expect_equal(x$DIABETES, 1)
  expect_equal(x$CHF, 1)
  expect_equal(x$CANCER, 0)
})
