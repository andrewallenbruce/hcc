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
    # length = 16
    `01` = "Transaction Handling Code", # I = Remittance Information Only, C = Payment with Remittance
    `02` = "Total Payment Amount", # The total payment amount for this 820 cannot exceed eleven characters, including decimals (99999999.99). Although the value can be zero, the 820 cannot be issued for less than zero dollars.
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
    # length = 2
    `01` = "Trace Type Code", # 1 = Current Transaction Trace, 3 = Financial Reassociation Trace Number
    `02` = "Check or EFT Trace Number"
  ),
  # REF Variants:
  # 1. 14 (Master Account Number), Premium Receiver Reference Identifier
  # 4. 18 (Plan Number), Exchange Assigned Employer Group Identifier
  # 2. 38 (Master Policy Number), Exchange Assigned Qualified Health Plan Identifier
  # 5. 1L (Group or Policy Number), Issuer Assigned Employer Group Identifier
  # 3. TV (Line of Business), Issuer Assigned Qualified Health Plan Identifier
  # 2F (Consolidated Invoice Number)
  # 17 (Client Reporting Category)
  # 72 (Schedule Reference Number)
  # LB (Lockbox)
  REF = list(
    `01` = "Reference Identification Qualifier",
    `02` = "Exchange Assigned Qualified Health Plan Identifier"
  ),
  # 1000A Payee Name Loop
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
