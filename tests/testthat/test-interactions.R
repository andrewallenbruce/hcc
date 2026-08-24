test_that("has_any_hcc works", {
  hcc_list = c(17, 18, 19)
  hcc_set = c(18, 20, 21)
  expect_equal(has_any_hcc(hcc_list, hcc_set), 1)
  hcc_set = c(20, 21, 22)
  expect_equal(has_any_hcc(hcc_list, hcc_set), 0)
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
  hcc_set = c(17, 18, 19)
  x = create_hcc_counts(hcc_set)
  expect_equal(x[["D3"]], 1)
  expect_no_match(names(x), "D2")
  expect_no_match(names(x), "D10P")
})
