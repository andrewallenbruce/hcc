# Calculate HCC interactions across CMS models.

Handles CMS-HCC, ESRD, and RxHCC models.

## Usage

``` r
apply_interactions(demographics, hcc, model = "CMS-HCC Model V28")
```

## Arguments

- demographics:

  demographic information for age/sex/disability interactions

- hcc:

  set of HCCs for direct HCC checks

- model:

  The HCC model version being used; default is "CMS-HCC Model V28"

## Value

`<chr>` vector of interactions

## Examples

``` r
apply_interactions(
  model = "CMS-HCC Model V24",
  demographics = PatientDemographics(
    age = 65,
    sex = "F",
    category = "F65",
    dis_curr = FALSE,
    dis_orig = FALSE,
    non_aged = FALSE,
    dual_full = TRUE,
    dual_part = FALSE,
    is_lti = FALSE
  ),
  hcc = c(17:18, 85L)
)
#>  [1] "Originally_ESRD_Female" "MCAID_Female_Aged"      "NMCAID_NORIGDIS_F65"   
#>  [4] "MCAID_NORIGDIS_F65"     "FBD_NORIGDIS_F65"       "GE65_DUR4_9"           
#>  [7] "GE65_DUR10PL"           "FGC_GE65_DUR10PL_FBD"   "FGC_GE65_DUR4_9_FBD"   
#> [10] "FBDual_Female_Aged"     "DIABETES_CHF"           "D3"                    
```
