# Remittance Line Item

A single remittance line item within a member's payment record.

## Arguments

- reference_number:

  `<chr>` `RMR-02` Invoice/check reference number

- payment_amount:

  `<chr>` `RMR-04/RMR-05` Net payment amount for this period; negative =
  recoupment

- original_amount:

  `<chr>` `RMR-05/RMR-06` Original amount before adjustment (when
  present)

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

- coverage_start:

  `<Date>` `DTM*582` Coverage period begin date (YYYY-MM-DD)

- coverage_end:

  `<Date>` `DTM*582` Coverage period end date (YYYY-MM-DD) from DTM\*582

- coverage_period:

  `<iv>` Coverage period start and end date

- adjustment_amount:

  `<chr>` `ADX-01` Adjustment amount; If negative, it is a recoupment

- adjustment_reason:

  `<chr>` `ADX-02` Adjustment reason code ("53" = prior period)

## Value

A `<RemittanceEntry>` S7 object

## Details

Each RemittanceEntry corresponds to one RMR segment and its associated
REF, DTM, and ADX segments within an ENT loop of an 820 transaction.

## Examples

``` r
RemittanceEntry(
  reference_number = "TESTPLAN-SREGLR-2602200043000P",
  payment_amount = 401.72,
  original_amount = 8488.25,
  rate_code = "957",
  aid_code = "17",
  plan_type = "2",
  payment_description = "Dual-State Only",
  coverage_start = "2026-01-01",
  coverage_end = "2026-01-31",
  coverage_period = ivs::iv_pairs(c(as.Date("2026-01-01"), as.Date("2026-01-31") + 1L)),
  adjustment_amount = -8086.53,
  adjustment_reason = "53"
)
#> <hcc::RemittanceEntry>
#>  @ reference_number   : chr "TESTPLAN-SREGLR-2602200043000P"
#>  @ payment_amount     : num 402
#>  @ original_amount    : num 8488
#>  @ rate_code          : chr "957"
#>  @ aid_code           : chr "17"
#>  @ plan_type          : chr "2"
#>  @ payment_description: chr "Dual-State Only"
#>  @ coverage_start     : Date[1:1], format: "2026-01-01"
#>  @ coverage_end       : Date[1:1], format: "2026-01-31"
#>  @ coverage_period    : iv<date> [1:1] [2026-01-01, 2026-02-01)
#>  @ adjustment_amount  : num -8087
#>  @ adjustment_reason  : chr "53"
```
