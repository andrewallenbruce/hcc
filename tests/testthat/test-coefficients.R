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

test_that("apply_coefficients works", {
  skip()
  result <- apply_coefficients(
    demographics = demographics(
      age = 70,
      sex = "F",
      dual_code = "00",
      orec_code = "0",
      crec_code = "0",
      version = "V2",
      new_enrollee = FALSE,
      has_snp = FALSE,
      low_income = FALSE
    ),
    hcc = c(19L, 47L, 85L),
    interactions = "D1",
    model = "CMS-HCC Model V28",
    coefficients = list(
      "CMS-HCC Model V28" = list(
        CNA_HCC19 = 0.421,
        CNA_HCC47 = 0.368,
        CNA_HCC85 = 0.323,
        CNA_D1 = 0.118,
        CNA_D2 = 0.245
      )
    )
  )
})
