# Single Edit Rule

Single Edit Rule

## Arguments

- icd:

  `<chr>` "sex" or "age"

- action:

  `<chr>` "invalid" or "override"

- override:

  `<int>` CC to assign when `action = "override"`

- model:

  description

- description:

  description

- sex:

  `<int>` For sex edits: 1 (male) or 2 (female)

- age:

  `<int>` For age edits: minimum age (inclusive)

- boundary:

  `<int>` For age edits: maximum age (inclusive)

## Value

An `<EditRule>` S7 object

## Examples

``` r
SexEdit(
  icd = c("D66", "D67"),
  sex = 2L,
  action = "override",
  override = 112L,
  model = "C28",
  description = "Hemophilia A/B in female - assign to CC 112"
)
#> <hcc::SexEdit>
#>  @ icd        : chr [1:2] "D66" "D67"
#>  @ action     : chr "override"
#>  @ override   : int 112
#>  @ model      : chr "C28"
#>  @ description: chr "Hemophilia A/B in female - assign to CC 112"
#>  @ sex        : int 2

AgeEdit(
  icd = "J410",
  age = 17L,
  boundary = "max",
  action = "invalid",
  override = NA_integer_,
  model = "C28",
  description = "Simple chronic bronchitis - invalid if age < 18"
)
#> <hcc::AgeEdit>
#>  @ icd        : chr "J410"
#>  @ action     : chr "invalid"
#>  @ override   : int NA
#>  @ model      : chr "C28"
#>  @ description: chr "Simple chronic bronchitis - invalid if age < 18"
#>  @ age        : int 17
#>  @ boundary   : chr "max"
```
