## code to prepare `ra_dx_to_cc` dataset goes here
path <- here::here("data-raw", "hccinfhir-main", "src", "hccinfhir", "data")
files <- fs::dir_ls(path, regexp = "ra_dx_to")

rm_spec <- function(x) {
  class(x) <- setdiff(class(x), "spec_tbl_df")
  x
}

dx_2025 <- vroom::vroom(files[1], col_types = "cic") |> rm_spec()
dx_2026 <- vroom::vroom(files[2], col_types = "cic") |> rm_spec()

dx_2025$year <- 2025L
dx_2026$year <- 2026L

ra_dx_to_cc <- vctrs::vec_rbind(dx_2025, dx_2026) |>
  vctrs::vec_unique() |>
  collapse::colorderv("year") |>
  collapse::rnm("icd_code" = "diagnosis_code") |>
  collapse::roworderv(c("year", "model_name"))

usethis::use_data(ra_dx_to_cc, overwrite = TRUE)

collapse::rsplit(
  collapse::roworderv(
    hcc::ra_dx_to_cc,
    c("year", "cc")
  ),
  ~model_name
)
