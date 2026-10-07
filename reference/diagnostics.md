# Model-Based Disease Categories

Model-Based Disease Categories

## Usage

``` r
diagnostics(model, hcc)
```

## Arguments

- model:

  `<chr>` HCC model name:

  - `C22`: CMS-HCC Model V22

  - `C24`: CMS-HCC Model V24

  - `C28`: CMS-HCC Model V28

  - `D21`: CMS-HCC ESRD Model V21

  - `D24`: CMS-HCC ESRD Model V24

- hcc:

  `<int>` hcc

## Value

`<DiagnosticCategories>` S7 object

## Examples

``` r
diagnostics(hcc = c(17:19, 85L), model = "C24")
#> <hcc::DiagnosticCategories>
#>  @ model   : chr "CMS-HCC Model V24"
#>  @ hcc     : int [1:4] 17 18 19 85
#>  @ category:List of 10
#>  .. $ CANCER                   : int 0
#>  .. $ DIABETES                 : int 1
#>  .. $ CARD_RESP_FAIL           : int 0
#>  .. $ CHF                      : int 1
#>  .. $ SEPSIS                   : int 0
#>  .. $ gCopdCF                  : int 0
#>  .. $ RENAL_V24                : int 0
#>  .. $ gSubstanceUseDisorder_V24: int 0
#>  .. $ gPsychiatric_V24         : int 0
#>  .. $ PRESSURE_ULCER           : int 0
```
