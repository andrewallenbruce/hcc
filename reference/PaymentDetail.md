# Per-Member Payment Record from an X12-820 ENT Loop

One PaymentDetail is created per ENT segment. A member may appear in
multiple ENT entries within the same transaction (e.g., retroactive
adjustments for prior periods).

## Arguments

- entity_number:

  `<chr>` `ENT-01` ENT sequence number

- member_id:

  `<chr>` `NM1-09` Member identifier

- last_name:

  `<chr>` `NM1-03` Member last name

- first_name:

  `<chr>` `NM1-04` Member first name

- middle_name:

  `<chr>` `NM1-05` Member middle name

- remittance_entries:

  List of `<RemittanceEntry>` line items (one per RMR/DTM set)

## Value

A `<PaymentDetail>` S7 object

## Examples

``` r
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
      description = "Dual-State Only",
      coverage_start = "2026-01-01",
      coverage_end = "2026-01-31",
      adjustment_amount = -8086.53,
      adjustment_reason = "53"
    )
  )
)
#> <hcc::PaymentDetail>
#>  @ entity_number     : chr "1"
#>  @ member_id         : chr "TESTMBR000000001"
#>  @ last_name         : chr "LASTNAME01"
#>  @ first_name        : chr "FIRSTNAME01"
#>  @ middle_name       : chr(0) 
#>  @ remittance_entries:List of 1
#>  .. $ : <hcc::RemittanceEntry>
#>  ..  ..@ reference_number : chr "TESTPLAN-SREGLR-2602200043000P"
#>  ..  ..@ payment_amount   : num 402
#>  ..  ..@ original_amount  : num 8488
#>  ..  ..@ rate_code        : chr "957"
#>  ..  ..@ aid_code         : chr "17"
#>  ..  ..@ plan_type        : chr "2"
#>  ..  ..@ description      : chr "Dual-State Only"
#>  ..  ..@ coverage_start   : Date[1:1], format: "2026-01-01"
#>  ..  ..@ coverage_end     : Date[1:1], format: "2026-01-31"
#>  ..  ..@ adjustment_amount: num -8087
#>  ..  ..@ adjustment_reason: chr "53"
```
