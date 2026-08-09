# Enrollment Data from 834 Transactions

Data needed for risk adjustment and Medicaid coverage tracking. Supports
California DHCS Medi-Cal 834 format with FAME fields.

## Usage

``` r
EnrollmentData(
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
)
```

## Arguments

- source:

  Interchange sender ID (ISA06)

- report_date:

  Transaction date (GS04)

- member_id:

  Unique identifier for the member (REF\*0F)

- mbi:

  Medicare Beneficiary Identifier (REF\*6P)

- medicaid_id:

  Medicaid/Medi-Cal ID number (REF\*23)

- hic:

  Medicare HICN (REF\*F6)

- cin:

  Client Index Number from REF\*3H

- cin_check_digit:

  CIN check digit from REF\*3H

- first_name:

  Member first name (NM104)

- last_name:

  Member last name (NM103)

- middle_name:

  Member middle name (NM105)

- dob:

  Date of birth (YYYY-MM-DD)

- age:

  Calculated age

- sex:

  Member sex (M/F)

- race:

  Race/ethnicity code (DMG05)

- language:

  Preferred language (LUI02)

- death_date:

  Date of death if applicable

- address_1:

  Street address line 1 (N301)

- address_2:

  Street address line 2 (N302)

- city:

  City (N401)

- state:

  State code (N402)

- zip:

  Postal code (N403)

- phone:

  Phone number (PER04)

- maintenance_type:

  001 = Change, 021 = Add, 024 = Cancel, 025 = Reinstate (INS03)

- maintenance_reason_code:

  Maintenance reason (INS04)

- benefit_status_code:

  A=Active, C=COBRA, etc. (INS05)

- coverage_start_date:

  Coverage effective date

- coverage_end_date:

  Coverage termination date

- has_medicare:

  Member has Medicare coverage

- has_medicaid:

  Member has Medicaid coverage

- dual_elgbl_cd:

  Dual eligibility status code ('00','01'-'08')

- is_full_benefit_dual:

  Full Benefit Dual (uses CFA\_/CFD\_ prefix)

- is_partial_benefit_dual:

  Partial Benefit Dual (uses CPA\_/CPD\_ prefix)

- medicare_status_code:

  QMB, SLMB, QI, QDWI, etc.

- medi_cal_aid_code:

  California Medi-Cal aid code

- medi_cal_eligibility_status:

  Medi-Cal eligibility status (Active/Terminated/None)

- fame_county_id:

  FAME county ID (REF*ZX or N4*CY)

- case_number:

  Case number (REF\*1L)

- fame_card_issue_date:

  FAME card issue date

- fame_redetermination_date:

  FAME redetermination date (REF\*17)

- fame_death_date:

  FAME death date

- primary_aid_code:

  Primary AID code (REF\*RB)

- carrier_code:

  Carrier code

- fed_contract_number:

  Federal contract number

- client_reporting_cat:

  Client reporting category

- res_addr_flag:

  Residential address flag from REF\*6O

- reas_add_ind:

  Reason address indicator from REF\*6O

- res_zip_deliv_code:

  Residential zip delivery code

- orec:

  Original Reason for Entitlement Code

- crec:

  Current Reason for Entitlement Code

- snp:

  Special Needs Plan enrollment

- low_income:

  Low Income Subsidy (Part D)

- lti:

  Long-Term Institutionalized

- new_enrollee:

  New enrollee status (\<= 3 months)

- medicare_prt_a:

  description

- medicare_prt_b:

  description

- medicare_prt_d:

  description

- hcp_code:

  Current HCP code (HD04 first part)

- hcp_status:

  Current HCP status (HD04 second part)

- amount_qualifier:

  AMT qualifier code (e.g., 'D' = premium, 'C1' = copay)

- amount:

  Premium or cost share amount (numeric)

- hcp_history:

  List of historical HCP coverage periods

## Value

object

## Examples

``` r
EnrollmentData()
#> $source
#> character(0)
#> 
#> $report_date
#> character(0)
#> 
#> $member_id
#> character(0)
#> 
#> $mbi
#> character(0)
#> 
#> $medicaid_id
#> character(0)
#> 
#> $hic
#> character(0)
#> 
#> $cin
#> character(0)
#> 
#> $cin_check_digit
#> integer(0)
#> 
#> $first_name
#> character(0)
#> 
#> $last_name
#> character(0)
#> 
#> $middle_name
#> character(0)
#> 
#> $dob
#> character(0)
#> 
#> $age
#> integer(0)
#> 
#> $sex
#> character(0)
#> 
#> $race
#> character(0)
#> 
#> $language
#> character(0)
#> 
#> $death_date
#> character(0)
#> 
#> $address_1
#> character(0)
#> 
#> $address_2
#> character(0)
#> 
#> $city
#> character(0)
#> 
#> $state
#> character(0)
#> 
#> $zip
#> character(0)
#> 
#> $phone
#> character(0)
#> 
#> $maintenance_type
#> character(0)
#> 
#> $maintenance_reason_code
#> character(0)
#> 
#> $benefit_status_code
#> character(0)
#> 
#> $coverage_start_date
#> character(0)
#> 
#> $coverage_end_date
#> character(0)
#> 
#> $has_medicare
#> logical(0)
#> 
#> $has_medicaid
#> logical(0)
#> 
#> $dual_elgbl_cd
#> character(0)
#> 
#> $is_full_benefit_dual
#> logical(0)
#> 
#> $is_partial_benefit_dual
#> logical(0)
#> 
#> $medicare_status_code
#> character(0)
#> 
#> $medi_cal_aid_code
#> character(0)
#> 
#> $medi_cal_eligibility_status
#> character(0)
#> 
#> $fame_county_id
#> character(0)
#> 
#> $case_number
#> character(0)
#> 
#> $fame_card_issue_date
#> character(0)
#> 
#> $fame_redetermination_date
#> character(0)
#> 
#> $fame_death_date
#> character(0)
#> 
#> $primary_aid_code
#> character(0)
#> 
#> $carrier_code
#> character(0)
#> 
#> $fed_contract_number
#> character(0)
#> 
#> $client_reporting_cat
#> character(0)
#> 
#> $res_addr_flag
#> character(0)
#> 
#> $reas_add_ind
#> character(0)
#> 
#> $res_zip_deliv_code
#> character(0)
#> 
#> $orec
#> character(0)
#> 
#> $crec
#> character(0)
#> 
#> $snp
#> logical(0)
#> 
#> $low_income
#> logical(0)
#> 
#> $lti
#> logical(0)
#> 
#> $new_enrollee
#> logical(0)
#> 
#> $medicare_prt_a
#> logical(0)
#> 
#> $medicare_prt_b
#> logical(0)
#> 
#> $medicare_prt_d
#> logical(0)
#> 
#> $hcp_code
#> character(0)
#> 
#> $hcp_status
#> character(0)
#> 
#> $amount_qualifier
#> character(0)
#> 
#> $amount
#> numeric(0)
#> 
#> $hcp_history
#> character(0)
#> 
```
