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
edi_parse(x12_EX$`837`[[1]][[1]])
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "HC" "SENDERGS" "RECEIVERGS" "20231106" "140822" ...
#>  .. @ ST : chr [1:3] "837" "987654" "005010X223A2"
#>  @ Details:List of 4
#>  .. $ : chr [1:7] "BHT" "0019" "00" "0123" ...
#>  .. $ : chr [1:10] "NM1" "41" "2" "JONES HOSPITAL" ...
#>  .. $ : chr [1:5] "PER" "IC" "JANE DOE" "TE" ...
#>  .. $ : chr [1:10] "NM1" "40" "2" "MEDICARE" ...
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
edi_parse(x12_EX$`837`[[2]][[1]])
#> <hcc::Parsed837>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" "AUTHORIZAT" "00" "SECURITY I" "ZZ" ...
#>  .. @ GS : chr [1:8] "HC" "00000006" "00000001" "20110705" "113253" ...
#>  .. @ ST : chr [1:3] "837" "0021" "005010X222"
#>  @ Details:List of 4
#>  .. $ : chr [1:7] "BHT" "0019" "00" "244579" ...
#>  .. $ : chr [1:10] "NM1" "41" "2" "PREMIER BILLING SERVICE" ...
#>  .. $ : chr [1:7] "PER" "IC" "JERRY" "TE" ...
#>  .. $ : chr [1:10] "NM1" "40" "2" "KEY INSURANCE COMPANY" ...
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
edi_parse(x12_EX$`834`[[1]])
#> <hcc::Parsed834>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDERNAME" "ZZ" "RECEIVERNAME" ...
#>  .. @ GS : chr [1:8] "BE" "SENDERNAME" "RECEIVERNAME" "20041227" "1324" ...
#>  .. @ ST : chr [1:3] "834" "12345" "005010X220A1"
#>  @ Details: <hcc::Detail834>
#>  .. @ BGN  : chr [1:8] "00" "12456" "19980520" "1200" NA NA NA "2"
#>  .. @ N1P5 : chr [1:3] NA "FI" "999888777"
#>  .. @ N1IN : chr [1:3] NA "FI" "654456654"
#>  .. @ REF38: chr [1:2] "38" "ABCD012354"
#>  .. @ QTY  : chr NA
#>  .. @ DTP  : chr NA
#>  @ Member :List of 5
#>  .. $ :List of 1
#>  ..  ..$ : chr [1:10] "INS" "N" "19" "021" ...
#>  .. $ :List of 3
#>  ..  ..$ : chr [1:3] "REF" "0F" "123456789"
#>  ..  ..$ : chr [1:3] "REF" "1L" "123456001"
#>  ..  ..$ : chr [1:4] "DTP" "351" "D8" "19980515"
#>  .. $ :List of 2
#>  ..  ..$ : chr [1:10] "NM1" "IL" "1" "DOE" ...
#>  ..  ..$ : chr [1:4] "DMG" "D8" "19770816" "M"
#>  .. $ :List of 1
#>  ..  ..$ : chr [1:4] "NM1" "M8" "2" "PENN STATE UNIVERSITY"
#>  .. $ :List of 2
#>  ..  ..$ : chr [1:4] "HD" "021" NA "HLT"
#>  ..  ..$ : chr [1:4] "DTP" "348" "D8" "19960601"
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "15" "12345"
#>  .. @ GE : chr [1:2] "1" "000000103"
#>  .. @ IEA: chr [1:2] "1" "000000103"
edi_parse(x12_EX$`820`[[1]][[1]])
#> <hcc::Parsed820>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "EMEDNYBAT" "ZZ" "ETIN" "141231" ...
#>  .. @ GS : chr [1:8] "RA" "EMEDNYBAT" "ETIN" "20141231" "11595900" ...
#>  .. @ ST : chr [1:3] "820" "222222222" "005010X218"
#>  @ Details: <hcc::Detail218>
#>  .. @ BPR: chr [1:16] "I" "239.6" "C" "ACH" "CCP" "01" "111111111" NA NA ...
#>  .. @ TRN: chr [1:3] "3" "021300000000000" "1141797357"
#>  .. @ REF: chr [1:2] "14" "12345678"
#>  .. @ NPE: chr [1:4] "PE" "MANAGED CARE" "FI" "123456789"
#>  .. @ NPR: chr [1:2] "PR" "CHILD HEALTH PLUS"
#>  @ Entity :List of 2
#>  .. $ :List of 3
#>  ..  ..$ :List of 1
#>  ..  .. ..$ : chr [1:5] "ENT" "1" "2L" "24" ...
#>  ..  ..$ :List of 2
#>  ..  .. ..$ : chr [1:5] "RMR" "1L" "12345678" NA ...
#>  ..  .. ..$ : chr [1:3] "REF" "ZZ" "RECOVERY OF FUNDS"
#>  ..  ..$ :List of 2
#>  ..  .. ..$ : chr [1:5] "RMR" "1L" "12345678" NA ...
#>  ..  .. ..$ : chr [1:3] "REF" "ZZ" "LUMP SUM PAYMENT"
#>  .. $ :List of 2
#>  ..  ..$ :List of 2
#>  ..  .. ..$ : chr [1:5] "ENT" "2" "2J" "EI" ...
#>  ..  .. ..$ : chr [1:10] "NM1" "QE" "1" "LAST NAME" ...
#>  ..  ..$ :List of 5
#>  ..  .. ..$ : chr [1:5] "RMR" "AZ" "12345678" NA ...
#>  ..  .. ..$ : chr [1:3] "REF" "ZZ" "1436500000001230"
#>  ..  .. ..$ : chr [1:3] "REF" "ZZ" "0123456789"
#>  ..  .. ..$ : chr [1:3] "REF" "LU" "01"
#>  ..  .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "17" "222222222"
#>  .. @ GE : chr [1:2] "1" "333333333"
#>  .. @ IEA: chr [1:2] "1" "003333333"
edi_parse(x12_EX$`820`[[2]][[1]])
#> <hcc::Parsed820>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA: chr [1:16] "00" NA "00" NA "ZZ" "SENDER" "ZZ" "RECEIVER" ...
#>  .. @ GS : chr [1:8] "RA" "SENDERGS" "RECEIVERGS" "20240221" "134856" ...
#>  .. @ ST : chr [1:3] "820" "0001" "005010X306"
#>  @ Details: <hcc::Detail306>
#>  .. @ BPR: chr [1:16] "I" "0" "C" "NON" NA NA NA NA NA NA NA NA NA NA NA ...
#>  .. @ TRN: chr [1:2] "3" "123456789123385"
#>  .. @ REF: chr NA
#>  .. @ NPE: chr [1:4] "PE" "NATIONAL EAST" "FI" "121231244"
#>  .. @ NRM: chr [1:4] "RM" "CMS" "58" "CMS"
#>  .. @ PER: chr [1:6] "IC" "EXCHANGE OPERATIONS CENTER" "EM" ...
#>  @ Entity :List of 3
#>  .. $ :List of 6
#>  ..  ..$ :List of 6
#>  ..  .. ..$ : chr [1:2] "ENT" "1"
#>  ..  .. ..$ : chr [1:10] "NM1" "IL" "1" "HOPE" ...
#>  ..  .. ..$ : chr [1:3] "REF" "38" "12345MD000011500"
#>  ..  .. ..$ : chr [1:3] "REF" "POL" "4599"
#>  ..  .. ..$ : chr [1:3] "REF" "AZ" "PLAN2"
#>  ..  .. ..$ : chr [1:3] "REF" "0F" "SUB1234"
#>  ..  ..$ :List of 2
#>  ..  .. ..$ : chr [1:5] "RMR" "ZZ" "APTC" NA ...
#>  ..  .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>  ..  ..$ :List of 2
#>  ..  .. ..$ : chr [1:5] "RMR" "ZZ" "CSR" NA ...
#>  ..  .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>  ..  ..$ :List of 2
#>  ..  .. ..$ : chr [1:5] "RMR" "ZZ" "UF" NA ...
#>  ..  .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>  ..  ..$ :List of 2
#>  ..  .. ..$ : chr [1:5] "RMR" "ZZ" "APTCADJ" NA ...
#>  ..  .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>  ..  ..$ :List of 2
#>  ..  .. ..$ : chr [1:5] "RMR" "ZZ" "APTCADJ" NA ...
#>  ..  .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>  .. $ :List of 4
#>  ..  ..$ :List of 6
#>  ..  .. ..$ : chr [1:2] "ENT" "2"
#>  ..  .. ..$ : chr [1:10] "NM1" "IL" "1" "RENEE" ...
#>  ..  .. ..$ : chr [1:3] "REF" "38" "12346MD000011501"
#>  ..  .. ..$ : chr [1:3] "REF" "POL" "5678"
#>  ..  .. ..$ : chr [1:3] "REF" "AZ" "PLAN4"
#>  ..  .. ..$ : chr [1:3] "REF" "0F" "SUB2348"
#>  ..  ..$ :List of 2
#>  ..  .. ..$ : chr [1:5] "RMR" "ZZ" "APTC" NA ...
#>  ..  .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>  ..  ..$ :List of 2
#>  ..  .. ..$ : chr [1:5] "RMR" "ZZ" "CSR" NA ...
#>  ..  .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>  ..  ..$ :List of 2
#>  ..  .. ..$ : chr [1:5] "RMR" "ZZ" "UF" NA ...
#>  ..  .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>  .. $ :List of 2
#>  ..  ..$ :List of 1
#>  ..  .. ..$ : chr [1:2] "ENT" "3"
#>  ..  ..$ :List of 2
#>  ..  .. ..$ : chr [1:5] "RMR" "ZZ" "BAL" NA ...
#>  ..  .. ..$ : chr [1:7] "DTM" "582" NA NA ...
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE : chr [1:2] "38" "0001"
#>  .. @ GE : chr [1:2] "1" "000000001"
#>  .. @ IEA: chr [1:2] "1" "000000001"
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
```
