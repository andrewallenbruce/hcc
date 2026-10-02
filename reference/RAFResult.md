# Risk Adjustment Factor Results

Risk Adjustment Factor Results

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
  service_data = list()
)
```

## Arguments

- risk_score:

  `<dbl>` Final RAF score

- risk_score_demographics:

  `<dbl>` Demographics-only risk score

- risk_score_chronic_only:

  `<dbl>` Chronic conditions risk score

- risk_score_hcc:

  `<dbl>` HCC conditions risk score

- risk_score_payment:

  `<dbl>` Payment RAF score, adjusted for MACI, normalization, and
  frailty

- hcc_list:

  `<chr>` List of active HCC categories

- hcc_details:

  `<chr>` Detailed HCC information with labels and chronic status

- cc_to_dx:

  Condition categories mapped to diagnosis codes

- coefficients:

  Applied model coefficients

- interactions:

  Disease interaction coefficients

- demographics:

  Patient demographics used in calculation

- model_name:

  `<chr>` HCC model used for calculation

- version:

  `<chr>` Library version

- diagnosis_codes:

  `<chr>` Input diagnosis codes

- service_data:

  list of `<ServiceLevelData>` objects, Processed service records

## Value

A `<RAFResult>` S7 object

## Examples

``` r
RAFResult(service_level_data = list(ServiceLevelData(), ServiceLevelData()))
#> Error in RAFResult(service_level_data = list(ServiceLevelData(), ServiceLevelData())): unused argument (service_level_data = list(ServiceLevelData(), ServiceLevelData()))
```
