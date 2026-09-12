# Healthcare Claim Service Level Data

Healthcare Claim Service Level Data

## Usage

``` r
ServiceLevelData(
  claim_id = character(0),
  procedure_code = character(0),
  ndc = character(0),
  linked_diagnosis_codes = character(0),
  claim_diagnosis_codes = character(0),
  claim_type = character(0),
  provider_specialty = character(0),
  performing_provider_npi = character(0),
  billing_provider_npi = character(0),
  patient_id = character(0),
  facility_type = character(0),
  service_type = character(0),
  service_date = character(0),
  place_of_service = character(0),
  quantity = integer(0),
  quantity_unit = character(0),
  modifiers = character(0),
  allowed_amount = integer(0)
)
```

## Arguments

- claim_id:

  `<chr>` Unique identifier for the claim

- procedure_code:

  `<chr>` HCPCS code

- ndc:

  `<chr>` National Drug Code

- linked_diagnosis_codes:

  `<chr>` ICD-10 diagnosis codes linked to this service

- claim_diagnosis_codes:

  `<chr>` All diagnosis codes on the claim

- claim_type:

  `<chr>` Type of claim (e.g., NCH Claim Type Code, or 837I, 837P)

- provider_specialty:

  `<chr>` Provider taxonomy or specialty code

- performing_provider_npi:

  `<chr>` National Provider Identifier for performing provider

- billing_provider_npi:

  `<chr>` National Provider Identifier for billing provider

- patient_id:

  `<chr>` Unique identifier for the patient

- facility_type:

  `<chr>` Type of facility where service was rendered

- service_type:

  `<chr>` Type of service provided (facility type + service type = Type
  of Bill)

- service_date:

  `<chr>` Date service was performed (YYYY-MM-DD)

- place_of_service:

  `<chr>` Place of service code

- quantity:

  `<num>` Number of units provided

- quantity_unit:

  `<chr>` Unit of measure for quantity

- modifiers:

  `<chr>` List of procedure code modifiers

- allowed_amount:

  `<num>` Allowed amount for the service

## Value

A `<ServiceLevelData>` S7 object

## Examples

``` r
ServiceLevelData(
  claim_id = "756048Q",
  procedure_code = c("85025", "93005"),
  claim_diagnosis_codes = c("3669", "4019", "79431"),
  claim_type = "837I",
  provider_specialty = "203BA0200N",
  billing_provider_npi = "9876540809",
  patient_id = "030005074A",
  facility_type = "14",
  service_date = c("19960911", "19960911"),
  quantity = c(1L, 3L),
  quantity_unit = "UN",
  allowed_amount = 89.93
)
#> <hcc::ServiceLevelData>
#>  @ claim_id               : chr "756048Q"
#>  @ procedure_code         : chr [1:2] "85025" "93005"
#>  @ ndc                    : chr(0) 
#>  @ linked_diagnosis_codes : chr(0) 
#>  @ claim_diagnosis_codes  : chr [1:3] "3669" "4019" "79431"
#>  @ claim_type             : chr "837I"
#>  @ provider_specialty     : chr "203BA0200N"
#>  @ performing_provider_npi: chr(0) 
#>  @ billing_provider_npi   : chr "9876540809"
#>  @ patient_id             : chr "030005074A"
#>  @ facility_type          : chr "14"
#>  @ service_type           : chr(0) 
#>  @ service_date           : chr [1:2] "19960911" "19960911"
#>  @ place_of_service       : chr(0) 
#>  @ quantity               : int [1:2] 1 3
#>  @ quantity_unit          : chr "UN"
#>  @ modifiers              : chr(0) 
#>  @ allowed_amount         : num 89.9
```
