# Get CC for a single diagnosis code.

Get CC for a single diagnosis code.

## Usage

``` r
get_cc(diagnosis_code, year, model_name)
```

## Arguments

- diagnosis_code:

  `<chr>` ICD-10 diagnosis code

- model_name:

  `<chr>` HCC model name to use for hierarchy rules

## Value

CC code if found, NULL otherwise

## Examples

``` r
if (FALSE) {
get_cc("E119")
get_cc("E11.9")
}
```
