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
create_index(hcc::x12_820[13:17]) |>
  purrr::map(parse_820) |>
  str(list.len = 10L)
#> List of 5
#>  $ sample_820_01: <hcc::X12_820_218>
#>   ..@ ISA : chr [1:14] "00" "00" "ZZ" "TEST-PAYER" ...
#>   ..@ GS  : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20260118" ...
#>   ..@ ST  : chr [1:3] "820" "0001" "005010X218"
#>   ..@ BPR : chr [1:6] "I" "102139.46" "C" "NON" ...
#>   ..@ TRN : chr [1:2] "3" "TESTTRN01000001"
#>   ..@ RF14: chr "0000245023"
#>   ..@ N1PE: chr "TEST PAYEE ORGANIZATION"
#>   ..@ N3PE: chr "123 TEST STREET"
#>   ..@ N4PE: chr [1:3] "TESTCITY" "CA" "00000"
#>   ..@ N1PR: chr "TEST PAYER AGENCY"
#>   ..@ N3PR: chr "123 TEST STREET"
#>   ..@ N4PR: chr [1:3] "TESTCITY" "CA" "00000"
#>   ..@ ENT :List of 89
#>  .. .. $ 1.1 : chr [1:4] "1" "2J" "EI" "999999999"
#>  .. .. $ 1.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME01" ...
#>  .. .. $ 1.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2512150225000P" "8086.53"
#>  .. .. $ 1.4 : chr [1:3] "REF" "18" "957"
#>  .. .. $ 1.5 : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. .. $ 1.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. .. $ 1.7 : chr [1:4] "DTM" "582" "RD8" "20251201-20251231"
#>  .. .. $ 2.1 : chr [1:4] "2" "2J" "EI" "999999999"
#>  .. .. $ 2.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME02" ...
#>  .. .. $ 2.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2512150225000P" "8086.53"
#>  .. ..  [list output truncated]
#>   ..@ SE  : chr [1:2] "100" "0001"
#>   ..@ GE  : chr [1:2] "1" "43304"
#>   ..@ IEA : chr [1:2] "1" "000058691"
#>  $ sample_820_02: <hcc::X12_820_218>
#>   ..@ ISA : chr [1:14] "00" "00" "ZZ" "TEST-PAYER" ...
#>   ..@ GS  : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20260316" ...
#>   ..@ ST  : chr [1:3] "820" "0001" "005010X218"
#>   ..@ BPR : chr [1:6] "I" "91977.81" "C" "NON" ...
#>   ..@ TRN : chr [1:2] "3" "TESTTRN02000001"
#>   ..@ RF14: chr "0000245023"
#>   ..@ N1PE: chr "TEST PAYEE ORGANIZATION"
#>   ..@ N3PE: chr "123 TEST STREET"
#>   ..@ N4PE: chr [1:3] "TESTCITY" "CA" "00000"
#>   ..@ N1PR: chr "TEST PAYER AGENCY"
#>   ..@ N3PR: chr "123 TEST STREET"
#>   ..@ N4PR: chr [1:3] "TESTCITY" "CA" "00000"
#>   ..@ ENT :List of 151
#>  .. .. $ 1.1  : chr [1:4] "1" "2J" "EI" "999999999"
#>  .. .. $ 1.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME01" ...
#>  .. .. $ 1.3  : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2602200043000P" "5555.82"
#>  .. .. $ 1.4  : chr [1:3] "REF" "18" "957"
#>  .. .. $ 1.5  : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. .. $ 1.6  : chr [1:3] "REF" "ZZ" "Dual-State Only"
#>  .. .. $ 1.7  : chr [1:4] "DTM" "582" "RD8" "20260201-20260228"
#>  .. .. $ 1.8  : chr [1:5] "RMR" "IK" "TESTPLAN-SREGLR-2602200043000P" "454.72" ...
#>  .. .. $ 1.9  : chr [1:3] "REF" "18" "957"
#>  .. .. $ 1.10 : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. ..  [list output truncated]
#>   ..@ SE  : chr [1:2] "162" "0001"
#>   ..@ GE  : chr [1:2] "1" "44273"
#>   ..@ IEA : chr [1:2] "1" "000059660"
#>  $ sample_820_03: <hcc::X12_820_218>
#>   ..@ ISA : chr [1:14] "00" "00" "ZZ" "TEST-PAYER" ...
#>   ..@ GS  : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20260316" ...
#>   ..@ ST  : chr [1:3] "820" "0001" "005010X218"
#>   ..@ BPR : chr [1:6] "I" "697085.64" "C" "NON" ...
#>   ..@ TRN : chr [1:2] "3" "TESTTRN03000001"
#>   ..@ RF14: chr "0000245023"
#>   ..@ N1PE: chr "TEST PAYEE ORGANIZATION"
#>   ..@ N3PE: chr "123 TEST STREET"
#>   ..@ N4PE: chr [1:3] "TESTCITY" "CA" "00000"
#>   ..@ N1PR: chr "TEST PAYER AGENCY"
#>   ..@ N3PR: chr "123 TEST STREET"
#>   ..@ N4PR: chr [1:3] "TESTCITY" "CA" "00000"
#>   ..@ ENT :List of 1131
#>  .. .. $ 1.1  : chr [1:4] "1" "2J" "EI" "999999999"
#>  .. .. $ 1.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME14" ...
#>  .. .. $ 1.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2602200042000P" "5727.65"
#>  .. .. $ 1.4  : chr [1:3] "REF" "18" "957"
#>  .. .. $ 1.5  : chr [1:4] "REF" "ZZ" "60" "1"
#>  .. .. $ 1.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. .. $ 1.7  : chr [1:4] "DTM" "582" "RD8" "20260201-20260228"
#>  .. .. $ 1.8  : chr [1:5] "RMR" "IK" "TESTPLAN-PREGLR-2602200042000P" "468.79" ...
#>  .. .. $ 1.9  : chr [1:3] "REF" "18" "957"
#>  .. .. $ 1.10 : chr [1:4] "REF" "ZZ" "60" "1"
#>  .. ..  [list output truncated]
#>   ..@ SE  : chr [1:2] "1142" "0001"
#>   ..@ GE  : chr [1:2] "1" "44272"
#>   ..@ IEA : chr [1:2] "1" "000059659"
#>  $ sample_820_04: <hcc::X12_820_218>
#>   ..@ ISA : chr [1:14] "00" "00" "ZZ" "TEST-PAYER" ...
#>   ..@ GS  : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20251217" ...
#>   ..@ ST  : chr [1:3] "820" "0001" "005010X218"
#>   ..@ BPR : chr [1:6] "I" "80865.30" "C" "NON" ...
#>   ..@ TRN : chr [1:2] "3" "TESTTRN04000001"
#>   ..@ RF14: chr "0000245023"
#>   ..@ N1PE: chr "TEST PAYEE ORGANIZATION"
#>   ..@ N3PE: chr "123 TEST STREET"
#>   ..@ N4PE: chr [1:3] "TESTCITY" "CA" "00000"
#>   ..@ N1PR: chr "TEST PAYER AGENCY"
#>   ..@ N3PR: chr "123 TEST STREET"
#>   ..@ N4PR: chr [1:3] "TESTCITY" "CA" "00000"
#>   ..@ ENT :List of 80
#>  .. .. $ 1.1 : chr [1:4] "1" "2J" "EI" "999999999"
#>  .. .. $ 1.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME01" ...
#>  .. .. $ 1.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2511190148000P" "8086.53"
#>  .. .. $ 1.4 : chr [1:3] "REF" "18" "957"
#>  .. .. $ 1.5 : chr [1:4] "REF" "ZZ" "1H" "2"
#>  .. .. $ 1.6 : chr [1:3] "REF" "ZZ" "Medi-Cal Only-State Only"
#>  .. .. $ 1.7 : chr [1:4] "DTM" "582" "RD8" "20251101-20251130"
#>  .. .. $ 2.1 : chr [1:4] "2" "2J" "EI" "999999999"
#>  .. .. $ 2.2 : chr [1:7] "NM1" "IL" "1" "LASTNAME02" ...
#>  .. .. $ 2.3 : chr [1:4] "RMR" "IK" "TESTPLAN-SREGLR-2511190148000P" "8086.53"
#>  .. ..  [list output truncated]
#>   ..@ SE  : chr [1:2] "91" "0001"
#>   ..@ GE  : chr [1:2] "1" "42755"
#>   ..@ IEA : chr [1:2] "1" "000058142"
#>  $ sample_820_05: <hcc::X12_820_218>
#>   ..@ ISA : chr [1:14] "00" "00" "ZZ" "TEST-PAYER" ...
#>   ..@ GS  : chr [1:8] "RA" "TEST-PAYER" "TEST-PAYEE" "20260217" ...
#>   ..@ ST  : chr [1:3] "820" "0001" "005010X218"
#>   ..@ BPR : chr [1:6] "I" "499187.57" "C" "NON" ...
#>   ..@ TRN : chr [1:2] "3" "TESTTRN05000001"
#>   ..@ RF14: chr "0000245023"
#>   ..@ N1PE: chr "TEST PAYEE ORGANIZATION"
#>   ..@ N3PE: chr "123 TEST STREET"
#>   ..@ N4PE: chr [1:3] "TESTCITY" "CA" "00000"
#>   ..@ N1PR: chr "TEST PAYER AGENCY"
#>   ..@ N3PR: chr "123 TEST STREET"
#>   ..@ N4PR: chr [1:3] "TESTCITY" "CA" "00000"
#>   ..@ ENT :List of 632
#>  .. .. $ 1.1  : chr [1:4] "1" "2J" "EI" "999999999"
#>  .. .. $ 1.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME14" ...
#>  .. .. $ 1.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2601080201000P" "5258.86"
#>  .. .. $ 1.4  : chr [1:3] "REF" "18" "957"
#>  .. .. $ 1.5  : chr [1:4] "REF" "ZZ" "60" "1"
#>  .. .. $ 1.6  : chr [1:3] "REF" "ZZ" "Primary Capitation Dual"
#>  .. .. $ 1.7  : chr [1:4] "DTM" "582" "RD8" "20260101-20260131"
#>  .. .. $ 2.1  : chr [1:4] "2" "2J" "EI" "999999999"
#>  .. .. $ 2.2  : chr [1:7] "NM1" "IL" "1" "LASTNAME15" ...
#>  .. .. $ 2.3  : chr [1:4] "RMR" "IK" "TESTPLAN-PREGLR-2601080201000P" "5258.86"
#>  .. ..  [list output truncated]
#>   ..@ SE  : chr [1:2] "643" "0001"
#>   ..@ GE  : chr [1:2] "1" "44044"
#>   ..@ IEA : chr [1:2] "1" "000059431"
```
