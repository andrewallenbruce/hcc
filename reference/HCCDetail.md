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
if (FALSE) {
HCCDetail(
 hcc = "203",
 label = "Coma, Brain Compression/Anoxic Damage",
 is_chronic = TRUE,
 coefficient = 0.486
)
}
```
