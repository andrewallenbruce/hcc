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
RAFResult(service_level_data = list(ServiceLevelData(), ServiceLevelData()))
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
#>  @ service_level_data     :List of 2
#>  .. $ : <hcc::ServiceLevelData>
#>  ..  ..@ service_date           : Date[1:1], format: "2026-09-25"
#>  ..  ..@ claim_id               : chr(0) 
#>  ..  ..@ patient_id             : chr(0) 
#>  ..  ..@ claim_type             : chr(0) 
#>  ..  ..@ place_of_service       : chr(0) 
#>  ..  ..@ facility_type          : chr(0) 
#>  ..  ..@ service_type           : chr(0) 
#>  ..  ..@ linked_diagnosis_codes : chr(0) 
#>  ..  ..@ claim_diagnosis_codes  : chr(0) 
#>  ..  ..@ provider_specialty     : chr(0) 
#>  ..  ..@ performing_provider_npi: int(0) 
#>  ..  ..@ billing_provider_npi   : int(0) 
#>  ..  ..@ procedure_code         : chr(0) 
#>  ..  ..@ modifiers              : chr(0) 
#>  ..  ..@ ndc                    : chr(0) 
#>  ..  ..@ quantity               : int(0) 
#>  ..  ..@ unit                   : chr(0) 
#>  ..  ..@ allowed_amount         : num(0) 
#>  .. $ : <hcc::ServiceLevelData>
#>  ..  ..@ service_date           : Date[1:1], format: "2026-09-25"
#>  ..  ..@ claim_id               : chr(0) 
#>  ..  ..@ patient_id             : chr(0) 
#>  ..  ..@ claim_type             : chr(0) 
#>  ..  ..@ place_of_service       : chr(0) 
#>  ..  ..@ facility_type          : chr(0) 
#>  ..  ..@ service_type           : chr(0) 
#>  ..  ..@ linked_diagnosis_codes : chr(0) 
#>  ..  ..@ claim_diagnosis_codes  : chr(0) 
#>  ..  ..@ provider_specialty     : chr(0) 
#>  ..  ..@ performing_provider_npi: int(0) 
#>  ..  ..@ billing_provider_npi   : int(0) 
#>  ..  ..@ procedure_code         : chr(0) 
#>  ..  ..@ modifiers              : chr(0) 
#>  ..  ..@ ndc                    : chr(0) 
#>  ..  ..@ quantity               : int(0) 
#>  ..  ..@ unit                   : chr(0) 
#>  ..  ..@ allowed_amount         : num(0) 
```
