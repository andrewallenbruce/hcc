x = split_tilde(hcc::x12_820[[1]])
cat(x, sep = "\n")

# ISA Interchange Control Header - Length = 16
isa = strsplit(x[1], " ", fixed = TRUE)[[1]]
isa = unlist_(strsplit(isa[nzchar(isa)], "*", fixed = TRUE))[c(-1, -8, -11)]
isa = pad_names(isa, replace_na = TRUE)

# GS Functional Group Header - Length = 8
gs = split_star(x[2], pad = TRUE)

# ST 820 Header - Length = 3
st = split_star(x[3], pad = TRUE)

# BPR Financial Information - Length = 16
bpr = split_star(x[4], pad = TRUE, replace_na = TRUE)

# TRN Reassociation Trace Number - Length = 2
trn = split_star(x[5], pad = TRUE)

# REF Reference Identification
# Premium Receiver's Identification Key - Length = 2
ref = split_star(x[6], pad = TRUE)

# 1000A Loop: Premium Receiver's Loop
n1pe = split_star(x[7], pad = TRUE) # N1 Premium Receiver's Name
n3pe = split_star(x[8], pad = TRUE) # N3 Premium Receiver's Address
n4pe = split_star(x[9], pad = TRUE) # N4 Premium Receiver's City State ZIP

# 1000B Loop: Premium Payer's Loop
n1pr = split_star(x[10], pad = TRUE) # N1 Premium Payer's Name
n3pr = split_star(x[11], pad = TRUE) # N3 Premium Payer's Address
n4pr = split_star(x[12], pad = TRUE) # N4 Premium Payer's City State ZIP

# 2000B Loop: Individual Remittance Loop
# 2100B Loop: Individual Name Loop
# 2300B Loop: Individual Premium Remittance Detail Loop

list(
  ISA = list(
    `01` = "Authorization Info Qualifier", # 00 (No Authorization Information Present)
    `02` = "Authorization Information",
    `03` = "Security Info Qualifier", # 00 (No Security Information Present)
    `04` = "Security Information",
    `05` = "Interchange ID Qualifier",
    `06` = "Interchange Sender ID",
    `07` = "Interchange ID Qualifier",
    `08` = "Interchange Receiver ID",
    `09` = "Interchange Date (YYMMDD)",
    `10` = "Interchange Time (HHMM)",
    `11` = "Interchange Control Standards - ID",
    `12` = "Interchange Control Version - Number",
    `13` = "Interchange Control Number",
    `14` = "Acknowledgment Requested", # 0 (No Acknowledgment Requested)
    `15` = "Usage Indicator", # P (Production Data)
    `16` = "Component Element Separator"
  ),
  GS = list(
    `01` = "Functional Identifier Code",
    `02` = "Application Sender's Code",
    `03` = "Application Receiver's Code",
    `04` = "Date (YYYYMMDD)",
    `05` = "Time (HHMMSS)",
    `06` = "Group Control Number",
    `07` = "Responsible Agency Code", # (X = Accredited Standards Committee X12)
    `08` = "Industry Identifier Code" # (HIPAA Release 005010X218)
  ),
  ST = list(
    `01` = "Transaction Set Identifier Code", # 820 (Payment Order/Remittance Advice)
    `02` = "Transaction Set Control Number",
    `03` = "Implementation Convention Reference"
  ),
  BPR = list(
    `01` = "Transaction Handling Code", # I (Remittance Information Only)
    `02` = "Total Premium Payment Amount",
    `03` = "Credit or Debit Flag Code", # C (Credit)
    `04` = "Payment Method Code", # NON (Non-Payment Data)
    `05` = NA,
    `06` = NA,
    `07` = NA,
    `08` = NA,
    `09` = NA,
    `10` = "Payer Identifier",
    `11` = NA,
    `12` = NA,
    `13` = NA,
    `14` = NA,
    `15` = NA,
    `16` = "Check Effective Date (YYYYMMDD)"
  ),
  TRN = list(
    `01` = "Trace Type Code", # 3 (Financial Reassociation Trace Number)
    `02` = "Check or EFT Trace Number"
  ),
  REF = list(
    `01` = "Reference Identification Qualifier", # 14 (Master Account Number)
    `02` = "Payee Reference Identifier"
  ),
  PE = list(
    N1 = "Payee's Name",
    N3 = "Payee's Address",
    N4 = "Payee's City",
    N4 = "Payee's State",
    N4 = "Payee's ZIP"
  ),
  PR = list(
    N1 = "Payer's Name",
    N3 = "Payer's Address",
    N4 = "Payer's City",
    N4 = "Payer's State",
    N4 = "Payer's ZIP"
  )
) |>
  collapse::unlist2d(idcols = "ID") |>
  collapse::rnm("ID.1" = "SEG", "ID.2" = "N", "V1" = "Meaning") |>
  collapse::sbt(!is.na(Meaning))
