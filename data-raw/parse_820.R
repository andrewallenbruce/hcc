# 2000B Loop: Individual Remittance Loop
# 2100B Loop: Individual Name Loop
# 2300B Loop: Individual Premium Remittance Detail Loop

dict_820 = list(
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
    `15` = "Usage Indicator", # P = Production, T = Test
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
    `01` = "Transaction Handling Code", # I = Remittance Information Only, C = Payment with Remittance
    `02` = "Total Premium Payment Amount",
    `03` = "Credit or Debit Flag Code", # C = Credit
    `04` = "Payment Method Code", # NON = Non-Payment Data, ACH, CHK, FWT = Wire
    `05` = "Payment Format Code", # CTX = Corporate Trade Exchange
    `06` = "Originating Bank Routing and Account",
    `07` = "Originating Bank Routing and Account",
    `08` = "Originating Bank Routing and Account",
    `09` = "Originating Bank Routing and Account",
    `10` = "Payer Identifier/Originator's ID",
    `11` = "Receiving Bank Routing and Account",
    `12` = "Receiving Bank Routing and Account",
    `13` = "Receiving Bank Routing and Account",
    `14` = "Receiving Bank Routing and Account",
    `15` = "Receiving Bank Routing and Account",
    `16` = "Check Issue or EFT Effective Date (YYYYMMDD)"
  ),
  TRN = list(
    `01` = "Trace Type Code", # 1 = Current Transaction Trace, 3 = Financial Reassociation Trace Number
    `02` = "Check or EFT Trace Number", # Reference identification (your payment trace number)
    `03` = "Originating company identifier"
  ),
  REF = list(
    `01` = "Reference Identification Qualifier", # 14 (Master Account Number)
    `02` = "Payee Reference Identifier"
  ),
  # 1000A Loop Premium Receiver's Name Loop
  `N1*PE` = list(
    `01` = "Entity Identifier Code",
    `02` = "Premium Receiver's Last or Organization Name"
  ),
  `N3*PE` = list(
    `01` = "Premium Receiver's Address Line"
  ),
  `N4*PE` = list(
    `01` = "Premium Receiver's City Name",
    `02` = "Premium Receiver's State Code",
    `03` = "Premium Receiver's Postal Zone or Zip Code"
  ),
  # 1000B Loop Premium Payer's Name Loop
  `N1*PR` = list(
    `01` = "Entity Identifier Code",
    `02` = "Premium Payer Name"
  ),
  `N3*PR` = list(
    `01` = "Premium Payer Address Line"
  ),
  `N4*PR` = list(
    `01` = "Premium Payer City Name",
    `02` = "Premium Payer State Code",
    `03` = "Premium Payer Postal Zone or Zip Code"
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
    # IK = Invoice Number, IV = Seller's Invoice Number,
    # AP = Accounts Receivable Number, CM = Buyer's Credit Memo,
    # CL = Seller's Credit Memo, PO = Purchase Order
    `01` = "Reference Identification Qualifier",
    `02` = "Insurance Remittance Reference Number",
    `03` = NA,
    `04` = "Detail Premium Payment Amount" # Amount Applied to This Invoice
  ),
  REF = list(
    `01` = "Organizational Reference Identification Qualifier", # 18 = Plan Number
    `02` = "Organizational Reference Identifier" # 957
  ),
  REF = list(
    `01` = "Organizational Reference Identification Qualifier", # ZZ = Mutually Defined
    `02` = "Organizational Reference Identifier" # 1H;2
  ),
  REF = list(
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
  collapse::sbt(!is.na(DESCRIPTION))
