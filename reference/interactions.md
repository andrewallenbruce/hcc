# Create Demographic Interactions

Creates interaction variables that are model-agnostic. The coefficient
look-up will match only the relevant coefficients for each model.

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
  orec = "2",
  dual = "02",
  new = TRUE,
  lti = TRUE,
  months = 10L
 )

x
#> <hcc::PatientDemographics>
#>  @ version     : chr "V2"
#>  @ age         : int 65
#>  @ sex         : chr "1"
#>  @ dual_code   : chr "02"
#>  @ orec_code   : chr "2"
#>  @ crec_code   : chr NA
#>  @ new_enrollee: logi TRUE
#>  @ has_snp     : logi FALSE
#>  @ non_aged    : logi FALSE
#>  @ dis_orig    : logi FALSE
#>  @ dis_curr    : logi FALSE
#>  @ dual_full   : logi TRUE
#>  @ dual_part   : logi FALSE
#>  @ has_esrd    : logi TRUE
#>  @ is_lti      : logi TRUE
#>  @ low_income  : logi FALSE
#>  @ esrd_months : int 10
#>  @ category    : chr "M65_69"

interactions(x)
#>  [1] "Originally_ESRD_Male"  "MCAID_Male_Aged"       "LTI_Aged"             
#>  [4] "LTI_GE65"              "LTIMCAID"              "MCAID_NORIGDIS_M65_69"
#>  [7] "FBD_NORIGDIS_M65_69"   "GE65_DUR10PL"          "FGI_GE65_DUR10PL_FBD" 
#> [10] "FBDual_Male_Aged"     
```
