# Extract Problems from X12 Indices

Extract Problems from X12 Indices

## Arguments

- x:

  `<X12Index>` S7 object

- ...:

  dots

## Value

a character vector of interactions

## Examples

``` r
idx9 = index_x12(hcc::x12_837I$sample_837_9)
problems(idx9)
#> character(0)
```
