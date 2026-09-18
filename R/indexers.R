#' @noRd
X12Header := S7::new_class(
  properties = list(
    ISA = S7::class_integer,
    GS = S7::class_integer,
    ST = S7::class_integer
  )
)

#' @noRd
X218Header := S7::new_class(
  parent = X12Header,
  properties = list(
    BPR = S7::class_integer,
    TRN = S7::class_integer,
    REF14 = S7::class_integer,
    N1PE = S7::class_integer,
    N3PE = S7::class_integer,
    N4PE = S7::class_integer,
    N1PR = S7::class_integer,
    N3PR = S7::class_integer,
    N4PR = S7::class_integer
  )
)

#' @noRd
X12Trailer := S7::new_class(
  properties = list(
    SE = S7::class_integer,
    GE = S7::class_integer,
    IEA = S7::class_integer
  )
)

#' 2300B Remittance Detail Loop
#' 2000B Per-Member Entity Loop

#' @noRd
I820_X218 := S7::new_class(
  properties = list(
    Header = X218Header,
    ENT = S7::class_integer,
    NM1 = S7::class_integer,
    RMR = S7::class_integer,
    REF18 = S7::class_integer,
    REFZZ = S7::class_integer,
    DTM = S7::class_integer,
    ADX = S7::class_integer,
    Trailer = X12Trailer
  )
)

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
  # N1_TST <- paste0("N1*", c("Z6", "0B", "04", "8W", "AK", "BE", "BK", "C1", "C2", "IAT", "MJ", "RB", "Z6", "ZB", "ZL"))
  # perl(N1_TST, N1_REX)
  N1_REX <- r"(N1\*(Z6|0B|04|8W|AK|BE|BK|C1|C2|IAT|MJ|RB|Z6|ZB|ZL))"

  list(
    ISA = perl(x, "^ISA"), # r
    GS = perl(x, "^GS"), # r
    ST = perl(x, "^ST"), # r
    BPR = perl(x, "^BPR"), # r
    TRN = perl(x, "^TRN"), # r
    CUR = perl(x, "^CUR"), # o
    REF_14 = perl(x, r"(REF\*14)"),
    N1_PE = perl(x, r"(N1\*PE)"),
    N3_PE = perl(x, r"(N1\*PE)") + 1L,
    N4_PE = perl(x, r"(N1\*PE)") + 2L,
    N1_PR = perl(x, r"(N1\*PR)"),
    N3_PR = perl(x, r"(N1\*PR)") + 1L,
    N4_PR = perl(x, r"(N1\*PR)") + 2L,
    PER_IC = perl(x, r"(PER\*IC)"),
    N1__ = perl(x, N1_REX),
    # N3_ = perl(x, N1_REX) + 1L,
    # N4_ = perl(x, N1_REX) + 2L,
    ENT = perl(x, "^ENT"),
    NM1 = perl(x, r"(NM1\*(DO|EY|IL|QE))"),
    RMR = perl(x, "^RMR"),
    REF_18 = perl(x, r"(^REF\*18)"),
    REF_38 = perl(x, r"(REF\*38)"),
    REF_TV = perl(x, r"(REF\*TV)"),
    REF_1L = perl(x, r"(REF\*1L)"),
    REF_ABY = perl(x, r"(REF\*ABY)"),
    REF_ZZ = perl(x, r"(^REF\*ZZ)"),
    DTM_582 = perl(x, r"(^DTM\*582)"),
    DTM_009 = perl(x, r"(^DTM\*009)"),
    DTM_035 = perl(x, r"(^DTM\*035)"),
    DTM_AAG = perl(x, r"(^DTM\*AAG)"),
    DTM_097 = perl(x, r"(^DTM\*097)"),
    ADX = perl(x, "^ADX"),
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

#' @rdname parse_834
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
    REF_38 = perl(x, r"(REF\*38)"),
    REF_0F = perl(x, r"(REF\*0F)"),
    REF_1D = perl(x, r"(REF\*1D)"),
    REF_1L = perl(x, r"(REF\*1L)"),
    REF_17 = perl(x, r"(REF\*17)"),
    REF_23 = perl(x, r"(REF\*23)"),
    REF_3H = perl(x, r"(REF\*3H)"),
    REF_6O = perl(x, r"(REF\*6O)"),
    REF_6P = perl(x, r"(REF\*6P)"),
    REF_Q4 = perl(x, r"(REF\*Q4)"),
    REF_ZZ = perl(x, r"(REF\*ZZ)"),
    REF_ZX = perl(x, r"(REF\*ZX)"),
    REF_CE = perl(x, r"(REF\*CE)"),
    REF_RB = perl(x, r"(REF\*RB)"),
    REF_DX = perl(x, r"(REF\*DX)"),
    REF_F6 = perl(x, r"(REF\*F6)"),
    REF_QQ = perl(x, r"(REF\*QQ)"),
    REF_AB = perl(x, r"(REF\*AB\*)"),
    REF_ABB = perl(x, r"(REF\*ABB)"),
    REF_9V = perl(x, r"(REF\*(9V))"),
    DTP_007 = perl(x, r"(DTP\*007)"),
    DTP_303 = perl(x, r"(DTP\*303)"),
    DTP_348 = perl(x, r"(DTP\*348)"),
    DTP_349 = perl(x, r"(DTP\*349)"),
    DTP_351 = perl(x, r"(DTP\*351)"),
    DTP_356 = perl(x, r"(DTP\*356)"),
    DTP_357 = perl(x, r"(DTP\*357)"),
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
