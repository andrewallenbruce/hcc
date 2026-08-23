# HCC Category Detail

HCC Category Detail

## Usage

``` r
HCCDetail(
  hcc = character(0),
  label = character(0),
  is_chronic = logical(0),
  coefficient = numeric(0)
)
```

## Arguments

- hcc:

  `<chr>` HCC code (e.g., "18", "85")

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
HCCDetail(
 hcc = "80",
 label = "Coma, Brain Compression/Anoxic Damage",
 is_chronic = FALSE,
 coefficient = 0.486
)
#> <hcc::HCCDetail>
#>  @ hcc        : chr "80"
#>  @ label      : chr "Coma, Brain Compression/Anoxic Damage"
#>  @ is_chronic : logi FALSE
#>  @ coefficient: num 0.486
```
