# A single remittance line item within a member's payment record.

Each RemittanceEntry corresponds to one RMR segment and its associated
REF, DTM, and ADX segments within an ENT loop of an 820 transaction.

## Usage

``` r
RemittanceEntry(
  reference_number = character(),
  payment_amount = double(),
  original_amount = double(),
  rate_code = character(),
  aid_code = character(),
  plan_type = character(),
  description = character(),
  coverage_period_start = character(),
  coverage_period_end = character(),
  adjustment_amount = double(),
  adjustment_reason = character()
)
```

## Arguments

- reference_number:

  `RMR-02` Invoice/check reference number

- payment_amount:

  `RMR-04/RMR-05` Net payment amount for this period; negative =
  recoupment

- original_amount:

  `RMR-05/RMR-06` Original amount before adjustment, when present

- rate_code:

  `REF*18` Rate code (e.g., "957" = PACE rate)

- aid_code:

  `REF*ZZ` California Medi-Cal aid code (e.g., "1H", "M1", "60")

- plan_type:

  `REF*ZZ` Plan type - composite aid_code;plan_type ("1" =
  primary/medical, "2" = pharmacy/state-only)

- description:

  `REF*ZZ` Payment description (e.g., "Primary Capitation Dual",
  "Medi-Cal Only-State Only")

- coverage_period_start:

  `DTM*582` Coverage period begin date (YYYY-MM-DD)

- coverage_period_end:

  `DTM*582` Coverage period end date (YYYY-MM-DD) from DTM\*582

- adjustment_amount:

  `ADX-01` Adjustment amount (negative = recoupment)

- adjustment_reason:

  `ADX-02` Adjustment reason code (e.g., "53" = prior period)

## Value

A `<RemittanceEntry>` S7 object

## Examples

``` r
if (FALSE) {
RemittanceEntry()
}
```
