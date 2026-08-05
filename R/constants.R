# CMS Risk Adjustment Domain Constants
#
# This module contains constants used across the HCC risk adjustment system,
# including dual eligibility codes, OREC/CREC values, and state-specific mappings.
#
# References:
# - CMS Rate Announcement and Call Letter
# - Medicare Advantage Enrollment and Disenrollment Guidance
# - X12 834 Implementation Guides

# =============================================================================
# DUAL ELIGIBILITY CODES
# =============================================================================

#' CMS Dual Eligibility Status Codes (Medicare + Medicaid)
#' Used in coefficient prefix selection (CNA_, CFA_, CPA_, etc.)
#' @noRd
VALID_DUAL_CODES = c("00", "01", "02", "03", "04", "05", "06", "08")

#' Non-Dual Eligible
#' @noRd
NON_DUAL_CODE = "00"

#' Full Benefit Dual Eligible (receive both Medicare and full Medicaid benefits)
#' Uses CFA_ (Community, Full Benefit Dual, Aged) or CFD_ (Disabled) prefixes
#' @noRd
FULL_BENEFIT_DUAL_CODES = c(
  "02", # QMB Plus (Qualified Medicare Beneficiary Plus)
  "04", # SLMB Plus (Specified Low-Income Medicare Beneficiary Plus)
  "08" # Other Full Benefit Dual Eligible
)

#' Partial Benefit Dual Eligible (Medicare + limited Medicaid)
#' Uses CPA_ (Community, Partial Benefit Dual, Aged) or CPD_ (Disabled) prefixes
#' @noRd
PARTIAL_BENEFIT_DUAL_CODES = c(
  "01", # QMB Only
  "03", # SLMB Only
  "05", # QDWI (Qualified Disabled and Working Individual)
  "06" # QI (Qualifying Individual)
)

# =============================================================================
# OREC - Original Reason for Entitlement Code
# =============================================================================

#' Determines if beneficiary has ESRD and affects coefficient prefix selection
#' @noRd
VALID_OREC_VALUES = c("0", "1", "2", "3")

#' @noRd
OREC_DESCRIPTIONS = list(
  "0" = "Old Age and Survivors Insurance (OASI)",
  "1" = "Disability Insurance Benefits (DIB)",
  "2" = "ESRD - End-Stage Renal Disease",
  "3" = "DIB and ESRD"
)

#' OREC codes indicating ESRD status (per CMS documentation)
#' @noRd
OREC_ESRD_CODES = c("2", "3")

# =============================================================================
# CREC - Current Reason for Entitlement Code
# =============================================================================

#' Current entitlement status (may differ from OREC)
#' @noRd
VALID_CREC_VALUES = c("0", "1", "2", "3")

#' @noRd
CREC_DESCRIPTIONS = list(
  "0" = "Old Age and Survivors Insurance (OASI)",
  "1" = "Disability Insurance Benefits (DIB)",
  "2" = "ESRD - End-Stage Renal Disease",
  "3" = "DIB and ESRD"
)

#' CREC codes indicating ESRD status
#' @noRd
CREC_ESRD_CODES = c("2", "3")

# =============================================================================
# COEFFICIENT PREFIX GROUPS
# =============================================================================
# Used for prefix_override logic in model_demographics

#' ESRD model prefixes
#' @noRd
ESRD_PREFIXES = c(
  "DI_",
  "DNE_",
  "GI_",
  "GNE_",
  "GFPA_",
  "GFPN_",
  "GNPA_",
  "GNPN_"
)

#' CMS-HCC new enrollee prefixes
#' @noRd
NEW_ENROLLEE_PREFIXES = c("NE_", "SNPNE_", "DNE_", "GNE_")

#' CMS-HCC community prefixes
#' @noRd
COMMUNITY_PREFIXES = c("CNA_", "CND_", "CFA_", "CFD_", "CPA_", "CPD_")

#' Institutionalized prefixes
#' @noRd
INSTITUTIONAL_PREFIXES = c("INS_", "GI_")

#' Full Benefit Dual prefixes
#' @noRd
FULL_BENEFIT_DUAL_PREFIXES = c("CFA_", "CFD_", "GFPA_", "GFPN_")

#' Partial Benefit Dual prefixes
#' @noRd
PARTIAL_BENEFIT_DUAL_PREFIXES = c("CPA_", "CPD_")

#' Non-Dual prefixes
#' @noRd
NON_DUAL_PREFIXES = c("CNA_", "CND_", "GNPA_", "GNPN_")

# =============================================================================
# DEMOGRAPHIC CODES
# =============================================================================
#' @noRd
VALID_SEX_CODES = c("M", "F")

#' X12 834 Gender Code mappings
#' @noRd
X12_SEX_CODE_MAPPING = list(
  "M" = "M",
  "F" = "F",
  "1" = "M", # X12 numeric code
  "2" = "F" # X12 numeric code
)

# =============================================================================
# X12 834 MAINTENANCE TYPE CODES
# =============================================================================

#' INS03 - Maintenance Type Code
#' @noRd
MAINTENANCE_TYPE_CHANGE = "001"
#' @noRd
MAINTENANCE_TYPE_ADD = "021"
#' @noRd
MAINTENANCE_TYPE_CANCEL = "024"
#' @noRd
MAINTENANCE_TYPE_REINSTATE = "025"
#' @noRd
MAINTENANCE_TYPE_DESCRIPTIONS = list(
  "001" = "Change",
  "021" = "Addition",
  "024" = "Cancellation/Termination",
  "025" = "Reinstatement"
)

# =============================================================================
# STATE-SPECIFIC MAPPINGS
# =============================================================================

# -----------------------------------------------------------------------------
# California DHCS Medi-Cal Aid Codes
# -----------------------------------------------------------------------------

#' Maps California-specific aid codes to CMS dual eligibility codes
#' Source: California DHCS 834 Implementation Guide
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

# -----------------------------------------------------------------------------
# Medicare Status Code Mappings
# -----------------------------------------------------------------------------
# Maps Medicare status codes (from various sources) to CMS dual eligibility codes
# Used in X12 834 REF*ABB segment and other payer files
#' @noRd
MEDICARE_STATUS_CODE_MAPPING = list(
  # QMB - Qualified Medicare Beneficiary
  `NA` = NA,
  "QMB" = "01", # QMB Only (Partial)
  "QMBONLY" = "01",
  "QMBPLUS" = "02", # QMB Plus (Full Benefit)
  "QMB+" = "02",

  # SLMB - Specified Low-Income Medicare Beneficiary
  "SLMB" = "03", # SLMB Only (Partial)
  "SLMBONLY" = "03",
  "SLMBPLUS" = "04", # SLMB Plus (Full Benefit)
  "SLMB+" = "04",

  # Other dual eligibility programs
  "QDWI" = "05", # Qualified Disabled and Working Individual
  "QI" = "06", # Qualifying Individual
  "QI1" = "06",
  "FBDE" = "08", # Full Benefit Dual Eligible (Other)
  "OTHERFULL" = "08"
)
