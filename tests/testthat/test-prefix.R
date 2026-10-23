test_that("prefix works", {
  # CMS HCC Community default model
  expect_equal(
    prefix(
      demographics(
        age = 70,
        sex = "F",
        dual = "00",
        orec = 0,
        crec = 0,
        new_enrollee = FALSE,
        snp = FALSE,
        low_income = FALSE
      )
    ),
    "CNA_"
  )

  # ESRD Dialysis model
  expect_equal(
    prefix(
      demographics(
        age = 45,
        sex = "M",
        dual = "00",
        orec = 2,
        crec = 0,
        new_enrollee = FALSE,
        snp = FALSE,
        low_income = FALSE
      ),
      model = "D24"
    ),
    "DI_"
  )
})
