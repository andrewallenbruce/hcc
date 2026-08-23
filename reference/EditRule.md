# Single Edit Rule

Single Edit Rule

## Usage

``` r
EditRule(
  edit_type = character(0),
  sex = character(0),
  age_min = integer(0),
  age_max = integer(0),
  action = character(0),
  cc_override = character(0)
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

  `<chr>` CC to assign when action is "override"

## Value

An `<EditRule>` S7 object

## Examples

``` r
EditRule(
 edit_type = "age",
 age_min = 15L,
 age_max = 65L
 )
#> <hcc::EditRule>
#>  @ edit_type  : chr "age"
#>  @ sex        : chr(0) 
#>  @ age_min    : int 15
#>  @ age_max    : int 65
#>  @ action     : chr(0) 
#>  @ cc_override: chr(0) 
```
