# Creates HCC count variables

Creates HCC count variables

## Usage

``` r
hcc_counts(hcc)
```

## Arguments

- hcc:

  hcc

## Value

a named `<int>` vector of counts

## Examples

``` r
hcc_counts(17:19)
#> D3 
#>  1 
hcc_counts(c(17:19, 85L))
#> D4 
#>  1 
```
