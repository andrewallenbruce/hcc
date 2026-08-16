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
#> <hcc::Demographics>
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
#> $female
#> [1] FALSE
#> 
#> $male
#> [1] TRUE
#> 
#> $aged
#> [1] TRUE
#> 
#> $lti
#> [1] TRUE
#> 
#> $fbd
#> [1] FALSE
#> 
#> $pbd
#> [1] FALSE
#> 
#> $months
#> [1] 10
#> 
#> $mcaid
#> [1] FALSE
#> 
#> $nemcaid
#> [1] FALSE
#> 
#> $ne_origds
#> [1] FALSE
#> 
#> $is_dur4_9
#> [1] FALSE
#> 
#> $is_dur10pl
#> [1] TRUE
#> 
#> $is_esrd
#> [1] FALSE
#> 
```
