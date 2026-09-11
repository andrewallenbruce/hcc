# Model-Based Disease Interaction Variables

Model-Based Disease Interaction Variables

## Usage

``` r
disease_interactions(diag, demo = NULL)
```

## Arguments

- diag:

  `<DiagnosticCategories>` object

- demo:

  `<PatientDemographics>` object

## Value

`<list>` containing disease interaction variables

## Examples

``` r
cms = diagnostics("CMS-HCC Model V24", c(17L, 85L))
rx = diagnostics("RxHCC Model V08", 130:133)
demo = demographics(age = 64, sex = "F", orec = "1")
disease_interactions(cms, demo)
#> [1] "DIABETES_CHF"   "DISABLED_HCC85"
disease_interactions(rx, demo)
#> [1] "NonAged_RXHCC130" "NonAged_RXHCC131" "NonAged_RXHCC132" "NonAged_RXHCC133"
```
