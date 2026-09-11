## code to prepare `hcc_is_chronic` dataset goes here
path = here::here("data-raw", "hccinfhir-main", "src", "hccinfhir", "data")
files = fs::dir_ls(path, regexp = "hcc_is_chronic")
hcc_is_chronic = vroom::vroom(files[1], col_types = "ccc")

hcc_is_chronic <- cheapr::sset(
  hcc_is_chronic,
  cheapr::which_not_na(
    hcc_is_chronic$is_chronic
  ),
  -2L
) |>
  vctrs::vec_unique()

hcc_is_chronic$hcc <- substring(hcc_is_chronic$hcc, 4L) |> as.integer()
hcc_is_chronic$model <- cheapr::paste_(
  hcc_is_chronic$model_domain,
  " Model ",
  hcc_is_chronic$model_version
)

hcc_is_chronic$model_domain <- NULL
hcc_is_chronic$model_version <- NULL

chronic_hcc <- collapse::roworderv(hcc_is_chronic, c("model", "hcc")) |>
  vctrs::vec_unique() |>
  collapse::rsplit(~model)
names(chronic_hcc) <- heck::to_snek_case(names(chronic_hcc))


usethis::use_data(chronic_hcc, overwrite = TRUE)

chronic_hcc_no_esrd = vroom::vroom(files[2], col_types = "ccc")
chronic_hcc_no_esrd <- cheapr::sset(
  chronic_hcc_no_esrd,
  cheapr::which_not_na(
    chronic_hcc_no_esrd$is_chronic
  ),
  -2L
) |>
  vctrs::vec_unique()

chronic_hcc_no_esrd$hcc <- substring(chronic_hcc_no_esrd$hcc, 4L) |>
  as.integer()
chronic_hcc_no_esrd$model <- cheapr::paste_(
  chronic_hcc_no_esrd$model_domain,
  " Model ",
  chronic_hcc_no_esrd$model_version
)

chronic_hcc_no_esrd$model_domain <- NULL
chronic_hcc_no_esrd$model_version <- NULL

chronic_hcc_no_esrd <- collapse::roworderv(
  chronic_hcc_no_esrd,
  c("model", "hcc")
) |>
  vctrs::vec_unique() |>
  collapse::rsplit(~model)
names(chronic_hcc_no_esrd) <- heck::to_snek_case(names(chronic_hcc_no_esrd))
usethis::use_data(chronic_hcc_no_esrd, overwrite = TRUE)
