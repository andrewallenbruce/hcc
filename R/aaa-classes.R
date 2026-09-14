#' @noRd
S3_ivs_iv <- S7::new_S3_class(c("ivs_iv", "vctrs_rcrd", "vctrs_vctr"))

#' @noRd
prop_date <- S7::new_property(
  S7::class_Date,
  setter = function(self, name, value) {
    S7::prop(self, name) <- as.Date(value)
    self
  }
)

#' HCC Category Detail
#'
#' @param hcc `<int>` HCC code (e.g., 18, 85)
#' @param label `<chr>` Human-readable description (e.g., "Diabetes with Chronic
#'   Complications")
#' @param is_chronic `<lgl>` Whether this HCC is considered a chronic condition
#' @param coefficient `<dbl>` The coefficient value applied for this HCC in the
#'   RAF calculation
#' @returns An `<HCCDetail>` S7 object
#' @usage NULL
#' @examples
#' HCCDetail( # HCC203
#'  hcc = 203L,
#'  label = "Coma, Brain Compression/Anoxic Damage",
#'  is_chronic = TRUE,
#'  coefficient = 0.486
#' )
#' @name HCCDetail
#' @export
HCCDetail := S7::new_class(
  properties = list(
    hcc = S7::class_integer,
    label = S7::class_character,
    is_chronic = S7::class_logical,
    coefficient = S7::class_double
  )
)

#' Health Care Plan coverage period from HD loop
#'
#' Single HD loop (HCP coverage period)
#'
#' @param start_date `<Date>` coverage start date
#' @param end_date `<Date>` coverage start date
#' @param hcp_code `<chr>` HCP code
#' @param hcp_status `<chr>` HCP status
#' @param aid_codes `<chr>` REF*CE composite
#' @returns An `<HCPCoveragePeriod>` S7 object
#' @usage NULL
#' @examples
#' HCPCoveragePeriod(start_date = "2026-08-20", end_date = "2026-08-25")
#' @name HCPCoveragePeriod
#' @export
HCPCoveragePeriod := S7::new_class(
  properties = list(
    start_date = prop_date,
    end_date = prop_date,
    hcp_code = S7::class_character,
    hcp_status = S7::class_character,
    aid_codes = S7::class_character
  ),
  validator = function(self) {
    if (self@start_date >= self@end_date) {
      return("@start_date must occur before @end_date")
    }
  }
)

#' Healthcare Claim Service Level Data
#'
#' @param claim_id `<chr>` Unique identifier for the claim
#' @param procedure_code `<chr>` HCPCS code
#' @param ndc `<chr>` National Drug Code
#' @param linked_diagnosis_codes `<chr>` ICD-10 diagnosis codes linked to this
#'   service
#' @param claim_diagnosis_codes `<chr>` All diagnosis codes on the claim
#' @param claim_type `<chr>` Type of claim (e.g., NCH Claim Type Code, or 837I,
#'   837P)
#' @param provider_specialty `<chr>` Provider taxonomy or specialty code
#' @param performing_provider_npi `<chr>` National Provider Identifier for
#'   performing provider
#' @param billing_provider_npi `<chr>` National Provider Identifier for billing
#'   provider
#' @param patient_id `<chr>` Unique identifier for the patient
#' @param facility_type `<chr>` Type of facility where service was rendered
#' @param service_type `<chr>` Type of service provided (facility type + service
#'   type = Type of Bill)
#' @param service_date `<Date>` Date service was performed (YYYY-MM-DD)
#' @param place_of_service `<chr>` Place of service code
#' @param quantity `<num>` Number of units provided
#' @param quantity_unit `<chr>` Unit of measure for quantity
#' @param modifiers `<chr>` List of procedure code modifiers
#' @param allowed_amount `<num>` Allowed amount for the service
#' @returns A `<ServiceLevelData>` S7 object
#' @usage NULL
#' @examples
#' ServiceLevelData(
#'   claim_id = "756048Q",
#'   procedure_code = c("85025", "93005"),
#'   claim_diagnosis_codes = c("3669", "4019", "79431"),
#'   claim_type = "837I",
#'   provider_specialty = "203BA0200N",
#'   billing_provider_npi = "9876540809",
#'   patient_id = "030005074A",
#'   facility_type = "14",
#'   service_date = "1996-09-11",
#'   quantity = c(1L, 3L),
#'   quantity_unit = "UN",
#'   allowed_amount = 89.93
#' )
#' @name ServiceLevelData
#' @export
ServiceLevelData := S7::new_class(
  properties = list(
    claim_id = S7::class_character,
    procedure_code = S7::class_character,
    ndc = S7::class_character,
    linked_diagnosis_codes = S7::class_character,
    claim_diagnosis_codes = S7::class_character,
    claim_type = S7::class_character,
    provider_specialty = S7::class_character,
    performing_provider_npi = S7::class_character,
    billing_provider_npi = S7::class_character,
    patient_id = S7::class_character,
    facility_type = S7::class_character,
    service_type = S7::class_character,
    service_date = prop_date,
    place_of_service = S7::class_character,
    quantity = S7::class_numeric,
    quantity_unit = S7::class_character,
    modifiers = S7::class_character,
    allowed_amount = S7::class_numeric
  )
)

#' Risk Adjustment Factor score results
#'
#' @param risk_score `<dbl>` Final RAF score
#' @param risk_score_demographics `<dbl>` Demographics-only risk score
#' @param risk_score_chronic_only `<dbl>` Chronic conditions risk score
#' @param risk_score_hcc `<dbl>` HCC conditions risk score
#' @param risk_score_payment `<dbl>` Payment RAF score, adjusted for MACI,
#'   normalization, and frailty
#' @param hcc_list `<chr>` List of active HCC categories
#' @param hcc_details `<chr>` Detailed HCC information with labels and chronic
#'   status
#' @param cc_to_dx Condition categories mapped to diagnosis codes
#' @param coefficients Applied model coefficients
#' @param interactions Disease interaction coefficients
#' @param demographics Patient demographics used in calculation
#' @param model_name `<chr>` HCC model used for calculation
#' @param version `<chr>` Library version
#' @param diagnosis_codes `<chr>` Input diagnosis codes
#' @param service_level_data `<ServiceLevelData>` S7 object; Processed service
#'   records
#' @returns A `<RAFResult>` S7 object
#' @usage NULL
#' @examples
#' RAFResult()
#' @name RAFResult
#' @export
RAFResult := S7::new_class(
  properties = list(
    risk_score = S7::class_double,
    risk_score_demographics = S7::class_double,
    risk_score_chronic_only = S7::class_double,
    risk_score_hcc = S7::class_double,
    risk_score_payment = S7::class_double,
    hcc_list = S7::class_character,
    hcc_details = S7::class_character,
    cc_to_dx = S7::class_character,
    coefficients = S7::class_double,
    interactions = S7::class_character,
    demographics = S7::class_character,
    model_name = S7::class_character,
    version = S7::class_character,
    diagnosis_codes = S7::class_character,
    service_level_data = ServiceLevelData
  )
)

#' X12-834 Transaction Enrollment Data
#'
#' Data needed for risk adjustment and Medicaid coverage tracking.
#' Supports California DHCS Medi-Cal 834 format with FAME fields.
#'
#' @param source `ISA-06` Interchange sender ID
#' @param report_date `GS-04` Transaction date
#' @param member_id `REF*0F` Unique identifier for the member
#' @param mbi `REF*6P` Medicare Beneficiary Identifier
#' @param medicaid_id `REF*23` Medicaid/Medi-Cal ID number
#' @param hic `REF*F6` Medicare HICN
#' @param cin `REF*3H` Client Index Number
#' @param cin_check_digit `REF*3H` CIN check digit
#' @param first_name `NM1-04` Member first name
#' @param last_name `NM1-03` Member last name
#' @param middle_name `NM1-05` Member middle name
#' @param dob Date of birth (YYYY-MM-DD)
#' @param age Calculated age
#' @param sex Member sex (M/F)
#' @param race `DMG-05` Race/ethnicity code
#' @param language `LUI-02` Preferred language
#' @param death_date Date of death if applicable
#' @param address_1 `N3-01` Street address line 1
#' @param address_2 `N3-02` Street address line 2
#' @param city `N4-01` City
#' @param state `N4-02` State code
#' @param zip `N4-03` Postal code
#' @param phone `PER-04` Phone number
#' @param maintenance_type `INS-03`
#'    - Change (`001`)
#'    - Add (`021`)
#'    - Cancel (`024`)
#'    - Reinstate (`025`)
#' @param maintenance_reason_code `INS-04` Maintenance reason
#' @param benefit_status_code `INS-05` A=Active, C=COBRA, etc.
#' @param coverage_start Coverage effective date
#' @param coverage_end Coverage termination date
#' @param has_medicare Member has Medicare coverage
#' @param has_medicaid Member has Medicaid coverage
#' @param dual_elgbl_cd Dual eligibility status code (`00`,`01`-`08`)
#' @param is_full_benefit_dual Full Benefit Dual (uses CFA_/CFD_ prefix)
#' @param is_partial_benefit_dual Partial Benefit Dual (uses CPA_/CPD_ prefix)
#' @param medicare_status_code QMB, SLMB, QI, QDWI, etc.
#' @param medi_cal_aid_code California Medi-Cal aid code
#' @param medi_cal_eligibility_status Medi-Cal eligibility status
#'   (Active/Terminated/None)
#' @param fame_county_id FAME county ID (`REF*ZX` or `N4*CY`)
#' @param case_number Case number (`REF*1L`)
#' @param fame_card_issue_date FAME card issue date
#' @param fame_redetermination_date FAME redetermination date (`REF*17`)
#' @param fame_death_date FAME death date
#' @param primary_aid_code Primary AID code (`REF*RB`)
#' @param carrier_code Carrier code
#' @param fed_contract_number Federal contract number
#' @param client_reporting_cat Client reporting category
#' @param res_addr_flag Residential address flag from `REF*6O`
#' @param reas_add_ind Reason address indicator from `REF*6O`
#' @param res_zip_deliv_code Residential zip delivery code
#' @param orec Original Reason for Entitlement Code
#' @param crec Current Reason for Entitlement Code
#' @param snp Special Needs Plan enrollment
#' @param low_income Low Income Subsidy (Part D)
#' @param lti Long-Term Institutionalized
#' @param new_enrollee New enrollee status (`<= 3 months`)
#' @param medicare_prt_a description
#' @param medicare_prt_b description
#' @param medicare_prt_d description
#' @param hcp_code Current HCP code (`HD-04` first part)
#' @param hcp_status Current HCP status (`HD-04` second part)
#' @param amount_qualifier AMT qualifier code (e.g., `D` = premium, `C1` =
#'   copay)
#' @param amount Premium or cost share amount (numeric)
#' @param hcp_history `<HCPCoveragePeriod>` List of historical HCP coverage
#'   periods
#' @returns A `<EnrollmentData>` S7 object
#' @usage NULL
#' @examplesIf FALSE
#' EnrollmentData()
#' @export
EnrollmentData <- function(
  source = character(),
  report_date = character(),
  member_id = character(),
  mbi = character(),
  medicaid_id = character(),
  hic = character(),
  cin = character(),
  cin_check_digit = integer(),
  first_name = character(),
  last_name = character(),
  middle_name = character(),
  dob = character(),
  age = integer(),
  sex = character(),
  race = character(),
  language = character(),
  death_date = character(),
  address_1 = character(),
  address_2 = character(),
  city = character(),
  state = character(),
  zip = character(),
  phone = character(),
  maintenance_type = character(),
  maintenance_reason_code = character(),
  benefit_status_code = character(),
  coverage_start = character(),
  coverage_end = character(),
  has_medicare = logical(),
  has_medicaid = logical(),
  dual_elgbl_cd = character(),
  is_full_benefit_dual = logical(),
  is_partial_benefit_dual = logical(),
  medicare_status_code = character(),
  medi_cal_aid_code = character(),
  medi_cal_eligibility_status = character(),
  fame_county_id = character(),
  case_number = character(),
  fame_card_issue_date = character(),
  fame_redetermination_date = character(),
  fame_death_date = character(),
  primary_aid_code = character(),
  carrier_code = character(),
  fed_contract_number = character(),
  client_reporting_cat = character(),
  res_addr_flag = character(),
  reas_add_ind = character(),
  res_zip_deliv_code = character(),
  orec = character(),
  crec = character(),
  snp = logical(),
  low_income = logical(),
  lti = logical(),
  new_enrollee = logical(),
  medicare_prt_a = logical(),
  medicare_prt_b = logical(),
  medicare_prt_d = logical(),
  hcp_code = character(),
  hcp_status = character(),
  amount_qualifier = character(),
  amount = double(),
  hcp_history = HCPCoveragePeriod()
) {
  list(
    source = source,
    report_date = report_date,
    member_id = member_id,
    mbi = mbi,
    medicaid_id = medicaid_id,
    hic = hic,
    cin = cin,
    cin_check_digit = cin_check_digit,
    first_name = first_name,
    last_name = last_name,
    middle_name = middle_name,
    dob = dob,
    age = age,
    sex = sex,
    race = race,
    language = language,
    death_date = death_date,
    address_1 = address_1,
    address_2 = address_2,
    city = city,
    state = state,
    zip = zip,
    phone = phone,
    maintenance_type = maintenance_type,
    maintenance_reason_code = maintenance_reason_code,
    benefit_status_code = benefit_status_code,
    coverage_start = coverage_start,
    coverage_end = coverage_end,
    has_medicare = has_medicare,
    has_medicaid = has_medicaid,
    dual_elgbl_cd = dual_elgbl_cd,
    is_full_benefit_dual = is_full_benefit_dual,
    is_partial_benefit_dual = is_partial_benefit_dual,
    medicare_status_code = medicare_status_code,
    medi_cal_aid_code = medi_cal_aid_code,
    medi_cal_eligibility_status = medi_cal_eligibility_status,
    fame_county_id = fame_county_id,
    case_number = case_number,
    fame_card_issue_date = fame_card_issue_date,
    fame_redetermination_date = fame_redetermination_date,
    fame_death_date = fame_death_date,
    primary_aid_code = primary_aid_code,
    carrier_code = carrier_code,
    fed_contract_number = fed_contract_number,
    client_reporting_cat = client_reporting_cat,
    res_addr_flag = res_addr_flag,
    reas_add_ind = reas_add_ind,
    res_zip_deliv_code = res_zip_deliv_code,
    orec = orec,
    crec = crec,
    snp = snp,
    low_income = low_income,
    lti = lti,
    new_enrollee = new_enrollee,
    medicare_prt_a = medicare_prt_a,
    medicare_prt_b = medicare_prt_b,
    medicare_prt_d = medicare_prt_d,
    hcp_code = hcp_code,
    hcp_status = hcp_status,
    amount_qualifier = amount_qualifier,
    amount = amount,
    hcp_history = hcp_history
  )
}
