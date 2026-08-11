## code to prepare `sample_files` dataset goes here

read_samples <- function(path) {
  rlang::set_names(
    purrr::map(path, brio::read_lines),
    tools::file_path_sans_ext(basename(path))
  )
}

read_json <- function(path) {
  rlang::set_names(
    purrr::map(path, jsonify::from_json),
    tools::file_path_sans_ext(basename(path))
  )
}

read_ndjson <- function(path) {
  rlang::set_names(
    purrr::map(path, jsonify::from_ndjson),
    tools::file_path_sans_ext(basename(path))
  )
}

path = here::here(
  "data-raw",
  "hccinfhir-main",
  "src",
  "hccinfhir",
  "sample_files"
)

x12_820 = read_samples(fs::dir_ls(path, regexp = "sample_820_[0][0-9][.]txt$"))
usethis::use_data(x12_820, overwrite = TRUE)

x12_834 = read_samples(fs::dir_ls(path, regexp = "sample_834_[0][0-9][.]txt$"))
usethis::use_data(x12_834, overwrite = TRUE)

x12_837 = read_samples(fs::dir_ls(path, regexp = "sample_837_[0-9][.]txt$"))
usethis::use_data(x12_837, overwrite = TRUE)

eob_json <- read_json(fs::dir_ls(path, regexp = "sample_eob_[0-9][.]json$"))
usethis::use_data(eob_json, overwrite = TRUE)

eob_ndjson <- read_ndjson(fs::dir_ls(path, regexp = "ndjson$"))
usethis::use_data(eob_ndjson, overwrite = TRUE)
