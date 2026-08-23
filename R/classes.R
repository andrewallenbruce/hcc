#' HCC Category Detail
#'
#' @param hcc `<chr>` HCC code (e.g., "18", "85")
#' @param label `<chr>` Human-readable description (e.g., "Diabetes with Chronic
#'   Complications")
#' @param is_chronic `<lgl>` Whether this HCC is considered a chronic condition
#' @param coefficient `<dbl>` The coefficient value applied for this HCC in the
#'   RAF calculation
#' @returns An `<HCCDetail>` S7 object
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
#' @returns An `<HCPCoveragePeriod>` S7 object
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

#' Patient Demographics Categorization
#'
#' @param version `<chr>` Version of categorization to use (`V2`, `V4`, `V6`)
#' @param age `<num>` Beneficiary age
#' @param sex `<chr>` Beneficiary sex (`M`/`F` or `1`/`2`)
#' @param dual_code `<chr>` Dual eligibility code (`00` - `10`)
#' @param orec_code `<chr>` Original reason for entitlement (`0` - `3`)
#' @param crec_code `<chr>` Current reason for entitlement (`0` - `3`)
#' @param new_enrollee `<lgl>` Beneficiary is a **New Enrollee**
#' @param has_snp `<lgl>` Beneficiary is in a **Special Needs Plan**
#' @param non_aged `<lgl>` `TRUE` if `age <= 64`
#' @param dis_orig `<lgl>` `TRUE` if originally disabled (`OREC == "1"`) and not currently disabled
#' @param dis_curr `<lgl>` `TRUE` if currently disabled (`age < 65 & OREC != "0"`)
#' @param dual_full `<lgl>` `TRUE` if FBD *(FBD Model)*
#' @param dual_part `<lgl>` `TRUE` if PBD *(PBD Model)*
#' @param has_esrd `<lgl>` `TRUE` if ESRD *(ESRD Model)*
#' @param is_lti `<lgl>` `TRUE` if LTI *(LTI Model)*
#' @param low_income `<lgl>` Beneficiary is **Low Income** *(RxHCC only)*
#' @param esrd_months `<int>` Number of months since transplant *(ESRD only)*
#' @param category `<chr>` Age-sex category code
#' @returns A `<PatientDemographics>` S7 object
#' @examplesIf FALSE
#' PatientDemographics(age = 48, sex = "1", version = "V2")
#' PatientDemographics(age = 35, sex = "M", version = "V6")
#' PatientDemographics(age = 75, sex = "2", orec_code = "0", version = "V2")
#' @noRd
PatientDemographics <- S7::new_class(
  "PatientDemographics",
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

#' Healthcare Claim Service Level Data
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
#' @returns A `<ServiceLevelData>` S7 object
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
#' @returns A `<RAFResult>` S7 object
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
#' @param reference_number `RMR-02` Invoice/check reference number
#' @param payment_amount `RMR-04/RMR-05` Net payment amount for this period; negative = recoupment
#' @param original_amount `RMR-05/RMR-06` Original amount before adjustment, when present
#' @param rate_code `REF*18` Rate code (e.g., "957" = PACE rate)
#' @param aid_code `REF*ZZ` California Medi-Cal aid code (e.g., "1H", "M1", "60")
#' @param plan_type `REF*ZZ` Plan type - composite aid_code;plan_type ("1" = primary/medical, "2" = pharmacy/state-only)
#' @param description `REF*ZZ` Payment description (e.g., "Primary Capitation Dual", "Medi-Cal Only-State Only")
#' @param coverage_period_start `DTM*582` Coverage period begin date (YYYY-MM-DD)
#' @param coverage_period_end `DTM*582` Coverage period end date (YYYY-MM-DD) from DTM*582
#' @param adjustment_amount `ADX-01` Adjustment amount (negative = recoupment)
#' @param adjustment_reason `ADX-02` Adjustment reason code (e.g., "53" = prior period)
#' @returns A `<RemittanceEntry>` S7 object
#' @examplesIf FALSE
#' RemittanceEntry()
#' @export
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
#' @param entity_number `ENT-01` ENT sequence number
#' @param member_id `NM1-09` Member identifier
#' @param last_name `NM1-03` Member last name
#' @param first_name `NM1-04` Member first name
#' @param middle_name `NM1-05` Member middle name
#' @param remittance_entries List of `<RemittanceEntry>` line items (one per RMR/DTM set)
#' @returns A `<PaymentDetail>` S7 object
#' @examplesIf FALSE
#' PaymentDetail()
#' @export
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

#' X12-820 Transaction Remittance Data
#'
#' Represents one ST*820 transaction, typically a capitation payment remittance
#' from a state Medicaid agency or CMS to a managed care plan.
#'
#' @param source `ISA-06` Interchange sender ID, e.g., "CALIFORNIA-DHCS"
#' @param report_date `GS-04` Transaction date (YYYY-MM-DD)
#' @param total_amount `BPR-02` Total payment amount
#' @param payment_date `BPR-16` EFT effective date (YYYY-MM-DD)
#' @param check_number `TRN-02` EFT/check trace number
#' @param payee_name `N1*PE` Receiving organization name
#' @param payee_address_1 `N3` Payee street address
#' @param payee_city `N4` Payee city
#' @param payee_state `N4` Payee state
#' @param payee_zip `N4` Payee ZIP code
#' @param payer_name `N1*PR` Paying organization name
#' @param payer_address_1 `N3` Payer street address
#' @param payer_city `N4` Payer city
#' @param payer_state `N4` Payer state
#' @param payer_zip `N4` Payer ZIP code
#' @param members List of per-member payment records
#' @returns A `<PaymentData>` S7 object
#' @examplesIf FALSE
#' PaymentData()
#' @export
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
#' @param maintenance_type `INS-03` Change (`001`), Add (`021`), Cancel (`024`), Reinstate (`025`)
#' @param maintenance_reason_code `INS-04` Maintenance reason
#' @param benefit_status_code `INS-05` A=Active, C=COBRA, etc.
#' @param coverage_start_date Coverage effective date
#' @param coverage_end_date Coverage termination date
#' @param has_medicare Member has Medicare coverage
#' @param has_medicaid Member has Medicaid coverage
#' @param dual_elgbl_cd Dual eligibility status code (`00`,`01`-`08`)
#' @param is_full_benefit_dual Full Benefit Dual (uses CFA_/CFD_ prefix)
#' @param is_partial_benefit_dual Partial Benefit Dual (uses CPA_/CPD_ prefix)
#' @param medicare_status_code QMB, SLMB, QI, QDWI, etc.
#' @param medi_cal_aid_code California Medi-Cal aid code
#' @param medi_cal_eligibility_status Medi-Cal eligibility status (Active/Terminated/None)
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
#' @param amount_qualifier AMT qualifier code (e.g., `D` = premium, `C1` = copay)
#' @param amount Premium or cost share amount (numeric)
#' @param hcp_history List of historical HCP coverage periods
#' @returns A `<EnrollmentData>` S7 object
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
