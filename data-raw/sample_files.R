## code to prepare `sample_files` dataset goes here
# sample_eob = fs::dir_ls(path, regexp = "eob")

read_samples <- function(path) {
  rlang::set_names(
    purrr::map(path, brio::read_lines),
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
