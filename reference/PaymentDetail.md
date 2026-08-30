# Per-Member Payment Record from an X12-820 ENT Loop

One PaymentDetail is created per ENT segment. A member may appear in
multiple ENT entries within the same transaction (e.g., retroactive
adjustments for prior periods).

## Usage

``` r
PaymentDetail(
  entity_number = character(),
  member_id = character(),
  last_name = character(),
  first_name = character(),
  middle_name = character(),
  remittance_entries = character()
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
if (FALSE) {
PaymentDetail()
}
```
