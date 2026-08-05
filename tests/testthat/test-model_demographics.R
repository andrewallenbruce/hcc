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
