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
x =  parse_218(edi_index(hcc::x12_EX$`820`$`218`$sample_820_01))
#> Error in parse_218(edi_index(hcc::x12_EX$`820`$`218`$sample_820_01)): could not find function "parse_218"
PaymentData(
  source = purrr::pluck(x, "header", "ISA", 6L),
  report_date = purrr::pluck(x, "header", "GS", 4L),
  total_amount = purrr::pluck(x, "details", 1L, 3L),
  payment_date = purrr::pluck(x, "details", 1L, 17L),
  check_number = purrr::pluck(x, "details", 2L, 3L),
  payee_name = purrr::pluck(x, "details", 4L, 3L),
  payee_address = purrr::pluck(x, "details", 5L, 2L),
  payee_city = purrr::pluck(x, "details", 6L, 2L),
  payee_state = purrr::pluck(x, "details", 6L, 3L),
  payee_zip = purrr::pluck(x, "details", 6L, 4L),
  payer_name = purrr::pluck(x, "details", 7L, 3L),
  payer_address = purrr::pluck(x, "details", 8L, 2L),
  payer_city = purrr::pluck(x, "details", 9L, 2L),
  payer_state = purrr::pluck(x, "details", 9L, 3L),
  payer_zip = purrr::pluck(x, "details", 9L, 4L),
  payment_details = list(
    PaymentDetail(
      entity_number = purrr::pluck(x, "entity", 1L, 1L, 1L, 2L),
      member_id = purrr::pluck(x, "entity", 1L, 1L, 2L, 10L),
      last_name = purrr::pluck(x, "entity", 1L, 1L, 2L, 4L),
      first_name = purrr::pluck(x, "entity", 1L, 1L, 2L, 5L),
      middle_name = purrr::pluck(x, "entity", 1L, 1L, 2L, 6L),
      remittances = list(
        RemittanceEntry(
          reference_number = purrr::pluck(x, "entity", 1L, 2L, 1L, 3L),
          payment_amount = purrr::pluck(x, "entity", 1L, 2L, 1L, 5L, .default = NA_real_),
          original_amount = purrr::pluck(x, "entity", 1L, 2L, 1L, 6L, .default = NA_real_),
          adjustment_amount = NA_real_,
          adjustment_reason = NA_character_,
          rate_code = purrr::pluck(x, "entity", 1L, 2L, 3L, 3L),
          aid_code = substring(purrr::pluck(x, "entity", 1L, 2L, 3L, 3L), 1L, 2L),
          plan_type = substring(purrr::pluck(x, "entity", 1L, 2L, 3L, 3L), 4L),
          payment_description = purrr::pluck(x, "entity", 1L, 2L, 4L, 3L),
          coverage_period = purrr::pluck(x, "entity", 1L, 2L, 5L, 7L)
        )
      )
    ),
    PaymentDetail(
      entity_number = purrr::pluck(x, "entity", 7L, 1L, 1L, 2L),
      member_id = purrr::pluck(x, "entity", 7L, 1L, 2L, 10L),
      last_name = purrr::pluck(x, "entity", 7L, 1L, 2L, 4L),
      first_name = purrr::pluck(x, "entity", 7L, 1L, 2L, 5L),
      middle_name = purrr::pluck(x, "entity", 7L, 1L, 2L, 6L),
      remittances = list(
        RemittanceEntry(
          reference_number = purrr::pluck(x, "entity", 7L, 2L, 1L, 3L),
          payment_amount = purrr::pluck(x, "entity", 7L, 2L, 1L, 5L, .default = NA_real_),
          original_amount = purrr::pluck(x, "entity", 7L, 2L, 1L, 6L, .default = NA_real_),
          adjustment_amount = NA_real_,
          adjustment_reason = NA_character_,
          rate_code = purrr::pluck(x, "entity", 7L, 2L, 3L, 3L),
          aid_code = substring(purrr::pluck(x, "entity", 7L, 2L, 3L, 3L), 1L, 2L),
          plan_type = substring(purrr::pluck(x, "entity", 7L, 2L, 3L, 3L), 4L),
          payment_description = purrr::pluck(x, "entity", 7L, 2L, 4L, 3L),
          coverage_period = purrr::pluck(x, "entity", 7L, 2L, 5L, 7L)
        ),
        RemittanceEntry(
          reference_number = purrr::pluck(x, "entity", 7L, 2L, 6L, 3L),
          payment_amount = purrr::pluck(x, "entity", 7L, 2L, 6L, 5L, .default = NA_real_),
          original_amount = purrr::pluck(x, "entity", 7L, 2L, 6L, 6L, .default = NA_real_),
          adjustment_amount = NA_real_,
          adjustment_reason = NA_character_,
          rate_code = purrr::pluck(x, "entity", 7L, 2L, 7L, 3L),
          aid_code = substring(purrr::pluck(x, "entity", 7L, 2L, 8L, 3L), 1L, 2L),
          plan_type = substring(purrr::pluck(x, "entity", 7L, 2L, 8L, 3L), 4L),
          payment_description = purrr::pluck(x, "entity", 7L, 2L, 9L, 3L),
          coverage_period = purrr::pluck(x, "entity", 7L, 2L, 10L, 7L)
        )
      )
    )
  )
)
#> Error: object 'x' not found
```
