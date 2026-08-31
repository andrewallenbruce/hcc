# Single Edit Rule

Single Edit Rule

## Usage

``` r
EditRule(
  edit_type = character(0),
  sex = integer(0),
  age_min = integer(0),
  age_max = integer(0),
  action = character(0),
  cc_override = integer(0)
)
```

## Arguments

- edit_type:

  `<chr>` "sex" or "age"

- sex:

  `<int>` For sex edits: 1 (male) or 2 (female)

- age_min:

  `<int>` For age edits: minimum age (inclusive)

- age_max:

  `<int>` For age edits: minimum age (inclusive)

- action:

  `<chr>` "invalid" or "override"

- cc_override:

  `<int>` CC to assign when action is "override"

## Value

An `<EditRule>` S7 object

## Examples

``` r
EditRule(
  edit_type = "age",
  sex = 2L,
  action = "invalid",
  age_max = 16L,
  age_min = 15L,
  cc_override = 13L
)
#> <hcc::EditRule>
#>  @ edit_type  : chr "age"
#>  @ sex        : int 2
#>  @ age_min    : int 15
#>  @ age_max    : int 16
#>  @ action     : chr "invalid"
#>  @ cc_override: int 13
```
