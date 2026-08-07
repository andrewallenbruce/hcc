# Response model for demographic categorization

Response model for demographic categorization

## Usage

``` r
Demographics(
  age = integer(),
  sex = character(),
  orec = character(),
  crec = character(),
  version = character(),
  snp = logical(),
  dual_elgbl_cd = character(),
  new_enrollee = logical(),
  graft_months = integer(),
  low_income = logical()
)
```

## Arguments

- age:

  `<int>` Beneficiary age (floored to `integer`)

- sex:

  `<chr>` Beneficiary sex (M/F or 1/2)

- orec:

  `<chr>` Original reason for entitlement code ("0" - "3")

- crec:

  `<chr>` Current reason for entitlement code ("0" - "3")

- version:

  `<chr>` Version of categorization to use ("V2", "V4", "V6")

- snp:

  `<lgl>` Whether beneficiary is in a **Special Needs Plan**

- dual_elgbl_cd:

  `<chr>` Dual eligibility code ("00" - "10")

- new_enrollee:

  `<lgl>` Whether beneficiary is a **New Enrollee**

- graft_months:

  `<int>` Number of months since transplant (ESRD only)

- low_income:

  `<lgl>` Whether beneficiary is **Low Income** (RxHCC only)

## Value

object containing the following derived fields:

- category: Age-sex category code

- non_aged: `TRUE` if `age <= 64`

- orig_disabled: `TRUE` if originally disabled (`OREC == "1"`) and not
  currently disabled)

- disabled: `TRUE` if currently disabled (`age < 65 & OREC != "0"`)

- esrd: `TRUE` if ESRD (ESRD Model)

- lti: `TRUE` if LTI (LTI Model)

- fbd: `TRUE` if FBD (FBD Model)

- pbd: `TRUE` if PBD (PBD Model)

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
#> dual_elgbl_cd : 
#>          orec : 
#>          crec : 
#>  new_enrollee : 
#>           snp : 
#>           fbd : 
#>           pbd : 
#>          esrd : 
#>           lti : 
#>  graft_months : 
#>    low_income : 
Demographics(age = 35, sex = "M", version = "V6")
#> <Demographics>
#>       version : V6
#>           age : 35
#>           sex : M
#>      non_aged : 
#> orig_disabled : 
#>      disabled : 
#> dual_elgbl_cd : 
#>          orec : 
#>          crec : 
#>  new_enrollee : 
#>           snp : 
#>           fbd : 
#>           pbd : 
#>          esrd : 
#>           lti : 
#>  graft_months : 
#>    low_income : 
Demographics(age = 75, sex = "2", orec = "0", version = "V2")
#> <Demographics>
#>       version : V2
#>           age : 75
#>           sex : 2
#>      non_aged : 
#> orig_disabled : 
#>      disabled : 
#> dual_elgbl_cd : 
#>          orec : 0
#>          crec : 
#>  new_enrollee : 
#>           snp : 
#>           fbd : 
#>           pbd : 
#>          esrd : 
#>           lti : 
#>  graft_months : 
#>    low_income : 
```
