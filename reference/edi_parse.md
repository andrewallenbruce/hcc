# Create an EDI Parse Object

Create an EDI Parse Object

## Usage

``` r
edi_parse(x, ...)
```

## Arguments

- x:

  raw X12 text input

- ...:

  dots

## Value

an `<hcc::ParsedEDI>` S7 object

## Details

Methods for `edi_parse`:

- `ANY`

- `character`

- `hcc::Index820`

- `hcc::Index834`

- `hcc::Index837`

- `hcc::Parsed820`

- `hcc::Parsed834`

- `hcc::Parsed837`

- `list`

## Examples

``` r
edi_parse(x12_EX$`820`) |> hcc:::tails_(2L)
#> $`218`
#> $`218`$`820_Child_Health_Plus_Payment_EFT`
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "I" "239.6" "C" "ACH" "CCP" "01" "111111111" NA NA ...
#>  @ TRN: chr [1:3] "3" "021300000000000" "1141797357"
#>  @ REF: chr [1:2] "14" "12345678"
#>  @ NPE: chr [1:4] "PE" "MANAGED CARE" "FI" "123456789"
#>  @ NPR: chr [1:2] "PR" "CHILD HEALTH PLUS"
#> 
#> $`218`$`820_Essentail_Health_Plan`
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "I" "123.45" "C" "CHK" NA NA NA NA NA "1141797357" NA NA ...
#>  @ TRN: chr [1:3] "3" "000000032788113" "1141797357"
#>  @ REF: chr [1:2] "14" "12345678"
#>  @ NPE: chr [1:4] "PE" NA "FI" "123456789"
#>  @ NPR: chr [1:7] "PR" "BASIC HEALTH PLAN" ...
#> 
#> $`218`$`820_Premium_Payment_EFT`
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "I" "566.29" "C" "ACH" "CCP" "01" "111111111" NA NA ...
#>  @ TRN: chr [1:3] "3" "021300000000000" "1141797357"
#>  @ REF: chr [1:2] "14" "12345678"
#>  @ NPE: chr [1:4] "PE" "MANAGED CARE" "FI" "123456789"
#>  @ NPR: chr [1:4] "PR" "NYSDOH" "FI" "141797357"
#> 
#> $`218`$`820_Premium_Payment_NOPMT`
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA "1234567890" NA NA NA NA ...
#>  @ TRN: chr [1:3] "3" "021300000000000" "1123456789"
#>  @ REF: chr [1:2] "14" "12345678"
#>  @ NPE: chr [1:4] "PE" "MANAGED CARE" "FI" "123456789"
#>  @ NPR: chr [1:9] "PR" "NYSDOH" "FI" "141797357" ...
#> 
#> $`218`$payment_order_820_218
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "C" "19000" "C" "ACH" "CTX" "01" "999999992" "DA" ...
#>  @ TRN: chr [1:3] "1" "12345" "1030449999"
#>  @ REF: chr [1:2] "14" "12345"
#>  @ NPE: chr [1:4] "PE" "DEF HEALTH CARE INC." "FI" "012222222"
#>  @ NPR: chr [1:4] "PR" "ABC PLASTICS" "FI" "123456789"
#> 
#> $`218`$sample_820_01
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "I" "102139.46" "C" "NON" NA NA NA NA NA "68-0317191" NA ...
#>  @ TRN: chr [1:2] "3" "TESTTRN01000001"
#>  @ REF: chr [1:2] "14" "0000245023"
#>  @ NPE: chr [1:6] "PE" "TEST PAYEE ORGANIZATION" "123 TEST STREET" "TESTCITY" ...
#>  @ NPR: chr [1:6] "PR" "TEST PAYER AGENCY" "123 TEST STREET" "TESTCITY" "CA" ...
#> 
#> $`218`$sample_820_02
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "I" "91977.81" "C" "NON" NA NA NA NA NA "68-0317191" NA NA ...
#>  @ TRN: chr [1:2] "3" "TESTTRN02000001"
#>  @ REF: chr [1:2] "14" "0000245023"
#>  @ NPE: chr [1:6] "PE" "TEST PAYEE ORGANIZATION" "123 TEST STREET" "TESTCITY" ...
#>  @ NPR: chr [1:6] "PR" "TEST PAYER AGENCY" "123 TEST STREET" "TESTCITY" "CA" ...
#> 
#> $`218`$sample_820_03
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "I" "697085.64" "C" "NON" NA NA NA NA NA "68-0317191" NA ...
#>  @ TRN: chr [1:2] "3" "TESTTRN03000001"
#>  @ REF: chr [1:2] "14" "0000245023"
#>  @ NPE: chr [1:6] "PE" "TEST PAYEE ORGANIZATION" "123 TEST STREET" "TESTCITY" ...
#>  @ NPR: chr [1:6] "PR" "TEST PAYER AGENCY" "123 TEST STREET" "TESTCITY" "CA" ...
#> 
#> $`218`$sample_820_04
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "I" "80865.30" "C" "NON" NA NA NA NA NA "68-0317191" NA NA ...
#>  @ TRN: chr [1:2] "3" "TESTTRN04000001"
#>  @ REF: chr [1:2] "14" "0000245023"
#>  @ NPE: chr [1:6] "PE" "TEST PAYEE ORGANIZATION" "123 TEST STREET" "TESTCITY" ...
#>  @ NPR: chr [1:6] "PR" "TEST PAYER AGENCY" "123 TEST STREET" "TESTCITY" "CA" ...
#> 
#> $`218`$sample_820_05
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "I" "499187.57" "C" "NON" NA NA NA NA NA "68-0317191" NA ...
#>  @ TRN: chr [1:2] "3" "TESTTRN05000001"
#>  @ REF: chr [1:2] "14" "0000245023"
#>  @ NPE: chr [1:6] "PE" "TEST PAYEE ORGANIZATION" "123 TEST STREET" "TESTCITY" ...
#>  @ NPR: chr [1:6] "PR" "TEST PAYER AGENCY" "123 TEST STREET" "TESTCITY" "CA" ...
#> 
#> 
#> $`306`
#> $`306`$`820_EX10_debt_covered_by_affiliate1`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA NA NA NA NA NA NA ...
#>  @ TRN: chr [1:2] "3" "123456789123385"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "NATIONAL EAST" "FI" "121231244"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`306`$`820_EX11_debt_covered_by_affiliate2`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA NA NA NA NA NA NA ...
#>  @ TRN: chr [1:2] "3" "12345678945678"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "NATIONAL EAST" "FI" "121231244"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`306`$`820_EX12_csr_manual_adj`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA NA NA NA NA NA NA ...
#>  @ TRN: chr [1:2] "3" "123456789123456"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "NATIONAL" "FI" "121231233"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`306`$`820_EX1_different_types_of_pmt_by_HIX`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "220" "C" "ACH" "CCP" NA NA NA NA NA NA "01" ...
#>  @ TRN: chr [1:2] "3" "78905"
#>  @ REF: chr [1:4] "38" "123456" "TV" "12565496"
#>  @ NPE: chr [1:4] "PE" "BATA INSURANCE CO." "FI" "012222222"
#>  @ NRM: chr [1:4] "RM" "GOVERNMENT AGENCY" "58" "123ABC"
#>  @ PER: chr NA
#> 
#> $`306`$`820_EX2_payments_exceed_charges1`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA NA NA NA NA NA NA ...
#>  @ TRN: chr [1:2] "3" "123456789123456"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "NATIONAL" "FI" "121231233"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`306`$`820_EX3_payments_exceed_charges2`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "1110" "C" "ACH" "CCP" NA NA NA NA NA NA "01" ...
#>  @ TRN: chr [1:2] "3" "123456789123459"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "NATIONAL" "FI" "121231233"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`306`$`820_EX4_charges_exceed_payments1`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA NA NA NA NA NA NA ...
#>  @ TRN: chr [1:2] "3" "123456789123457"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "USINS" "FI" "121231234"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`306`$`820_EX5_charges_exceed_payments2`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA NA NA NA NA NA NA ...
#>  @ TRN: chr [1:2] "3" "123456789123567"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "USINS" "FI" "121231234"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`306`$`820_EX6_aptc_adjustments1`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA NA NA NA NA NA NA ...
#>  @ TRN: chr [1:2] "3" "123456789123456"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "NATIONAL" "FI" "121231233"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`306`$`820_EX7_aptc_adjustments2`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "910" "C" "ACH" "CCP" NA NA NA NA NA NA "01" ...
#>  @ TRN: chr [1:2] "3" "123456789123459"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "NATIONAL" "FI" "121231233"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`306`$`820_EX8_outstanding_debt_owed1`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA NA NA NA NA NA NA ...
#>  @ TRN: chr [1:2] "3" "1234512345098"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "NATIONAL" "FI" "121231233"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`306`$`820_EX9_outstanding_debt_owed2`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "985" "C" "ACH" "CCP" NA NA NA NA NA NA "01" ...
#>  @ TRN: chr [1:2] "3" "123456789123459"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "NATIONAL" "FI" "121231233"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`306`$payment_order_820_360
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "220" "C" "ACH" "CCP" NA NA NA NA NA NA "01" ...
#>  @ TRN: chr [1:2] "3" "78905"
#>  @ REF: chr [1:4] "38" "123456" "TV" "12565496"
#>  @ NPE: chr [1:4] "PE" "BATA INSURANCE CO." "FI" "012222222"
#>  @ NRM: chr [1:4] "RM" "GOVERNMENT AGENCY" "58" "123ABC"
#>  @ PER: chr NA
#> 
#> 
edi_parse(x12_EX$`834`) |> hcc:::tails_()
#> $`834_EX2_add_dependent`
#> <hcc::Detail834>
#>  @ BGN: chr [1:8] "00" "12456" "19980520" "1200" NA NA NA "2"
#>  @ REF: chr [1:2] "38" "ABCD012354"
#>  @ DTP: chr NA
#>  @ QTY: chr NA
#>  @ NP5: chr [1:4] "P5" NA "FI" "999888777"
#>  @ NIN: chr [1:4] "IN" NA "FI" "654456654"
#> 
#> $`834_EX3_enroll_employee_mco`
#> <hcc::Detail834>
#>  @ BGN: chr [1:8] "00" "12456" "19980520" "1200" NA NA NA "2"
#>  @ REF: chr NA
#>  @ DTP: chr NA
#>  @ QTY: chr NA
#>  @ NP5: chr [1:4] "P5" NA "FI" "999888777"
#>  @ NIN: chr [1:4] "IN" NA "FI" "654456654"
#> 
#> $`834_EX4_add_subscriber_coverage`
#> <hcc::Detail834>
#>  @ BGN: chr [1:8] "00" "12456" "20020601" "1200" NA NA NA "2"
#>  @ REF: chr [1:2] "38" "ABCD012354"
#>  @ DTP: chr NA
#>  @ QTY: chr NA
#>  @ NP5: chr [1:4] "P5" NA "FI" "999888777"
#>  @ NIN: chr [1:4] "IN" NA "FI" "654456654"
#> 
#> $`834_EX5_change_subscriber_info`
#> <hcc::Detail834>
#>  @ BGN: chr [1:8] "00" "12456" "19980520" "1200" NA NA NA "2"
#>  @ REF: chr NA
#>  @ DTP: chr NA
#>  @ QTY: chr NA
#>  @ NP5: chr [1:4] "P5" "GENERIC INC" "FI" "000111000"
#>  @ NIN: chr [1:4] "IN" "ABC INSURANCE" "FI" "654456654"
#> 
#> $`834_EX6_cancel_dependent`
#> <hcc::Detail834>
#>  @ BGN: chr [1:8] "00" "12456" "19980520" "1200" NA NA NA "2"
#>  @ REF: chr [1:2] "38" "ABCD012354"
#>  @ DTP: chr NA
#>  @ QTY: chr NA
#>  @ NP5: chr [1:4] "P5" NA "FI" "999888777"
#>  @ NIN: chr [1:4] "IN" NA "FI" "654456654"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`
#> <hcc::Detail834>
#>  @ BGN: chr [1:8] "00" "12456" "19980520" "1200" NA NA NA "2"
#>  @ REF: chr NA
#>  @ DTP: chr NA
#>  @ QTY: chr NA
#>  @ NP5: chr [1:4] "P5" NA "FI" "999888777"
#>  @ NIN: chr [1:4] "IN" NA "FI" "654456654"
#> 
#> $`834_EX8_reinstate_employee`
#> <hcc::Detail834>
#>  @ BGN: chr [1:8] "00" "12456" "19980520" "1200" NA NA NA "2"
#>  @ REF: chr [1:2] "38" "ABCD012354"
#>  @ DTP: chr NA
#>  @ QTY: chr NA
#>  @ NP5: chr [1:4] "P5" NA "FI" "999888777"
#>  @ NIN: chr [1:4] "IN" NA "FI" "654456654"
#> 
#> $`834_EX9_reinstate_employee_coverage`
#> <hcc::Detail834>
#>  @ BGN: chr [1:8] "00" "12456" "20020601" "1200" NA NA NA "2"
#>  @ REF: chr [1:2] "38" "ABCD012354"
#>  @ DTP: chr NA
#>  @ QTY: chr NA
#>  @ NP5: chr [1:4] "P5" NA "FI" "999888777"
#>  @ NIN: chr [1:4] "IN" NA "FI" "654456654"
#> 
#> $benefit_enrollment_834_220
#> <hcc::Detail834>
#>  @ BGN: chr [1:8] "00" "12456" "19980520" "1200" NA NA NA "2"
#>  @ REF: chr NA
#>  @ DTP: chr NA
#>  @ QTY: chr NA
#>  @ NP5: chr [1:4] "P5" NA "FI" "999888777"
#>  @ NIN: chr [1:4] "IN" NA "FI" "654456654"
#> 
#> $sample_834_01
#> <hcc::Detail834>
#>  @ BGN: chr [1:8] "00" "12345" "20250108" "1430" NA NA NA "2"
#>  @ REF: chr [1:2] "38" "MEDI-CAL"
#>  @ DTP: chr [1:3] "007" "D8" "20250108"
#>  @ QTY: chr NA
#>  @ NP5: chr [1:4] "P5" "CALIFORNIA DHCS" "FI" "953654321"
#>  @ NIN: chr [1:4] "IN" "HEALTH PLAN NAME" "FI" "987654321"
#> 
#> $sample_834_02
#> <hcc::Detail834>
#>  @ BGN: chr [1:8] "00" "DHCS834-DA-20250124-Sample PACE-001" "20250124" ...
#>  @ REF: chr NA
#>  @ DTP: chr NA
#>  @ QTY: chr [1:2] "TO" "1"
#>  @ NP5: chr [1:4] "P5" ...
#>  @ NIN: chr [1:4] "IN" "Sample PACE Inc." "FI" "999999991"
#> 
#> $sample_834_03
#> <hcc::Detail834>
#>  @ BGN: chr [1:8] "00" "DHCS834-DA-20250812-Sample South LA PACE-957-001" ...
#>  @ REF: chr NA
#>  @ DTP: chr NA
#>  @ QTY: chr [1:2] "TO" "1"
#>  @ NP5: chr [1:4] "P5" ...
#>  @ NIN: chr [1:4] "IN" "Sample South LA PACE Inc." "FI" "999999992"
#> 
#> $sample_834_04
#> <hcc::Detail834>
#>  @ BGN: chr [1:8] "00" "DHCS834-DA-20251022-Sample South LA PACE-957-001" ...
#>  @ REF: chr NA
#>  @ DTP: chr NA
#>  @ QTY: chr [1:2] "TO" "1"
#>  @ NP5: chr [1:4] "P5" ...
#>  @ NIN: chr [1:4] "IN" "Sample South LA PACE Inc." "FI" "999999992"
#> 
#> $sample_834_05
#> <hcc::Detail834>
#>  @ BGN: chr [1:8] "00" "DHCS834-DA-20251023-Sample South LA PACE-957-001" ...
#>  @ REF: chr NA
#>  @ DTP: chr NA
#>  @ QTY: chr [1:2] "TO" "1"
#>  @ NP5: chr [1:4] "P5" ...
#>  @ NIN: chr [1:4] "IN" "Sample South LA PACE Inc." "FI" "999999992"
#> 
#> $sample_834_06
#> <hcc::Detail834>
#>  @ BGN: chr [1:8] "00" "DHCS834-DA-20250206-Sample PACE-001" "20250206" ...
#>  @ REF: chr NA
#>  @ DTP: chr NA
#>  @ QTY: chr [1:2] "TO" "2"
#>  @ NP5: chr [1:4] "P5" ...
#>  @ NIN: chr [1:4] "IN" "Sample PACE Inc." "FI" "999999991"
#> 
edi_parse(x12_EX$`837`)
#> $I223
#> $I223$`837I_EX1a_institutional_claim`
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "HC" "SENDERGS" "RECEIVERGS" "20231106" "140822" ...
#>  .. @ ST : chr [1:3] "837" "987654" "005010X223A2"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "0123" "19960918" "0932" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "JONES HOSPITAL" NA NA NA NA "46" "12345"
#>  .. @ P41: chr [1:4] "IC" "JANE DOE" "TE" "9005555555"
#>  .. @ N40: chr [1:9] "40" "2" "MEDICARE" NA NA NA NA "46" "00120"
#>  .. @ P40: chr NA
#>  @ Claims :List of 5
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:4] "PRV" "BI" "PXC" "203BA0200N"
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "JONES HOSPITAL" ...
#>  ..  ..$ : chr [1:2] "N3" "225 MAIN STREET BARKLEY BUILDING"
#>  ..  ..$ : chr [1:4] "N4" "CENTERVILLE" "PA" "17111"
#>  ..  ..$ : chr [1:3] "REF" "EI" "567891234"
#>  ..  ..$ : chr [1:5] "PER" "IC" "CONNIE" "TE" ...
#>  .. $ :List of 8
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" NA ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "DOE" ...
#>  ..  ..$ : chr [1:2] "N3" "125 CITY AVENUE"
#>  ..  ..$ : chr [1:4] "N4" "CENTERVILLE" "PA" "17111"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19261111" "M"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "MEDICARE B" ...
#>  ..  ..$ : chr [1:3] "REF" "G2" "330127"
#>  .. $ :List of 16
#>  ..  ..$ : chr [1:10] "CLM" "756048Q" "89.93" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "19960911"
#>  ..  ..$ : chr [1:4] "CL1" "3" NA "01"
#>  ..  ..$ : chr [1:2] "HI" "BK>3669"
#>  ..  ..$ : chr [1:3] "HI" "BF>4019" "BF>79431"
#>  ..  ..$ : chr [1:5] "HI" "BH>A1>D8>19261111" "BH>A2>D8>19911101" "BH>B1>D8>19261111" ...
#>  ..  ..$ : chr [1:2] "HI" "BE>A2>>>15.31"
#>  ..  ..$ : chr [1:2] "HI" "BG>09"
#>  ..  ..$ : chr [1:6] "NM1" "71" "1" "JONES" ...
#>  ..  ..$ : chr [1:3] "REF" "1G" "B99937"
#>  ..  ..$ : chr [1:10] "SBR" "S" "01" "351630" ...
#>  ..  ..$ : chr [1:7] "OI" NA NA "Y" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "DOE" ...
#>  ..  ..$ : chr [1:2] "N3" "125 CITY AVENUE"
#>  ..  ..$ : chr [1:4] "N4" "CENTERVILLE" "PA" "17111"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "STATE TEACHERS" ...
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:6] "SV2" "0305" "HC>85025" "13.39" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "19960911"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:6] "SV2" "0730" "HC>93005" "76.54" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "19960911"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "43" "987654"
#>  .. @ GE : chr [1:2] "1" "000000001"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> $I223$`837I_EX1b_2claims_1provider`
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "HC" "SENDERGS" "RECEIVERGS" "20231106" "141054" ...
#>  .. @ ST : chr [1:3] "837" "987654" "005010X223A2"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "0123" "20050630" "0932" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "JONES HOSPITAL" NA NA NA NA "46" "12345"
#>  .. @ P41: chr [1:4] "IC" "JANE DOE" "TE" "1112223333"
#>  .. @ N40: chr [1:9] "40" "2" "TRICARE" NA NA NA NA "46" "99999"
#>  .. @ P40: chr NA
#>  @ Claims :List of 8
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:4] "PRV" "BI" "PXC" "282N00000X"
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "JONES HOSPITAL" ...
#>  ..  ..$ : chr [1:2] "N3" "225 MAIN STREET"
#>  ..  ..$ : chr [1:4] "N4" "ANYWHERE" "PA" "17111"
#>  ..  ..$ : chr [1:3] "REF" "EI" "123456789"
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" NA ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "DOE" ...
#>  ..  ..$ : chr [1:2] "N3" "125 CITY AVENUE"
#>  ..  ..$ : chr [1:4] "N4" "CENTERVILLE" "PA" "17111"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19681111" "M"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "TRICARE" ...
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:10] "CLM" "756048Q" "89.95" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "20050315-20050315"
#>  ..  ..$ : chr [1:4] "CL1" "1" NA "01"
#>  ..  ..$ : chr [1:2] "HI" "BK>3669"
#>  ..  ..$ : chr [1:3] "HI" "BF>4019" "BF>79431"
#>  ..  ..$ : chr [1:10] "NM1" "71" "1" "JONES" ...
#>  ..  ..$ : chr [1:3] "REF" "1G" "U12345"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:6] "SV2" "0305" "HC>85025" "13.39" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20050315"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:6] "SV2" "0730" "HC>93010" "76.56" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20050315"
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "3" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" NA ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "SMITH" ...
#>  ..  ..$ : chr [1:2] "N3" "5 MAIN STREET"
#>  ..  ..$ : chr [1:4] "N4" "ANYWHERE" "PA" "17111"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19621210" "M"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "TRICARE" ...
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:10] "CLM" "756049Q" "50" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "20050401-20050401"
#>  ..  ..$ : chr [1:4] "CL1" "1" NA "01"
#>  ..  ..$ : chr [1:2] "HI" "BK>30000"
#>  ..  ..$ : chr [1:10] "NM1" "71" "1" "JONES" ...
#>  ..  ..$ : chr [1:4] "PRV" "AT" "PXC" "363LP0200N"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:6] "SV2" "0300" "HC>85087" "50" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20050401"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "48" "987654"
#>  .. @ GE : chr [1:2] "1" "000000001"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> $I223$`837I_EX1c_ppo_repriced_claim`
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "HC" "SENDERGS" "RECEIVERGS" "20231106" "141512" ...
#>  .. @ ST : chr [1:3] "837" "1002" "005010X223A2"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "1002" "20050721" "09460000" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "REGIONAL PPO NETWORK" NA NA NA NA "46" ...
#>  .. @ P41: chr [1:4] "IC" "SUBMITTER CONTACT INFO" "TE" "8001231234"
#>  .. @ N40: chr [1:9] "40" "2" "LOCAL INSURANCE COMPANY" NA NA NA NA "46" ...
#>  .. @ P40: chr NA
#>  @ Claims :List of 6
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "GOOD HEALTH HOSPITAL" ...
#>  ..  ..$ : chr [1:2] "N3" "592 NORTH ELM STREET"
#>  ..  ..$ : chr [1:4] "N4" "EDGEWOOD" "AZ" "860015590"
#>  ..  ..$ : chr [1:3] "REF" "EI" "344232321"
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" NA "46522567AW" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "JONES" ...
#>  ..  ..$ : chr [1:2] "N3" "4512 WEST AVENUE"
#>  ..  ..$ : chr [1:4] "N4" "EVANSVILLE" "AZ" "863030000"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19690731" "F"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "LOCAL INSURANCE COMPANY" ...
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "3" "2" "23" ...
#>  ..  ..$ : chr [1:2] "PAT" "19"
#>  ..  ..$ : chr [1:5] "NM1" "QC" "1" "JONES" ...
#>  ..  ..$ : chr [1:2] "N3" "4512 WEST AVENUE"
#>  ..  ..$ : chr [1:4] "N4" "EVANSVILLE" "AZ" "863030000"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19980820" "F"
#>  .. $ :List of 16
#>  ..  ..$ : chr [1:10] "CLM" "456DFH43" "237.5" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "20050706-20050706"
#>  ..  ..$ : chr [1:4] "DTP" "435" "DT" "200507060800"
#>  ..  ..$ : chr [1:4] "CL1" "1" "2" "01"
#>  ..  ..$ : chr [1:3] "AMT" "F3" "237.5"
#>  ..  ..$ : chr [1:3] "REF" "9A" "09459034092"
#>  ..  ..$ : chr [1:3] "REF" "D9" "04566877634343456"
#>  ..  ..$ : chr [1:2] "HI" "BK>38181"
#>  ..  ..$ : chr [1:2] "HI" "BF>38900"
#>  ..  ..$ : chr [1:2] "HI" "BH>11>D8>20050706"
#>  ..  ..$ : chr [1:5] "HCP" "03" "182.88" "54.62" ...
#>  ..  ..$ : chr [1:10] "NM1" "71" "1" "JOHNSON" ...
#>  ..  ..$ : chr [1:10] "SBR" "S" "19" NA ...
#>  ..  ..$ : chr [1:7] "OI" NA NA "Y" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "JONES" ...
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "OTHER COVERAGE COMPANY" ...
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:6] "SV2" "0471" "HC>92557" "178" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20050706"
#>  ..  ..$ : chr [1:4] "HCP" "03" "137.06" "40.94"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:6] "SV2" "0471" "HC>92567" "59.5" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20050706"
#>  ..  ..$ : chr [1:4] "HCP" "03" "45.82" "13.68"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "48" "1002"
#>  .. @ GE : chr [1:2] "1" "000000001"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> $I223$`837I_EX1d_oon_repriced_claim`
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "HC" "SENDERGS" "RECEIVERGS" "20231106" "141557" ...
#>  .. @ ST : chr [1:3] "837" "1024" "005010X223A2"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "1024" "20050711" "1335" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "REGIONAL PPO NETWORK" NA NA NA NA "46" ...
#>  .. @ P41: chr [1:4] "IC" "SUBMITTER CONTACT INFO" "TE" "8001231234"
#>  .. @ N40: chr [1:9] "40" "2" "CONSERVATIVE INSURANCE" NA NA NA NA "46" ...
#>  .. @ P40: chr NA
#>  @ Claims :List of 4
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "LOCAL HOSPITAL" ...
#>  ..  ..$ : chr [1:2] "N3" "3423 SMALL STREET"
#>  ..  ..$ : chr [1:4] "N4" "COLUMBUS" "OH" "432150000"
#>  ..  ..$ : chr [1:3] "REF" "EI" "111002222"
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" "34561W" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "SMITH" ...
#>  ..  ..$ : chr [1:2] "N3" "934 NORTH STREET"
#>  ..  ..$ : chr [1:4] "N4" "COLUMBUS" "OH" "432150000"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19621015" "M"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "CONSERVATIVE INSURANCE" ...
#>  .. $ :List of 10
#>  ..  ..$ : chr [1:10] "CLM" "W392-49141" "14.84" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "20050617-20050617"
#>  ..  ..$ : chr [1:4] "DTP" "435" "DT" "200506170800"
#>  ..  ..$ : chr [1:4] "CL1" "1" "1" "01"
#>  ..  ..$ : chr [1:3] "AMT" "F3" "14.84"
#>  ..  ..$ : chr [1:3] "REF" "9A" "459804390823"
#>  ..  ..$ : chr [1:3] "REF" "D9" "32423466233"
#>  ..  ..$ : chr [1:2] "HI" "BK>53081"
#>  ..  ..$ : chr [1:14] "HCP" "00" "0" NA ...
#>  ..  ..$ : chr [1:10] "NM1" "71" "1" "RIVERS" ...
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:6] "SV2" "0301" "HC>82270" "14.84" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20050617"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "31" "1024"
#>  .. @ GE : chr [1:2] "1" "000000001"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> $I223$`837I_EX2_car_accident`
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "HC" "SENDERGS" "RECEIVERGS" "20231106" "141625" ...
#>  .. @ ST : chr [1:3] "837" "557766" "005010X223A2"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "0324" "20051111" "1800" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "HALL OF FAME MEMORIAL HOSPITAL" NA NA NA NA ...
#>  .. @ P41: chr [1:4] "IC" "KATE CASEY" "TE" "7152569877"
#>  .. @ N40: chr [1:9] "40" "2" "HEISMAN INSURANCE COMPANY" NA NA NA NA "46" ...
#>  .. @ P40: chr NA
#>  @ Claims :List of 8
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:4] "PRV" "BI" "PXC" "203BA0200N"
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "HALL OF FAME MEMORIAL HOSPITAL" ...
#>  ..  ..$ : chr [1:2] "N3" "1 CANTON ROAD"
#>  ..  ..$ : chr [1:4] "N4" "BROKEN FIELD" "CA" "99998"
#>  ..  ..$ : chr [1:3] "REF" "EI" "737373737"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" NA NA ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "HOWLING" ...
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "HEISMAN INSURANCE COMPANY" ...
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "3" "2" "23" ...
#>  ..  ..$ : chr [1:2] "PAT" "21"
#>  ..  ..$ : chr [1:5] "NM1" "QC" "1" "MEXICO" ...
#>  ..  ..$ : chr [1:2] "N3" "32 BUFFALO RUN"
#>  ..  ..$ : chr [1:4] "N4" "ROCKING HORSE" "CA" "99666"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19480601" "M"
#>  ..  ..$ : chr [1:3] "REF" "Y4" "32323232"
#>  .. $ :List of 8
#>  ..  ..$ : chr [1:10] "CLM" "67236695521" "545" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "20051031-20051101"
#>  ..  ..$ : chr [1:4] "CL1" "3" "7" "1"
#>  ..  ..$ : chr [1:3] "REF" "LU" "CA"
#>  ..  ..$ : chr [1:2] "HI" "BK>8842"
#>  ..  ..$ : chr [1:2] "HI" "PR>8842"
#>  ..  ..$ : chr [1:3] "HI" "BN>E9750" "BN>E9860"
#>  ..  ..$ : chr [1:10] "NM1" "71" "1" "LOMBARDO" ...
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:6] "SV2" "0450" "HC>98765" "150" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20051031"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:6] "SV2" "0360" "HC>26591" "75" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20051031"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "3"
#>  ..  ..$ : chr [1:6] "SV2" "0312" "HC>86225" "100" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20051031"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "4"
#>  ..  ..$ : chr [1:6] "SV2" "0360" "HC>99283" "220" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20051031"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "43" "557766"
#>  .. @ GE : chr [1:2] "1" "000000001"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> $I223$institutional_claim_837I_223
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "1234567" "ZZ" "11111" "170508" ...
#>  .. @ GS : chr [1:8] "HC" "XXXXXXX" "XXXXX" "20170617" "1741" "101" "X" ...
#>  .. @ ST : chr [1:3] "837" "987654" "005010X223A2"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "0123" "19960918" "0932" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "JONES HOSPITAL" NA NA NA NA "46" "12345"
#>  .. @ P41: chr [1:4] "IC" "JANE DOE" "TE" "9005555555"
#>  .. @ N40: chr [1:9] "40" "2" "MEDICARE" NA NA NA NA "46" "00120"
#>  .. @ P40: chr NA
#>  @ Claims :List of 5
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:4] "PRV" "BI" "PXC" "203BA0200N"
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "JONES HOSPITAL" ...
#>  ..  ..$ : chr [1:2] "N3" "225 MAIN STREET BARKLEY BUILDING"
#>  ..  ..$ : chr [1:4] "N4" "CENTERVILLE" "PA" "17111"
#>  ..  ..$ : chr [1:3] "REF" "EI" "567891234"
#>  ..  ..$ : chr [1:5] "PER" "IC" "CONNIE" "TE" ...
#>  .. $ :List of 8
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" NA ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "DOE" ...
#>  ..  ..$ : chr [1:2] "N3" "125 CITY AVENUE"
#>  ..  ..$ : chr [1:4] "N4" "CENTERVILLE" "PA" "17111"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19261111" "M"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "MEDICARE B" ...
#>  ..  ..$ : chr [1:3] "REF" "G2" "330127"
#>  .. $ :List of 16
#>  ..  ..$ : chr [1:8] "CLM" "756048Q" "89.93" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "19960911"
#>  ..  ..$ : chr [1:4] "CL1" "3" NA "01"
#>  ..  ..$ : chr [1:2] "HI" "BK:3669"
#>  ..  ..$ : chr [1:3] "HI" "BF:4019" "BF:79431"
#>  ..  ..$ : chr [1:5] "HI" "BH:A1:D8:19261111" "BH:A2:D8:19911101" "BH:B1:D8:19261111" ...
#>  ..  ..$ : chr [1:2] "HI" "BE:A2:::15.31"
#>  ..  ..$ : chr [1:2] "HI" "BG:09"
#>  ..  ..$ : chr [1:6] "NM1" "71" "1" "JONES" ...
#>  ..  ..$ : chr [1:3] "REF" "1G" "B99937"
#>  ..  ..$ : chr [1:10] "SBR" "S" "01" "351630" ...
#>  ..  ..$ : chr [1:7] "OI" NA NA "Y" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "DOE" ...
#>  ..  ..$ : chr [1:2] "N3" "125 CITY AVENUE"
#>  ..  ..$ : chr [1:4] "N4" "CENTERVILLE" "PA" "17111"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "STATE TEACHERS" ...
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:6] "SV2" "0305" "HC:85025" "13.39" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "19960911"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:6] "SV2" "0730" "HC:93005" "76.54" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "19960911"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "43" "987654"
#>  .. @ GE : chr [1:2] "1" "101"
#>  .. @ IEA: chr [1:2] "1" "000000101"
#> 
#> $I223$sample_837_1
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "589155000448185" "ZZ" ...
#>  .. @ GS : chr [1:8] "HC" "589155000448185" "RegenceBluePoin" "20241205" ...
#>  .. @ ST : chr [1:3] "837" "0105" "005010X223A2"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "241205204217" "20241205" "2042" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "NATIONAL BIRTH CENTERS INC" NA NA NA NA "XX" ...
#>  .. @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  .. @ N40: chr [1:9] "40" "2" ...
#>  .. @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ Claims :List of 7
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "NATIONAL BIRTH CENTERS INC" ...
#>  ..  ..$ : chr [1:2] "N3" "1141 N LOOP 1604 E # 105436"
#>  ..  ..$ : chr [1:4] "N4" "SAN ANTONIO" "TX" "78232"
#>  ..  ..$ : chr [1:3] "REF" "EI" "46-4072679"
#>  ..  ..$ : chr [1:5] "PER" "IC" "TEST CONTACT" "TE" ...
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" "068094280" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "TESTLAST01" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>  .. $ :List of 11
#>  ..  ..$ : chr [1:10] "CLM" "4742333269" "297" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "20240422-20240430"
#>  ..  ..$ : chr [1:4] "DTP" "435" "D8" "20240809"
#>  ..  ..$ : chr [1:4] "DTP" "096" "TM" "2337"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S00459S"
#>  ..  ..$ : chr [1:2] "HI" "ABK:T426X6A"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S35496D"
#>  ..  ..$ : chr [1:2] "HI" "ABK:O368913"
#>  ..  ..$ : chr [1:2] "HI" "ABK:T368X6A"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S36118D"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S46229A"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:11] "SV1" "HC:33222" "62" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:11] "SV1" "HC:27005" "80" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "3"
#>  ..  ..$ : chr [1:11] "SV1" "HC:65860" "65" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "4"
#>  ..  ..$ : chr [1:11] "SV1" "HC:75891" "90" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "45" "0105"
#>  .. @ GE : chr [1:2] "1" "1"
#>  .. @ IEA: chr [1:2] "1" "566609694"
#> 
#> $I223$sample_837_10
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "765613337801994" "ZZ" ...
#>  .. @ GS : chr [1:8] "HC" "765613337801994" "OptimaFourSight" "20241205" ...
#>  .. @ ST : chr [1:3] "837" "5856" "005010X223A2"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "241205204222" "20241205" "2042" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "HSA PORT ARTHUR, LLC" NA NA NA NA "XX" ...
#>  .. @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  .. @ N40: chr [1:9] "40" "2" "OptimaFourSight" NA NA NA NA "XX" ...
#>  .. @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ Claims :List of 6
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "HSA PORT ARTHUR, LLC" ...
#>  ..  ..$ : chr [1:2] "N3" "505 N BRAND BLVD STE 1200"
#>  ..  ..$ : chr [1:4] "N4" "GLENDALE" "CA" "91203"
#>  ..  ..$ : chr [1:3] "REF" "EI" "71-3391736"
#>  ..  ..$ : chr [1:5] "PER" "IC" "TEST CONTACT" "TE" ...
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" "731323546" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "TESTLAST01" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>  .. $ :List of 8
#>  ..  ..$ : chr [1:10] "CLM" "4742333269" "128" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "20240422-20240430"
#>  ..  ..$ : chr [1:4] "DTP" "435" "D8" "20240809"
#>  ..  ..$ : chr [1:4] "DTP" "096" "TM" "2337"
#>  ..  ..$ : chr [1:2] "HI" "ABK:W214XXA"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S31813D"
#>  ..  ..$ : chr [1:2] "HI" "ABK:V0492XD"
#>  ..  ..$ : chr [1:2] "HI" "ABK:T498X6A"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:11] "SV1" "HC:37180" "93" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:11] "SV1" "HC:24000" "4" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "3"
#>  ..  ..$ : chr [1:11] "SV1" "HC:16035" "31" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "38" "5856"
#>  .. @ GE : chr [1:2] "1" "1"
#>  .. @ IEA: chr [1:2] "1" "351175143"
#> 
#> $I223$sample_837_2
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "961285082616691" "ZZ" ...
#>  .. @ GS : chr [1:8] "HC" "961285082616691" "AntidoteGoldSaf" "20241205" ...
#>  .. @ ST : chr [1:3] "837" "1462077" "005010X223A2"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "241205204218" "20241205" "2042" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "COMMUNITY BIRTH GROUP" NA NA NA NA "XX" ...
#>  .. @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  .. @ N40: chr [1:9] "40" "2" "AntidoteGoldSafeGuard0TopRx" NA NA NA NA ...
#>  .. @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ Claims :List of 6
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "COMMUNITY BIRTH GROUP" ...
#>  ..  ..$ : chr [1:2] "N3" "216 TOWER RD"
#>  ..  ..$ : chr [1:4] "N4" "SAN ANTONIO" "TX" "78223"
#>  ..  ..$ : chr [1:3] "REF" "EI" "98-2541777"
#>  ..  ..$ : chr [1:5] "PER" "IC" "TEST CONTACT" "TE" ...
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" "404250129" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "TESTLAST01" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:10] "CLM" "4742333269" "180" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "20240422-20240430"
#>  ..  ..$ : chr [1:4] "DTP" "435" "D8" "20240809"
#>  ..  ..$ : chr [1:4] "DTP" "096" "TM" "2337"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S43396S"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S52263J"
#>  ..  ..$ : chr [1:2] "HI" "ABK:V0009XD"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:11] "SV1" "HC:77522" "27" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:11] "SV1" "HC:86304" "3" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "3"
#>  ..  ..$ : chr [1:11] "SV1" "HC:43848" "150" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "37" "1462077"
#>  .. @ GE : chr [1:2] "1" "1"
#>  .. @ IEA: chr [1:2] "1" "030077084"
#> 
#> $I223$sample_837_3
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "657631015478465" "ZZ" ...
#>  .. @ GS : chr [1:8] "HC" "657631015478465" "MOLINAHEALTHCAR" "20241205" ...
#>  .. @ ST : chr [1:3] "837" "93687" "005010X223A2"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "241205204218" "20241205" "2042" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "MARYVIEW HOSPITAL LLC" NA NA NA NA "XX" ...
#>  .. @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  .. @ N40: chr [1:9] "40" "2" "MOLINAHEALTHCARE" NA NA NA NA "XX" ...
#>  .. @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ Claims :List of 5
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "MARYVIEW HOSPITAL LLC" ...
#>  ..  ..$ : chr [1:2] "N3" "8580 MAGELLAN PKWY"
#>  ..  ..$ : chr [1:4] "N4" "RICHMOND" "VA" "23227"
#>  ..  ..$ : chr [1:3] "REF" "EI" "40-3601447"
#>  ..  ..$ : chr [1:5] "PER" "IC" "TEST CONTACT" "TE" ...
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" "520458393" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "TESTLAST01" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>  .. $ :List of 10
#>  ..  ..$ : chr [1:10] "CLM" "4742333269" "626" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "20240422-20240430"
#>  ..  ..$ : chr [1:4] "DTP" "435" "D8" "20240809"
#>  ..  ..$ : chr [1:4] "DTP" "096" "TM" "2337"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S25412A"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S55209S"
#>  ..  ..$ : chr [1:2] "HI" "ABK:H05033"
#>  ..  ..$ : chr [1:2] "HI" "ABK:M61529"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S12500S"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S62661G"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:11] "SV1" "HC:32662" "83" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:11] "SV1" "HC:42509" "543" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "36" "93687"
#>  .. @ GE : chr [1:2] "1" "1"
#>  .. @ IEA: chr [1:2] "1" "828442319"
#> 
#> $I223$sample_837_4
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "816055286149740" "ZZ" ...
#>  .. @ GS : chr [1:8] "HC" "816055286149740" "HighDeductibleH" "20241205" ...
#>  .. @ ST : chr [1:3] "837" "91529" "005010X223A2"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "241205204219" "20241205" "2042" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "HSA ST. JOSEPH, LLC" NA NA NA NA "XX" ...
#>  .. @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  .. @ N40: chr [1:9] "40" "2" "HighDeductibleHealthPlanHSA30" NA NA NA NA ...
#>  .. @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ Claims :List of 4
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "HSA ST. JOSEPH, LLC" ...
#>  ..  ..$ : chr [1:2] "N3" "505 N BRAND BLVD STE 1200"
#>  ..  ..$ : chr [1:4] "N4" "GLENDALE" "CA" "91203"
#>  ..  ..$ : chr [1:3] "REF" "EI" "38-4035437"
#>  ..  ..$ : chr [1:5] "PER" "IC" "TEST CONTACT" "TE" ...
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" "812162750" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "TESTLAST01" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>  .. $ :List of 12
#>  ..  ..$ : chr [1:10] "CLM" "4742333269" "836" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "20240422-20240430"
#>  ..  ..$ : chr [1:4] "DTP" "435" "D8" "20240809"
#>  ..  ..$ : chr [1:4] "DTP" "096" "TM" "2337"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S42453G"
#>  ..  ..$ : chr [1:2] "HI" "ABK:M25775"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S32421K"
#>  ..  ..$ : chr [1:2] "HI" "ABK:V275XXD"
#>  ..  ..$ : chr [1:2] "HI" "ABK:X130XXS"
#>  ..  ..$ : chr [1:2] "HI" "ABK:T1512XD"
#>  ..  ..$ : chr [1:2] "HI" "ABK:M70859"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S82454S"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:11] "SV1" "HC:64823" "836" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "34" "91529"
#>  .. @ GE : chr [1:2] "1" "1"
#>  .. @ IEA: chr [1:2] "1" "621402678"
#> 
#> $I223$sample_837_5
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "051153619573476" "ZZ" ...
#>  .. @ GS : chr [1:8] "HC" "051153619573476" "BlanketStudentA" "20241205" ...
#>  .. @ ST : chr [1:3] "837" "46086" "005010X223A2"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "241205204219" "20241205" "2042" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "NATIONAL BIRTH CENTERS INC" NA NA NA NA "XX" ...
#>  .. @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  .. @ N40: chr [1:9] "40" "2" ...
#>  .. @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ Claims :List of 7
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "NATIONAL BIRTH CENTERS INC" ...
#>  ..  ..$ : chr [1:2] "N3" "1141 N LOOP 1604 E # 105436"
#>  ..  ..$ : chr [1:4] "N4" "SAN ANTONIO" "TX" "78232"
#>  ..  ..$ : chr [1:3] "REF" "EI" "58-1127151"
#>  ..  ..$ : chr [1:5] "PER" "IC" "TEST CONTACT" "TE" ...
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" "518691181" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "TESTLAST01" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>  .. $ :List of 10
#>  ..  ..$ : chr [1:10] "CLM" "4742333269" "157" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "20240422-20240430"
#>  ..  ..$ : chr [1:4] "DTP" "435" "D8" "20240809"
#>  ..  ..$ : chr [1:4] "DTP" "096" "TM" "2337"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S89219K"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S50349S"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S81052D"
#>  ..  ..$ : chr [1:2] "HI" "ABK:D434"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S00451A"
#>  ..  ..$ : chr [1:2] "HI" "ABK:T81505D"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:11] "SV1" "HC:0029T" "97" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:11] "SV1" "HC:86490" "6" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "3"
#>  ..  ..$ : chr [1:11] "SV1" "HC:57545" "21" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "4"
#>  ..  ..$ : chr [1:11] "SV1" "HC:62258" "33" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "44" "46086"
#>  .. @ GE : chr [1:2] "1" "1"
#>  .. @ IEA: chr [1:2] "1" "518159636"
#> 
#> $I223$sample_837_6
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "336342583485277" "ZZ" ...
#>  .. @ GS : chr [1:8] "HC" "336342583485277" "EHB2015IPLAELIC" "20241205" ...
#>  .. @ ST : chr [1:3] "837" "76134698" "005010X223A2"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "241205204220" "20241205" "2042" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "OKEECHOBEE HOSPITAL, INC." NA NA NA NA "XX" ...
#>  .. @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  .. @ N40: chr [1:9] "40" "2" "EHB2015IPLAELIC" NA NA NA NA "XX" ...
#>  .. @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ Claims :List of 8
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "OKEECHOBEE HOSPITAL, INC." ...
#>  ..  ..$ : chr [1:2] "N3" "PO BOX 1307"
#>  ..  ..$ : chr [1:4] "N4" "OKEECHOBEE" "FL" "34973"
#>  ..  ..$ : chr [1:3] "REF" "EI" "47-2705172"
#>  ..  ..$ : chr [1:5] "PER" "IC" "TEST CONTACT" "TE" ...
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" "768417323" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "TESTLAST01" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>  .. $ :List of 10
#>  ..  ..$ : chr [1:10] "CLM" "4742333269" "766" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "20240422-20240430"
#>  ..  ..$ : chr [1:4] "DTP" "435" "D8" "20240809"
#>  ..  ..$ : chr [1:4] "DTP" "096" "TM" "2337"
#>  ..  ..$ : chr [1:2] "HI" "ABK:F551"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S43201D"
#>  ..  ..$ : chr [1:2] "HI" "ABK:T6194XA"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S92505K"
#>  ..  ..$ : chr [1:2] "HI" "ABK:T280XXS"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S71011D"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:11] "SV1" "HC:27606" "61" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:11] "SV1" "HC:44960" "371" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "3"
#>  ..  ..$ : chr [1:11] "SV1" "HC:90680" "34" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "4"
#>  ..  ..$ : chr [1:11] "SV1" "HC:92551" "267" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "5"
#>  ..  ..$ : chr [1:11] "SV1" "HC:31237" "33" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "48" "76134698"
#>  .. @ GE : chr [1:2] "1" "1"
#>  .. @ IEA: chr [1:2] "1" "115983591"
#> 
#> $I223$sample_837_7
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "879679616399691" "ZZ" ...
#>  .. @ GS : chr [1:8] "HC" "879679616399691" "HSA2000_10A1189" "20241205" ...
#>  .. @ ST : chr [1:3] "837" "7869171" "005010X223A2"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "241205204220" "20241205" "2042" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "ELMHURST MEMORIAL HOSPITAL" NA NA NA NA "XX" ...
#>  .. @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  .. @ N40: chr [1:9] "40" "2" "HSA2000_10A1" NA NA NA NA "XX" "39424OR071"
#>  .. @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ Claims :List of 7
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "ELMHURST MEMORIAL HOSPITAL" ...
#>  ..  ..$ : chr [1:2] "N3" "155 E BRUSH HILL RD"
#>  ..  ..$ : chr [1:4] "N4" "ELMHURST" "IL" "60126"
#>  ..  ..$ : chr [1:3] "REF" "EI" "78-1631771"
#>  ..  ..$ : chr [1:5] "PER" "IC" "TEST CONTACT" "TE" ...
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" "270183084" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "TESTLAST01" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>  .. $ :List of 9
#>  ..  ..$ : chr [1:10] "CLM" "4742333269" "349" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "20240422-20240430"
#>  ..  ..$ : chr [1:4] "DTP" "435" "D8" "20240809"
#>  ..  ..$ : chr [1:4] "DTP" "096" "TM" "2337"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S00249D"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S99131K"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S32425K"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S52501J"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S72114P"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:11] "SV1" "HC:38724" "36" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:11] "SV1" "HC:86701" "213" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "3"
#>  ..  ..$ : chr [1:11] "SV1" "HC:92325" "70" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "4"
#>  ..  ..$ : chr [1:11] "SV1" "HC:89060" "30" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "43" "7869171"
#>  .. @ GE : chr [1:2] "1" "1"
#>  .. @ IEA: chr [1:2] "1" "871936722"
#> 
#> $I223$sample_837_8
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "719189088449132" "ZZ" ...
#>  .. @ GS : chr [1:8] "HC" "719189088449132" "SimplyBluePPOwi" "20241205" ...
#>  .. @ ST : chr [1:3] "837" "57975326" "005010X223A2"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "241205204221" "20241205" "2042" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "GUTHRIE CORTLAND MEDICAL CENTER" NA NA NA NA ...
#>  .. @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  .. @ N40: chr [1:9] "40" "2" "SimplyBluePPOwithabortioncoverage" NA NA NA ...
#>  .. @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ Claims :List of 7
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "GUTHRIE CORTLAND MEDICAL CENTER" ...
#>  ..  ..$ : chr [1:2] "N3" "PO BOX 2060"
#>  ..  ..$ : chr [1:4] "N4" "CORTLAND" "NY" "13045"
#>  ..  ..$ : chr [1:3] "REF" "EI" "92-6992381"
#>  ..  ..$ : chr [1:5] "PER" "IC" "TEST CONTACT" "TE" ...
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" "406068712" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "TESTLAST01" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:10] "CLM" "4742333269" "434" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "20240422-20240430"
#>  ..  ..$ : chr [1:4] "DTP" "435" "D8" "20240809"
#>  ..  ..$ : chr [1:4] "DTP" "096" "TM" "2337"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S62511K"
#>  ..  ..$ : chr [1:2] "HI" "ABK:T578X3S"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S72342G"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:11] "SV1" "HC:43280" "41" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:11] "SV1" "HC:46250" "35" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "3"
#>  ..  ..$ : chr [1:11] "SV1" "HC:33305" "197" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "4"
#>  ..  ..$ : chr [1:11] "SV1" "HC:90947" "161" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "41" "57975326"
#>  .. @ GE : chr [1:2] "1" "1"
#>  .. @ IEA: chr [1:2] "1" "464860572"
#> 
#> $I223$sample_837_9
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "913673479406110" "ZZ" ...
#>  .. @ GS : chr [1:8] "HC" "913673479406110" "HMOOffExchangeR" "20241205" ...
#>  .. @ ST : chr [1:3] "837" "4763033" "005010X223A2"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "241205204221" "20241205" "2042" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "HCA HEALTH SERVICES OF TENNESSEE, INC." NA ...
#>  .. @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  .. @ N40: chr [1:9] "40" "2" "HMOOffExchangeRegion7" NA NA NA NA "XX" ...
#>  .. @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ Claims :List of 7
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "HCA HEALTH SERVICES OF TENNESSEE, INC." ...
#>  ..  ..$ : chr [1:2] "N3" "313 N MAIN ST"
#>  ..  ..$ : chr [1:4] "N4" "ASHLAND CITY" "TN" "37015"
#>  ..  ..$ : chr [1:3] "REF" "EI" "99-5971744"
#>  ..  ..$ : chr [1:5] "PER" "IC" "TEST CONTACT" "TE" ...
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" "556791994" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "TESTLAST01" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>  .. $ :List of 12
#>  ..  ..$ : chr [1:10] "CLM" "4742333269" "839" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "20240422-20240430"
#>  ..  ..$ : chr [1:4] "DTP" "435" "D8" "20240809"
#>  ..  ..$ : chr [1:4] "DTP" "096" "TM" "2337"
#>  ..  ..$ : chr [1:2] "HI" "ABK:V9421XS"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S35292S"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S52272S"
#>  ..  ..$ : chr [1:2] "HI" "ABK:H68022"
#>  ..  ..$ : chr [1:2] "HI" "ABK:T4144XD"
#>  ..  ..$ : chr [1:2] "HI" "ABK:H1030"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S82832J"
#>  ..  ..$ : chr [1:2] "HI" "ABK:B340"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:11] "SV1" "HC:35650" "161" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:11] "SV1" "HC:73200" "383" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "3"
#>  ..  ..$ : chr [1:11] "SV1" "HC:28262" "194" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "4"
#>  ..  ..$ : chr [1:11] "SV1" "HC:84480" "101" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "46" "4763033"
#>  .. @ GE : chr [1:2] "1" "1"
#>  .. @ IEA: chr [1:2] "1" "253034665"
#> 
#> 
#> $P222
#> $P222$`005010_837P`
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" "AUTHORIZAT" "00" "SECURITY I" "ZZ" ...
#>  .. @ GS : chr [1:8] "HC" "00000006" "00000001" "20110705" "113253" ...
#>  .. @ ST : chr [1:3] "837" "0021" "005010X222"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "244579" "20061015" "1023" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "PREMIER BILLING SERVICE" NA NA NA NA "46" ...
#>  .. @ P41: chr [1:6] "IC" "JERRY" "TE" "3055552222" "EX" "231"
#>  .. @ N40: chr [1:9] "40" "2" "KEY INSURANCE COMPANY" NA NA NA NA "46" ...
#>  .. @ P40: chr NA
#>  @ Claims :List of 8
#>  .. $ :List of 9
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:4] "PRV" "BI" "PXC" "203BF0100Y"
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "BEN KILDARE SERVICE" ...
#>  ..  ..$ : chr [1:2] "N3" "234 SEAWAY ST"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33111"
#>  ..  ..$ : chr [1:3] "REF" "EI" "587654321"
#>  ..  ..$ : chr [1:3] "NM1" "87" "2"
#>  ..  ..$ : chr [1:2] "N3" "2345 OCEAN BLVD"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33111"
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" NA "2222-SJ" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "SMITH" ...
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19430501" "F"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "KEY INSURANCE COMPANY" ...
#>  ..  ..$ : chr [1:3] "REF" "G2" "KA6663"
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "3" "2" "23" ...
#>  ..  ..$ : chr [1:2] "PAT" "19"
#>  ..  ..$ : chr [1:5] "NM1" "QC" "1" "SMITH" ...
#>  ..  ..$ : chr [1:2] "N3" "236 N MAIN ST"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33413"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19730501" "M"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:10] "CLM" "26463774" "100" NA ...
#>  ..  ..$ : chr [1:3] "REF" "D9" "17312345600006351"
#>  ..  ..$ : chr [1:3] "HI" "BK:0340" "BF:V7389"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC:99213" "40" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20061003"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:8] "SV1" "HC:87070" "15" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20061003"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "3"
#>  ..  ..$ : chr [1:8] "SV1" "HC:99214" "35" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20061010"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "4"
#>  ..  ..$ : chr [1:8] "SV1" "HC:86663" "10" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20061010"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "42" "0021"
#>  .. @ GE : chr [1:2] "1" "110705001"
#>  .. @ IEA: chr [1:2] "1" "110705001"
#> 
#> $P222$`837P_EX10a_drug_adm_office`
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "HC" "SENDERGS" "RECEIVERGS" "20231106" "141104" ...
#>  .. @ ST : chr [1:3] "837" "0711" "005010X222A1"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "0013" "20040801" "1200" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "Associates in Medicine" NA NA NA NA "46" ...
#>  .. @ P41: chr [1:4] "IC" "Bud Holly" "TE" "8017268899"
#>  .. @ N40: chr [1:9] "40" "2" "XYZ Receiver" NA NA NA NA "46" "369852758"
#>  .. @ P40: chr NA
#>  @ Claims :List of 5
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "Associates in Medicine" ...
#>  ..  ..$ : chr [1:2] "N3" "1313 Las Vegas Boulevard"
#>  ..  ..$ : chr [1:4] "N4" "Las Vegas" "NV" "89109"
#>  ..  ..$ : chr [1:3] "REF" "EI" "587654321"
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" "GRP01020102" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "Vaughn" ...
#>  ..  ..$ : chr [1:2] "N3" "236 Diamond ST"
#>  ..  ..$ : chr [1:4] "N4" "Las Vegas" "NV" "89109"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19430501" "M"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "R&R Health Plan" ...
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:10] "CLM" "CLMNO12345" "103.37" NA ...
#>  ..  ..$ : chr [1:2] "HI" "BK>03591"
#>  ..  ..$ : chr [1:10] "NM1" "82" "1" "Hendrix" ...
#>  ..  ..$ : chr [1:4] "PRV" "PE" "PXC" "208D00000X"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC>90782" "50" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20040711"
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:8] "SV1" "HC>J1550" "53.37" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20040711"
#>  ..  ..$ : chr [1:3] "AMT" "T" "3.37"
#>  ..  ..$ : chr [1:4] "LIN" NA "N4" "00026063512"
#>  ..  ..$ : chr [1:6] "CTP" NA NA NA ...
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "31" "0711"
#>  .. @ GE : chr [1:2] "1" "000000001"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> $P222$`837P_EX11_ppo_repriced_claim`
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "HC" "SENDERGS" "RECEIVERGS" "20231106" "141535" ...
#>  .. @ ST : chr [1:3] "837" "1002" "005010X222A1"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "1002" "20050620" "09460000" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "REGIONAL PPO NETWORK" NA NA NA NA "46" ...
#>  .. @ P41: chr [1:4] "IC" "SUBMITTER CONTACT INFO" "TE" "8001231234"
#>  .. @ N40: chr [1:9] "40" "2" "EXTRA HEALTHY INSURANCE" NA NA NA NA "46" ...
#>  .. @ P40: chr NA
#>  @ Claims :List of 5
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "HAPPY DOCTORS GROUP PRACTICE" ...
#>  ..  ..$ : chr [1:2] "N3" "P O BOX 123"
#>  ..  ..$ : chr [1:4] "N4" "FORT WAYNE" "IN" "462540000"
#>  ..  ..$ : chr [1:3] "REF" "EI" "555512345"
#>  ..  ..$ : chr [1:5] "PER" "IC" "SUE BILLINGSWORTH" "TE" ...
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" "123XYZ" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "RING" ...
#>  ..  ..$ : chr [1:2] "N3" "123 EXAMPLE DRIVE"
#>  ..  ..$ : chr [1:4] "N4" "INDIANAPOLIS" "IN" "462290000"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19401229" "F"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "EXTRA HEALTHY INSURANCE" ...
#>  .. $ :List of 10
#>  ..  ..$ : chr [1:11] "CLM" "ABC123-RI" "28.75" NA ...
#>  ..  ..$ : chr [1:3] "REF" "9A" "0902352342"
#>  ..  ..$ : chr [1:3] "REF" "D9" "061505501749388"
#>  ..  ..$ : chr [1:3] "HI" "BK>496" "BF>25000"
#>  ..  ..$ : chr [1:5] "HCP" "03" "26.75" "2" ...
#>  ..  ..$ : chr [1:10] "NM1" "DN" "1" "DOE" ...
#>  ..  ..$ : chr [1:10] "NM1" "82" "1" "ANTHONY" ...
#>  ..  ..$ : chr [1:4] "NM1" "77" "2" "HAPPY DOCTORS GROUP"
#>  ..  ..$ : chr [1:2] "N3" "123 FEEL GOOD ROAD"
#>  ..  ..$ : chr [1:4] "N4" "WASHINGTON" "IN" "475010000"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC>E0570>RR" "25" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20050514"
#>  ..  ..$ : chr [1:5] "HCP" "03" "23.75" "1.25" ...
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:8] "SV1" "HC>A7003>NU" "3.75" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20050514"
#>  ..  ..$ : chr [1:5] "HCP" "03" "3" ".75" ...
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "37" "1002"
#>  .. @ GE : chr [1:2] "1" "000000001"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> $P222$`837P_EX12_oon_repriced_claim`
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "HC" "SENDERGS" "RECEIVERGS" "20231106" "141631" ...
#>  .. @ ST : chr [1:3] "837" "1024" "005010X222A1"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "1024" "20050711" "1335" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "REGIONAL PPO NETWORK" NA NA NA NA "46" ...
#>  .. @ P41: chr [1:4] "IC" "SUBMITTER CONTACT INFO" "TE" "8001231234"
#>  .. @ N40: chr [1:9] "40" "2" "CONSERVATIVE INSURANCE" NA NA NA NA "46" ...
#>  .. @ P40: chr NA
#>  @ Claims :List of 5
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "EMERGENCY PHYSICIANS GROUP" ...
#>  ..  ..$ : chr [1:2] "N3" "7423 SUPER STREET"
#>  ..  ..$ : chr [1:4] "N4" "BILLINGS" "MO" "919910000"
#>  ..  ..$ : chr [1:3] "REF" "EI" "111002222"
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" NA "232AA" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "SMITH" ...
#>  ..  ..$ : chr [1:2] "N3" "5698 SOUTH STREET"
#>  ..  ..$ : chr [1:4] "N4" "BILLINGS" "MO" "919910000"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19561015" "M"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "CONSERVATIVE INSURANCE" ...
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "3" "2" "23" ...
#>  ..  ..$ : chr [1:2] "PAT" "19"
#>  ..  ..$ : chr [1:6] "NM1" "QC" "1" "SMITH" ...
#>  ..  ..$ : chr [1:2] "N3" "5698 SOUTH STREET"
#>  ..  ..$ : chr [1:4] "N4" "BILLINGS" "MO" "919910000"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19960807" "M"
#>  .. $ :List of 12
#>  ..  ..$ : chr [1:11] "CLM" "TS234H3" "252.71" NA ...
#>  ..  ..$ : chr [1:3] "REF" "9A" "0902345406"
#>  ..  ..$ : chr [1:3] "REF" "D9" "687534234346"
#>  ..  ..$ : chr [1:2] "HI" "BK>9951"
#>  ..  ..$ : chr [1:14] "HCP" "00" "0" NA ...
#>  ..  ..$ : chr [1:10] "NM1" "82" "1" "BLUE" ...
#>  ..  ..$ : chr [1:10] "SBR" "S" "18" "56567" ...
#>  ..  ..$ : chr [1:7] "OI" NA NA "Y" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "SMITH" ...
#>  ..  ..$ : chr [1:2] "N3" "5698 SOUTH STREET"
#>  ..  ..$ : chr [1:4] "N4" "BILLINGS" "MO" "919910000"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "SECONDARY INSURANCE COMPANY" ...
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC>99284" "252.71" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20050506"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "39" "1024"
#>  .. @ GE : chr [1:2] "1" "000000001"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> $P222$`837P_EX1_commercial-insurance`
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "HC" "SENDERGS" "RECEIVERGS" "20231106" "140840" ...
#>  .. @ ST : chr [1:3] "837" "0021" "005010X222A1"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "244579" "20061015" "1023" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "PREMIER BILLING SERVICE" NA NA NA NA "46" ...
#>  .. @ P41: chr [1:6] "IC" "JERRY" "TE" "3055552222" "EX" "231"
#>  .. @ N40: chr [1:9] "40" "2" "KEY INSURANCE COMPANY" NA NA NA NA "46" ...
#>  .. @ P40: chr NA
#>  @ Claims :List of 8
#>  .. $ :List of 9
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:4] "PRV" "BI" "PXC" "203BF0100Y"
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "BEN KILDARE SERVICE" ...
#>  ..  ..$ : chr [1:2] "N3" "234 SEAWAY ST"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33111"
#>  ..  ..$ : chr [1:3] "REF" "EI" "587654321"
#>  ..  ..$ : chr [1:3] "NM1" "87" "2"
#>  ..  ..$ : chr [1:2] "N3" "2345 OCEAN BLVD"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33111"
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" NA "2222-SJ" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "SMITH" ...
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19430501" "F"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "KEY INSURANCE COMPANY" ...
#>  ..  ..$ : chr [1:3] "REF" "G2" "KA6663"
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "3" "2" "23" ...
#>  ..  ..$ : chr [1:2] "PAT" "19"
#>  ..  ..$ : chr [1:5] "NM1" "QC" "1" "SMITH" ...
#>  ..  ..$ : chr [1:2] "N3" "236 N MAIN ST"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33413"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19730501" "M"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:10] "CLM" "26463774" "100" NA ...
#>  ..  ..$ : chr [1:3] "REF" "D9" "17312345600006351"
#>  ..  ..$ : chr [1:3] "HI" "BK>0340" "BF>V7389"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC>99213" "40" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20061003"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:8] "SV1" "HC>87070" "15" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20061003"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "3"
#>  ..  ..$ : chr [1:8] "SV1" "HC>99214" "35" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20061010"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "4"
#>  ..  ..$ : chr [1:8] "SV1" "HC>86663" "10" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20061010"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "42" "0021"
#>  .. @ GE : chr [1:2] "1" "000000001"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> $P222$`837P_EX2_encounter`
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "HC" "SENDERGS" "RECEIVERGS" "20231106" "141815" ...
#>  .. @ ST : chr [1:3] "837" "0021" "005010X222A1"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "0123" "20061015" "1023" "RP"
#>  .. @ N41: chr [1:9] "41" "2" "PREMIER BILLING SERVICE" NA NA NA NA "46" ...
#>  .. @ P41: chr [1:6] "IC" "JERRY" "TE" "3055552222" "EX" "231"
#>  .. @ N40: chr [1:9] "40" "2" "AHLIC" NA NA NA NA "46" "66783JJT"
#>  .. @ P40: chr NA
#>  @ Claims :List of 7
#>  .. $ :List of 9
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:4] "PRV" "BI" "PXC" "203BF0100Y"
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "BEN KILDARE SERVICE" ...
#>  ..  ..$ : chr [1:2] "N3" "234 SEAWAY ST"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33111"
#>  ..  ..$ : chr [1:3] "REF" "EI" "587654321"
#>  ..  ..$ : chr [1:3] "NM1" "87" "2"
#>  ..  ..$ : chr [1:2] "N3" "2345 OCEAN BLVD"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33111"
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" "12312-A" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "SMITH" ...
#>  ..  ..$ : chr [1:2] "N3" "236 N MAIN ST"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33413"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19430501" "M"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "ALLIANCE HEALTH AND LIFE INSURANCE" ...
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:10] "CLM" "26462967" "100" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "431" "D8" "19981003"
#>  ..  ..$ : chr [1:3] "REF" "D9" "17312345600006351"
#>  ..  ..$ : chr [1:3] "HI" "BK>0340" "BF>V7389"
#>  ..  ..$ : chr [1:10] "NM1" "77" "2" "KILDARE ASSOCIATES" ...
#>  ..  ..$ : chr [1:2] "N3" "2345 OCEAN BLVD"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33111"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC>99213" "40" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20061003"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:8] "SV1" "HC>87072" "15" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20061003"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "3"
#>  ..  ..$ : chr [1:8] "SV1" "HC>99214" "35" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20061010"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "4"
#>  ..  ..$ : chr [1:8] "SV1" "HC>86663" "10" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20061010"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "41" "0021"
#>  .. @ GE : chr [1:2] "1" "000000001"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> $P222$`837P_EX3a_billing_provider_payer_a`
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "HC" "SENDERGS" "RECEIVERGS" "20231106" "142058" ...
#>  .. @ ST : chr [1:3] "837" "0021" "005010X222A1"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "0123" "20051015" "1023" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "PREMIER BILLING SERVICE" NA NA NA NA "46" ...
#>  .. @ P41: chr [1:4] "IC" "JERRY" "TE" "3055552222"
#>  .. @ N40: chr [1:9] "40" "2" "XYZ REPRICER" NA NA NA NA "46" "66783JJT"
#>  .. @ P40: chr NA
#>  @ Claims :List of 7
#>  .. $ :List of 9
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "1" "KILDARE" ...
#>  ..  ..$ : chr [1:2] "N3" "234 SEAWAY ST"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33111"
#>  ..  ..$ : chr [1:3] "REF" "EI" "123456789"
#>  ..  ..$ : chr [1:5] "PER" "IC" "CONNIE" "TE" ...
#>  ..  ..$ : chr [1:3] "NM1" "87" "2"
#>  ..  ..$ : chr [1:2] "N3" "2345 OCEAN BLVD"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33111"
#>  .. $ :List of 8
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" NA NA ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "SMITH" ...
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19430501" "F"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "KEY INSURANCE COMPANY" ...
#>  ..  ..$ : chr [1:2] "N3" "3333 OCEAN ST"
#>  ..  ..$ : chr [1:4] "N4" "SOUTH MIAMI" "FL" "33000"
#>  ..  ..$ : chr [1:3] "REF" "G2" "PBS3334"
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "3" "2" "23" ...
#>  ..  ..$ : chr [1:2] "PAT" "19"
#>  ..  ..$ : chr [1:5] "NM1" "QC" "1" "SMITH" ...
#>  ..  ..$ : chr [1:2] "N3" "236 N MAIN ST"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33413"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19730501" "M"
#>  .. $ :List of 14
#>  ..  ..$ : chr [1:11] "CLM" "26407789" "79.04" NA ...
#>  ..  ..$ : chr [1:5] "HI" "BK>4779" "BF>2724" "BF>2780" ...
#>  ..  ..$ : chr [1:10] "NM1" "82" "1" "KILDARE" ...
#>  ..  ..$ : chr [1:4] "PRV" "PE" "PXC" "204C00000X"
#>  ..  ..$ : chr [1:3] "REF" "G2" "KA6663"
#>  ..  ..$ : chr [1:10] "NM1" "77" "2" "KILDARE ASSOCIATES" ...
#>  ..  ..$ : chr [1:2] "N3" "2345 OCEAN BLVD"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33111"
#>  ..  ..$ : chr [1:10] "SBR" "S" "01" NA ...
#>  ..  ..$ : chr [1:7] "OI" NA NA "Y" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "SMITH" ...
#>  ..  ..$ : chr [1:2] "N3" "236 N MAIN ST"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33111"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "KEY INSURANCE COMPANY" ...
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC>99213" "43" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20051003"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:8] "SV1" "HC>90782" "15" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20051003"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "3"
#>  ..  ..$ : chr [1:8] "SV1" "HC>J3301" "21.04" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20051003"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "52" "0021"
#>  .. @ GE : chr [1:2] "1" "000000001"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> $P222$`837P_EX4_medicare_secondary_cob`
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "HC" "SENDERGS" "RECEIVERGS" "20231106" "142142" ...
#>  .. @ ST : chr [1:3] "837" "0002" "005010X222A1"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "000001142" "20050214" "115101" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "SPECIALISTS" NA NA NA NA "46" "1111111"
#>  .. @ P41: chr [1:4] "IC" "SUE" "TE" "8005558888"
#>  .. @ N40: chr [1:9] "40" "2" "MEDICARE PENNSYLVANIA" NA NA NA NA "46" ...
#>  .. @ P40: chr NA
#>  @ Claims :List of 4
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "SPECIALISTS" ...
#>  ..  ..$ : chr [1:2] "N3" "5 MAP COURT"
#>  ..  ..$ : chr [1:4] "N4" "MAYNE" "PA" "17111"
#>  ..  ..$ : chr [1:3] "REF" "EI" "890123456"
#>  ..  ..$ : chr [1:3] "REF" "1G" "110101"
#>  .. $ :List of 9
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "S" "18" "MEDICARE" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "MEDYUM" ...
#>  ..  ..$ : chr [1:2] "N3" "1010 THOUSAND OAK LANE"
#>  ..  ..$ : chr [1:4] "N4" "MAYN" "PA" "17089"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19560110" "M"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "MEDICARE PENNSYLVANIA" ...
#>  ..  ..$ : chr [1:2] "N3" "5232 MAYNE AVENUE"
#>  ..  ..$ : chr [1:4] "N4" "LYGHT" "PA" "17009"
#>  .. $ :List of 15
#>  ..  ..$ : chr [1:11] "CLM" "101KEN6055" "120" NA ...
#>  ..  ..$ : chr [1:3] "HI" "BK>71516" "BF>71906"
#>  ..  ..$ : chr [1:6] "NM1" "DN" "1" "BRYHT" ...
#>  ..  ..$ : chr [1:3] "REF" "1G" "B01010"
#>  ..  ..$ : chr [1:10] "NM1" "82" "1" "HENZES" ...
#>  ..  ..$ : chr [1:4] "PRV" "PE" "PXC" "207X00000X"
#>  ..  ..$ : chr [1:3] "REF" "G2" "110102CCC"
#>  ..  ..$ : chr [1:10] "SBR" "P" "01" NA ...
#>  ..  ..$ : chr [1:3] "AMT" "D" "80"
#>  ..  ..$ : chr [1:3] "AMT" "A8" "15"
#>  ..  ..$ : chr [1:7] "OI" NA NA "Y" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "MEDYUM" ...
#>  ..  ..$ : chr [1:2] "N3" "PO BOX 45"
#>  ..  ..$ : chr [1:4] "N4" "MAYN" "PA" "17089"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "COMMERCE" ...
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC>99203>25" "120" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20050119"
#>  ..  ..$ : chr [1:6] "SVD" "59999" "80" "HC>99203>25" ...
#>  ..  ..$ : chr [1:4] "CAS" "CO" "42" "25"
#>  ..  ..$ : chr [1:4] "CAS" "PR" "2" "15"
#>  ..  ..$ : chr [1:4] "DTP" "573" "D8" "20050128"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "43" "0002"
#>  .. @ GE : chr [1:2] "1" "000000001"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> $P222$`837P_EX5_ambulance`
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "HC" "SENDERGS" "RECEIVERGS" "20231106" "142212" ...
#>  .. @ ST : chr [1:3] "837" "000017712" "005010X222A1"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "000017712" "20050208" "1112" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "AAA AMBULANCE SERVICE" NA NA NA NA "46" ...
#>  .. @ P41: chr [1:4] "IC" "LISA SMITH" "TE" "3037752536"
#>  .. @ N40: chr [1:9] "40" "2" "MEDICARE B" NA NA NA NA "46" "123245"
#>  .. @ P40: chr NA
#>  @ Claims :List of 7
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:4] "PRV" "BI" "PXC" "3416L0300X"
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "AAA AMBULANCE SERVICE" ...
#>  ..  ..$ : chr [1:2] "N3" "12202 AIRPORT WAY"
#>  ..  ..$ : chr [1:4] "N4" "BROOMFIELD" "CO" "800210021"
#>  ..  ..$ : chr [1:3] "REF" "EI" "376985369"
#>  .. $ :List of 9
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" NA ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "JONES" ...
#>  ..  ..$ : chr [1:2] "N3" "1129 REINDEER ROAD"
#>  ..  ..$ : chr [1:4] "N4" "CARR" "CO" "80612"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19630729" "F"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "MEDICARE PART B" ...
#>  ..  ..$ : chr [1:2] "N3" "PO BOX 3543"
#>  ..  ..$ : chr [1:4] "N4" "BALTIMORE" "MD" "666013543"
#>  .. $ :List of 12
#>  ..  ..$ : chr [1:12] "CLM" "051068" "766.50" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "439" "D8" "20050208"
#>  ..  ..$ : chr [1:11] "CR1" "LB" "275" NA ...
#>  ..  ..$ : chr [1:6] "CRC" "07" "Y" "04" ...
#>  ..  ..$ : chr [1:6] "CRC" "07" "N" "05" ...
#>  ..  ..$ : chr [1:5] "HI" "BK>8628" "BF>E8888" "BF>9592" ...
#>  ..  ..$ : chr [1:3] "NM1" "PW" "2"
#>  ..  ..$ : chr [1:2] "N3" "1129 REINDEER ROAD"
#>  ..  ..$ : chr [1:4] "N4" "CARR" "CO" "80612"
#>  ..  ..$ : chr [1:3] "NM1" "45" "2"
#>  ..  ..$ : chr [1:2] "N3" "10005 BANNOCK ST"
#>  ..  ..$ : chr [1:4] "N4" "CHEYENNE" "WY" "82009"
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:10] "SV1" "HC>A0427>RH" "700" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20050208"
#>  ..  ..$ : chr [1:3] "QTY" "PT" "2"
#>  ..  ..$ : chr [1:3] "REF" "6R" "1001"
#>  ..  ..$ : chr [1:3] "NTE" "ADD" "CARDIAC EMERGENCY"
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:10] "SV1" "HC>A0425>RH" "8.20" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20050208"
#>  ..  ..$ : chr [1:3] "QTY" "PT" "2"
#>  ..  ..$ : chr [1:3] "REF" "6R" "1002"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "3"
#>  ..  ..$ : chr [1:10] "SV1" "HC>A0422>RH" "46" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20050208"
#>  ..  ..$ : chr [1:3] "REF" "6R" "1003"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "4"
#>  ..  ..$ : chr [1:10] "SV1" "HC>A0382>RH" "12.30" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20050208"
#>  ..  ..$ : chr [1:3] "REF" "6R" "1004"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "52" "000017712"
#>  .. @ GE : chr [1:2] "1" "000000001"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> $P222$`837P_EX6_chiropractic`
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "HC" "SENDERGS" "RECEIVERGS" "20231106" "142242" ...
#>  .. @ ST : chr [1:3] "837" "3701" "005010X222A1"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "007227" "20050215" "075420" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "DAVID GREEN" NA NA NA NA "46" "S01057"
#>  .. @ P41: chr [1:4] "IC" "KATHY SMITH" "TE" "4105558888"
#>  .. @ N40: chr [1:9] "40" "2" "MEDICARE PART B MARYLAND" NA NA NA NA "46" ...
#>  .. @ P40: chr NA
#>  @ Claims :List of 4
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "1" "GREENE" ...
#>  ..  ..$ : chr [1:2] "N3" "1264 OAKWOOD AVE"
#>  ..  ..$ : chr [1:4] "N4" "BALTIMORE" "MD" "21236"
#>  ..  ..$ : chr [1:3] "REF" "EI" "987654321"
#>  ..  ..$ : chr [1:5] "PER" "IC" "DR" "TE" ...
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" NA ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "WILLIAMSON" ...
#>  ..  ..$ : chr [1:2] "N3" "128 BROADCREEK"
#>  ..  ..$ : chr [1:4] "N4" "BALTIMORE" "MD" "21234"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19250110" "M"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "MEDICARE PART B MARYLAND" ...
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:10] "CLM" "125WILL" "145.5" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "454" "D8" "20050115"
#>  ..  ..$ : chr [1:4] "DTP" "453" "D8" "20050110"
#>  ..  ..$ : chr [1:4] "DTP" "455" "D8" "20050113"
#>  ..  ..$ : chr [1:11] "CR2" NA NA NA ...
#>  ..  ..$ : chr [1:2] "HI" "BK>7215"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC>98940" "145.5" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20050215"
#>  ..  ..$ : chr [1:3] "REF" "6R" "01"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "29" "3701"
#>  .. @ GE : chr [1:2] "1" "000000001"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> $P222$`837P_EX7_oxygen`
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "HC" "SENDERGS" "RECEIVERGS" "20231106" "142340" ...
#>  .. @ ST : chr [1:3] "837" "0001" "005010X222A1"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "16" "20050326" "1036" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "OXYGEN SUPPLY COMPANY" NA NA NA NA "46" ...
#>  .. @ P41: chr [1:6] "IC" "BONNIE" "TE" "8125551111" "EM" ...
#>  .. @ N40: chr [1:9] "40" "2" "DMERC CARRIER" NA NA NA NA "46" "99999"
#>  .. @ P40: chr NA
#>  @ Claims :List of 5
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "OXYGEN SUPPLY COMPANY" ...
#>  ..  ..$ : chr [1:2] "N3" "1800 EAST RIDGE DRIVE"
#>  ..  ..$ : chr [1:4] "N4" "RICHMOND" "IN" "46224"
#>  ..  ..$ : chr [1:3] "REF" "EI" "389999999"
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" NA ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "SMITH" ...
#>  ..  ..$ : chr [1:2] "N3" "121 SOUTH ST"
#>  ..  ..$ : chr [1:4] "N4" "RICHMOND" "IN" "46236"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19380105" "F"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "DMERC CARRIER" ...
#>  .. $ :List of 2
#>  ..  ..$ : chr [1:10] "CLM" "R03996273 #01" "520.24" NA ...
#>  ..  ..$ : chr [1:4] "HI" "BK>496" "BF>51881" "BF>2859"
#>  .. $ :List of 23
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC>E1390>RR" "461.1" "UN" ...
#>  ..  ..$ : chr [1:3] "PWK" "CT" "AD"
#>  ..  ..$ : chr [1:4] "CR3" "R" "MO" "99"
#>  ..  ..$ : chr [1:4] "DTP" "472" "RD8" "20050321-20050321"
#>  ..  ..$ : chr [1:4] "DTP" "607" "D8" "20050321"
#>  ..  ..$ : chr [1:4] "DTP" "463" "D8" "20040321"
#>  ..  ..$ : chr [1:4] "DTP" "461" "D8" "20050321"
#>  ..  ..$ : chr [1:10] "NM1" "DK" "1" "WILSON" ...
#>  ..  ..$ : chr [1:2] "N3" "1212 NORTH MERIDIAN"
#>  ..  ..$ : chr [1:4] "N4" "RICHMOND" "IN" "46223"
#>  ..  ..$ : chr [1:3] "REF" "1G" "X99999"
#>  ..  ..$ : chr [1:5] "PER" "IC" "LEE" "TE" ...
#>  ..  ..$ : chr [1:3] "LQ" "UT" "04.03"
#>  ..  ..$ : chr [1:4] "FRM" "1A" NA "056"
#>  ..  ..$ : chr [1:4] "FRM" "1C" NA "20050228"
#>  ..  ..$ : chr [1:4] "FRM" "2" NA "1"
#>  ..  ..$ : chr [1:4] "FRM" "3" NA "1"
#>  ..  ..$ : chr [1:3] "FRM" "4" "Y"
#>  ..  ..$ : chr [1:4] "FRM" "5" NA "2"
#>  ..  ..$ : chr [1:3] "FRM" "7" "Y"
#>  ..  ..$ : chr [1:3] "FRM" "8" "N"
#>  ..  ..$ : chr [1:3] "FRM" "9" "Y"
#>  .. $ :List of 23
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:8] "SV1" "HC>E0431>RR" "59.14" "UN" ...
#>  ..  ..$ : chr [1:3] "PWK" "CT" "AD"
#>  ..  ..$ : chr [1:4] "CR3" "R" "MO" "99"
#>  ..  ..$ : chr [1:4] "DTP" "472" "RD8" "20050321-20050321"
#>  ..  ..$ : chr [1:4] "DTP" "607" "D8" "20050321"
#>  ..  ..$ : chr [1:4] "DTP" "463" "D8" "20040321"
#>  ..  ..$ : chr [1:4] "DTP" "461" "D8" "20050321"
#>  ..  ..$ : chr [1:10] "NM1" "DK" "1" "WILSON" ...
#>  ..  ..$ : chr [1:2] "N3" "1212 NORTH MERIDIAN"
#>  ..  ..$ : chr [1:4] "N4" "RICHMOND" "IN" "46223"
#>  ..  ..$ : chr [1:3] "REF" "1G" "X99999"
#>  ..  ..$ : chr [1:5] "PER" "IC" "LEE" "TE" ...
#>  ..  ..$ : chr [1:3] "LQ" "UT" "04.03"
#>  ..  ..$ : chr [1:4] "FRM" "1A" NA "056"
#>  ..  ..$ : chr [1:4] "FRM" "1C" NA "20050228"
#>  ..  ..$ : chr [1:4] "FRM" "2" NA "1"
#>  ..  ..$ : chr [1:4] "FRM" "3" NA "1"
#>  ..  ..$ : chr [1:3] "FRM" "4" "Y"
#>  ..  ..$ : chr [1:4] "FRM" "5" NA "2"
#>  ..  ..$ : chr [1:3] "FRM" "7" "Y"
#>  ..  ..$ : chr [1:3] "FRM" "8" "N"
#>  ..  ..$ : chr [1:3] "FRM" "9" "Y"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "66" "0001"
#>  .. @ GE : chr [1:2] "1" "000000001"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> $P222$`837P_EX8_wheelchair`
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "HC" "SENDERGS" "RECEIVERGS" "20231106" "142406" ...
#>  .. @ ST : chr [1:3] "837" "112233" "005010X222A1"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "16" "20050326" "1036" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "XYZ WHEELCHAIRS INC" NA NA NA NA "46" ...
#>  .. @ P41: chr [1:4] "IC" "JANE" "TE" "2225551111"
#>  .. @ N40: chr [1:9] "40" "2" "DMERC CARRIER" NA NA NA NA "46" "99999"
#>  .. @ P40: chr NA
#>  @ Claims :List of 4
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "XYZ WHEELCHAIR INC" ...
#>  ..  ..$ : chr [1:2] "N3" "1440 NORTH STREET"
#>  ..  ..$ : chr [1:4] "N4" "LAFAYETTE" "IN" "47904"
#>  ..  ..$ : chr [1:3] "REF" "EI" "123567989"
#>  ..  ..$ : chr [1:3] "REF" "1G" "0426960001"
#>  .. $ :List of 8
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" NA ...
#>  ..  ..$ : chr [1:9] "PAT" NA NA NA ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "SMITH" ...
#>  ..  ..$ : chr [1:2] "N3" "12 MAIN ST"
#>  ..  ..$ : chr [1:4] "N4" "FRANKFORT" "IN" "46209"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19201023" "M"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "DMERC CARRIER" ...
#>  .. $ :List of 2
#>  ..  ..$ : chr [1:10] "CLM" "SMI123" "75" NA ...
#>  ..  ..$ : chr [1:3] "HI" "BK>436" "BF>3449"
#>  .. $ :List of 21
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC>K0001>RR>KH>BR" "75" "UN" ...
#>  ..  ..$ : chr [1:3] "PWK" "CT" "AD"
#>  ..  ..$ : chr [1:4] "CR3" "I" "MO" "99"
#>  ..  ..$ : chr [1:4] "DTP" "472" "RD8" "20050321-20050321"
#>  ..  ..$ : chr [1:4] "DTP" "463" "D8" "20040321"
#>  ..  ..$ : chr [1:4] "DTP" "461" "D8" "20050321"
#>  ..  ..$ : chr [1:4] "MEA" "TR" "HT" "70"
#>  ..  ..$ : chr [1:10] "NM1" "DK" "1" "WILSON" ...
#>  ..  ..$ : chr [1:2] "N3" "1226 WEST RAILROAD STREET"
#>  ..  ..$ : chr [1:4] "N4" "LAFAYETTE" "IN" "47905"
#>  ..  ..$ : chr [1:3] "REF" "1G" "M12345"
#>  ..  ..$ : chr [1:5] "PER" "IC" "LEE" "TE" ...
#>  ..  ..$ : chr [1:3] "LQ" "UT" "02.03B"
#>  ..  ..$ : chr [1:3] "FRM" "1" "Y"
#>  ..  ..$ : chr [1:3] "FRM" "2" "N"
#>  ..  ..$ : chr [1:3] "FRM" "3" "N"
#>  ..  ..$ : chr [1:3] "FRM" "4" "N"
#>  ..  ..$ : chr [1:4] "FRM" "5" NA "8"
#>  ..  ..$ : chr [1:3] "FRM" "8" "N"
#>  ..  ..$ : chr [1:3] "FRM" "9" "Y"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "43" "112233"
#>  .. @ GE : chr [1:2] "1" "000000001"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> $P222$`837P_EX9_anesthesia`
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "HC" "SENDERGS" "RECEIVERGS" "20231106" "142432" ...
#>  .. @ ST : chr [1:3] "837" "0001" "005010X222A1"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "0123" "20050117" "1023" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "PROVIDER MEDICAL GROUP" NA NA NA NA "46" ...
#>  .. @ P41: chr [1:6] "IC" "NINA" "TE" "6155551212" "EX" "911"
#>  .. @ N40: chr [1:9] "40" "2" "ABC PAYER" NA NA NA NA "46" "05440"
#>  .. @ P40: chr NA
#>  @ Claims :List of 4
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "PROVIDER MEDICAL GROUP" ...
#>  ..  ..$ : chr [1:2] "N3" "1234 WEST END AVE"
#>  ..  ..$ : chr [1:4] "N4" "NASHVILLE" "TN" "37232"
#>  ..  ..$ : chr [1:3] "REF" "EI" "756473826"
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" NA ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "JONES" ...
#>  ..  ..$ : chr [1:2] "N3" "123 RAINBOW ROAD"
#>  ..  ..$ : chr [1:4] "N4" "NASHVILLE" "TN" "37232"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19740303" "F"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "ABC PAYER" ...
#>  .. $ :List of 8
#>  ..  ..$ : chr [1:10] "CLM" "153829140" "827" NA ...
#>  ..  ..$ : chr [1:2] "HI" "BK>36616"
#>  ..  ..$ : chr [1:10] "NM1" "82" "1" "TOWNSEND" ...
#>  ..  ..$ : chr [1:4] "PRV" "PE" "PXC" "207L00000X"
#>  ..  ..$ : chr [1:3] "REF" "G2" "9741234"
#>  ..  ..$ : chr [1:10] "NM1" "77" "2" "PROVIDER OP HOSP" ...
#>  ..  ..$ : chr [1:2] "N3" "345 MAIN DRIVE"
#>  ..  ..$ : chr [1:4] "N4" "NASHVILLE" "TN" "37232"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC>00142>QK>QS>P1" "827" "MJ" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20050112"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "29" "0001"
#>  .. @ GE : chr [1:2] "1" "000000001"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> $P222$claim_payment_837P_222
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "1234567" "ZZ" "11111" "170508" ...
#>  .. @ GS : chr [1:8] "HC" "XXXXXXX" "XXXXX" "20170617" "1741" "101" "X" ...
#>  .. @ ST : chr [1:3] "837" "0021" "005010X222A1"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "244579" "20061015" "1023" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "PREMIER BILLING SERVICE" NA NA NA NA "46" ...
#>  .. @ P41: chr [1:6] "IC" "JERRY" "TE" "3055552222" "EX" "231"
#>  .. @ N40: chr [1:9] "40" "2" "KEY INSURANCE COMPANY" NA NA NA NA "46" ...
#>  .. @ P40: chr NA
#>  @ Claims :List of 8
#>  .. $ :List of 9
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:4] "PRV" "BI" "PXC" "203BF0100Y"
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "BEN KILDARE SERVICE" ...
#>  ..  ..$ : chr [1:2] "N3" "234 SEAWAY ST"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33111"
#>  ..  ..$ : chr [1:3] "REF" "EI" "587654321"
#>  ..  ..$ : chr [1:4] "NM1" "87" "2" "Kildare Associates"
#>  ..  ..$ : chr [1:2] "N3" "2345 OCEAN BLVD"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33111"
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" NA "2222-SJ" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "SMITH" ...
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19430501" "F"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "KEY INSURANCE COMPANY" ...
#>  ..  ..$ : chr [1:3] "REF" "G2" "KA6663"
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "3" "2" "23" ...
#>  ..  ..$ : chr [1:2] "PAT" "19"
#>  ..  ..$ : chr [1:5] "NM1" "QC" "1" "SMITH" ...
#>  ..  ..$ : chr [1:2] "N3" "236 N MAIN ST"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33413"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19730501" "M"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:10] "CLM" "26463774" "100" NA ...
#>  ..  ..$ : chr [1:3] "REF" "D9" "17312345600006351"
#>  ..  ..$ : chr [1:3] "HI" "BK:0340" "BF:V7389"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC:99213" "40" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20061003"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:8] "SV1" "HC:87070" "15" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20061003"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "3"
#>  ..  ..$ : chr [1:8] "SV1" "HC:99214" "35" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20061010"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:2] "LX" "4"
#>  ..  ..$ : chr [1:8] "SV1" "HC:86663" "10" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20061010"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "42" "0021"
#>  .. @ GE : chr [1:2] "1" "101"
#>  .. @ IEA: chr [1:2] "1" "000000101"
#> 
#> $P222$claim_payment_EVV_837P_222
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "1234567" "ZZ" "11111" "170508" ...
#>  .. @ GS : chr [1:8] "HC" "XXXXXXX" "XXXXX" "20170617" "1741" "101" "X" ...
#>  .. @ ST : chr [1:3] "837" "0021" "005010X222A1"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "244579" "20061015" "1023" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "PREMIER BILLING SERVICE" NA NA NA NA "46" ...
#>  .. @ P41: chr [1:6] "IC" "JERRY" "TE" "3055552222" "EX" "231"
#>  .. @ N40: chr [1:9] "40" "2" "KEY INSURANCE COMPANY" NA NA NA NA "46" ...
#>  .. @ P40: chr NA
#>  @ Claims :List of 5
#>  .. $ :List of 9
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:4] "PRV" "BI" "PXC" "203BF0100Y"
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "BEN KILDARE SERVICE" ...
#>  ..  ..$ : chr [1:2] "N3" "234 SEAWAY ST"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33111"
#>  ..  ..$ : chr [1:3] "REF" "EI" "587654321"
#>  ..  ..$ : chr [1:4] "NM1" "87" "2" "Kildare Associates"
#>  ..  ..$ : chr [1:2] "N3" "2345 OCEAN BLVD"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33111"
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" NA "2222-SJ" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "SOLO" ...
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19430501" "F"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "KEY INSURANCE COMPANY" ...
#>  ..  ..$ : chr [1:3] "REF" "G2" "KA6663"
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "3" "2" "23" ...
#>  ..  ..$ : chr [1:2] "PAT" "19"
#>  ..  ..$ : chr [1:5] "NM1" "QC" "1" "SMITH" ...
#>  ..  ..$ : chr [1:2] "N3" "236 N MAIN ST"
#>  ..  ..$ : chr [1:4] "N4" "MIAMI" "FL" "33413"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19730501" "M"
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:10] "CLM" "26463774" "100" NA ...
#>  ..  ..$ : chr [1:3] "REF" "D9" "17312345600006351"
#>  ..  ..$ : chr [1:3] "HI" "BK:0340" "BF:V7389"
#>  .. $ :List of 11
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC:S5135:::::1230-1630" "50" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "RD8" "20160302-20160302"
#>  ..  ..$ : chr [1:5] "NM1" "DQ" "1" "JONES" ...
#>  ..  ..$ : chr [1:3] "REF" "LU" "1234567890"
#>  ..  ..$ : chr [1:3] "NM1" "PW" "2"
#>  ..  ..$ : chr [1:3] "N3" "2777 HOOCH LANE" "APT 2005"
#>  ..  ..$ : chr [1:4] "N4" "CLARICE" "VA" "22554"
#>  ..  ..$ : chr [1:3] "NM1" "45" "2"
#>  ..  ..$ : chr [1:2] "N3" "4545 RETURN ST"
#>  ..  ..$ : chr [1:4] "N4" "NUCHOL" "VA" "22554"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "41" "0021"
#>  .. @ GE : chr [1:2] "1" "101"
#>  .. @ IEA: chr [1:2] "1" "000000101"
#> 
#> $P222$sample_837_0
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "01" "987654321" "ZZ" "123456789" ...
#>  .. @ GS : chr [1:8] "HC" "CLEARINGHOUSE" "123456789" "20180508" "0833" ...
#>  .. @ ST : chr [1:3] "837" "000000001" "005010X222A1"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "7349063984" "20180508" "0833" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "CLEARINGHOUSE LLC" NA NA NA NA "46" ...
#>  .. @ P41: chr [1:6] "IC" "CLEARINGHOUSE CLIENT SERVICES" "TE" "5555550000" ...
#>  .. @ N40: chr [1:9] "40" "2" "123456789" NA NA NA NA "46" "CHPWA"
#>  .. @ P40: chr NA
#>  @ Claims :List of 20
#>  .. $ :List of 9
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "BH CLINIC OF VANCOUVER" ...
#>  ..  ..$ : chr [1:2] "N3" "12345 MAIN ST"
#>  ..  ..$ : chr [1:4] "N4" "VANCOUVER" "WA" "98662"
#>  ..  ..$ : chr [1:3] "REF" "EI" "720000000"
#>  ..  ..$ : chr [1:5] "PER" "IC" "CONTACT" "TE" ...
#>  ..  ..$ : chr [1:3] "NM1" "87" "2"
#>  ..  ..$ : chr [1:2] "N3" "PO BOX 1234"
#>  ..  ..$ : chr [1:4] "N4" "VANCOUVER" "WA" "986681234"
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" NA ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "SUBSCRIBER" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19000101" "M"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "COMMUNITY HEALTH PLAN OF WASHINGTON" ...
#>  .. $ :List of 8
#>  ..  ..$ : chr [1:10] "CLM" "1805080AV3648339" "20" NA ...
#>  ..  ..$ : chr [1:3] "REF" "D9" "7349065509"
#>  ..  ..$ : chr [1:2] "HI" "ABK:F1120"
#>  ..  ..$ : chr [1:10] "NM1" "82" "1" "PROVIDER" ...
#>  ..  ..$ : chr [1:4] "PRV" "PE" "PXC" "261QR0405X"
#>  ..  ..$ : chr [1:10] "NM1" "77" "2" "BH CLINIC OF VANCOUVER" ...
#>  ..  ..$ : chr [1:2] "N3" "12345 MAIN ST SUITE A1"
#>  ..  ..$ : chr [1:4] "N4" "VANCOUVER" "WA" "98662"
#>  .. $ :List of 10
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC:H0003" "20" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  ..  ..$ : chr [1:3] "SE" "34" "000000001"
#>  ..  ..$ : chr [1:4] "ST" "837" "000000002" "005010X222A1"
#>  ..  ..$ : chr [1:7] "BHT" "0019" "00" "7349063984" ...
#>  ..  ..$ : chr [1:10] "NM1" "41" "2" "CLEARINGHOUSE LLC" ...
#>  ..  ..$ : chr [1:7] "PER" "IC" "CLEARINGHOUSE CLIENT SERVICES" "TE" ...
#>  ..  ..$ : chr [1:10] "NM1" "40" "2" "123456789" ...
#>  .. $ :List of 9
#>  ..  ..$ : chr [1:5] "HL" "63" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "BH CLINIC OF VANCOUVER" ...
#>  ..  ..$ : chr [1:2] "N3" "12345 MAIN ST"
#>  ..  ..$ : chr [1:4] "N4" "VANCOUVER" "WA" "98662"
#>  ..  ..$ : chr [1:3] "REF" "EI" "720000000"
#>  ..  ..$ : chr [1:5] "PER" "IC" "CONTACT" "TE" ...
#>  ..  ..$ : chr [1:3] "NM1" "87" "2"
#>  ..  ..$ : chr [1:2] "N3" "PO BOX 1234"
#>  ..  ..$ : chr [1:4] "N4" "VANCOUVER" "WA" "986681234"
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "64" "63" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" NA ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "PATIENT" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19000101" "F"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "COMMUNITY HEALTH PLAN OF WASHINGTON" ...
#>  .. $ :List of 8
#>  ..  ..$ : chr [1:10] "CLM" "1805080AV3648347" "50.1" NA ...
#>  ..  ..$ : chr [1:3] "REF" "D9" "7349065730"
#>  ..  ..$ : chr [1:3] "HI" "ABK:F1520" "ABF:F1220"
#>  ..  ..$ : chr [1:10] "NM1" "82" "1" "PROVIDER" ...
#>  ..  ..$ : chr [1:4] "PRV" "PE" "PXC" "261QR0405X"
#>  ..  ..$ : chr [1:10] "NM1" "77" "2" "BH CLINIC OF VANCOUVER" ...
#>  ..  ..$ : chr [1:2] "N3" "12345 MAIN ST SUITE A1"
#>  ..  ..$ : chr [1:4] "N4" "VANCOUVER" "WA" "98662"
#>  .. $ :List of 10
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC:96153:HF" "50.1" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180426"
#>  ..  ..$ : chr [1:3] "REF" "6R" "143792"
#>  ..  ..$ : chr [1:3] "SE" "34" "000000002"
#>  ..  ..$ : chr [1:4] "ST" "837" "000000003" "005010X222A1"
#>  ..  ..$ : chr [1:7] "BHT" "0019" "00" "7349063984" ...
#>  ..  ..$ : chr [1:10] "NM1" "41" "2" "CLEARINGHOUSE LLC" ...
#>  ..  ..$ : chr [1:7] "PER" "IC" "CLEARINGHOUSE CLIENT SERVICES" "TE" ...
#>  ..  ..$ : chr [1:10] "NM1" "40" "2" "123456789" ...
#>  .. $ :List of 9
#>  ..  ..$ : chr [1:5] "HL" "49" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "BH CLINIC OF VANCOUVER" ...
#>  ..  ..$ : chr [1:2] "N3" "12345 MAIN ST"
#>  ..  ..$ : chr [1:4] "N4" "VANCOUVER" "WA" "98662"
#>  ..  ..$ : chr [1:3] "REF" "EI" "720000000"
#>  ..  ..$ : chr [1:5] "PER" "IC" "CONTACT" "TE" ...
#>  ..  ..$ : chr [1:3] "NM1" "87" "2"
#>  ..  ..$ : chr [1:2] "N3" "PO BOX 1234"
#>  ..  ..$ : chr [1:4] "N4" "VANCOUVER" "WA" "986681234"
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "50" "49" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" NA ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "SUBSCRIBER" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19000101" "M"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "COMMUNITY HEALTH PLAN OF WASHINGTON" ...
#>  .. $ :List of 8
#>  ..  ..$ : chr [1:10] "CLM" "1805080AV3648340" "11.64" NA ...
#>  ..  ..$ : chr [1:3] "REF" "D9" "7349065492"
#>  ..  ..$ : chr [1:3] "HI" "ABK:F1020" "ABF:F1220"
#>  ..  ..$ : chr [1:10] "NM1" "82" "1" "PROVIDER" ...
#>  ..  ..$ : chr [1:4] "PRV" "PE" "PXC" "261QR0405X"
#>  ..  ..$ : chr [1:10] "NM1" "77" "2" "BH CLINIC OF VANCOUVER" ...
#>  ..  ..$ : chr [1:2] "N3" "12345 MAIN ST SUITE A1"
#>  ..  ..$ : chr [1:4] "N4" "VANCOUVER" "WA" "98662"
#>  .. $ :List of 10
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC:T1017:HF" "11.64" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180427"
#>  ..  ..$ : chr [1:3] "REF" "6R" "140976"
#>  ..  ..$ : chr [1:3] "SE" "34" "000000003"
#>  ..  ..$ : chr [1:4] "ST" "837" "000000004" "005010X222A1"
#>  ..  ..$ : chr [1:7] "BHT" "0019" "00" "7349063984" ...
#>  ..  ..$ : chr [1:10] "NM1" "41" "2" "CLEARINGHOUSE LLC" ...
#>  ..  ..$ : chr [1:7] "PER" "IC" "CLEARINGHOUSE CLIENT SERVICES" "TE" ...
#>  ..  ..$ : chr [1:10] "NM1" "40" "2" "123456789" ...
#>  .. $ :List of 9
#>  ..  ..$ : chr [1:5] "HL" "75" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "BH CLINIC OF VANCOUVER" ...
#>  ..  ..$ : chr [1:2] "N3" "12345 MAIN ST"
#>  ..  ..$ : chr [1:4] "N4" "VANCOUVER" "WA" "98662"
#>  ..  ..$ : chr [1:3] "REF" "EI" "720000000"
#>  ..  ..$ : chr [1:5] "PER" "IC" "CONTACT" "TE" ...
#>  ..  ..$ : chr [1:3] "NM1" "87" "2"
#>  ..  ..$ : chr [1:2] "N3" "PO BOX 1234"
#>  ..  ..$ : chr [1:4] "N4" "VANCOUVER" "WA" "986681234"
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "76" "75" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" NA ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "PATIENT" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19000101" "F"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "COMMUNITY HEALTH PLAN OF WASHINGTON" ...
#>  .. $ :List of 8
#>  ..  ..$ : chr [1:10] "CLM" "1805080AV3648353" "234" NA ...
#>  ..  ..$ : chr [1:3] "REF" "D9" "7349064290"
#>  ..  ..$ : chr [1:2] "HI" "ABK:F251"
#>  ..  ..$ : chr [1:10] "NM1" "82" "1" "PROVIDER" ...
#>  ..  ..$ : chr [1:4] "PRV" "PE" "PXC" "251S00000X"
#>  ..  ..$ : chr [1:10] "NM1" "77" "2" "BH CLINIC OF VANCOUVER" ...
#>  ..  ..$ : chr [1:2] "N3" "12345 MAIN ST SUITE A1"
#>  ..  ..$ : chr [1:4] "N4" "VANCOUVER" "WA" "98662"
#>  .. $ :List of 11
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC:90853" "234" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180427"
#>  ..  ..$ : chr [1:3] "REF" "6R" "140787"
#>  ..  ..$ : chr [1:3] "NTE" "ADD" "05"
#>  ..  ..$ : chr [1:3] "SE" "35" "000000004"
#>  ..  ..$ : chr [1:4] "ST" "837" "000000005" "005010X222A1"
#>  ..  ..$ : chr [1:7] "BHT" "0019" "00" "7349063984" ...
#>  ..  ..$ : chr [1:10] "NM1" "41" "2" "CLEARINGHOUSE LLC" ...
#>  ..  ..$ : chr [1:7] "PER" "IC" "CLEARINGHOUSE CLIENT SERVICES" "TE" ...
#>  ..  ..$ : chr [1:10] "NM1" "40" "2" "123456789" ...
#>  .. $ :List of 9
#>  ..  ..$ : chr [1:5] "HL" "79" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "BH CLINIC OF VANCOUVER" ...
#>  ..  ..$ : chr [1:2] "N3" "12345 MAIN ST"
#>  ..  ..$ : chr [1:4] "N4" "VANCOUVER" "WA" "98662"
#>  ..  ..$ : chr [1:3] "REF" "EI" "720000000"
#>  ..  ..$ : chr [1:5] "PER" "IC" "CONTACT" "TE" ...
#>  ..  ..$ : chr [1:3] "NM1" "87" "2"
#>  ..  ..$ : chr [1:2] "N3" "PO BOX 1234"
#>  ..  ..$ : chr [1:4] "N4" "VANCOUVER" "WA" "986681234"
#>  .. $ :List of 7
#>  ..  ..$ : chr [1:5] "HL" "80" "79" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" NA ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "SUBSCRIBER" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19000101" "M"
#>  ..  ..$ : chr [1:10] "NM1" "PR" "2" "COMMUNITY HEALTH PLAN OF WASHINGTON" ...
#>  .. $ :List of 8
#>  ..  ..$ : chr [1:10] "CLM" "1805080AV3648355" "20" NA ...
#>  ..  ..$ : chr [1:3] "REF" "D9" "7349064036"
#>  ..  ..$ : chr [1:3] "HI" "ABK:F1020" "ABF:F1120"
#>  ..  ..$ : chr [1:10] "NM1" "82" "1" "PROVIDER" ...
#>  ..  ..$ : chr [1:4] "PRV" "PE" "PXC" "261QR0405X"
#>  ..  ..$ : chr [1:10] "NM1" "77" "2" "BH CLINIC OF VANCOUVER" ...
#>  ..  ..$ : chr [1:2] "N3" "12345 MAIN ST SUITE A1"
#>  ..  ..$ : chr [1:4] "N4" "VANCOUVER" "WA" "98662"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:8] "SV1" "HC:H0003" "20" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180427"
#>  ..  ..$ : chr [1:3] "REF" "6R" "143907"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "34" "000000005"
#>  .. @ GE : chr [1:2] "5" "212950697"
#>  .. @ IEA: chr [1:2] "1" "697773230"
#> 
#> $P222$sample_837_11
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SUBMITTER ID" "ZZ" ...
#>  .. @ GS : chr [1:8] "HC" "SUBMITTER ID" "RECEIVER ID" "20230516" "1145" ...
#>  .. @ ST : chr [1:3] "837" "0001" "005010X222A1"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "244579" "20230516" "1145" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "SUBMIT CLINIC" NA NA NA NA "46" "12345"
#>  .. @ P41: chr [1:4] "IC" "CONTACT NAME" "TE" "5555550000"
#>  .. @ N40: chr [1:9] "40" "2" "RECEIVER NAME" NA NA NA NA "46" "67890"
#>  .. @ P40: chr NA
#>  @ Claims :List of 3
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "BILLING PROVIDER" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "GA" "00000"
#>  ..  ..$ : chr [1:3] "REF" "EI" "123456789"
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" NA ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "DOE" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "GA" "00000"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19000101" "M"
#>  .. $ :List of 8
#>  ..  ..$ : chr [1:10] "CLM" "12345" "150.00" NA ...
#>  ..  ..$ : chr [1:2] "HI" "ABK:I109"
#>  ..  ..$ : chr [1:10] "NM1" "82" "1" "PROVIDER" ...
#>  ..  ..$ : chr [1:4] "PRV" "PE" "ZZ" "207RC0000X"
#>  ..  ..$ : chr [1:9] "SV1" "HC:J1745" "150.00" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20230515"
#>  ..  ..$ : chr [1:4] "LIN" NA "N4" "50242004001"
#>  ..  ..$ : chr [1:5] "CTP" NA NA "2" ...
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "24" "0001"
#>  .. @ GE : chr [1:2] "1" "1"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> $P222$sample_837_12
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SUBMITTER ID" "ZZ" ...
#>  .. @ GS : chr [1:8] "HC" "SUBMITTER ID" "RECEIVER ID" "20230516" "1145" ...
#>  .. @ ST : chr [1:3] "837" "0001" "005010X222A1"
#>  @ Details: <hcc::Detail837>
#>  .. @ BHT: chr [1:6] "0019" "00" "244579" "20230516" "1145" "CH"
#>  .. @ N41: chr [1:9] "41" "2" "SUBMIT CLINIC" NA NA NA NA "46" "12345"
#>  .. @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  .. @ N40: chr [1:9] "40" "2" "RECEIVER NAME" NA NA NA NA "46" "67890"
#>  .. @ P40: chr NA
#>  @ Claims :List of 16
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "BILLING PROVIDER" ...
#>  ..  ..$ : chr [1:2] "N3" "123 BILLING ST"
#>  ..  ..$ : chr [1:4] "N4" "CITY" "GA" "30001"
#>  ..  ..$ : chr [1:3] "REF" "EI" "123456789"
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" NA ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "TESTLAST01" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19000101" "M"
#>  .. $ :List of 15
#>  ..  ..$ : chr [1:10] "CLM" "12345" "150.00" NA ...
#>  ..  ..$ : chr [1:2] "HI" "ABK:I109"
#>  ..  ..$ : chr [1:10] "NM1" "82" "1" "PROVIDER" ...
#>  ..  ..$ : chr [1:4] "PRV" "PE" "ZZ" "207RC0000X"
#>  ..  ..$ : chr [1:9] "SV1" "HC:J1745" "150.00" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20230515"
#>  ..  ..$ : chr [1:4] "LIN" NA "N4" "50242004001"
#>  ..  ..$ : chr [1:5] "CTP" NA NA "2" ...
#>  ..  ..$ : chr [1:3] "SE" "24" "0001"
#>  ..  ..$ : chr [1:4] "ST" "837" "5856" "005010X223A2"
#>  ..  ..$ : chr [1:7] "BHT" "0019" "00" "241205204222" ...
#>  ..  ..$ : chr [1:10] "NM1" "41" "2" "HSA PORT ARTHUR, LLC" ...
#>  ..  ..$ : chr [1:5] "PER" "IC" "TEST CONTACT" "TE" ...
#>  ..  ..$ : chr [1:10] "NM1" "40" "2" "OptimaFourSight" ...
#>  ..  ..$ : chr [1:5] "PER" "IC" "TEST CONTACT" "TE" ...
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "HSA PORT ARTHUR, LLC" ...
#>  ..  ..$ : chr [1:2] "N3" "505 N BRAND BLVD STE 1200"
#>  ..  ..$ : chr [1:4] "N4" "GLENDALE" "CA" "91203"
#>  ..  ..$ : chr [1:3] "REF" "EI" "71-3391736"
#>  ..  ..$ : chr [1:5] "PER" "IC" "TEST CONTACT" "TE" ...
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" "731323546" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "TESTLAST02" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>  .. $ :List of 8
#>  ..  ..$ : chr [1:10] "CLM" "4742333269" "128" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "20240422-20240430"
#>  ..  ..$ : chr [1:4] "DTP" "435" "D8" "20240809"
#>  ..  ..$ : chr [1:4] "DTP" "096" "TM" "2337"
#>  ..  ..$ : chr [1:2] "HI" "ABK:W214XXA"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S31813D"
#>  ..  ..$ : chr [1:2] "HI" "ABK:V0492XD"
#>  ..  ..$ : chr [1:2] "HI" "ABK:T498X6A"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:11] "SV1" "HC:37180" "93" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:11] "SV1" "HC:24000" "4" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 11
#>  ..  ..$ : chr [1:2] "LX" "3"
#>  ..  ..$ : chr [1:11] "SV1" "HC:16035" "31" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  ..  ..$ : chr [1:3] "SE" "38" "5856"
#>  ..  ..$ : chr [1:4] "ST" "837" "4763033" "005010X223A2"
#>  ..  ..$ : chr [1:7] "BHT" "0019" "00" "241205204221" ...
#>  ..  ..$ : chr [1:10] "NM1" "41" "2" "HCA HEALTH SERVICES OF TENNESSEE, INC." ...
#>  ..  ..$ : chr [1:5] "PER" "IC" "TEST CONTACT" "TE" ...
#>  ..  ..$ : chr [1:10] "NM1" "40" "2" "HMOOffExchangeRegion7" ...
#>  ..  ..$ : chr [1:5] "PER" "IC" "TEST CONTACT" "TE" ...
#>  .. $ :List of 6
#>  ..  ..$ : chr [1:5] "HL" "1" NA "20" ...
#>  ..  ..$ : chr [1:10] "NM1" "85" "2" "HCA HEALTH SERVICES OF TENNESSEE, INC." ...
#>  ..  ..$ : chr [1:2] "N3" "313 N MAIN ST"
#>  ..  ..$ : chr [1:4] "N4" "ASHLAND CITY" "TN" "37015"
#>  ..  ..$ : chr [1:3] "REF" "EI" "99-5971744"
#>  ..  ..$ : chr [1:5] "PER" "IC" "TEST CONTACT" "TE" ...
#>  .. $ :List of 5
#>  ..  ..$ : chr [1:5] "HL" "2" "1" "22" ...
#>  ..  ..$ : chr [1:10] "SBR" "P" "18" "556791994" ...
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "TESTLAST03" ...
#>  ..  ..$ : chr [1:2] "N3" "123 TEST STREET"
#>  ..  ..$ : chr [1:4] "N4" "TESTCITY" "CA" "00000"
#>  .. $ :List of 12
#>  ..  ..$ : chr [1:10] "CLM" "4742333269" "839" NA ...
#>  ..  ..$ : chr [1:4] "DTP" "434" "RD8" "20240422-20240430"
#>  ..  ..$ : chr [1:4] "DTP" "435" "D8" "20240809"
#>  ..  ..$ : chr [1:4] "DTP" "096" "TM" "2337"
#>  ..  ..$ : chr [1:2] "HI" "ABK:V9421XS"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S35292S"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S52272S"
#>  ..  ..$ : chr [1:2] "HI" "ABK:H68022"
#>  ..  ..$ : chr [1:2] "HI" "ABK:T4144XD"
#>  ..  ..$ : chr [1:2] "HI" "ABK:H1030"
#>  ..  ..$ : chr [1:2] "HI" "ABK:S82832J"
#>  ..  ..$ : chr [1:2] "HI" "ABK:B340"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "1"
#>  ..  ..$ : chr [1:11] "SV1" "HC:35650" "161" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "2"
#>  ..  ..$ : chr [1:11] "SV1" "HC:73200" "383" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "3"
#>  ..  ..$ : chr [1:11] "SV1" "HC:28262" "194" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  .. $ :List of 4
#>  ..  ..$ : chr [1:2] "LX" "4"
#>  ..  ..$ : chr [1:11] "SV1" "HC:84480" "101" "UN" ...
#>  ..  ..$ : chr [1:4] "DTP" "472" "D8" "20180428"
#>  ..  ..$ : chr [1:3] "REF" "6R" "142671"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "46" "4763033"
#>  .. @ GE : chr [1:2] "1" "1"
#>  .. @ IEA: chr [1:2] "1" "000000001"
#> 
#> 
```
