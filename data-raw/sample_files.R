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

read_ndjson <- function(path, lines = -1L) {
  path <- fs::dir_ls(path, regexp = "\\.ndjson$")
  rlang::set_names(
    # purrr::map(path, \(file) yyjsonr::read_ndjson_file(filename = file, nread = lines, opts = yyjsonr::opts_read_json(df_missing_list_elem = NA, str_specials = "special", num_specials = "special"))),
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
eob_json = jsonify::pretty_json(eob_json)
usethis::use_data(eob_json, overwrite = TRUE)

eob_ndjson = read_ndjson(here::here(path, "EOB"))
eob_ndjson = jsonify::minify_json(eob_ndjson)
usethis::use_data(eob_ndjson, overwrite = TRUE)
