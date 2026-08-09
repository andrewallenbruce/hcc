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

  Invoice/check reference number (RMR02)

- payment_amount:

  Net payment amount for this period; negative = recoupment (RMR04/05)

- original_amount:

  Original amount before adjustment, when present (RMR05/06)

- rate_code:

  Rate code from REF\*18 (e.g., "957" = PACE rate)

- aid_code:

  California Medi-Cal aid code from REF\*ZZ (e.g., "1H", "M1", "60")

- plan_type:

  Plan type from REF\*ZZ composite aid_code;plan_type ("1" =
  primary/medical, "2" = pharmacy/state-only)

- description:

  Payment description from second REF\*ZZ (e.g., "Primary Capitation
  Dual", "Medi-Cal Only-State Only")

- coverage_period_start:

  Coverage period begin date (YYYY-MM-DD) from DTM\*582

- coverage_period_end:

  Coverage period end date (YYYY-MM-DD) from DTM\*582

- adjustment_amount:

  Adjustment amount from ADX01 (negative = recoupment)

- adjustment_reason:

  Adjustment reason code from ADX02 (e.g., "53" = prior period)

## Value

A object

## Examples

``` r
RemittanceEntry()
#> $reference_number
#> character(0)
#> 
#> $payment_amount
#> numeric(0)
#> 
#> $original_amount
#> numeric(0)
#> 
#> $rate_code
#> character(0)
#> 
#> $aid_code
#> character(0)
#> 
#> $plan_type
#> character(0)
#> 
#> $description
#> character(0)
#> 
#> $coverage_period_start
#> character(0)
#> 
#> $coverage_period_end
#> character(0)
#> 
#> $adjustment_amount
#> numeric(0)
#> 
#> $adjustment_reason
#> character(0)
#> 
```
