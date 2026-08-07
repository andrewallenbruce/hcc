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
#> <Demographics>
#>       version : V2
#>           age : 48
#>           sex : 1
#>      non_aged : 
#> orig_disabled : 
#>      disabled : 
#>          dual : 
#>          orec : 
#>          crec : 
#>           new : 
#>           snp : 
#>           fbd : 
#>           pbd : 
#>          esrd : 
#>           lti : 
#>        months : 
#>           low : 
#>      category : 
Demographics(age = 35, sex = "M", version = "V6")
#> <Demographics>
#>       version : V6
#>           age : 35
#>           sex : M
#>      non_aged : 
#> orig_disabled : 
#>      disabled : 
#>          dual : 
#>          orec : 
#>          crec : 
#>           new : 
#>           snp : 
#>           fbd : 
#>           pbd : 
#>          esrd : 
#>           lti : 
#>        months : 
#>           low : 
#>      category : 
Demographics(age = 75, sex = "2", orec = "0", version = "V2")
#> <Demographics>
#>       version : V2
#>           age : 75
#>           sex : 2
#>      non_aged : 
#> orig_disabled : 
#>      disabled : 
#>          dual : 
#>          orec : 0
#>          crec : 
#>           new : 
#>           snp : 
#>           fbd : 
#>           pbd : 
#>          esrd : 
#>           lti : 
#>        months : 
#>           low : 
#>      category : 
```
