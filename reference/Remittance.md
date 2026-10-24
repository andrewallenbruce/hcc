# Remittance Line Item

A single remittance line item within a member's payment record.

## Usage

``` r
Remittance(
  reference = NA_character_,
  original = numeric(0),
  adjustment = numeric(0),
  payment = numeric(0),
  rate = NA_character_,
  aid = NA_character_,
  plan = NA_character_,
  reason = NA_character_,
  description = NA_character_,
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

  - `1`: primary/medical

  - `2`: pharmacy/state-only

- reason:

  `<chr>` `ADX-02` Adjustment reason code ("53" = prior period)

- description:

  `<chr>` `REF*ZZ` Payment description (e.g., "Primary Capitation Dual",
  "Medi-Cal Only-State Only")

- coverage:

  `<DTM*582>` Coverage period start and end date (YYYY-MM-DD)

## Value

A `<hcc::Remittance>` S7 object

## Details

Each Remittance corresponds to one RMR segment and its associated REF,
DTM, and ADX segments within an ENT loop of an 820 transaction.
