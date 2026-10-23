# Patient Demographics Categorization

Patient Demographics Categorization

## Usage

``` r
PatientDemographics(
  version = NA_character_,
  age = integer(0),
  sex = NA_character_,
  dual_code = NA_character_,
  orec_code = integer(0),
  crec_code = integer(0),
  new_enrollee = NA,
  has_snp = NA,
  non_aged = NA,
  dis_orig = NA,
  dis_curr = NA,
  dual_full = NA,
  dual_part = NA,
  has_esrd = NA,
  is_lti = NA,
  low_income = NA,
  esrd_months = integer(0),
  category = NA_character_
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
if (FALSE) {
PatientDemographics(
  age = 75,
  sex = "2",
  orec_code = "0",
  version = "V2"
)
}
```
