# Calculate HCC interactions across CMS models.

Handles CMS-HCC, ESRD, and RxHCC models.

## Usage

``` r
apply_interactions(diagnostics, demographics)
```

## Arguments

- diagnostics:

  `<DiagnosticCategories>` object

- demographics:

  `<PatientDemographics>` object

## Value

`<chr>` vector of interactions

## Examples

``` r
apply_interactions(
  diagnostics(model = "C24", hcc = c(17L, 85L)),
  demographics(age = 64, sex = "F", orec = "1")
)
#> $demographic
#> [1] "NMCAID_NORIGDIS_F60_64" "ND_PBD_NORIGDIS_F60_64"
#> 
#> $disease
#> [1] "DIABETES_CHF"   "DISABLED_HCC85"
#> 
#> $number_hccs
#> [1] "D2"
#> 
```
