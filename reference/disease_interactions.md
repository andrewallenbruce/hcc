# Model-Based Disease Interaction Variables

Model-Based Disease Interaction Variables

## Usage

``` r
disease_interactions(model, diagnostics, demographics = NULL, hcc = 0L)
```

## Arguments

- model:

  The HCC model version being used

- diagnostics:

  Dictionary of diagnostic categories

- demographics:

  (Optional) demographic information for age/sex/disability interactions

- hcc:

  (Optional) set of HCCs for direct HCC checks

## Value

Dictionary containing all disease interaction variables

## Examples

``` r
disease_interactions(
  model = "CMS-HCC Model V24",
  diagnostics = diagnostic_categories("CMS-HCC Model V24", c(17L, 85L)),
  demographics = PatientDemographics(
    age = 65,
    sex = "F",
    category = "F65",
    dis_curr = TRUE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = FALSE,
    dual_part = FALSE,
    is_lti = FALSE
  ),
  hcc = c(17L, 85L)
 )
#> [1] "DIABETES_CHF"   "DISABLED_HCC85"
```
