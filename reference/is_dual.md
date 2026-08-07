# Dual Eligibility Code Checks

Dual Eligibility Code Checks

## Usage

``` r
is_dual_any(dual_code)

is_dual_valid(dual_code)

is_dual_full(dual_code)

is_dual_partial(dual_code)
```

## Arguments

- dual_code:

  `<chr>` Dual eligibility code ("00" - "10")

## Value

`<lgl>` vector indicating membership

## Examples

``` r
is_dual_any(c("02", "04", "08"))
#> [1] TRUE TRUE TRUE
is_dual_valid(c("02", "04", "08"))
#> [1] TRUE TRUE TRUE
is_dual_full(c("02", "04", "08"))
#> [1] TRUE TRUE TRUE
is_dual_partial(c("01", "03", "05", "06"))
#> [1] TRUE TRUE TRUE TRUE
```
