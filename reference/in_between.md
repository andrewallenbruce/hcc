# Is x Between a Minimum and a Maximum?

Is x Between a Minimum and a Maximum?

## Usage

``` r
in_between(x, min, max)
```

## Arguments

- x:

  `<int>` vector of candidates

- min:

  `<int>` Minimum value (inclusive)

- max:

  `<int>` Maximum value (inclusive)

## Value

`<lgl>` vector indicating membership

## Examples

``` r
if (FALSE) {
in_between(5L, 10L, 15L)
in_between(1L, 2L, 3L)
in_between(0L, 5L, 10L)
in_between(0:15, 5L, 10L)
}
```
