test_that("Common diabetes code maps correctly", {
  x = apply_map(icd = "E119", model = "CMS-HCC Model V28")
  expect_equal(x$cc, 38)
})

test_that("Batch mapping with default dx_to_cc_mapping", {
  x = apply_map(
    icd = c("E103213", "I5022", "Z9999"),
    model = "CMS-HCC Model V28"
  )
  expect_equal(x$cc, c(37, 298, 226))
})

test_that("Different model version", {
  x = apply_map(icd = "E119", model = "CMS-HCC ESRD Model V21")
  expect_equal(x$cc, 19)
})

test_that("Non-existent diagnosis code", {
  x = apply_map(icd = "Z99.99", model = "CMS-HCC Model V28")
  expect_equal(x$cc, integer())
})
