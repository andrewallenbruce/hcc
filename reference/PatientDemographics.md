# Patient Demographics Categorization

Patient Demographics Categorization

## Usage

``` r
PatientDemographics(
  version = character(0),
  age = integer(0),
  sex = character(0),
  dual_code = character(0),
  orec_code = character(0),
  crec_code = character(0),
  new_enrollee = logical(0),
  has_snp = logical(0),
  non_aged = logical(0),
  dis_orig = logical(0),
  dis_curr = logical(0),
  dual_full = logical(0),
  dual_part = logical(0),
  has_esrd = logical(0),
  is_lti = logical(0),
  low_income = logical(0),
  esrd_months = integer(0),
  category = character(0)
)
```

## Arguments

- version:

  `<chr>` Version of categorization to use (`V2`, `V4`, `V6`)

- age:

  `<num>` Beneficiary age

- sex:

  `<chr>` Beneficiary sex (`M`/`F` or `1`/`2`)

- dual_code:

  `<chr>` Dual eligibility code (`00` - `10`)

- orec_code:

  `<chr>` Original reason for entitlement (`0` - `3`)

- crec_code:

  `<chr>` Current reason for entitlement (`0` - `3`)

- new_enrollee:

  `<lgl>` Beneficiary is a **New Enrollee**

- has_snp:

  `<lgl>` Beneficiary is in a **Special Needs Plan**

- non_aged:

  `<lgl>` `TRUE` if `age <= 64`

- dis_orig:

  `<lgl>` `TRUE` if originally disabled (`OREC == "1"`) and not
  currently disabled

- dis_curr:

  `<lgl>` `TRUE` if currently disabled (`age < 65 & OREC != "0"`)

- dual_full:

  `<lgl>` `TRUE` if FBD *(FBD Model)*

- dual_part:

  `<lgl>` `TRUE` if PBD *(PBD Model)*

- has_esrd:

  `<lgl>` `TRUE` if ESRD *(ESRD Model)*

- is_lti:

  `<lgl>` `TRUE` if LTI *(LTI Model)*

- low_income:

  `<lgl>` Beneficiary is **Low Income** *(RxHCC only)*

- esrd_months:

  `<int>` Number of months since transplant *(ESRD only)*

- category:

  `<chr>` Age-sex category code

## Value

A `<PatientDemographics>` S7 object

## Examples

``` r
PatientDemographics(age = 48, sex = "1", version = "V2")
#> <hcc::PatientDemographics>
#>  @ version     : chr "V2"
#>  @ age         : num 48
#>  @ sex         : chr "1"
#>  @ dual_code   : chr(0) 
#>  @ orec_code   : chr(0) 
#>  @ crec_code   : chr(0) 
#>  @ new_enrollee: logi(0) 
#>  @ has_snp     : logi(0) 
#>  @ non_aged    : logi(0) 
#>  @ dis_orig    : logi(0) 
#>  @ dis_curr    : logi(0) 
#>  @ dual_full   : logi(0) 
#>  @ dual_part   : logi(0) 
#>  @ has_esrd    : logi(0) 
#>  @ is_lti      : logi(0) 
#>  @ low_income  : logi(0) 
#>  @ esrd_months : int(0) 
#>  @ category    : chr(0) 
PatientDemographics(age = 35, sex = "M", version = "V6")
#> <hcc::PatientDemographics>
#>  @ version     : chr "V6"
#>  @ age         : num 35
#>  @ sex         : chr "M"
#>  @ dual_code   : chr(0) 
#>  @ orec_code   : chr(0) 
#>  @ crec_code   : chr(0) 
#>  @ new_enrollee: logi(0) 
#>  @ has_snp     : logi(0) 
#>  @ non_aged    : logi(0) 
#>  @ dis_orig    : logi(0) 
#>  @ dis_curr    : logi(0) 
#>  @ dual_full   : logi(0) 
#>  @ dual_part   : logi(0) 
#>  @ has_esrd    : logi(0) 
#>  @ is_lti      : logi(0) 
#>  @ low_income  : logi(0) 
#>  @ esrd_months : int(0) 
#>  @ category    : chr(0) 
PatientDemographics(age = 75, sex = "2", orec_code = "0", version = "V2")
#> <hcc::PatientDemographics>
#>  @ version     : chr "V2"
#>  @ age         : num 75
#>  @ sex         : chr "2"
#>  @ dual_code   : chr(0) 
#>  @ orec_code   : chr "0"
#>  @ crec_code   : chr(0) 
#>  @ new_enrollee: logi(0) 
#>  @ has_snp     : logi(0) 
#>  @ non_aged    : logi(0) 
#>  @ dis_orig    : logi(0) 
#>  @ dis_curr    : logi(0) 
#>  @ dual_full   : logi(0) 
#>  @ dual_part   : logi(0) 
#>  @ has_esrd    : logi(0) 
#>  @ is_lti      : logi(0) 
#>  @ low_income  : logi(0) 
#>  @ esrd_months : int(0) 
#>  @ category    : chr(0) 
```
