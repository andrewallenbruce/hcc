## code to prepare `sample_files` dataset goes here
path <- here::here(
  "data-raw",
  "hccinfhir-main",
  "src",
  "hccinfhir",
  "sample_files"
)

read_text <- function(path) {
  path <- fs::dir_ls(path, regexp = "\\.txt$|\\.edi$")
  rlang::set_names(
    purrr::map(path, brio::read_lines),
    tools::file_path_sans_ext(basename(path))
  )
}

read_json <- function(path) {
  path <- fs::dir_ls(path, regexp = "\\.json$")
  rlang::set_names(
    purrr::map(path, jsonify::from_json),
    tools::file_path_sans_ext(basename(path))
  )
}

read_ndjson <- function(path) {
  path <- fs::dir_ls(path, regexp = "\\.ndjson$")
  rlang::set_names(
    purrr::map(path, jsonify::from_ndjson),
    tools::file_path_sans_ext(basename(path))
  )
}

x12_820 = read_text(here::here(path, "820"))
usethis::use_data(x12_820, overwrite = TRUE)

x12_834 = read_text(here::here(path, "834"))
usethis::use_data(x12_834, overwrite = TRUE)

x12_837I = read_text(here::here(path, "837I"))
usethis::use_data(x12_837I, overwrite = TRUE)

x12_837P = read_text(here::here(path, "837P"))
usethis::use_data(x12_837P, overwrite = TRUE)

eob_json = read_json(here::here(path, "EOB"))
usethis::use_data(eob_json, overwrite = TRUE)

eob_ndjson = read_ndjson(here::here(path, "EOB"))
usethis::use_data(eob_ndjson, overwrite = TRUE)
