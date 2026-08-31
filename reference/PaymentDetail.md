# Per-Member Payment Record from an X12-820 ENT Loop

One PaymentDetail is created per ENT segment. A member may appear in
multiple ENT entries within the same transaction (e.g., retroactive
adjustments for prior periods).

## Usage

``` r
PaymentDetail(
  entity_number = character(0),
  member_id = character(0),
  last_name = character(0),
  first_name = character(0),
  middle_name = character(0),
  remittance_entries = RemittanceEntry()
)
```

## Arguments

- entity_number:

  `ENT-01` ENT sequence number

- member_id:

  `NM1-09` Member identifier

- last_name:

  `NM1-03` Member last name

- first_name:

  `NM1-04` Member first name

- middle_name:

  `NM1-05` Member middle name

- remittance_entries:

  List of `<RemittanceEntry>` line items (one per RMR/DTM set)

## Value

A `<PaymentDetail>` S7 object

## Examples

``` r
PaymentDetail()
#> <hcc::PaymentDetail>
#>  @ entity_number     : chr(0) 
#>  @ member_id         : chr(0) 
#>  @ last_name         : chr(0) 
#>  @ first_name        : chr(0) 
#>  @ middle_name       : chr(0) 
#>  @ remittance_entries: <hcc::RemittanceEntry>
#>  .. @ reference_number     : chr(0) 
#>  .. @ payment_amount       : num(0) 
#>  .. @ original_amount      : num(0) 
#>  .. @ rate_code            : chr(0) 
#>  .. @ aid_code             : chr(0) 
#>  .. @ plan_type            : chr(0) 
#>  .. @ description          : chr(0) 
#>  .. @ coverage_period_start: chr(0) 
#>  .. @ coverage_period_end  : chr(0) 
#>  .. @ adjustment_amount    : num(0) 
#>  .. @ adjustment_reason    : chr(0) 
```
