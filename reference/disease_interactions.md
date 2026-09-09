# Model-Based Disease Interaction Variables

Model-Based Disease Interaction Variables

## Usage

``` r
disease_interactions(diagnostics, demographics = NULL)
```

## Arguments

- diagnostics:

  Dictionary of diagnostic categories

- demographics:

  (Optional) demographic information for age/sex/disability interactions

## Value

Dictionary containing all disease interaction variables

## Examples

``` r
disease_interactions(
  diagnostics(model = "CMS-HCC Model V24", hcc = c(17L, 85L)),
  demographics(age = 64, sex = "F", orec = "1")
 )
#> [1] "DIABETES_CHF"   "DISABLED_HCC85"
```
