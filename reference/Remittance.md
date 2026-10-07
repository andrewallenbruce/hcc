# Remittance Line Item

A single remittance line item within a member's payment record.

## Usage

``` r
Remittance(
  reference = character(0),
  original = numeric(0),
  adjustment = numeric(0),
  payment = numeric(0),
  rate = character(0),
  aid = character(0),
  plan = character(0),
  reason = character(0),
  description = character(0),
  coverage = c(.Date(numeric(0L)), .Date(numeric(0L)))
)
```

## Arguments

- reference:

  `<chr>` `RMR-02` Invoice/check reference number

- original:

  `<chr>` `RMR-05/RMR-06` Original amount before adjustment (when
  present)

- adjustment:

  `<chr>` `ADX-01` Adjustment amount; If negative, it is a recoupment

- payment:

  `<chr>` `RMR-04/RMR-05` Net payment amount for this period; negative =
  recoupment

- rate:

  `<chr>` `REF*18` Rate code (e.g., "957" = PACE rate)

- aid:

  `<chr>` `REF*ZZ` California Medi-Cal aid code (e.g., "1H", "M1", "60")

- plan:

  `<chr>` `REF*ZZ` Plan type; Composite aid_code;plan_type

  - "1": primary/medical

  - "2" = pharmacy/state-only

- reason:

  `<chr>` `ADX-02` Adjustment reason code ("53" = prior period)

- description:

  `<chr>` `REF*ZZ` Payment description (e.g., "Primary Capitation Dual",
  "Medi-Cal Only-State Only")

- coverage:

  `<class_iv>` Coverage period start and end date (YYYY-MM-DD) from
  DTM\*582

## Value

A `<hcc::Remittance>` S7 object

## Details

Each Remittance corresponds to one RMR segment and its associated REF,
DTM, and ADX segments within an ENT loop of an 820 transaction.
