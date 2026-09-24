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
  text <- check_text_(text)
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
  # N1_REX <- r"(N1\*(Z6|0B|04|8W|AK|BE|BK|C1|C2|IAT|MJ|RB|Z6|ZB|ZL))"

  list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    BPR = perl(x, "^BPR"),
    TRN = perl(x, "^TRN"),
    CUR = perl(x, "^CUR"),
    REF14 = perl(x, r"(REF\*14)"),
    N1PE = perl(x, r"(N1\*PE)"),
    N3PE = perl(x, r"(N1\*PE)") + 1L,
    N4PE = perl(x, r"(N1\*PE)") + 2L,
    N1PR = perl(x, r"(N1\*PR)"),
    N3PR = perl(x, r"(N1\*PR)") + 1L,
    N4PR = perl(x, r"(N1\*PR)") + 2L,
    PERIC = perl(x, r"(PER\*IC)"),
    # N1__ = perl(x, N1_REX),
    ENT = perl(x, "^ENT"),
    NM1 = perl(x, r"(NM1\*(DO|EY|IL|QE))"),
    RMR = perl(x, "^RMR"),
    REF18 = perl(x, r"(^REF\*18)"),
    REF38 = perl(x, r"(REF\*38)"),
    REFTV = perl(x, r"(REF\*TV)"),
    REF1L = perl(x, r"(REF\*1L)"),
    REFABY = perl(x, r"(REF\*ABY)"),
    REFZZ = perl(x, r"(^REF\*ZZ)"),
    DTM582 = perl(x, r"(^DTM\*582)"),
    DTM009 = perl(x, r"(^DTM\*009)"),
    DTM035 = perl(x, r"(^DTM\*035)"),
    DTMAAG = perl(x, r"(^DTM\*AAG)"),
    DTM097 = perl(x, r"(^DTM\*097)"),
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
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    BPR = perl(x, "^BPR"),
    TRN = perl(x, "^TRN"),
    REFTV = perl(x, r"(REF\*TV)"),
    REF18 = perl(x, r"(^REF\*18)"),
    REFZZ = perl(x, r"(REF\*ZZ)"),
    N1PE = perl(x, r"(N1\*PE)"),
    REFABY = perl(x, r"(REF\*ABY)"),
    N1RM = perl(x, r"(N1\*RM)"),
    PERIC = perl(x, r"(PER\*IC)"),
    ENT = perl(x, "^ENT"),
    NM1 = perl(x, "^NM1"),
    REF38 = perl(x, r"(REF\*38)"),
    REFPOL = perl(x, r"(REF\*POL)"),
    REF1L = perl(x, r"(REF\*1L)"),
    REFAZ = perl(x, r"(REF\*AZ)"),
    REF4A = perl(x, r"(REF\*4A)"),
    REF23 = perl(x, r"(REF\*23)"),
    REF60 = perl(x, r"(REF\*60)"),
    REF1W = perl(x, r"(REF\*1W)"),
    REF0F = perl(x, r"(REF\*0F)"),
    RMR = perl(x, "^RMR"),
    DTM582 = perl(x, r"(^DTM\*582)"),
    REF0N = perl(x, r"(REF\*0N)"),
    SE = perl(x, "^SE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )
}

#' @rdname parse_834
#' @export
index_834 <- function(text) {
  text <- check_text_(text)
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
    REF38 = perl(x, r"(^REF\*38)"),
    REF0F = perl(x, r"(^REF\*0F)"),
    REF1D = perl(x, r"(^REF\*1D)"),
    REF1L = perl(x, r"(^REF\*1L)"),
    REF17 = perl(x, r"(^REF\*17)"),
    REF23 = perl(x, r"(^REF\*23)"),
    REF3H = perl(x, r"(^REF\*3H)"),
    REF6O = perl(x, r"(^REF\*6O)"),
    REF6P = perl(x, r"(^REF\*6P)"),
    REFQ4 = perl(x, r"(^REF\*Q4)"),
    REFZZ = perl(x, r"(^REF\*ZZ)"),
    REFZX = perl(x, r"(^REF\*ZX)"),
    REFCE = perl(x, r"(^REF\*CE)"),
    REFRB = perl(x, r"(^REF\*RB)"),
    REFDX = perl(x, r"(^REF\*DX)"),
    REFF6 = perl(x, r"(^REF\*F6)"),
    REFQQ = perl(x, r"(^REF\*QQ)"),
    REFAB = perl(x, r"(^REF\*AB\*)"),
    REFABB = perl(x, r"(^REF\*ABB)"),
    REF9V = perl(x, r"(^REF\*9V)"),
    DTP007 = perl(x, r"(^DTP\*007)"),
    DTP303 = perl(x, r"(^DTP\*303)"),
    DTP348 = perl(x, r"(^DTP\*348)"),
    DTP349 = perl(x, r"(^DTP\*349)"),
    DTP351 = perl(x, r"(^DTP\*351)"),
    DTP356 = perl(x, r"(^DTP\*356)"),
    DTP357 = perl(x, r"(^DTP\*357)"),
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
  text <- check_text_(text)
  xtype <- x12_type(text)

  if (xtype %!in_% c("837I-X223", "837P-X222") || cheapr::is_na(xtype)) {
    return(NA)
  }

  x <- tilde(text)

  i <- switch(
    xtype,
    `837I-X223` = index_837I_x223(x),
    `837P-X222` = index_837P_x222(x)
  )

  new_x12_index(i, x, text, xtype)
}

#' @noRd
index_837I_x223 <- function(x) {
  list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    BHT = perl(x, "^BHT"),
    NM140 = perl(x, r"(^NM1\*40)"),
    NM141 = perl(x, r"(^NM1\*41)"),
    NM171 = perl(x, r"(^NM1\*71)"),
    NM185 = perl(x, r"(^NM1\*85)"),
    NM1IL = perl(x, r"(^NM1\*IL)"),
    NM1PR = perl(x, r"(^NM1\*PR)"),
    NM1QC = perl(x, r"(^NM1\*QC)"),
    PERIC = perl(x, r"(^PER\*IC)"),
    HL = perl(x, "^HL"),
    N3 = perl(x, "^N3"),
    N4 = perl(x, "^N4"),
    REF1G = perl(x, r"(^REF\*1G)"),
    REF2U = perl(x, r"(^REF\*2U)"),
    REF6R = perl(x, r"(^REF\*6R)"),
    REF9A = perl(x, r"(^REF\*9A)"),
    REFD9 = perl(x, r"(^REF\*D9)"),
    REFEI = perl(x, r"(^REF\*EI)"),
    REFG2 = perl(x, r"(^REF\*G2)"),
    REFLU = perl(x, r"(^REF\*LU)"),
    REFY4 = perl(x, r"(^REF\*Y4)"),
    SBRP = perl(x, r"(^SBR\*P\*)"),
    SBRS = perl(x, r"(^SBR\*S\*)"),
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
    DMH = perl(x, "^DMH"),
    CAS = perl(x, "^CAS"),
    OI = perl(x, "^OI"),
    MOA = perl(x, "^MOA"),
    MEA = perl(x, "^MEA"),
    CLM = perl(x, "^CLM"),
    HIABJ = perl(x, r"(^HI\*ABJ)"),
    HIABK = perl(x, r"(^HI\*ABK)"),
    HIBE = perl(x, r"(^HI\*BE)"),
    HIBF = perl(x, r"(^HI\*BF)"),
    HIBG = perl(x, r"(^HI\*BG)"),
    HIBH = perl(x, r"(^HI\*BH)"),
    HIBK = perl(x, r"(^HI\*BK)"),
    HIBN = perl(x, r"(^HI\*BN)"),
    HIPR = perl(x, r"(^HI\*PR)"),
    PRVBI = perl(x, r"(^PRV\*BI)"),
    PRVAT = perl(x, r"(^PRV\*AT)"),
    LX = perl(x, "^LX"),
    SV1 = perl(x, "^SV1"),
    SV2 = perl(x, "^SV2"),
    SV5 = perl(x, "^SV5"),
    DTP096 = perl(x, r"(^DTP\*096)"),
    DTP434 = perl(x, r"(^DTP\*434)"),
    DTP435 = perl(x, r"(^DTP\*435)"),
    DTP472 = perl(x, r"(^DTP\*472)"),
    DTP523 = perl(x, r"(^DTP\*523)"),
    CR8 = perl(x, r"(^CR8)"),
    CL1 = perl(x, "^CL1"),
    NTE = perl(x, "^NTE"),
    CTP = perl(x, "^CTP"),
    LIN = perl(x, "^LIN"),
    LU = perl(x, "^LU"),
    LQ = perl(x, "^LQ"),
    FRM = perl(x, "^FRM"),
    QTY = perl(x, "^QTY"),
    SE = perl(x, "^SE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )
}

#' @noRd
index_837P_x222 <- function(x) {
  list(
    ISA = perl(x, "^ISA"),
    GS = perl(x, "^GS"),
    ST = perl(x, "^ST"),
    HCP = perl(x, "^HCP"),
    AMT = perl(x, "^AMT"),
    OI = perl(x, "^OI"),
    CAS = perl(x, "^CAS"),
    CR1 = perl(x, "^CR1"),
    CRC = perl(x, "^CRC"),
    QTYPT = perl(x, r"(^QTY\*PT)"),
    CR2 = perl(x, "^CR2"),
    PAT = perl(x, "^PAT"),
    PWK = perl(x, "^PWK"),
    CR3 = perl(x, "^CR3"),
    LQUT = perl(x, r"(^LQ\*UT)"),
    FRM = perl(x, "^FRM"),
    MEA = perl(x, "^MEA"),
    NTE = perl(x, "^NTE"),
    DMG = perl(x, "^DMG"),
    PRVBI = perl(x, r"(^PRV\*BI)"),
    PRVPE = perl(x, r"(^PRV\*PE)"),
    LIN = perl(x, "^LIN"),
    CTP = perl(x, "^CTP"),
    N3 = perl(x, "^N3"),
    N4 = perl(x, "^N4"),
    BHT = perl(x, "^BHT"),
    CLM = perl(x, "^CLM"),
    PERIC = perl(x, r"(^PER\*IC)"),
    HL = perl(x, "^HL"),
    LX = perl(x, "^LX"),
    SV1 = perl(x, "^SV1"),
    SVD = perl(x, "^SVD"),
    SBRP = perl(x, r"(^SBR\*P\*)"),
    SBRS = perl(x, r"(^SBR\*S\*)"),
    HIABK = perl(x, r"(^HI\*ABK)"),
    HIBK = perl(x, r"(^HI\*BK)"),
    NM140 = perl(x, r"(^NM1\*40)"),
    NM141 = perl(x, r"(^NM1\*41)"),
    NM145 = perl(x, r"(^NM1\*45)"),
    NM177 = perl(x, r"(^NM1\*77)"),
    NM182 = perl(x, r"(^NM1\*82)"),
    NM185 = perl(x, r"(^NM1\*85)"),
    NM187 = perl(x, r"(^NM1\*87)"),
    NM1DN = perl(x, r"(^NM1\*DN)"),
    NM1DK = perl(x, r"(^NM1\*DK)"),
    NM1IL = perl(x, r"(^NM1\*IL)"),
    NM1PR = perl(x, r"(^NM1\*PR)"),
    NM1PW = perl(x, r"(^NM1\*PW)"),
    NM1QC = perl(x, r"(^NM1\*QC)"),
    REF1G = perl(x, r"(^REF\*1G)"),
    REF6R = perl(x, r"(^REF\*6R)"),
    REF9A = perl(x, r"(^REF\*9A)"),
    REFD9 = perl(x, r"(^REF\*D9)"),
    REFEI = perl(x, r"(^REF\*EI)"),
    REFG2 = perl(x, r"(^REF\*G2)"),
    DTP096 = perl(x, r"(^DTP\*096)"),
    DTP431 = perl(x, r"(^DTP\*431)"),
    DTP434 = perl(x, r"(^DTP\*434)"),
    DTP435 = perl(x, r"(^DTP\*435)"),
    DTP439 = perl(x, r"(^DTP\*439)"),
    DTP453 = perl(x, r"(^DTP\*453)"),
    DTP454 = perl(x, r"(^DTP\*454)"),
    DTP455 = perl(x, r"(^DTP\*455)"),
    DTP461 = perl(x, r"(^DTP\*461)"),
    DTP463 = perl(x, r"(^DTP\*463)"),
    DTP472 = perl(x, r"(^DTP\*472)"),
    DTP573 = perl(x, r"(^DTP\*573)"),
    DTP607 = perl(x, r"(^DTP\*607)"),
    SE = perl(x, "^SE"),
    GE = perl(x, "^GE"),
    IEA = perl(x, "^IEA")
  )
}
