# Demographics-Based Coefficient Prefix

Get the coefficient prefix based on beneficiary demographics.

## Usage

``` r
prefix(x, model = "C28")
```

## Arguments

- x:

  `<PatientDemographics>` S7 object

- model:

  `<chr>` model name; default is `"C28"`

## Value

String prefix used to look up coefficients for beneficiary type

## Examples

``` r
x = demographics(age = 70, sex = "F", dual = "00", orec = 0, crec = 0)
prefix(x, "C28")
#> [1] "CNA_"
prefix(x, "D24")
#> [1] NA
prefix(x, "R05")
#> [1] "Rx_CE_NoLowAged_"
```
