# X12-834 Transaction Enrollment Data

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
  hcp_history = HCPCoveragePeriod()
)
```

## Arguments

- source:

  `ISA-06` Interchange sender ID

- report_date:

  `GS-04` Transaction date

- member_id:

  `REF*0F` Unique identifier for the member

- mbi:

  `REF*6P` Medicare Beneficiary Identifier

- medicaid_id:

  `REF*23` Medicaid/Medi-Cal ID number

- hic:

  `REF*F6` Medicare HICN

- cin:

  `REF*3H` Client Index Number

- cin_check_digit:

  `REF*3H` CIN check digit

- first_name:

  `NM1-04` Member first name

- last_name:

  `NM1-03` Member last name

- middle_name:

  `NM1-05` Member middle name

- dob:

  Date of birth (YYYY-MM-DD)

- age:

  Calculated age

- sex:

  Member sex (M/F)

- race:

  `DMG-05` Race/ethnicity code

- language:

  `LUI-02` Preferred language

- death_date:

  Date of death if applicable

- address_1:

  `N3-01` Street address line 1

- address_2:

  `N3-02` Street address line 2

- city:

  `N4-01` City

- state:

  `N4-02` State code

- zip:

  `N4-03` Postal code

- phone:

  `PER-04` Phone number

- maintenance_type:

  `INS-03` Change (`001`), Add (`021`), Cancel (`024`), Reinstate
  (`025`)

- maintenance_reason_code:

  `INS-04` Maintenance reason

- benefit_status_code:

  `INS-05` A=Active, C=COBRA, etc.

- coverage_start_date:

  Coverage effective date

- coverage_end_date:

  Coverage termination date

- has_medicare:

  Member has Medicare coverage

- has_medicaid:

  Member has Medicaid coverage

- dual_elgbl_cd:

  Dual eligibility status code (`00`,`01`-`08`)

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

  FAME county ID (`REF*ZX` or `N4*CY`)

- case_number:

  Case number (`REF*1L`)

- fame_card_issue_date:

  FAME card issue date

- fame_redetermination_date:

  FAME redetermination date (`REF*17`)

- fame_death_date:

  FAME death date

- primary_aid_code:

  Primary AID code (`REF*RB`)

- carrier_code:

  Carrier code

- fed_contract_number:

  Federal contract number

- client_reporting_cat:

  Client reporting category

- res_addr_flag:

  Residential address flag from `REF*6O`

- reas_add_ind:

  Reason address indicator from `REF*6O`

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

  New enrollee status (`<= 3 months`)

- medicare_prt_a:

  description

- medicare_prt_b:

  description

- medicare_prt_d:

  description

- hcp_code:

  Current HCP code (`HD-04` first part)

- hcp_status:

  Current HCP status (`HD-04` second part)

- amount_qualifier:

  AMT qualifier code (e.g., `D` = premium, `C1` = copay)

- amount:

  Premium or cost share amount (numeric)

- hcp_history:

  `<HCPCoveragePeriod>` List of historical HCP coverage periods

## Value

A `<EnrollmentData>` S7 object

## Examples

``` r
if (FALSE) {
EnrollmentData()
}
```
