# Create Demographic Interactions

Creates interaction variables that are model-agnostic. The coefficient
lookup will match only the relevant coefficients for each model.

## Usage

``` r
create_demographic_interactions(d)
```

## Arguments

- d:

  Demographics object

## Value

a list of interactions

## Examples

``` r
x = categorize_demographics(
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
#>      category : NEM65_69

create_demographic_interactions(x)
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
#> $GE65_DUR10PL
#> [1] 1
#> 
#> $LT65_DUR10PL
#> [1] 0
#> 
```
