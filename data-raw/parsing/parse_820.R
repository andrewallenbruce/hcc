# https://portal.stedi.com/app/guides/view/hipaa/health-insurance-exchange-related-payments-x306/01HQ4HZB22GES43ZEA8H62Y77C
# https://portal.stedi.com/app/guides/view/hipaa/payroll-deducted-and-other-group-premium-payment-for-insurance-products-examples-x218/01GRYB6CPB1S1257NJJP6K497B

# 2000B Loop: Individual Remittance Loop
# 2100B Loop: Individual Name Loop
# 2300B Loop: Individual Premium Remittance Detail Loop
dict_820 = list(
  # length = 16
  ISA = list(
    `01` = "Authorization Info Qualifier", # 00 = No Authorization Information Present
    `02` = "Authorization Information",
    `03` = "Security Info Qualifier", # 00 = No Security Information Present
    `04` = "Security Information",
    `05` = "Interchange ID Qualifier",
    `06` = "Interchange Sender ID",
    `07` = "Interchange ID Qualifier",
    `08` = "Interchange Receiver ID",
    `09` = "Interchange Date", # YYMMDD
    `10` = "Interchange Time", # HHMM
    `11` = "Repetition Separator", # ^
    `12` = "Interchange Control Version Number", # 00501 = Standards Approved for Publication by ASC X12 Procedures Review Board through October 2003
    `13` = "Interchange Control Number",
    `14` = "Acknowledgment Requested", # 0 = No Acknowledgment Requested
    `15` = "Interchange Usage Indicator", # P = Production, T = Test, I = Information
    `16` = "Component Element Separator" # >
  ),
  GS = list(
    # length = 8
    `01` = "Functional Identifier Code", # RA = Payment Order/Remittance Advice (820)
    `02` = "Application Sender's Code",
    `03` = "Application Receiver's Code",
    `04` = "Date", # CCYYMMDD format
    `05` = "Time", # HHMM, HHMMSS, HHMMSSD, or HHMMSSDD format
    `06` = "Group Control Number",
    `07` = "Responsible Agency Code", # X = Accredited Standards Committee X12, T = Transportation Data Coordinating Committee (TDCC)
    `08` = "Version / Release / Industry Identifier Code" # (HIPAA Release 005010X218)
  ),
  ST = list(
    # length = 3
    `01` = "Transaction Set Identifier Code", # 820 = Payment Order/Remittance Advice
    `02` = "Transaction Set Control Number",
    `03` = "Implementation Convention Reference" # Must be the same as the value in GS-08
  ),
  BPR = list(
    `01` = "Transaction Handling Code", # I = Remittance Information Only, C = Payment with Remittance
    `02` = "Total Premium Payment Amount", # The total payment amount for this 820 cannot exceed eleven characters, including decimals (99999999.99). Although the value can be zero, the 820 cannot be issued for less than zero dollars.
    `03` = "Credit or Debit Flag Code", # C = Credit, D = Debit
    `04` = "Payment Method Code", # NON = Non-Payment Data (No dollars, nothing paid), ACH = Automated Clearing House, CHK = Check, FWT = Federal Reserve Funds/Wire Transfer - Nonrepetitive, BOP = Financial Institution Option
    `05` = "Payment Format Code", # CCP = Cash Concentration/Disbursement plus Addenda (CCD+) (ACH), CTX = Corporate Trade Exchange
    `06` = "Depository Financial Institution (DFI) Identification Number Qualifier", # 01 = ABA Transit Routing Number Including Check Digits (9 digits), 02 = Swift Identification (8 or 11 characters), 04 = Canadian Bank Branch and Institution Number
    `07` = "Originating Depository Financial Institution (DFI) Identifier",
    `08` = "Account Number Qualifier", # DA = Demand Deposit, SG = Savings, ALC = Agency Location Code
    `09` = "Sender Bank Account Number",
    `10` = "Payer Identifier",
    `11` = "Originating Company Supplemental Code", # must be identical to the value sent in the TRN04 data element
    `12` = "Depository Financial Institution (DFI) Identification Number Qualifier", # 01 = ABA Transit Routing Number Including Check Digits (9 digits), 02 = Swift Identification (8 or 11 characters), 04 = Canadian Bank Branch and Institution Number
    `13` = "Receiving Depository Financial Institution (DFI) Identifier",
    `14` = "Account Number Qualifier", # DA = Demand Deposit, SG = Savings, ALC = Agency Location Code
    `15` = "Receiver Bank Account Number",
    `16` = "Check Issue or EFT Effective Date" # CCYYMMDD format
  ),
  TRN = list(
    `01` = "Trace Type Code", # 1 = Current Transaction Trace, 3 = Financial Reassociation Trace Number
    `02` = "Check or EFT Trace Number",
    `03` = "Originating Company Identifier",
    `04` = "Originating Company Supplemental Code"
  ),
  REF = list(
    `01` = "Reference Identification Qualifier", # 2F Consolidated Invoice Number, 14 Master Account Number, 17 Client Reporting Category, 18 Plan Number, 38 Master Policy Number, 72 Schedule Reference Number, LB Lockbox
    `02` = "Exchange Assigned Qualified Health Plan Identifier"
  ),
  DTM = list(
    `01` = "Date Time Qualifier", # 009 Process, 035 Delivered, 582 Report Period, 097 Transaction Creation
    `02` = "Payer Process Date"
  ),
  N1 = list(
    `01` = "Entity Identifier Code",
    `02` = "Premium Receiver's Last or Organization Name",
    `03` = "Identification Code Qualifier",
    `04` = "Premium Receiver's Identification Code"
  ),
  N3 = list(
    `01` = "Premium Receiver's Address Line",
    `02` = "Premium Receiver's Address Line"
  ),
  N4 = list(
    `01` = "Premium Receiver's City Name",
    `02` = "Premium Receiver's State Code",
    `03` = "Premium Receiver's Postal Zone or Zip Code",
    `04` = "Country Code",
    `07` = "Country Subdivision Code"
  ),
  PER = list(
    `01` = "Premium Receiver's City Name",
    `02` = "Premium Receiver's State Code",
    `03` = "Premium Receiver's Postal Zone or Zip Code",
    `04` = "Country Code",
    `07` = "Country Subdivision Code"
  ),
  # 2000B Loop Individual Remittance Loop
  ENT = list(
    `01` = "Assigned Number", # 1
    `02` = "Entity Identifier Code", # 2J = Individual
    `03` = "Identification Code Qualifier", # EI = Employee Identification Number
    `04` = "Receiver's Individual Identifier" # 999999999
  ),
  # 2100B Loop Individual Name Loop
  NM1 = list(
    `01` = "Entity Identifier Code", # IL = Insured or Subscriber
    `02` = "Entity Type Qualifier", # 1 = Person
    `03` = "Individual Last Name",
    `04` = "Individual First Name",
    `05` = NA,
    `06` = NA,
    `07` = NA,
    `08` = "Identification Code Qualifier", # N = Insured's Unique Identification Number
    `09` = "Individual Identifier"
  ),
  # 2300B Loop Individual Premium Remittance Detail Loop
  RMR = list(
    # IK = Invoice Number
    # IV = Seller's Invoice Number
    # AP = Accounts Receivable Number
    # CM = Buyer's Credit Memo
    # CL = Seller's Credit Memo
    # PO = Purchase Order
    `01` = "Reference Identification Qualifier",
    `02` = "Insurance Remittance Reference Number",
    `03` = NA,
    `04` = "Detail Premium Payment Amount" # Amount Applied to This Invoice
  ),
  REF18 = list(
    `01` = "Organizational Reference Identification Qualifier", # 18 = Plan Number
    `02` = "Organizational Reference Identifier" # 957
  ),
  REFZZ = list(
    `01` = "Organizational Reference Identification Qualifier", # ZZ = Mutually Defined
    `02` = "Organizational Reference Identifier" # 1H;2
  ),
  REFZZ = list(
    `01` = "Organizational Reference Identification Qualifier", # ZZ = Mutually Defined
    `02` = "Organizational Reference Identifier" # Medi-Cal Only-State Only
  ),
  # Individual Coverage Period
  DTM = list(
    `01` = "Date Time Qualifier", # 582 = Report Period, 007 = Effective Date, 003 = Invoice Date
    `02` = "Date in CCYYMMDD format",
    `03` = NA,
    `04` = NA,
    `05` = "Date Time Period Format Qualifier", # RD8 = Range of Dates Expressed in Format CCYYMMDD-CCYYMMDD
    `06` = "Coverage Period" # 20251201-20251231
  ),
  # Adjustment Segments (ADX): When the buyer takes a deduction, the ADX segment follows the related RMR
  ADX = list(
    `01` = "Adjustment Amount",
    `02` = "Adjustment Reason Code", # 01 = Pricing Error, 02 = Quantity Contested, 03 = Quality/damaged Goods, 04 = Delivery Issue, 05 = Early Payment Discount Taken
    `03` = "Reference ID Qualifier"
  ),
  # Transaction Set Trailer
  SE = list(
    `01` = "Transaction Segment Count", # 100
    `02` = "Transaction Set Control Number" # 1
  ),
  # Functional Group Trailer
  GE = list(
    `01` = "Number of Transaction Sets Included", # 1
    `02` = "Group Control Number" # 43304
  ),
  # Interchange Control Trailer
  IEA = list(
    `01` = "Number of Included Functional Groups", # 1
    `02` = "Interchange Control Number" # 000058691
  )
) |>
  collapse::unlist2d(idcols = "ID") |>
  collapse::rnm("ID.1" = "SEG", "ID.2" = "PT", "V1" = "DESCRIPTION") |>
  collapse::sbt(!is.na(DESCRIPTION)) |>
  collapse::qTBL()

dict_820

# ST01(820) - ST03=GS08(005010X218)
# https://portal.stedi.com/app/guides/view/hipaa/payroll-deducted-and-other-group-premium-payment-for-insurance-products-examples-x218/01GRYB6CPB1S1257NJJP6K497B
# e = edi_index(x12_EX$`820`$`218`)
# i820_218(x$sample_820_01)
# i820_218(x$sample_820_03)
# x = edi_index(x12_EX$`820`$`218`$`820_Premium_Payment_EFT`) |> str()
# i = i820_218(x)
#' @noRd
ind_820_218 <- function(x) {
  list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    BPR = perl(x, "^BPR"),
    TRN = perl(x, "^TRN"),
    CUR = perl(x, "^CUR"),
    REF14 = perl(x, "^REF\\*14"),
    N1PE = perl(x, "^N1\\*PE"),
    N1PR = perl(x, "^N1\\*PR"),
    N3 = perl(x, "^N3"),
    N4 = perl(x, "^N4"),
    PERIC = perl(x, "^PER\\*IC"),
    ENT = perl(x, "^ENT"),
    NM1 = perl(x, "^NM1\\*(DO|EY|IL|QE)"),
    RMR = perl(x, "^RMR"),
    REF18 = perl(x, "^REF\\*18"),
    REF38 = perl(x, "^REF\\*38"),
    REFTV = perl(x, "^REF\\*TV"),
    REF1L = perl(x, "^REF\\*1L"),
    REFABY = perl(x, "^REF\\*ABY"),
    REFZZ = perl(x, "^REF\\*ZZ"),
    REFLU = perl(x, "^REF\\*LU"),
    DTM582 = perl(x, "^DTM\\*582"),
    DTM009 = perl(x, "^DTM\\*009"),
    DTM035 = perl(x, "^DTM\\*035"),
    DTMAAG = perl(x, "^DTM\\*AAG"),
    DTM097 = perl(x, "^DTM\\*097"),
    SLN = perl(x, "^SLN"),
    IT = perl(x, "^IT"),
    ADX = perl(x, "^ADX"),
    SE = perl(x, "^SE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )
}

# ST01(820) - ST03=GS08(005010X306)
# https://portal.stedi.com/app/guides/view/hipaa/health-insurance-exchange-related-payments-x306/01HQ4HZB22GES43ZEA8H62Y77C
#' @noRd
ind_820_306 <- function(x) {
  list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    BPR = perl(x, "^BPR"),
    DTM582 = perl(x, "^DTM\\*582"),
    ENT = perl(x, "^ENT"),
    N1PE = perl(x, "^N1\\*PE"),
    N1RM = perl(x, "^N1\\*RM"),
    NM1 = perl(x, "^NM1"),
    PERIC = perl(x, "^PER\\*IC"),
    REF18 = perl(x, "^REF\\*18"),
    REF23 = perl(x, "^REF\\*23"),
    REF38 = perl(x, "^REF\\*38"),
    REF0F = perl(x, "^REF\\*0F"),
    REF0N = perl(x, "^REF\\*0N"),
    REF1L = perl(x, "^REF\\*1L"),
    REF1W = perl(x, "^REF\\*1W"),
    REF4A = perl(x, "^REF\\*4A"),
    REF60 = perl(x, "^REF\\*60"),
    REFABY = perl(x, "^REF\\*ABY"),
    REFAZ = perl(x, "^REF\\*AZ"),
    REFPOL = perl(x, "^REF\\*POL"),
    REFTV = perl(x, "^REF\\*TV"),
    REFZZ = perl(x, "^REF\\*ZZ"),
    RMR = perl(x, "^RMR"),
    TRN = perl(x, "^TRN"),
    SE = perl(x, "^SE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )
}
