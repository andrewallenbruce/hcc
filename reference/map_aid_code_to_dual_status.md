# Map California Medi-Cal aid code to dual eligibility code

Map California Medi-Cal aid code to dual eligibility code

## Usage

``` r
map_aid_code_to_dual_status(aid_code)
```

## Arguments

- aid_code:

  California aid code (e.g., '4N', '5B')

## Value

Dual eligibility code ('01'-'08') or '00' if not found

## Examples

``` r
map_aid_code_to_dual_status(c("4N", "5B"))
#> [1] "02" "04"
```
