# Creates HCC count variables

Creates HCC count variables

## Usage

``` r
hcc_count(hcc)
```

## Arguments

- hcc:

  hcc

## Value

a named `<int>` vector of counts

## Examples

``` r
hcc_count(17:19)
#> [1] "D3"
hcc_count(c(17:19, 85L))
#> [1] "D4"
```
