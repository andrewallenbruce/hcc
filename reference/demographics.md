# Categorize a beneficiary's demographics into risk adjustment categories.

This function takes demographic information about a beneficiary and
returns a Demographics object containing derived fields used in risk
adjustment models.

## Usage

``` r
demographics(
  age,
  sex,
  ver = "V2",
  dual = NA_character_,
  orec = NA_integer_,
  crec = NA_integer_,
  new_enrollee = FALSE,
  snp = FALSE,
  low_income = FALSE,
  lti = FALSE,
  months = 0,
  prefix = NULL
)
```

## Arguments

- age:

  `<num>` Beneficiary age

- sex:

  `<chr>` Beneficiary sex (`M`/`1` or `F`/`2`)

- ver:

  `<chr>` Version of categorization; default is `V2`

- dual:

  `<chr>` Dual eligibility code (`00` - `10`)

- orec, crec:

  `<chr>` Original/Current reason for entitlement code:

  - `0`: Old Age and Survivors Insurance (OASI)

  - `1`: Disability Insurance Benefits (DIB)

  - `2`: ESRD - End-Stage Renal Disease

  - `3`: DIB and ESRD

- new_enrollee:

  `<lgl>` Beneficiary is a New Enrollee

- snp:

  `<lgl>` Beneficiary is in a Special Needs Plan

- low_income:

  `<lgl>` Beneficiary is Low Income (RxHCC only)

- lti:

  `<lgl>` Beneficiary is Long-Term Institutionalized

- months:

  `<int>` Number of months since transplant (ESRD only)

- prefix:

  `<chr>` Optional prefix to override demographic detection (e.g.,
  `DI_`, `DNE_`, `INS_`, `CFA_`, etc.)

## Value

A `<PatientDemographics>` S7 object

## Examples

``` r
demographics(age = 48, sex = "1")
#> <hcc::PatientDemographics>
#>  @ version     : chr "V2"
#>  @ age         : int 48
#>  @ sex         : chr "1"
#>  @ dual_code   : chr NA
#>  @ orec_code   : int NA
#>  @ crec_code   : int NA
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
demographics(age = 35, sex = "M", ver = "V6")
#> <hcc::PatientDemographics>
#>  @ version     : chr "V6"
#>  @ age         : int 35
#>  @ sex         : chr "M"
#>  @ dual_code   : chr NA
#>  @ orec_code   : int NA
#>  @ crec_code   : int NA
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
demographics(age = 75, sex = "2", orec = 0)
#> <hcc::PatientDemographics>
#>  @ version     : chr "V2"
#>  @ age         : int 75
#>  @ sex         : chr "2"
#>  @ dual_code   : chr NA
#>  @ orec_code   : int 0
#>  @ crec_code   : int NA
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
