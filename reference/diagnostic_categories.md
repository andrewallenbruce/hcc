# Model-Based Disease Categories

Model-Based Disease Categories

## Usage

``` r
diagnostic_categories(model, hcc)
```

## Arguments

- model:

  `<chr>` Model Name

- hcc:

  `<int>` hcc

## Value

`<DiagnosticCategories>` S7 object

## Examples

``` r
diagnostic_categories(model = "CMS-HCC Model V24", hcc = c(17:19, 85L))
#> <hcc::DiagnosticCategories>
#>  @ model     : chr "CMS-HCC Model V24"
#>  @ hcc       : int [1:4] 17 18 19 85
#>  @ categories:List of 10
#>  .. $ CANCER                   : int 0
#>  .. $ DIABETES                 : int 1
#>  .. $ CARD_RESP_FAIL           : int 0
#>  .. $ CHF                      : int 1
#>  .. $ gCopdCF                  : int 0
#>  .. $ RENAL_V24                : int 0
#>  .. $ SEPSIS                   : int 0
#>  .. $ gSubstanceUseDisorder_V24: int 0
#>  .. $ gPsychiatric_V24         : int 0
#>  .. $ PRESSURE_ULCER           : int 0
```
