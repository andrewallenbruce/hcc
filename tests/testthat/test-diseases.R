test_that("disease_interactions works", {
  expect_setequal(
    disease_interactions(
      diagnostics("v24", c(17L, 85L)),
      PatientDemographics(
        age = 65,
        sex = "F",
        category = "F65",
        dis_curr = TRUE,
        dis_orig = FALSE,
        non_aged = FALSE,
        dual_full = FALSE,
        dual_part = FALSE,
        is_lti = FALSE
      )
    ),
    c("DIABETES_CHF", "DISABLED_HCC85")
  )
})
