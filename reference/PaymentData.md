# X12-820 Transaction Remittance Data

Represents one ST\*820 transaction, typically a capitation payment
remittance from a state Medicaid agency or CMS to a managed care plan.

## Usage

``` r
PaymentData(
  source = character(0),
  report_date = character(0),
  total_amount = numeric(0),
  payment_date = character(0),
  check_number = character(0),
  payee_name = character(0),
  payee_address = character(0),
  payee_city = character(0),
  payee_state = character(0),
  payee_zip = character(0),
  payer_name = character(0),
  payer_address = character(0),
  payer_city = character(0),
  payer_state = character(0),
  payer_zip = character(0),
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

- payee_address:

  `<chr>` `N3` Payee street address

- payee_city:

  `<chr>` `N4` Payee city

- payee_state:

  `<chr>` `N4` Payee state

- payee_zip:

  `<chr>` `N4` Payee ZIP code

- payer_name:

  `<chr>` `N1*PR` Paying organization name

- payer_address:

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
