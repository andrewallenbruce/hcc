## code to prepare `ph_race` dataset goes here
path = here::here("data-raw", "hccinfhir-main", "src", "hccinfhir", "data")
files = fs::dir_ls(path, regexp = "ph_race_and_ethnicity_cdc_v1.3")
ph_race = vroom::vroom(files, col_types = "ccccccccc")
collapse::setrename(ph_race, heck::to_snake_case)
collapse::setrename(
  ph_race,
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
ph_race <- collapse::colorderv(ph_race, "code")
usethis::use_data(ph_race, overwrite = TRUE)
