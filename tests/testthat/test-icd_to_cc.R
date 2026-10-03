test_that("Common diabetes code maps correctly", {
  expect_equal(
    icd_to_cc(
      icd = "E119",
      model = "C28",
      year = 2026,
      simplify = TRUE
    ),
    list(E119 = 38)
  )
})

test_that("Batch mapping works", {
  expect_equal(
    icd_to_cc(
      icd = c("E103213", "I5022", "Z9999"),
      model = "C28",
      year = 2026,
      simplify = TRUE
    ),
    list(E103213 = c(37, 298), I5022 = 226)
  )
})

test_that("Different model version", {
  expect_equal(
    icd_to_cc(
      icd = "E119",
      model = "D21",
      year = 2026,
      simplify = TRUE
    ),
    list(E119 = 19)
  )
})

test_that("Non-existent diagnosis code returns nothing", {
  expect_equal(
    icd_to_cc(
      icd = "Z9999",
      model = "C28",
      year = 2026,
      simplify = TRUE
    ),
    rlang::set_names(list(), character())
  )
})
