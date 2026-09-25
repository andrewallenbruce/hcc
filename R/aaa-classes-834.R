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
