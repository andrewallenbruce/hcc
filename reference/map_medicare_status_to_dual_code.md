# Map Medicare status code to dual eligibility code

Map Medicare status code to dual eligibility code

## Usage

``` r
map_medicare_status_to_dual_code(status)
```

## Arguments

- status:

  Medicare status code (e.g., 'QMB Plus', 'SLMB', 'QI')

## Value

Dual eligibility code ('01'-'08') or '00' if not found

## Examples

``` r
x <- c("QQQ", "QMB", "QMBONLY", "SLMBPLUS", "SLMB+", "QDWI", "QI", "QI1")
map_medicare_status_to_dual_code(x)
#> [1] NA   "01" "01" "04" "04" "05" "06" "06"
```
