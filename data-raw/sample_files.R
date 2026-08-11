## code to prepare `sample_files` dataset goes here
# sample_834 = fs::dir_ls(path, regexp = "834_[0][0-9][.]txt$")
# sample_837 = fs::dir_ls(path, regexp = "837_[0][0-9][.]txt$")
# sample_eob = fs::dir_ls(path, regexp = "eob")
path = here::here(
  "data-raw",
  "hccinfhir-main",
  "src",
  "hccinfhir",
  "sample_files"
)

star_split <- \(x) {
  strsplit(x, "*", fixed = TRUE)[[1]][-1]
}

sample_820 = fs::dir_ls(path, regexp = "820_[0][0-9][.]txt$")
x = brio::read_lines(sample_820[1])
x = strsplit(x[1], "~", fixed = TRUE)[[1]]
cat(x, sep = "\n")


# ISA Interchange Control Header - Length = 16
isa = strsplit(x[1], " ", fixed = TRUE)[[1]]
isa = unlist_(strsplit(isa[nzchar(isa)], "*", fixed = TRUE))[c(-1, -8, -11)]
isa[!nzchar(isa)] <- NA_character_
isa

# GS Functional Group Header - Length = 8
gs = star_split(x[2])

# ST 820 Header - Length = 3
st = star_split(x[3])

# BPR Financial Information - Length = 16
bpr = star_split(x[4])
bpr[!nzchar(bpr)] <- NA_character_

# TRN Reassociation Trace Number - Length = 2
trn = star_split(x[5])

# REF Reference Identification
# Premium Receiver's Identification Key - Length = 2
ref = star_split(x[6])

# 1000A Loop: Premium Receiver's Loop
n1A = star_split(x[7]) # N1 Premium Receiver's Name
n3A = star_split(x[8]) # N3 Premium Receiver's Address
n4A = star_split(x[9]) # N4 Premium Receiver's City State ZIP

# 1000B Loop: Premium Payer's Loop
n1B = star_split(x[10]) # N1 Premium Payer's Name
n3B = star_split(x[11]) # N3 Premium Payer's Address
n4B = star_split(x[12]) # N4 Premium Payer's City State ZIP

# 2000B Loop: Individual Remittance Loop
# 2100B Loop: Individual Name Loop
# 2300B Loop: Individual Premium Remittance Detail Loop

list(
  ISA = list(
    `01` = isa[1], # Authorization Info Qualifier (00 == No Authorization Information Present)
    `02` = isa[2], # Authorization Information
    `03` = isa[3], # Security Info Qualifier (00 == No Security Information Present)
    `04` = isa[4], # Security Information
    `05` = isa[5], # Interchange ID Qualifier
    `06` = isa[6], # Interchange Sender ID
    `07` = isa[7], # Interchange ID Qualifier
    `08` = isa[8], # Interchange Receiver ID
    `09` = isa[9], # Interchange Date (YYMMDD)
    `10` = isa[10], # Interchange Time (HHMM)
    `11` = isa[11], # Interchange Control Standards - ID
    `12` = isa[12], # Interchange Control Version - Number
    `13` = isa[13], # Interchange Control Number
    `14` = isa[14], # Acknowledgment Requested (0 == No Acknowledgment Requested)
    `15` = isa[15], # Usage Indicator (P == Production Data)
    `16` = isa[16] # Component Element Separator
  ),
  GS = list(
    `01` = gs[1], # Functional Identifier Code
    `02` = gs[2], # Application Sender's Code
    `03` = gs[3], # Application Receiver's Code
    `04` = gs[4], # Date (YYYYMMDD)
    `05` = gs[5], # Time (HHMMSS)
    `06` = gs[6], # Group Control Number
    `07` = gs[7], # Responsible Agency Code (X = Accredited Standards Committee X12)
    `08` = gs[8] # Version/Release/Industry Identifier Code (HIPAA Release 005010X218)
  ),
  ST = list(
    `01` = st[1], # Transaction Set Identifier Code (820 = Payment Order/Remittance Advice)
    `02` = st[2], # Transaction Set Control Number
    `03` = st[3] # Implementation Convention Reference
  ),
  BPR = list(
    `01` = bpr[1], # Transaction Handling Code (I = Remittance Information Only)
    `02` = bpr[2], # Total Premium Payment Amount
    `03` = bpr[3], # Credit or Debit Flag Code (C = Credit)
    `04` = bpr[4], # Payment Method Code (Non = Non-Payment Data)
    `05` = bpr[5],
    `06` = bpr[6],
    `07` = bpr[7],
    `08` = bpr[8],
    `09` = bpr[9],
    `10` = bpr[10], # Payer Identifier
    `11` = bpr[11],
    `12` = bpr[12],
    `13` = bpr[13],
    `14` = bpr[14],
    `15` = bpr[15],
    `16` = bpr[16] # Check Issue or Effective Date (YYYYMMDD)
  ),
  TRN = list(
    `01` = trn[1], # Trace Type Code (3 = Financial Reassociation Trace Number)
    `02` = trn[2] # Check or EFT Trace Number
  ),
  REF = list(
    `01` = ref[1], # Reference Identification Qualifier (14 = Master Account Number)
    `02` = ref[2] # Premium Receiver Reference Identifier
  )
)
