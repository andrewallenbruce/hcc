# Apply risk adjustment coefficients to HCCs and interactions.

This function takes demographic information, HCC codes, and interaction
variables and returns a dictionary mapping each variable to its
corresponding coefficient value based on the specified model.

## Usage

``` r
apply_coefficients(
  demographics,
  interactions,
  coefficients = NULL,
  hcc,
  model = "CMS-HCC Model V28",
  year = 2026L,
  prefix_override = NULL
)
```

## Arguments

- demographics:

  Demographics object

- interactions:

  Interaction variables and their values (0 or 1)

- coefficients:

  Map of variable/model to coefficient values

- hcc:

  HCC codes present for the patient

- model:

  Risk adjustment model to use; default is "CMS-HCC Model V28"

- year:

  Model year; default is 2026

- prefix_override:

  Optional prefix to override auto-detected demographic prefix. Common
  values:

  - `DI_` (ESRD Dialysis)

  - `DNE_` (ESRD Dialysis New Enrollee)

  - `INS_` (Institutionalized)

  - `CFA_` (Community Full Dual Aged), etc.

## Value

Dictionary mapping HCC codes and interaction variables to their
coefficient values for variables that are present

## Examples

``` r
if (FALSE) {
apply_coefficients(
  demographics(
    age = 70,
    sex = "F",
    dual_code = "00",
    orec_code = "0",
    crec_code = "0",
    version = "V2",
    new_enrollee = FALSE,
    has_snp = FALSE,
    low_income = FALSE
  )
)
}
```
