test_that("Common diabetes code maps correctly", {
  expect_equal(
    apply_map(
      icd = "E119",
      model = "C28",
      year = 2026
    )$cc,
    38
  )
})

test_that("Batch mapping works", {
  expect_equal(
    apply_map(
      icd = c("E103213", "I5022", "Z9999"),
      model = "C28",
      year = 2026
    )$cc,
    c(37, 298, 226)
  )
})

test_that("Different model version", {
  expect_equal(
    apply_map(
      icd = "E119",
      model = "D21",
      year = 2026
    )$cc,
    19
  )
})

test_that("Non-existent diagnosis code returns nothing", {
  expect_equal(
    apply_map(
      icd = "Z9999",
      model = "C28",
      year = 2026
    )$cc,
    integer(0)
  )
})
