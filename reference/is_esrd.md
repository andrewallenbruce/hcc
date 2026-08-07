# Check if OREC/CREC indicates ESRD status

Check if OREC/CREC indicates ESRD status

## Usage

``` r
is_esrd(rec_code)
```

## Arguments

- rec_code:

  OREC/CREC code

## Value

logical

## Examples

``` r
is_esrd(c("2", "3"))
#> [1] TRUE TRUE
```
