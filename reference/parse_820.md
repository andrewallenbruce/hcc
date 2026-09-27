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

list

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
x = purrr::map(hcc::x12_820, index_x12)
w = purrr::compact(purrr::map(x, purrr::pluck, "type"))
x = x[names(w)[collapse::whichv(hcc:::unlist_(w), "820-X218")]]
purrr::map(x, hcc:::parse_820_218)
#> $sample_820_01
#> <hcc::X12_820_218>
#>  @ ISA : chr [1:14] "00" "00" "ZZ" "TEST-PAYER" "30" "TEST-PAYEE" "260118" ...
#>  @ GS  : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20260118" "083122" "43304" ...
#>  @ ST  : chr [1:3] "820" "0001" "005010X218"
#>  @ BPR : chr [1:6] "I" "102139.46" "C" "NON" "68-0317191" "20260115"
#>  @ TRN : chr [1:2] "3" "TESTTRN01000001"
#>  @ RF14: chr "0000245023"
#>  @ N1PE: chr "TEST PAYEE ORGANIZATION"
#>  @ N3PE: chr "123 TEST STREET"
#>  @ N4PE: chr [1:3] "TESTCITY" "CA" "00000"
#>  @ N1PR: chr "TEST PAYER AGENCY"
#>  @ N3PR: chr "123 TEST STREET"
#>  @ N4PR: chr [1:3] "TESTCITY" "CA" "00000"
#>  @ ENT :List of 89
#>  .. $ 1.1 : chr [1:4] "1" "2J" "EI" "999999999"
#>  .. $ 1.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME01" ...
#>  .. $ 1.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2512150225000P" "8086.53"
#>  .. $ 1.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 1.5 : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 1.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 1.7 : chr [1:4] "DTM" "582" "RD8" "20251201-20251231"
#>  .. $ 2.1 : chr [1:4] "2" "2J" "EI" "999999999"
#>  .. $ 2.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME02" ...
#>  .. $ 2.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2512150225000P" "8086.53"
#>  .. $ 2.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 2.5 : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 2.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 2.7 : chr [1:4] "DTM" "582" "RD8" "20251201-20251231"
#>  .. $ 3.1 : chr [1:4] "3" "2J" "EI" "999999999"
#>  .. $ 3.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME03" ...
#>  .. $ 3.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2512150225000P" "8086.53"
#>  .. $ 3.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 3.5 : chr [1:4] "REF" "ZZ" "M1" "2"
#>  .. $ 3.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 3.7 : chr [1:4] "DTM" "582" "RD8" "20251201-20251231"
#>  .. $ 4.1 : chr [1:4] "4" "2J" "EI" "999999999"
#>  .. $ 4.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME04" ...
#>  .. $ 4.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2512150225000P" "8086.53"
#>  .. $ 4.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 4.5 : chr [1:4] "REF" "ZZ" "M1" "2"
#>  .. $ 4.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 4.7 : chr [1:4] "DTM" "582" "RD8" "20251201-20251231"
#>  .. $ 5.1 : chr [1:4] "5" "2J" "EI" "999999999"
#>  .. $ 5.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME05" ...
#>  .. $ 5.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2512150225000P" "8086.53"
#>  .. $ 5.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 5.5 : chr [1:4] "REF" "ZZ" "M1" "2"
#>  .. $ 5.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 5.7 : chr [1:4] "DTM" "582" "RD8" "20251201-20251231"
#>  .. $ 6.1 : chr [1:4] "6" "2J" "EI" "999999999"
#>  .. $ 6.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME06" ...
#>  .. $ 6.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2512150225000P" "8086.53"
#>  .. $ 6.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 6.5 : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 6.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 6.7 : chr [1:4] "DTM" "582" "RD8" "20251201-20251231"
#>  .. $ 7.1 : chr [1:4] "7" "2J" "EI" "999999999"
#>  .. $ 7.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME07" ...
#>  .. $ 7.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2512150225000P" "8086.53"
#>  .. $ 7.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 7.5 : chr [1:4] "REF" "ZZ" "M1" "2"
#>  .. $ 7.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 7.7 : chr [1:4] "DTM" "582" "RD8" "20251201-20251231"
#>  .. $ 7.8 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2512150225000P" "8086.53"
#>  .. $ 7.9 : chr [1:3] "REF" "18" "957"
#>  .. $ 7.10: chr [1:4] "REF" "ZZ" "M1" "2"
#>  .. $ 7.11: chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 7.12: chr [1:4] "DTM" "582" "RD8" "20251101-20251130"
#>  .. $ 8.1 : chr [1:4] "8" "2J" "EI" "999999999"
#>  .. $ 8.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME08" ...
#>  .. $ 8.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2512150225000P" "8086.53"
#>  .. $ 8.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 8.5 : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 8.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 8.7 : chr [1:4] "DTM" "582" "RD8" "20251201-20251231"
#>  .. $ 9.1 : chr [1:4] "9" "2J" "EI" "999999999"
#>  .. $ 9.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME09" ...
#>  .. $ 9.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2512150225000P" "8086.53"
#>  .. $ 9.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 9.5 : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 9.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 9.7 : chr [1:4] "DTM" "582" "RD8" "20251201-20251231"
#>  .. $ 10.1: chr [1:4] "10" "2J" "EI" "999999999"
#>  .. $ 10.2: chr [1:7] "NM1" "IL" "1" "LASTNAME10" ...
#>  .. $ 10.3: chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2512150225000P" "8086.53"
#>  .. $ 10.4: chr [1:3] "REF" "18" "957"
#>  .. $ 10.5: chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 10.6: chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 10.7: chr [1:4] "DTM" "582" "RD8" "20251201-20251231"
#>  .. $ 11.1: chr [1:4] "11" "2J" "EI" "999999999"
#>  .. $ 11.2: chr [1:7] "NM1" "IL" "1" "LASTNAME11" ...
#>  .. $ 11.3: chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2512150225000P" "8086.53"
#>  .. $ 11.4: chr [1:3] "REF" "18" "957"
#>  .. $ 11.5: chr [1:4] "REF" "ZZ" "M1" "2"
#>  .. $ 11.6: chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 11.7: chr [1:4] "DTM" "582" "RD8" "20251201-20251231"
#>  .. $ 12.1: chr [1:4] "12" "2J" "EI" "999999999"
#>  .. $ 12.2: chr [1:7] "NM1" "IL" "1" "LASTNAME12" ...
#>  .. $ 12.3: chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2512150225000P" "5101.10"
#>  .. $ 12.4: chr [1:3] "REF" "18" "957"
#>  .. $ 12.5: chr [1:4] "REF" "ZZ" "17" "2"
#>  .. $ 12.6: chr [1:3] "REF" "ZZ" "Dual-State Only"
#>  .. $ 12.7: chr [1:4] "DTM" "582" "RD8" "20251101-20251130"
#>  @ SE  : chr [1:2] "100" "0001"
#>  @ GE  : chr [1:2] "1" "43304"
#>  @ IEA : chr [1:2] "1" "000058691"
#> 
#> $sample_820_02
#> <hcc::X12_820_218>
#>  @ ISA : chr [1:14] "00" "00" "ZZ" "TEST-PAYER" "30" "TEST-PAYEE" "260316" ...
#>  @ GS  : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20260316" "085500" "44273" ...
#>  @ ST  : chr [1:3] "820" "0001" "005010X218"
#>  @ BPR : chr [1:6] "I" "91977.81" "C" "NON" "68-0317191" "20260312"
#>  @ TRN : chr [1:2] "3" "TESTTRN02000001"
#>  @ RF14: chr "0000245023"
#>  @ N1PE: chr "TEST PAYEE ORGANIZATION"
#>  @ N3PE: chr "123 TEST STREET"
#>  @ N4PE: chr [1:3] "TESTCITY" "CA" "00000"
#>  @ N1PR: chr "TEST PAYER AGENCY"
#>  @ N3PR: chr "123 TEST STREET"
#>  @ N4PR: chr [1:3] "TESTCITY" "CA" "00000"
#>  @ ENT :List of 151
#>  .. $ 1.1  : chr [1:4] "1" "2J" "EI" "999999999"
#>  .. $ 1.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME01" ...
#>  .. $ 1.3  : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2602200043000P" "5555.82"
#>  .. $ 1.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 1.5  : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 1.6  : chr [1:3] "REF" "ZZ" "Dual-State Only"
#>  .. $ 1.7  : chr [1:4] "DTM" "582" "RD8" "20260201-20260228"
#>  .. $ 1.8  : chr [1:5] "RMR" "IK" "TESTPLAN-SREGLR-2602200043000P" "454.72" ...
#>  .. $ 1.9  : chr [1:3] "REF" "18" "957"
#>  .. $ 1.10 : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 1.11 : chr [1:3] "REF" "ZZ" "Dual-State Only"
#>  .. $ 1.12 : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 1.13 : chr [1:3] "ADX" "-5101.10" "53"
#>  .. $ 2.1  : chr [1:4] "2" "2J" "EI" "999999999"
#>  .. $ 2.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME02" ...
#>  .. $ 2.3  : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2602200043000P" "8488.25"
#>  .. $ 2.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 2.5  : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 2.6  : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 2.7  : chr [1:4] "DTM" "582" "RD8" "20260201-20260228"
#>  .. $ 2.8  : chr [1:5] "RMR" "IK" "TESTPLAN-SREGLR-2602200043000P" "401.72" ...
#>  .. $ 2.9  : chr [1:3] "REF" "18" "957"
#>  .. $ 2.10 : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 2.11 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 2.12 : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 2.13 : chr [1:3] "ADX" "-8086.53" "53"
#>  .. $ 3.1  : chr [1:4] "3" "2J" "EI" "999999999"
#>  .. $ 3.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME03" ...
#>  .. $ 3.3  : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2602200043000P" "8488.25"
#>  .. $ 3.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 3.5  : chr [1:4] "REF" "ZZ" "M1" "2"
#>  .. $ 3.6  : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 3.7  : chr [1:4] "DTM" "582" "RD8" "20260201-20260228"
#>  .. $ 3.8  : chr [1:5] "RMR" "IK" "TESTPLAN-SREGLR-2602200043000P" "401.72" ...
#>  .. $ 3.9  : chr [1:3] "REF" "18" "957"
#>  .. $ 3.10 : chr [1:4] "REF" "ZZ" "M1" "2"
#>  .. $ 3.11 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 3.12 : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 3.13 : chr [1:3] "ADX" "-8086.53" "53"
#>  .. $ 4.1  : chr [1:4] "4" "2J" "EI" "999999999"
#>  .. $ 4.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME13" ...
#>  .. $ 4.3  : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2602200043000P" "8488.25"
#>  .. $ 4.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 4.5  : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 4.6  : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 4.7  : chr [1:4] "DTM" "582" "RD8" "20260201-20260228"
#>  .. $ 4.8  : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2602200043000P" "8488.25"
#>  .. $ 4.9  : chr [1:3] "REF" "18" "957"
#>  .. $ 4.10 : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 4.11 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 4.12 : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 5.1  : chr [1:4] "5" "2J" "EI" "999999999"
#>  .. $ 5.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME04" ...
#>  .. $ 5.3  : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2602200043000P" "8488.25"
#>  .. $ 5.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 5.5  : chr [1:4] "REF" "ZZ" "M1" "2"
#>  .. $ 5.6  : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 5.7  : chr [1:4] "DTM" "582" "RD8" "20260201-20260228"
#>  .. $ 5.8  : chr [1:5] "RMR" "IK" "TESTPLAN-SREGLR-2602200043000P" "401.72" ...
#>  .. $ 5.9  : chr [1:3] "REF" "18" "957"
#>  .. $ 5.10 : chr [1:4] "REF" "ZZ" "M1" "2"
#>  .. $ 5.11 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 5.12 : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 5.13 : chr [1:3] "ADX" "-8086.53" "53"
#>  .. $ 6.1  : chr [1:4] "6" "2J" "EI" "999999999"
#>  .. $ 6.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME05" ...
#>  .. $ 6.3  : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2602200043000P" "8488.25"
#>  .. $ 6.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 6.5  : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 6.6  : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 6.7  : chr [1:4] "DTM" "582" "RD8" "20260201-20260228"
#>  .. $ 6.8  : chr [1:5] "RMR" "IK" "TESTPLAN-SREGLR-2602200043000P" "401.72" ...
#>  .. $ 6.9  : chr [1:3] "REF" "18" "957"
#>  .. $ 6.10 : chr [1:4] "REF" "ZZ" "M1" "2"
#>  .. $ 6.11 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 6.12 : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 6.13 : chr [1:3] "ADX" "-8086.53" "53"
#>  .. $ 7.1  : chr [1:4] "7" "2J" "EI" "999999999"
#>  .. $ 7.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME06" ...
#>  .. $ 7.3  : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2602200043000P" "-8086.53"
#>  .. $ 7.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 7.5  : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 7.6  : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 7.7  : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 8.1  : chr [1:4] "8" "2J" "EI" "999999999"
#>  .. $ 8.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME07" ...
#>  .. $ 8.3  : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2602200043000P" "8488.25"
#>  .. $ 8.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 8.5  : chr [1:4] "REF" "ZZ" "M1" "2"
#>  .. $ 8.6  : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 8.7  : chr [1:4] "DTM" "582" "RD8" "20260201-20260228"
#>  .. $ 8.8  : chr [1:5] "RMR" "IK" "TESTPLAN-SREGLR-2602200043000P" "401.72" ...
#>  .. $ 8.9  : chr [1:3] "REF" "18" "957"
#>  .. $ 8.10 : chr [1:4] "REF" "ZZ" "M1" "2"
#>  .. $ 8.11 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 8.12 : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 8.13 : chr [1:3] "ADX" "-8086.53" "53"
#>  .. $ 9.1  : chr [1:4] "9" "2J" "EI" "999999999"
#>  .. $ 9.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME08" ...
#>  ..  [list output truncated]
#>  @ SE  : chr [1:2] "162" "0001"
#>  @ GE  : chr [1:2] "1" "44273"
#>  @ IEA : chr [1:2] "1" "000059660"
#> 
#> $sample_820_03
#> <hcc::X12_820_218>
#>  @ ISA : chr [1:14] "00" "00" "ZZ" "TEST-PAYER" "30" "TEST-PAYEE" "260316" ...
#>  @ GS  : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20260316" "085458" "44272" ...
#>  @ ST  : chr [1:3] "820" "0001" "005010X218"
#>  @ BPR : chr [1:6] "I" "697085.64" "C" "NON" "68-0317191" "20260312"
#>  @ TRN : chr [1:2] "3" "TESTTRN03000001"
#>  @ RF14: chr "0000245023"
#>  @ N1PE: chr "TEST PAYEE ORGANIZATION"
#>  @ N3PE: chr "123 TEST STREET"
#>  @ N4PE: chr [1:3] "TESTCITY" "CA" "00000"
#>  @ N1PR: chr "TEST PAYER AGENCY"
#>  @ N3PR: chr "123 TEST STREET"
#>  @ N4PR: chr [1:3] "TESTCITY" "CA" "00000"
#>  @ ENT :List of 1131
#>  .. $ 1.1  : chr [1:4] "1" "2J" "EI" "999999999"
#>  .. $ 1.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME14" ...
#>  .. $ 1.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2602200042000P" "5727.65"
#>  .. $ 1.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 1.5  : chr [1:4] "REF" "ZZ" "60" "1"
#>  .. $ 1.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 1.7  : chr [1:4] "DTM" "582" "RD8" "20260201-20260228"
#>  .. $ 1.8  : chr [1:5] "RMR" "IK" "TESTPLAN-PREGLR-2602200042000P" "468.79" ...
#>  .. $ 1.9  : chr [1:3] "REF" "18" "957"
#>  .. $ 1.10 : chr [1:4] "REF" "ZZ" "60" "1"
#>  .. $ 1.11 : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 1.12 : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 1.13 : chr [1:3] "ADX" "-5258.86" "53"
#>  .. $ 2.1  : chr [1:4] "2" "2J" "EI" "999999999"
#>  .. $ 2.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME15" ...
#>  .. $ 2.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2602200042000P" "5727.65"
#>  .. $ 2.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 2.5  : chr [1:4] "REF" "ZZ" "60" "1"
#>  .. $ 2.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 2.7  : chr [1:4] "DTM" "582" "RD8" "20260201-20260228"
#>  .. $ 2.8  : chr [1:5] "RMR" "IK" "TESTPLAN-PREGLR-2602200042000P" "468.79" ...
#>  .. $ 2.9  : chr [1:3] "REF" "18" "957"
#>  .. $ 2.10 : chr [1:4] "REF" "ZZ" "60" "1"
#>  .. $ 2.11 : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 2.12 : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 2.13 : chr [1:3] "ADX" "-5258.86" "53"
#>  .. $ 3.1  : chr [1:4] "3" "2J" "EI" "999999999"
#>  .. $ 3.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME16" ...
#>  .. $ 3.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2602200042000P" "5727.65"
#>  .. $ 3.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 3.5  : chr [1:4] "REF" "ZZ" "1H" "1"
#>  .. $ 3.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 3.7  : chr [1:4] "DTM" "582" "RD8" "20260201-20260228"
#>  .. $ 4.1  : chr [1:4] "4" "2J" "EI" "999999999"
#>  .. $ 4.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME17" ...
#>  .. $ 4.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2602200042000P" "5727.65"
#>  .. $ 4.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 4.5  : chr [1:4] "REF" "ZZ" "1H" "1"
#>  .. $ 4.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 4.7  : chr [1:4] "DTM" "582" "RD8" "20260201-20260228"
#>  .. $ 4.8  : chr [1:5] "RMR" "IK" "TESTPLAN-PREGLR-2602200042000P" "468.79" ...
#>  .. $ 4.9  : chr [1:3] "REF" "18" "957"
#>  .. $ 4.10 : chr [1:4] "REF" "ZZ" "1H" "1"
#>  .. $ 4.11 : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 4.12 : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 4.13 : chr [1:3] "ADX" "-5258.86" "53"
#>  .. $ 5.1  : chr [1:4] "5" "2J" "EI" "999999999"
#>  .. $ 5.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME18" ...
#>  .. $ 5.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2602200042000P" "9645.74"
#>  .. $ 5.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 5.5  : chr [1:4] "REF" "ZZ" "M1" "1"
#>  .. $ 5.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Medi-Cal Only"
#>  .. $ 5.7  : chr [1:4] "DTM" "582" "RD8" "20260201-20260228"
#>  .. $ 5.8  : chr [1:5] "RMR" "IK" "TESTPLAN-PREGLR-2602200042000P" "559.75" ...
#>  .. $ 5.9  : chr [1:3] "REF" "18" "957"
#>  .. $ 5.10 : chr [1:4] "REF" "ZZ" "M1" "1"
#>  .. $ 5.11 : chr [1:3] "REF" "ZZ" "Primary Capitation Medi-Cal Only"
#>  .. $ 5.12 : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 5.13 : chr [1:3] "ADX" "-9085.99" "53"
#>  .. $ 6.1  : chr [1:4] "6" "2J" "EI" "999999999"
#>  .. $ 6.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME19" ...
#>  .. $ 6.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2602200042000P" "5727.65"
#>  .. $ 6.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 6.5  : chr [1:4] "REF" "ZZ" "17" "1"
#>  .. $ 6.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 6.7  : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 7.1  : chr [1:4] "7" "2J" "EI" "999999999"
#>  .. $ 7.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME20" ...
#>  .. $ 7.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2602200042000P" "9645.74"
#>  .. $ 7.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 7.5  : chr [1:4] "REF" "ZZ" "M1" "1"
#>  .. $ 7.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Medi-Cal Only"
#>  .. $ 7.7  : chr [1:4] "DTM" "582" "RD8" "20260201-20260228"
#>  .. $ 7.8  : chr [1:5] "RMR" "IK" "TESTPLAN-PREGLR-2602200042000P" "559.75" ...
#>  .. $ 7.9  : chr [1:3] "REF" "18" "957"
#>  .. $ 7.10 : chr [1:4] "REF" "ZZ" "M1" "1"
#>  .. $ 7.11 : chr [1:3] "REF" "ZZ" "Primary Capitation Medi-Cal Only"
#>  .. $ 7.12 : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 7.13 : chr [1:3] "ADX" "-9085.99" "53"
#>  .. $ 8.1  : chr [1:4] "8" "2J" "EI" "999999999"
#>  .. $ 8.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME21" ...
#>  .. $ 8.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2602200042000P" "5727.65"
#>  .. $ 8.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 8.5  : chr [1:4] "REF" "ZZ" "17" "1"
#>  .. $ 8.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 8.7  : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 9.1  : chr [1:4] "9" "2J" "EI" "999999999"
#>  .. $ 9.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME22" ...
#>  .. $ 9.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2602200042000P" "5727.65"
#>  .. $ 9.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 9.5  : chr [1:4] "REF" "ZZ" "10" "1"
#>  .. $ 9.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 9.7  : chr [1:4] "DTM" "582" "RD8" "20260201-20260228"
#>  .. $ 9.8  : chr [1:5] "RMR" "IK" "TESTPLAN-PREGLR-2602200042000P" "468.79" ...
#>  .. $ 9.9  : chr [1:3] "REF" "18" "957"
#>  .. $ 9.10 : chr [1:4] "REF" "ZZ" "10" "1"
#>  .. $ 9.11 : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 9.12 : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 9.13 : chr [1:3] "ADX" "-5258.86" "53"
#>  ..  [list output truncated]
#>  @ SE  : chr [1:2] "1142" "0001"
#>  @ GE  : chr [1:2] "1" "44272"
#>  @ IEA : chr [1:2] "1" "000059659"
#> 
#> $sample_820_04
#> <hcc::X12_820_218>
#>  @ ISA : chr [1:14] "00" "00" "ZZ" "TEST-PAYER" "30" "TEST-PAYEE" "251217" ...
#>  @ GS  : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20251217" "231624" "42755" ...
#>  @ ST  : chr [1:3] "820" "0001" "005010X218"
#>  @ BPR : chr [1:6] "I" "80865.30" "C" "NON" "68-0317191" "20251216"
#>  @ TRN : chr [1:2] "3" "TESTTRN04000001"
#>  @ RF14: chr "0000245023"
#>  @ N1PE: chr "TEST PAYEE ORGANIZATION"
#>  @ N3PE: chr "123 TEST STREET"
#>  @ N4PE: chr [1:3] "TESTCITY" "CA" "00000"
#>  @ N1PR: chr "TEST PAYER AGENCY"
#>  @ N3PR: chr "123 TEST STREET"
#>  @ N4PR: chr [1:3] "TESTCITY" "CA" "00000"
#>  @ ENT :List of 80
#>  .. $ 1.1 : chr [1:4] "1" "2J" "EI" "999999999"
#>  .. $ 1.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME01" ...
#>  .. $ 1.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2511190148000P" "8086.53"
#>  .. $ 1.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 1.5 : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 1.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 1.7 : chr [1:4] "DTM" "582" "RD8" "20251101-20251130"
#>  .. $ 2.1 : chr [1:4] "2" "2J" "EI" "999999999"
#>  .. $ 2.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME02" ...
#>  .. $ 2.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2511190148000P" "8086.53"
#>  .. $ 2.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 2.5 : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 2.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 2.7 : chr [1:4] "DTM" "582" "RD8" "20251101-20251130"
#>  .. $ 2.8 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2511190148000P" "-5101.10"
#>  .. $ 2.9 : chr [1:3] "REF" "18" "957"
#>  .. $ 2.10: chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 2.11: chr [1:3] "REF" "ZZ" "Dual-State Only"
#>  .. $ 2.12: chr [1:4] "DTM" "582" "RD8" "20251001-20251031"
#>  .. $ 2.13: chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2511190148000P" "8086.53"
#>  .. $ 2.14: chr [1:3] "REF" "18" "957"
#>  .. $ 2.15: chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 2.16: chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 2.17: chr [1:4] "DTM" "582" "RD8" "20251001-20251031"
#>  .. $ 3.1 : chr [1:4] "3" "2J" "EI" "999999999"
#>  .. $ 3.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME03" ...
#>  .. $ 3.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2511190148000P" "8086.53"
#>  .. $ 3.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 3.5 : chr [1:4] "REF" "ZZ" "M1" "2"
#>  .. $ 3.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 3.7 : chr [1:4] "DTM" "582" "RD8" "20251101-20251130"
#>  .. $ 4.1 : chr [1:4] "4" "2J" "EI" "999999999"
#>  .. $ 4.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME05" ...
#>  .. $ 4.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2511190148000P" "8086.53"
#>  .. $ 4.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 4.5 : chr [1:4] "REF" "ZZ" "M1" "2"
#>  .. $ 4.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 4.7 : chr [1:4] "DTM" "582" "RD8" "20251101-20251130"
#>  .. $ 5.1 : chr [1:4] "5" "2J" "EI" "999999999"
#>  .. $ 5.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME06" ...
#>  .. $ 5.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2511190148000P" "8086.53"
#>  .. $ 5.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 5.5 : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 5.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 5.7 : chr [1:4] "DTM" "582" "RD8" "20251101-20251130"
#>  .. $ 6.1 : chr [1:4] "6" "2J" "EI" "999999999"
#>  .. $ 6.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME08" ...
#>  .. $ 6.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2511190148000P" "8086.53"
#>  .. $ 6.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 6.5 : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 6.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 6.7 : chr [1:4] "DTM" "582" "RD8" "20251101-20251130"
#>  .. $ 7.1 : chr [1:4] "7" "2J" "EI" "999999999"
#>  .. $ 7.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME09" ...
#>  .. $ 7.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2511190148000P" "8086.53"
#>  .. $ 7.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 7.5 : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 7.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 7.7 : chr [1:4] "DTM" "582" "RD8" "20251101-20251130"
#>  .. $ 8.1 : chr [1:4] "8" "2J" "EI" "999999999"
#>  .. $ 8.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME10" ...
#>  .. $ 8.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2511190148000P" "8086.53"
#>  .. $ 8.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 8.5 : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. $ 8.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 8.7 : chr [1:4] "DTM" "582" "RD8" "20251101-20251130"
#>  .. $ 9.1 : chr [1:4] "9" "2J" "EI" "999999999"
#>  .. $ 9.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME11" ...
#>  .. $ 9.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2511190148000P" "8086.53"
#>  .. $ 9.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 9.5 : chr [1:4] "REF" "ZZ" "M1" "2"
#>  .. $ 9.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. $ 9.7 : chr [1:4] "DTM" "582" "RD8" "20251101-20251130"
#>  .. $ 10.1: chr [1:4] "10" "2J" "EI" "999999999"
#>  .. $ 10.2: chr [1:7] "NM1" "IL" "1" "LASTNAME12" ...
#>  .. $ 10.3: chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2511190148000P" "5101.10"
#>  .. $ 10.4: chr [1:3] "REF" "18" "957"
#>  .. $ 10.5: chr [1:4] "REF" "ZZ" "17" "2"
#>  .. $ 10.6: chr [1:3] "REF" "ZZ" "Dual-State Only"
#>  .. $ 10.7: chr [1:4] "DTM" "582" "RD8" "20251001-20251031"
#>  @ SE  : chr [1:2] "91" "0001"
#>  @ GE  : chr [1:2] "1" "42755"
#>  @ IEA : chr [1:2] "1" "000058142"
#> 
#> $sample_820_05
#> <hcc::X12_820_218>
#>  @ ISA : chr [1:14] "00" "00" "ZZ" "TEST-PAYER" "30" "TEST-PAYEE" "260217" ...
#>  @ GS  : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20260217" "093627" "44044" ...
#>  @ ST  : chr [1:3] "820" "0001" "005010X218"
#>  @ BPR : chr [1:6] "I" "499187.57" "C" "NON" "68-0317191" "20260212"
#>  @ TRN : chr [1:2] "3" "TESTTRN05000001"
#>  @ RF14: chr "0000245023"
#>  @ N1PE: chr "TEST PAYEE ORGANIZATION"
#>  @ N3PE: chr "123 TEST STREET"
#>  @ N4PE: chr [1:3] "TESTCITY" "CA" "00000"
#>  @ N1PR: chr "TEST PAYER AGENCY"
#>  @ N3PR: chr "123 TEST STREET"
#>  @ N4PR: chr [1:3] "TESTCITY" "CA" "00000"
#>  @ ENT :List of 632
#>  .. $ 1.1  : chr [1:4] "1" "2J" "EI" "999999999"
#>  .. $ 1.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME14" ...
#>  .. $ 1.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2601080201000P" "5258.86"
#>  .. $ 1.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 1.5  : chr [1:4] "REF" "ZZ" "60" "1"
#>  .. $ 1.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 1.7  : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 2.1  : chr [1:4] "2" "2J" "EI" "999999999"
#>  .. $ 2.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME15" ...
#>  .. $ 2.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2601080201000P" "5258.86"
#>  .. $ 2.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 2.5  : chr [1:4] "REF" "ZZ" "60" "1"
#>  .. $ 2.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 2.7  : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 3.1  : chr [1:4] "3" "2J" "EI" "999999999"
#>  .. $ 3.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME17" ...
#>  .. $ 3.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2601080201000P" "5258.86"
#>  .. $ 3.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 3.5  : chr [1:4] "REF" "ZZ" "1H" "1"
#>  .. $ 3.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 3.7  : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 4.1  : chr [1:4] "4" "2J" "EI" "999999999"
#>  .. $ 4.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME18" ...
#>  .. $ 4.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2601080201000P" "9085.99"
#>  .. $ 4.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 4.5  : chr [1:4] "REF" "ZZ" "M1" "1"
#>  .. $ 4.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Medi-Cal Only"
#>  .. $ 4.7  : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 5.1  : chr [1:4] "5" "2J" "EI" "999999999"
#>  .. $ 5.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME19" ...
#>  .. $ 5.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2601080201000P" "5258.86"
#>  .. $ 5.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 5.5  : chr [1:4] "REF" "ZZ" "17" "1"
#>  .. $ 5.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 5.7  : chr [1:4] "DTM" "582" "RD8" "20251201-20251231"
#>  .. $ 6.1  : chr [1:4] "6" "2J" "EI" "999999999"
#>  .. $ 6.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME20" ...
#>  .. $ 6.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2601080201000P" "9085.99"
#>  .. $ 6.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 6.5  : chr [1:4] "REF" "ZZ" "M1" "1"
#>  .. $ 6.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Medi-Cal Only"
#>  .. $ 6.7  : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 7.1  : chr [1:4] "7" "2J" "EI" "999999999"
#>  .. $ 7.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME21" ...
#>  .. $ 7.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2601080201000P" "5258.86"
#>  .. $ 7.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 7.5  : chr [1:4] "REF" "ZZ" "17" "1"
#>  .. $ 7.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 7.7  : chr [1:4] "DTM" "582" "RD8" "20251201-20251231"
#>  .. $ 8.1  : chr [1:4] "8" "2J" "EI" "999999999"
#>  .. $ 8.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME22" ...
#>  .. $ 8.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2601080201000P" "5258.86"
#>  .. $ 8.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 8.5  : chr [1:4] "REF" "ZZ" "10" "1"
#>  .. $ 8.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 8.7  : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 9.1  : chr [1:4] "9" "2J" "EI" "999999999"
#>  .. $ 9.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME23" ...
#>  .. $ 9.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2601080201000P" "5258.86"
#>  .. $ 9.4  : chr [1:3] "REF" "18" "957"
#>  .. $ 9.5  : chr [1:4] "REF" "ZZ" "1H" "1"
#>  .. $ 9.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 9.7  : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 10.1 : chr [1:4] "10" "2J" "EI" "999999999"
#>  .. $ 10.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME24" ...
#>  .. $ 10.3 : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2601080201000P" "5258.86"
#>  .. $ 10.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 10.5 : chr [1:4] "REF" "ZZ" "6H" "1"
#>  .. $ 10.6 : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 10.7 : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 10.8 : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2601080201000P" "5258.86"
#>  .. $ 10.9 : chr [1:3] "REF" "18" "957"
#>  .. $ 10.10: chr [1:4] "REF" "ZZ" "6H" "1"
#>  .. $ 10.11: chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 10.12: chr [1:4] "DTM" "582" "RD8" "20251201-20251231"
#>  .. $ 11.1 : chr [1:4] "11" "2J" "EI" "999999999"
#>  .. $ 11.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME25" ...
#>  .. $ 11.3 : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2601080201000P" "5258.86"
#>  .. $ 11.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 11.5 : chr [1:4] "REF" "ZZ" "60" "1"
#>  .. $ 11.6 : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 11.7 : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 12.1 : chr [1:4] "12" "2J" "EI" "999999999"
#>  .. $ 12.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME26" ...
#>  .. $ 12.3 : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2601080201000P" "9085.99"
#>  .. $ 12.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 12.5 : chr [1:4] "REF" "ZZ" "1H" "1"
#>  .. $ 12.6 : chr [1:3] "REF" "ZZ" "Primary Capitation Medi-Cal Only"
#>  .. $ 12.7 : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 13.1 : chr [1:4] "13" "2J" "EI" "999999999"
#>  .. $ 13.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME28" ...
#>  .. $ 13.3 : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2601080201000P" "5258.86"
#>  .. $ 13.4 : chr [1:3] "REF" "18" "957"
#>  .. $ 13.5 : chr [1:4] "REF" "ZZ" "1H" "1"
#>  .. $ 13.6 : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. $ 13.7 : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. $ 14.1 : chr [1:4] "14" "2J" "EI" "999999999"
#>  .. $ 14.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME29" ...
#>  .. $ 14.3 : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2601080201000P" "9085.99"
#>  ..  [list output truncated]
#>  @ SE  : chr [1:2] "643" "0001"
#>  @ GE  : chr [1:2] "1" "44044"
#>  @ IEA : chr [1:2] "1" "000059431"
#> 
```
