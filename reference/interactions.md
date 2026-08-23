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
#> [1] "LTI_Aged"                "LTI_GE65"               
#> [3] "NMCAID_NORIGDIS_M65_69"  "ND_PBD_NORIGDIS_M65_69" 
#> [5] "GE65_DUR10PL"            "FGI_GE65_DUR10PL_ND_PBD"
```
