## code to prepare `hcc_is_chronic` dataset goes here
path = here::here("data-raw", "hccinfhir-main", "src", "hccinfhir", "data")
files = fs::dir_ls(path, regexp = "hcc_is_chronic")

hcc_is_chronic = vroom::vroom(files[1], col_types = "ccc")
hcc_is_chronic_without_esrd_model = vroom::vroom(files[2], col_types = "ccc")

usethis::use_data(hcc_is_chronic, overwrite = TRUE)
usethis::use_data(hcc_is_chronic_without_esrd_model, overwrite = TRUE)
