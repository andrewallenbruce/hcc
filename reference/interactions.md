# Create Interactions

Creates interaction variables that are model-agnostic. The coefficient
look-up will match only the relevant coefficients for each model.

## Arguments

- x:

  `<PatientDemographics>` S7 object

- y:

  `<DiagnosticCategories>` S7 object

- ...:

  dots

## Value

a character vector of interactions

## Examples

``` r
interactions(
  demographics(
    age = 64,
    sex = "F",
    orec = "1"
  )
)
#> [1] "NMCAID_NORIGDIS_F60_64" "ND_PBD_NORIGDIS_F60_64"

interactions(
  demographics(age = 64, sex = "F", orec = "1"),
  diagnostics("C24", c(17L, 85L))
)
#> [1] "DIABETES_CHF"   "DISABLED_HCC85"
interactions(
  demographics(age = 64, sex = "F", orec = "1"),
  diagnostics("R08", 130:133)
)
#> [1] "NonAged_RXHCC130" "NonAged_RXHCC131" "NonAged_RXHCC132" "NonAged_RXHCC133"
```
