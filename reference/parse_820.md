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
purrr::map(edi_index(hcc::x12_EX$`820`$`218`[5:10]), hcc:::parse_218) |>
str(list.len = 10L)
#> List of 6
#>  $ payment_order_820_218:List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "HC" "XXXXXXX" "XXXXX" "20170617" ...
#>   .. ..$ ST : chr [1:3] "820" "0001" "005010X218"
#>   ..$ details:List of 5
#>   .. ..$ BPR: chr [1:16] "C" "19000" "C" "ACH" ...
#>   .. ..$ TRN: chr [1:3] "1" "12345" "1030449999"
#>   .. ..$ REF: chr [1:2] "14" "12345"
#>   .. ..$ N1 : chr [1:4] "PE" "DEF HEALTH CARE INC." "FI" "012222222"
#>   .. ..$ N1 : chr [1:4] "PR" "ABC PLASTICS" "FI" "123456789"
#>   ..$ entity :List of 1
#>   .. ..$ :List of 8
#>   .. .. ..$ ENT: chr [1:4] "1" "2L" "FI" "123456789"
#>   .. .. ..$ RMR: chr [1:4] "IK" "970501001" "PI" "16500"
#>   .. .. ..$ IT1: chr "1"
#>   .. .. ..$ SLN: chr [1:5] "1" NA "O" "5" ...
#>   .. .. ..$ SLN: chr [1:5] "2" NA "O" "75" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "970501002" "PI" "250"
#>   .. .. ..$ IT1: chr "1"
#>   .. .. ..$ SLN: chr [1:5] "1" NA "O" "25" ...
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "15" "0001"
#>   .. ..$ GE : chr [1:2] "1" "101"
#>   .. ..$ IEA: chr [1:2] "1" "000000101"
#>  $ sample_820_01        :List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20260118" ...
#>   .. ..$ ST : chr [1:3] "820" "0001" "005010X218"
#>   ..$ details:List of 9
#>   .. ..$ BPR: chr [1:16] "I" "102139.46" "C" "NON" ...
#>   .. ..$ TRN: chr [1:2] "3" "TESTTRN01000001"
#>   .. ..$ REF: chr [1:2] "14" "0000245023"
#>   .. ..$ N1 : chr [1:2] "PE" "TEST PAYEE ORGANIZATION"
#>   .. ..$ N3 : chr "123 TEST STREET"
#>   .. ..$ N4 : chr [1:3] "TESTCITY" "CA" "00000"
#>   .. ..$ N1 : chr [1:2] "PR" "TEST PAYER AGENCY"
#>   .. ..$ N3 : chr "123 TEST STREET"
#>   .. ..$ N4 : chr [1:3] "TESTCITY" "CA" "00000"
#>   ..$ entity :List of 12
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "1" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME01" "FIRSTNAME01" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2512150225000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "2" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME02" "FIRSTNAME02" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2512150225000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "3" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME03" "FIRSTNAME03" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2512150225000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "4" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME04" "FIRSTNAME04" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2512150225000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "5" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME05" "FIRSTNAME05" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2512150225000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "6" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME06" "FIRSTNAME06" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2512150225000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 12
#>   .. .. ..$ ENT: chr [1:4] "7" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME07" "FIRSTNAME07" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2512150225000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2512150225000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;2"
#>   .. .. .. [list output truncated]
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "8" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME08" "FIRSTNAME08" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2512150225000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "9" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME09" "FIRSTNAME09" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2512150225000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "10" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME10" "FIRSTNAME10" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2512150225000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. [list output truncated]
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "100" "0001"
#>   .. ..$ GE : chr [1:2] "1" "43304"
#>   .. ..$ IEA: chr [1:2] "1" "000058691"
#>  $ sample_820_02        :List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20260316" ...
#>   .. ..$ ST : chr [1:3] "820" "0001" "005010X218"
#>   ..$ details:List of 9
#>   .. ..$ BPR: chr [1:16] "I" "91977.81" "C" "NON" ...
#>   .. ..$ TRN: chr [1:2] "3" "TESTTRN02000001"
#>   .. ..$ REF: chr [1:2] "14" "0000245023"
#>   .. ..$ N1 : chr [1:2] "PE" "TEST PAYEE ORGANIZATION"
#>   .. ..$ N3 : chr "123 TEST STREET"
#>   .. ..$ N4 : chr [1:3] "TESTCITY" "CA" "00000"
#>   .. ..$ N1 : chr [1:2] "PR" "TEST PAYER AGENCY"
#>   .. ..$ N3 : chr "123 TEST STREET"
#>   .. ..$ N4 : chr [1:3] "TESTCITY" "CA" "00000"
#>   ..$ entity :List of 13
#>   .. ..$ :List of 13
#>   .. .. ..$ ENT: chr [1:4] "1" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME01" "FIRSTNAME01" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "5555.82"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Dual-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:5] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "454.72" ...
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. .. [list output truncated]
#>   .. ..$ :List of 13
#>   .. .. ..$ ENT: chr [1:4] "2" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME02" "FIRSTNAME02" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "8488.25"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:5] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "401.72" ...
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. .. [list output truncated]
#>   .. ..$ :List of 13
#>   .. .. ..$ ENT: chr [1:4] "3" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME03" "FIRSTNAME03" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "8488.25"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:5] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "401.72" ...
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;2"
#>   .. .. .. [list output truncated]
#>   .. ..$ :List of 12
#>   .. .. ..$ ENT: chr [1:4] "4" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME13" "FIRSTNAME13" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "8488.25"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "8488.25"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. .. [list output truncated]
#>   .. ..$ :List of 13
#>   .. .. ..$ ENT: chr [1:4] "5" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME04" "FIRSTNAME04" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "8488.25"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:5] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "401.72" ...
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;2"
#>   .. .. .. [list output truncated]
#>   .. ..$ :List of 13
#>   .. .. ..$ ENT: chr [1:4] "6" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME05" "FIRSTNAME05" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "8488.25"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:5] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "401.72" ...
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;2"
#>   .. .. .. [list output truncated]
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "7" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME06" "FIRSTNAME06" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "-8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 13
#>   .. .. ..$ ENT: chr [1:4] "8" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME07" "FIRSTNAME07" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "8488.25"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:5] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "401.72" ...
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;2"
#>   .. .. .. [list output truncated]
#>   .. ..$ :List of 13
#>   .. .. ..$ ENT: chr [1:4] "9" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME08" "FIRSTNAME08" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "8488.25"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:5] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "401.72" ...
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. .. [list output truncated]
#>   .. ..$ :List of 13
#>   .. .. ..$ ENT: chr [1:4] "10" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME09" "FIRSTNAME09" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "8488.25"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:5] "IK" "TESTPLAN-SREGLR-2602200043000P" NA "401.72" ...
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. .. [list output truncated]
#>   .. .. [list output truncated]
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "162" "0001"
#>   .. ..$ GE : chr [1:2] "1" "44273"
#>   .. ..$ IEA: chr [1:2] "1" "000059660"
#>  $ sample_820_03        :List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20260316" ...
#>   .. ..$ ST : chr [1:3] "820" "0001" "005010X218"
#>   ..$ details:List of 9
#>   .. ..$ BPR: chr [1:16] "I" "697085.64" "C" "NON" ...
#>   .. ..$ TRN: chr [1:2] "3" "TESTTRN03000001"
#>   .. ..$ REF: chr [1:2] "14" "0000245023"
#>   .. ..$ N1 : chr [1:2] "PE" "TEST PAYEE ORGANIZATION"
#>   .. ..$ N3 : chr "123 TEST STREET"
#>   .. ..$ N4 : chr [1:3] "TESTCITY" "CA" "00000"
#>   .. ..$ N1 : chr [1:2] "PR" "TEST PAYER AGENCY"
#>   .. ..$ N3 : chr "123 TEST STREET"
#>   .. ..$ N4 : chr [1:3] "TESTCITY" "CA" "00000"
#>   ..$ entity :List of 93
#>   .. ..$ :List of 13
#>   .. .. ..$ ENT: chr [1:4] "1" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME14" "FIRSTNAME14" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2602200042000P" NA "5727.65"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "60;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Dual"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:5] "IK" "TESTPLAN-PREGLR-2602200042000P" NA "468.79" ...
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "60;1"
#>   .. .. .. [list output truncated]
#>   .. ..$ :List of 13
#>   .. .. ..$ ENT: chr [1:4] "2" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME15" "FIRSTNAME15" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2602200042000P" NA "5727.65"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "60;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Dual"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:5] "IK" "TESTPLAN-PREGLR-2602200042000P" NA "468.79" ...
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "60;1"
#>   .. .. .. [list output truncated]
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "3" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME16" "FIRSTNAME16" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2602200042000P" NA "5727.65"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Dual"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 13
#>   .. .. ..$ ENT: chr [1:4] "4" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME17" "FIRSTNAME17" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2602200042000P" NA "5727.65"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Dual"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:5] "IK" "TESTPLAN-PREGLR-2602200042000P" NA "468.79" ...
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;1"
#>   .. .. .. [list output truncated]
#>   .. ..$ :List of 13
#>   .. .. ..$ ENT: chr [1:4] "5" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME18" "FIRSTNAME18" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2602200042000P" NA "9645.74"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Medi-Cal Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:5] "IK" "TESTPLAN-PREGLR-2602200042000P" NA "559.75" ...
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;1"
#>   .. .. .. [list output truncated]
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "6" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME19" "FIRSTNAME19" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2602200042000P" NA "5727.65"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "17;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Dual"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 13
#>   .. .. ..$ ENT: chr [1:4] "7" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME20" "FIRSTNAME20" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2602200042000P" NA "9645.74"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Medi-Cal Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:5] "IK" "TESTPLAN-PREGLR-2602200042000P" NA "559.75" ...
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;1"
#>   .. .. .. [list output truncated]
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "8" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME21" "FIRSTNAME21" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2602200042000P" NA "5727.65"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "17;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Dual"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 13
#>   .. .. ..$ ENT: chr [1:4] "9" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME22" "FIRSTNAME22" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2602200042000P" NA "5727.65"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "10;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Dual"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:5] "IK" "TESTPLAN-PREGLR-2602200042000P" NA "468.79" ...
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "10;1"
#>   .. .. .. [list output truncated]
#>   .. ..$ :List of 13
#>   .. .. ..$ ENT: chr [1:4] "10" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME23" "FIRSTNAME23" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2602200042000P" NA "5727.65"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Dual"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:5] "IK" "TESTPLAN-PREGLR-2602200042000P" NA "468.79" ...
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;1"
#>   .. .. .. [list output truncated]
#>   .. .. [list output truncated]
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "1142" "0001"
#>   .. ..$ GE : chr [1:2] "1" "44272"
#>   .. ..$ IEA: chr [1:2] "1" "000059659"
#>  $ sample_820_04        :List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20251217" ...
#>   .. ..$ ST : chr [1:3] "820" "0001" "005010X218"
#>   ..$ details:List of 9
#>   .. ..$ BPR: chr [1:16] "I" "80865.30" "C" "NON" ...
#>   .. ..$ TRN: chr [1:2] "3" "TESTTRN04000001"
#>   .. ..$ REF: chr [1:2] "14" "0000245023"
#>   .. ..$ N1 : chr [1:2] "PE" "TEST PAYEE ORGANIZATION"
#>   .. ..$ N3 : chr "123 TEST STREET"
#>   .. ..$ N4 : chr [1:3] "TESTCITY" "CA" "00000"
#>   .. ..$ N1 : chr [1:2] "PR" "TEST PAYER AGENCY"
#>   .. ..$ N3 : chr "123 TEST STREET"
#>   .. ..$ N4 : chr [1:3] "TESTCITY" "CA" "00000"
#>   ..$ entity :List of 10
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "1" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME01" "FIRSTNAME01" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2511190148000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 17
#>   .. .. ..$ ENT: chr [1:4] "2" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME02" "FIRSTNAME02" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2511190148000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2511190148000P" NA "-5101.10"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. .. [list output truncated]
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "3" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME03" "FIRSTNAME03" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2511190148000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "4" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME05" "FIRSTNAME05" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2511190148000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "5" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME06" "FIRSTNAME06" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2511190148000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "6" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME08" "FIRSTNAME08" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2511190148000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "7" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME09" "FIRSTNAME09" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2511190148000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "8" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME10" "FIRSTNAME10" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2511190148000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "9" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME11" "FIRSTNAME11" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2511190148000P" NA "8086.53"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Medi-Cal Only-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "10" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME12" "FIRSTNAME12" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-SREGLR-2511190148000P" NA "5101.10"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "17;2"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Dual-State Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "91" "0001"
#>   .. ..$ GE : chr [1:2] "1" "42755"
#>   .. ..$ IEA: chr [1:2] "1" "000058142"
#>  $ sample_820_05        :List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20260217" ...
#>   .. ..$ ST : chr [1:3] "820" "0001" "005010X218"
#>   ..$ details:List of 9
#>   .. ..$ BPR: chr [1:16] "I" "499187.57" "C" "NON" ...
#>   .. ..$ TRN: chr [1:2] "3" "TESTTRN05000001"
#>   .. ..$ REF: chr [1:2] "14" "0000245023"
#>   .. ..$ N1 : chr [1:2] "PE" "TEST PAYEE ORGANIZATION"
#>   .. ..$ N3 : chr "123 TEST STREET"
#>   .. ..$ N4 : chr [1:3] "TESTCITY" "CA" "00000"
#>   .. ..$ N1 : chr [1:2] "PR" "TEST PAYER AGENCY"
#>   .. ..$ N3 : chr "123 TEST STREET"
#>   .. ..$ N4 : chr [1:3] "TESTCITY" "CA" "00000"
#>   ..$ entity :List of 81
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "1" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME14" "FIRSTNAME14" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2601080201000P" NA "5258.86"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "60;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Dual"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "2" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME15" "FIRSTNAME15" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2601080201000P" NA "5258.86"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "60;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Dual"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "3" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME17" "FIRSTNAME17" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2601080201000P" NA "5258.86"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Dual"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "4" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME18" "FIRSTNAME18" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2601080201000P" NA "9085.99"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Medi-Cal Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "5" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME19" "FIRSTNAME19" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2601080201000P" NA "5258.86"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "17;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Dual"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "6" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME20" "FIRSTNAME20" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2601080201000P" NA "9085.99"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "M1;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Medi-Cal Only"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "7" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME21" "FIRSTNAME21" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2601080201000P" NA "5258.86"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "17;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Dual"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "8" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME22" "FIRSTNAME22" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2601080201000P" NA "5258.86"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "10;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Dual"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 7
#>   .. .. ..$ ENT: chr [1:4] "9" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME23" "FIRSTNAME23" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2601080201000P" NA "5258.86"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "1H;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Dual"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. ..$ :List of 12
#>   .. .. ..$ ENT: chr [1:4] "10" "2J" "EI" "999999999"
#>   .. .. ..$ NM1: chr [1:9] "IL" "1" "LASTNAME24" "FIRSTNAME24" ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2601080201000P" NA "5258.86"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "6H;1"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "Primary Capitation Dual"
#>   .. .. ..$ DTM: chr [1:6] "582" NA NA NA ...
#>   .. .. ..$ RMR: chr [1:4] "IK" "TESTPLAN-PREGLR-2601080201000P" NA "5258.86"
#>   .. .. ..$ REF: chr [1:2] "18" "957"
#>   .. .. ..$ REF: chr [1:2] "ZZ" "6H;1"
#>   .. .. .. [list output truncated]
#>   .. .. [list output truncated]
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "643" "0001"
#>   .. ..$ GE : chr [1:2] "1" "44044"
#>   .. ..$ IEA: chr [1:2] "1" "000059431"
```
