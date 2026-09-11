test_that("diagnostic_categories works", {
  x = diagnostics("CMS-HCC Model V24", c(17:19, 85L))
  expect_equal(x@categories$DIABETES, 1)
  expect_equal(x@categories$CHF, 1)
  expect_equal(x@categories$CANCER, 0)
})
