# Per-Member Payment Record from an X12-820 ENT Loop

One PaymentDetail is created per ENT segment. A member may appear in
multiple ENT entries within the same transaction (e.g., retroactive
adjustments for prior periods).

## Usage

``` r
PaymentDetail(
  entity_number = integer(0),
  member_id = character(0),
  last_name = character(0),
  first_name = character(0),
  middle_name = character(0),
  remittances = list()
)
```

## Arguments

- entity_number:

  `<int>` `ENT-01` ENT sequence number

- member_id:

  `<chr>` `NM1-09` Member identifier

- last_name:

  `<chr>` `NM1-03` Member last name

- first_name:

  `<chr>` `NM1-04` Member first name

- middle_name:

  `<chr>` `NM1-05` Member middle name

- remittances:

  list of `<RemittanceEntry>` objects, line items (one per RMR/DTM set)

## Value

A `<PaymentDetail>` S7 object
