# Create Demographic Interactions

Creates interaction variables that are model-agnostic. The coefficient
lookup will match only the relevant coefficients for each model.

## Usage

``` r
interactions(x, ...)
```

## Arguments

- x:

  Demographics object

- ...:

  dots

## Value

a list of interactions

## Examples

``` r
x = demographics(
  age = 65.1,
  sex = "M",
  orec_code = "2",
  dual_code = "2",
  new_enrollee = TRUE,
  is_lti = TRUE,
  esrd_months = 10L
 )

x
#> <hcc::PatientDemographics>
#>  @ version     : chr "V2"
#>  @ age         : int 65
#>  @ sex         : chr "1"
#>  @ dual_code   : chr "2"
#>  @ orec_code   : chr NA
#>  @ crec_code   : chr NA
#>  @ new_enrollee: logi TRUE
#>  @ has_snp     : logi FALSE
#>  @ non_aged    : logi FALSE
#>  @ dis_orig    : logi FALSE
#>  @ dis_curr    : logi FALSE
#>  @ dual_full   : logi FALSE
#>  @ dual_part   : logi FALSE
#>  @ has_esrd    : logi TRUE
#>  @ is_lti      : logi TRUE
#>  @ low_income  : logi FALSE
#>  @ esrd_months : int 10
#>  @ category    : chr "M65_69"

interactions(x)
#>  [1] "OriginallyDisabled_Male" "Originally_ESRD_Male"   
#>  [3] "LTI_Aged"                "LTI_NonAged"            
#>  [5] "LTI_GE65"                "LTI_LT65"               
#>  [7] "LTIMCAID"                "NMCAID_NORIGDIS_M65_69" 
#>  [9] "NMCAID_ORIGDIS_M65_69"   "ND_PBD_NORIGDIS_M65_69" 
#> [11] "ND_PBD_ORIGDIS_M65_69"   "GE65_DUR10PL"           
#> [13] "LT65_DUR10PL"            "FGC_GE65_DUR4_9_ND_PBD" 
#> [15] "FGC_LT65_DUR4_9_ND_PBD"  "FGI_GE65_DUR4_9_ND_PBD" 
#> [17] "FGC_GE65_DUR10PL_ND_PBD" "FGC_LT65_DUR10PL_ND_PBD"
#> [19] "FGI_GE65_DUR10PL_ND_PBD"
```
