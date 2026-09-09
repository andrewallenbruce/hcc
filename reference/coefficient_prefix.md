# Demographics-Based Coefficient Prefix

Get the coefficient prefix based on beneficiary demographics.

## Usage

``` r
coefficient_prefix(x, ...)
```

## Arguments

- x:

  `<PatientDemographics>` S7 object

- ...:

  dots

## Value

String prefix used to look up coefficients for beneficiary type

## Examples

``` r
coefficient_prefix(
  demographics(
    age = 70,
    sex = "F",
    dual = "00",
    orec = "0",
    crec = "0"
  )
)
#> [1] "CNA_"
coefficient_prefix(
  demographics(
    age = 45,
    sex = "M",
    dual = "00",
    orec = "2",
    crec = "0"
  ),
  model = "CMS-HCC ESRD Model V24"
)
#> [1] "DI_"
```
