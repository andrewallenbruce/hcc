# Healthcare Claim Service Level Data

Healthcare Claim Service Level Data

## Usage

``` r
ServiceLevelData(
  service_date = .Date(numeric()),
  claim_id = character(0),
  patient_id = character(0),
  claim_type = character(0),
  place_of_service = character(0),
  facility_type = character(0),
  service_type = character(0),
  linked_diagnosis_codes = character(0),
  claim_diagnosis_codes = character(0),
  provider_specialty = character(0),
  performing_provider_npi = integer(0),
  billing_provider_npi = integer(0),
  procedure_code = character(0),
  modifiers = character(0),
  ndc = character(0),
  quantity = integer(0),
  unit = character(0),
  allowed_amount = numeric(0)
)
```

## Arguments

- service_date:

  `<Date>` Date service was performed (YYYY-MM-DD)

- claim_id:

  `<chr>` Unique identifier for the claim

- patient_id:

  `<chr>` Unique identifier for the patient

- claim_type:

  `<chr>` Type of claim (e.g., NCH Claim Type Code, or 837I, 837P)

- place_of_service:

  `<chr>` Place of service code

- facility_type:

  `<chr>` Type of facility where service was rendered

- service_type:

  `<chr>` Type of service provided (facility type + service type = Type
  of Bill)

- linked_diagnosis_codes:

  `<chr>` ICD-10 diagnosis codes linked to this service

- claim_diagnosis_codes:

  `<chr>` All diagnosis codes on the claim

- provider_specialty:

  `<chr>` Provider taxonomy or specialty code

- performing_provider_npi:

  `<int>` NPI for performing provider

- billing_provider_npi:

  `<int>` NPI for billing provider

- procedure_code:

  `<chr>` HCPCS code

- modifiers:

  `<chr>` List of procedure code modifiers

- ndc:

  `<chr>` National Drug Code

- quantity:

  `<num>` Number of units provided

- unit:

  `<chr>` Unit of measure for quantity

- allowed_amount:

  `<num>` Allowed amount for the service

## Value

A `<ServiceLevelData>` S7 object

## Examples

``` r
ServiceLevelData(
  claim_id = "756048Q",
  procedure_code = "93005",
  ndc = "85972-161",
  linked_diagnosis_codes = c("3669", "4019", "79431"),
  claim_diagnosis_codes = c("3669", "4019", "79431"),
  claim_type = "837I",
  provider_specialty = "203BA0200N",
  performing_provider_npi = "1876540809",
  billing_provider_npi = "1234567891",
  patient_id = "030005074A",
  facility_type = "14",
  service_type = "03",
  service_date = "1996-09-11",
  place_of_service = "11",
  quantity = "4",
  unit = "UN",
  modifiers = c("F1", "QQ"),
  allowed_amount = 89.93
)
#> Error in ServiceLevelData(claim_id = "756048Q", procedure_code = "93005",     ndc = "85972-161", linked_diagnosis_codes = c("3669", "4019",         "79431"), claim_diagnosis_codes = c("3669", "4019", "79431"),     claim_type = "837I", provider_specialty = "203BA0200N", performing_provider_npi = "1876540809",     billing_provider_npi = "1234567891", patient_id = "030005074A",     facility_type = "14", service_type = "03", service_date = "1996-09-11",     place_of_service = "11", quantity = "4", unit = "UN", modifiers = c("F1",         "QQ"), allowed_amount = 89.93): <hcc::ServiceLevelData> object properties are invalid:
#> - @service_date must be S3<Date>, not <character>
```
