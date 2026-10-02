# Single Edit Rule

Single Edit Rule

## Usage

``` r
EditRule(
  icd = character(0),
  action = character(0),
  override = integer(0),
  model = character(0),
  description = character(0)
)

AgeEdit(
  icd = character(0),
  action = character(0),
  override = integer(0),
  model = character(0),
  description = character(0),
  age = integer(0),
  boundary = character(0)
)

SexEdit(
  icd = character(0),
  action = character(0),
  override = integer(0),
  model = character(0),
  description = character(0),
  sex = integer(0)
)
```

## Arguments

- icd:

  `<chr>` ICD-10-CM diagnosis code

- action:

  `<chr>` "invalid" or "override"

- override:

  `<int>` CC to assign when `action = "override"`

- model:

  `<chr>` Model Name

- description:

  `<chr>` description of Edit Rule

- age:

  `<int>` `<AgeEdit>`: patient age

- boundary:

  `<int>` `<AgeEdit>`: maximum or minimum age

- sex:

  `<int>` `<SexEdit>`: 1 (male) or 2 (female)

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
