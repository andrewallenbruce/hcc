# X12-834 Transaction Enrollment Data

Data needed for risk adjustment and Medicaid coverage tracking. Supports
California DHCS Medi-Cal 834 format with FAME fields.

## Usage

``` r
EnrollmentData(
  source = character(0),
  report_date = .Date(numeric(0L)),
  member_id = character(0),
  mbi = character(0),
  medicaid_id = character(0),
  hic = integer(0),
  cin = integer(0),
  cin_check_digit = integer(0),
  first_name = character(0),
  last_name = character(0),
  middle_name = character(0),
  dob = .Date(numeric(0L)),
  age = integer(0),
  sex = character(0),
  race = character(0),
  language = character(0),
  death_date = .Date(numeric(0L)),
  address = character(0),
  city = character(0),
  state = character(0),
  zip = character(0),
  phone = character(0),
  maintenance_type = character(0),
  maintenance_reason_code = character(0),
  benefit_status_code = character(0),
  coverage_period = c(.Date(numeric(0L)), .Date(numeric(0L))),
  has_medicare = logical(0),
  has_medicaid = logical(0),
  dual_elgbl_cd = character(0),
  is_full_benefit_dual = logical(0),
  is_partial_benefit_dual = logical(0),
  medicare_status_code = character(0),
  medi_cal_aid_code = character(0),
  medi_cal_eligibility_status = character(0),
  fame_county_id = character(0),
  case_number = character(0),
  fame_card_issue_date = .Date(numeric(0L)),
  fame_redetermination_date = .Date(numeric(0L)),
  fame_death_date = .Date(numeric(0L)),
  primary_aid_code = character(0),
  carrier_code = character(0),
  fed_contract_number = character(0),
  client_reporting_cat = character(0),
  res_addr_flag = character(0),
  reas_add_ind = character(0),
  res_zip_deliv_code = character(0),
  orec = character(0),
  crec = character(0),
  snp = logical(0),
  low_income = logical(0),
  lti = logical(0),
  new_enrollee = logical(0),
  medicare_prt_a = logical(0),
  medicare_prt_b = logical(0),
  medicare_prt_d = logical(0),
  hcp_code = character(0),
  hcp_status = character(0),
  amount_qualifier = character(0),
  amount = numeric(0),
  hcp_history = list()
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

- address:

  `N3-01` Street address line 1

- city:

  `N4-01` City

- state:

  `N4-02` State code

- zip:

  `N4-03` Postal code

- phone:

  `PER-04` Phone number

- maintenance_type:

  `INS-03`

  - Change (`001`)

  - Add (`021`)

  - Cancel (`024`)

  - Reinstate (`025`)

- maintenance_reason_code:

  `INS-04` Maintenance reason

- benefit_status_code:

  `INS-05` A=Active, C=COBRA, etc.

- coverage_period:

  Coverage effective date range

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

  List of `<HCPCoveragePeriod>`, historical HCP coverage periods

## Value

An `<hcc::EnrollmentData>` S7 object

## Examples

``` r
EnrollmentData()
#> <hcc::EnrollmentData>
#>  @ source                     : chr(0) 
#>  @ report_date                : 'Date' num(0) 
#>  @ member_id                  : chr(0) 
#>  @ mbi                        : chr(0) 
#>  @ medicaid_id                : chr(0) 
#>  @ hic                        : int(0) 
#>  @ cin                        : int(0) 
#>  @ cin_check_digit            : int(0) 
#>  @ first_name                 : chr(0) 
#>  @ last_name                  : chr(0) 
#>  @ middle_name                : chr(0) 
#>  @ dob                        : 'Date' num(0) 
#>  @ age                        : int(0) 
#>  @ sex                        : chr(0) 
#>  @ race                       : chr(0) 
#>  @ language                   : chr(0) 
#>  @ death_date                 : 'Date' num(0) 
#>  @ address                    : chr(0) 
#>  @ city                       : chr(0) 
#>  @ state                      : chr(0) 
#>  @ zip                        : chr(0) 
#>  @ phone                      : chr(0) 
#>  @ maintenance_type           : chr(0) 
#>  @ maintenance_reason_code    : chr(0) 
#>  @ benefit_status_code        : chr(0) 
#>  @ coverage_period            : iv<date> [1:1] [NA, NA)
#>  @ has_medicare               : logi(0) 
#>  @ has_medicaid               : logi(0) 
#>  @ dual_elgbl_cd              : chr(0) 
#>  @ is_full_benefit_dual       : logi(0) 
#>  @ is_partial_benefit_dual    : logi(0) 
#>  @ medicare_status_code       : chr(0) 
#>  @ medi_cal_aid_code          : chr(0) 
#>  @ medi_cal_eligibility_status: chr(0) 
#>  @ fame_county_id             : chr(0) 
#>  @ case_number                : chr(0) 
#>  @ fame_card_issue_date       : 'Date' num(0) 
#>  @ fame_redetermination_date  : 'Date' num(0) 
#>  @ fame_death_date            : 'Date' num(0) 
#>  @ primary_aid_code           : chr(0) 
#>  @ carrier_code               : chr(0) 
#>  @ fed_contract_number        : chr(0) 
#>  @ client_reporting_cat       : chr(0) 
#>  @ res_addr_flag              : chr(0) 
#>  @ reas_add_ind               : chr(0) 
#>  @ res_zip_deliv_code         : chr(0) 
#>  @ orec                       : chr(0) 
#>  @ crec                       : chr(0) 
#>  @ snp                        : logi(0) 
#>  @ low_income                 : logi(0) 
#>  @ lti                        : logi(0) 
#>  @ new_enrollee               : logi(0) 
#>  @ medicare_prt_a             : logi(0) 
#>  @ medicare_prt_b             : logi(0) 
#>  @ medicare_prt_d             : logi(0) 
#>  @ hcp_code                   : chr(0) 
#>  @ hcp_status                 : chr(0) 
#>  @ amount_qualifier           : chr(0) 
#>  @ amount                     : num(0) 
#>  @ hcp_history                : list()
```
