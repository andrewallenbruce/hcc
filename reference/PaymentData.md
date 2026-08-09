# Remittance Data from an X12 820 Transaction

Represents one ST\*820 transaction, typically a capitation payment
remittance from a state Medicaid agency or CMS to a managed care plan.

## Usage

``` r
PaymentData(
  source = character(),
  report_date = character(),
  total_amount = double(),
  payment_date = character(),
  check_number = character(),
  payee_name = character(),
  payee_address_1 = character(),
  payee_city = character(),
  payee_state = character(),
  payee_zip = character(),
  payer_name = character(),
  payer_address_1 = character(),
  payer_city = character(),
  payer_state = character(),
  payer_zip = character(),
  members = character()
)
```

## Arguments

- source:

  Interchange sender ID (ISA06), e.g., "CALIFORNIA-DHCS"

- report_date:

  Transaction date from GS04 (YYYY-MM-DD)

- total_amount:

  Total payment amount from BPR02

- payment_date:

  EFT effective date from BPR16 (YYYY-MM-DD)

- check_number:

  EFT/check trace number from TRN02

- payee_name:

  Receiving organization name (N1\*PE)

- payee_address_1:

  Payee street address (N3)

- payee_city:

  Payee city (N4)

- payee_state:

  Payee state (N4)

- payee_zip:

  Payee ZIP code (N4)

- payer_name:

  Paying organization name (N1\*PR)

- payer_address_1:

  Payer street address (N3)

- payer_city:

  Payer city (N4)

- payer_state:

  Payer state (N4)

- payer_zip:

  Payer ZIP code (N4)

- members:

  List of per-member payment records

## Value

A object

## Examples

``` r
PaymentData()
#> $source
#> character(0)
#> 
#> $report_date
#> character(0)
#> 
#> $total_amount
#> numeric(0)
#> 
#> $payment_date
#> character(0)
#> 
#> $check_number
#> character(0)
#> 
#> $payee_name
#> character(0)
#> 
#> $payee_address_1
#> character(0)
#> 
#> $payee_city
#> character(0)
#> 
#> $payee_state
#> character(0)
#> 
#> $payee_zip
#> character(0)
#> 
#> $payer_name
#> character(0)
#> 
#> $payer_address_1
#> character(0)
#> 
#> $payer_city
#> character(0)
#> 
#> $payer_state
#> character(0)
#> 
#> $payer_zip
#> character(0)
#> 
#> $members
#> character(0)
#> 
```
