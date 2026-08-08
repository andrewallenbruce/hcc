## code to prepare `sample_files` dataset goes here
path = here::here(
  "data-raw",
  "hccinfhir-main",
  "src",
  "hccinfhir",
  "sample_files"
)
sample_820 = fs::dir_ls(path, regexp = "820")
sample_834 = fs::dir_ls(path, regexp = "834")
sample_837 = fs::dir_ls(path, regexp = "837")
sample_eob = fs::dir_ls(path, regexp = "eob")

s820_01 = brio::read_lines(sample_820[1])
# stringr::str_locate_all(s820_01, "~")
s820_01 = stringr::str_split(s820_01, stringr::fixed("~"))[[1]]
s820_01 = stringr::str_squish(s820_01)
s820_01 = s820_01[nzchar(s820_01)]
s820_01


stringr::str_split(s820_01, stringr::fixed("~")) |> unlist(use.names = FALSE)
s820_01 = stringr::str_replace_all(s820_01, "\\s", "<>")
s820_01 = stringr::str_split(s820_01, "(<><><><><>)+")[[1]]
s820_01 = stringr::str_replace_all(s820_01, "<>", "-")
# s820_01 = s820_01[s820_01 != ""]
s820_01 = stringr::str_split(s820_01, ";") |> unlist(use.names = FALSE)
s820_01 = stringr::str_split(s820_01, stringr::fixed("****")) |>
  unlist(use.names = FALSE)
