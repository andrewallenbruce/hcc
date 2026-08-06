## code to prepare `ra_dx_edits` dataset goes here
path = here::here("data-raw", "hccinfhir-main", "src", "hccinfhir", "data")
files = fs::dir_ls(path, regexp = "ra_dx_edits")

ra_dx_edits = vroom::vroom(files, col_types = "ccc")

class(ra_dx_edits) <- setdiff(
  class(ra_dx_edits),
  "spec_tbl_df"
)

collapse::settfmv(
  ra_dx_edits,
  c("sex", "age_min", "age_max", "cc_override"),
  as.integer
)
usethis::use_data(ra_dx_edits, overwrite = TRUE)
