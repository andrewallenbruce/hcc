test_that("any_hcc works", {
  expect_equal(any_hcc(17:19, 18:21), 1)
  expect_equal(any_hcc(17:19, 20:22), 0)
})

test_that("hcc_count works", {
  x = hcc_count(17:19)
  expect_equal(x, "D3")
  expect_disjoint(x, c("D2", "D10P"))
})

test_that("date parsing utility works", {
  NA_Date_ <- as.Date(NA)
  expect_equal(parse_date("20250108"), as.Date("2025-01-08"))
  expect_equal(parse_date("19550315"), as.Date("1955-03-15"))
  expect_equal(parse_date("invalid"), NA_Date_)
  expect_equal(parse_date("999999999"), NA_Date_)
  expect_equal(parse_date(""), NA_Date_)
})

test_that("Age calculation", {
  expect_equal(calculate_age("1955-03-15", "2025-01-08"), 69L)
  expect_equal(calculate_age("1960-08-22", "2025-01-08"), 64L)
  expect_equal(calculate_age("invalid"), NA_integer_)
  expect_equal(calculate_age("999999999"), NA_integer_)
  expect_equal(calculate_age(""), NA_integer_)
})


test_that("New Enrollee detection", {
  expect_true(is_new_enrollee("2024-11-08", "2025-01-08"))
  expect_true(is_new_enrollee("2024-10-08", "2025-01-08"))
  expect_false(is_new_enrollee("2024-09-08", "2025-01-08"))
  expect_false(is_new_enrollee("2024-01-08", "2025-01-08"))
  expect_equal(is_new_enrollee("None"), NA)
})

test_that("Status to Dual mapping works", {
  expect_all_equal(map_to_dual(c("QMB", "4M", "4O")), "01")
  expect_all_equal(map_to_dual(c("QMBPLUS", "QMB+", "4N", "4P")), "02")
  expect_all_equal(map_to_dual(c("SLMB", "5A", "5C")), "03")
  expect_all_equal(map_to_dual(c("SLMBPLUS", "SLMB+", "5B", "5D")), "04")
  expect_all_equal(map_to_dual(c("QI", "5E", "5F")), "06")
  expect_equal(map_to_dual("QDWI"), "05")
  expect_equal(map_to_dual("FBDE"), "08")
  expect_equal(map_to_dual("INVALID"), NA_character_) # Returns '00' for invalid
})

test_that("Medi-Cal eligibility status can be derived from dates", {
  expect_equal(medi_eligibility_status("2025-11-30", "2025-11-15"), "Active")
  expect_equal(medi_eligibility_status("2025-12-31", "2025-11-15"), "Active")
  expect_equal(
    medi_eligibility_status("2025-10-31", "2025-11-15"),
    "Terminated"
  )
  expect_equal(
    medi_eligibility_status("2025-09-30", "2025-11-15"),
    "Terminated"
  )
  expect_error(medi_eligibility_status(NULL, "2025-11-15"))
  expect_error(medi_eligibility_status("", "2025-11-15"))

  # Edge case: coverage ends on first day of report month
  expect_equal(medi_eligibility_status("2025-11-01", "2025-11-15"), "Active")
  # Edge case: coverage ends on last day of previous month
  expect_equal(
    medi_eligibility_status("2025-10-31", "2025-11-01"),
    "Terminated"
  )
})
