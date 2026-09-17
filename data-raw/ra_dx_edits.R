## code to prepare `ra_dx_edits` dataset goes here
path <- here::here("data-raw", "hccinfhir-main", "src", "hccinfhir", "data")
files <- fs::dir_ls(path, regexp = "ra_dx_edits")
edits <- vroom::vroom(files, col_types = "cciiicicc")
class(edits) <- setdiff(class(edits), "spec_tbl_df")

collapse::setrename(
  edits,
  c(
    "icd10" = "icd",
    "age_min" = "min",
    "age_max" = "max",
    "cc_override" = "cc"
  )
)

edits <- collapse::rsplit(edits, ~edit_type)
collapse::gv(edits$age, "sex") <- NULL
collapse::gv(edits$sex, c("min", "max")) <- NULL

age_min <- cheapr::sset(
  edits$age,
  !cheapr::is_na(edits$age$min) &
    cheapr::is_na(edits$age$max),
  c(1, 2, 4, 6, 7)
)

collapse::setrename(age_min, c("min" = "age"))
age_min$bound <- "min"

age_max <- cheapr::sset(
  edits$age,
  cheapr::is_na(edits$age$min) &
    !cheapr::is_na(edits$age$max),
  c(1, 3, 4, 5, 6, 7)
)

collapse::setrename(age_max, c("max" = "age"))
age_max$bound <- "max"

edits$age <- vctrs::vec_rbind(age_min, age_max) |>
  collapse::colorderv(c("icd", "age", "bound", "action", "cc")) |>
  collapse::roworderv("icd")

edits$sex <- edits$sex |>
  collapse::colorderv(c("icd", "sex", "action", "cc")) |>
  collapse::roworderv("icd")

ra_dx_edits <- edits

usethis::use_data(ra_dx_edits, overwrite = TRUE)
