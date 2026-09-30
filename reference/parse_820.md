# X12-820 (X306/X218) Payment Order/Remittance Advice Parser

Parses X12-820 (005010X218) transactions for Medicaid/Medicare
capitation and premium payments. Designed for California DHCS PACE
capitation remittances but handles the general 820 format used by state
Medicaid agencies.

## Usage

``` r
parse_820(x)
```

## Arguments

- x:

  `<chr>` string of raw X12-820 text

## Value

list of `<hcc::X12_820_218>` S7 objects

## Details

Key segments parsed:

- `ISA/GS`: Interchange and group headers (source ID, report date)

- `BPR`: Payment amount and effective date

- `TRN`: EFT/check trace number

- `N1/N3/N4`: Payer and payee name and address

- `ENT`: Per-member entity loop start

- `NM1`: Member name and ID

- `RMR`: Remittance line item (reference number, payment amount)

- `REF*18`: Rate code (e.g., `957` = PACE rate)

- `REF*ZZ`: Aid code/plan type composite and description

- `DTM*582`: Coverage period date range

- `ADX`: Adjustment amount and reason code

Typical loop structure within an `820-X218`:

- Header: `ISA` \> `GS` \> `ST` \> `BPR` \> `TRN` \> `N1*PE` \> `N1*PR`

- Per-member: `ENT` \> `NM1` \> (`RMR` \> `REF*18` \> `REF*ZZ` \>
  `REF*ZZ` \> `DTM*582` \> `ADX`)

- Trailer: `SE` \> `GE` \> `IEA`

## Examples

``` r
create_index(hcc::x12_EX$`820`$`218`) |>
  purrr::map(parse_820) |>
  str(list.len = 10L)
#> List of 10
#>  $ 820_Child_Health_Plus_Payment_EFT:List of 13
#>   ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   ..$ GS : chr [1:8] "RA" "EMEDNYBAT" "ETIN" "20141231" ...
#>   ..$ ST : chr [1:3] "820" "222222222" "005010X218"
#>   ..$ BPR: chr [1:16] "I" "239.6" "C" "ACH" ...
#>   ..$ TRN: chr [1:3] "3" "021300000000000" "1141797357"
#>   ..$ REF: chr [1:2] "14" "12345678"
#>   ..$ N1 : chr [1:4] "PE" "MANAGED CARE" "FI" "123456789"
#>   ..$ N1_: chr [1:2] "PR" "CHILD HEALTH PLUS"
#>   ..$    :List of 5
#>   .. ..$ ENT: chr [1:4] "1" "2L" "24" "141797357"
#>   .. ..$ RMR: chr [1:4] "1L" "12345678" NA "-5.55"
#>   .. ..$ REF: chr [1:2] "ZZ" "RECOVERY OF FUNDS"
#>   .. ..$ RMR: chr [1:4] "1L" "12345678" NA "96.96"
#>   .. ..$ REF: chr [1:2] "ZZ" "LUMP SUM PAYMENT"
#>   ..$    :List of 7
#>   .. ..$ ENT: chr [1:4] "2" "2J" "EI" "PATIENT ACCOUNT NUMBER"
#>   .. ..$ NM1: chr [1:9] "QE" "1" "LAST NAME" "FIRST NAME" ...
#>   .. ..$ RMR: chr [1:4] "AZ" "12345678" NA "148.19"
#>   .. ..$ REF: chr [1:2] "ZZ" "1436500000001230"
#>   .. ..$ REF: chr [1:2] "ZZ" "0123456789"
#>   .. ..$ REF: chr [1:2] "LU" "01"
#>   .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. [list output truncated]
#>  $ 820_Essentail_Health_Plan        :List of 14
#>   ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   ..$ GS : chr [1:8] "RA" "EMEDNYBAT" "ETIN" "20150105" ...
#>   ..$ ST : chr [1:3] "820" "221500001" "005010X218"
#>   ..$ BPR: chr [1:16] "I" "123.45" "C" "CHK" ...
#>   ..$ TRN: chr [1:3] "3" "000000032788113" "1141797357"
#>   ..$ REF: chr [1:2] "14" "12345678"
#>   ..$ N1 : chr [1:4] "PE" NA "FI" "123456789"
#>   ..$ N1_: chr [1:2] "PR" "BASIC HEALTH PLAN"
#>   ..$ N3 : chr [1:2] "OFFICE OF HEALTH INSURANCE PROGRAMS" "CORNING TOWER, EMPIRE STATE PLAZA"
#>   ..$ N4 : chr [1:3] "ALBANY" "NY" "122370080"
#>   .. [list output truncated]
#>  $ 820_Premium_Payment_EFT          :List of 14
#>   ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   ..$ GS : chr [1:8] "RA" "EMEDNYBAT" "ETIN" "20141231" ...
#>   ..$ ST : chr [1:3] "820" "222222222" "005010X218"
#>   ..$ BPR: chr [1:16] "I" "566.29" "C" "ACH" ...
#>   ..$ TRN: chr [1:3] "3" "021300000000000" "1141797357"
#>   ..$ REF: chr [1:2] "14" "12345678"
#>   ..$ N1 : chr [1:4] "PE" "MANAGED CARE" "FI" "123456789"
#>   ..$ N1_: chr [1:4] "PR" "NYSDOH" "FI" "141797357"
#>   ..$    :List of 7
#>   .. ..$ ENT: chr [1:4] "1" "2L" "24" "141797357"
#>   .. ..$ RMR: chr [1:4] "1L" "12345678" NA "-63.34"
#>   .. ..$ REF: chr [1:2] "ZZ" "RECOVERY OF FUNDS"
#>   .. ..$ RMR: chr [1:4] "1L" "12345678" NA "8.89"
#>   .. ..$ REF: chr [1:2] "ZZ" "COURT ORDERED PAYMENT"
#>   .. ..$ RMR: chr [1:4] "1L" "12345678" NA "-12.67"
#>   .. ..$ REF: chr [1:2] "ZZ" "STATE MANDATED PAYMENT REDUCT"
#>   ..$    :List of 4
#>   .. ..$ ENT: chr [1:4] "2" "2J" "EI" "PATIENT ACCOUNT NUMBER"
#>   .. ..$ NM1: chr [1:9] "QE" "1" "LAST NAME" "FIRST NAME" ...
#>   .. ..$ RMR: chr [1:5] "IK" "1000210000000020" NA "183.47" ...
#>   .. ..$ ADX: chr [1:2] "181.64" "IA"
#>   .. [list output truncated]
#>  $ 820_Premium_Payment_NOPMT        :List of 15
#>   ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   ..$ GS : chr [1:8] "RA" "EMEDNYBAT" "ETIN" "20100101" ...
#>   ..$ ST : chr [1:3] "820" "173900001" "005010X218"
#>   ..$ BPR: chr [1:16] "I" "0" "C" "NON" ...
#>   ..$ TRN: chr [1:3] "3" "021300000000000" "1123456789"
#>   ..$ REF: chr [1:2] "14" "12345678"
#>   ..$ N1 : chr [1:4] "PE" "MANAGED CARE" "FI" "123456789"
#>   ..$ N1_: chr [1:4] "PR" "NYSDOH" "FI" "141797357"
#>   ..$ N3 : chr [1:2] "OFFICE OF HEALTH INSURANCE PROGRAMS" "CORNING TOWER, EMPIRE STATE PLAZA"
#>   ..$ N4 : chr [1:3] "ALBANY" "NY" "12204"
#>   .. [list output truncated]
#>  $ payment_order_820_218            :List of 12
#>   ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   ..$ GS : chr [1:8] "HC" "XXXXXXX" "XXXXX" "20170617" ...
#>   ..$ ST : chr [1:3] "820" "0001" "005010X218"
#>   ..$ BPR: chr [1:16] "C" "19000" "C" "ACH" ...
#>   ..$ TRN: chr [1:3] "1" "12345" "1030449999"
#>   ..$ REF: chr [1:2] "14" "12345"
#>   ..$ N1 : chr [1:4] "PE" "DEF HEALTH CARE INC." "FI" "012222222"
#>   ..$ N1_: chr [1:4] "PR" "ABC PLASTICS" "FI" "123456789"
#>   ..$    :List of 8
#>   .. ..$ ENT: chr [1:4] "1" "2L" "FI" "123456789"
#>   .. ..$ RMR: chr [1:4] "IK" "970501001" "PI" "16500"
#>   .. ..$ IT1: chr "1"
#>   .. ..$ SLN: chr [1:5] "1" NA "O" "5" ...
#>   .. ..$ SLN: chr [1:5] "2" NA "O" "75" ...
#>   .. ..$ RMR: chr [1:4] "IK" "970501002" "PI" "250"
#>   .. ..$ IT1: chr "1"
#>   .. ..$ SLN: chr [1:5] "1" NA "O" "25" ...
#>   ..$ SE : chr [1:2] "15" "0001"
#>   .. [list output truncated]
#>  $ sample_820_01                    :List of 27
#>   ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   ..$ GS : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20260118" ...
#>   ..$ ST : chr [1:3] "820" "0001" "005010X218"
#>   ..$ BPR: chr [1:16] "I" "102139.46" "C" "NON" ...
#>   ..$ TRN: chr [1:2] "3" "TESTTRN01000001"
#>   ..$ REF: chr [1:2] "14" "0000245023"
#>   ..$ N1 : chr [1:2] "PE" "TEST PAYEE ORGANIZATION"
#>   ..$ N3 : chr "123 TEST STREET"
#>   ..$ N4 : chr [1:3] "TESTCITY" "CA" "00000"
#>   ..$ N1_: chr [1:2] "PR" "TEST PAYER AGENCY"
#>   .. [list output truncated]
#>  $ sample_820_02                    :List of 28
#>   ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   ..$ GS : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20260316" ...
#>   ..$ ST : chr [1:3] "820" "0001" "005010X218"
#>   ..$ BPR: chr [1:16] "I" "91977.81" "C" "NON" ...
#>   ..$ TRN: chr [1:2] "3" "TESTTRN02000001"
#>   ..$ REF: chr [1:2] "14" "0000245023"
#>   ..$ N1 : chr [1:2] "PE" "TEST PAYEE ORGANIZATION"
#>   ..$ N3 : chr "123 TEST STREET"
#>   ..$ N4 : chr [1:3] "TESTCITY" "CA" "00000"
#>   ..$ N1_: chr [1:2] "PR" "TEST PAYER AGENCY"
#>   .. [list output truncated]
#>  $ sample_820_03                    :List of 108
#>   ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   ..$ GS : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20260316" ...
#>   ..$ ST : chr [1:3] "820" "0001" "005010X218"
#>   ..$ BPR: chr [1:16] "I" "697085.64" "C" "NON" ...
#>   ..$ TRN: chr [1:2] "3" "TESTTRN03000001"
#>   ..$ REF: chr [1:2] "14" "0000245023"
#>   ..$ N1 : chr [1:2] "PE" "TEST PAYEE ORGANIZATION"
#>   ..$ N3 : chr "123 TEST STREET"
#>   ..$ N4 : chr [1:3] "TESTCITY" "CA" "00000"
#>   ..$ N1_: chr [1:2] "PR" "TEST PAYER AGENCY"
#>   .. [list output truncated]
#>  $ sample_820_04                    :List of 25
#>   ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   ..$ GS : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20251217" ...
#>   ..$ ST : chr [1:3] "820" "0001" "005010X218"
#>   ..$ BPR: chr [1:16] "I" "80865.30" "C" "NON" ...
#>   ..$ TRN: chr [1:2] "3" "TESTTRN04000001"
#>   ..$ REF: chr [1:2] "14" "0000245023"
#>   ..$ N1 : chr [1:2] "PE" "TEST PAYEE ORGANIZATION"
#>   ..$ N3 : chr "123 TEST STREET"
#>   ..$ N4 : chr [1:3] "TESTCITY" "CA" "00000"
#>   ..$ N1_: chr [1:2] "PR" "TEST PAYER AGENCY"
#>   .. [list output truncated]
#>  $ sample_820_05                    :List of 96
#>   ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   ..$ GS : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20260217" ...
#>   ..$ ST : chr [1:3] "820" "0001" "005010X218"
#>   ..$ BPR: chr [1:16] "I" "499187.57" "C" "NON" ...
#>   ..$ TRN: chr [1:2] "3" "TESTTRN05000001"
#>   ..$ REF: chr [1:2] "14" "0000245023"
#>   ..$ N1 : chr [1:2] "PE" "TEST PAYEE ORGANIZATION"
#>   ..$ N3 : chr "123 TEST STREET"
#>   ..$ N4 : chr [1:3] "TESTCITY" "CA" "00000"
#>   ..$ N1_: chr [1:2] "PR" "TEST PAYER AGENCY"
#>   .. [list output truncated]
```
