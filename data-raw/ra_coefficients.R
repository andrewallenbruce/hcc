## code to prepare `ra_coefficients` dataset goes here

make_model <- function(model_domain, model_version) {
  cheapr::if_else_(
    model_domain == "ESRD",
    cheapr::paste_("CMS-HCC ", model_domain, " Model V", model_version),
    cheapr::paste_(model_domain, " Model V", model_version)
  )
}

path = here::here("data-raw", "hccinfhir-main", "src", "hccinfhir", "data")
files = fs::dir_ls(path, regexp = "coefficients")

ra_coefficients_2025 = vroom::vroom(files[1], col_types = "cdcc")
ra_coefficients_2026 = vroom::vroom(files[2], col_types = "cdcc")
ra_coefficients_2027 = vroom::vroom(files[3], col_types = "cdcc")

# ===================================== 2025
class(ra_coefficients_2025) <- setdiff(
  class(ra_coefficients_2025),
  "spec_tbl_df"
)

ra_coefficients_2025$year <- 2025L

collapse::settfmv(ra_coefficients_2025, c("year"), as.integer)
collapse::settfmv(ra_coefficients_2025, c("value"), as.double)

ra_coefficients_2025 <- collapse::colorderv(ra_coefficients_2025, "year")

ra_coefficients_2025$model_version <- substr(
  ra_coefficients_2025$model_version,
  2L,
  3L
)
ra_coefficients_2025$model_name <- make_model(
  ra_coefficients_2025$model_domain,
  ra_coefficients_2025$model_version
)
ra_coefficients_2025$model_version <- NULL
ra_coefficients_2025$model_domain <- NULL
# ===================================== 2026
class(ra_coefficients_2026) <- setdiff(
  class(ra_coefficients_2026),
  "spec_tbl_df"
)

ra_coefficients_2026$year <- 2026

collapse::settfmv(ra_coefficients_2026, c("year"), as.integer)
collapse::settfmv(ra_coefficients_2026, c("value"), as.double)

ra_coefficients_2026 <- collapse::colorderv(ra_coefficients_2026, "year")

ra_coefficients_2026$model_version <- substr(
  ra_coefficients_2026$model_version,
  2L,
  3L
)
ra_coefficients_2026$model_name <- make_model(
  ra_coefficients_2026$model_domain,
  ra_coefficients_2026$model_version
)
ra_coefficients_2026$model_version <- NULL
ra_coefficients_2026$model_domain <- NULL

ra_coefficients = vctrs::vec_rbind(
  ra_coefficients_2025,
  ra_coefficients_2026
) |>
  vctrs::vec_unique()

usethis::use_data(ra_coefficients, overwrite = TRUE)
