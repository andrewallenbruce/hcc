# Healthcare Claim Service Level Data

Healthcare Claim Service Level Data

## Usage

``` r
ServiceData(
  service_date = .Date(numeric(0L)),
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

  `DTP*472` Date service was performed (YYYY-MM-DD)

- claim_id:

  `CLM-01` Unique identifier for the claim

- patient_id:

  `<chr>` Unique identifier for the patient

- claim_type:

  `<chr>` Type of claim (e.g., NCH Claim Type Code, or 837I, 837P)

- place_of_service:

  `CLM-05` Place of service code

- facility_type:

  `CLM-05` Type of facility where service was rendered

- service_type:

  `CLM-05` Type of service provided (facility type + service type = Type
  of Bill)

- linked_diagnosis_codes:

  `HI-01` ICD-10 diagnosis codes linked to this service

- claim_diagnosis_codes:

  `<chr>` All diagnosis codes on the claim

- provider_specialty:

  `PRV*BI-03` Provider taxonomy or specialty code

- performing_provider_npi:

  `NM1*82` NPI for performing provider

- billing_provider_npi:

  `NM1*85` NPI for billing provider

- procedure_code:

  `SV1-01` HCPCS code

- modifiers:

  `SV1-01` List of procedure code modifiers

- ndc:

  `LIN-03` `<chr>` National Drug Code

- quantity:

  `CTP-04` Number of units provided

- unit:

  `CTP-05` Unit of measure for quantity

- allowed_amount:

  `SV1-02` Allowed amount for the service

## Value

A `<ServiceData>` S7 object

## Examples

``` r
ServiceData(
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
  allowed_amount = "89.93"
)
#> <hcc::ServiceData>
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
