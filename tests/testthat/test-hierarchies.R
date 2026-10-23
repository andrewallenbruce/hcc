test_that("Parent-child hierarchy removal works", {
  # Example: Diabetes hierarchy where 17 > 18 > 19

  # Test parent removes children
  expect_equal(hierarchies(17:19), 17L)

  # Test middle hierarchy
  expect_equal(hierarchies(18:19), 18L)
})

test_that("C28-specific rules work", {
  # Example: CC 223 removal
  expect_disjoint(hierarchies(223L), 223L)

  # 223 should remain when other specified CCs exist
  expect_equal(hierarchies(c(221L, 223L)), c(221L, 223L))
})

test_that("ESRD model-specific rules work", {
  # Test V21
  expect_equal(hierarchies(134:135, "D21"), 135L)

  # Test V24
  expect_disjoint(hierarchies(134:137, "D24"), 134:137)
})

test_that("Edge cases with empty inputs", {
  expect_equal(hierarchies(integer(0)), integer(0))
  expect_equal(hierarchies(0L), 0L)
})

test_that("Common diabetes code maps correctly", {
  expect_equal(icd_to_cc("E119")$cc, 38L)
})

test_that("Batch mapping works", {
  expect_equal(
    icd_to_cc(c("E103213", "I5022", "Z9999"))$cc,
    c(37L, 226L, 298L)
  )
})

test_that("Different model version", {
  expect_equal(icd_to_cc("E119", "D21")$cc, 19L)
})

test_that("Non-existent diagnosis code returns nothing", {
  expect_equal(icd_to_cc("Z9999")$cc, integer(0))
})

test_that("Complete chain from ICD codes to final hierarchical CCs works", {
  diagnoses <- c(
    "E1100", # Type 2 Diabetes Mellitus with Hyperosmolarity without Non-Ketotic Hyperglycemic-Hyperosmolar Coma (NKHHC)
    "E1022", # Type 1 Diabetes with Kidney Complications
    "E1165", # Type 2 Diabetes with Circulatory Complications
    "E119" # Type 2 Diabetes without Complications
  )

  cc_dx <- icd_to_cc(diagnoses, "C24")$cc |> unique()
  expect_equal(cc_dx, 17:19)
  expect_equal(hierarchies(cc_dx, "C24"), 17L)

  cc_dx <- icd_to_cc(icd = diagnoses)$cc |> unique()
  expect_equal(cc_dx, 36:38)
  expect_equal(hierarchies(cc_dx), 36L)
})
