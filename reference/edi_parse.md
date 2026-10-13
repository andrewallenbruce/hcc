# X12-820 (X306/X218) Payment Order/Remittance Advice Parser

Parses X12-820 (005010X218) transactions for Medicaid/Medicare
capitation and premium payments. Designed for California DHCS PACE
capitation remittances but handles the general 820 format used by state
Medicaid agencies.

## Usage

``` r
edi_parse(x)
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
x = edi_index(x12_EX$`834`)
purrr::map(x, hcc:::parse_834_) |> str(list.len = 10L)
#> List of 15
#>  $ 834_EX2_add_dependent                   :List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "BE" "SENDERNAME" "RECEIVERNAME" "20041227" ...
#>   .. ..$ ST : chr [1:3] "834" "12345" "005010X220A1"
#>   ..$ details:List of 4
#>   .. ..$ : chr [1:9] "BGN" "00" "12456" "19980520" ...
#>   .. ..$ : chr [1:3] "REF" "38" "ABCD012354"
#>   .. ..$ : chr [1:5] "N1" "P5" NA "FI" ...
#>   .. ..$ : chr [1:5] "N1" "IN" NA "FI" ...
#>   ..$ member :List of 5
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr [1:10] "INS" "N" "19" "021" ...
#>   .. ..$ :List of 3
#>   .. .. ..$ : chr [1:3] "REF" "0F" "123456789"
#>   .. .. ..$ : chr [1:3] "REF" "1L" "123456001"
#>   .. .. ..$ : chr [1:4] "DTP" "351" "D8" "19980515"
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:10] "NM1" "IL" "1" "DOE" ...
#>   .. .. ..$ : chr [1:4] "DMG" "D8" "19770816" "M"
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr [1:4] "NM1" "M8" "2" "PENN STATE UNIVERSITY"
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:4] "HD" "021" NA "HLT"
#>   .. .. ..$ : chr [1:4] "DTP" "348" "D8" "19960601"
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "15" "12345"
#>   .. ..$ GE : chr [1:2] "1" "000000103"
#>   .. ..$ IEA: chr [1:2] "1" "000000103"
#>  $ 834_EX3_enroll_employee_mco             :List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "BE" "SENDERNAME" "RECEIVERNAME" "20041227" ...
#>   .. ..$ ST : chr [1:3] "834" "12345" "005010X220A1"
#>   ..$ details:List of 3
#>   .. ..$ : chr [1:9] "BGN" "00" "12456" "19980520" ...
#>   .. ..$ : chr [1:5] "N1" "P5" NA "FI" ...
#>   .. ..$ : chr [1:5] "N1" "IN" NA "FI" ...
#>   ..$ member :List of 5
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr [1:9] "INS" "Y" "18" "021" ...
#>   .. ..$ :List of 3
#>   .. .. ..$ : chr [1:3] "REF" "0F" "202443307"
#>   .. .. ..$ : chr [1:3] "REF" "1L" "123456001"
#>   .. .. ..$ : chr [1:4] "DTP" "356" "D8" "19960112"
#>   .. ..$ :List of 5
#>   .. .. ..$ : chr [1:10] "NM1" "IL" "1" "SMITH" ...
#>   .. .. ..$ : chr [1:7] "PER" "IP" NA "HP" ...
#>   .. .. ..$ : chr [1:2] "N3" "1715 SOUTHWIND AVENUE"
#>   .. .. ..$ : chr [1:4] "N4" "ANYTOWN" "PA" "171110000"
#>   .. .. ..$ : chr [1:4] "DMG" "D8" "19700614" "M"
#>   .. ..$ :List of 3
#>   .. .. ..$ : chr [1:4] "HD" "021" NA "HMO"
#>   .. .. ..$ : chr [1:4] "DTP" "348" "D8" "19960601"
#>   .. .. ..$ : chr [1:2] "LX" "01"
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr [1:11] "NM1" "P3" "1" "BROWN" ...
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "18" "12345"
#>   .. ..$ GE : chr [1:2] "1" "000000103"
#>   .. ..$ IEA: chr [1:2] "1" "000000103"
#>  $ 834_EX4_add_subscriber_coverage         :List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "BE" "SENDERNAME" "RECEIVERNAME" "20041227" ...
#>   .. ..$ ST : chr [1:3] "834" "12345" "005010X220A1"
#>   ..$ details:List of 4
#>   .. ..$ : chr [1:9] "BGN" "00" "12456" "20020601" ...
#>   .. ..$ : chr [1:3] "REF" "38" "ABCD012354"
#>   .. ..$ : chr [1:5] "N1" "P5" NA "FI" ...
#>   .. ..$ : chr [1:5] "N1" "IN" NA "FI" ...
#>   ..$ member :List of 4
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr [1:9] "INS" "Y" "18" "001" ...
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:3] "REF" "0F" "202443307"
#>   .. .. ..$ : chr [1:3] "REF" "1L" "123456001"
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr [1:10] "NM1" "IL" "1" "SMITH" ...
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:4] "HD" "021" NA "DEN"
#>   .. .. ..$ : chr [1:4] "DTP" "348" "D8" "20020701"
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "12" "12345"
#>   .. ..$ GE : chr [1:2] "1" "000000103"
#>   .. ..$ IEA: chr [1:2] "1" "000000103"
#>  $ 834_EX5_change_subscriber_info          :List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "BE" "SENDERNAME" "RECEIVERNAME" "20041227" ...
#>   .. ..$ ST : chr [1:3] "834" "12345" "005010X220A1"
#>   ..$ details:List of 3
#>   .. ..$ : chr [1:9] "BGN" "00" "12456" "19980520" ...
#>   .. ..$ : chr [1:5] "N1" "P5" "GENERIC INC" "FI" ...
#>   .. ..$ : chr [1:5] "N1" "IN" "ABC INSURANCE" "FI" ...
#>   ..$ member :List of 4
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr [1:9] "INS" "Y" "18" "001" ...
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:3] "REF" "0F" "123456789"
#>   .. .. ..$ : chr [1:3] "REF" "1L" "123456001"
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:10] "NM1" "IL" "1" "DOE" ...
#>   .. .. ..$ : chr [1:4] "DMG" "D8" "19500415" "M"
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:6] "NM1" "70" "1" "DOE" ...
#>   .. .. ..$ : chr [1:4] "DMG" "D8" "19500416" "M"
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "12" "12345"
#>   .. ..$ GE : chr [1:2] "1" "000000103"
#>   .. ..$ IEA: chr [1:2] "1" "000000103"
#>  $ 834_EX6_cancel_dependent                :List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "BE" "SENDERNAME" "RECEIVERNAME" "20041227" ...
#>   .. ..$ ST : chr [1:3] "834" "12345" "005010X220A1"
#>   ..$ details:List of 4
#>   .. ..$ : chr [1:9] "BGN" "00" "12456" "19980520" ...
#>   .. ..$ : chr [1:3] "REF" "38" "ABCD012354"
#>   .. ..$ : chr [1:5] "N1" "P5" NA "FI" ...
#>   .. ..$ : chr [1:5] "N1" "IN" NA "FI" ...
#>   ..$ member :List of 3
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr [1:6] "INS" "N" "19" "024" ...
#>   .. ..$ :List of 3
#>   .. .. ..$ : chr [1:3] "REF" "0F" "123456789"
#>   .. .. ..$ : chr [1:3] "REF" "1L" "123456001"
#>   .. .. ..$ : chr [1:4] "DTP" "357" "D8" "19960801"
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:10] "NM1" "IL" "1" "DOE" ...
#>   .. .. ..$ : chr [1:4] "DMG" "D8" "19770816" "M"
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "12" "12345"
#>   .. ..$ GE : chr [1:2] "1" "000000103"
#>   .. ..$ IEA: chr [1:2] "1" "000000103"
#>  $ 834_EX7_terminate_subscriber_eligibility:List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "BE" "SENDERNAME" "RECEIVERNAME" "20041227" ...
#>   .. ..$ ST : chr [1:3] "834" "12345" "005010X220A1"
#>   ..$ details:List of 3
#>   .. ..$ : chr [1:9] "BGN" "00" "12456" "19980520" ...
#>   .. ..$ : chr [1:5] "N1" "P5" NA "FI" ...
#>   .. ..$ : chr [1:5] "N1" "IN" NA "FI" ...
#>   ..$ member :List of 3
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr [1:9] "INS" "Y" "18" "024" ...
#>   .. ..$ :List of 3
#>   .. .. ..$ : chr [1:3] "REF" "0F" "123456789"
#>   .. .. ..$ : chr [1:3] "REF" "1L" "123456001"
#>   .. .. ..$ : chr [1:4] "DTP" "357" "D8" "19961001"
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr [1:10] "NM1" "IL" "1" "DOE" ...
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "10" "12345"
#>   .. ..$ GE : chr [1:2] "1" "000000103"
#>   .. ..$ IEA: chr [1:2] "1" "000000103"
#>  $ 834_EX8_reinstate_employee              :List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "BE" "SENDERNAME" "RECEIVERNAME" "20041227" ...
#>   .. ..$ ST : chr [1:3] "834" "12345" "005010X220A1"
#>   ..$ details:List of 4
#>   .. ..$ : chr [1:9] "BGN" "00" "12456" "19980520" ...
#>   .. ..$ : chr [1:3] "REF" "38" "ABCD012354"
#>   .. ..$ : chr [1:5] "N1" "P5" NA "FI" ...
#>   .. ..$ : chr [1:5] "N1" "IN" NA "FI" ...
#>   ..$ member :List of 3
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr [1:9] "INS" "Y" "18" "025" ...
#>   .. ..$ :List of 3
#>   .. .. ..$ : chr [1:3] "REF" "0F" "123456789"
#>   .. .. ..$ : chr [1:3] "REF" "1L" "123456001"
#>   .. .. ..$ : chr [1:4] "DTP" "303" "D8" "19961001"
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr [1:10] "NM1" "IL" "1" "DOE" ...
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "11" "12345"
#>   .. ..$ GE : chr [1:2] "1" "000000103"
#>   .. ..$ IEA: chr [1:2] "1" "000000103"
#>  $ 834_EX9_reinstate_employee_coverage     :List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "BE" "SENDERNAME" "RECEIVERNAME" "20041227" ...
#>   .. ..$ ST : chr [1:3] "834" "12345" "005010X220A1"
#>   ..$ details:List of 4
#>   .. ..$ : chr [1:9] "BGN" "00" "12456" "20020601" ...
#>   .. ..$ : chr [1:3] "REF" "38" "ABCD012354"
#>   .. ..$ : chr [1:5] "N1" "P5" NA "FI" ...
#>   .. ..$ : chr [1:5] "N1" "IN" NA "FI" ...
#>   ..$ member :List of 4
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr [1:9] "INS" "Y" "18" "025" ...
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:3] "REF" "0F" "202443307"
#>   .. .. ..$ : chr [1:3] "REF" "1L" "123456001"
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr [1:10] "NM1" "IL" "1" "SMITH" ...
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:4] "HD" "025" NA "DEN"
#>   .. .. ..$ : chr [1:4] "DTP" "348" "D8" "20020701"
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "12" "12345"
#>   .. ..$ GE : chr [1:2] "1" "000000103"
#>   .. ..$ IEA: chr [1:2] "1" "000000103"
#>  $ benefit_enrollment_834_220              :List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "BE" "386028429" "382328142" "20050221" ...
#>   .. ..$ ST : chr [1:3] "834" "12345" "005010X220A1"
#>   ..$ details:List of 3
#>   .. ..$ : chr [1:9] "BGN" "00" "12456" "19980520" ...
#>   .. ..$ : chr [1:5] "N1" "P5" NA "FI" ...
#>   .. ..$ : chr [1:5] "N1" "IN" NA "FI" ...
#>   ..$ member :List of 6
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr [1:9] "INS" "Y" "18" "021" ...
#>   .. ..$ :List of 3
#>   .. .. ..$ : chr [1:3] "REF" "0F" "123456789"
#>   .. .. ..$ : chr [1:3] "REF" "1L" "123456001"
#>   .. .. ..$ : chr [1:4] "DTP" "356" "D8" "19960523"
#>   .. ..$ :List of 5
#>   .. .. ..$ : chr [1:10] "NM1" "IL" "1" "DOE" ...
#>   .. .. ..$ : chr [1:7] "PER" "IP" NA "HP" ...
#>   .. .. ..$ : chr [1:3] "N3" "100 MARKET ST" "APT 3G"
#>   .. .. ..$ : chr [1:7] "N4" "CAMP HILL" "PA" "17011" ...
#>   .. .. ..$ : chr [1:4] "DMG" "D8" "19400816" "M"
#>   .. ..$ :List of 3
#>   .. .. ..$ : chr [1:4] "HD" "021" NA "HLT"
#>   .. .. ..$ : chr [1:4] "DTP" "348" "D8" "19960601"
#>   .. .. ..$ : chr [1:4] "COB" "P" "890111" "5"
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:4] "HD" "021" NA "DEN"
#>   .. .. ..$ : chr [1:4] "DTP" "348" "D8" "19960601"
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:4] "HD" "021" NA "VIS"
#>   .. .. ..$ : chr [1:4] "DTP" "348" "D8" "19960601"
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "21" "12345"
#>   .. ..$ GE : chr [1:2] "1" "000012345"
#>   .. ..$ IEA: chr [1:2] "1" "000012345"
#>  $ sample_834_01                           :List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "BE" "DHCS" "HEALTHPLAN" "20250108" ...
#>   .. ..$ ST : chr [1:3] "834" "0001" "005010X220A1"
#>   ..$ details:List of 5
#>   .. ..$ : chr [1:9] "BGN" "00" "12345" "20250108" ...
#>   .. ..$ : chr [1:3] "REF" "38" "MEDI-CAL"
#>   .. ..$ : chr [1:4] "DTP" "007" "D8" "20250108"
#>   .. ..$ : chr [1:5] "N1" "P5" "CALIFORNIA DHCS" "FI" ...
#>   .. ..$ : chr [1:5] "N1" "IN" "HEALTH PLAN NAME" "FI" ...
#>   ..$ member :List of 23
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr [1:10] "INS" "Y" "18" "021" ...
#>   .. ..$ :List of 4
#>   .. .. ..$ : chr [1:3] "REF" "0F" "MBR001"
#>   .. .. ..$ : chr [1:3] "REF" "6P" "TESTMBI000000001"
#>   .. .. ..$ : chr [1:3] "REF" "1D" "TESTMCD000000001"
#>   .. .. ..$ : chr [1:3] "REF" "ABB" "QMBPLUS"
#>   .. ..$ :List of 5
#>   .. .. ..$ : chr [1:10] "NM1" "IL" "1" "TESTLAST01" ...
#>   .. .. ..$ : chr [1:5] "PER" "IP" NA "HP" ...
#>   .. .. ..$ : chr [1:2] "N3" "123 TEST STREET"
#>   .. .. ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>   .. .. ..$ : chr [1:4] "DMG" "D8" "19000101" "F"
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "HD" "021" NA "HLT" ...
#>   .. .. ..$ : chr [1:4] "DTP" "348" "D8" "20240101"
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "HD" "021" NA "HLT" ...
#>   .. .. ..$ : chr [1:4] "DTP" "348" "D8" "20240101"
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr [1:10] "INS" "Y" "18" "001" ...
#>   .. ..$ :List of 4
#>   .. .. ..$ : chr [1:3] "REF" "0F" "MBR002"
#>   .. .. ..$ : chr [1:3] "REF" "6P" "TESTMBI000000002"
#>   .. .. ..$ : chr [1:3] "REF" "1D" "TESTMCD000000002"
#>   .. .. ..$ : chr [1:3] "REF" "AB" "4M"
#>   .. ..$ :List of 4
#>   .. .. ..$ : chr [1:10] "NM1" "IL" "1" "TESTLAST02" ...
#>   .. .. ..$ : chr [1:2] "N3" "123 TEST STREET"
#>   .. .. ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>   .. .. ..$ : chr [1:4] "DMG" "D8" "19000101" "M"
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "HD" "001" NA "HLT" ...
#>   .. .. ..$ : chr [1:4] "DTP" "348" "D8" "20230515"
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "HD" "001" NA "HLT" ...
#>   .. .. ..$ : chr [1:4] "DTP" "348" "D8" "20240101"
#>   .. .. [list output truncated]
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "68" "0001"
#>   .. ..$ GE : chr [1:2] "1" "1"
#>   .. ..$ IEA: chr [1:2] "1" "000000001"
#>   [list output truncated]

x = edi_index(c(x12_EX$`820`$`218`[1:2], x12_EX$`820`$`306`[1:2]))
str(edi_parse(x), list.len = 10L)
#> List of 4
#>  $ 820_Child_Health_Plus_Payment_EFT  :List of 4
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
#>   .. .. ..$ : chr [1:5] "ENT" "1" "2L" "24" ...
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "RMR" "1L" "12345678" NA ...
#>   .. .. ..$ : chr [1:3] "REF" "ZZ" "RECOVERY OF FUNDS"
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "RMR" "1L" "12345678" NA ...
#>   .. .. ..$ : chr [1:3] "REF" "ZZ" "LUMP SUM PAYMENT"
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "ENT" "2" "2J" "EI" ...
#>   .. .. ..$ : chr [1:10] "NM1" "QE" "1" "LAST NAME" ...
#>   .. ..$ :List of 5
#>   .. .. ..$ : chr [1:5] "RMR" "AZ" "12345678" NA ...
#>   .. .. ..$ : chr [1:3] "REF" "ZZ" "1436500000001230"
#>   .. .. ..$ : chr [1:3] "REF" "ZZ" "0123456789"
#>   .. .. ..$ : chr [1:3] "REF" "LU" "01"
#>   .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "17" "222222222"
#>   .. ..$ GE : chr [1:2] "1" "333333333"
#>   .. ..$ IEA: chr [1:2] "1" "003333333"
#>  $ 820_Essentail_Health_Plan          :List of 4
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
#>   .. .. ..$ : chr [1:5] "ENT" "1" "2J" "EI" ...
#>   .. .. ..$ : chr [1:10] "NM1" "QE" "1" "LASTNAME" ...
#>   .. ..$ :List of 6
#>   .. .. ..$ : chr [1:5] "RMR" "AZ" "LL88888L" NA ...
#>   .. .. ..$ : chr [1:3] "REF" "ZZ" "1500311111112540"
#>   .. .. ..$ : chr [1:3] "REF" "ZZ" "0123456789"
#>   .. .. ..$ : chr [1:3] "REF" "LU" "01"
#>   .. .. ..$ : chr [1:3] "REF" "ZZ" "51"
#>   .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "14" "221500001"
#>   .. ..$ GE : chr [1:2] "1" "5113240"
#>   .. ..$ IEA: chr [1:2] "1" "005113240"
#>  $ 820_EX10_debt_covered_by_affiliate1:List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "RA" "SENDERGS" "RECEIVERGS" "20240221" ...
#>   .. ..$ ST : chr [1:3] "820" "0001" "005010X306"
#>   ..$ details:List of 5
#>   .. ..$ : chr [1:17] "BPR" "I" "0" "C" ...
#>   .. ..$ : chr [1:3] "TRN" "3" "123456789123385"
#>   .. ..$ : chr [1:5] "N1" "PE" "NATIONAL EAST" "FI" ...
#>   .. ..$ : chr [1:5] "N1" "RM" "CMS" "58" ...
#>   .. ..$ : chr [1:7] "PER" "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#>   ..$ entity :List of 12
#>   .. ..$ :List of 6
#>   .. .. ..$ : chr [1:2] "ENT" "1"
#>   .. .. ..$ : chr [1:10] "NM1" "IL" "1" "HOPE" ...
#>   .. .. ..$ : chr [1:3] "REF" "38" "12345MD000011500"
#>   .. .. ..$ : chr [1:3] "REF" "POL" "4599"
#>   .. .. ..$ : chr [1:3] "REF" "AZ" "PLAN2"
#>   .. .. ..$ : chr [1:3] "REF" "0F" "SUB1234"
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "RMR" "ZZ" "APTC" NA ...
#>   .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "RMR" "ZZ" "CSR" NA ...
#>   .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "RMR" "ZZ" "UF" NA ...
#>   .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "RMR" "ZZ" "APTCADJ" NA ...
#>   .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "RMR" "ZZ" "APTCADJ" NA ...
#>   .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   .. ..$ :List of 6
#>   .. .. ..$ : chr [1:2] "ENT" "2"
#>   .. .. ..$ : chr [1:10] "NM1" "IL" "1" "RENEE" ...
#>   .. .. ..$ : chr [1:3] "REF" "38" "12346MD000011501"
#>   .. .. ..$ : chr [1:3] "REF" "POL" "5678"
#>   .. .. ..$ : chr [1:3] "REF" "AZ" "PLAN4"
#>   .. .. ..$ : chr [1:3] "REF" "0F" "SUB2348"
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "RMR" "ZZ" "APTC" NA ...
#>   .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "RMR" "ZZ" "CSR" NA ...
#>   .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "RMR" "ZZ" "UF" NA ...
#>   .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   .. .. [list output truncated]
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "38" "0001"
#>   .. ..$ GE : chr [1:2] "1" "000000001"
#>   .. ..$ IEA: chr [1:2] "1" "000000001"
#>  $ 820_EX11_debt_covered_by_affiliate2:List of 4
#>   ..$ header :List of 3
#>   .. ..$ ISA: chr [1:16] "00" NA "00" NA ...
#>   .. ..$ GS : chr [1:8] "RA" "SENDERGS" "RECEIVERGS" "20240221" ...
#>   .. ..$ ST : chr [1:3] "820" "0002" "005010X306"
#>   ..$ details:List of 5
#>   .. ..$ : chr [1:17] "BPR" "I" "0" "C" ...
#>   .. ..$ : chr [1:3] "TRN" "3" "12345678945678"
#>   .. ..$ : chr [1:5] "N1" "PE" "NATIONAL EAST" "FI" ...
#>   .. ..$ : chr [1:5] "N1" "RM" "CMS" "58" ...
#>   .. ..$ : chr [1:7] "PER" "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#>   ..$ entity :List of 12
#>   .. ..$ :List of 6
#>   .. .. ..$ : chr [1:2] "ENT" "1"
#>   .. .. ..$ : chr [1:10] "NM1" "IL" "1" "HOPE" ...
#>   .. .. ..$ : chr [1:3] "REF" "38" "12345MD000011501"
#>   .. .. ..$ : chr [1:3] "REF" "POL" "4599"
#>   .. .. ..$ : chr [1:3] "REF" "AZ" "PLAN2"
#>   .. .. ..$ : chr [1:3] "REF" "0F" "SUB1234"
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "RMR" "ZZ" "APTC" NA ...
#>   .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "RMR" "ZZ" "CSR" NA ...
#>   .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "RMR" "ZZ" "UF" NA ...
#>   .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "RMR" "ZZ" "APTCADJ" NA ...
#>   .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "RMR" "ZZ" "APTCADJ" NA ...
#>   .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   .. ..$ :List of 6
#>   .. .. ..$ : chr [1:2] "ENT" "2"
#>   .. .. ..$ : chr [1:10] "NM1" "IL" "1" "RENEE" ...
#>   .. .. ..$ : chr [1:3] "REF" "38" "12346MD000011501"
#>   .. .. ..$ : chr [1:3] "REF" "POL" "5674"
#>   .. .. ..$ : chr [1:3] "REF" "AZ" "PLAN4"
#>   .. .. ..$ : chr [1:3] "REF" "0F" "SUB2348"
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "RMR" "ZZ" "APTC" NA ...
#>   .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "RMR" "ZZ" "CSR" NA ...
#>   .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   .. ..$ :List of 2
#>   .. .. ..$ : chr [1:5] "RMR" "ZZ" "UF" NA ...
#>   .. .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>   .. .. [list output truncated]
#>   ..$ trailer:List of 3
#>   .. ..$ SE : chr [1:2] "39" "0002"
#>   .. ..$ GE : chr [1:2] "1" "000000001"
#>   .. ..$ IEA: chr [1:2] "1" "000000001"
```
