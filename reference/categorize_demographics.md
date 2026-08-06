# Categorize a beneficiary's demographics into risk adjustment categories.

This function takes demographic information about a beneficiary and
returns a Demographics object containing derived fields used in risk
adjustment models.

## Usage

``` r
categorize_demographics(
  age,
  sex,
  version = "V2",
  dual_elgbl_cd = NA,
  orec = NA,
  crec = NA,
  new_enrollee = FALSE,
  snp = FALSE,
  low_income = FALSE,
  lti = FALSE,
  graft_months = NULL,
  prefix_override = NULL
)
```

## Arguments

- age:

  `<int>` Beneficiary age (floored to `integer`)

- sex:

  `<chr>` Beneficiary sex (M/F or 1/2)

- version:

  `<chr>` Version of categorization to use ("V2", "V4", "V6")

- dual_elgbl_cd:

  `<chr>` Dual eligibility code ("00" - "10")

- orec:

  `<chr>` Original reason for entitlement code ("0" - "3")

- crec:

  `<chr>` Current reason for entitlement code ("0" - "3")

- new_enrollee:

  `<lgl>` Whether beneficiary is a **New Enrollee**

- snp:

  `<lgl>` Whether beneficiary is in a **Special Needs Plan**

- low_income:

  `<lgl>` Whether beneficiary is **Low Income** (RxHCC only)

- lti:

  `<lgl>` Whether beneficiary is Long-Term Institutionalized

- graft_months:

  `<int>` Number of months since transplant (ESRD only)

- prefix_override:

  `<chr>` Optional prefix to override demographic detection (e.g.,
  "DI\_", "DNE\_", "INS\_", "CFA\_", etc.)

## Value

Demographics object containing derived fields like age/sex category,
disability status, dual status flags, etc.

## Examples

``` r
categorize_demographics(age = 48, sex = "1", version = "V2")
#> <Demographics>
#>       version : V2
#>           age : 48
#>           sex : 1
#>      non_aged : TRUE
#> orig_disabled : FALSE
#>      disabled : FALSE
#> dual_elgbl_cd : NA
#>          orec : NA
#>          crec : NA
#>  new_enrollee : FALSE
#>           snp : FALSE
#>           fbd : FALSE
#>           pbd : FALSE
#>          esrd : FALSE
#>           lti : FALSE
#>  graft_months : NULL
#>    low_income : FALSE
#>      category : M45_54
categorize_demographics(age = 35, sex = "M", version = "V6")
#> <Demographics>
#>       version : V6
#>           age : 35
#>           sex : M
#>      non_aged : TRUE
#> orig_disabled : FALSE
#>      disabled : FALSE
#> dual_elgbl_cd : NA
#>          orec : NA
#>          crec : NA
#>  new_enrollee : FALSE
#>           snp : FALSE
#>           fbd : FALSE
#>           pbd : FALSE
#>          esrd : FALSE
#>           lti : FALSE
#>  graft_months : NULL
#>    low_income : FALSE
#>      category : MAGE_LAST_35_39
categorize_demographics(age = 75, sex = "2", orec = "0", version = "V2")
#> <Demographics>
#>       version : V2
#>           age : 75
#>           sex : 2
#>      non_aged : FALSE
#> orig_disabled : FALSE
#>      disabled : FALSE
#> dual_elgbl_cd : NA
#>          orec : 0
#>          crec : NA
#>  new_enrollee : FALSE
#>           snp : FALSE
#>           fbd : FALSE
#>           pbd : FALSE
#>          esrd : FALSE
#>           lti : FALSE
#>  graft_months : NULL
#>    low_income : FALSE
#>      category : F75_79
```
