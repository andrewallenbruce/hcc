## code to prepare `ra_dx_edits` dataset goes here
path = here::here("data-raw", "hccinfhir-main", "src", "hccinfhir", "data")
files = fs::dir_ls(path, regexp = "ra_dx_edits")
ra_dx_edits = vroom::vroom(files, col_types = "cciiicicc")
class(ra_dx_edits) = setdiff(class(ra_dx_edits), "spec_tbl_df")

collapse::setrename(
  ra_dx_edits,
  c(
    "icd10" = "icd",
    "age_min" = "min",
    "age_max" = "max",
    "cc_override" = "override"
  )
)

ra_dx_edits <- ra_dx_edits |>
  collapse::rsplit(~edit_type)

ra_dx_edits$age$sex <- NULL
ra_dx_edits$sex$min <- ra_dx_edits$sex$max <- NULL

age_min <- cheapr::sset(
  ra_dx_edits$age,
  !cheapr::is_na(ra_dx_edits$age$min) &
    cheapr::is_na(ra_dx_edits$age$max),
  c(1, 2, 4, 6, 7)
)

collapse::setrename(age_min, c("min" = "age"))
age_min$bound <- "min"

age_max <- cheapr::sset(
  ra_dx_edits$age,
  cheapr::is_na(ra_dx_edits$age$min) &
    !cheapr::is_na(ra_dx_edits$age$max),
  c(1, 3, 4, 5, 6, 7)
)

collapse::setrename(age_max, c("max" = "age"))
age_max$bound <- "max"

ra_dx_edits$age <- vctrs::vec_rbind(age_min, age_max) |>
  collapse::colorderv(c("icd", "age", "bound", "override")) |>
  collapse::roworderv("icd")

usethis::use_data(ra_dx_edits, overwrite = TRUE)
