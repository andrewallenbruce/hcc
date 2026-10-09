# https://portal.stedi.com/app/guides/view/hipaa/health-insurance-exchange-related-payments-x306/01HQ4HZB22GES43ZEA8H62Y77C
# https://portal.stedi.com/app/guides/view/hipaa/payroll-deducted-and-other-group-premium-payment-for-insurance-products-examples-x218/01GRYB6CPB1S1257NJJP6K497B

# 2000B Loop: Individual Remittance Loop
# 2100B Loop: Individual Name Loop
# 2300B Loop: Individual Premium Remittance Detail Loop
dict_820 = list(
  ISA = list(
    `01` = "Authorization Info Qualifier",
    # 00 = No Authorization Information Present
    `02` = "Authorization Information",
    `03` = "Security Info Qualifier",
    # 00 = No Security Information Present
    `04` = "Security Information",
    `05` = "Interchange ID Qualifier",
    `06` = "Interchange Sender ID",
    `07` = "Interchange ID Qualifier",
    `08` = "Interchange Receiver ID",
    `09` = "Interchange Date",
    # YYMMDD
    `10` = "Interchange Time",
    # HHMM
    `11` = "Repetition Separator",
    # ^
    `12` = "Interchange Control Version Number",
    # 00501 = Standards Approved for Publication by ASC X12 Procedures Review Board through October 2003
    `13` = "Interchange Control Number",
    `14` = "Acknowledgment Requested",
    # 0 = No Acknowledgment Requested
    `15` = "Interchange Usage Indicator",
    # I = Information,
    # P = Production,
    # T = Test
    `16` = "Component Element Separator"
    # >
  ),
  GS = list(
    `01` = "Functional Identifier Code",
    # RA = Payment Order/Remittance Advice (820)
    `02` = "Application Sender's Code",
    `03` = "Application Receiver's Code",
    `04` = "Date",
    # CCYYMMDD format
    `05` = "Time",
    # HHMM, HHMMSS, HHMMSSD, or HHMMSSDD format
    `06` = "Group Control Number",
    `07` = "Responsible Agency Code",
    # T = Transportation Data Coordinating Committee (TDCC)
    # X = Accredited Standards Committee X12,
    `08` = "Version / Release / Industry Identifier Code"
    # (HIPAA Release 005010X218)
  ),
  ST = list(
    `01` = "Transaction Set Identifier Code",
    # 820 = Payment Order/Remittance Advice
    `02` = "Transaction Set Control Number",
    `03` = "Implementation Convention Reference"
    # Must be the same as the value in GS-08
  ),
  BPR = list(
    `01` = "Transaction Handling Code",
    # C = Payment Accompanies Remittance Advice,
    # D = Make Payment Only,
    # I = Remittance Information Only,
    # P = Prenotification of Future Transfers,
    # U = Split Payment and Remittance,
    # X = Handling Party's Option to Split Payment and Remittance
    `02` = "Total Premium Payment Amount",
    `03` = "Credit or Debit Flag Code",
    # C = Credit,
    # D = Debit
    `04` = "Payment Method Code",
    # ACH = Automated Clearing House,
    # BOP = Financial Institution Option,
    # CHK = Check,
    # FWT = Federal Reserve Funds/Wire Transfer - Nonrepetitive,
    # NON = Non-Payment Data,
    # SWT = SWIFT
    `05` = "Payment Format Code",
    # CCP = Cash Concentration/Disbursement plus Addenda (CCD+) (ACH),
    # CTX = Corporate Trade Exchange
    `06` = "Depository Financial Institution (DFI) Identification Number Qualifier",
    # 01 = ABA Transit Routing Number Including Check Digits (9 digits),
    # 02 = Swift Identification (8 or 11 characters),
    # 04 = Canadian Bank Branch and Institution Number
    `07` = "Originating Depository Financial Institution (DFI) Identifier",
    `08` = "Account Number Qualifier",
    # ALC = Agency Location Code,
    # DA = Demand Deposit,
    # SG = Savings
    `09` = "Sender Bank Account Number",
    `10` = "Payer Identifier",
    `11` = "Originating Company Supplemental Code",
    # Must be identical to the value sent in the TRN04 data element
    `12` = "Depository Financial Institution (DFI) Identification Number Qualifier",
    # 01 = ABA Transit Routing Number Including Check Digits (9 digits),
    # 02 = Swift Identification (8 or 11 characters),
    # 04 = Canadian Bank Branch and Institution Number
    `13` = "Receiving Depository Financial Institution (DFI) Identifier",
    `14` = "Account Number Qualifier",
    # DA = Demand Deposit
    # SG = Savings
    # ALC = Agency Location Code
    `15` = "Receiver Bank Account Number",
    `16` = "Check Issue or EFT Effective Date"
  ),
  TRN = list(
    `01` = "Trace Type Code",
    # 1 = Current Transaction Trace,
    # 3 = Financial Reassociation Trace Number
    `02` = "Check or EFT Trace Number",
    `03` = "Originating Company Identifier",
    `04` = "Originating Company Supplemental Code"
  ),
  REF = list(
    `01` = "Reference Identification Qualifier",
    `02` = "Reference Identifier"
  ),
  DTM = list(
    `01` = "Date Time Qualifier",
    # 009 = Process
    # 035 = Delivered
    # 582 = Report Period
    # 097 = Transaction Creation
    # AAG = Due Date
    `02` = "Date",
    `05` = "Date Time Period Qualifier",
    # RD8 = Range of Dates CCYYMMDD-CCYYMMDD
    `06` = "Coverage Period"
  ),
  IT1 = list(
    `01` = "Line Item Control Number",
  ),
  SLN = list(
    # Summary Line Item
    `01` = "Line Item Control Number",
    `02` = NA_character_,
    `03` = "Information Only Indicator",
    # O = Information Only
    `04` = "Head Count",
    `05` = "Composite Unit of Measure"
    # C000-01 = Unit or Basis for Measurement Code
    # 10 = Group,
    # IE = Person
    # PR = Pair
  ),
  N1 = list(
    `01` = "Entity Identifier Code",
    # 0B = Interim Funding Organization,
    # 04
    # 8W
    # AK
    # BE
    # BK
    # C1
    # C2
    # IAT
    # MJ
    # PE = Payee,
    # PR = Payer,
    # RB
    # Z6
    # ZB
    # ZL
    `02` = "Premium Receiver's Last or Organization Name",
    `03` = "Identification Code Qualifier",
    # 1 = D-U-N-S Number, Dun & Bradstreet,
    # 9 = D-U-N-S+4, D-U-N-S Number with Four Character Suffix,
    # 24 = Employer's Identification Number,
    # 75 = State or Province Assigned Number,
    # EQ = Insurance Company Assigned Identification Number,
    # FI = Federal Taxpayer's Identification Number,
    # PI = Payor Identification,
    # XV = Centers for Medicare and Medicaid Services PlanID
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
    `01` = "Contact Function Code",
    # IC = Information Contact
    `02` = "Contact Name",
    `03` = "Communication Number Qualifier",
    # EM = Electronic Mail,
    # EX = Telephone Extension,
    # FX = Facsimile,
    # TE = Telephone
    `04` = "Communication Number",
    `05` = "Communication Number Qualifier",
    `06` = "Communication Number",
    `07` = "Communication Number Qualifier",
    `08` = "Communication Number"
  ),
  # 2000B Loop Individual Remittance Loop
  ENT = list(
    `01` = "Assigned Number",
    `02` = "Entity Identifier Code",
    # 2J = Individual
    # 2L = Corporation
    # AG = Agent/Agency
    # NH = Association
    # RGA = Responsible Government Agency
    # UN = Union
    `03` = "Identification Code Qualifier",
    # 34 = Social Security Number,
    # EI = Employee Identification Number,
    # II = Standard Unique Health Identifier for each Individual in the United States
    `04` = "Identification Code"
  ),
  # 2100B Loop Individual Name Loop
  NM1 = list(
    `01` = "Entity Identifier Code",
    # DO = Dependent Name,
    # EY = Employee Name,
    # IL = Insured or Subscriber,
    # QE = Policyholder
    `02` = "Entity Type Qualifier",
    # 1 = Person
    `03` = "Individual Last Name",
    `04` = "Individual First Name",
    `05` = "Individual Middle Name",
    `06` = "Individual Name Prefix",
    `07` = "Individual Name Suffix",
    `08` = "Identification Code Qualifier",
    # 34 = Social Security Number,
    # C1 = Insured or Subscriber,
    # EI = Employee Identification Number,
    # N = Insured's Unique Identification Number
    `09` = "Identification Code"
  ),
  RMR = list(
    `01` = "Reference Identification Qualifier",
    # 11 = Account Number,
    # 9J = Pension Contract,
    # AP = Accounts Receivable Number,
    # AZ = Health Insurance Policy Number,
    # B7 = Life Insurance Policy Number,
    # CL = Seller's Credit Memo,
    # CM = Buyer's Credit Memo,
    # CT = Contract Number,
    # ID = Insurance Certificate Number,
    # IK = Invoice Number,
    # IV = Seller's Invoice Number,
    # KW = Certification,
    # PO = Purchase Order
    `02` = "Reference Identification Number",
    `03` = "Payment Action Code",
    # PA = Payment in Advance
    # PI = Pay Item
    # PO = Payment on Account
    # PP = Partial Payment
    `04` = "Detail Premium Payment Amount",
    `05` = "Billed Premium Amount"
  ),
  # Adjustment Segments (ADX): When the buyer takes a deduction, the ADX segment follows the related RMR
  ADX = list(
    `01` = "Adjustment Amount",
    `02` = "Adjustment Reason Code",
    # 01 = Pricing Error,
    # 02 = Quantity Contested,
    # 03 = Quality/damaged Goods,
    # 04 = Delivery Issue,
    # 05 = Early Payment Discount Taken,
    # 20 = Balance Due Declined,
    # 52 = Credit for Overpayment,
    # 53 = Remittance for Previous Underpayment,
    # 80 = Overpayment,
    # 81 = Credit as Agreed,
    # 86 = Duplicate Payment,
    # AA = Prepaid Benefit or Advances,
    # AX = Person No Longer Employed,
    # BJ = Insurance Charge,
    # H1 = Information Forthcoming,
    # H6 = Partial Payment Remitted,
    # IA = Invoice Amount Does Not Match Account Analysis Statement,
    # J3 = Promised Adjustment Not Received,
    # RU = Interest,
    # WO = Overpayment Recovery
  ),
  # Transaction Set Trailer
  SE = list(
    `01` = "Transaction Segment Count",
    `02` = "Transaction Set Control Number"
  ),
  # Functional Group Trailer
  GE = list(
    `01` = "Number of Transaction Sets Included",
    `02` = "Group Control Number"
  ),
  # Interchange Control Trailer
  IEA = list(
    `01` = "Number of Included Functional Groups",
    `02` = "Interchange Control Number"
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

#' @noRd
index_820 <- function(x) {
  ST <- perl(x, "^ST")
  SE <- perl(x, "^SE")
  ENT <- perl(x, "^ENT")
  NM1 <- perl(x, "^NM1") %0% 0L

  if (length(ENT) != length(NM1)) {
    emp <- cheapr::new_integer(length(ENT), seq_along(ENT))
    emp[grep("^NM1", x[ENT + 1L])] <- NM1
    NM1 <- unname(emp)
  }

  rlang::list2(
    header = fill_(perl(x, "ISA\\*"), ST),
    details = fill_(ST + 1L, ENT[1L] - 1L),
    entity = map_entity_index(ENT, SE, NM1),
    trailer = fill_(SE, perl(x, "^IEA"))
  )
}

#' @noRd
create_entity_index <- function(ENT, SE) {
  index <- sort.int(
    c(
      ENT[1L],
      ENT[-1] - 1L,
      ENT[-1],
      SE - 1L
    )
  )

  half <- vctrs::vec_size(index) / 2L
  runs <- vctrs::vec_rep_each(seq(half), rep(2L, half))

  purrr::map(
    vctrs::vec_split(index, runs)$val,
    \(x) fill_(start = x[1], end = x[2])
  )
}

#' @noRd
map_entity_index <- function(ENT, SE, NM1) {
  purrr::map2(
    create_entity_index(ENT, SE),
    as.list(NM1),
    function(x, nm) {
      if (!nm) {
        return(list(x[1], c(x[2:length(x)])))
      }
      # ni = nm + 1L
      list(x[1:2], c(x[3:length(x)]))
    }
  )
}
