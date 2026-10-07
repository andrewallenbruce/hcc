test_that("prefix works", {
  # CMS HCC Community default model
  x = demographics(
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

  expect_equal(prefix(x, model = "C28"), "CNA_")

  # ESRD Dialysis model
  x = demographics(
    version = "V2",
    age = 45,
    sex = "M",
    dual = "00",
    orec = "2",
    crec = "0",
    new = FALSE,
    snp = FALSE,
    low = FALSE
  )
  expect_equal(prefix(x, model = "D24"), "DI_")
})
