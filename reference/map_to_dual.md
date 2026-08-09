# Map Codes to Dual Eligibility Codes

Map California Medi-Cal aid codes or Medicare status codes to CMS Dual
Eligibility codes

## Usage

``` r
map_to_dual(code)
```

## Arguments

- code:

  `<chr>` Medi-Cal aid code or Medicare status code

## Value

Dual eligibility code ('01'-'08') or NA if not found

## Examples

``` r
map_to_dual(c("QMB", "QMBONLY", "SLMB+", "QQQ"))
#> [1] "01" "01" "04" NA  
map_to_dual(c("4N", "5B", "40"))
#> [1] "02" "04" NA  
```
