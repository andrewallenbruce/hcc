# Retrieve Risk Adjustment Coefficients

Retrieve Risk Adjustment Coefficients

## Usage

``` r
coefficients(coefficient = NULL, model = "C28", year = 2026L)
```

## Arguments

- coefficient:

  prefixed HCC(s)

- model:

  Risk adjustment model to use; default is "C28" (CMS-HCC Model V28)

- year:

  Model year; default is 2025

## Value

Dictionary mapping HCC codes and interaction variables to their
coefficient values for variables that are present

## Examples

``` r
coefficients(c("CPD_HCC111", "INS_HCC49"), "C28", 2026L)
#> # A tibble: 2 × 4
#>    year coefficient value model_name       
#>   <int> <chr>       <dbl> <chr>            
#> 1  2026 CPD_HCC111  32.2  CMS-HCC Model V28
#> 2  2026 INS_HCC49    1.53 CMS-HCC Model V28
```
