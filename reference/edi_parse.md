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
# edi_parse(x12_EX$`837`[[1]][[1]])
# edi_parse(x12_EX$`837`[[2]][[1]])
# edi_parse(x12_EX$`834`[[1]])
# edi_parse(x12_EX$`820`[[1]][[1]])
# edi_parse(x12_EX$`820`[[2]][[1]])
edi_parse(x12_EX$`820`$`306`) |>
purrr::map_depth(1L, \(x) S7::prop(x, "Details"))
#> $`820_EX10_debt_covered_by_affiliate1`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA NA NA NA NA NA NA ...
#>  @ TRN: chr [1:2] "3" "123456789123385"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "NATIONAL EAST" "FI" "121231244"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`820_EX11_debt_covered_by_affiliate2`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA NA NA NA NA NA NA ...
#>  @ TRN: chr [1:2] "3" "12345678945678"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "NATIONAL EAST" "FI" "121231244"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`820_EX12_csr_manual_adj`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA NA NA NA NA NA NA ...
#>  @ TRN: chr [1:2] "3" "123456789123456"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "NATIONAL" "FI" "121231233"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "220" "C" "ACH" "CCP" NA NA NA NA NA NA "01" ...
#>  @ TRN: chr [1:2] "3" "78905"
#>  @ REF: chr [1:4] "38" "123456" "TV" "12565496"
#>  @ NPE: chr [1:4] "PE" "BATA INSURANCE CO." "FI" "012222222"
#>  @ NRM: chr [1:4] "RM" "GOVERNMENT AGENCY" "58" "123ABC"
#>  @ PER: chr NA
#> 
#> $`820_EX2_payments_exceed_charges1`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA NA NA NA NA NA NA ...
#>  @ TRN: chr [1:2] "3" "123456789123456"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "NATIONAL" "FI" "121231233"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`820_EX3_payments_exceed_charges2`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "1110" "C" "ACH" "CCP" NA NA NA NA NA NA "01" ...
#>  @ TRN: chr [1:2] "3" "123456789123459"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "NATIONAL" "FI" "121231233"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`820_EX4_charges_exceed_payments1`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA NA NA NA NA NA NA ...
#>  @ TRN: chr [1:2] "3" "123456789123457"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "USINS" "FI" "121231234"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`820_EX5_charges_exceed_payments2`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA NA NA NA NA NA NA ...
#>  @ TRN: chr [1:2] "3" "123456789123567"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "USINS" "FI" "121231234"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`820_EX6_aptc_adjustments1`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA NA NA NA NA NA NA ...
#>  @ TRN: chr [1:2] "3" "123456789123456"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "NATIONAL" "FI" "121231233"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`820_EX7_aptc_adjustments2`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "910" "C" "ACH" "CCP" NA NA NA NA NA NA "01" ...
#>  @ TRN: chr [1:2] "3" "123456789123459"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "NATIONAL" "FI" "121231233"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`820_EX8_outstanding_debt_owed1`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA NA NA NA NA NA NA ...
#>  @ TRN: chr [1:2] "3" "1234512345098"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "NATIONAL" "FI" "121231233"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $`820_EX9_outstanding_debt_owed2`
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "985" "C" "ACH" "CCP" NA NA NA NA NA NA "01" ...
#>  @ TRN: chr [1:2] "3" "123456789123459"
#>  @ REF: chr NA
#>  @ NPE: chr [1:4] "PE" "NATIONAL" "FI" "121231233"
#>  @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#> 
#> $payment_order_820_360
#> <hcc::Detail306>
#>  @ BPR: chr [1:16] "I" "220" "C" "ACH" "CCP" NA NA NA NA NA NA "01" ...
#>  @ TRN: chr [1:2] "3" "78905"
#>  @ REF: chr [1:4] "38" "123456" "TV" "12565496"
#>  @ NPE: chr [1:4] "PE" "BATA INSURANCE CO." "FI" "012222222"
#>  @ NRM: chr [1:4] "RM" "GOVERNMENT AGENCY" "58" "123ABC"
#>  @ PER: chr NA
#> 
edi_parse(x12_EX$`820`$`218`) |>
purrr::map_depth(1L, \(x) S7::prop(x, "Details"))
#> $`820_Child_Health_Plus_Payment_EFT`
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "I" "239.6" "C" "ACH" "CCP" "01" "111111111" NA NA ...
#>  @ TRN: chr [1:3] "3" "021300000000000" "1141797357"
#>  @ REF: chr [1:2] "14" "12345678"
#>  @ NPE: chr [1:4] "PE" "MANAGED CARE" "FI" "123456789"
#>  @ NPR: chr [1:2] "PR" "CHILD HEALTH PLUS"
#> 
#> $`820_Essentail_Health_Plan`
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "I" "123.45" "C" "CHK" NA NA NA NA NA "1141797357" NA NA ...
#>  @ TRN: chr [1:3] "3" "000000032788113" "1141797357"
#>  @ REF: chr [1:2] "14" "12345678"
#>  @ NPE: chr [1:4] "PE" NA "FI" "123456789"
#>  @ NPR: chr [1:7] "PR" "BASIC HEALTH PLAN" ...
#> 
#> $`820_Premium_Payment_EFT`
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "I" "566.29" "C" "ACH" "CCP" "01" "111111111" NA NA ...
#>  @ TRN: chr [1:3] "3" "021300000000000" "1141797357"
#>  @ REF: chr [1:2] "14" "12345678"
#>  @ NPE: chr [1:4] "PE" "MANAGED CARE" "FI" "123456789"
#>  @ NPR: chr [1:4] "PR" "NYSDOH" "FI" "141797357"
#> 
#> $`820_Premium_Payment_NOPMT`
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA "1234567890" NA NA NA NA ...
#>  @ TRN: chr [1:3] "3" "021300000000000" "1123456789"
#>  @ REF: chr [1:2] "14" "12345678"
#>  @ NPE: chr [1:4] "PE" "MANAGED CARE" "FI" "123456789"
#>  @ NPR: chr [1:9] "PR" "NYSDOH" "FI" "141797357" ...
#> 
#> $payment_order_820_218
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "C" "19000" "C" "ACH" "CTX" "01" "999999992" "DA" ...
#>  @ TRN: chr [1:3] "1" "12345" "1030449999"
#>  @ REF: chr [1:2] "14" "12345"
#>  @ NPE: chr [1:4] "PE" "DEF HEALTH CARE INC." "FI" "012222222"
#>  @ NPR: chr [1:4] "PR" "ABC PLASTICS" "FI" "123456789"
#> 
#> $sample_820_01
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "I" "102139.46" "C" "NON" NA NA NA NA NA "68-0317191" NA ...
#>  @ TRN: chr [1:2] "3" "TESTTRN01000001"
#>  @ REF: chr [1:2] "14" "0000245023"
#>  @ NPE: chr [1:6] "PE" "TEST PAYEE ORGANIZATION" "123 TEST STREET" "TESTCITY" ...
#>  @ NPR: chr [1:6] "PR" "TEST PAYER AGENCY" "123 TEST STREET" "TESTCITY" "CA" ...
#> 
#> $sample_820_02
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "I" "91977.81" "C" "NON" NA NA NA NA NA "68-0317191" NA NA ...
#>  @ TRN: chr [1:2] "3" "TESTTRN02000001"
#>  @ REF: chr [1:2] "14" "0000245023"
#>  @ NPE: chr [1:6] "PE" "TEST PAYEE ORGANIZATION" "123 TEST STREET" "TESTCITY" ...
#>  @ NPR: chr [1:6] "PR" "TEST PAYER AGENCY" "123 TEST STREET" "TESTCITY" "CA" ...
#> 
#> $sample_820_03
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "I" "697085.64" "C" "NON" NA NA NA NA NA "68-0317191" NA ...
#>  @ TRN: chr [1:2] "3" "TESTTRN03000001"
#>  @ REF: chr [1:2] "14" "0000245023"
#>  @ NPE: chr [1:6] "PE" "TEST PAYEE ORGANIZATION" "123 TEST STREET" "TESTCITY" ...
#>  @ NPR: chr [1:6] "PR" "TEST PAYER AGENCY" "123 TEST STREET" "TESTCITY" "CA" ...
#> 
#> $sample_820_04
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "I" "80865.30" "C" "NON" NA NA NA NA NA "68-0317191" NA NA ...
#>  @ TRN: chr [1:2] "3" "TESTTRN04000001"
#>  @ REF: chr [1:2] "14" "0000245023"
#>  @ NPE: chr [1:6] "PE" "TEST PAYEE ORGANIZATION" "123 TEST STREET" "TESTCITY" ...
#>  @ NPR: chr [1:6] "PR" "TEST PAYER AGENCY" "123 TEST STREET" "TESTCITY" "CA" ...
#> 
#> $sample_820_05
#> <hcc::Detail218>
#>  @ BPR: chr [1:16] "I" "499187.57" "C" "NON" NA NA NA NA NA "68-0317191" NA ...
#>  @ TRN: chr [1:2] "3" "TESTTRN05000001"
#>  @ REF: chr [1:2] "14" "0000245023"
#>  @ NPE: chr [1:6] "PE" "TEST PAYEE ORGANIZATION" "123 TEST STREET" "TESTCITY" ...
#>  @ NPR: chr [1:6] "PR" "TEST PAYER AGENCY" "123 TEST STREET" "TESTCITY" "CA" ...
#> 
edi_parse(x12_EX$`834`) |>
purrr::map_depth(1L, \(x) S7::prop(x, "Details"))
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
edi_parse(x12_EX$`837`$I223) |>
purrr::map_depth(1L, \(x) S7::prop(x, "Details"))
#> $`837I_EX1a_institutional_claim`
#> <hcc::Detail837>
#>  @ BHT: chr [1:6] "0019" "00" "0123" "19960918" "0932" "CH"
#>  @ N41: chr [1:9] "41" "2" "JONES HOSPITAL" NA NA NA NA "46" "12345"
#>  @ P41: chr [1:4] "IC" "JANE DOE" "TE" "9005555555"
#>  @ N40: chr [1:9] "40" "2" "MEDICARE" NA NA NA NA "46" "00120"
#>  @ P40: chr NA
#> 
#> $`837I_EX1b_2claims_1provider`
#> <hcc::Detail837>
#>  @ BHT: chr [1:6] "0019" "00" "0123" "20050630" "0932" "CH"
#>  @ N41: chr [1:9] "41" "2" "JONES HOSPITAL" NA NA NA NA "46" "12345"
#>  @ P41: chr [1:4] "IC" "JANE DOE" "TE" "1112223333"
#>  @ N40: chr [1:9] "40" "2" "TRICARE" NA NA NA NA "46" "99999"
#>  @ P40: chr NA
#> 
#> $`837I_EX1c_ppo_repriced_claim`
#> <hcc::Detail837>
#>  @ BHT: chr [1:6] "0019" "00" "1002" "20050721" "09460000" "CH"
#>  @ N41: chr [1:9] "41" "2" "REGIONAL PPO NETWORK" NA NA NA NA "46" ...
#>  @ P41: chr [1:4] "IC" "SUBMITTER CONTACT INFO" "TE" "8001231234"
#>  @ N40: chr [1:9] "40" "2" "LOCAL INSURANCE COMPANY" NA NA NA NA "46" ...
#>  @ P40: chr NA
#> 
#> $`837I_EX1d_oon_repriced_claim`
#> <hcc::Detail837>
#>  @ BHT: chr [1:6] "0019" "00" "1024" "20050711" "1335" "CH"
#>  @ N41: chr [1:9] "41" "2" "REGIONAL PPO NETWORK" NA NA NA NA "46" ...
#>  @ P41: chr [1:4] "IC" "SUBMITTER CONTACT INFO" "TE" "8001231234"
#>  @ N40: chr [1:9] "40" "2" "CONSERVATIVE INSURANCE" NA NA NA NA "46" ...
#>  @ P40: chr NA
#> 
#> $`837I_EX2_car_accident`
#> <hcc::Detail837>
#>  @ BHT: chr [1:6] "0019" "00" "0324" "20051111" "1800" "CH"
#>  @ N41: chr [1:9] "41" "2" "HALL OF FAME MEMORIAL HOSPITAL" NA NA NA NA "46" ...
#>  @ P41: chr [1:4] "IC" "KATE CASEY" "TE" "7152569877"
#>  @ N40: chr [1:9] "40" "2" "HEISMAN INSURANCE COMPANY" NA NA NA NA "46" ...
#>  @ P40: chr NA
#> 
#> $institutional_claim_837I_223
#> <hcc::Detail837>
#>  @ BHT: chr [1:6] "0019" "00" "0123" "19960918" "0932" "CH"
#>  @ N41: chr [1:9] "41" "2" "JONES HOSPITAL" NA NA NA NA "46" "12345"
#>  @ P41: chr [1:4] "IC" "JANE DOE" "TE" "9005555555"
#>  @ N40: chr [1:9] "40" "2" "MEDICARE" NA NA NA NA "46" "00120"
#>  @ P40: chr NA
#> 
#> $sample_837_1
#> <hcc::Detail837>
#>  @ BHT: chr [1:6] "0019" "00" "241205204217" "20241205" "2042" "CH"
#>  @ N41: chr [1:9] "41" "2" "NATIONAL BIRTH CENTERS INC" NA NA NA NA "XX" ...
#>  @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ N40: chr [1:9] "40" "2" ...
#>  @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#> 
#> $sample_837_10
#> <hcc::Detail837>
#>  @ BHT: chr [1:6] "0019" "00" "241205204222" "20241205" "2042" "CH"
#>  @ N41: chr [1:9] "41" "2" "HSA PORT ARTHUR, LLC" NA NA NA NA "XX" ...
#>  @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ N40: chr [1:9] "40" "2" "OptimaFourSight" NA NA NA NA "XX" "89242VA018"
#>  @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#> 
#> $sample_837_2
#> <hcc::Detail837>
#>  @ BHT: chr [1:6] "0019" "00" "241205204218" "20241205" "2042" "CH"
#>  @ N41: chr [1:9] "41" "2" "COMMUNITY BIRTH GROUP" NA NA NA NA "XX" ...
#>  @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ N40: chr [1:9] "40" "2" "AntidoteGoldSafeGuard0TopRx" NA NA NA NA "XX" ...
#>  @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#> 
#> $sample_837_3
#> <hcc::Detail837>
#>  @ BHT: chr [1:6] "0019" "00" "241205204218" "20241205" "2042" "CH"
#>  @ N41: chr [1:9] "41" "2" "MARYVIEW HOSPITAL LLC" NA NA NA NA "XX" ...
#>  @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ N40: chr [1:9] "40" "2" "MOLINAHEALTHCARE" NA NA NA NA "XX" "64353OH001"
#>  @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#> 
#> $sample_837_4
#> <hcc::Detail837>
#>  @ BHT: chr [1:6] "0019" "00" "241205204219" "20241205" "2042" "CH"
#>  @ N41: chr [1:9] "41" "2" "HSA ST. JOSEPH, LLC" NA NA NA NA "XX" ...
#>  @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ N40: chr [1:9] "40" "2" "HighDeductibleHealthPlanHSA30" NA NA NA NA "XX" ...
#>  @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#> 
#> $sample_837_5
#> <hcc::Detail837>
#>  @ BHT: chr [1:6] "0019" "00" "241205204219" "20241205" "2042" "CH"
#>  @ N41: chr [1:9] "41" "2" "NATIONAL BIRTH CENTERS INC" NA NA NA NA "XX" ...
#>  @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ N40: chr [1:9] "40" "2" "BlanketStudentAccidentandSicknessUnivofWYPlan1" ...
#>  @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#> 
#> $sample_837_6
#> <hcc::Detail837>
#>  @ BHT: chr [1:6] "0019" "00" "241205204220" "20241205" "2042" "CH"
#>  @ N41: chr [1:9] "41" "2" "OKEECHOBEE HOSPITAL, INC." NA NA NA NA "XX" ...
#>  @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ N40: chr [1:9] "40" "2" "EHB2015IPLAELIC" NA NA NA NA "XX" "85570LA014"
#>  @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#> 
#> $sample_837_7
#> <hcc::Detail837>
#>  @ BHT: chr [1:6] "0019" "00" "241205204220" "20241205" "2042" "CH"
#>  @ N41: chr [1:9] "41" "2" "ELMHURST MEMORIAL HOSPITAL" NA NA NA NA "XX" ...
#>  @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ N40: chr [1:9] "40" "2" "HSA2000_10A1" NA NA NA NA "XX" "39424OR071"
#>  @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#> 
#> $sample_837_8
#> <hcc::Detail837>
#>  @ BHT: chr [1:6] "0019" "00" "241205204221" "20241205" "2042" "CH"
#>  @ N41: chr [1:9] "41" "2" "GUTHRIE CORTLAND MEDICAL CENTER" NA NA NA NA "XX" ...
#>  @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ N40: chr [1:9] "40" "2" "SimplyBluePPOwithabortioncoverage" NA NA NA NA ...
#>  @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#> 
#> $sample_837_9
#> <hcc::Detail837>
#>  @ BHT: chr [1:6] "0019" "00" "241205204221" "20241205" "2042" "CH"
#>  @ N41: chr [1:9] "41" "2" "HCA HEALTH SERVICES OF TENNESSEE, INC." NA NA NA ...
#>  @ P41: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#>  @ N40: chr [1:9] "40" "2" "HMOOffExchangeRegion7" NA NA NA NA "XX" ...
#>  @ P40: chr [1:4] "IC" "TEST CONTACT" "TE" "5555550000"
#> 
```
