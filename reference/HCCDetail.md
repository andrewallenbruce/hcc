# HCC Category Detail

HCC Category Detail

## Usage

``` r
HCCDetail(
  hcc = integer(0),
  label = character(0),
  is_chronic = logical(0),
  coefficient = numeric(0)
)
```

## Arguments

- hcc:

  `<int>` HCC code (e.g., 18, 85)

- label:

  `<chr>` Human-readable description (e.g., "Diabetes with Chronic
  Complications")

- is_chronic:

  `<lgl>` Whether this HCC is considered a chronic condition

- coefficient:

  `<dbl>` The coefficient value applied for this HCC in the RAF
  calculation

## Value

An `<HCCDetail>` S7 object

## Examples

``` r
HCCDetail( # HCC203
 hcc = 203L,
 label = "Coma, Brain Compression/Anoxic Damage",
 is_chronic = TRUE,
 coefficient = 0.486
)
#> <hcc::HCCDetail>
#>  @ hcc        : int 203
#>  @ label      : chr "Coma, Brain Compression/Anoxic Damage"
#>  @ is_chronic : logi TRUE
#>  @ coefficient: num 0.486
```
