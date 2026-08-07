# Detailed information about an HCC category.

Detailed information about an HCC category.

## Usage

``` r
HCCDetail(
  hcc = character(),
  label = character(),
  is_chronic = logical(),
  coefficient = double()
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
HCCDetail()
#> $hcc
#> character(0)
#> 
#> $label
#> character(0)
#> 
#> $is_chronic
#> logical(0)
#> 
#> $coefficient
#> numeric(0)
#> 
#> attr(,"class")
#> [1] "hcc_detail"
```
