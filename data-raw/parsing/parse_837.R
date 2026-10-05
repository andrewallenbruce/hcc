# https://portal.stedi.com/app/guides/view/hipaa/health-care-claim-professional-x222a2/01GRYB6EJ999Y6MZ53ZBAHYBHE

# 1000A: Submitter Name Loop
# 1000B: Receiver Name Loop

# 2000A: Billing Provider Hierarchical Level Loop
# ====== All of the following variants may be used:
#    - 2010AA: Billing Provider Name Loop
#    - 2010AB: Pay-to Address Name Loop
#    - 2010AC: Pay-To Plan Name Loop

dict_837 = list(
  # length = 16
  ISA = list(
    `01` = "Authorization Info Qualifier", # 00 = No Authorization Information Present
    `02` = "Authorization Information",
    `03` = "Security Info Qualifier", # 00 = No Security Information Present
    `04` = "Security Information",
    `05` = "Interchange ID Qualifier", # ZZ = Mutually Defined
    `06` = "Interchange Sender ID",
    `07` = "Interchange ID Qualifier",
    `08` = "Interchange Receiver ID",
    `09` = "Interchange Date (YYMMDD)",
    `10` = "Interchange Time (HHMM)",
    `11` = "Repetition Separator", # `^`
    `12` = "Interchange Control Version Number",
    `13` = "Interchange Control Number",
    `14` = "Acknowledgment Requested", # 0 = No Acknowledgment Requested, 1 = Interchange Acknowledgment Requested (TA1)
    `15` = "Interchange Usage Indicator", # P = Production, T = Test, I = Information
    `16` = "Component Element Separator" # `>`
  ),
  # length = 8
  GS = list(
    `01` = "Functional Identifier Code",
    `02` = "Application Sender's Code",
    `03` = "Application Receiver's Code",
    `04` = "Date (YYYYMMDD)",
    `05` = "Time (HHMMSS)",
    `06` = "Group Control Number",
    `07` = "Responsible Agency Code", # X = Accredited Standards Committee X12, T = Transportation Data Coordinating Committee (TDCC)
    `08` = "Version / Release / Industry Identifier Code" # Ex., 005010X218, 005010X222A2 (HIPAA Releases)
  ),
  # length = 3
  ST = list(
    `01` = "Transaction Set Identifier Code", # 820 = Payment Order/Remittance Advice, 837 = Health Care Claim
    `02` = "Transaction Set Control Number", # !!!The Transaction Set Control Number in ST02 and SE02 must be identical
    `03` = "Implementation Guide Version Name" # Contains the same value as GS-08
  ),
  # length = 6
  BHT = list(
    `01` = "Hierarchical Structure Code", # 0019 Information Source, Subscriber, Dependent
    `02` = "Transaction Set Purpose Code", # 00 Original (Original transmissions are transmissions which have never been sent to the receiver.) 18 Reissue (If a transmission was disrupted and the receiver requests a retransmission, the sender uses "Reissue" to indicate the transmission has been previously sent.)
    `03` = "Originator Application Transaction Identifier",
    `04` = "Transaction Set Creation Date", # CCYYMMDD format
    `05` = "Transaction Set Creation Time", # HHMM, HHMMSS, HHMMSSD, or HHMMSSDD format
    `06` = "Claim or Encounter Identifier" # 31 = Subrogation Demand, CH = Chargeable, RP = Reporting
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


#' @noRd
ind_837I <- function(x) {
  list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    AMT = perl(x, "^AMT"),
    BHT = perl(x, "^BHT"),
    CAS = perl(x, "^CAS"),
    CL1 = perl(x, "^CL1"),
    CLM = perl(x, "^CLM"),
    CN1 = perl(x, "^CN1"),
    CR1 = perl(x, "^CR1"),
    CR2 = perl(x, "^CR2"),
    CR3 = perl(x, "^CR3"),
    CR8 = perl(x, "^CR8"),
    CRC = perl(x, "^CRC"),
    CTP = perl(x, "^CTP"),
    DMG = perl(x, "^DMG"),
    DMH = perl(x, "^DMH"),
    DTP096 = perl(x, "^DTP\\*096"),
    DTP434 = perl(x, "^DTP\\*434"),
    DTP435 = perl(x, "^DTP\\*435"),
    DTP472 = perl(x, "^DTP\\*472"),
    DTP523 = perl(x, "^DTP\\*523"),
    FRM = perl(x, "^FRM"),
    HCP = perl(x, "^HCP"),
    HIABJ = perl(x, "^HI\\*ABJ"),
    HIABK = perl(x, "^HI\\*ABK"),
    HIBE = perl(x, "^HI\\*BE"),
    HIBF = perl(x, "^HI\\*BF"),
    HIBG = perl(x, "^HI\\*BG"),
    HIBH = perl(x, "^HI\\*BH"),
    HIBK = perl(x, "^HI\\*BK"),
    HIBN = perl(x, "^HI\\*BN"),
    HIPR = perl(x, "^HI\\*PR"),
    HL = perl(x, "^HL"),
    K3 = perl(x, "^K3"),
    LIN = perl(x, "^LIN"),
    LQ = perl(x, "^LQ"),
    LU = perl(x, "^LU"),
    LX = perl(x, "^LX"),
    MEA = perl(x, "^MEA"),
    MOA = perl(x, "^MOA"),
    N3 = perl(x, "^N3"),
    N4 = perl(x, "^N4"),
    NM140 = perl(x, "^NM1\\*40"),
    NM141 = perl(x, "^NM1\\*41"),
    NM171 = perl(x, "^NM1\\*71"),
    NM185 = perl(x, "^NM1\\*85"),
    NM1IL = perl(x, "^NM1\\*IL"),
    NM1PR = perl(x, "^NM1\\*PR"),
    NM1QC = perl(x, "^NM1\\*QC"),
    NTE = perl(x, "^NTE"),
    OI = perl(x, "^OI"),
    PAT = perl(x, "^PAT"),
    PERIC = perl(x, "^PER\\*IC"),
    PRVBI = perl(x, "^PRV\\*BI"),
    PRVAT = perl(x, "^PRV\\*AT"),
    PWK = perl(x, "^PWK"),
    QTY = perl(x, "^QTY"),
    REF1G = perl(x, "^REF\\*1G"),
    REF2U = perl(x, "^REF\\*2U"),
    REF6R = perl(x, "^REF\\*6R"),
    REF9A = perl(x, "^REF\\*9A"),
    REFD9 = perl(x, "^REF\\*D9"),
    REFEI = perl(x, "^REF\\*EI"),
    REFG2 = perl(x, "^REF\\*G2"),
    REFLU = perl(x, "^REF\\*LU"),
    REFY4 = perl(x, "^REF\\*Y4"),
    SBRP = perl(x, "^SBR\\*P\\*"),
    SBRS = perl(x, "^SBR\\*S\\*"),
    SV1 = perl(x, "^SV1"),
    SV2 = perl(x, "^SV2"),
    SV5 = perl(x, "^SV5"),
    SE = perl(x, "^SE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )
}

#' @noRd
ind_837P <- function(x) {
  list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    AMT = perl(x, "^AMT"),
    BHT = perl(x, "^BHT"),
    CAS = perl(x, "^CAS"),
    CLM = perl(x, "^CLM"),
    CR1 = perl(x, "^CR1"),
    CR2 = perl(x, "^CR2"),
    CR3 = perl(x, "^CR3"),
    CRC = perl(x, "^CRC"),
    CTP = perl(x, "^CTP"),
    DMG = perl(x, "^DMG"),
    DTP096 = perl(x, "^DTP\\*096"),
    DTP431 = perl(x, "^DTP\\*431"),
    DTP434 = perl(x, "^DTP\\*434"),
    DTP439 = perl(x, "^DTP\\*439"),
    DTP435 = perl(x, "^DTP\\*435"),
    DTP453 = perl(x, "^DTP\\*453"),
    DTP454 = perl(x, "^DTP\\*454"),
    DTP455 = perl(x, "^DTP\\*455"),
    DTP461 = perl(x, "^DTP\\*461"),
    DTP463 = perl(x, "^DTP\\*463"),
    DTP472 = perl(x, "^DTP\\*472"),
    DTP523 = perl(x, "^DTP\\*523"),
    DTP573 = perl(x, "^DTP\\*573"),
    DTP607 = perl(x, "^DTP\\*607"),
    FRM = perl(x, "^FRM"),
    HCP = perl(x, "^HCP"),
    HIABK = perl(x, "^HI\\*ABK"),
    HIBK = perl(x, "^HI\\*BK"),
    HL = perl(x, "^HL"),
    LIN = perl(x, "^LIN"),
    LQ = perl(x, "^LQ"),
    LX = perl(x, "^LX"),
    MEA = perl(x, "^MEA"),
    N3 = perl(x, "^N3"),
    N4 = perl(x, "^N4"),
    NM140 = perl(x, "^NM1\\*40"),
    NM141 = perl(x, "^NM1\\*41"),
    NM145 = perl(x, "^NM1\\*45"),
    NM171 = perl(x, "^NM1\\*71"),
    NM177 = perl(x, "^NM1\\*77"),
    NM182 = perl(x, "^NM1\\*82"),
    NM185 = perl(x, "^NM1\\*85"),
    NM187 = perl(x, "^NM1\\*87"),
    NM1DK = perl(x, "^NM1\\*DK"),
    NM1DN = perl(x, "^NM1\\*DN"),
    NM1IL = perl(x, "^NM1\\*IL"),
    NM1PR = perl(x, "^NM1\\*PR"),
    NM1PW = perl(x, "^NM1\\*PW"),
    NM1QC = perl(x, "^NM1\\*QC"),
    NTE = perl(x, "^NTE"),
    OI = perl(x, "^OI"),
    PAT = perl(x, "^PAT"),
    PERIC = perl(x, "^PER\\*IC"),
    PRVBI = perl(x, "^PRV\\*BI"),
    PRVPE = perl(x, "^PRV\\*PE"),
    PWK = perl(x, "^PWK"),
    QTY = perl(x, "^QTY"),
    REF1G = perl(x, "^REF\\*1G"),
    REF6R = perl(x, "^REF\\*6R"),
    REF9A = perl(x, "^REF\\*9A"),
    REFD9 = perl(x, "^REF\\*D9"),
    REFEI = perl(x, "^REF\\*EI"),
    REFG2 = perl(x, "^REF\\*G2"),
    SBRP = perl(x, "^SBR\\*P\\*"),
    SBRS = perl(x, "^SBR\\*S\\*"),
    SV1 = perl(x, "^SV1"),
    SVD = perl(x, "^SVD"),
    SE = perl(x, "^SE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )
}
