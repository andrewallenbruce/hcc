#' Single Edit Rule
#'
#' @param edit_type `<chr>` "sex" or "age"
#' @param sex `<int>` For sex edits: 1 (male) or 2 (female)
#' @param age_min `<int>` For age edits: minimum age (inclusive)
#' @param age_max `<int>` For age edits: maximum age (inclusive)
#' @param action `<chr>` "invalid" or "override"
#' @param cc_override `<int>` CC to assign when `action = "override"`
#' @returns An `<EditRule>` S7 object
#' @examples
#' EditRule(
#'   edit_type = "age",
#'   sex = 2L,
#'   action = "invalid",
#'   age_max = 16L,
#'   age_min = 15L,
#'   cc_override = 13L
#' )
#' @export
EditRule <- S7::new_class(
  "EditRule",
  properties = list(
    edit_type = S7::class_character,
    sex = S7::class_integer,
    age_min = S7::class_integer,
    age_max = S7::class_integer,
    action = S7::class_character,
    cc_override = S7::class_integer
  ),
  validator = function(self) {
    if (!rlang::is_empty(self@edit_type)) {
      if (length(self@edit_type) != 1L) {
        return("@edit_type must be length 1")
      }
      if (!self@edit_type %in% c("sex", "age")) {
        return("@edit_type must be either `sex` or `age`")
      }
    }

    if (self@edit_type == "sex") {
      if (length(self@sex) != 1L) {
        return("@sex must be length 1")
      }
      if (!self@sex %in% 1:2) {
        return("@sex must be either `1` or `2`")
      }
    }

    if (self@edit_type == "age") {
      if (length(self@age_min) != 1L) {
        return("@age_min must be length 1")
      }
      if (length(self@age_max) != 1L) {
        return("@age_max must be length 1")
      }
      if (self@age_min >= self@age_max) {
        return("@age_min must be < @age_max")
      }
    }

    if (!rlang::is_empty(self@action)) {
      if (length(self@action) != 1L) {
        return("@action must be length 1")
      }
      if (!self@action %in% c("invalid", "override")) {
        return("@action must be either `invalid` or `override`")
      }

      if (self@action == "override") {
        if (rlang::is_empty(self@cc_override)) {
          return("@cc_override cannot be empty when @action = `override`")
        }
      }
    }
    if (!rlang::is_empty(self@cc_override)) {
      if (length(self@cc_override) != 1L) {
        return("@cc_override must be length 1")
      }
    }
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
#' @examples
#' HCCDetail( # HCC203
#'  hcc = 203L,
#'  label = "Coma, Brain Compression/Anoxic Damage",
#'  is_chronic = TRUE,
#'  coefficient = 0.486
#' )
#' @export
HCCDetail <- S7::new_class(
  "HCCDetail",
  properties = list(
    hcc = S7::class_integer,
    label = S7::class_character,
    is_chronic = S7::class_logical,
    coefficient = S7::class_double
  )
)

#' Health Care Plan coverage period from HD loop
#'
#' @param start_date `<Date>` coverage start date
#' @param end_date `<Date>` coverage start date
#' @param hcp_code `<chr>` HCP code
#' @param hcp_status `<chr>` HCP status
#' @param aid_codes `<chr>` REF*CE composite
#' @returns An `<HCPCoveragePeriod>` S7 object
#' @usage NULL
#' @examples
#' HCPCoveragePeriod(
#'   start_date = as.Date("2026-08-20"),
#'   end_date = as.Date("2026-08-25")
#'   )
#' @export
HCPCoveragePeriod <- S7::new_class(
  "HCPCoveragePeriod",
  properties = list(
    start_date = S7::as_class(S7::class_Date),
    end_date = S7::as_class(S7::class_Date),
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
#' @param dis_orig `<lgl>` `TRUE` if originally disabled (`OREC == "1"`) and not
#'   currently disabled
#' @param dis_curr `<lgl>` `TRUE` if currently disabled (`age < 65 & OREC !=
#'   "0"`)
#' @param dual_full `<lgl>` `TRUE` if FBD *(FBD Model)*
#' @param dual_part `<lgl>` `TRUE` if PBD *(PBD Model)*
#' @param has_esrd `<lgl>` `TRUE` if ESRD *(ESRD Model)*
#' @param is_lti `<lgl>` `TRUE` if LTI *(LTI Model)*
#' @param low_income `<lgl>` Beneficiary is **Low Income** *(RxHCC only)*
#' @param esrd_months `<int>` Number of months since transplant *(ESRD only)*
#' @param category `<chr>` Age-sex category code
#' @returns A `<PatientDemographics>` S7 object
#' @examples
#' PatientDemographics(age = 48, sex = "1", version = "V2")
#' PatientDemographics(age = 35, sex = "M", version = "V6")
#' PatientDemographics(age = 75, sex = "2", orec_code = "0", version = "V2")
#' @export
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
#' @param claim_id `<chr>` Unique identifier for the claim
#' @param procedure_code `<chr>` HCPCS code
#' @param ndc `<chr>` National Drug Code
#' @param linked_diagnosis_codes `<chr>` ICD-10 diagnosis codes linked to this
#'   service
#' @param claim_diagnosis_codes `<chr>` All diagnosis codes on the claim
#' @param claim_type `<chr>` Type of claim (e.g., NCH Claim Type Code, or 837I,
#'   837P)
#' @param provider_specialty `<chr>` Provider taxonomy or specialty code
#' @param performing_provider_npi `<int>` National Provider Identifier for
#'   performing provider
#' @param billing_provider_npi `<int>` National Provider Identifier for billing
#'   provider
#' @param patient_id `<chr>` Unique identifier for the patient
#' @param facility_type `<chr>` Type of facility where service was rendered
#' @param service_type `<chr>` Type of service provided (facility type + service
#'   type = Type of Bill)
#' @param service_date `<Date>` Date service was performed (YYYY-MM-DD)
#' @param place_of_service `<chr>` Place of service code
#' @param quantity `<int>` Number of units provided
#' @param quantity_unit `<chr>` Unit of measure for quantity
#' @param modifiers `<chr>` List of procedure code modifiers
#' @param allowed_amount `<dbl>` Allowed amount for the service
#' @returns A `<ServiceLevelData>` S7 object
#' @examples
#' ServiceLevelData()
#' @export
ServiceLevelData <- S7::new_class(
  "ServiceLevelData",
  properties = list(
    claim_id = S7::class_character,
    procedure_code = S7::class_character,
    ndc = S7::class_character,
    linked_diagnosis_codes = S7::class_character,
    claim_diagnosis_codes = S7::class_character,
    claim_type = S7::class_character,
    provider_specialty = S7::class_character,
    performing_provider_npi = S7::class_integer,
    billing_provider_npi = S7::class_integer,
    patient_id = S7::class_character,
    facility_type = S7::class_character,
    service_type = S7::class_character,
    service_date = S7::class_character,
    place_of_service = S7::class_character,
    quantity = S7::class_integer,
    quantity_unit = S7::class_character,
    modifiers = S7::class_character,
    allowed_amount = S7::class_double
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
#' @examples
#' RAFResult()
#' @export
RAFResult <- S7::new_class(
  "RAFResult",
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

#' Remittance Line Item
#'
#' A single remittance line item within a member's payment record.
#'
#' @details
#' Each RemittanceEntry corresponds to one RMR segment and its associated REF,
#' DTM, and ADX segments within an ENT loop of an 820 transaction.
#'
#' @param reference_number `<chr>` `RMR-02` Invoice/check reference number
#' @param payment_amount `<chr>` `RMR-04/RMR-05` Net payment amount for this
#'   period; negative = recoupment
#' @param original_amount `<chr>` `RMR-05/RMR-06` Original amount before
#'   adjustment (when present)
#' @param rate_code `<chr>` `REF*18` Rate code (e.g., "957" = PACE rate)
#' @param aid_code `<chr>` `REF*ZZ` California Medi-Cal aid code (e.g., "1H",
#'   "M1", "60")
#' @param plan_type `<chr>` `REF*ZZ` Plan type; Composite aid_code;plan_type
#'    - "1": primary/medical
#'    - "2" = pharmacy/state-only
#' @param description `<chr>` `REF*ZZ` Payment description (e.g., "Primary
#'   Capitation Dual", "Medi-Cal Only-State Only")
#' @param coverage_period_start `<Date>` `DTM*582` Coverage period begin date
#'   (YYYY-MM-DD)
#' @param coverage_period_end `<Date>` `DTM*582` Coverage period end date
#'   (YYYY-MM-DD) from DTM*582
#' @param adjustment_amount `<chr>` `ADX-01` Adjustment amount; If negative, it
#'   is a recoupment
#' @param adjustment_reason `<chr>` `ADX-02` Adjustment reason code ("53" =
#'   prior period)
#' @returns A `<RemittanceEntry>` S7 object
#' @examples
#' RemittanceEntry()
#' @export
RemittanceEntry <- S7::new_class(
  "RemittanceEntry",
  properties = list(
    reference_number = S7::class_character,
    payment_amount = S7::class_double,
    original_amount = S7::class_double,
    rate_code = S7::class_character,
    aid_code = S7::class_character,
    plan_type = S7::class_character,
    description = S7::class_character,
    coverage_period_start = S7::class_character,
    coverage_period_end = S7::class_character,
    adjustment_amount = S7::class_double,
    adjustment_reason = S7::class_character
  )
)

#' Per-Member Payment Record from an X12-820 ENT Loop
#'
#' One PaymentDetail is created per ENT segment. A member may
#' appear in multiple ENT entries within the same transaction
#' (e.g., retroactive adjustments for prior periods).
#'
#' @param entity_number `<chr>` `ENT-01` ENT sequence number
#' @param member_id `<chr>` `NM1-09` Member identifier
#' @param last_name `<chr>` `NM1-03` Member last name
#' @param first_name `<chr>` `NM1-04` Member first name
#' @param middle_name `<chr>` `NM1-05` Member middle name
#' @param remittance_entries List of `<RemittanceEntry>` line items (one per
#'   RMR/DTM set)
#' @returns A `<PaymentDetail>` S7 object
#' @examples
#' PaymentDetail()
#' @export
PaymentDetail <- S7::new_class(
  "PaymentDetail",
  properties = list(
    entity_number = S7::class_character,
    member_id = S7::class_character,
    last_name = S7::class_character,
    first_name = S7::class_character,
    middle_name = S7::class_character,
    remittance_entries = RemittanceEntry
  )
)

#' X12-820 Transaction Remittance Data
#'
#' Represents one ST*820 transaction, typically a capitation
#' payment remittance from a state Medicaid agency or CMS to
#' a managed care plan.
#'
#' @param source `<chr>` `ISA-06` Interchange sender ID, e.g., "CALIFORNIA-DHCS"
#' @param report_date `<Date>` `GS-04` Transaction date (YYYY-MM-DD)
#' @param total_amount `<chr>` `BPR-02` Total payment amount
#' @param payment_date `<Date>` `BPR-16` EFT effective date (YYYY-MM-DD)
#' @param check_number `<chr>` `TRN-02` EFT/check trace number
#' @param payee_name `<chr>` `N1*PE` Receiving organization name
#' @param payee_address_1 `<chr>` `N3` Payee street address
#' @param payee_city `<chr>` `N4` Payee city
#' @param payee_state `<chr>` `N4` Payee state
#' @param payee_zip `<chr>` `N4` Payee ZIP code
#' @param payer_name `<chr>` `N1*PR` Paying organization name
#' @param payer_address_1 `<chr>` `N3` Payer street address
#' @param payer_city `<chr>` `N4` Payer city
#' @param payer_state `<chr>` `N4` Payer state
#' @param payer_zip `<chr>` `N4` Payer ZIP code
#' @param members `<PaymentDetail>` List of per-member payment records
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
  members = PaymentDetail()
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
#' @param maintenance_type `INS-03` Change (`001`), Add (`021`), Cancel (`024`),
#'   Reinstate (`025`)
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
