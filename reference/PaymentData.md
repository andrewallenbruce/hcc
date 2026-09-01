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
  members = PaymentDetail()
)
```

## Arguments

- source:

  `<chr>` `ISA-06` Interchange sender ID, e.g., "CALIFORNIA-DHCS"

- report_date:

  `<Date>` `GS-04` Transaction date (YYYY-MM-DD)

- total_amount:

  `<chr>` `BPR-02` Total payment amount

- payment_date:

  `<Date>` `BPR-16` EFT effective date (YYYY-MM-DD)

- check_number:

  `<chr>` `TRN-02` EFT/check trace number

- payee_name:

  `<chr>` `N1*PE` Receiving organization name

- payee_address_1:

  `<chr>` `N3` Payee street address

- payee_city:

  `<chr>` `N4` Payee city

- payee_state:

  `<chr>` `N4` Payee state

- payee_zip:

  `<chr>` `N4` Payee ZIP code

- payer_name:

  `<chr>` `N1*PR` Paying organization name

- payer_address_1:

  `<chr>` `N3` Payer street address

- payer_city:

  `<chr>` `N4` Payer city

- payer_state:

  `<chr>` `N4` Payer state

- payer_zip:

  `<chr>` `N4` Payer ZIP code

- members:

  `<PaymentDetail>` List of per-member payment records

## Value

A `<PaymentData>` S7 object

## Examples

``` r
if (FALSE) {
PaymentData()
}
```
