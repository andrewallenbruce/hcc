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
  orec = NA,
  crec = NA,
  dual = NA,
  new = FALSE,
  snp = FALSE,
  low = FALSE,
  lti = FALSE,
  months = NULL,
  prefix = NULL
)
```

## Arguments

- age:

  `<int>` Beneficiary age

- sex:

  `<chr>` Beneficiary sex (M/F or 1/2)

- version:

  `<chr>` Version of categorization to use ("V2", "V4", "V6")

- orec:

  `<chr>` Original reason for entitlement code ("0" - "3")

- crec:

  `<chr>` Current reason for entitlement code ("0" - "3")

- dual:

  `<chr>` Dual eligibility code ("00" - "10")

- new:

  `<lgl>` Beneficiary is a **New Enrollee**

- snp:

  `<lgl>` Beneficiary is in a **Special Needs Plan**

- low:

  `<lgl>` Beneficiary is **Low Income** (RxHCC only)

- lti:

  `<lgl>` Beneficiary is Long-Term Institutionalized

- months:

  `<int>` Number of months since transplant (ESRD only)

- prefix:

  `<chr>` Optional prefix to override demographic detection (e.g.,
  "DI\_", "DNE\_", "INS\_", "CFA\_", etc.)

## Value

A object containing derived fields like age/sex category, disability
status, dual status flags, etc.

## Examples

``` r
categorize_demographics(48, "1", "V2")
#> <Demographics>
#>       version : V2
#>           age : 48
#>           sex : 1
#>      non_aged : TRUE
#> orig_disabled : FALSE
#>      disabled : FALSE
#>          dual : NA
#>          orec : NA
#>          crec : NA
#>           new : FALSE
#>           snp : FALSE
#>           fbd : FALSE
#>           pbd : FALSE
#>          esrd : FALSE
#>           lti : FALSE
#>        months : NULL
#>           low : FALSE
#>      category : M45_54
categorize_demographics(35, "M", "V6")
#> <Demographics>
#>       version : V6
#>           age : 35
#>           sex : M
#>      non_aged : TRUE
#> orig_disabled : FALSE
#>      disabled : FALSE
#>          dual : NA
#>          orec : NA
#>          crec : NA
#>           new : FALSE
#>           snp : FALSE
#>           fbd : FALSE
#>           pbd : FALSE
#>          esrd : FALSE
#>           lti : FALSE
#>        months : NULL
#>           low : FALSE
#>      category : MAGE_LAST_35_39
categorize_demographics(75, "2", "V2", "0")
#> <Demographics>
#>       version : V2
#>           age : 75
#>           sex : 2
#>      non_aged : FALSE
#> orig_disabled : FALSE
#>      disabled : FALSE
#>          dual : NA
#>          orec : 0
#>          crec : NA
#>           new : FALSE
#>           snp : FALSE
#>           fbd : FALSE
#>           pbd : FALSE
#>          esrd : FALSE
#>           lti : FALSE
#>        months : NULL
#>           low : FALSE
#>      category : F75_79
```
