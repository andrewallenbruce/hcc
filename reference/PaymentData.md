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
  payee = class_entity(),
  payer = class_entity(),
  payments = list()
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

- payee:

  `<hcc::class_entity>` Receiving organization name, street address,
  city, state, zip

- payer:

  `<hcc::class_entity>` Paying organization name, street address, city,
  state, zip

- payments:

  list of `<hcc::Payment>` objects, per-member payment records

## Value

A `<hcc::PaymentData>` S7 object

## Examples

``` r
x =  hcc:::parse_218(edi_index(hcc::x12_EX$`820`$`218`$sample_820_01))
PaymentData(
  source = purrr::pluck(x, "header", "ISA", 6L),
  report_date = purrr::pluck(x, "header", "GS", 4L),
  total_amount = purrr::pluck(x, "details", 1L, 3L),
  payment_date = purrr::pluck(x, "details", 1L, 17L),
  check_number = purrr::pluck(x, "details", 2L, 3L),
  payee = hcc:::class_entity(
    name = purrr::pluck(x, "details", 4L, 3L),
    address = c(
      purrr::pluck(x, "details", 5L, 2L),
      purrr::pluck(x, "details", 6L, 2L),
      purrr::pluck(x, "details", 6L, 3L),
      purrr::pluck(x, "details", 6L, 4L)
    )
  ),
  payer = hcc:::class_entity(
    name = purrr::pluck(x, "details", 7L, 3L),
    address = c(
      purrr::pluck(x, "details", 8L, 2L),
      purrr::pluck(x, "details", 9L, 2L),
      purrr::pluck(x, "details", 9L, 3L),
      purrr::pluck(x, "details", 9L, 4L)
    )
  ),
  payments = list(
    Payment(
      order = purrr::pluck(x, "entity", 1L, 1L, 1L, 2L),
      member = hcc:::class_member(
        id = purrr::pluck(x, "entity", 1L, 1L, 2L, 10L),
        last = purrr::pluck(x, "entity", 1L, 1L, 2L, 4L),
        first = purrr::pluck(x, "entity", 1L, 1L, 2L, 5L),
        middle = purrr::pluck(x, "entity", 1L, 1L, 2L, 6L)
      ),
      remits = list(
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
    Payment(
      order = purrr::pluck(x, "entity", 7L, 1L, 1L, 2L),
      member = hcc:::class_member(
        id = purrr::pluck(x, "entity", 7L, 1L, 2L, 10L),
        last = purrr::pluck(x, "entity", 7L, 1L, 2L, 4L),
        first = purrr::pluck(x, "entity", 7L, 1L, 2L, 5L),
        middle = purrr::pluck(x, "entity", 7L, 1L, 2L, 6L)
      ),
      remits = list(
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
#> <hcc::PaymentData>
#>  @ source      : chr "TEST-PAYER"
#>  @ report_date : Date[1:1], format: "2026-01-18"
#>  @ payment_date: Date[1:1], format: "2026-01-15"
#>  @ total_amount: num 102139
#>  @ check_number: chr "TESTTRN01000001"
#>  @ payee       : <hcc::class_entity>
#>  .. @ name   : chr "TEST PAYEE ORGANIZATION"
#>  .. @ address: chr [1:4] "123 TEST STREET" "TESTCITY" "CA" "00000"
#>  @ payer       : <hcc::class_entity>
#>  .. @ name   : chr "TEST PAYER AGENCY"
#>  .. @ address: chr [1:4] "123 TEST STREET" "TESTCITY" "CA" "00000"
#>  @ payments    :List of 2
#>  .. $ : <hcc::Payment>
#>  ..  ..@ order : int 1
#>  ..  ..@ member: <hcc::class_member>
#>  .. .. .. @ id    : chr "TESTMBR000000001"
#>  .. .. .. @ last  : chr "LASTNAME01"
#>  .. .. .. @ first : chr "FIRSTNAME01"
#>  .. .. .. @ middle: chr NA
#>  ..  ..@ remits:List of 1
#>  .. .. .. $ : <hcc::RemittanceEntry>
#>  .. .. ..  ..@ reference_number   : chr "TESTPLAN-SREGLR-2512150225000P"
#>  .. .. ..  ..@ original_amount    : num NA
#>  .. .. ..  ..@ adjustment_amount  : num NA
#>  .. .. ..  ..@ payment_amount     : num 8087
#>  .. .. ..  ..@ adjustment_reason  : chr NA
#>  .. .. ..  ..@ rate_code          : chr "1H;2"
#>  .. .. ..  ..@ aid_code           : chr "1H"
#>  .. .. ..  ..@ plan_type          : chr "2"
#>  .. .. ..  ..@ payment_description: chr "Medi-Cal Only-State Only"
#>  .. .. ..  ..@ coverage_period    : iv<date> [1:1] [2025-12-01, 2026-01-01)
#>  .. $ : <hcc::Payment>
#>  ..  ..@ order : int 7
#>  ..  ..@ member: <hcc::class_member>
#>  .. .. .. @ id    : chr "TESTMBR000000007"
#>  .. .. .. @ last  : chr "LASTNAME07"
#>  .. .. .. @ first : chr "FIRSTNAME07"
#>  .. .. .. @ middle: chr NA
#>  ..  ..@ remits:List of 2
#>  .. .. .. $ : <hcc::RemittanceEntry>
#>  .. .. ..  ..@ reference_number   : chr "TESTPLAN-SREGLR-2512150225000P"
#>  .. .. ..  ..@ original_amount    : num NA
#>  .. .. ..  ..@ adjustment_amount  : num NA
#>  .. .. ..  ..@ payment_amount     : num 8087
#>  .. .. ..  ..@ adjustment_reason  : chr NA
#>  .. .. ..  ..@ rate_code          : chr "M1;2"
#>  .. .. ..  ..@ aid_code           : chr "M1"
#>  .. .. ..  ..@ plan_type          : chr "2"
#>  .. .. ..  ..@ payment_description: chr "Medi-Cal Only-State Only"
#>  .. .. ..  ..@ coverage_period    : iv<date> [1:1] [2025-12-01, 2026-01-01)
#>  .. .. .. $ : <hcc::RemittanceEntry>
#>  .. .. ..  ..@ reference_number   : chr "TESTPLAN-SREGLR-2512150225000P"
#>  .. .. ..  ..@ original_amount    : num NA
#>  .. .. ..  ..@ adjustment_amount  : num NA
#>  .. .. ..  ..@ payment_amount     : num 8087
#>  .. .. ..  ..@ adjustment_reason  : chr NA
#>  .. .. ..  ..@ rate_code          : chr "957"
#>  .. .. ..  ..@ aid_code           : chr "M1"
#>  .. .. ..  ..@ plan_type          : chr "2"
#>  .. .. ..  ..@ payment_description: chr "Medi-Cal Only-State Only"
#>  .. .. ..  ..@ coverage_period    : iv<date> [1:1] [2025-11-01, 2025-12-01)
```
