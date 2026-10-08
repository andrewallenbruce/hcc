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
x = edi_index(hcc::x12_EX$`820`$`218`[1:5])
str(purrr::map(x, hcc:::parse_218), list.len = 10L)
#> List of 5
#>  $ 820_Child_Health_Plus_Payment_EFT:List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "RA" "EMEDNYBAT" "ETIN" "20141231" ...
#>   .. ..$ ST : chr [1:3] "820" "222222222" "005010X218"
#>   ..$ details:List of 5
#>   .. ..$ : chr [1:17] "BPR" "I" "239.6" "C" ...
#>   .. ..$ : chr [1:4] "TRN" "3" "021300000000000" "1141797357"
#>   .. ..$ : chr [1:3] "REF" "14" "12345678"
#>   .. ..$ : chr [1:5] "N1" "PE" "MANAGED CARE" "FI" ...
#>   .. ..$ : chr [1:3] "N1" "PR" "CHILD HEALTH PLUS"
#>   ..$ entity :List of 5
#>   .. ..$ :List of 1
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "ENT" "1" "2L" "24" ...
#>   .. ..$ :List of 2
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "RMR" "1L" "12345678" NA ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:3] "REF" "ZZ" "RECOVERY OF FUNDS"
#>   .. ..$ :List of 2
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "RMR" "1L" "12345678" NA ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:3] "REF" "ZZ" "LUMP SUM PAYMENT"
#>   .. ..$ :List of 2
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "ENT" "2" "2J" "EI" ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:10] "NM1" "QE" "1" "LAST NAME" ...
#>   .. ..$ :List of 5
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "RMR" "AZ" "12345678" NA ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:3] "REF" "ZZ" "1436500000001230"
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:3] "REF" "ZZ" "0123456789"
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:3] "REF" "LU" "01"
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "17" "222222222"
#>   .. ..$ GE : chr [1:2] "1" "333333333"
#>   .. ..$ IEA: chr [1:2] "1" "003333333"
#>  $ 820_Essentail_Health_Plan        :List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "RA" "EMEDNYBAT" "ETIN" "20150105" ...
#>   .. ..$ ST : chr [1:3] "820" "221500001" "005010X218"
#>   ..$ details:List of 7
#>   .. ..$ : chr [1:17] "BPR" "I" "123.45" "C" ...
#>   .. ..$ : chr [1:4] "TRN" "3" "000000032788113" "1141797357"
#>   .. ..$ : chr [1:3] "REF" "14" "12345678"
#>   .. ..$ : chr [1:5] "N1" "PE" NA "FI" ...
#>   .. ..$ : chr [1:3] "N1" "PR" "BASIC HEALTH PLAN"
#>   .. ..$ : chr [1:3] "N3" "OFFICE OF HEALTH INSURANCE PROGRAMS" "CORNING TOWER, EMPIRE STATE PLAZA"
#>   .. ..$ : chr [1:4] "N4" "ALBANY" "NY" "122370080"
#>   ..$ entity :List of 2
#>   .. ..$ :List of 2
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "ENT" "1" "2J" "EI" ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:10] "NM1" "QE" "1" "LASTNAME" ...
#>   .. ..$ :List of 6
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "RMR" "AZ" "LL88888L" NA ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:3] "REF" "ZZ" "1500311111112540"
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:3] "REF" "ZZ" "0123456789"
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:3] "REF" "LU" "01"
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:3] "REF" "ZZ" "51"
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "14" "221500001"
#>   .. ..$ GE : chr [1:2] "1" "5113240"
#>   .. ..$ IEA: chr [1:2] "1" "005113240"
#>  $ 820_Premium_Payment_EFT          :List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "RA" "EMEDNYBAT" "ETIN" "20141231" ...
#>   .. ..$ ST : chr [1:3] "820" "222222222" "005010X218"
#>   ..$ details:List of 5
#>   .. ..$ : chr [1:17] "BPR" "I" "566.29" "C" ...
#>   .. ..$ : chr [1:4] "TRN" "3" "021300000000000" "1141797357"
#>   .. ..$ : chr [1:3] "REF" "14" "12345678"
#>   .. ..$ : chr [1:5] "N1" "PE" "MANAGED CARE" "FI" ...
#>   .. ..$ : chr [1:5] "N1" "PR" "NYSDOH" "FI" ...
#>   ..$ entity :List of 8
#>   .. ..$ :List of 1
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "ENT" "1" "2L" "24" ...
#>   .. ..$ :List of 2
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "RMR" "1L" "12345678" NA ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:3] "REF" "ZZ" "RECOVERY OF FUNDS"
#>   .. ..$ :List of 2
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "RMR" "1L" "12345678" NA ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:3] "REF" "ZZ" "COURT ORDERED PAYMENT"
#>   .. ..$ :List of 2
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "RMR" "1L" "12345678" NA ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:3] "REF" "ZZ" "STATE MANDATED PAYMENT REDUCT"
#>   .. ..$ :List of 2
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "ENT" "2" "2J" "EI" ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:10] "NM1" "QE" "1" "LAST NAME" ...
#>   .. ..$ :List of 2
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:6] "RMR" "IK" "1000210000000020" NA ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:3] "ADX" "181.64" "IA"
#>   .. ..$ :List of 2
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "ENT" "3" "2J" "EI" ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:10] "NM1" "QE" "1" "LAST NAME" ...
#>   .. ..$ :List of 2
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:6] "RMR" "IK" "1000210000000020" NA ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:3] "ADX" "445.45" "IA"
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "22" "222222222"
#>   .. ..$ GE : chr [1:2] "1" "333333333"
#>   .. ..$ IEA: chr [1:2] "1" "003333333"
#>  $ 820_Premium_Payment_NOPMT        :List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "RA" "EMEDNYBAT" "ETIN" "20100101" ...
#>   .. ..$ ST : chr [1:3] "820" "173900001" "005010X218"
#>   ..$ details:List of 7
#>   .. ..$ : chr [1:17] "BPR" "I" "0" "C" ...
#>   .. ..$ : chr [1:4] "TRN" "3" "021300000000000" "1123456789"
#>   .. ..$ : chr [1:3] "REF" "14" "12345678"
#>   .. ..$ : chr [1:5] "N1" "PE" "MANAGED CARE" "FI" ...
#>   .. ..$ : chr [1:5] "N1" "PR" "NYSDOH" "FI" ...
#>   .. ..$ : chr [1:3] "N3" "OFFICE OF HEALTH INSURANCE PROGRAMS" "CORNING TOWER, EMPIRE STATE PLAZA"
#>   .. ..$ : chr [1:4] "N4" "ALBANY" "NY" "12204"
#>   ..$ entity :List of 5
#>   .. ..$ :List of 1
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "ENT" "1" "2L" "24" ...
#>   .. ..$ :List of 2
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "RMR" "1L" "01234567" NA ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:3] "REF" "ZZ" "RECOVERY OF FUNDS"
#>   .. ..$ :List of 2
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "RMR" "1L" "01234567" NA ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:3] "REF" "ZZ" "STATE MANDATED PAYMENT REDUCT"
#>   .. ..$ :List of 2
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "ENT" "2" "2J" "EI" ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:10] "NM1" "QE" "1" "LAST NAME" ...
#>   .. ..$ :List of 2
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:6] "RMR" "IK" "1320600000000020" NA ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:3] "ADX" "-2851.11" "H1"
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "18" "173900001"
#>   .. ..$ GE : chr [1:2] "1" "6000001"
#>   .. ..$ IEA: chr [1:2] "1" "006000001"
#>  $ payment_order_820_218            :List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "HC" "XXXXXXX" "XXXXX" "20170617" ...
#>   .. ..$ ST : chr [1:3] "820" "0001" "005010X218"
#>   ..$ details:List of 5
#>   .. ..$ : chr [1:17] "BPR" "C" "19000" "C" ...
#>   .. ..$ : chr [1:4] "TRN" "1" "12345" "1030449999"
#>   .. ..$ : chr [1:3] "REF" "14" "12345"
#>   .. ..$ : chr [1:5] "N1" "PE" "DEF HEALTH CARE INC." "FI" ...
#>   .. ..$ : chr [1:5] "N1" "PR" "ABC PLASTICS" "FI" ...
#>   ..$ entity :List of 3
#>   .. ..$ :List of 1
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "ENT" "1" "2L" "FI" ...
#>   .. ..$ :List of 4
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "RMR" "IK" "970501001" "PI" ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:2] "IT1" "1"
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:6] "SLN" "1" NA "O" ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:6] "SLN" "2" NA "O" ...
#>   .. ..$ :List of 3
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:5] "RMR" "IK" "970501002" "PI" ...
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:2] "IT1" "1"
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr [1:6] "SLN" "1" NA "O" ...
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "15" "0001"
#>   .. ..$ GE : chr [1:2] "1" "101"
#>   .. ..$ IEA: chr [1:2] "1" "000000101"
```
