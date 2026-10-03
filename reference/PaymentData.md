# X12-820 Transaction Remittance Data

Represents one ST\*820 transaction, typically a capitation payment
remittance from a state Medicaid agency or CMS to a managed care plan.

## Usage

``` r
PaymentData(
  source = character(0),
  report_date = .Date(numeric(0L)),
  payment_date = .Date(numeric(0L)),
  total_amount = numeric(0),
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
  payment_details = list()
)
```

## Arguments

- source:

  `<chr>` `ISA-06` Interchange sender ID, e.g., "CALIFORNIA-DHCS"

- report_date:

  `<Date>` `GS-04` Transaction date (YYYY-MM-DD)

- payment_date:

  `<Date>` `BPR-16` EFT effective date (YYYY-MM-DD)

- total_amount:

  `<chr>` `BPR-02` Total payment amount

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

- payment_details:

  list of `<PaymentDetail>` objects, per-member payment records

## Value

A `<PaymentData>` S7 object

## Examples

``` r
PaymentData(
  source = "TEST-PAYER",
  report_date = "2026-03-16",
  payment_date = "2026-03-12",
  total_amount = 91977.81,
  check_number = "TESTTRN02000001",
  payee_name = "TEST PAYEE ORGANIZATION",
  payee_address = "123 TEST STREET",
  payee_city = "TESTCITY",
  payee_state = "CA",
  payee_zip = "00000",
  payer_name = "TEST PAYER AGENCY",
  payer_address = "123 TEST STREET",
  payer_city = "TESTCITY",
  payer_state = "CA",
  payer_zip = "00000",
  payment_details = list(
    PaymentDetail(
      entity_number = "1",
      member_id = "TESTMBR000000001",
      last_name = "LASTNAME01",
      first_name = "FIRSTNAME01",
      remittances = list(
        RemittanceEntry(
          reference_number = "TESTPLAN-SREGLR-2602200043000P",
          payment_amount = 401.72,
          original_amount = 8488.25,
          rate_code = "957",
          aid_code = "17",
          plan_type = "2",
          payment_description = "Dual-State Only",
          coverage_period = c("2026-01-01", "2026-01-31"),
          adjustment_amount = -8086.53,
          adjustment_reason = "53"
        )
      )
    )
  )
)
#> Error in .c(x, y) %=% .subset2(strsplit(x, "-", fixed = TRUE), 1L): length(lhs) must be equal to length(rhs)
```
