## code to prepare `ra_dx_edits` dataset goes here
path = here::here("data-raw", "hccinfhir-main", "src", "hccinfhir", "data")
files = fs::dir_ls(path, regexp = "ra_dx_edits")

ra_dx_edits = vroom::vroom(files, col_types = "ccc")

class(ra_dx_edits) <- setdiff(
  class(ra_dx_edits),
  "spec_tbl_df"
)

collapse::settfmv(
  ra_dx_edits,
  c("sex", "age_min", "age_max", "cc_override"),
  as.integer
)
usethis::use_data(ra_dx_edits, overwrite = TRUE)


ra_dx_edits = hcc::ra_dx_edits |>
  collapse::rsplit(~edit_type)

ra_dx_edits$age$sex <- NULL
ra_dx_edits$sex$age_min <- ra_dx_edits$sex$age_max <- NULL

age_min <- cheapr::sset(
  ra_dx_edits$age,
  !cheapr::is_na(ra_dx_edits$age$age_min) &
    cheapr::is_na(ra_dx_edits$age$age_max),
  c(1, 2, 4, 6, 7)
)

collapse::setrename(age_min, c("age_min" = "age"))
age_min$bound <- "min"

age_max <- cheapr::sset(
  ra_dx_edits$age,
  cheapr::is_na(ra_dx_edits$age$age_min) &
    !cheapr::is_na(ra_dx_edits$age$age_max),
  c(1, 3, 4, 5, 6, 7)
) |>
  vctrs::vec_unique()

collapse::setrename(age_max, c("age_max" = "age"))
age_max$bound <- "max"


list(
  sex = ra_dx_edits$sex,
  age = vctrs::vec_rbind(age_min, age_max) |>
    collapse::rnm(c("cc_override" = "cc_over")) |>
    collapse::colorderv(c("icd10", "age", "bound"))
)
