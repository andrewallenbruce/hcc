## code to prepare `ra_coefficients` dataset goes here
make_model <- function(model_domain, model_version) {
  cheapr::if_else_(
    model_domain == "ESRD",
    cheapr::paste_("CMS-HCC ", model_domain, " Model V", model_version),
    cheapr::paste_(model_domain, " Model V", model_version)
  )
}

sub_mver <- \(x) substr(x, 2L, 3L)

rm_spec <- \(x) {
  class(x) <- setdiff(class(x), "spec_tbl_df")
  x
}


path <- here::here("data-raw", "hccinfhir-main", "src", "hccinfhir", "data")
files <- fs::dir_ls(path, regexp = "coefficients")

coef_2025 <- vroom::vroom(files[1], col_types = "cdcc") |> rm_spec()
coef_2026 <- vroom::vroom(files[2], col_types = "cdcc") |> rm_spec()
coef_2027 <- vroom::vroom(files[3], col_types = "cdcc") |> rm_spec()

coef_2025$year <- 2025L
coef_2026$year <- 2026L
coef_2027$year <- 2027L

coef_ <- vctrs::vec_rbind(coef_2025, coef_2026, coef_2026)
coef_$model_version <- sub_mver(coef_$model_version)
coef_$model_name <- make_model(coef_$model_domain, coef_$model_version)
collapse::gv(coef_, c("model_version", "model_domain")) <- NULL

ra_coefficients <- collapse::colorderv(vctrs::vec_unique(coef_), "year")

usethis::use_data(ra_coefficients, overwrite = TRUE)
