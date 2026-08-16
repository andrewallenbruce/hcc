#' HCC Category Detail
#'
#' @param hcc `<chr>` HCC code (e.g., "18", "85")
#' @param label `<chr>` Human-readable description (e.g., "Diabetes with Chronic Complications")
#' @param is_chronic `<lgl>` Whether this HCC is considered a chronic condition
#' @param coefficient `<dbl>` The coefficient value applied for this HCC in the RAF calculation
#' @returns An <HCCDetail> S7 object
#' @examplesIf FALSE
#' HCCDetail(
#'  hcc = "80",
#'  label = "Coma, Brain Compression/Anoxic Damage",
#'  is_chronic = FALSE,
#'  coefficient = 0.486
#' )
#' @noRd
HCCDetail <- S7::new_class(
  "HCCDetail",
  properties = list(
    hcc = S7::class_character,
    label = S7::class_character,
    is_chronic = S7::class_logical,
    coefficient = S7::class_double
  )
)

#' Health Care Plan coverage period from HD loop
#'
#' @param start_date `<date>` coverage start date
#' @param end_date `<date>` coverage start date
#' @param hcp_code `<chr>` HCP code
#' @param hcp_status `<chr>` HCP status
#' @param aid_codes `<chr>` REF*CE composite
#' @returns A <HCPCoveragePeriod> S7 object
#' @examplesIf FALSE
#' HCPCoveragePeriod()
#' @noRd
HCPCoveragePeriod <- S7::new_class(
  "HCPCoveragePeriod",
  properties = list(
    start_date = S7::new_property(S7::class_Date, default = Sys.Date()),
    end_date = S7::new_property(S7::class_Date, default = Sys.Date() + 1L),
    hcp_code = S7::class_character,
    hcp_status = S7::class_character,
    aid_codes = S7::class_character
  )
)

#' Response model for demographic categorization
#'
#' @param version `<chr>` Version of categorization to use ("V2", "V4", "V6")
#' @param age `<int>` Beneficiary age (floored to `integer`)
#' @param sex `<chr>` Beneficiary sex (M/F or 1/2)
#' @param dual_code `<chr>` Dual eligibility code ("00" - "10")
#' @param orec_code `<chr>` Original reason for entitlement code ("0" - "3")
#' @param crec_code `<chr>` Current reason for entitlement code ("0" - "3")
#' @param new_enrollee `<lgl>` Beneficiary is a **New Enrollee**
#' @param has_snp `<lgl>` Beneficiary is in a **Special Needs Plan**
#' @param non_aged `<lgl>` `TRUE` if `age <= 64`
#' @param dis_orig `<lgl>` `TRUE` if originally disabled (`OREC == "1"`) and not currently disabled
#' @param dis_curr `<lgl>` `TRUE` if currently disabled (`age < 65 & OREC != "0"`)
#' @param dual_full `<lgl>` `TRUE` if FBD (FBD Model)
#' @param dual_part `<lgl>` `TRUE` if PBD (PBD Model)
#' @param has_esrd `<lgl>` `TRUE` if ESRD (ESRD Model)
#' @param is_lti `<lgl>` `TRUE` if LTI (LTI Model)
#' @param low_income `<lgl>` Beneficiary is **Low Income** (RxHCC only)
#' @param esrd_months `<int>` Number of months since transplant (ESRD only)
#' @param category `<chr>` Age-sex category code
#' @returns A <Demographics> S7 object
#' @examplesIf FALSE
#' Demographics(age = 48, sex = "1", version = "V2")
#' Demographics(age = 35, sex = "M", version = "V6")
#' Demographics(age = 75, sex = "2", orec_code = "0", version = "V2")
#' @noRd
Demographics <- S7::new_class(
  "Demographics",
  properties = list(
    version = S7::class_character,
    age = S7::class_numeric,
    sex = S7::class_character,
    dual_code = S7::class_character,
    orec_code = S7::class_character,
    crec_code = S7::class_character,
    new_enrollee = S7::class_logical,
    has_snp = S7::class_logical,
    non_aged = S7::class_logical,
    dis_orig = S7::class_logical,
    dis_curr = S7::class_logical,
    dual_full = S7::class_logical,
    dual_part = S7::class_logical,
    has_esrd = S7::class_logical,
    is_lti = S7::class_logical,
    low_income = S7::class_logical,
    esrd_months = S7::class_integer,
    category = S7::class_character
  )
)

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
#' @noRd
ServiceLevelData <- function(
  claim_id = character(),
  procedure_code = character(),
  ndc = character(),
  linked_diagnosis_codes = character(),
  claim_diagnosis_codes = character(),
  claim_type = character(),
  provider_specialty = character(),
  performing_provider_npi = character(),
  billing_provider_npi = character(),
  patient_id = character(),
  facility_type = character(),
  service_type = character(),
  service_date = character(),
  place_of_service = character(),
  quantity = character(),
  quantity_unit = character(),
  modifiers = character(),
  allowed_amount = character()
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
#' @noRd
RAFResult <- function(
  risk_score = double(),
  risk_score_demographics = double(),
  risk_score_chronic_only = double(),
  risk_score_hcc = double(),
  risk_score_payment = double(),
  hcc_list = character(),
  hcc_details = character(),
  cc_to_dx = character(),
  coefficients = double(),
  interactions = character(),
  demographics = character(),
  model_name = character(),
  version = character(),
  diagnosis_codes = character(),
  service_level_data = character()
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

#' A single remittance line item within a member's payment record.
#'
#' Each RemittanceEntry corresponds to one RMR segment and its associated REF, DTM, and ADX segments within an ENT loop of an 820 transaction.
#'
#' @param reference_number Invoice/check reference number (RMR02)
#' @param payment_amount Net payment amount for this period; negative = recoupment (RMR04/05)
#' @param original_amount Original amount before adjustment, when present (RMR05/06)
#' @param rate_code Rate code from REF*18 (e.g., "957" = PACE rate)
#' @param aid_code California Medi-Cal aid code from REF*ZZ (e.g., "1H", "M1", "60")
#' @param plan_type Plan type from REF*ZZ composite aid_code;plan_type ("1" = primary/medical, "2" = pharmacy/state-only)
#' @param description Payment description from second REF*ZZ (e.g., "Primary Capitation Dual", "Medi-Cal Only-State Only")
#' @param coverage_period_start Coverage period begin date (YYYY-MM-DD) from DTM*582
#' @param coverage_period_end Coverage period end date (YYYY-MM-DD) from DTM*582
#' @param adjustment_amount Adjustment amount from ADX01 (negative = recoupment)
#' @param adjustment_reason Adjustment reason code from ADX02 (e.g., "53" = prior period)
#' @returns A <RemittanceEntry> object
#' @examplesIf FALSE
#' RemittanceEntry()
#' @noRd
RemittanceEntry <- function(
  reference_number = character(),
  payment_amount = double(),
  original_amount = double(),
  rate_code = character(),
  aid_code = character(),
  plan_type = character(),
  description = character(),
  coverage_period_start = character(),
  coverage_period_end = character(),
  adjustment_amount = double(),
  adjustment_reason = character()
) {
  list(
    reference_number = reference_number,
    payment_amount = payment_amount,
    original_amount = original_amount,
    rate_code = rate_code,
    aid_code = aid_code,
    plan_type = plan_type,
    description = description,
    coverage_period_start = coverage_period_start,
    coverage_period_end = coverage_period_end,
    adjustment_amount = adjustment_amount,
    adjustment_reason = adjustment_reason
  )
}

#' Per-Member Payment Record from an X12 820 ENT Loop
#'
#' One PaymentDetail is created per ENT segment. A member may appear in multiple
#' ENT entries within the same transaction (e.g., retroactive adjustments for
#' prior periods).
#'
#' @param entity_number ENT sequence number (ENT01)
#' @param member_id Member identifier from NM109
#' @param last_name Member last name (NM103)
#' @param first_name Member first name (NM104)
#' @param middle_name Member middle name (NM105)
#' @param remittance_entries List of remittance line items (one per RMR/DTM set)
#' @returns A <PaymentDetail> object
#' @examplesIf FALSE
#' PaymentDetail()
#' @noRd
PaymentDetail <- function(
  entity_number = character(),
  member_id = character(),
  last_name = character(),
  first_name = character(),
  middle_name = character(),
  remittance_entries = character()
) {
  list(
    entity_number = entity_number,
    member_id = member_id,
    last_name = last_name,
    first_name = first_name,
    middle_name = middle_name,
    remittance_entries = remittance_entries
  )
}

#' Remittance Data from an X12 820 Transaction
#'
#' Represents one ST*820 transaction, typically a capitation payment remittance
#' from a state Medicaid agency or CMS to a managed care plan.
#'
#' @param source Interchange sender ID (ISA06), e.g., "CALIFORNIA-DHCS"
#' @param report_date Transaction date from GS04 (YYYY-MM-DD)
#' @param total_amount Total payment amount from BPR02
#' @param payment_date EFT effective date from BPR16 (YYYY-MM-DD)
#' @param check_number EFT/check trace number from TRN02
#' @param payee_name Receiving organization name (N1*PE)
#' @param payee_address_1 Payee street address (N3)
#' @param payee_city Payee city (N4)
#' @param payee_state Payee state (N4)
#' @param payee_zip Payee ZIP code (N4)
#' @param payer_name Paying organization name (N1*PR)
#' @param payer_address_1 Payer street address (N3)
#' @param payer_city Payer city (N4)
#' @param payer_state Payer state (N4)
#' @param payer_zip Payer ZIP code (N4)
#' @param members List of per-member payment records
#' @returns A <PaymentData> object
#' @examplesIf FALSE
#' PaymentData()
#' @noRd
PaymentData <- function(
  source = character(),
  report_date = character(),
  total_amount = double(),
  payment_date = character(),
  check_number = character(),
  payee_name = character(),
  payee_address_1 = character(),
  payee_city = character(),
  payee_state = character(),
  payee_zip = character(),
  payer_name = character(),
  payer_address_1 = character(),
  payer_city = character(),
  payer_state = character(),
  payer_zip = character(),
  members = character()
) {
  list(
    source = source,
    report_date = report_date,
    total_amount = total_amount,
    payment_date = payment_date,
    check_number = check_number,
    payee_name = payee_name,
    payee_address_1 = payee_address_1,
    payee_city = payee_city,
    payee_state = payee_state,
    payee_zip = payee_zip,
    payer_name = payer_name,
    payer_address_1 = payer_address_1,
    payer_city = payer_city,
    payer_state = payer_state,
    payer_zip = payer_zip,
    members = members
  )
}

#' Enrollment Data from 834 Transactions
#'
#' Data needed for risk adjustment and Medicaid coverage tracking.
#' Supports California DHCS Medi-Cal 834 format with FAME fields.
#'
#' @param source Interchange sender ID (ISA06)
#' @param report_date Transaction date (GS04)
#' @param member_id Unique identifier for the member (REF*0F)
#' @param mbi Medicare Beneficiary Identifier (REF*6P)
#' @param medicaid_id Medicaid/Medi-Cal ID number (REF*23)
#' @param hic Medicare HICN (REF*F6)
#' @param cin Client Index Number from REF*3H
#' @param cin_check_digit CIN check digit from REF*3H
#' @param first_name Member first name (NM104)
#' @param last_name Member last name (NM103)
#' @param middle_name Member middle name (NM105)
#' @param dob Date of birth (YYYY-MM-DD)
#' @param age Calculated age
#' @param sex Member sex (M/F)
#' @param race Race/ethnicity code (DMG05)
#' @param language Preferred language (LUI02)
#' @param death_date Date of death if applicable
#' @param address_1 Street address line 1 (N301)
#' @param address_2 Street address line 2 (N302)
#' @param city City (N401)
#' @param state State code (N402)
#' @param zip Postal code (N403)
#' @param phone Phone number (PER04)
#' @param maintenance_type 001 = Change, 021 = Add, 024 = Cancel, 025 = Reinstate (INS03)
#' @param maintenance_reason_code Maintenance reason (INS04)
#' @param benefit_status_code A=Active, C=COBRA, etc. (INS05)
#' @param coverage_start_date Coverage effective date
#' @param coverage_end_date Coverage termination date
#' @param has_medicare Member has Medicare coverage
#' @param has_medicaid Member has Medicaid coverage
#' @param dual_elgbl_cd Dual eligibility status code ('00','01'-'08')
#' @param is_full_benefit_dual Full Benefit Dual (uses CFA_/CFD_ prefix)
#' @param is_partial_benefit_dual Partial Benefit Dual (uses CPA_/CPD_ prefix)
#' @param medicare_status_code QMB, SLMB, QI, QDWI, etc.
#' @param medi_cal_aid_code California Medi-Cal aid code
#' @param medi_cal_eligibility_status Medi-Cal eligibility status (Active/Terminated/None)
#' @param fame_county_id FAME county ID (REF*ZX or N4*CY)
#' @param case_number Case number (REF*1L)
#' @param fame_card_issue_date FAME card issue date
#' @param fame_redetermination_date FAME redetermination date (REF*17)
#' @param fame_death_date FAME death date
#' @param primary_aid_code Primary AID code (REF*RB)
#' @param carrier_code Carrier code
#' @param fed_contract_number Federal contract number
#' @param client_reporting_cat Client reporting category
#' @param res_addr_flag Residential address flag from REF*6O
#' @param reas_add_ind Reason address indicator from REF*6O
#' @param res_zip_deliv_code Residential zip delivery code
#' @param orec Original Reason for Entitlement Code
#' @param crec Current Reason for Entitlement Code
#' @param snp Special Needs Plan enrollment
#' @param low_income Low Income Subsidy (Part D)
#' @param lti Long-Term Institutionalized
#' @param new_enrollee New enrollee status (<= 3 months)
#' @param medicare_prt_a description
#' @param medicare_prt_b description
#' @param medicare_prt_d description
#' @param hcp_code Current HCP code (HD04 first part)
#' @param hcp_status Current HCP status (HD04 second part)
#' @param amount_qualifier AMT qualifier code (e.g., 'D' = premium, 'C1' = copay)
#' @param amount Premium or cost share amount (numeric)
#' @param hcp_history List of historical HCP coverage periods
#' @returns <EnrollmentData> object
#' @examplesIf FALSE
#' EnrollmentData()
#' @noRd
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
  coverage_start_date = character(),
  coverage_end_date = character(),
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
  hcp_history = character()
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
    coverage_start_date = coverage_start_date,
    coverage_end_date = coverage_end_date,
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
