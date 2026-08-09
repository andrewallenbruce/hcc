# Per-Member Payment Record from an X12 820 ENT Loop

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

  ENT sequence number (ENT01)

- member_id:

  Member identifier from NM109

- last_name:

  Member last name (NM103)

- first_name:

  Member first name (NM104)

- middle_name:

  Member middle name (NM105)

- remittance_entries:

  List of remittance line items (one per RMR/DTM set)

## Value

A object

## Examples

``` r
PaymentDetail()
#> $entity_number
#> character(0)
#> 
#> $member_id
#> character(0)
#> 
#> $last_name
#> character(0)
#> 
#> $first_name
#> character(0)
#> 
#> $middle_name
#> character(0)
#> 
#> $remittance_entries
#> character(0)
#> 
```
