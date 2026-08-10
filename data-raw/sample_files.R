## code to prepare `sample_files` dataset goes here
path = here::here(
  "data-raw",
  "hccinfhir-main",
  "src",
  "hccinfhir",
  "sample_files"
)

sample_820 = fs::dir_ls(path, regexp = "820_[0][0-9][.]txt$")
# sample_834 = fs::dir_ls(path, regexp = "834_[0][0-9][.]txt$")
# sample_837 = fs::dir_ls(path, regexp = "837_[0][0-9][.]txt$")
# sample_eob = fs::dir_ls(path, regexp = "eob")

x = brio::read_lines(sample_820[1])
x = stringr::str_split(x, stringr::fixed("~"))[[1]]
x = x[nzchar(x)]

isa = strsplit(x[1], " ", fixed = TRUE)[[1]]
isa = unlist_(strsplit(isa[nzchar(isa)], "*", fixed = TRUE))[c(-1, -8, -11)]
# isa = isa[nzchar(isa)]

gs = strsplit(x[2], "*", fixed = TRUE)[[1]][-1]
gs

st = strsplit(x[3], "*", fixed = TRUE)[[1]][-1]
st

# ISA (Interchange Control Header)
# The ISA segment begins every EDI interchange and contains
# sender/receiver identification and control information.
list(
  ISA = list(
    `01` = isa[1], # Authorization Info Qualifier <Required>. 00 == No Authorization Information Present.
    `02` = isa[2], # Authorization Information <Required>
    `03` = isa[3], # Security Info Qualifier <Required>. 00 == No Security Information Present.
    `04` = isa[4], # Security Information <Required>
    `05` = isa[5], # Interchange ID Qualifier <Required>
    `06` = isa[6], # Interchange Sender ID <Required>
    `07` = isa[7], # Interchange ID Qualifier <Required>
    `08` = isa[8], # Interchange Receiver ID <Required>
    `09` = isa[9], # Interchange Date (YYMMDD format) <Required>
    `10` = isa[10], # Interchange Time (HHMM format) <Required>
    `11` = isa[11], # Interchange Control Standards - ID <Required>
    `12` = isa[12], # Interchange Control Version - Number <Required>
    `13` = isa[13], # Interchange Control Number <Required>
    `14` = isa[14], # Acknowledgment Requested <Required>. 0 == No Acknowledgment Requested.
    `15` = isa[15], # Usage Indicator <Required>. P == Production Data
    `16` = isa[16] # Component Element Separator <Required>
  ),
  GS = list(
    `01` = gs[1], # Authorization Info Qualifier <Required>. 00 == No Authorization Information Present.
    `02` = gs[2], # Authorization Information <Required>
    `03` = gs[3], # Security Info Qualifier <Required>. 00 == No Security Information Present.
    `04` = gs[4], # Security Information <Required>
    `05` = gs[5], # Interchange ID Qualifier <Required>
    `06` = gs[6], # Interchange Sender ID <Required>
    `07` = gs[7], # Interchange ID Qualifier <Required>
    `08` = gs[8] # Interchange Receiver ID <Required>
  ),
  ST = list(
    `01` = st[1],
    `02` = st[2],
    `03` = st[3]
  )
)
