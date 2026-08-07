test_that("basic V6 (ACA) categorization", {
  x = categorize_demographics(age = 35, sex = "M", version = "V6")
  expect_equal(x$category, "MAGE_LAST_35_39")
  expect_equal(x$version, "V6")
  expect_true(x$non_aged)
  expect_false(x$disabled)
  expect_false(x$orig_disabled)
})

test_that("basic V2 (Medicare) categorization", {
  x = categorize_demographics(age = 75, sex = "F", orec = "0", version = "V2")
  expect_equal(x$category, "F75_79")
  expect_equal(x$version, "V2")
  expect_false(x$non_aged)
  expect_false(x$disabled)
  expect_false(x$orig_disabled)
})

test_that("input validation works", {
  # `age` must be a number
  expect_error(categorize_demographics(age = "35", sex = "M", version = "V6"))
  # `age` must be positive
  expect_error(categorize_demographics(age = -5, sex = "M", version = "V6"))
  # `sex` must be one of "1", "2", "M", or "F"
  expect_error(categorize_demographics(age = 35, sex = "X", version = "V6"))
  # `version` must be one of "V2", "V4", or "V6"
  expect_error(categorize_demographics(age = 35, sex = "M", version = "V3"))
})

test_that("different sex formats are normalized correctly", {
  x = categorize_demographics(age = 35, sex = "M", version = "V6")
  y = categorize_demographics(age = 35, sex = "1", version = "V6")
  expect_equal(x$category, y$category)

  x = categorize_demographics(age = 35, sex = "F", version = "V6")
  y = categorize_demographics(age = 35, sex = "2", version = "V6")
  expect_equal(x$category, y$category)
})

test_that("disability and original disability flags", {
  # Currently disabled
  x = categorize_demographics(age = 45, sex = "M", orec = "1", version = "V2")
  expect_true(x$disabled)
  expect_false(x$orig_disabled)

  # Originally disabled, now aged
  x = categorize_demographics(age = 70, sex = "M", orec = "1", version = "V2")
  expect_false(x$disabled)
  expect_true(x$orig_disabled)

  # Neither disabled
  x = categorize_demographics(age = 70, sex = "M", orec = "0", version = "V2")
  expect_false(x$disabled)
  expect_false(x$orig_disabled)
})

test_that("Edge cases for age ranges", {
  # Test V6 boundaries
  w = categorize_demographics(age = 0, sex = "M", version = "V6")
  x = categorize_demographics(age = 1, sex = "M", version = "V6")
  y = categorize_demographics(age = 60, sex = "M", version = "V6")
  z = categorize_demographics(age = 99, sex = "M", version = "V6")
  expect_equal(w$category, "MAGE_LAST_0_0")
  expect_equal(x$category, "MAGE_LAST_1_1")
  expect_equal(y$category, "MAGE_LAST_60_GT")
  expect_equal(z$category, "MAGE_LAST_60_GT")

  # Test V2 boundaries
  x = categorize_demographics(age = 34, sex = "M", orec = "0", version = "V2")
  y = categorize_demographics(age = 35, sex = "M", orec = "0", version = "V2")
  z = categorize_demographics(age = 95, sex = "M", orec = "0", version = "V2")
  expect_equal(x$category, "M0_34")
  expect_equal(y$category, "M35_44")
  expect_equal(z$category, "M95_GT")
})

test_that("Dual eligibility categorization", {
  # Full benefit dual
  x = categorize_demographics(
    age = 65,
    sex = "M",
    dual = "02",
    orec = "0"
  )
  expect_true(x$fbd)
  expect_false(x$pbd)

  # Partial benefit dual
  x = categorize_demographics(
    age = 65,
    sex = "M",
    dual = "01",
    orec = "0"
  )
  expect_false(x$fbd)
  expect_true(x$pbd)

  # Non-dual
  x = categorize_demographics(
    age = 65,
    sex = "M",
    dual = "00",
    orec = "0"
  )
  expect_false(x$fbd)
  expect_false(x$pbd)
})

test_that("ESRD (End Stage Renal Disease) detection", {
  # Test with null OREC/CREC
  x = categorize_demographics(age = 65, sex = "M", version = "V6")
  expect_false(x$esrd)

  # Test with null CREC only
  x = categorize_demographics(age = 65, sex = "M", orec = "0")
  expect_false(x$esrd)

  # Test with null OREC only
  x = categorize_demographics(age = 65, sex = "M", crec = "0", version = "V6")
  expect_false(x$esrd)

  # ESRD from OREC
  x = categorize_demographics(age = 65, sex = "M", orec = "2")
  expect_true(x$esrd)

  # ESRD from CREC
  x = categorize_demographics(age = 65, sex = "M", orec = "0", crec = "2")
  expect_true(x$esrd)

  # No ESRD
  x = categorize_demographics(age = 65, sex = "M", orec = "0", crec = "0")
  expect_false(x$esrd)
})

test_that("new enrollee and SNP flags", {
  x = categorize_demographics(
    age = 65.1,
    sex = "M",
    orec = "0",
    new = TRUE,
    snp = TRUE
  )
  expect_true(x$new)
  expect_true(x$snp)

  x = categorize_demographics(age = 65, sex = "M", orec = "0")
  expect_false(x$new)
  expect_false(x$snp)
})
