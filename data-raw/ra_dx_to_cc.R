## code to prepare `ra_dx_to_cc` dataset goes here
path = here::here("data-raw", "hccinfhir-main", "src", "hccinfhir", "data")
files = fs::dir_ls(path, regexp = "ra_dx_to")

ra_dx_to_cc_2025 = vroom::vroom(files[1], col_types = "ccc")
ra_dx_to_cc_2026 = vroom::vroom(files[2], col_types = "ccc")

ra_dx_to_cc_2025$year <- 2025
collapse::settfmv(ra_dx_to_cc_2025, c("cc", "year"), as.integer)
ra_dx_to_cc_2025 = collapse::colorderv(ra_dx_to_cc_2025, "year")

ra_dx_to_cc_2026$year <- 2026
collapse::settfmv(ra_dx_to_cc_2026, c("cc", "year"), as.integer)
ra_dx_to_cc_2026 = collapse::colorderv(ra_dx_to_cc_2026, "year")

ra_dx_to_cc = vctrs::vec_rbind(ra_dx_to_cc_2025, ra_dx_to_cc_2026)

usethis::use_data(ra_dx_to_cc, overwrite = TRUE)

collapse::rsplit(
  collapse::roworderv(
    hcc::ra_dx_to_cc,
    c("year", "cc")
  ),
  ~model_name
)
