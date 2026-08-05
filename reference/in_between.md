# Check if x is between min and max (inclusive)

Check if x is between min and max (inclusive)

## Usage

``` r
in_between(x, min, max)
```

## Arguments

- x:

  `<int>` Integer vector to check

- min:

  `<int>` Minimum value (inclusive)

- max:

  `<int>` Maximum value (inclusive)

## Value

Logical vector indicating if each element of x is between min and max

## Examples

``` r
in_between(5L, 10L, 15L)
#> [1] FALSE
in_between(1L, 2L, 3L)
#> [1] FALSE
in_between(0L, 5L, 10L)
#> [1] FALSE
```
