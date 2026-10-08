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
  payee = Party(),
  payer = Party(),
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

  `<hcc::Party>` Receiving organization name, street address, city,
  state, zip

- payer:

  `<hcc::Party>` Paying organization name, street address, city, state,
  zip

- payments:

  list of `<hcc::Payment>` objects, per-member payment records

## Value

A `<hcc::PaymentData>` S7 object

## Examples

``` r
x = edi_index(hcc::x12_EX$`820`$`218`$sample_820_01)
x = edi_parse(x)
PaymentData(
  source = purrr::pluck(x, "header", "ISA", 6L),
  report_date = purrr::pluck(x, "header", "GS", 4L),
  total_amount = purrr::pluck(x, "details", 1L, 3L),
  payment_date = purrr::pluck(x, "details", 1L, 17L),
  check_number = purrr::pluck(x, "details", 2L, 3L),
  payee = hcc:::Party(
    name = purrr::pluck(x, "details", 4L, 3L),
    address = c(
      purrr::pluck(x, "details", 5L, 2L),
      purrr::pluck(x, "details", 6L, 2L),
      purrr::pluck(x, "details", 6L, 3L),
      purrr::pluck(x, "details", 6L, 4L))),
  payer = hcc:::Party(
    name = purrr::pluck(x, "details", 7L, 3L),
    address = c(
      purrr::pluck(x, "details", 8L, 2L),
      purrr::pluck(x, "details", 9L, 2L),
      purrr::pluck(x, "details", 9L, 3L),
      purrr::pluck(x, "details", 9L, 4L))),
  payments = list(
    Payment(
      order = purrr::pluck(x, "entity", 1L, 1L, 2L),
      member = hcc:::Member(
        id = purrr::pluck(x, "entity", 1L, 2L, 10L),
        last = purrr::pluck(x, "entity", 1L, 2L, 4L),
        first = purrr::pluck(x, "entity", 1L, 2L, 5L)),
      remits = list(
        Remittance(
          reference = purrr::pluck(x, "entity", 2L, 1L, 3L),
          payment = purrr::pluck(x, "entity", 2L, 1L, 5L, .default = NA_real_),
          original = purrr::pluck(x, "entity", 2L, 1L, 6L, .default = NA_real_),
          rate = purrr::pluck(x, "entity", 2L, 2L, 3L),
          aid = substring(purrr::pluck(x, "entity", 2L, 3L, 3L), 1L, 2L),
          plan = substring(purrr::pluck(x, "entity", 2L, 3L, 3L), 4L),
          description = purrr::pluck(x, "entity", 2L, 4L, 3L),
          coverage = purrr::pluck(x, "entity", 2L, 5L, 7L)))),
    Payment(
      order = purrr::pluck(x, "entity", 7L, 1L, 2L),
      member = hcc:::Member(
        id = purrr::pluck(x, "entity", 7L, 2L, 10L),
        last = purrr::pluck(x, "entity", 7L, 2L, 4L),
        first = purrr::pluck(x, "entity", 7L, 2L, 5L)),
      remits = list(
        Remittance(
          reference = purrr::pluck(x, "entity", 8L, 1L, 3L),
          payment = purrr::pluck(x, "entity", 8L, 1L, 5L, .default = NA_real_),
          original = purrr::pluck(x, "entity", 8L, 1L, 6L, .default = NA_real_),
          rate = purrr::pluck(x, "entity", 8L, 2L, 3L),
          aid = substring(purrr::pluck(x, "entity", 8L, 3L, 3L), 1L, 2L),
          plan = substring(purrr::pluck(x, "entity", 8L, 3L, 3L), 4L),
          description = purrr::pluck(x, "entity", 8L, 4L, 3L),
          coverage = purrr::pluck(x, "entity", 8L, 5L, 7L))))))
#> <hcc::PaymentData>
#>  @ source      : chr "TEST-PAYER"
#>  @ report_date : Date[1:1], format: "2026-01-18"
#>  @ payment_date: Date[1:1], format: "2026-01-15"
#>  @ total_amount: num 102139
#>  @ check_number: chr "TESTTRN01000001"
#>  @ payee       : <hcc::Party>
#>  .. @ name   : chr "TEST PAYEE ORGANIZATION"
#>  .. @ address: chr [1:4] "123 TEST STREET" "TESTCITY" "CA" "00000"
#>  @ payer       : <hcc::Party>
#>  .. @ name   : chr "TEST PAYER AGENCY"
#>  .. @ address: chr [1:4] "123 TEST STREET" "TESTCITY" "CA" "00000"
#>  @ payments    :List of 2
#>  .. $ : <hcc::Payment>
#>  ..  ..@ order : int 1
#>  ..  ..@ member: <hcc::Member>
#>  .. .. .. @ id    : chr "TESTMBR000000001"
#>  .. .. .. @ last  : chr "LASTNAME01"
#>  .. .. .. @ first : chr "FIRSTNAME01"
#>  .. .. .. @ middle: chr(0) 
#>  ..  ..@ remits:List of 1
#>  .. .. .. $ : <hcc::Remittance>
#>  .. .. ..  ..@ reference  : chr "TESTPLAN-SREGLR-2512150225000P"
#>  .. .. ..  ..@ original   : num NA
#>  .. .. ..  ..@ adjustment : num(0) 
#>  .. .. ..  ..@ payment    : num 8087
#>  .. .. ..  ..@ rate       : chr "957"
#>  .. .. ..  ..@ aid        : chr "1H"
#>  .. .. ..  ..@ plan       : chr "2"
#>  .. .. ..  ..@ reason     : chr(0) 
#>  .. .. ..  ..@ description: chr "Medi-Cal Only-State Only"
#>  .. .. ..  ..@ coverage   : iv<date> [1:1] [2025-12-01, 2026-01-01)
#>  .. $ : <hcc::Payment>
#>  ..  ..@ order : int 4
#>  ..  ..@ member: <hcc::Member>
#>  .. .. .. @ id    : chr "TESTMBR000000004"
#>  .. .. .. @ last  : chr "LASTNAME04"
#>  .. .. .. @ first : chr "FIRSTNAME04"
#>  .. .. .. @ middle: chr(0) 
#>  ..  ..@ remits:List of 1
#>  .. .. .. $ : <hcc::Remittance>
#>  .. .. ..  ..@ reference  : chr "TESTPLAN-SREGLR-2512150225000P"
#>  .. .. ..  ..@ original   : num NA
#>  .. .. ..  ..@ adjustment : num(0) 
#>  .. .. ..  ..@ payment    : num 8087
#>  .. .. ..  ..@ rate       : chr "957"
#>  .. .. ..  ..@ aid        : chr "M1"
#>  .. .. ..  ..@ plan       : chr "2"
#>  .. .. ..  ..@ reason     : chr(0) 
#>  .. .. ..  ..@ description: chr "Medi-Cal Only-State Only"
#>  .. .. ..  ..@ coverage   : iv<date> [1:1] [2025-12-01, 2026-01-01)
```
