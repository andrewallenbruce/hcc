# Categorize a beneficiary's demographics into risk adjustment categories.

This function takes demographic information about a beneficiary and
returns a Demographics object containing derived fields used in risk
adjustment models.

## Usage

``` r
demographics(
  version = "V2",
  age,
  sex,
  dual_code = NA_character_,
  orec_code = NA_character_,
  crec_code = NA_character_,
  new_enrollee = FALSE,
  has_snp = FALSE,
  low_income = FALSE,
  is_lti = FALSE,
  esrd_months = 0L,
  prefix = NULL
)
```

## Arguments

- version:

  `<chr>` Version of categorization to use ("V2", "V4", "V6")

- age:

  `<num>` Beneficiary age

- sex:

  `<chr>` Beneficiary sex (M/F or 1/2)

- dual_code:

  `<chr>` Dual eligibility code ("00" - "10")

- orec_code:

  `<chr>` Original reason for entitlement code (`"0"` - `"3"`)

- crec_code:

  `<chr>` Current reason for entitlement code (`"0"` - `"3"`)

- new_enrollee:

  `<lgl>` Beneficiary is a **New Enrollee**

- has_snp:

  `<lgl>` Beneficiary is in a **Special Needs Plan**

- low_income:

  `<lgl>` Beneficiary is **Low Income** (RxHCC only)

- is_lti:

  `<lgl>` Beneficiary is Long-Term Institutionalized

- esrd_months:

  `<int>` Number of months since transplant (ESRD only)

- prefix:

  `<chr>` Optional prefix to override demographic detection (e.g.,
  "DI\_", "DNE\_", "INS\_", "CFA\_", etc.)

## Value

A S7 object

## Examples

``` r
demographics(age = 48, sex = "1")
#> <hcc::PatientDemographics>
#>  @ version     : chr "V2"
#>  @ age         : int 48
#>  @ sex         : chr "1"
#>  @ dual_code   : chr NA
#>  @ orec_code   : chr NA
#>  @ crec_code   : chr NA
#>  @ new_enrollee: logi FALSE
#>  @ has_snp     : logi FALSE
#>  @ non_aged    : logi TRUE
#>  @ dis_orig    : logi FALSE
#>  @ dis_curr    : logi FALSE
#>  @ dual_full   : logi FALSE
#>  @ dual_part   : logi FALSE
#>  @ has_esrd    : logi FALSE
#>  @ is_lti      : logi FALSE
#>  @ low_income  : logi FALSE
#>  @ esrd_months : int 0
#>  @ category    : chr "M45_54"
demographics(version = "V6", age = 35, sex = "M")
#> <hcc::PatientDemographics>
#>  @ version     : chr "V6"
#>  @ age         : int 35
#>  @ sex         : chr "M"
#>  @ dual_code   : chr NA
#>  @ orec_code   : chr NA
#>  @ crec_code   : chr NA
#>  @ new_enrollee: logi FALSE
#>  @ has_snp     : logi FALSE
#>  @ non_aged    : logi TRUE
#>  @ dis_orig    : logi FALSE
#>  @ dis_curr    : logi FALSE
#>  @ dual_full   : logi FALSE
#>  @ dual_part   : logi FALSE
#>  @ has_esrd    : logi FALSE
#>  @ is_lti      : logi FALSE
#>  @ low_income  : logi FALSE
#>  @ esrd_months : int 0
#>  @ category    : chr "MAGE_LAST_35_39"
demographics(version = "V2", age = 75, sex = "2", orec_code = "0")
#> <hcc::PatientDemographics>
#>  @ version     : chr "V2"
#>  @ age         : int 75
#>  @ sex         : chr "2"
#>  @ dual_code   : chr NA
#>  @ orec_code   : chr NA
#>  @ crec_code   : chr NA
#>  @ new_enrollee: logi FALSE
#>  @ has_snp     : logi FALSE
#>  @ non_aged    : logi FALSE
#>  @ dis_orig    : logi FALSE
#>  @ dis_curr    : logi FALSE
#>  @ dual_full   : logi FALSE
#>  @ dual_part   : logi FALSE
#>  @ has_esrd    : logi FALSE
#>  @ is_lti      : logi FALSE
#>  @ low_income  : logi FALSE
#>  @ esrd_months : int 0
#>  @ category    : chr "F75_79"
```
