# Risk Adjustment Factor score results

Risk Adjustment Factor score results

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

- service_level_data:

  `<ServiceLevelData>` S7 object; Processed service records

## Value

A `<RAFResult>` S7 object

## Examples

``` r
RAFResult()
#> Error in if (perl0(x, "-")) {    as.Date(x)} else {    as.Date.character(x, format = "%Y%m%d", ...)}: argument is of length zero
```
