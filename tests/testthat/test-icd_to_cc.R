test_that("Common diabetes code maps correctly", {
  expect_equal(
    icd_to_cc(icd = "E119", model = "C28", year = 2026L)$cc,
    38L
  )
})

test_that("Batch mapping works", {
  expect_equal(
    icd_to_cc(
      icd = c("E103213", "I5022", "Z9999"),
      model = "C28",
      year = 2026
    )$cc,
    c(37L, 226L, 298L)
  )
})

test_that("Different model version", {
  expect_equal(
    icd_to_cc(icd = "E119", model = "D21", year = 2026)$cc,
    19L
  )
})

test_that("Non-existent diagnosis code returns nothing", {
  expect_equal(
    icd_to_cc(icd = "Z9999", model = "C28", year = 2026)$cc,
    integer(0)
  )
})
