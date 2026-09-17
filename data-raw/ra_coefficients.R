## code to prepare `ra_coefficients` dataset goes here
make_model <- function(model_domain, model_version) {
  cheapr::if_else_(
    model_domain == "ESRD",
    cheapr::paste_("CMS-HCC ", model_domain, " Model V", model_version),
    cheapr::paste_(model_domain, " Model V", model_version)
  )
}

rm_spec <- function(x) {
  class(x) <- setdiff(class(x), "spec_tbl_df")
  x
}

sub_mver <- function(x) {
  substr(x, 2L, 3L)
}

path = here::here("data-raw", "hccinfhir-main", "src", "hccinfhir", "data")
files = fs::dir_ls(path, regexp = "coefficients")

coef_2025 = vroom::vroom(files[1], col_types = "cdcc") |> rm_spec()
coef_2026 = vroom::vroom(files[2], col_types = "cdcc") |> rm_spec()
coef_2027 = vroom::vroom(files[3], col_types = "cdcc") |> rm_spec()

coef_2025$year <- 2025L
coef_2026$year <- 2026L
coef_2027$year <- 2027L

coef_2025$model_version <- sub_mver(coef_2025$model_version)
coef_2026$model_version <- sub_mver(coef_2026$model_version)
coef_2027$model_version <- sub_mver(coef_2027$model_version)

coef_2025$model_name <- make_model(
  coef_2025$model_domain,
  coef_2025$model_version
)
coef_2026$model_name <- make_model(
  coef_2026$model_domain,
  coef_2026$model_version
)
coef_2027$model_name <- make_model(
  coef_2027$model_domain,
  coef_2027$model_version
)

collapse::gv(coef_2025, c("model_version", "model_domain")) <- NULL
collapse::gv(coef_2026, c("model_version", "model_domain")) <- NULL
collapse::gv(coef_2027, c("model_version", "model_domain")) <- NULL

ra_coefficients <- vctrs::vec_rbind(coef_2025, coef_2026, coef_2026) |>
  vctrs::vec_unique() |>
  collapse::colorderv("year")

usethis::use_data(ra_coefficients, overwrite = TRUE)
