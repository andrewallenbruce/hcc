## code to prepare `ph_race` dataset goes here
path = here::here("data-raw", "hccinfhir-main", "src", "hccinfhir", "data")
files = fs::dir_ls(path, regexp = "ph_race_and_ethnicity_cdc_v1.3")
ra_race = vroom::vroom(files, col_types = "ccccccccc")
collapse::setrename(ra_race, heck::to_snake_case)
collapse::setrename(
  ra_race,
  c(
    "code",
    "hierarchy",
    "name",
    "preferred",
    "date_added",
    "fed_status",
    "file_date",
    "sdo_status",
    "sys_oid"
  )
)
ra_race <- collapse::colorderv(ra_race, "code")
usethis::use_data(ra_race, overwrite = TRUE)
