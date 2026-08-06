## code to prepare `ra_coefficients` dataset goes here
path = here::here("data-raw", "hccinfhir-main", "src", "hccinfhir", "data")
files = fs::dir_ls(path, regexp = "ra_coefficients")

ra_coefficients_2025 = vroom::vroom(files[1], col_types = "ccc")
ra_coefficients_2026 = vroom::vroom(files[2], col_types = "ccc")

class(ra_coefficients_2025) <- setdiff(
  class(ra_coefficients_2025),
  "spec_tbl_df"
)
ra_coefficients_2025$year <- 2025
collapse::settfmv(ra_coefficients_2025, c("year"), as.integer)
collapse::settfmv(ra_coefficients_2025, c("value"), as.double)
ra_coefficients_2025 = collapse::colorderv(ra_coefficients_2025, "year")

class(ra_coefficients_2026) <- setdiff(
  class(ra_coefficients_2026),
  "spec_tbl_df"
)
ra_coefficients_2026$year <- 2026
collapse::settfmv(ra_coefficients_2026, c("year"), as.integer)
collapse::settfmv(ra_coefficients_2026, c("value"), as.double)
ra_coefficients_2026 = collapse::colorderv(ra_coefficients_2026, "year")

ra_coefficients = vctrs::vec_rbind(ra_coefficients_2025, ra_coefficients_2026)
usethis::use_data(ra_coefficients, overwrite = TRUE)
