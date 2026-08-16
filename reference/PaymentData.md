# X12-820 Transaction Remittance Data

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

  `ISA-06` Interchange sender ID, e.g., "CALIFORNIA-DHCS"

- report_date:

  `GS-04` Transaction date (YYYY-MM-DD)

- total_amount:

  `BPR-02` Total payment amount

- payment_date:

  `BPR-16` EFT effective date (YYYY-MM-DD)

- check_number:

  `TRN-02` EFT/check trace number

- payee_name:

  `N1*PE` Receiving organization name

- payee_address_1:

  `N3` Payee street address

- payee_city:

  `N4` Payee city

- payee_state:

  `N4` Payee state

- payee_zip:

  `N4` Payee ZIP code

- payer_name:

  `N1*PR` Paying organization name

- payer_address_1:

  `N3` Payer street address

- payer_city:

  `N4` Payer city

- payer_state:

  `N4` Payer state

- payer_zip:

  `N4` Payer ZIP code

- members:

  List of per-member payment records

## Value

A `<PaymentData>` S7 object

## Examples

``` r
if (FALSE) {
PaymentData()
}
```
