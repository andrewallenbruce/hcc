## code to prepare `ra_eligible_hcpcs` dataset goes here
path = here::here("data-raw", "hccinfhir-main", "src", "hccinfhir", "data")
files = fs::dir_ls(path, regexp = "ra_eligible_cpt_hcpcs")

ra_eligible_hcpcs_2025 = vroom::vroom(files[3], col_types = "c", delim = "\\n")
ra_eligible_hcpcs_2026 = vroom::vroom(files[4], col_types = "c", delim = "\\n")

class(ra_eligible_hcpcs_2025) <- setdiff(
  class(ra_eligible_hcpcs_2025),
  "spec_tbl_df"
)

class(ra_eligible_hcpcs_2026) <- setdiff(
  class(ra_eligible_hcpcs_2026),
  "spec_tbl_df"
)

ra_eligible_hcpcs = list(
  y2025 = collapse::roworderv(
    ra_eligible_hcpcs_2025,
    "cpt_hcpcs_code"
  )$cpt_hcpcs_code,
  y2026 = collapse::roworderv(
    ra_eligible_hcpcs_2026,
    "cpt_hcpcs_code"
  )$cpt_hcpcs_code
)

ra_eligible_hcpcs$all <- vctrs::vec_set_intersect(
  ra_eligible_hcpcs$y2025,
  ra_eligible_hcpcs$y2026
)

ra_eligible_hcpcs$y2026 <- vctrs::vec_set_difference(
  ra_eligible_hcpcs$y2026,
  ra_eligible_hcpcs$y2025
)

ra_eligible_hcpcs$y2025 <- NULL

usethis::use_data(ra_eligible_hcpcs, overwrite = TRUE)
