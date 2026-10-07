# Create Interactions

Create Interactions

## Usage

``` r
interactions(x, y, ...)
```

## Arguments

- x:

  `<PatientDemographics>` S7 object

- y:

  `<DiagnosticCategories>` S7 object

- ...:

  dots

## Value

a character vector of interactions

## Details

Methods for `interactions`:

- `hcc::DiagnosticCategories,hcc::PatientDemographics`

- `hcc::PatientDemographics,MISSING`

- `hcc::PatientDemographics,hcc::DiagnosticCategories`

Creates interaction variables that are model-agnostic. The coefficient
look-up will match only the relevant coefficients for each model.

## Examples

``` r
x = demographics(age = 64, sex = "F", orec = "1")
interactions(x)
#> [1] "NMCAID_NORIGDIS_F60_64" "ND_PBD_NORIGDIS_F60_64"
interactions(x, diagnostics("C24", c(17L, 85L)))
#> [1] "DIABETES_CHF"   "DISABLED_HCC85"
interactions(x, diagnostics("R08", 130:133))
#> [1] "NonAged_RXHCC130" "NonAged_RXHCC131" "NonAged_RXHCC132" "NonAged_RXHCC133"
```
