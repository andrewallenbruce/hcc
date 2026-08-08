## code to prepare `ra_hierarchies` dataset goes here
path = here::here("data-raw", "hccinfhir-main", "src", "hccinfhir", "data")
files = fs::dir_ls(path, regexp = "ra_hierarchies")

ra_hierarchies_2025 = vroom::vroom(files[1], col_types = "iiccc")
ra_hierarchies_2026 = vroom::vroom(files[2], col_types = "iiccc")

class(ra_hierarchies_2025) <- setdiff(
  class(ra_hierarchies_2025),
  "spec_tbl_df"
)

class(ra_hierarchies_2026) <- setdiff(
  class(ra_hierarchies_2026),
  "spec_tbl_df"
)

ra_hierarchies_2025$year <- 2025L
ra_hierarchies_2026$year <- 2026L
ra_hierarchies = collapse::colorderv(
  vctrs::vec_rbind(ra_hierarchies_2025, ra_hierarchies_2026),
  "year"
)
usethis::use_data(ra_hierarchies, overwrite = TRUE)
