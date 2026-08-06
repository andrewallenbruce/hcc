# Risk adjustment calculation results

Risk adjustment calculation results

## Usage

``` r
RAFResult(
  risk_score,
  risk_score_demographics,
  risk_score_chronic_only,
  risk_score_hcc,
  risk_score_payment,
  hcc_list,
  hcc_details,
  cc_to_dx,
  coefficients,
  interactions,
  demographics,
  model_name,
  version,
  diagnosis_codes,
  service_level_data
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

object

## Examples

``` r
if (FALSE) {
RAFResult()
}
```
