test_that("diagnostics works", {
  expect_equal(
    names(which(diagnostics("C24", c(17:19, 85L))@category == 1L)),
    c("DIABETES", "CHF")
  )
})
