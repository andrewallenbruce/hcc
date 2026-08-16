# Categorize a beneficiary's demographics into risk adjustment categories.

This function takes demographic information about a beneficiary and
returns a Demographics object containing derived fields used in risk
adjustment models.

## Usage

``` r
as_demographics(
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
  months = 0L,
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
as_demographics(48, "1", "V2")
#> $version
#> [1] "V2"
#> 
#> $age
#> [1] 48
#> 
#> $sex
#> [1] "1"
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
#> $dual
#> [1] NA
#> 
#> $orec
#> [1] NA
#> 
#> $crec
#> [1] NA
#> 
#> $new
#> [1] FALSE
#> 
#> $snp
#> [1] FALSE
#> 
#> $fbd
#> [1] FALSE
#> 
#> $pbd
#> [1] FALSE
#> 
#> $esrd
#> [1] FALSE
#> 
#> $lti
#> [1] FALSE
#> 
#> $months
#> [1] 0
#> 
#> $low
#> [1] FALSE
#> 
#> $category
#> [1] "M45_54"
#> 
#> attr(,"class")
#> [1] "demographics"
as_demographics(35, "M", "V6")
#> $version
#> [1] "V6"
#> 
#> $age
#> [1] 35
#> 
#> $sex
#> [1] "M"
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
#> $dual
#> [1] NA
#> 
#> $orec
#> [1] NA
#> 
#> $crec
#> [1] NA
#> 
#> $new
#> [1] FALSE
#> 
#> $snp
#> [1] FALSE
#> 
#> $fbd
#> [1] FALSE
#> 
#> $pbd
#> [1] FALSE
#> 
#> $esrd
#> [1] FALSE
#> 
#> $lti
#> [1] FALSE
#> 
#> $months
#> [1] 0
#> 
#> $low
#> [1] FALSE
#> 
#> $category
#> [1] "MAGE_LAST_35_39"
#> 
#> attr(,"class")
#> [1] "demographics"
as_demographics(75, "2", "V2", "0")
#> $version
#> [1] "V2"
#> 
#> $age
#> [1] 75
#> 
#> $sex
#> [1] "2"
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
#> $dual
#> [1] NA
#> 
#> $orec
#> [1] "0"
#> 
#> $crec
#> [1] NA
#> 
#> $new
#> [1] FALSE
#> 
#> $snp
#> [1] FALSE
#> 
#> $fbd
#> [1] FALSE
#> 
#> $pbd
#> [1] FALSE
#> 
#> $esrd
#> [1] FALSE
#> 
#> $lti
#> [1] FALSE
#> 
#> $months
#> [1] 0
#> 
#> $low
#> [1] FALSE
#> 
#> $category
#> [1] "F75_79"
#> 
#> attr(,"class")
#> [1] "demographics"
```
