# Risk adjustment calculation results

Risk adjustment calculation results

## Usage

``` r
RAFResult(
  risk_score = numeric(0),
  risk_score_demographics = numeric(0),
  risk_score_chronic_only = numeric(0),
  risk_score_hcc = numeric(0),
  risk_score_payment = numeric(0),
  hcc_list = character(0),
  hcc_details = character(0),
  cc_to_dx = character(0),
  coefficients = numeric(0),
  interactions = character(0),
  demographics = character(0),
  model_name = character(0),
  version = character(0),
  diagnosis_codes = character(0),
  service_level_data = list()
)
```

## Arguments

- risk_score:

  Final RAF score

- risk_score_demographics:

  Demographics-only risk score

- risk_score_chronic_only:

  Chronic conditions risk score

- risk_score_hcc:

  HCC conditions risk score

- risk_score_payment:

  Payment RAF score (adjusted for MACI, normalization, and frailty)

- hcc_list:

  List of active HCC categories

- hcc_details:

  Detailed HCC information with labels and chronic status

- cc_to_dx:

  Condition categories mapped to diagnosis codes

- coefficients:

  Applied model coefficients

- interactions:

  Disease interaction coefficients

- demographics:

  Patient demographics used in calculation

- model_name:

  HCC model used for calculation

- version:

  Library version

- diagnosis_codes:

  Input diagnosis codes

- service_level_data:

  Processed service records

## Value

A `<RAFResult>` S7 object

## Examples

``` r
RAFResult()
#> <hcc::RAFResult>
#>  @ risk_score             : num(0) 
#>  @ risk_score_demographics: num(0) 
#>  @ risk_score_chronic_only: num(0) 
#>  @ risk_score_hcc         : num(0) 
#>  @ risk_score_payment     : num(0) 
#>  @ hcc_list               : chr(0) 
#>  @ hcc_details            : chr(0) 
#>  @ cc_to_dx               : chr(0) 
#>  @ coefficients           : num(0) 
#>  @ interactions           : chr(0) 
#>  @ demographics           : chr(0) 
#>  @ model_name             : chr(0) 
#>  @ version                : chr(0) 
#>  @ diagnosis_codes        : chr(0) 
#>  @ service_level_data     : list()
```
