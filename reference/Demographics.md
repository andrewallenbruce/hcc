# Response model for demographic categorization

Response model for demographic categorization

## Usage

``` r
Demographics(
  version = character(),
  age = integer(),
  sex = character(),
  non_aged = logical(),
  orig_disabled = logical(),
  disabled = logical(),
  dual = character(),
  orec = character(),
  crec = character(),
  new = logical(),
  snp = logical(),
  fbd = logical(),
  pbd = logical(),
  esrd = logical(),
  lti = logical(),
  months = integer(),
  low = logical(),
  category = character()
)
```

## Arguments

- version:

  `<chr>` Version of categorization to use ("V2", "V4", "V6")

- age:

  `<int>` Beneficiary age (floored to `integer`)

- sex:

  `<chr>` Beneficiary sex (M/F or 1/2)

- non_aged:

  `<lgl>` `TRUE` if `age <= 64`

- orig_disabled:

  `<lgl>` `TRUE` if originally disabled (`OREC == "1"`) and not
  currently disabled

- disabled:

  `<lgl>` `TRUE` if currently disabled (`age < 65 & OREC != "0"`)

- dual:

  `<chr>` Dual eligibility code ("00" - "10")

- orec:

  `<chr>` Original reason for entitlement code ("0" - "3")

- crec:

  `<chr>` Current reason for entitlement code ("0" - "3")

- new:

  `<lgl>` Whether beneficiary is a **New Enrollee**

- snp:

  `<lgl>` Whether beneficiary is in a **Special Needs Plan**

- fbd:

  `<lgl>` `TRUE` if FBD (FBD Model)

- pbd:

  `<lgl>` `TRUE` if PBD (PBD Model)

- esrd:

  `<lgl>` `TRUE` if ESRD (ESRD Model)

- lti:

  `<lgl>` `TRUE` if LTI (LTI Model)

- months:

  `<int>` Number of months since transplant (ESRD only)

- low:

  `<lgl>` Whether beneficiary is **Low Income** (RxHCC only)

- category:

  `<chr>` Age-sex category code

## Value

A list object containing the derived fields.

## Examples

``` r
Demographics(age = 48, sex = "1", version = "V2")
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
#> logical(0)
#> 
#> $orig_disabled
#> logical(0)
#> 
#> $disabled
#> logical(0)
#> 
#> $dual
#> character(0)
#> 
#> $orec
#> character(0)
#> 
#> $crec
#> character(0)
#> 
#> $new
#> logical(0)
#> 
#> $snp
#> logical(0)
#> 
#> $fbd
#> logical(0)
#> 
#> $pbd
#> logical(0)
#> 
#> $esrd
#> logical(0)
#> 
#> $lti
#> logical(0)
#> 
#> $months
#> integer(0)
#> 
#> $low
#> logical(0)
#> 
#> $category
#> character(0)
#> 
#> attr(,"class")
#> [1] "demographics"
Demographics(age = 35, sex = "M", version = "V6")
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
#> logical(0)
#> 
#> $orig_disabled
#> logical(0)
#> 
#> $disabled
#> logical(0)
#> 
#> $dual
#> character(0)
#> 
#> $orec
#> character(0)
#> 
#> $crec
#> character(0)
#> 
#> $new
#> logical(0)
#> 
#> $snp
#> logical(0)
#> 
#> $fbd
#> logical(0)
#> 
#> $pbd
#> logical(0)
#> 
#> $esrd
#> logical(0)
#> 
#> $lti
#> logical(0)
#> 
#> $months
#> integer(0)
#> 
#> $low
#> logical(0)
#> 
#> $category
#> character(0)
#> 
#> attr(,"class")
#> [1] "demographics"
Demographics(age = 75, sex = "2", orec = "0", version = "V2")
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
#> logical(0)
#> 
#> $orig_disabled
#> logical(0)
#> 
#> $disabled
#> logical(0)
#> 
#> $dual
#> character(0)
#> 
#> $orec
#> [1] "0"
#> 
#> $crec
#> character(0)
#> 
#> $new
#> logical(0)
#> 
#> $snp
#> logical(0)
#> 
#> $fbd
#> logical(0)
#> 
#> $pbd
#> logical(0)
#> 
#> $esrd
#> logical(0)
#> 
#> $lti
#> logical(0)
#> 
#> $months
#> integer(0)
#> 
#> $low
#> logical(0)
#> 
#> $category
#> character(0)
#> 
#> attr(,"class")
#> [1] "demographics"
```
