# Represents standardized service-level data extracted from healthcare claims.

Represents standardized service-level data extracted from healthcare
claims.

## Usage

``` r
ServiceLevelData(
  claim_id = character(),
  procedure_code = character(),
  ndc = character(),
  linked_diagnosis_codes = character(),
  claim_diagnosis_codes = character(),
  claim_type = character(),
  provider_specialty = character(),
  performing_provider_npi = character(),
  billing_provider_npi = character(),
  patient_id = character(),
  facility_type = character(),
  service_type = character(),
  service_date = character(),
  place_of_service = character(),
  quantity = character(),
  quantity_unit = character(),
  modifiers = character(),
  allowed_amount = character()
)
```

## Arguments

- claim_id:

  Unique identifier for the claim

- procedure_code:

  Healthcare Common Procedure Coding System (HCPCS) code

- ndc:

  National Drug Code

- linked_diagnosis_codes:

  ICD-10 diagnosis codes linked to this service

- claim_diagnosis_codes:

  All diagnosis codes on the claim

- claim_type:

  Type of claim (e.g., NCH Claim Type Code, or 837I, 837P)

- provider_specialty:

  Provider taxonomy or specialty code

- performing_provider_npi:

  National Provider Identifier for performing provider

- billing_provider_npi:

  National Provider Identifier for billing provider

- patient_id:

  Unique identifier for the patient

- facility_type:

  Type of facility where service was rendered

- service_type:

  Type of service provided (facility type + service type = Type of Bill)

- service_date:

  Date service was performed (YYYY-MM-DD)

- place_of_service:

  Place of service code

- quantity:

  Number of units provided

- quantity_unit:

  Unit of measure for quantity

- modifiers:

  List of procedure code modifiers

- allowed_amount:

  Allowed amount for the service

## Value

object

## Examples

``` r
ServiceLevelData()
#> $claim_id
#> character(0)
#> 
#> $procedure_code
#> character(0)
#> 
#> $ndc
#> character(0)
#> 
#> $linked_diagnosis_codes
#> character(0)
#> 
#> $claim_diagnosis_codes
#> character(0)
#> 
#> $claim_type
#> character(0)
#> 
#> $provider_specialty
#> character(0)
#> 
#> $performing_provider_npi
#> character(0)
#> 
#> $billing_provider_npi
#> character(0)
#> 
#> $patient_id
#> character(0)
#> 
#> $facility_type
#> character(0)
#> 
#> $service_type
#> character(0)
#> 
#> $service_date
#> character(0)
#> 
#> $place_of_service
#> character(0)
#> 
#> $quantity
#> character(0)
#> 
#> $quantity_unit
#> character(0)
#> 
#> $modifiers
#> character(0)
#> 
#> $allowed_amount
#> character(0)
#> 
```
