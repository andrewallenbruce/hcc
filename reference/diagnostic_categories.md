# Model-Based Disease Categories

Model-Based Disease Categories

## Usage

``` r
diagnostic_categories(model, hcc)
```

## Arguments

- model:

  `<chr>` Model Name

- hcc:

  `<int>` hcc

## Value

a list of interactions

## Examples

``` r
diagnostic_categories("CMS-HCC Model V24", c(17:19, 85L))
#> $CANCER
#> [1] 0
#> 
#> $DIABETES
#> [1] 1
#> 
#> $CARD_RESP_FAIL
#> [1] 0
#> 
#> $CHF
#> [1] 1
#> 
#> $gCopdCF
#> [1] 0
#> 
#> $RENAL_V24
#> [1] 0
#> 
#> $SEPSIS
#> [1] 0
#> 
#> $gSubstanceUseDisorder_V24
#> [1] 0
#> 
#> $gPsychiatric_V24
#> [1] 0
#> 
#> $PRESSURE_ULCER
#> [1] 0
#> 
```
