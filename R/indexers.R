# purrr::map(hcc::x12_820, index_820)
#' @rdname parse_820
#' @export
index_820 <- function(text) {
  if (length(text) > 1L || is.list(text)) {
    text <- paste0(unlist_(text), collapse = "")
  }

  xtype <- x12_type(text)

  if (xtype %!in_% c("820-X306", "820-X218") || cheapr::is_na(xtype)) {
    return(NA)
  }

  x <- tilde(text)

  i <- switch(
    xtype,
    `820-X306` = index_820_x306(x),
    `820-X218` = index_820_x218(x)
  )

  new_x12_index(i, x, text, xtype = paste0("X12-", xtype))
}

# ST-01 = 820
# ST-03 = 005010X218
# GS-08 = 005010X218
# https://portal.stedi.com/app/guides/view/hipaa/payroll-deducted-and-other-group-premium-payment-for-insurance-products-examples-x218/01GRYB6CPB1S1257NJJP6K497B
#' @noRd
index_820_x218 <- function(x) {
  N1_REX <- r"(N1\*(Z6|0B|04|8W|AK|BE|BK|C1|C2|IAT|MJ|RB|Z6|ZB|ZL))"

  list(
    ISA = perl(x, "^ISA"), # r
    GS = perl(x, "^GS"), # r
    ST = perl(x, "^ST"), # r
    BPR = perl(x, "^BPR"), # r
    TRN = perl(x, "^TRN"), # r
    CUR = perl(x, "^CUR"), # o
    REF_14 = perl(x, r"(REF\*14)"),
    DTM_009 = perl(x, r"(^DTM\*009)"), # o
    DTM_035 = perl(x, r"(^DTM\*035)"), # o
    DTM_AAG = perl(x, r"(^DTM\*AAG)"), # o
    DTM_097 = perl(x, r"(^DTM\*097)"), # r
    N1_PE = perl(x, r"(N1\*PE)"), # r
    N3_PE = perl(x, r"(N1\*PE)") + 1L, # o
    N4_PE = perl(x, r"(N1\*PE)") + 2L, # o
    N1_PR = perl(x, r"(N1\*PR)"), # r
    N3_PR = perl(x, r"(N1\*PR)") + 1L, # o
    N4_PR = perl(x, r"(N1\*PR)") + 2L, # o
    PER_IC = perl(x, r"(PER\*IC)"), # o
    N1_ = perl(x, N1_REX), # r
    N3_ = perl(x, N1_REX) + 1L, # r
    N4_ = perl(x, N1_REX) + 2L, # r
    ENT = perl(x, "^ENT"),
    NM1_ = perl(x, r"(NM1\*(DO|EY|IL|QE))"),
    RMR = perl(x, "^RMR"),
    REF_18 = perl(x, r"(^REF\*18)"), # o
    REF_38 = perl(x, r"(REF\*38)"), # o
    REF_TV = perl(x, r"(REF\*TV)"), # o
    REF_1L = perl(x, r"(REF\*1L)"), # o
    REF_ABY = perl(x, r"(REF\*ABY)"), # o
    REF_ZZ = perl(x, r"(^REF\*ZZ)"),
    DTM_582 = perl(x, r"(^DTM\*582)"), # o
    ADX = perl(x, "^ADX"),
    # DTM = perl(x, "^DTM"),
    SE = perl(x, "^SE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )
}

# ST-01 = 820
# ST-03 = 005010X306
# GS-08 = 005010X306
# https://portal.stedi.com/app/guides/view/hipaa/health-insurance-exchange-related-payments-x306/01HQ4HZB22GES43ZEA8H62Y77C
#' @noRd
index_820_x306 <- function(x) {
  list(
    ISA = perl(x, "^ISA"), # r
    GS = perl(x, "^GS"), # r
    ST = perl(x, "^ST"), # r
    BPR = perl(x, "^BPR"), # r
    TRN = perl(x, "^TRN"), # r
    REF_TV = perl(x, r"(REF\*TV)"), # o
    REF_18 = perl(x, r"(^REF\*18)"), # o
    REF_ZZ = perl(x, r"(REF\*ZZ)"), # o
    N1_PE = perl(x, r"(N1\*PE)"), # r
    REF_ABY = perl(x, r"(REF\*ABY)"), # o
    N1_RM = perl(x, r"(N1\*RM)"), # r
    PER_IC = perl(x, r"(PER\*IC)"), # o
    ENT = perl(x, "^ENT"), # r
    NM1 = perl(x, "^NM1"), # r
    REF_38 = perl(x, r"(REF\*38)"), # o
    REF_POL = perl(x, r"(REF\*POL)"), # r
    REF_1L = perl(x, r"(REF\*1L)"), # o
    REF_AZ = perl(x, r"(REF\*AZ)"), # o
    REF_4A = perl(x, r"(REF\*4A)"), # o
    REF_23 = perl(x, r"(REF\*23)"), # o
    REF_60 = perl(x, r"(REF\*60)"), # o
    REF_1W = perl(x, r"(REF\*1W)"), # o
    REF_0F = perl(x, r"(REF\*0F)"), # o
    RMR = perl(x, "^RMR"), # r
    DTM_582 = perl(x, r"(^DTM\*582)"), # r
    REF_0N = perl(x, r"(REF\*0N)"), # o
    SE = perl(x, "^SE"), # r
    GE = perl(x, "^GE"), # r
    IEA = perl(x, "^IEA") # r
  )
}

#' @rdname parse_834_index
#' @export
index_834 <- function(text) {
  if (length(text) > 1L || is.list(text)) {
    text <- paste0(unlist_(text), collapse = "")
  }

  xtype <- x12_type(text)

  if (xtype != "834-X220" || cheapr::is_na(xtype)) {
    return(NA)
  }

  x <- tilde(text)

  i <- list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    BGN = perl(x, "^BGN"),
    QTY = perl(x, "^QTY"),
    REF = perl(x, "^REF"),
    DTP = perl(x, "^DTP"),
    N1 = perl(x, "^N1"),
    ACT = perl(x, "^ACT"),
    INS = perl(x, "^INS"),
    NM1 = perl(x, "^NM1"),
    PER = perl(x, "^PER"),
    N3 = perl(x, "^N3"),
    N4 = perl(x, "^N4"),
    DMG = perl(x, "^DMG"),
    EC = perl(x, "^EC"),
    ICM = perl(x, "^ICM"),
    AMT = perl(x, "^AMT"),
    HLH = perl(x, "^HLH"),
    LUI = perl(x, "^LUI"),
    DSB = perl(x, "^DSB"),
    IDC = perl(x, "^IDC"),
    PLA = perl(x, "^PLA"),
    COB = perl(x, "^COB"),
    LS = perl(x, "^LS"),
    LX = perl(x, "^LX"),
    LE = perl(x, "^LE"),
    HD = perl(x, "^HD"),
    SE = perl(x, "^SE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )

  new_x12_index(i, x, text, xtype)
}

#' @rdname parse_837
#' @export
index_837 <- function(text) {
  if (length(text) > 1L || is.list(text)) {
    text <- paste0(unlist_(text), collapse = "")
  }

  xtype <- x12_type(text)

  if (xtype %!in_% c("837I-X223", "837P-X222") || cheapr::is_na(xtype)) {
    return(NA)
  }

  x <- tilde(text)

  i <- list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    BPR = perl(x, "^BHT"),
    NM1 = perl(x, "^NM1"),
    PER = perl(x, "^PER"),
    HL = perl(x, "^HL"),
    N3 = perl(x, "^N3"),
    N4 = perl(x, "^N4"),
    REF = perl(x, "^REF"),
    SBR = perl(x, "^SBR"),
    PAT = perl(x, "^PAT"),
    PWK = perl(x, "^PWK"),
    AMT = perl(x, "^AMT"),
    CN1 = perl(x, "^CN1"),
    K3 = perl(x, "^K3"),
    NTE = perl(x, "^NTE"),
    CR1 = perl(x, "^CR1"),
    CR2 = perl(x, "^CR2"),
    CR3 = perl(x, "^CR3"),
    CRC = perl(x, "^CRC"),
    HCP = perl(x, "^HCP"),
    DMG = perl(x, "^DMG"),
    CAS = perl(x, "^CAS"),
    OI = perl(x, "^OI"),
    MOA = perl(x, "^MOA"),
    MEA = perl(x, "^MEA"),
    CLM = perl(x, "^CLM"),
    HI = perl(x, "^HI"),
    PRV = perl(x, "^PRV"),
    LX = perl(x, "^LX"),
    SV1 = perl(x, "^SV1"), # 837P (2400 Loop)
    SV2 = perl(x, "^SV2"), # 837I (2400 Loop)
    SV5 = perl(x, "^SV5"), # 837I (2400 Loop)
    DTP = perl(x, "^DTP"),
    SE = perl(x, "^SE"),
    NTE = perl(x, "^NTE"),
    CTP = perl(x, "^CTP"),
    LIN = perl(x, "^LIN"), # 837I (2410 Loop)
    LQ = perl(x, "^LQ"), # 837P (2440 Loop)
    FRM = perl(x, "^FRM"), # 837P (2440 Loop)
    QTY = perl(x, "^QTY"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )

  new_x12_index(i, x, text, xtype)
}
