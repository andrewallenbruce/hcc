test_that("Basic V6 (ACA) categorization", {
  x = demographics(age = 35, sex = "M", version = "V6")
  expect_equal(x@category, "MAGE_LAST_35_39")
  expect_equal(x@version, "V6")
  expect_true(x@non_aged)
  expect_false(x@dis_curr)
  expect_false(x@dis_orig)
})

test_that("Basic V2 (Medicare) categorization", {
  x = demographics(age = 75, sex = "F", orec_code = "0", version = "V2")
  expect_equal(x@category, "F75_79")
  expect_equal(x@version, "V2")
  expect_false(x@non_aged)
  expect_false(x@dis_curr)
  expect_false(x@dis_orig)
})

test_that("Basic input validation works", {
  expect_error(demographics(age = "35", sex = "M", version = "V6"))
  expect_error(demographics(age = -5, sex = "M", version = "V6"))
  expect_error(demographics(age = 35, sex = "X", version = "V6"))
  expect_error(demographics(age = 35, sex = "M", version = "V3"))
})

test_that("different sex formats are normalized correctly", {
  x = demographics(age = 35, sex = "M", version = "V6")
  y = demographics(age = 35, sex = "1", version = "V6")
  expect_equal(x@category, y@category)

  x = demographics(age = 35, sex = "F", version = "V6")
  y = demographics(age = 35, sex = "2", version = "V6")
  expect_equal(x@category, y@category)
})

test_that("Current and Original Disability flags are recognized", {
  # Currently disabled
  x = demographics(age = 45, sex = "M", orec_code = "1", version = "V2")
  expect_true(x@dis_curr)
  expect_false(x@dis_orig)

  # Originally disabled, now aged
  x = demographics(age = 70, sex = "M", orec_code = "1", version = "V2")
  expect_false(x@dis_curr)
  expect_true(x@dis_orig)

  # Not disabled
  x = demographics(age = 70, sex = "M", orec_code = "0", version = "V2")
  expect_false(x@dis_curr)
  expect_false(x@dis_orig)
})

test_that("Age Range edge cases", {
  # V6 boundaries
  w = demographics(age = 0, sex = "M", version = "V6")
  x = demographics(age = 1, sex = "M", version = "V6")
  y = demographics(age = 60, sex = "M", version = "V6")
  z = demographics(age = 99, sex = "M", version = "V6")
  expect_equal(w@category, "MAGE_LAST_0_0")
  expect_equal(x@category, "MAGE_LAST_1_1")
  expect_equal(y@category, "MAGE_LAST_60_GT")
  expect_equal(z@category, "MAGE_LAST_60_GT")

  # V2 boundaries
  x = demographics(age = 34, sex = "M", orec_code = "0", version = "V2")
  y = demographics(age = 35, sex = "M", orec_code = "0", version = "V2")
  z = demographics(age = 95, sex = "M", orec_code = "0", version = "V2")
  expect_equal(x@category, "M0_34")
  expect_equal(y@category, "M35_44")
  expect_equal(z@category, "M95_GT")
})

test_that("Dual eligibility categorization", {
  # Full benefit dual
  x = demographics(
    age = 65,
    sex = "M",
    dual_code = "02",
    orec_code = "0"
  )
  expect_true(x@dual_full)
  expect_false(x@dual_part)

  # Partial benefit dual
  x = demographics(
    age = 65,
    sex = "M",
    dual_code = "01",
    orec_code = "0"
  )
  expect_false(x@dual_full)
  expect_true(x@dual_part)

  # Non-dual
  x = demographics(
    age = 65,
    sex = "M",
    dual_code = "00",
    orec_code = "0"
  )
  expect_false(x@dual_full)
  expect_false(x@dual_part)
})

test_that("ESRD is detected", {
  # Test with na OREC/CREC
  x = demographics(age = 65, sex = "M", version = "V6")
  expect_false(x@has_esrd)

  # Test with na CREC only
  x = demographics(age = 65, sex = "M", orec_code = "0")
  expect_false(x@has_esrd)

  # Test with na OREC only
  x = demographics(age = 65, sex = "M", crec_code = "0", version = "V6")
  expect_false(x@has_esrd)

  # ESRD from OREC
  x = demographics(age = 65, sex = "M", orec_code = "2")
  expect_true(x@has_esrd)

  # ESRD from CREC
  x = demographics(age = 65, sex = "M", orec_code = "0", crec_code = "2")
  expect_true(x@has_esrd)

  # No ESRD
  x = demographics(age = 65, sex = "M", orec_code = "0", crec_code = "0")
  expect_false(x@has_esrd)
})

test_that("New Enrollee and SNP flags are recognized", {
  x = demographics(
    age = 65.1,
    sex = "M",
    orec_code = "0",
    new_enrollee = TRUE,
    has_snp = TRUE
  )
  expect_true(x@new_enrollee)
  expect_true(x@has_snp)

  x = demographics(age = 65, sex = "M", orec_code = "0")
  expect_false(x@new_enrollee)
  expect_false(x@has_snp)
})
