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
create_index(hcc::x12_EX$`820`$`218`[1:3]) |>
  purrr::map(parse_820) |>
  str(list.len = 10L)
#> List of 3
#>  $ 820_Child_Health_Plus_Payment_EFT: <hcc::X12_820_218>
#>   ..@ ISA : chr [1:14] "00" "00" "ZZ" "EMEDNYBAT" ...
#>   ..@ GS  : chr [1:8] "RA" "EMEDNYBAT" "ETIN" "20141231" ...
#>   ..@ ST  : chr [1:3] "820" "222222222" "005010X218"
#>   ..@ BPR : chr [1:13] "I" "239.6" "C" "ACH" ...
#>   ..@ TRN : chr [1:3] "3" "021300000000000" "1141797357"
#>   ..@ RF14: chr "12345678"
#>   ..@ N1PE: chr [1:3] "MANAGED CARE" "FI" "123456789"
#>   ..@ N3PE: chr [1:2] "PR" "CHILD HEALTH PLUS"
#>   ..@ N4PE: chr [1:4] "1" "2L" "24" "141797357"
#>   ..@ N1PR: chr "CHILD HEALTH PLUS"
#>   ..@ N3PR: chr [1:4] "1" "2L" "24" "141797357"
#>   ..@ N4PR: chr [1:3] "1L" "12345678" "-5.55"
#>   ..@ ENT :List of 2
#>  .. .. $ 1:List of 5
#>  .. ..  ..$ : chr [1:5] "ENT" "1" "2L" "24" ...
#>  .. ..  ..$ : chr [1:4] "RMR" "1L" "12345678" "-5.55"
#>  .. ..  ..$ : chr [1:3] "REF" "ZZ" "RECOVERY OF FUNDS"
#>  .. ..  ..$ : chr [1:4] "RMR" "1L" "12345678" "96.96"
#>  .. ..  ..$ : chr [1:3] "REF" "ZZ" "LUMP SUM PAYMENT"
#>  .. .. $ 2:List of 7
#>  .. ..  ..$ : chr [1:5] "ENT" "2" "2J" "EI" ...
#>  .. ..  ..$ : chr [1:7] "NM1" "QE" "1" "LAST NAME" ...
#>  .. ..  ..$ : chr [1:4] "RMR" "AZ" "12345678" "148.19"
#>  .. ..  ..$ : chr [1:3] "REF" "ZZ" "1436500000001230"
#>  .. ..  ..$ : chr [1:3] "REF" "ZZ" "0123456789"
#>  .. ..  ..$ : chr [1:3] "REF" "LU" "01"
#>  .. ..  ..$ : chr [1:4] "DTM" "582" "RD8" "20141201-20141231"
#>   ..@ SE  : chr [1:2] "17" "222222222"
#>   ..@ GE  : chr [1:2] "1" "333333333"
#>   ..@ IEA : chr [1:2] "1" "003333333"
#>  $ 820_Essentail_Health_Plan        : <hcc::X12_820_218>
#>   ..@ ISA : chr [1:14] "00" "00" "ZZ" "EMEDNYBAT" ...
#>   ..@ GS  : chr [1:8] "RA" "EMEDNYBAT" "ETIN" "20150105" ...
#>   ..@ ST  : chr [1:3] "820" "221500001" "005010X218"
#>   ..@ BPR : chr [1:6] "I" "123.45" "C" "CHK" ...
#>   ..@ TRN : chr [1:3] "3" "000000032788113" "1141797357"
#>   ..@ RF14: chr "12345678"
#>   ..@ N1PE: chr [1:2] "FI" "123456789"
#>   ..@ N3PE: chr [1:2] "PR" "BASIC HEALTH PLAN"
#>   ..@ N4PE: chr [1:2] "OFFICE OF HEALTH INSURANCE PROGRAMS" "CORNING TOWER, EMPIRE STATE PLAZA"
#>   ..@ N1PR: chr "BASIC HEALTH PLAN"
#>   ..@ N3PR: chr [1:2] "OFFICE OF HEALTH INSURANCE PROGRAMS" "CORNING TOWER, EMPIRE STATE PLAZA"
#>   ..@ N4PR: chr [1:3] "ALBANY" "NY" "122370080"
#>   ..@ ENT :List of 1
#>  .. .. $ 1:List of 8
#>  .. ..  ..$ : chr [1:5] "ENT" "1" "2J" "EI" ...
#>  .. ..  ..$ : chr [1:7] "NM1" "QE" "1" "LASTNAME" ...
#>  .. ..  ..$ : chr [1:4] "RMR" "AZ" "LL88888L" "123.45"
#>  .. ..  ..$ : chr [1:3] "REF" "ZZ" "1500311111112540"
#>  .. ..  ..$ : chr [1:3] "REF" "ZZ" "0123456789"
#>  .. ..  ..$ : chr [1:3] "REF" "LU" "01"
#>  .. ..  ..$ : chr [1:3] "REF" "ZZ" "51"
#>  .. ..  ..$ : chr [1:4] "DTM" "582" "RD8" "20141201-20141231"
#>   ..@ SE  : chr [1:2] "14" "221500001"
#>   ..@ GE  : chr [1:2] "1" "5113240"
#>   ..@ IEA : chr [1:2] "1" "005113240"
#>  $ 820_Premium_Payment_EFT          : <hcc::X12_820_218>
#>   ..@ ISA : chr [1:14] "00" "00" "ZZ" "EMEDNYBAT" ...
#>   ..@ GS  : chr [1:8] "RA" "EMEDNYBAT" "ETIN" "20141231" ...
#>   ..@ ST  : chr [1:3] "820" "222222222" "005010X218"
#>   ..@ BPR : chr [1:13] "I" "566.29" "C" "ACH" ...
#>   ..@ TRN : chr [1:3] "3" "021300000000000" "1141797357"
#>   ..@ RF14: chr "12345678"
#>   ..@ N1PE: chr [1:3] "MANAGED CARE" "FI" "123456789"
#>   ..@ N3PE: chr [1:4] "PR" "NYSDOH" "FI" "141797357"
#>   ..@ N4PE: chr [1:4] "1" "2L" "24" "141797357"
#>   ..@ N1PR: chr [1:3] "NYSDOH" "FI" "141797357"
#>   ..@ N3PR: chr [1:4] "1" "2L" "24" "141797357"
#>   ..@ N4PR: chr [1:3] "1L" "12345678" "-63.34"
#>   ..@ ENT :List of 3
#>  .. .. $ 1:List of 7
#>  .. ..  ..$ : chr [1:5] "ENT" "1" "2L" "24" ...
#>  .. ..  ..$ : chr [1:4] "RMR" "1L" "12345678" "-63.34"
#>  .. ..  ..$ : chr [1:3] "REF" "ZZ" "RECOVERY OF FUNDS"
#>  .. ..  ..$ : chr [1:4] "RMR" "1L" "12345678" "8.89"
#>  .. ..  ..$ : chr [1:3] "REF" "ZZ" "COURT ORDERED PAYMENT"
#>  .. ..  ..$ : chr [1:4] "RMR" "1L" "12345678" "-12.67"
#>  .. ..  ..$ : chr [1:3] "REF" "ZZ" "STATE MANDATED PAYMENT REDUCT"
#>  .. .. $ 2:List of 4
#>  .. ..  ..$ : chr [1:5] "ENT" "2" "2J" "EI" ...
#>  .. ..  ..$ : chr [1:7] "NM1" "QE" "1" "LAST NAME" ...
#>  .. ..  ..$ : chr [1:5] "RMR" "IK" "1000210000000020" "183.47" ...
#>  .. ..  ..$ : chr [1:3] "ADX" "181.64" "IA"
#>  .. .. $ 3:List of 4
#>  .. ..  ..$ : chr [1:5] "ENT" "3" "2J" "EI" ...
#>  .. ..  ..$ : chr [1:7] "NM1" "QE" "1" "LAST NAME" ...
#>  .. ..  ..$ : chr [1:5] "RMR" "IK" "1000210000000020" "449.94" ...
#>  .. ..  ..$ : chr [1:3] "ADX" "445.45" "IA"
#>   ..@ SE  : chr [1:2] "22" "222222222"
#>   ..@ GE  : chr [1:2] "1" "333333333"
#>   ..@ IEA : chr [1:2] "1" "003333333"
```
