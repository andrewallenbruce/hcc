# Create X12 Indices

Create X12 Indices

## Arguments

- x:

  raw X12 text input

- ...:

  dots

## Value

an `<hcc::IndexX12>` S7 object

## Examples

``` r
create_index(x = c(x12_820[c(1L, 17L)], x12_834[1], x12_837I[1], x12_837P[1]))
#> Error: object 'x12_820' not found
```
