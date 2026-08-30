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

String prefix used to look up coefficients for this beneficiary type

## Examples

``` r
coefficient_prefix(
  demographics(
    age = 70,
    sex = "F",
    dual_code = "00",
    orec_code = "0",
    crec_code = "0"
  )
) # CNA_
#> [1] "CNA_"
coefficient_prefix(
  demographics(
    age = 45,
    sex = "M",
    dual_code = "00",
    orec_code = "2",
    crec_code = "0"
  ),
  model = "CMS-HCC ESRD Model V24"
)
#> [1] "DI_"
```
