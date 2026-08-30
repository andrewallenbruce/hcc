test_that("coefficient_prefix works", {
  # CMS HCC Community default model
  x = coefficient_prefix(
    demographics(
      version = "V2",
      age = 70,
      sex = "F",
      dual_code = "00",
      orec_code = "0",
      crec_code = "0",
      new_enrollee = FALSE,
      has_snp = FALSE,
      low_income = FALSE
    )
  )
  expect_equal(x, "CNA_")

  # ESRD Dialysis model
  x = coefficient_prefix(
    demographics(
      version = "V2",
      age = 45,
      sex = "M",
      dual_code = "00",
      orec_code = "2",
      crec_code = "0",
      new_enrollee = FALSE,
      has_snp = FALSE,
      low_income = FALSE
    ),
    model = "CMS-HCC ESRD Model V24"
  )
  expect_equal(x, "DI_")
})
