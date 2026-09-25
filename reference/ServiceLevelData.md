# Healthcare Claim Service Level Data

Healthcare Claim Service Level Data

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

  `<int>` NPI for performing provider

- billing_provider_npi:

  `<int>` NPI for billing provider

- patient_id:

  `<chr>` Unique identifier for the patient

- facility_type:

  `<chr>` Type of facility where service was rendered

- service_type:

  `<chr>` Type of service provided (facility type + service type = Type
  of Bill)

- service_date:

  `<Date>` Date service was performed (YYYY-MM-DD)

- place_of_service:

  `<chr>` Place of service code

- quantity:

  `<num>` Number of units provided

- unit:

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
#> <hcc::ServiceLevelData>
#>  @ service_date           : Date[1:1], format: "1996-09-11"
#>  @ claim_id               : chr "756048Q"
#>  @ patient_id             : chr "030005074A"
#>  @ claim_type             : chr "837I"
#>  @ place_of_service       : chr "11"
#>  @ facility_type          : chr "14"
#>  @ service_type           : chr "03"
#>  @ linked_diagnosis_codes : chr [1:3] "3669" "4019" "79431"
#>  @ claim_diagnosis_codes  : chr [1:3] "3669" "4019" "79431"
#>  @ provider_specialty     : chr "203BA0200N"
#>  @ performing_provider_npi: int 1876540809
#>  @ billing_provider_npi   : int 1234567891
#>  @ procedure_code         : chr "93005"
#>  @ modifiers              : chr [1:2] "F1" "QQ"
#>  @ ndc                    : chr "85972-161"
#>  @ quantity               : int 4
#>  @ unit                   : chr "UN"
#>  @ allowed_amount         : num 89.9
```
