# Detailed information about an HCC category

Detailed information about an HCC category

## Usage

``` r
HCCDetail(
  hcc = character(0),
  label = character(0),
  is_chronic = logical(0),
  coefficient = double(0)
)
```

## Arguments

- hcc:

  HCC code (e.g., "18", "85")

- label:

  Human-readable description (e.g., "Diabetes with Chronic
  Complications")

- is_chronic:

  Whether this HCC is considered a chronic condition

- coefficient:

  The coefficient value applied for this HCC in the RAF calculation

## Value

object

## Examples

``` r
HCCDetail(
 hcc = "80",
 label = "Coma, Brain Compression/Anoxic Damage",
 is_chronic = FALSE,
 coefficient = 0.486
)
#> $hcc
#> [1] "80"
#> 
#> $label
#> [1] "Coma, Brain Compression/Anoxic Damage"
#> 
#> $is_chronic
#> [1] FALSE
#> 
#> $coefficient
#> [1] 0.486
#> 
#> attr(,"class")
#> [1] "hcc_detail"
```
