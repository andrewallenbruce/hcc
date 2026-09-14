# X12-820 Transaction Remittance Data

Represents one ST\*820 transaction, typically a capitation payment
remittance from a state Medicaid agency or CMS to a managed care plan.

## Arguments

- source:

  `<chr>` `ISA-06` Interchange sender ID, e.g., "CALIFORNIA-DHCS"

- report_date:

  `<Date>` `GS-04` Transaction date (YYYY-MM-DD)

- total_amount:

  `<chr>` `BPR-02` Total payment amount

- payment_date:

  `<Date>` `BPR-16` EFT effective date (YYYY-MM-DD)

- check_number:

  `<chr>` `TRN-02` EFT/check trace number

- payee_name:

  `<chr>` `N1*PE` Receiving organization name

- payee_address:

  `<chr>` `N3` Payee street address

- payee_city:

  `<chr>` `N4` Payee city

- payee_state:

  `<chr>` `N4` Payee state

- payee_zip:

  `<chr>` `N4` Payee ZIP code

- payer_name:

  `<chr>` `N1*PR` Paying organization name

- payer_address:

  `<chr>` `N3` Payer street address

- payer_city:

  `<chr>` `N4` Payer city

- payer_state:

  `<chr>` `N4` Payer state

- payer_zip:

  `<chr>` `N4` Payer ZIP code

- payment_details:

  `<PaymentDetail>` List of per-member payment records

## Value

A `<PaymentData>` S7 object

## Examples

``` r
PaymentData(
  source = "TEST-PAYER",
  report_date = "2026-03-16",
  payment_date = "2026-03-12",
  total_amount = 91977.81,
  check_number = "TESTTRN02000001",
  payee_name = "TEST PAYEE ORGANIZATION",
  payee_address = "123 TEST STREET",
  payee_city = "TESTCITY",
  payee_state = "CA",
  payee_zip = "00000",
  payer_name = "TEST PAYER AGENCY",
  payer_address = "123 TEST STREET",
  payer_city = "TESTCITY",
  payer_state = "CA",
  payer_zip = "00000",
  payment_details = list(
    PaymentDetail(
      entity_number = "1",
      member_id = "TESTMBR000000001",
      last_name = "LASTNAME01",
      first_name = "FIRSTNAME01",
      remittance_entries = list(
        RemittanceEntry(
          reference_number = "TESTPLAN-SREGLR-2602200043000P",
          payment_amount = 401.72,
          original_amount = 8488.25,
          rate_code = "957",
          aid_code = "17",
          plan_type = "2",
          payment_description = "Dual-State Only",
          coverage_start = "2026-01-01",
          coverage_end = "2026-01-31",
          coverage_period = ivs::iv_pairs(c(as.Date("2026-01-01"), as.Date("2026-01-31") + 1L)),
          adjustment_amount = -8086.53,
          adjustment_reason = "53"
        )
      )
    )
  )
)
#> <hcc::PaymentData>
#>  @ source         : chr "TEST-PAYER"
#>  @ report_date    : Date[1:1], format: "2026-03-16"
#>  @ payment_date   : Date[1:1], format: "2026-03-12"
#>  @ total_amount   : num 91978
#>  @ check_number   : chr "TESTTRN02000001"
#>  @ payee_name     : chr "TEST PAYEE ORGANIZATION"
#>  @ payee_address  : chr "123 TEST STREET"
#>  @ payee_city     : chr "TESTCITY"
#>  @ payee_state    : chr "CA"
#>  @ payee_zip      : chr "00000"
#>  @ payer_name     : chr "TEST PAYER AGENCY"
#>  @ payer_address  : chr "123 TEST STREET"
#>  @ payer_city     : chr "TESTCITY"
#>  @ payer_state    : chr "CA"
#>  @ payer_zip      : chr "00000"
#>  @ payment_details:List of 1
#>  .. $ : <hcc::PaymentDetail>
#>  ..  ..@ entity_number     : chr "1"
#>  ..  ..@ member_id         : chr "TESTMBR000000001"
#>  ..  ..@ last_name         : chr "LASTNAME01"
#>  ..  ..@ first_name        : chr "FIRSTNAME01"
#>  ..  ..@ middle_name       : chr(0) 
#>  ..  ..@ remittance_entries:List of 1
#>  .. .. .. $ : <hcc::RemittanceEntry>
#>  .. .. ..  ..@ reference_number   : chr "TESTPLAN-SREGLR-2602200043000P"
#>  .. .. ..  ..@ payment_amount     : num 402
#>  .. .. ..  ..@ original_amount    : num 8488
#>  .. .. ..  ..@ rate_code          : chr "957"
#>  .. .. ..  ..@ aid_code           : chr "17"
#>  .. .. ..  ..@ plan_type          : chr "2"
#>  .. .. ..  ..@ payment_description: chr "Dual-State Only"
#>  .. .. ..  ..@ coverage_start     : Date[1:1], format: "2026-01-01"
#>  .. .. ..  ..@ coverage_end       : Date[1:1], format: "2026-01-31"
#>  .. .. ..  ..@ coverage_period    : iv<date> [1:1] [2026-01-01, 2026-02-01)
#>  .. .. ..  ..@ adjustment_amount  : num -8087
#>  .. .. ..  ..@ adjustment_reason  : chr "53"
```
