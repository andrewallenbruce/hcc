## code to prepare `hcc_is_chronic` dataset goes here
path = here::here("data-raw", "hccinfhir-main", "src", "hccinfhir", "data")
files = fs::dir_ls(path, regexp = "hcc_is_chronic")

hcc_is_chronic = vroom::vroom(files[1], col_types = "ccc")

hcc_is_chronic <- cheapr::sset(
  hcc_is_chronic,
  cheapr::which_not_na(hcc_is_chronic$is_chronic),
  -2L
) |>
  vctrs::vec_unique()

hcc_is_chronic$hcc <- substring(hcc_is_chronic$hcc, 4L)
hcc_is_chronic$hcc <- as.integer(hcc_is_chronic$hcc)
hcc_is_chronic$model <- cheapr::paste_(
  hcc_is_chronic$model_domain,
  " Model ",
  hcc_is_chronic$model_version
)
hcc_is_chronic$model_domain <- NULL
hcc_is_chronic$model_version <- NULL

hcc_is_chronic <- collapse::roworderv(hcc_is_chronic, c("model", "hcc")) |>
  vctrs::vec_unique() |>
  collapse::rsplit(~model)

usethis::use_data(hcc_is_chronic, overwrite = TRUE)


hcc_is_chronic_without_esrd_model = vroom::vroom(files[2], col_types = "ccc")
usethis::use_data(hcc_is_chronic_without_esrd_model, overwrite = TRUE)
hcc_is_chronic_without_esrd_model |> collapse::descr()
