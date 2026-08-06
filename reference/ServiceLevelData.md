# Represents standardized service-level data extracted from healthcare claims.

Represents standardized service-level data extracted from healthcare
claims.

## Usage

``` r
ServiceLevelData(
  claim_id,
  procedure_code,
  ndc,
  linked_diagnosis_codes,
  claim_diagnosis_codes,
  claim_type,
  provider_specialty,
  performing_provider_npi,
  billing_provider_npi,
  patient_id,
  facility_type,
  service_type,
  service_date,
  place_of_service,
  quantity,
  quantity_unit,
  modifiers,
  allowed_amount
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
if (FALSE) {
ServiceLevelData()
}
```
