# Create Interactions

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
interactions(
 demographics(
   age = 65,
   sex = "M",
   orec = "2",
   dual = "02",
   new = TRUE,
   lti = TRUE,
   months = 10L
 )
)
#>  [1] "Originally_ESRD_Male"  "MCAID_Male_Aged"       "LTI_Aged"             
#>  [4] "LTI_GE65"              "LTIMCAID"              "MCAID_NORIGDIS_M65_69"
#>  [7] "FBD_NORIGDIS_M65_69"   "GE65_DUR10PL"          "FGI_GE65_DUR10PL_FBD" 
#> [10] "FBDual_Male_Aged"     
```
