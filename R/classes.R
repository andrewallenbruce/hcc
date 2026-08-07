#' Detailed information about an HCC category.
#'
#' @param hcc HCC code (e.g., "18", "85")
#' @param label Human-readable description (e.g., "Diabetes with Chronic Complications")
#' @param is_chronic Whether this HCC is considered a chronic condition
#' @param coefficient The coefficient value applied for this HCC in the RAF calculation
#' @returns <HCCDetail> object
#' @examplesIf FALSE
#' HCCDetail()
#' @export
HCCDetail <- function(hcc, label, is_chronic, coefficient) {
  list(
    hcc = hcc,
    label = label,
    is_chronic = is_chronic,
    coefficient = coefficient
  )
}

#' Represents standardized service-level data extracted from healthcare claims.
#'
#' @param claim_id Unique identifier for the claim
#' @param procedure_code Healthcare Common Procedure Coding System (HCPCS) code
#' @param ndc National Drug Code
#' @param linked_diagnosis_codes ICD-10 diagnosis codes linked to this service
#' @param claim_diagnosis_codes All diagnosis codes on the claim
#' @param claim_type Type of claim (e.g., NCH Claim Type Code, or 837I, 837P)
#' @param provider_specialty Provider taxonomy or specialty code
#' @param performing_provider_npi National Provider Identifier for performing provider
#' @param billing_provider_npi National Provider Identifier for billing provider
#' @param patient_id Unique identifier for the patient
#' @param facility_type Type of facility where service was rendered
#' @param service_type Type of service provided (facility type + service type = Type of Bill)
#' @param service_date Date service was performed (YYYY-MM-DD)
#' @param place_of_service Place of service code
#' @param quantity Number of units provided
#' @param quantity_unit Unit of measure for quantity
#' @param modifiers List of procedure code modifiers
#' @param allowed_amount Allowed amount for the service
#' @returns <ServiceLevelData> object
#' @examplesIf FALSE
#' ServiceLevelData()
#' @export
ServiceLevelData <- function(
  claim_id,
  procedure_code,
  ndc,
  linked_diagnosis_codes,
  claim_diagnosis_codes,
  claim_type,
  provider_specialty,
  performing_provider_npi,
  billing_provider_npi,
  patient_id,
  facility_type,
  service_type,
  service_date,
  place_of_service,
  quantity,
  quantity_unit,
  modifiers,
  allowed_amount
) {
  list(
    claim_id = claim_id,
    procedure_code = procedure_code,
    ndc = ndc,
    linked_diagnosis_codes = linked_diagnosis_codes,
    claim_diagnosis_codes = claim_diagnosis_codes,
    claim_type = claim_type,
    provider_specialty = provider_specialty,
    performing_provider_npi = performing_provider_npi,
    billing_provider_npi = billing_provider_npi,
    patient_id = patient_id,
    facility_type = facility_type,
    service_type = service_type,
    service_date = service_date,
    place_of_service = place_of_service,
    quantity = quantity,
    quantity_unit = quantity_unit,
    modifiers = modifiers,
    allowed_amount = allowed_amount
  )
}

#' Response model for demographic categorization
#'
#' @param age `<int>` Beneficiary age (floored to `integer`)
#' @param sex `<chr>` Beneficiary sex (M/F or 1/2)
#' @param dual_elgbl_cd `<chr>` Dual eligibility code ("00" - "10")
#' @param orec `<chr>` Original reason for entitlement code ("0" - "3")
#' @param crec `<chr>` Current reason for entitlement code ("0" - "3")
#' @param version `<chr>` Version of categorization to use ("V2", "V4", "V6")
#' @param new_enrollee `<lgl>` Whether beneficiary is a **New Enrollee**
#' @param snp `<lgl>` Whether beneficiary is in a **Special Needs Plan**
#' @param low_income `<lgl>` Whether beneficiary is **Low Income** (RxHCC only)
#' @param graft_months `<int>` Number of months since transplant (ESRD only)
#' @returns <Demographics> object containing the following derived fields:
#'    - category: Age-sex category code
#'    - non_aged: `TRUE` if `age <= 64`
#'    - orig_disabled: `TRUE` if originally disabled (`OREC == "1"`) and not currently disabled)
#'    - disabled: `TRUE` if currently disabled (`age < 65 & OREC != "0"`)
#'    - esrd: `TRUE` if ESRD (ESRD Model)
#'    - lti: `TRUE` if LTI (LTI Model)
#'    - fbd: `TRUE` if FBD (FBD Model)
#'    - pbd: `TRUE` if PBD (PBD Model)
#' @examples
#' Demographics(age = 48, sex = "1", version = "V2")
#' Demographics(age = 35, sex = "M", version = "V6")
#' Demographics(age = 75, sex = "2", orec = "0", version = "V2")
#' @export
Demographics <- function(
  age = integer(),
  sex = character(),
  orec = character(),
  crec = character(),
  version = character(),
  snp = logical(),
  dual_elgbl_cd = character(),
  new_enrollee = logical(),
  graft_months = integer(),
  low_income = logical()
) {
  structure(
    list(
      version = version,
      age = age,
      sex = sex,
      non_aged = logical(),
      orig_disabled = logical(),
      disabled = logical(),
      dual_elgbl_cd = dual_elgbl_cd,
      orec = orec,
      crec = crec,
      new_enrollee = new_enrollee,
      snp = snp,
      fbd = logical(),
      pbd = logical(),
      esrd = logical(),
      lti = logical(),
      graft_months = graft_months,
      low_income = low_income
    ),
    class = "demographics"
  )
}

#' Risk adjustment calculation results
#'
#' @param risk_score Final RAF score
#' @param risk_score_demographics Demographics-only risk score
#' @param risk_score_chronic_only Chronic conditions risk score
#' @param risk_score_hcc HCC conditions risk score
#' @param risk_score_payment Payment RAF score (adjusted for MACI, normalization, and frailty)
#' @param hcc_list List of active HCC categories
#' @param hcc_details Detailed HCC information with labels and chronic status
#' @param cc_to_dx Condition categories mapped to diagnosis codes
#' @param coefficients Applied model coefficients
#' @param interactions Disease interaction coefficients
#' @param demographics Patient demographics used in calculation
#' @param model_name HCC model used for calculation
#' @param version Library version
#' @param diagnosis_codes Input diagnosis codes
#' @param service_level_data Processed service records
#' @returns <RAFResult> object
#' @examplesIf FALSE
#' RAFResult()
#' @export
RAFResult <- function(
  risk_score,
  risk_score_demographics,
  risk_score_chronic_only,
  risk_score_hcc,
  risk_score_payment,
  hcc_list,
  hcc_details,
  cc_to_dx,
  coefficients,
  interactions,
  demographics,
  model_name,
  version,
  diagnosis_codes,
  service_level_data
) {
  list(
    risk_score = risk_score,
    risk_score_demographics = risk_score_demographics,
    risk_score_chronic_only = risk_score_chronic_only,
    risk_score_hcc = risk_score_hcc,
    risk_score_payment = risk_score_payment,
    hcc_list = hcc_list,
    hcc_details = hcc_details,
    cc_to_dx = cc_to_dx,
    coefficients = coefficients,
    interactions = interactions,
    demographics = demographics,
    model_name = model_name,
    version = version,
    diagnosis_codes = diagnosis_codes,
    service_level_dat = service_level_data
  )
}

#' @noRd
model_config = c("extra" = "forbid", "validate_assignment" = TRUE)

#' A single HCP (Health Care Plan) coverage period from HD loop
#'
#' @param start_date date
#' @param end_date date
#' @param hcp_code code
#' @param hcp_status status
#' @param aid_codes REF*CE composite
#' @returns <HCPCoveragePeriod> object
#' @export
HCPCoveragePeriod <- function(
  start_date,
  end_date,
  hcp_code,
  hcp_status,
  aid_codes
) {
  list(
    start_date = start_date,
    end_date = end_date,
    hcp_code = hcp_code,
    hcp_status = hcp_status,
    aid_codes = aid_codes
  )
}

# Enrollment and demographic data extracted from 834 transactions.
#
# Focus: Extract data needed for risk adjustment and Medicaid coverage tracking.
# Supports California DHCS Medi-Cal 834 format with FAME fields.
#
# @param source Interchange sender ID (ISA06)
# @param report_date Transaction date (GS04)
# @param member_id Unique identifier for the member (REF*0F)
# @param mbi Medicare Beneficiary Identifier (REF*6P)
# @param medicaid_id Medicaid/Medi-Cal ID number (REF*23)
# @param hic Medicare HICN (REF*F6)
# @param cin Client Index Number from REF*3H
# @param cin_check_digit CIN check digit from REF*3H
# @param first_name Member first name (NM104)
# @param last_name Member last name (NM103)
# @param middle_name Member middle name (NM105)
# @param dob Date of birth (YYYY-MM-DD)
# @param age Calculated age
# @param sex Member sex (M/F)
# @param race Race/ethnicity code (DMG05)
# @param language Preferred language (LUI02)
# @param death_date Date of death if applicable
# @param address_1 Street address line 1 (N301)
# @param address_2 Street address line 2 (N302)
# @param city City (N401)
# @param state State code (N402)
# @param zip Postal code (N403)
# @param phone Phone number (PER04)
# @param maintenance_type 001 = Change, 021 = Add, 024 = Cancel, 025 = Reinstate (INS03)
# @param maintenance_reason_code Maintenance reason (INS04)
# @param benefit_status_code A=Active, C=COBRA, etc. (INS05)
# @param coverage_start_date Coverage effective date
# @param coverage_end_date Coverage termination date
# @param has_medicare Member has Medicare coverage
# @param has_medicaid Member has Medicaid coverage
# @param dual_elgbl_cd Dual eligibility status code ('00','01'-'08')
# @param is_full_benefit_dual Full Benefit Dual (uses CFA_/CFD_ prefix)
# @param is_partial_benefit_dual Partial Benefit Dual (uses CPA_/CPD_ prefix)
# @param medicare_status_code QMB, SLMB, QI, QDWI, etc.
# @param medi_cal_aid_code California Medi-Cal aid code
# @param medi_cal_eligibility_status Medi-Cal eligibility status (Active/Terminated/None) [derived]
# @param fame_county_id FAME county ID (REF*ZX or N4*CY)
# @param case_number Case number (REF*1L)
# @param fame_card_issue_date FAME card issue date
# @param fame_redetermination_date FAME redetermination date (REF*17)
# @param fame_death_date FAME death date
# @param primary_aid_code Primary AID code (REF*RB)
# @param carrier_code Carrier code
# @param fed_contract_number Federal contract number
# @param client_reporting_cat Client reporting category
# @param res_addr_flag Residential address flag from REF*6O
# @param reas_add_ind Reason address indicator from REF*6O
# @param res_zip_deliv_code Residential zip delivery code
# @param orec Original Reason for Entitlement Code
# @param crec Current Reason for Entitlement Code
# @param snp Special Needs Plan enrollment
# @param low_income Low Income Subsidy (Part D)
# @param lti Long-Term Institutionalized
# @param new_enrollee New enrollee status (<= 3 months)
# @param hcp_code Current HCP code (HD04 first part)
# @param hcp_status Current HCP status (HD04 second part)
# @param amount_qualifier AMT qualifier code (e.g., 'D' = premium, 'C1' = copay)
# @param amount Premium or cost share amount (numeric)
# @param hcp_history List of historical HCP coverage periods
# @returns <EnrollmentData> object
# @examplesIf FALSE
# EnrollmentData()
# @export
#' EnrollmentData <- function() {
#'   list(
#'     # Header Info
#'     source = source
#'     report_date = report_date,
#'     # Identifiers
#'     member_id = member_id,
#'     mbi = mbi,
#'     medicaid_id = medicaid_id,
#'     hic = hic,
#'     cin = cin,
#'     cin_check_digit = cin_check_digit,
#'     # Name
#'     first_name = first_name,
#'     last_name = last_name,
#'     middle_name = middle_name,
#'     # Demographics
#'     dob: Optional[str] = None
#'     age: Optional[int] = None
#'     sex: Optional[str] = None
#'     race: Optional[str] = None
#'     language: Optional[str] = None
#'     death_date: Optional[str] = None
#'
#'     # Address
#'     address_1: Optional[str] = None
#'     address_2: Optional[str] = None
#'     city: Optional[str] = None
#'     state: Optional[str] = None
#'     zip: Optional[str] = None
#'     phone: Optional[str] = None
#'
#'     # Coverage tracking
#'     maintenance_type: Optional[str] = None
#'     maintenance_reason_code: Optional[str] = None
#'     benefit_status_code: Optional[str] = None
#'     coverage_start_date: Optional[str] = None
#'     coverage_end_date: Optional[str] = None
#'
#'     # Medicaid/Medicare Status
#'     has_medicare: bool = False
#'     has_medicaid: bool = False
#'     dual_elgbl_cd: Optional[str] = None
#'     is_full_benefit_dual: bool = False
#'     is_partial_benefit_dual: bool = False
#'     medicare_status_code: Optional[str] = None
#'     medi_cal_aid_code: Optional[str] = None
#'     medi_cal_eligibility_status: Optional[str] = None
#'
#'     # CA DHCS / FAME Specific
#'     fame_county_id: Optional[str] = None
#'     case_number: Optional[str] = None
#'     fame_card_issue_date: Optional[str] = None
#'     fame_redetermination_date: Optional[str] = None
#'     fame_death_date: Optional[str] = None
#'     primary_aid_code: Optional[str] = None
#'     carrier_code: Optional[str] = None
#'     fed_contract_number: Optional[str] = None
#'     client_reporting_cat: Optional[str] = None
#'     res_addr_flag: Optional[str] = None
#'     reas_add_ind: Optional[str] = None
#'     res_zip_deliv_code: Optional[str] = None
#'
#'     # Risk Adjustment Fields
#'     orec: Optional[str] = None
#'     crec: Optional[str] = None
#'     snp: bool = False
#'     low_income: bool = False
#'     lti: bool = False
#'     new_enrollee: bool = False
#'
#'     # Medicare Part A/B/D payment indicators (REF*9V, CA DHCS specific)
#'     medicare_prt_a: Optional[str] = None
#'     medicare_prt_b: Optional[str] = None
#'     medicare_prt_d: Optional[str] = None
#'
#'     # HCP Info
#'     hcp_code: Optional[str] = None
#'     hcp_status: Optional[str] = None
#'     amount_qualifier: Optional[str] = None
#'     amount: Optional[float] = None
#'
#'     # HCP History
#'     hcp_history: List[HCPCoveragePeriod] = [])
#' }

# EnrollmentData date fields
# date_fields = (
#   'report_date',
#   'dob',
#   'death_date',
#   'coverage_start_date',
#   'coverage_end_date',
#   'fame_card_issue_date',
#   'fame_redetermination_date',
#   'fame_death_date',
# )

# class RemittanceEntry(BaseModel):
#   """
#     A single remittance line item within a member's payment record.
#
#     Each RemittanceEntry corresponds to one RMR segment and its associated
#     REF, DTM, and ADX segments within an ENT loop of an 820 transaction.
#
#     Attributes:
#         reference_number: Invoice/check reference number (RMR02)
#         payment_amount: Net payment amount for this period; negative = recoupment (RMR04/05)
#         original_amount: Original amount before adjustment, when present (RMR05/06)
#         rate_code: Rate code from REF*18 (e.g., "957" = PACE rate)
#         aid_code: California Medi-Cal aid code from REF*ZZ (e.g., "1H", "M1", "60")
#         plan_type: Plan type from REF*ZZ composite aid_code;plan_type
#                    ("1" = primary/medical, "2" = pharmacy/state-only)
#         description: Payment description from second REF*ZZ
#                      (e.g., "Primary Capitation Dual", "Medi-Cal Only-State Only")
#         coverage_period_start: Coverage period begin date (YYYY-MM-DD) from DTM*582
#         coverage_period_end: Coverage period end date (YYYY-MM-DD) from DTM*582
#         adjustment_amount: Adjustment amount from ADX01 (negative = recoupment)
#         adjustment_reason: Adjustment reason code from ADX02 (e.g., "53" = prior period)
#     """
# reference_number: Optional[str] = None
# payment_amount: Optional[float] = None
# original_amount: Optional[float] = None
# rate_code: Optional[str] = None
# aid_code: Optional[str] = None
# plan_type: Optional[str] = None
# description: Optional[str] = None
# coverage_period_start: Optional[str] = None
# coverage_period_end: Optional[str] = None
# adjustment_amount: Optional[float] = None
# adjustment_reason: Optional[str] = None
#
#
# class PaymentDetail(BaseModel):
#   """
#     Per-member payment record from an X12 820 ENT loop.
#
#     One PaymentDetail is created per ENT segment. A member may appear in
#     multiple ENT entries within the same transaction (e.g., retroactive
#     adjustments for prior periods).
#
#     Attributes:
#         entity_number: ENT sequence number (ENT01)
#         member_id: Member identifier from NM109
#         last_name: Member last name (NM103)
#         first_name: Member first name (NM104)
#         middle_name: Member middle name (NM105)
#         remittance_entries: List of remittance line items (one per RMR/DTM set)
#     """
# entity_number: str = ""
# member_id: Optional[str] = None
# last_name: Optional[str] = None
# first_name: Optional[str] = None
# middle_name: Optional[str] = None
# remittance_entries: List[RemittanceEntry] = []
#
#
# class PaymentData(BaseModel):
#   """
#     Payment/remittance data extracted from an X12 820 transaction.
#
#     Represents one ST*820 transaction, typically a capitation payment
#     remittance from a state Medicaid agency or CMS to a managed care plan.
#
#     Attributes:
#         source: Interchange sender ID (ISA06), e.g., "CALIFORNIA-DHCS"
#         report_date: Transaction date from GS04 (YYYY-MM-DD)
#         total_amount: Total payment amount from BPR02
#         payment_date: EFT effective date from BPR16 (YYYY-MM-DD)
#         check_number: EFT/check trace number from TRN02
#         payee_name: Receiving organization name (N1*PE)
#         payee_address_1: Payee street address (N3)
#         payee_city: Payee city (N4)
#         payee_state: Payee state (N4)
#         payee_zip: Payee ZIP code (N4)
#         payer_name: Paying organization name (N1*PR)
#         payer_address_1: Payer street address (N3)
#         payer_city: Payer city (N4)
#         payer_state: Payer state (N4)
#         payer_zip: Payer ZIP code (N4)
#         members: List of per-member payment records
#     """
# source: Optional[str] = None
# report_date: Optional[str] = None
# total_amount: Optional[float] = None
# payment_date: Optional[str] = None
# check_number: Optional[str] = None
# payee_name: Optional[str] = None
# payee_address_1: Optional[str] = None
# payee_city: Optional[str] = None
# payee_state: Optional[str] = None
# payee_zip: Optional[str] = None
# payer_name: Optional[str] = None
# payer_address_1: Optional[str] = None
# payer_city: Optional[str] = None
# payer_state: Optional[str] = None
# payer_zip: Optional[str] = None
# members: List[PaymentDetail] = []
