test_that("prefix works", {
  # CMS HCC Community default model
  expect_equal(
    prefix(
      demographics(
        version = "V2",
        age = 70,
        sex = "F",
        dual = "00",
        orec = "0",
        crec = "0",
        new = FALSE,
        snp = FALSE,
        low = FALSE
      )
    ),
    "CNA_"
  )

  # ESRD Dialysis model
  expect_equal(
    prefix(
      demographics(
        version = "V2",
        age = 45,
        sex = "M",
        dual = "00",
        orec = "2",
        crec = "0",
        new = FALSE,
        snp = FALSE,
        low = FALSE
      ),
      model = "D24"
    ),
    "DI_"
  )
})
