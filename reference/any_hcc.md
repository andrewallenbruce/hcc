# Is any HCC present?

Is any HCC present?

## Usage

``` r
any_hcc(needles, haystack)
```

## Arguments

- needles:

  `<int>` hcc(s) being searched for

- haystack:

  `<int>` hcc(s) being searched in

## Value

`<int>` scalar, `1` (True), `0` (False)

## Examples

``` r
any_hcc(17:19, 18:21)
#> [1] 1
any_hcc(17:19, 20:22)
#> [1] 0
```
