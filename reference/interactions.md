# Create Demographic Interactions

Creates interaction variables that are model-agnostic. The coefficient
lookup will match only the relevant coefficients for each model.

## Usage

``` r
interactions(d)
```

## Arguments

- d:

  Demographics object

## Value

a list of interactions

## Examples

``` r
x = as_demographics(
  age = 65.1,
  sex = "M",
  orec = "2",
  dual = "2",
  new = TRUE,
  lti = TRUE,
  months = 10
 )

x
#> <Demographics>
#>       version : V2
#>           age : 65
#>           sex : 1
#>      non_aged : FALSE
#> orig_disabled : FALSE
#>      disabled : FALSE
#>          dual : 2
#>          orec : 2
#>          crec : NA
#>           new : TRUE
#>           snp : FALSE
#>           fbd : FALSE
#>           pbd : FALSE
#>          esrd : TRUE
#>           lti : TRUE
#>        months : 10
#>           low : FALSE
#>      category : M65_69

interactions(x)
#> $OriginallyDisabled_Female
#> [1] 0
#> 
#> $OriginallyDisabled_Male
#> [1] 0
#> 
#> $Originally_ESRD_Female
#> [1] 0
#> 
#> $Originally_ESRD_Male
#> [1] 1
#> 
#> $MCAID_Female_Aged
#> [1] 0
#> 
#> $MCAID_Female_NonAged
#> [1] 0
#> 
#> $MCAID_Male_Aged
#> [1] 0
#> 
#> $MCAID_Male_NonAged
#> [1] 0
#> 
#> $LTI_Aged
#> [1] 1
#> 
#> $LTI_NonAged
#> [1] 0
#> 
#> $LTI_GE65
#> [1] 1
#> 
#> $LTI_LT65
#> [1] 0
#> 
#> $LTIMCAID
#> [1] 0
#> 
#> $NMCAID_NORIGDIS_M65_69
#> [1] TRUE
#> 
#> $MCAID_NORIGDIS_M65_69
#> [1] 0
#> 
#> $NMCAID_ORIGDIS_M65_69
#> [1] TRUE
#> 
#> $MCAID_ORIGDIS_M65_69
#> [1] 0
#> 
#> $FBD_NORIGDIS_M65_69
#> [1] 0
#> 
#> $FBD_ORIGDIS_M65_69
#> [1] 0
#> 
#> $ND_PBD_NORIGDIS_M65_69
#> [1] TRUE
#> 
#> $ND_PBD_ORIGDIS_M65_69
#> [1] TRUE
#> 
#> $GE65_DUR4_9
#> [1] 0
#> 
#> $LT65_DUR4_9
#> [1] 0
#> 
#> $GE65_DUR10PL
#> [1] 1
#> 
#> $LT65_DUR10PL
#> [1] 0
#> 
#> $FGC_GE65_DUR4_9_ND_PBD
#> [1] TRUE
#> 
#> $FGC_LT65_DUR4_9_ND_PBD
#> [1] TRUE
#> 
#> $FGI_GE65_DUR4_9_ND_PBD
#> [1] TRUE
#> 
#> $FGI_LT65_DUR4_9_ND_PBD
#> [1] TRUE
#> 
#> $FGC_GE65_DUR10PL_ND_PBD
#> [1] TRUE
#> 
#> $FGC_LT65_DUR10PL_ND_PBD
#> [1] TRUE
#> 
#> $FGI_GE65_DUR10PL_ND_PBD
#> [1] TRUE
#> 
#> $FGI_LT65_DUR10PL_ND_PBD
#> [1] TRUE
#> 
#> $FGC_PBD_GE65_flag
#> [1] 0
#> 
#> $FGC_PBD_LT65_flag
#> [1] 0
#> 
#> $FGI_PBD_GE65_flag
#> [1] 0
#> 
#> $FGI_PBD_LT65_flag
#> [1] 0
#> 
#> $FGC_GE65_DUR4_9_FBD
#> [1] 0
#> 
#> $FGC_LT65_DUR4_9_FBD
#> [1] 0
#> 
#> $FGI_GE65_DUR4_9_FBD
#> [1] 0
#> 
#> $FGI_LT65_DUR4_9_FBD
#> [1] 0
#> 
```
