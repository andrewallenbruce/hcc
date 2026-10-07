# Per-Member Payment Record from an X12-820 ENT Loop

One Payment is created per ENT segment. A member may appear in multiple
ENT entries within the same transaction (e.g., retroactive adjustments
for prior periods).

## Usage

``` r
Payment(order = integer(0), member = Member(), remits = list())
```

## Arguments

- order:

  `<int>` `ENT-01` ENT sequence number

- member:

  `<hcc::Member>`

  - `NM1-09` Member identifier

  - `NM1-03` Member last name

  - `NM1-04` Member first name

  - `NM1-05` Member middle name

- remits:

  list of `<hcc::Remittance>` objects, line items (one per RMR/DTM set)

## Value

A `<hcc::Payment>` S7 object
