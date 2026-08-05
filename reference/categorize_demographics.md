# Categorize a beneficiary's demographics into risk adjustment categories.

This function takes demographic information about a beneficiary and
returns a Demographics object containing derived fields used in risk
adjustment models.

## Usage

``` r
categorize_demographics(
  age,
  sex,
  dual_elgbl_cd = NULL,
  orec = NA,
  crec = NA,
  version = "V2",
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

  `<int>` Beneficiary age (floored to integer)

- sex:

  `<chr>` Beneficiary sex (M/F or 1/2)

- dual_elgbl_cd:

  `<chr>` Dual eligibility code ("00" - "10")

- orec:

  `<chr>` Original reason for entitlement code ("0" - "3")

- crec:

  `<chr>` Current reason for entitlement code ("0" - "3")

- version:

  `<chr>` Version of categorization to use ("V2", "V4", "V6")

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
#> $version
#> [1] "V2"
#> 
#> $non_aged
#> [1] TRUE
#> 
#> $orig_disabled
#> [1] FALSE
#> 
#> $disabled
#> [1] FALSE
#> 
#> $age
#> [1] 48
#> 
#> $sex
#> [1] "1"
#> 
#> $dual_elgbl_cd
#> NULL
#> 
#> $orec
#> [1] NA
#> 
#> $crec
#> [1] NA
#> 
#> $new_enrollee
#> [1] FALSE
#> 
#> $snp
#> [1] FALSE
#> 
#> $fbd
#> logical(0)
#> 
#> $pbd
#> logical(0)
#> 
#> $esrd
#> [1] FALSE
#> 
#> $lti
#> [1] FALSE
#> 
#> $graft_months
#> NULL
#> 
#> $low_income
#> [1] FALSE
#> 
#> $category
#> [1] "NEF45_54"
#> 
categorize_demographics(age = 35, sex = "M", version = "V6")
#> $version
#> [1] "V6"
#> 
#> $non_aged
#> [1] TRUE
#> 
#> $orig_disabled
#> [1] FALSE
#> 
#> $disabled
#> [1] FALSE
#> 
#> $age
#> [1] 35
#> 
#> $sex
#> [1] "M"
#> 
#> $dual_elgbl_cd
#> NULL
#> 
#> $orec
#> [1] NA
#> 
#> $crec
#> [1] NA
#> 
#> $new_enrollee
#> [1] FALSE
#> 
#> $snp
#> [1] FALSE
#> 
#> $fbd
#> logical(0)
#> 
#> $pbd
#> logical(0)
#> 
#> $esrd
#> [1] FALSE
#> 
#> $lti
#> [1] FALSE
#> 
#> $graft_months
#> NULL
#> 
#> $low_income
#> [1] FALSE
#> 
#> $category
#> [1] "MAGE_LAST_35_39"
#> 
categorize_demographics(age = 75, sex = "2", orec = "0", version = "V2")
#> $version
#> [1] "V2"
#> 
#> $non_aged
#> [1] FALSE
#> 
#> $orig_disabled
#> [1] FALSE
#> 
#> $disabled
#> [1] FALSE
#> 
#> $age
#> [1] 75
#> 
#> $sex
#> [1] "2"
#> 
#> $dual_elgbl_cd
#> NULL
#> 
#> $orec
#> [1] "0"
#> 
#> $crec
#> [1] NA
#> 
#> $new_enrollee
#> [1] FALSE
#> 
#> $snp
#> [1] FALSE
#> 
#> $fbd
#> logical(0)
#> 
#> $pbd
#> logical(0)
#> 
#> $esrd
#> [1] FALSE
#> 
#> $lti
#> [1] FALSE
#> 
#> $graft_months
#> NULL
#> 
#> $low_income
#> [1] FALSE
#> 
#> $category
#> [1] "F75_79"
#> 
```
