#' Health Care Plan Coverage Period
#'
#' @description
#' Health Care Plan coverage period from HD loop
#'
#' @param date_range `<Date>` coverage start date
#' @param hcp_code `<chr>` HCP code
#' @param hcp_status `<chr>` HCP status
#' @param aid_codes `<chr>` REF*CE composite
#' @returns An `<HCPCoveragePeriod>` S7 object
#' @examples
#' HCPCoveragePeriod(date_range = c("2026-08-20", "2026-08-25"))
#' @export
HCPCoveragePeriod := S7::new_class(
  properties = list(
    date_range = prop_date_range,
    hcp_code = S7::class_character,
    hcp_status = S7::class_character,
    aid_codes = S7::class_character
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
#' @param address `N3-01` Street address line 1
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
#' @param coverage_period Coverage effective date range
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
#' @param hcp_history List of `<HCPCoveragePeriod>`, historical HCP coverage
#'   periods
#' @returns An `<hcc::EnrollmentData>` S7 object
#' @examples
#' EnrollmentData()
#' @export
EnrollmentData := S7::new_class(
  properties = list(
    source = S7::class_character,
    report_date = prop_date,
    member_id = S7::class_character,
    mbi = S7::class_character,
    medicaid_id = S7::class_character,
    hic = prop_integer,
    cin = prop_integer,
    cin_check_digit = prop_integer,
    first_name = S7::class_character,
    last_name = S7::class_character,
    middle_name = S7::class_character,
    dob = prop_date,
    age = prop_integer,
    sex = S7::class_character,
    race = S7::class_character,
    language = S7::class_character,
    death_date = prop_date,
    address = S7::class_character,
    city = S7::class_character,
    state = S7::class_character,
    zip = S7::class_character,
    phone = S7::class_character,
    maintenance_type = S7::class_character,
    maintenance_reason_code = S7::class_character,
    benefit_status_code = S7::class_character,
    coverage_period = prop_date_range,
    has_medicare = S7::class_logical,
    has_medicaid = S7::class_logical,
    dual_elgbl_cd = S7::class_character,
    is_full_benefit_dual = S7::class_logical,
    is_partial_benefit_dual = S7::class_logical,
    medicare_status_code = S7::class_character,
    medi_cal_aid_code = S7::class_character,
    medi_cal_eligibility_status = S7::class_character,
    fame_county_id = S7::class_character,
    case_number = S7::class_character,
    fame_card_issue_date = prop_date,
    fame_redetermination_date = prop_date,
    fame_death_date = prop_date,
    primary_aid_code = S7::class_character,
    carrier_code = S7::class_character,
    fed_contract_number = S7::class_character,
    client_reporting_cat = S7::class_character,
    res_addr_flag = S7::class_character,
    reas_add_ind = S7::class_character,
    res_zip_deliv_code = S7::class_character,
    orec = S7::class_character,
    crec = S7::class_character,
    snp = S7::class_logical,
    low_income = S7::class_logical,
    lti = S7::class_logical,
    new_enrollee = S7::class_logical,
    medicare_prt_a = S7::class_logical,
    medicare_prt_b = S7::class_logical,
    medicare_prt_d = S7::class_logical,
    hcp_code = S7::class_character,
    hcp_status = S7::class_character,
    amount_qualifier = S7::class_character,
    amount = prop_double,
    hcp_history = prop_list_of(HCPCoveragePeriod)
  )
)
