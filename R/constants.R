#' CMS Risk Adjustment Domain Constants
#'
# References:
# - CMS Rate Announcement and Call Letter
# - Medicare Advantage Enrollment and Disenrollment Guidance
# - `X12-834` Implementation Guides
#
# - aged: beneficiaries currently eligible for Medicare by age
# - disabled: beneficiaries currently eligible for Medicare by disability

#' Dual Eligibility Codes
#'
#' @description
#' CMS Dual Eligibility Status Codes (Medicare + Medicaid)
#'
#' @details
#' Used in coefficient prefix selection.
#'
#' ### Full Benefit Dual Eligible:
#'    * Receive both Medicare and full Medicaid benefits
#'    * Uses "CFA_" or "CFD_" prefixes
#'
#' ### Partial Benefit Dual Eligible
#'    * Medicare + limited Medicaid
#'    * Uses "CPA_" or "CPD_" prefixes
#'
#' Dual-eligibles are often divided into "full-duals" and "partial-duals" based
#' on the level of Medicaid benefits they receive. CMS generally considers
#' beneficiaries to be full-duals if they have values of 02, 04, or 08, and to
#' be partial-duals if they have values of 01, 03, 05, or 06.
#'
#' Partial-duals are sometimes divided into the QMB-only population (01) and all
#' other partial-duals (03, 05, or 06).
#' @noRd
DUAL_CODES = list(
  ANY = c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10"),
  VALID = c("00", "01", "02", "03", "04", "05", "06", "08"),
  NON_DUAL = "00",
  FULL = c("02", "04", "08"),
  PARTIAL = c("01", "03", "05", "06"),
  DESCRIPTION = list(
    "00" = "Non-Beneficiary",
    "01" = "QMB Only",
    "02" = "QMB Plus (Qualified Medicare Beneficiary Plus)",
    "03" = "SLMB Only",
    "04" = "SLMB Plus (Specified Low-Income Medicare Beneficiary Plus)",
    "05" = "QDWI (Qualified Disabled and Working Individual)",
    "06" = "QI (Medicare - Qualifying Individual)",
    "08" = "Other Full Benefit Dual Eligible",
    "09" = "Medicare without Medicaid Coverage",
    "10" = "Separate CHIP Eligible Medicare"
  )
)

#' California DHCS Medi-Cal Aid Codes
#' Maps California-specific aid codes to CMS dual eligibility codes
#' Source: California DHCS `834` Implementation Guide
#' @noRd
MEDI_CAL_AID_CODES = list(
  # Full Benefit Dual (QMB Plus, SLMB Plus)
  "4N" = "02", # QMB Plus - Aged
  "4P" = "02", # QMB Plus - Disabled
  "5B" = "04", # SLMB Plus - Aged
  "5D" = "04", # SLMB Plus - Disabled

  # Partial Benefit Dual (QMB Only, SLMB Only, QI)
  "4M" = "01", # QMB Only - Aged
  "4O" = "01", # QMB Only - Disabled
  "5A" = "03", # SLMB Only - Aged
  "5C" = "03", # SLMB Only - Disabled
  "5E" = "06", # QI - Aged
  "5F" = "06" # QI - Disabled
)

#' Medicare Status Code Mappings
#' Maps Medicare status codes (from various sources) to CMS dual eligibility
#' codes. Used in X12-834 `REF*ABB` segment and other payer files.
#' @noRd
MEDICARE_STATUS_CODE_MAPPING = list(
  "QMB" = "01", # QMB Only (Partial)
  "QMBONLY" = "01",
  "QMBPLUS" = "02", # QMB Plus (Full Benefit)
  "QMB+" = "02",
  "SLMB" = "03", # SLMB Only (Partial)
  "SLMBONLY" = "03",
  "SLMBPLUS" = "04", # SLMB Plus (Full Benefit)
  "SLMB+" = "04",
  "QDWI" = "05", # Qualified Disabled and Working Individual
  "QI" = "06", # Qualifying Individual
  "QI1" = "06",
  "FBDE" = "08", # Full Benefit Dual Eligible (Other)
  "OTHERFULL" = "08"
)

#' OREC/CREC Codes
#'
#' @description
#' CMS Reason for Entitlement Codes
#'
#' @details
#' Determines if beneficiary has ESRD.
#' Affects coefficient prefix selection.
#'
#' ### OREC
#' Original Reason for Entitlement Code
#'
#' ### CREC
#' Current Reason for Entitlement Code.
#' May differ from OREC.
#' @noRd
REC_CODES = list(
  VALID = c("0", "1", "2", "3"),
  ESRD = c("2", "3"),
  DESCRIPTION = list(
    "0" = "Old Age and Survivors Insurance (OASI)",
    "1" = "Disability Insurance Benefits (DIB)",
    "2" = "ESRD - End-Stage Renal Disease",
    "3" = "DIB and ESRD"
  )
)

#' COEFFICIENT PREFIX GROUPS
#' Used for prefix_override logic in model_demographics
#' @noRd
PREFIX = list(
  ESRD = c("DI_", "DNE_", "GI_", "GNE_", "GFPA_", "GFPN_", "GNPA_", "GNPN_"),
  NEW_ENROLLEE = c("NE_", "SNPNE_", "DNE_", "GNE_"),
  COMMUNITY = c("CNA_", "CND_", "CFA_", "CFD_", "CPA_", "CPD_"),
  INSTITUTIONAL = c("INS_", "GI_"),
  DUAL_FULL = c("CFA_", "CFD_", "GFPA_", "GFPN_"),
  DUAL_PARTIAL = c("CPA_", "CPD_"),
  DUAL_NON = c("CNA_", "CND_", "GNPA_", "GNPN_"),
  DESCRIPTION = list(
    "CNA_" = "Community, Non-Dual, Aged",
    "CND_" = "Community, Non-Dual, Disabled",
    "CFA_" = "Community, Full Benefit Dual, Aged",
    "CFD_" = "Community, Full Benefit Dual, Disabled",
    "CPA_" = "Community, Partial Benefit Dual, Aged",
    "CPD_" = "Community, Partial Benefit Dual, Disabled",
    "INS_" = "Long-Term Institutionalized",
    "NE_" = "New Enrollee",
    "SNPNE_" = "Special Needs Plan New Enrollee",
    "DI_" = "Dialysis",
    "DNE_" = "Dialysis New Enrollee",
    "GI_" = "Graft, Institutionalized",
    "GNE_" = "Graft, New Enrollee",
    "GFPA_" = "Graft, Full Benefit Dual, Aged",
    "GFPN_" = "Graft, Full Benefit Dual, Non-Aged",
    "GNPA_" = "Graft, Non-Dual, Aged",
    "GNPN_" = "Graft, Non-Dual, Non-Aged",
    "TRANSPLANT_KIDNEY_ONLY_1M" = "1 month post-transplant",
    "TRANSPLANT_KIDNEY_ONLY_2M" = "2 months post-transplant",
    "TRANSPLANT_KIDNEY_ONLY_3M" = "3 months post-transplant",
    "Rx_CE_LowAged_" = "Community Enrollee, Low Income, Aged",
    "Rx_CE_LowNoAged_" = "Community Enrollee, Low Income, Non-Aged",
    "Rx_CE_NoLowAged_" = "Community Enrollee, Not Low Income, Aged",
    "Rx_CE_NoLowNoAged_" = "Community Enrollee, Not Low Income, Non-Aged",
    "Rx_CE_LTI_" = "Community Enrollee, Long-Term Institutionalized",
    "Rx_NE_Lo_" = "New Enrollee, Low Income",
    "Rx_NE_NoLo_" = "New Enrollee, Not Low Income",
    "Rx_NE_LTI_" = "New Enrollee, Long-Term Institutionalized"
  )
)

#' DEMOGRAPHIC CODES
#' X12-834 Gender Code mappings (V6)
#' @noRd
SEX = list(
  VALID = c("M", "F", "1", "2"),
  MALE = c("M", "1"),
  FEMALE = c("F", "2"),
  V2 = c(
    "M" = "1",
    "F" = "2",
    "1" = "1",
    "2" = "2"
  ),
  V6 = c(
    "M" = "M",
    "F" = "F",
    "1" = "M",
    "2" = "F"
  )
)

#' X12 834 MAINTENANCE TYPE CODES (INS-03)
#' @noRd
MAINTENANCE = list(
  CHANGE = "001",
  ADD = "021",
  CANCEL = "024",
  REINSTATE = "025",
  DESCRIPTION = list(
    "001" = "Change",
    "021" = "Addition",
    "024" = "Cancellation/Termination",
    "025" = "Reinstatement"
  )
)

#' @noRd
MODEL = list(
  "CMS-HCC Model V22",
  "CMS-HCC Model V24",
  "CMS-HCC Model V28",
  "CMS-HCC ESRD Model V21",
  "CMS-HCC ESRD Model V24",
  "RxHCC Model V08",
  "RxHCC Model V08 PDP_AND_MAPD",
  "RxHCC Model V08 PDP_ONLY",
  "RxHCC Model V08 MAPD_ONLY"
)

#' @noRd
AGES = list(
  V6 = list(
    RANGE = ivs::iv_pairs(
      c(0, 1),
      c(1, 2),
      c(2, 5),
      c(5, 10),
      c(10, 15),
      c(15, 21),
      c(21, 25),
      c(25, 30),
      c(30, 35),
      c(35, 40),
      c(40, 45),
      c(45, 50),
      c(50, 55),
      c(55, 60),
      c(60, Inf)
    ),
    LABEL = c(
      "0_0",
      "1_1",
      "2_4",
      "5_9",
      "10_14",
      "15_20",
      "21_24",
      "25_29",
      "30_34",
      "35_39",
      "40_44",
      "45_49",
      "50_54",
      "55_59",
      "60_GT"
    )
  ),
  ESRD = list(
    RANGE = ivs::iv_pairs(
      c(0, 35),
      c(35, 45),
      c(45, 55),
      c(55, 60),
      c(60, 65),
      c(65, 70),
      c(70, 75),
      c(75, 80),
      c(80, 85),
      c(85, 90),
      c(90, 95),
      c(95, Inf)
    ),
    LABEL = c(
      "0_34",
      "35_44",
      "45_54",
      "55_59",
      "60_64",
      "65_69",
      "70_74",
      "75_79",
      "80_84",
      "85_89",
      "90_94",
      "95_GT"
    )
  )
)

#' @noRd
LANG = list(
  SPA = "Spanish",
  ENG = "English",
  CHI = "Chinese",
  VIE = "Vietnamese",
  KOR = "Korean",
  TAG = "Tagalog",
  ARM = "Armenian",
  FAR = "Farsi",
  ARA = "Arabic",
  RUS = "Russian",
  JPN = "Japanese",
  HIN = "Hindi",
  CAM = "Cambodian",
  HMO = "Hmong",
  LAO = "Lao",
  THA = "Thai"
)

#' @noRd
KEYWORDS = list(
  MEDICARE = c(
    "MEDICARE",
    "MA",
    "PART A",
    "PART B",
    "PART C",
    "PART D",
    "MEDICARE ADVANTAGE",
    "MA-PD"
  ),
  MEDICAID = c("MEDICAID", "MEDI-CAL", "MEDI CAL", "MEDIC-AID", "LTC"),
  SNP = c("SNP", "SPECIAL NEEDS", "D-SNP", "DSNP", "DUAL ELIGIBLE SNP"),
  LTI = c(
    "LTC",
    "LONG TERM CARE",
    "LONG-TERM CARE",
    "NURSING HOME",
    "SKILLED NURSING",
    "SNF",
    "INSTITUTIONALIZED"
  )
)
