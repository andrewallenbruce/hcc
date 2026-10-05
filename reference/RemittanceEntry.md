# Remittance Line Item

A single remittance line item within a member's payment record.

## Usage

``` r
RemittanceEntry(
  reference_number = character(0),
  original_amount = numeric(0),
  adjustment_amount = numeric(0),
  payment_amount = numeric(0),
  adjustment_reason = character(0),
  rate_code = character(0),
  aid_code = character(0),
  plan_type = character(0),
  payment_description = character(0),
  coverage_period = c(.Date(numeric(0L)), .Date(numeric(0L)))
)
```

## Arguments

- reference_number:

  `<chr>` `RMR-02` Invoice/check reference number

- original_amount:

  `<chr>` `RMR-05/RMR-06` Original amount before adjustment (when
  present)

- adjustment_amount:

  `<chr>` `ADX-01` Adjustment amount; If negative, it is a recoupment

- payment_amount:

  `<chr>` `RMR-04/RMR-05` Net payment amount for this period; negative =
  recoupment

- adjustment_reason:

  `<chr>` `ADX-02` Adjustment reason code ("53" = prior period)

- rate_code:

  `<chr>` `REF*18` Rate code (e.g., "957" = PACE rate)

- aid_code:

  `<chr>` `REF*ZZ` California Medi-Cal aid code (e.g., "1H", "M1", "60")

- plan_type:

  `<chr>` `REF*ZZ` Plan type; Composite aid_code;plan_type

  - "1": primary/medical

  - "2" = pharmacy/state-only

- payment_description:

  `<chr>` `REF*ZZ` Payment description (e.g., "Primary Capitation Dual",
  "Medi-Cal Only-State Only")

- coverage_period:

  `<class_iv>` Coverage period start and end date (YYYY-MM-DD) from
  DTM\*582

## Value

A `<RemittanceEntry>` S7 object

## Details

Each RemittanceEntry corresponds to one RMR segment and its associated
REF, DTM, and ADX segments within an ENT loop of an 820 transaction.
