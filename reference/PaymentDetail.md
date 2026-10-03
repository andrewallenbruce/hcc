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

## Examples

``` r
PaymentDetail(
  entity_number = "1",
  member_id = "TESTMBR000000001",
  last_name = "LASTNAME01",
  first_name = "FIRSTNAME01",
  remittances = list(
    RemittanceEntry(
      reference_number = "TESTPLAN-SREGLR-2602200043000P",
      payment_amount = 401.72,
      original_amount = 8488.25,
      rate_code = "957",
      aid_code = "17",
      plan_type = "2",
      payment_description = "Dual-State Only",
      coverage_period = c("2026-01-01", "2026-01-31"),
      adjustment_amount = -8086.53,
      adjustment_reason = "53"
    ),
    RemittanceEntry(
      reference_number = "TESTPLAN-SREGLR-2602200043000P",
      payment_amount = 401.72,
      original_amount = 8488.25,
      rate_code = "957",
      aid_code = "17",
      plan_type = "2",
      payment_description = "Dual-State Only",
      coverage_period = c("2026-01-01", "2026-01-31"),
      adjustment_amount = -8086.53,
      adjustment_reason = "53"
    )
  )
)
#> Error in .c(x, y) %=% .subset2(strsplit(x, "-", fixed = TRUE), 1L): length(lhs) must be equal to length(rhs)
```
