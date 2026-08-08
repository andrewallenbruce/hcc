## code to prepare `ra_labels` dataset goes here
path = here::here("data-raw", "hccinfhir-main", "src", "hccinfhir", "data")
files = fs::dir_ls(path, regexp = "ra_labels_2026")
ra_labels = vroom::vroom(files, col_types = "ccccc")

class(ra_labels) <- setdiff(
  class(ra_labels),
  "spec_tbl_df"
)

usethis::use_data(ra_labels, overwrite = TRUE)
