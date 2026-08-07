test_that("Basic V6 (ACA) categorization", {
  x = categorize_demographics(age = 35, sex = "M", version = "V6")
  expect_equal(x$category, "MAGE_LAST_35_39")
  expect_equal(x$version, "V6")
  expect_true(x$non_aged)
  expect_false(x$disabled)
  expect_false(x$orig_disabled)
})

test_that("Basic V2 (Medicare) categorization", {
  x = categorize_demographics(age = 75, sex = "F", orec = "0", version = "V2")
  expect_equal(x$category, "F75_79")
  expect_equal(x$version, "V2")
  expect_false(x$non_aged)
  expect_false(x$disabled)
  expect_false(x$orig_disabled)
})

test_that("Basic input validation works", {
  expect_error(categorize_demographics(age = "35", sex = "M", version = "V6"))
  expect_error(categorize_demographics(age = -5, sex = "M", version = "V6"))
  expect_error(categorize_demographics(age = 35, sex = "X", version = "V6"))
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

test_that("Current and Original Disability flags are recognized", {
  # Currently disabled
  x = categorize_demographics(age = 45, sex = "M", orec = "1", version = "V2")
  expect_true(x$disabled)
  expect_false(x$orig_disabled)

  # Originally disabled, now aged
  x = categorize_demographics(age = 70, sex = "M", orec = "1", version = "V2")
  expect_false(x$disabled)
  expect_true(x$orig_disabled)

  # Not disabled
  x = categorize_demographics(age = 70, sex = "M", orec = "0", version = "V2")
  expect_false(x$disabled)
  expect_false(x$orig_disabled)
})

test_that("Age Range edge cases", {
  # V6 boundaries
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

test_that("ESRD is detected", {
  # Test with na OREC/CREC
  x = categorize_demographics(age = 65, sex = "M", version = "V6")
  expect_false(x$esrd)

  # Test with na CREC only
  x = categorize_demographics(age = 65, sex = "M", orec = "0")
  expect_false(x$esrd)

  # Test with na OREC only
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

test_that("New Enrollee and SNP flags are recognized", {
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
