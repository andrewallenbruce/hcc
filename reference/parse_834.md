# X12-834 (X220A1) Benefit Enrollment Parser

The 834 carries *membership events*:

- new enrollment (qualifier 021)

- change (001)

- termination (024)

- audit/reconciliation (030)

## Usage

``` r
parse_834(x)
```

## Arguments

- x:

  `<chr>` string of raw X12-834 text

## Value

list

## Details

It transports member demographics, dependents, chosen plan, effective
and end dates, premium amounts, occasionally tax elements and primary
care provider. It is the system of record for membership on the payer
side.

The 834 is heavily used by BPaaS (Benefits Administration as a Service):

- Workday Benefits

- ADP TotalSource

- bswift

- BenefitFocus

- Empyrean

It is also the official pipe between ACA state exchanges / marketplaces
and payers. The Open Enrollment window (November – December) produces
volume spikes that stress overnight batch jobs.

Extracts enrollment and demographic data from 834 transactions with
focus on:

- Risk adjustment fields (dual eligibility, OREC/CREC, SNP, LTI)

- CA DHCS FAME-specific fields

- HCP (Health Care Plan) coverage history

## Examples

``` r
x = purrr::map(hcc::x12_834, index_x12)
purrr::map(x, parse_834)
#> $`834_EX2_add_dependent`
#> $`834_EX2_add_dependent`$ISA
#>  [1] "00"           "00"           "ZZ"           "SENDERNAME"   "ZZ"          
#>  [6] "RECEIVERNAME" "041227"       "1324"         "^"            "00501"       
#> [11] "000000103"    "0"            "P"            ">"           
#> 
#> $`834_EX2_add_dependent`$GS
#> [1] "BE"           "SENDERNAME"   "RECEIVERNAME" "20041227"     "1324"        
#> [6] "000000103"    "X"            "005010X220A1"
#> 
#> $`834_EX2_add_dependent`$ST
#> [1] "834"          "12345"        "005010X220A1"
#> 
#> $`834_EX2_add_dependent`$BGN
#> [1] "00"       "12456"    "19980520" "1200"     "2"       
#> 
#> $`834_EX2_add_dependent`$REF38
#> [1] "38"         "ABCD012354"
#> 
#> $`834_EX2_add_dependent`$N1P5
#> [1] "P5"        "FI"        "999888777"
#> 
#> $`834_EX2_add_dependent`$N1IN
#> [1] "IN"        "FI"        "654456654"
#> 
#> $`834_EX2_add_dependent`$INS_1_1
#>  [1] "INS" "N"   "19"  "021" "28"  "A"   NA    NA    NA    "F"  
#> 
#> $`834_EX2_add_dependent`$INS_1_2
#> [1] "REF"       "0F"        "123456789"
#> 
#> $`834_EX2_add_dependent`$INS_1_3
#> [1] "REF"       "1L"        "123456001"
#> 
#> $`834_EX2_add_dependent`$INS_1_4
#> [1] "DTP"      "351"      "D8"       "19980515"
#> 
#> $`834_EX2_add_dependent`$INS_1_5
#>  [1] "NM1"       "IL"        "1"         "DOE"       "JAMES"     "E"        
#>  [7] NA          NA          "34"        "103229876"
#> 
#> $`834_EX2_add_dependent`$INS_1_6
#> [1] "DMG"      "D8"       "19770816" "M"       
#> 
#> $`834_EX2_add_dependent`$INS_1_7
#> [1] "NM1"                   "M8"                    "2"                    
#> [4] "PENN STATE UNIVERSITY"
#> 
#> $`834_EX2_add_dependent`$INS_1_8
#> [1] "HD"  "021" NA    "HLT"
#> 
#> $`834_EX2_add_dependent`$INS_1_9
#> [1] "DTP"      "348"      "D8"       "19960601"
#> 
#> $`834_EX2_add_dependent`$SE
#> [1] "15"    "12345"
#> 
#> $`834_EX2_add_dependent`$GE
#> [1] "1"         "000000103"
#> 
#> $`834_EX2_add_dependent`$IEA
#> [1] "1"         "000000103"
#> 
#> 
#> $`834_EX3_enroll_employee_mco`
#> $`834_EX3_enroll_employee_mco`$ISA
#>  [1] "00"           "00"           "ZZ"           "SENDERNAME"   "ZZ"          
#>  [6] "RECEIVERNAME" "041227"       "1324"         "^"            "00501"       
#> [11] "000000103"    "0"            "P"            ">"           
#> 
#> $`834_EX3_enroll_employee_mco`$GS
#> [1] "BE"           "SENDERNAME"   "RECEIVERNAME" "20041227"     "1324"        
#> [6] "000000103"    "X"            "005010X220A1"
#> 
#> $`834_EX3_enroll_employee_mco`$ST
#> [1] "834"          "12345"        "005010X220A1"
#> 
#> $`834_EX3_enroll_employee_mco`$BGN
#> [1] "00"       "12456"    "19980520" "1200"     "2"       
#> 
#> $`834_EX3_enroll_employee_mco`$N1P5
#> [1] "P5"        "FI"        "999888777"
#> 
#> $`834_EX3_enroll_employee_mco`$N1IN
#> [1] "IN"        "FI"        "654456654"
#> 
#> $`834_EX3_enroll_employee_mco`$INS_1_1
#> [1] "INS" "Y"   "18"  "021" "20"  "A"   NA    NA    "FT" 
#> 
#> $`834_EX3_enroll_employee_mco`$INS_1_2
#> [1] "REF"       "0F"        "202443307"
#> 
#> $`834_EX3_enroll_employee_mco`$INS_1_3
#> [1] "REF"       "1L"        "123456001"
#> 
#> $`834_EX3_enroll_employee_mco`$INS_1_4
#> [1] "DTP"      "356"      "D8"       "19960112"
#> 
#> $`834_EX3_enroll_employee_mco`$INS_1_5
#>  [1] "NM1"       "IL"        "1"         "SMITH"     "WILLIAM"   NA         
#>  [7] NA          NA          "34"        "202443307"
#> 
#> $`834_EX3_enroll_employee_mco`$INS_1_6
#> [1] "PER"        "IP"         NA           "HP"         "7172343334"
#> [6] "WP"         "7172341240"
#> 
#> $`834_EX3_enroll_employee_mco`$INS_1_7
#> [1] "N3"                    "1715 SOUTHWIND AVENUE"
#> 
#> $`834_EX3_enroll_employee_mco`$INS_1_8
#> [1] "N4"        "ANYTOWN"   "PA"        "171110000"
#> 
#> $`834_EX3_enroll_employee_mco`$INS_1_9
#> [1] "DMG"      "D8"       "19700614" "M"       
#> 
#> $`834_EX3_enroll_employee_mco`$INS_1_10
#> [1] "HD"  "021" NA    "HMO"
#> 
#> $`834_EX3_enroll_employee_mco`$INS_1_11
#> [1] "DTP"      "348"      "D8"       "19960601"
#> 
#> $`834_EX3_enroll_employee_mco`$INS_1_12
#> [1] "LX" "01"
#> 
#> $`834_EX3_enroll_employee_mco`$INS_1_13
#>  [1] "NM1"     "P3"      "1"       "BROWN"   "BERNARD" NA        "DR"     
#>  [8] NA        "SV"      "143766"  "25"     
#> 
#> $`834_EX3_enroll_employee_mco`$SE
#> [1] "18"    "12345"
#> 
#> $`834_EX3_enroll_employee_mco`$GE
#> [1] "1"         "000000103"
#> 
#> $`834_EX3_enroll_employee_mco`$IEA
#> [1] "1"         "000000103"
#> 
#> 
#> $`834_EX4_add_subscriber_coverage`
#> $`834_EX4_add_subscriber_coverage`$ISA
#>  [1] "00"           "00"           "ZZ"           "SENDERNAME"   "ZZ"          
#>  [6] "RECEIVERNAME" "041227"       "1324"         "^"            "00501"       
#> [11] "000000103"    "0"            "P"            ">"           
#> 
#> $`834_EX4_add_subscriber_coverage`$GS
#> [1] "BE"           "SENDERNAME"   "RECEIVERNAME" "20041227"     "1324"        
#> [6] "000000103"    "X"            "005010X220A1"
#> 
#> $`834_EX4_add_subscriber_coverage`$ST
#> [1] "834"          "12345"        "005010X220A1"
#> 
#> $`834_EX4_add_subscriber_coverage`$BGN
#> [1] "00"       "12456"    "20020601" "1200"     "2"       
#> 
#> $`834_EX4_add_subscriber_coverage`$REF38
#> [1] "38"         "ABCD012354"
#> 
#> $`834_EX4_add_subscriber_coverage`$N1P5
#> [1] "P5"        "FI"        "999888777"
#> 
#> $`834_EX4_add_subscriber_coverage`$N1IN
#> [1] "IN"        "FI"        "654456654"
#> 
#> $`834_EX4_add_subscriber_coverage`$INS_1_1
#> [1] "INS" "Y"   "18"  "001" "22"  "A"   NA    NA    "FT" 
#> 
#> $`834_EX4_add_subscriber_coverage`$INS_1_2
#> [1] "REF"       "0F"        "202443307"
#> 
#> $`834_EX4_add_subscriber_coverage`$INS_1_3
#> [1] "REF"       "1L"        "123456001"
#> 
#> $`834_EX4_add_subscriber_coverage`$INS_1_4
#>  [1] "NM1"        "IL"         "1"          "SMITH"      "WILLIAM"   
#>  [6] NA           NA           NA           "ZZ"         "2024433307"
#> 
#> $`834_EX4_add_subscriber_coverage`$INS_1_5
#> [1] "HD"  "021" NA    "DEN"
#> 
#> $`834_EX4_add_subscriber_coverage`$INS_1_6
#> [1] "DTP"      "348"      "D8"       "20020701"
#> 
#> $`834_EX4_add_subscriber_coverage`$SE
#> [1] "12"    "12345"
#> 
#> $`834_EX4_add_subscriber_coverage`$GE
#> [1] "1"         "000000103"
#> 
#> $`834_EX4_add_subscriber_coverage`$IEA
#> [1] "1"         "000000103"
#> 
#> 
#> $`834_EX5_change_subscriber_info`
#> $`834_EX5_change_subscriber_info`$ISA
#>  [1] "00"           "00"           "ZZ"           "SENDERNAME"   "ZZ"          
#>  [6] "RECEIVERNAME" "041227"       "1324"         "^"            "00501"       
#> [11] "000000103"    "0"            "P"            ">"           
#> 
#> $`834_EX5_change_subscriber_info`$GS
#> [1] "BE"           "SENDERNAME"   "RECEIVERNAME" "20041227"     "1324"        
#> [6] "000000103"    "X"            "005010X220A1"
#> 
#> $`834_EX5_change_subscriber_info`$ST
#> [1] "834"          "12345"        "005010X220A1"
#> 
#> $`834_EX5_change_subscriber_info`$BGN
#> [1] "00"       "12456"    "19980520" "1200"     "2"       
#> 
#> $`834_EX5_change_subscriber_info`$N1P5
#> [1] "P5"          "GENERIC INC" "FI"          "000111000"  
#> 
#> $`834_EX5_change_subscriber_info`$N1IN
#> [1] "IN"            "ABC INSURANCE" "FI"            "654456654"    
#> 
#> $`834_EX5_change_subscriber_info`$INS_1_1
#> [1] "INS" "Y"   "18"  "001" "25"  "A"   NA    NA    "FT" 
#> 
#> $`834_EX5_change_subscriber_info`$INS_1_2
#> [1] "REF"       "0F"        "123456789"
#> 
#> $`834_EX5_change_subscriber_info`$INS_1_3
#> [1] "REF"       "1L"        "123456001"
#> 
#> $`834_EX5_change_subscriber_info`$INS_1_4
#>  [1] "NM1"       "IL"        "1"         "DOE"       "JAMES"     "E"        
#>  [7] NA          NA          "34"        "103229876"
#> 
#> $`834_EX5_change_subscriber_info`$INS_1_5
#> [1] "DMG"      "D8"       "19500415" "M"       
#> 
#> $`834_EX5_change_subscriber_info`$INS_1_6
#> [1] "NM1"   "70"    "1"     "DOE"   "JAMES" "E"    
#> 
#> $`834_EX5_change_subscriber_info`$INS_1_7
#> [1] "DMG"      "D8"       "19500416" "M"       
#> 
#> $`834_EX5_change_subscriber_info`$SE
#> [1] "12"    "12345"
#> 
#> $`834_EX5_change_subscriber_info`$GE
#> [1] "1"         "000000103"
#> 
#> $`834_EX5_change_subscriber_info`$IEA
#> [1] "1"         "000000103"
#> 
#> 
#> $`834_EX6_cancel_dependent`
#> $`834_EX6_cancel_dependent`$ISA
#>  [1] "00"           "00"           "ZZ"           "SENDERNAME"   "ZZ"          
#>  [6] "RECEIVERNAME" "041227"       "1324"         "^"            "00501"       
#> [11] "000000103"    "0"            "P"            ">"           
#> 
#> $`834_EX6_cancel_dependent`$GS
#> [1] "BE"           "SENDERNAME"   "RECEIVERNAME" "20041227"     "1324"        
#> [6] "000000103"    "X"            "005010X220A1"
#> 
#> $`834_EX6_cancel_dependent`$ST
#> [1] "834"          "12345"        "005010X220A1"
#> 
#> $`834_EX6_cancel_dependent`$BGN
#> [1] "00"       "12456"    "19980520" "1200"     "2"       
#> 
#> $`834_EX6_cancel_dependent`$REF38
#> [1] "38"         "ABCD012354"
#> 
#> $`834_EX6_cancel_dependent`$N1P5
#> [1] "P5"        "FI"        "999888777"
#> 
#> $`834_EX6_cancel_dependent`$N1IN
#> [1] "IN"        "FI"        "654456654"
#> 
#> $`834_EX6_cancel_dependent`$INS_1_1
#> [1] "INS" "N"   "19"  "024" "07"  "A"  
#> 
#> $`834_EX6_cancel_dependent`$INS_1_2
#> [1] "REF"       "0F"        "123456789"
#> 
#> $`834_EX6_cancel_dependent`$INS_1_3
#> [1] "REF"       "1L"        "123456001"
#> 
#> $`834_EX6_cancel_dependent`$INS_1_4
#> [1] "DTP"      "357"      "D8"       "19960801"
#> 
#> $`834_EX6_cancel_dependent`$INS_1_5
#>  [1] "NM1"       "IL"        "1"         "DOE"       "JAMES"     "E"        
#>  [7] NA          NA          "34"        "103229876"
#> 
#> $`834_EX6_cancel_dependent`$INS_1_6
#> [1] "DMG"      "D8"       "19770816" "M"       
#> 
#> $`834_EX6_cancel_dependent`$SE
#> [1] "12"    "12345"
#> 
#> $`834_EX6_cancel_dependent`$GE
#> [1] "1"         "000000103"
#> 
#> $`834_EX6_cancel_dependent`$IEA
#> [1] "1"         "000000103"
#> 
#> 
#> $`834_EX7_terminate_subscriber_eligibility`
#> $`834_EX7_terminate_subscriber_eligibility`$ISA
#>  [1] "00"           "00"           "ZZ"           "SENDERNAME"   "ZZ"          
#>  [6] "RECEIVERNAME" "041227"       "1324"         "^"            "00501"       
#> [11] "000000103"    "0"            "P"            ">"           
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$GS
#> [1] "BE"           "SENDERNAME"   "RECEIVERNAME" "20041227"     "1324"        
#> [6] "000000103"    "X"            "005010X220A1"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$ST
#> [1] "834"          "12345"        "005010X220A1"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$BGN
#> [1] "00"       "12456"    "19980520" "1200"     "2"       
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$N1P5
#> [1] "P5"        "FI"        "999888777"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$N1IN
#> [1] "IN"        "FI"        "654456654"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$INS_1_1
#> [1] "INS" "Y"   "18"  "024" "08"  "A"   NA    NA    "TE" 
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$INS_1_2
#> [1] "REF"       "0F"        "123456789"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$INS_1_3
#> [1] "REF"       "1L"        "123456001"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$INS_1_4
#> [1] "DTP"      "357"      "D8"       "19961001"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$INS_1_5
#>  [1] "NM1"       "IL"        "1"         "DOE"       "JOHN"      "E"        
#>  [7] NA          NA          "34"        "103229876"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$SE
#> [1] "10"    "12345"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$GE
#> [1] "1"         "000000103"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$IEA
#> [1] "1"         "000000103"
#> 
#> 
#> $`834_EX8_reinstate_employee`
#> $`834_EX8_reinstate_employee`$ISA
#>  [1] "00"           "00"           "ZZ"           "SENDERNAME"   "ZZ"          
#>  [6] "RECEIVERNAME" "041227"       "1324"         "^"            "00501"       
#> [11] "000000103"    "0"            "P"            ">"           
#> 
#> $`834_EX8_reinstate_employee`$GS
#> [1] "BE"           "SENDERNAME"   "RECEIVERNAME" "20041227"     "1324"        
#> [6] "000000103"    "X"            "005010X220A1"
#> 
#> $`834_EX8_reinstate_employee`$ST
#> [1] "834"          "12345"        "005010X220A1"
#> 
#> $`834_EX8_reinstate_employee`$BGN
#> [1] "00"       "12456"    "19980520" "1200"     "2"       
#> 
#> $`834_EX8_reinstate_employee`$REF38
#> [1] "38"         "ABCD012354"
#> 
#> $`834_EX8_reinstate_employee`$N1P5
#> [1] "P5"        "FI"        "999888777"
#> 
#> $`834_EX8_reinstate_employee`$N1IN
#> [1] "IN"        "FI"        "654456654"
#> 
#> $`834_EX8_reinstate_employee`$INS_1_1
#> [1] "INS" "Y"   "18"  "025" "20"  "A"   NA    NA    "FT" 
#> 
#> $`834_EX8_reinstate_employee`$INS_1_2
#> [1] "REF"       "0F"        "123456789"
#> 
#> $`834_EX8_reinstate_employee`$INS_1_3
#> [1] "REF"       "1L"        "123456001"
#> 
#> $`834_EX8_reinstate_employee`$INS_1_4
#> [1] "DTP"      "303"      "D8"       "19961001"
#> 
#> $`834_EX8_reinstate_employee`$INS_1_5
#>  [1] "NM1"       "IL"        "1"         "DOE"       "JOHN"      "E"        
#>  [7] NA          NA          "34"        "103229876"
#> 
#> $`834_EX8_reinstate_employee`$SE
#> [1] "11"    "12345"
#> 
#> $`834_EX8_reinstate_employee`$GE
#> [1] "1"         "000000103"
#> 
#> $`834_EX8_reinstate_employee`$IEA
#> [1] "1"         "000000103"
#> 
#> 
#> $`834_EX9_reinstate_employee_coverage`
#> $`834_EX9_reinstate_employee_coverage`$ISA
#>  [1] "00"           "00"           "ZZ"           "SENDERNAME"   "ZZ"          
#>  [6] "RECEIVERNAME" "041227"       "1324"         "^"            "00501"       
#> [11] "000000103"    "0"            "P"            ">"           
#> 
#> $`834_EX9_reinstate_employee_coverage`$GS
#> [1] "BE"           "SENDERNAME"   "RECEIVERNAME" "20041227"     "1324"        
#> [6] "000000103"    "X"            "005010X220A1"
#> 
#> $`834_EX9_reinstate_employee_coverage`$ST
#> [1] "834"          "12345"        "005010X220A1"
#> 
#> $`834_EX9_reinstate_employee_coverage`$BGN
#> [1] "00"       "12456"    "20020601" "1200"     "2"       
#> 
#> $`834_EX9_reinstate_employee_coverage`$REF38
#> [1] "38"         "ABCD012354"
#> 
#> $`834_EX9_reinstate_employee_coverage`$N1P5
#> [1] "P5"        "FI"        "999888777"
#> 
#> $`834_EX9_reinstate_employee_coverage`$N1IN
#> [1] "IN"        "FI"        "654456654"
#> 
#> $`834_EX9_reinstate_employee_coverage`$INS_1_1
#> [1] "INS" "Y"   "18"  "025" NA    "A"   NA    NA    "FT" 
#> 
#> $`834_EX9_reinstate_employee_coverage`$INS_1_2
#> [1] "REF"       "0F"        "202443307"
#> 
#> $`834_EX9_reinstate_employee_coverage`$INS_1_3
#> [1] "REF"       "1L"        "123456001"
#> 
#> $`834_EX9_reinstate_employee_coverage`$INS_1_4
#>  [1] "NM1"       "IL"        "1"         "SMITH"     "WILLIAM"   NA         
#>  [7] NA          NA          "ZZ"        "202443307"
#> 
#> $`834_EX9_reinstate_employee_coverage`$INS_1_5
#> [1] "HD"  "025" NA    "DEN"
#> 
#> $`834_EX9_reinstate_employee_coverage`$INS_1_6
#> [1] "DTP"      "348"      "D8"       "20020701"
#> 
#> $`834_EX9_reinstate_employee_coverage`$SE
#> [1] "12"    "12345"
#> 
#> $`834_EX9_reinstate_employee_coverage`$GE
#> [1] "1"         "000000103"
#> 
#> $`834_EX9_reinstate_employee_coverage`$IEA
#> [1] "1"         "000000103"
#> 
#> 
#> $sample_834_01
#> $sample_834_01$ISA
#>  [1] "00"         "00"         "ZZ"         "DHCS"       "ZZ"        
#>  [6] "HEALTHPLAN" "250108"     "1430"       "^"          "00501"     
#> [11] "000000001"  "0"          "P"          ":"         
#> 
#> $sample_834_01$GS
#> [1] "BE"           "DHCS"         "HEALTHPLAN"   "20250108"     "1430"        
#> [6] "1"            "X"            "005010X220A1"
#> 
#> $sample_834_01$ST
#> [1] "834"          "0001"         "005010X220A1"
#> 
#> $sample_834_01$BGN
#> [1] "00"       "12345"    "20250108" "1430"     "2"       
#> 
#> $sample_834_01$REF38
#> [1] "38"       "MEDI-CAL"
#> 
#> $sample_834_01$DTP007
#> [1] "007"      "D8"       "20250108"
#> 
#> $sample_834_01$N1P5
#> [1] "P5"              "CALIFORNIA DHCS" "FI"              "953654321"      
#> 
#> $sample_834_01$N1IN
#> [1] "IN"               "HEALTH PLAN NAME" "FI"               "987654321"       
#> 
#> $sample_834_01$INS_1_1
#>  [1] "INS" "Y"   "18"  "021" NA    NA    "FT"  NA    NA    "AC" 
#> 
#> $sample_834_01$INS_1_2
#> [1] "REF"    "0F"     "MBR001"
#> 
#> $sample_834_01$INS_1_3
#> [1] "REF"              "6P"               "TESTMBI000000001"
#> 
#> $sample_834_01$INS_1_4
#> [1] "REF"              "1D"               "TESTMCD000000001"
#> 
#> $sample_834_01$INS_1_5
#> [1] "REF"     "ABB"     "QMBPLUS"
#> 
#> $sample_834_01$INS_1_6
#>  [1] "NM1"              "IL"               "1"                "TESTLAST01"      
#>  [5] "TESTFIRST01"      NA                 NA                 NA                
#>  [9] "MI"               "TESTMBR000000001"
#> 
#> $sample_834_01$INS_1_7
#> [1] "PER"        "IP"         NA           "HP"         "5555550000"
#> 
#> $sample_834_01$INS_1_8
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_834_01$INS_1_9
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_834_01$INS_1_10
#> [1] "DMG"      "D8"       "19000101" "F"       
#> 
#> $sample_834_01$INS_1_11
#> [1] "HD"                       "021"                     
#> [3] NA                         "HLT"                     
#> [5] "MEDICARE ADVANTAGE D-SNP"
#> 
#> $sample_834_01$INS_1_12
#> [1] "DTP"      "348"      "D8"       "20240101"
#> 
#> $sample_834_01$INS_1_13
#> [1] "HD"       "021"      NA         "HLT"      "MEDI-CAL"
#> 
#> $sample_834_01$INS_1_14
#> [1] "DTP"      "348"      "D8"       "20240101"
#> 
#> $sample_834_01$INS_2_1
#>  [1] "INS" "Y"   "18"  "001" NA    NA    "FT"  NA    NA    "AC" 
#> 
#> $sample_834_01$INS_2_2
#> [1] "REF"    "0F"     "MBR002"
#> 
#> $sample_834_01$INS_2_3
#> [1] "REF"              "6P"               "TESTMBI000000002"
#> 
#> $sample_834_01$INS_2_4
#> [1] "REF"              "1D"               "TESTMCD000000002"
#> 
#> $sample_834_01$INS_2_5
#> [1] "REF" "AB"  "4M" 
#> 
#> $sample_834_01$INS_2_6
#>  [1] "NM1"              "IL"               "1"                "TESTLAST02"      
#>  [5] "TESTFIRST02"      NA                 NA                 NA                
#>  [9] "MI"               "TESTMBR000000002"
#> 
#> $sample_834_01$INS_2_7
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_834_01$INS_2_8
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_834_01$INS_2_9
#> [1] "DMG"      "D8"       "19000101" "M"       
#> 
#> $sample_834_01$INS_2_10
#> [1] "HD"              "001"             NA                "HLT"            
#> [5] "MEDICARE PART C"
#> 
#> $sample_834_01$INS_2_11
#> [1] "DTP"      "348"      "D8"       "20230515"
#> 
#> $sample_834_01$INS_2_12
#> [1] "HD"       "001"      NA         "HLT"      "MEDI-CAL"
#> 
#> $sample_834_01$INS_2_13
#> [1] "DTP"      "348"      "D8"       "20240101"
#> 
#> $sample_834_01$INS_3_1
#>  [1] "INS" "Y"   "18"  "024" NA    NA    "FT"  NA    NA    "TE" 
#> 
#> $sample_834_01$INS_3_2
#> [1] "REF"    "0F"     "MBR003"
#> 
#> $sample_834_01$INS_3_3
#> [1] "REF"              "6P"               "TESTMBI000000003"
#> 
#> $sample_834_01$INS_3_4
#> [1] "REF"              "1D"               "TESTMCD000000003"
#> 
#> $sample_834_01$INS_3_5
#> [1] "REF"      "ABB"      "SLMBPLUS"
#> 
#> $sample_834_01$INS_3_6
#>  [1] "NM1"              "IL"               "1"                "TESTLAST03"      
#>  [5] "TESTFIRST03"      NA                 NA                 NA                
#>  [9] "MI"               "TESTMBR000000003"
#> 
#> $sample_834_01$INS_3_7
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_834_01$INS_3_8
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_834_01$INS_3_9
#> [1] "DMG"      "D8"       "19000101" "F"       
#> 
#> $sample_834_01$INS_3_10
#> [1] "HD"              "024"             NA                "HLT"            
#> [5] "MEDICARE PART A"
#> 
#> $sample_834_01$INS_3_11
#> [1] "DTP"      "348"      "D8"       "20220101"
#> 
#> $sample_834_01$INS_3_12
#> [1] "DTP"      "349"      "D8"       "20250228"
#> 
#> $sample_834_01$INS_3_13
#> [1] "HD"       "024"      NA         "HLT"      "MEDI-CAL"
#> 
#> $sample_834_01$INS_3_14
#> [1] "DTP"      "348"      "D8"       "20220101"
#> 
#> $sample_834_01$INS_3_15
#> [1] "DTP"      "349"      "D8"       "20250228"
#> 
#> $sample_834_01$INS_4_1
#>  [1] "INS" "Y"   "18"  "021" NA    NA    "FT"  NA    NA    "AC" 
#> 
#> $sample_834_01$INS_4_2
#> [1] "REF"    "0F"     "MBR004"
#> 
#> $sample_834_01$INS_4_3
#> [1] "REF"              "1D"               "TESTMCD000000004"
#> 
#> $sample_834_01$INS_4_4
#>  [1] "NM1"              "IL"               "1"                "TESTLAST04"      
#>  [5] "TESTFIRST04"      NA                 NA                 NA                
#>  [9] "MI"               "TESTMBR000000004"
#> 
#> $sample_834_01$INS_4_5
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_834_01$INS_4_6
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_834_01$INS_4_7
#> [1] "DMG"      "D8"       "19000101" "M"       
#> 
#> $sample_834_01$INS_4_8
#> [1] "HD"       "021"      NA         "HLT"      "MEDI-CAL"
#> 
#> $sample_834_01$INS_4_9
#> [1] "DTP"      "348"      "D8"       "20250101"
#> 
#> $sample_834_01$INS_5_1
#>  [1] "INS" "Y"   "18"  "021" NA    NA    "FT"  NA    NA    "AC" 
#> 
#> $sample_834_01$INS_5_2
#> [1] "REF"    "0F"     "MBR005"
#> 
#> $sample_834_01$INS_5_3
#> [1] "REF"              "6P"               "TESTMBI000000005"
#> 
#> $sample_834_01$INS_5_4
#>  [1] "NM1"              "IL"               "1"                "TESTLAST05"      
#>  [5] "TESTFIRST05"      NA                 NA                 NA                
#>  [9] "MI"               "TESTMBR000000005"
#> 
#> $sample_834_01$INS_5_5
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_834_01$INS_5_6
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_834_01$INS_5_7
#> [1] "DMG"      "D8"       "19000101" "M"       
#> 
#> $sample_834_01$INS_5_8
#> [1] "HD"              "021"             NA                "HLT"            
#> [5] "MEDICARE PART C"
#> 
#> $sample_834_01$INS_5_9
#> [1] "DTP"      "348"      "D8"       "20250901"
#> 
#> $sample_834_01$SE
#> [1] "68"   "0001"
#> 
#> $sample_834_01$GE
#> [1] "1" "1"
#> 
#> $sample_834_01$IEA
#> [1] "1"         "000000001"
#> 
#> 
#> $sample_834_02
#> $sample_834_02$ISA
#>  [1] "00"              "00"              "ZZ"              "CADHCS_5010_834"
#>  [5] "30"              "999999991"       "250124"          "1927"           
#>  [9] "^"               "00501"           "000000001"       "0"              
#> [13] "P"               ":"              
#> 
#> $sample_834_02$GS
#> [1] "BE"              "CADHCS_5010_834" "999999991"       "20250124"       
#> [5] "192730"          "10000001"        "X"               "005010X220A1"   
#> 
#> $sample_834_02$ST
#> [1] "834"          "0001"         "005010X220A1"
#> 
#> $sample_834_02$BGN
#> [1] "00"                                  "DHCS834-DA-20250124-Sample PACE-001"
#> [3] "20250124"                            "19273000"                           
#> [5] "2"                                  
#> 
#> $sample_834_02$QTY
#> [1] "TO" "1" 
#> 
#> $sample_834_02$N1P5
#> [1] "P5"                                                    
#> [2] "California Department of Health Care Services........."
#> [3] "FI"                                                    
#> [4] "999999990"                                             
#> 
#> $sample_834_02$N1IN
#> [1] "IN"               "Sample PACE Inc." "FI"               "999999991"       
#> 
#> $sample_834_02$INS_1_1
#> [1] "INS" "Y"   "18"  "001" "AI"  "A"   "E"   NA    "AC" 
#> 
#> $sample_834_02$INS_1_2
#> [1] "REF"                 "0F"                  "randomParticipantID"
#> 
#> $sample_834_02$INS_1_3
#> [1] "REF"        "1L"         "randomCIN1"
#> 
#> $sample_834_02$INS_1_4
#> [1] "REF"    "17"     NA       NA       "202501"
#> 
#> $sample_834_02$INS_1_5
#> [1] "REF"      "23"       "4"        "20200101" NA        
#> 
#> $sample_834_02$INS_1_6
#> [1] "REF"            "3H"             "19"             "10"            
#> [5] "randomCaseNum1" NA              
#> 
#> $sample_834_02$INS_1_7
#> [1] "REF" "6O"  NA    "W"   "Y"   NA    "60" 
#> 
#> $sample_834_02$INS_1_8
#>  [1] "REF"   "ZZ"    "01051" "41609" NA      NA      NA      "30451" "41651"
#> [10] NA      NA     
#> 
#> $sample_834_02$INS_1_9
#> [1] "NM1"             "IL"              "1"               "randomLastName" 
#> [5] "randomFirstName" "A"              
#> 
#> $sample_834_02$INS_1_10
#> [1] "PER"         "IP"          NA            "TE"          "randomPhone"
#> 
#> $sample_834_02$INS_1_11
#> [1] "N3"                   "randomStreetAddress1"
#> 
#> $sample_834_02$INS_1_12
#> [1] "N4"             "LOS ANGELES CA" "CA"             "90019"         
#> [5] NA               "CY"             "19"            
#> 
#> $sample_834_02$INS_1_13
#> [1] "DMG"       "D8"        "randomDoB" "F"         NA          "7"        
#> 
#> $sample_834_02$INS_1_14
#> [1] "LUI" "LD"  "SPA" NA    "7"  
#> 
#> $sample_834_02$INS_1_15
#> [1] "HD"  "021" NA    "LTC" "010" "51" 
#> 
#> $sample_834_02$INS_1_16
#> [1] "DTP"      "348"      "D8"       "20250101"
#> 
#> $sample_834_02$INS_1_17
#> [1] "DTP"      "349"      "D8"       "20250131"
#> 
#> $sample_834_02$INS_1_18
#>  [1] "REF" "17"  "N"   NA    NA    NA    NA    NA    NA    NA    NA    NA   
#> [13] NA    NA    NA    "1"  
#> 
#> $sample_834_02$INS_1_19
#> [1] "REF" "9V"  "9"   "9"   "0"  
#> 
#> $sample_834_02$INS_1_20
#> [1] "REF" "CE"  "10"  "401" NA    NA    NA    NA    NA   
#> 
#> $sample_834_02$INS_1_21
#> [1] "REF" "RB"  "10" 
#> 
#> $sample_834_02$INS_1_22
#> [1] "REF" "ZX"  "19" 
#> 
#> $sample_834_02$INS_1_23
#> [1] "REF" "ZZ"  NA    NA    "10" 
#> 
#> $sample_834_02$SE
#> [1] "29"   "0001"
#> 
#> $sample_834_02$GE
#> [1] "1"        "10000001"
#> 
#> $sample_834_02$IEA
#> [1] "1"         "000000001"
#> 
#> 
#> $sample_834_03
#> $sample_834_03$ISA
#>  [1] "00"              "00"              "ZZ"              "CADHCS_5010_834"
#>  [5] "30"              "999999992"       "250812"          "1936"           
#>  [9] "^"               "00501"           "000000002"       "0"              
#> [13] "P"               ":"              
#> 
#> $sample_834_03$GS
#> [1] "BE"              "CADHCS_5010_834" "999999992"       "20250812"       
#> [5] "193641"          "10000002"        "X"               "005010X220A1"   
#> 
#> $sample_834_03$ST
#> [1] "834"          "0001"         "005010X220A1"
#> 
#> $sample_834_03$BGN
#> [1] "00"                                              
#> [2] "DHCS834-DA-20250812-Sample South LA PACE-957-001"
#> [3] "20250812"                                        
#> [4] "19364100"                                        
#> [5] "2"                                               
#> 
#> $sample_834_03$QTY
#> [1] "TO" "1" 
#> 
#> $sample_834_03$N1P5
#> [1] "P5"                                                    
#> [2] "California Department of Health Care Services........."
#> [3] "FI"                                                    
#> [4] "999999990"                                             
#> 
#> $sample_834_03$N1IN
#> [1] "IN"                        "Sample South LA PACE Inc."
#> [3] "FI"                        "999999992"                
#> 
#> $sample_834_03$INS_1_1
#> [1] "INS" "Y"   "18"  "001" "AI"  "A"   "C"   NA    "AC" 
#> 
#> $sample_834_03$INS_1_2
#> [1] "REF"            "0F"             "randomMemberId"
#> 
#> $sample_834_03$INS_1_3
#> [1] "REF"        "1L"         "randomCIN2"
#> 
#> $sample_834_03$INS_1_4
#> [1] "REF"    "17"     NA       NA       "202508"
#> 
#> $sample_834_03$INS_1_5
#> [1] "REF"      "23"       "2"        "20200201" NA         NA        
#> 
#> $sample_834_03$INS_1_6
#> [1] "REF"            "3H"             "19"             "60"            
#> [5] "randomCaseNum2" NA              
#> 
#> $sample_834_03$INS_1_7
#> [1] "REF" "6O"  NA    "W"   "Y"   NA    "08" 
#> 
#> $sample_834_03$INS_1_8
#> [1] "REF"      "DX"       "H9999"    "006"      "20250201" NA         NA        
#> 
#> $sample_834_03$INS_1_9
#> [1] "REF"       "F6"        "randomMbi"
#> 
#> $sample_834_03$INS_1_10
#> [1] "REF"    "QQ"     NA       NA       "202001" "202001"
#> 
#> $sample_834_03$INS_1_11
#>  [1] "REF"   "ZZ"    "95701" NA      NA      NA      NA      "35201" NA     
#> [10] NA      NA     
#> 
#> $sample_834_03$INS_1_12
#> [1] "NM1"             "IL"              "1"               "randomLastName" 
#> [5] "randomFirstName"
#> 
#> $sample_834_03$INS_1_13
#> [1] "PER"         "IP"          NA            "TE"          "randomPhone"
#> 
#> $sample_834_03$INS_1_14
#> [1] "N3"             "randomAddress1"
#> 
#> $sample_834_03$INS_1_15
#> [1] "N4"            "LONG BEACH CA" "CA"            "90813"        
#> [5] NA              "CY"            "19"           
#> 
#> $sample_834_03$INS_1_16
#> [1] "DMG"       "D8"        "randomDoB" "F"         NA          "7"        
#> 
#> $sample_834_03$INS_1_17
#> [1] "LUI" "LD"  "SPA" NA    "7"  
#> 
#> $sample_834_03$INS_1_18
#> [1] "HD"  "021" NA    "LTC" "957" "01" 
#> 
#> $sample_834_03$INS_1_19
#> [1] "DTP"      "348"      "D8"       "20250801"
#> 
#> $sample_834_03$INS_1_20
#> [1] "DTP"      "349"      "D8"       "20250831"
#> 
#> $sample_834_03$INS_1_21
#>  [1] "REF" "17"  "F"   NA    NA    NA    NA    NA    NA    NA    NA    NA   
#> [13] NA    NA    NA    "1"  
#> 
#> $sample_834_03$INS_1_22
#> [1] "REF" "9V"  "2"   "2"   "2"  
#> 
#> $sample_834_03$INS_1_23
#> [1] "REF" "CE"  "60"  "401" "80"  "401" NA    NA    NA   
#> 
#> $sample_834_03$INS_1_24
#> [1] "REF" "RB"  "60" 
#> 
#> $sample_834_03$INS_1_25
#> [1] "REF" "ZX"  "19" 
#> 
#> $sample_834_03$INS_1_26
#> [1] "REF" "ZZ"  NA    NA    "10" 
#> 
#> $sample_834_03$SE
#> [1] "32"   "0001"
#> 
#> $sample_834_03$GE
#> [1] "1"        "10000002"
#> 
#> $sample_834_03$IEA
#> [1] "1"         "000000002"
#> 
#> 
#> $sample_834_04
#> $sample_834_04$ISA
#>  [1] "00"              "00"              "ZZ"              "CADHCS_5010_834"
#>  [5] "30"              "999999992"       "251022"          "2000"           
#>  [9] "^"               "00501"           "000000003"       "0"              
#> [13] "P"               ":"              
#> 
#> $sample_834_04$GS
#> [1] "BE"              "CADHCS_5010_834" "999999992"       "20251022"       
#> [5] "200019"          "10000003"        "X"               "005010X220A1"   
#> 
#> $sample_834_04$ST
#> [1] "834"          "0001"         "005010X220A1"
#> 
#> $sample_834_04$BGN
#> [1] "00"                                              
#> [2] "DHCS834-DA-20251022-Sample South LA PACE-957-001"
#> [3] "20251022"                                        
#> [4] "20001900"                                        
#> [5] "2"                                               
#> 
#> $sample_834_04$QTY
#> [1] "TO" "1" 
#> 
#> $sample_834_04$N1P5
#> [1] "P5"                                                    
#> [2] "California Department of Health Care Services........."
#> [3] "FI"                                                    
#> [4] "999999990"                                             
#> 
#> $sample_834_04$N1IN
#> [1] "IN"                        "Sample South LA PACE Inc."
#> [3] "FI"                        "999999992"                
#> 
#> $sample_834_04$INS_1_1
#> [1] "INS" "Y"   "18"  "001" "AI"  "A"   "C"   NA    "AC" 
#> 
#> $sample_834_04$INS_1_2
#> [1] "REF"            "0F"             "randomMemberId"
#> 
#> $sample_834_04$INS_1_3
#> [1] "REF"        "1L"         "randomCIN3"
#> 
#> $sample_834_04$INS_1_4
#> [1] "REF"    "17"     "202605" NA       "202510"
#> 
#> $sample_834_04$INS_1_5
#> [1] "REF"      "23"       "2"        "20200301" NA         NA        
#> 
#> $sample_834_04$INS_1_6
#> [1] "REF"        "3H"         "19"         "16"         "randomCode"
#> [6] NA           "08"        
#> 
#> $sample_834_04$INS_1_7
#> [1] "REF" "6O"  NA    "A"   "Y"   NA    "29" 
#> 
#> $sample_834_04$INS_1_8
#> [1] "REF"      "DX"       "H9999"    "001"      "20251101" NA         NA        
#> 
#> $sample_834_04$INS_1_9
#> [1] "REF"       "F6"        "randomMbi"
#> 
#> $sample_834_04$INS_1_10
#> [1] "REF"    "QQ"     NA       NA       "202002" "202002"
#> 
#> $sample_834_04$INS_1_11
#>  [1] "REF"   "ZZ"    "95701" NA      NA      NA      NA      "20101" NA     
#> [10] NA      NA     
#> 
#> $sample_834_04$INS_1_12
#> [1] "NM1"             "IL"              "1"               "randomLastName" 
#> [5] "randomFirstName"
#> 
#> $sample_834_04$INS_1_13
#> [1] "PER"         "IP"          NA            "TE"          "randomPhone"
#> 
#> $sample_834_04$INS_1_14
#> [1] "N3"             "randomAddress1"
#> 
#> $sample_834_04$INS_1_15
#> [1] "N4"             "LOS ANGELES CA" "CA"             "90044"         
#> [5] NA               "CY"             "19"            
#> 
#> $sample_834_04$INS_1_16
#> [1] "DMG"         "D8"          "randomDoB"   "F"           NA           
#> [6] ":RET:2054-5"
#> 
#> $sample_834_04$INS_1_17
#> [1] "HD"  "021" NA    "LTC" "957" "01" 
#> 
#> $sample_834_04$INS_1_18
#> [1] "DTP"      "348"      "D8"       "20251001"
#> 
#> $sample_834_04$INS_1_19
#> [1] "DTP"      "349"      "D8"       "20251031"
#> 
#> $sample_834_04$INS_1_20
#> [1] "REF" "17"  "F"   NA    NA    NA    "1"  
#> 
#> $sample_834_04$INS_1_21
#> [1] "REF" "9V"  "3"   "2"   "2"  
#> 
#> $sample_834_04$INS_1_22
#> [1] "REF" "CE"  "16"  "401" "80"  "401" NA    NA    NA   
#> 
#> $sample_834_04$INS_1_23
#> [1] "REF" "RB"  "16" 
#> 
#> $sample_834_04$INS_1_24
#> [1] "REF" "ZX"  "19" 
#> 
#> $sample_834_04$INS_1_25
#> [1] "REF" "ZZ"  NA    NA    "10" 
#> 
#> $sample_834_04$SE
#> [1] "31"   "0001"
#> 
#> $sample_834_04$GE
#> [1] "1"        "10000003"
#> 
#> $sample_834_04$IEA
#> [1] "1"         "000000003"
#> 
#> 
#> $sample_834_05
#> $sample_834_05$ISA
#>  [1] "00"              "00"              "ZZ"              "CADHCS_5010_834"
#>  [5] "30"              "999999992"       "251023"          "1959"           
#>  [9] "^"               "00501"           "000000004"       "0"              
#> [13] "P"               ":"              
#> 
#> $sample_834_05$GS
#> [1] "BE"              "CADHCS_5010_834" "999999992"       "20251023"       
#> [5] "195928"          "10000004"        "X"               "005010X220A1"   
#> 
#> $sample_834_05$ST
#> [1] "834"          "0001"         "005010X220A1"
#> 
#> $sample_834_05$BGN
#> [1] "00"                                              
#> [2] "DHCS834-DA-20251023-Sample South LA PACE-957-001"
#> [3] "20251023"                                        
#> [4] "19592800"                                        
#> [5] "2"                                               
#> 
#> $sample_834_05$QTY
#> [1] "TO" "1" 
#> 
#> $sample_834_05$N1P5
#> [1] "P5"                                                    
#> [2] "California Department of Health Care Services........."
#> [3] "FI"                                                    
#> [4] "999999990"                                             
#> 
#> $sample_834_05$N1IN
#> [1] "IN"                        "Sample South LA PACE Inc."
#> [3] "FI"                        "999999992"                
#> 
#> $sample_834_05$INS_1_1
#> [1] "INS" "Y"   "18"  "001" "AI"  "A"   "C"   NA    "AC" 
#> 
#> $sample_834_05$INS_1_2
#> [1] "REF"            "0F"             "randomMemberId"
#> 
#> $sample_834_05$INS_1_3
#> [1] "REF"        "1L"         "randomCIN4"
#> 
#> $sample_834_05$INS_1_4
#> [1] "REF"    "17"     "202601" NA       "202510"
#> 
#> $sample_834_05$INS_1_5
#> [1] "REF"      "23"       "6"        "20200401" "20200101" NA        
#> 
#> $sample_834_05$INS_1_6
#> [1] "REF"       "3H"        "19"        "17"        "randomId1" NA         
#> [7] "07"       
#> 
#> $sample_834_05$INS_1_7
#> [1] "REF" "6O"  NA    "W"   "Y"   NA    "19" 
#> 
#> $sample_834_05$INS_1_8
#> [1] "REF"      "DX"       "H9999"    "006"      "20230401" NA         NA        
#> 
#> $sample_834_05$INS_1_9
#> [1] "REF"       "F6"        "randomId2"
#> 
#> $sample_834_05$INS_1_10
#> [1] "REF"    "QQ"     NA       NA       "202003" "202003"
#> 
#> $sample_834_05$INS_1_11
#>  [1] "REF"   "ZZ"    "957P4" NA      NA      NA      NA      NA      NA     
#> [10] NA      NA     
#> 
#> $sample_834_05$INS_1_12
#> [1] "NM1"             "IL"              "1"               "randomLastName" 
#> [5] "randomFirstName"
#> 
#> $sample_834_05$INS_1_13
#> [1] "PER"         "IP"          NA            "TE"          "randomPhone"
#> 
#> $sample_834_05$INS_1_14
#> [1] "N3"             "randomAddress1"
#> 
#> $sample_834_05$INS_1_15
#> [1] "N4"            "LONG BEACH CA" "CA"            "90810"        
#> [5] NA              "CY"            "19"           
#> 
#> $sample_834_05$INS_1_16
#> [1] "DMG"         "D8"          "randomDoB"   "F"           NA           
#> [6] ":RET:2135-2"
#> 
#> $sample_834_05$INS_1_17
#> [1] "HD"  "001" NA    "LTC" "957" "P4" 
#> 
#> $sample_834_05$INS_1_18
#> [1] "DTP"      "348"      "D8"       "20251001"
#> 
#> $sample_834_05$INS_1_19
#> [1] "DTP"      "349"      "D8"       "20250930"
#> 
#> $sample_834_05$INS_1_20
#> [1] "AMT"  "R"    "1237"
#> 
#> $sample_834_05$INS_1_21
#> [1] "REF" "17"  "F"   NA    NA    NA    "1"  
#> 
#> $sample_834_05$INS_1_22
#> [1] "REF" "9V"  "3"   "1"   "0"  
#> 
#> $sample_834_05$INS_1_23
#> [1] "REF" "CE"  "17"  "501" "2K"  "691" NA    NA    NA   
#> 
#> $sample_834_05$INS_1_24
#> [1] "REF" "ZX"  "19" 
#> 
#> $sample_834_05$INS_1_25
#> [1] "REF" "ZZ"  NA    NA    "10" 
#> 
#> $sample_834_05$SE
#> [1] "31"   "0001"
#> 
#> $sample_834_05$GE
#> [1] "1"        "10000004"
#> 
#> $sample_834_05$IEA
#> [1] "1"         "000000004"
#> 
#> 
#> $sample_834_06
#> $sample_834_06$ISA
#>  [1] "00"              "00"              "ZZ"              "CADHCS_5010_834"
#>  [5] "30"              "999999991"       "250206"          "2008"           
#>  [9] "^"               "00501"           "000000005"       "0"              
#> [13] "P"               ":"              
#> 
#> $sample_834_06$GS
#> [1] "BE"              "CADHCS_5010_834" "999999991"       "20250206"       
#> [5] "200823"          "10000005"        "X"               "005010X220A1"   
#> 
#> $sample_834_06$ST
#> [1] "834"          "0001"         "005010X220A1"
#> 
#> $sample_834_06$BGN
#> [1] "00"                                  "DHCS834-DA-20250206-Sample PACE-001"
#> [3] "20250206"                            "20082300"                           
#> [5] "2"                                  
#> 
#> $sample_834_06$QTY
#> [1] "TO" "2" 
#> 
#> $sample_834_06$N1P5
#> [1] "P5"                                                    
#> [2] "California Department of Health Care Services........."
#> [3] "FI"                                                    
#> [4] "999999990"                                             
#> 
#> $sample_834_06$N1IN
#> [1] "IN"               "Sample PACE Inc." "FI"               "999999991"       
#> 
#> $sample_834_06$INS_1_1
#> [1] "INS" "Y"   "18"  "001" "AI"  "A"   "E"   NA    "AC" 
#> 
#> $sample_834_06$INS_1_2
#> [1] "REF"            "0F"             "randomMemberId"
#> 
#> $sample_834_06$INS_1_3
#> [1] "REF"        "1L"         "randomCIN5"
#> 
#> $sample_834_06$INS_1_4
#> [1] "REF"    "17"     NA       NA       "202502"
#> 
#> $sample_834_06$INS_1_5
#> [1] "REF"      "23"       "3"        "20200501" NA        
#> 
#> $sample_834_06$INS_1_6
#> [1] "REF"            "3H"             "19"             "60"            
#> [5] "randomCaseNum1" NA              
#> 
#> $sample_834_06$INS_1_7
#> [1] "REF" "6O"  NA    "A"   "Y"   "D"   "67" 
#> 
#> $sample_834_06$INS_1_8
#> [1] "REF"              "Q4"               "randomProviderId"
#> 
#> $sample_834_06$INS_1_9
#>  [1] "REF"   "ZZ"    "01059" NA      NA      NA      NA      "010S1" NA     
#> [10] NA      NA     
#> 
#> $sample_834_06$INS_1_10
#> [1] "NM1"          "IL"           "1"            "randomLName1" "randomFName1"
#> 
#> $sample_834_06$INS_1_11
#> [1] "PER"          "IP"           NA             "TE"           "randomPhone1"
#> 
#> $sample_834_06$INS_1_12
#> [1] "N3"                 "randomFullAddress1"
#> 
#> $sample_834_06$INS_1_13
#> [1] "N4"             "LOS ANGELES CA" "CA"             "90037"         
#> [5] NA               "CY"             "19"            
#> 
#> $sample_834_06$INS_1_14
#> [1] "DMG"         "D8"          "randomDoB1"  "F"           NA           
#> [6] ":RET:2054-5"
#> 
#> $sample_834_06$INS_1_15
#> [1] "NM1" "31"  "1"  
#> 
#> $sample_834_06$INS_1_16
#> [1] "N3"            "randomAddress"
#> 
#> $sample_834_06$INS_1_17
#> [1] "N4"             "LOS ANGELES CA" "CA"             "90037"         
#> 
#> $sample_834_06$INS_1_18
#> [1] "HD"  "001" NA    "LTC" "010" "59" 
#> 
#> $sample_834_06$INS_1_19
#> [1] "DTP"      "348"      "D8"       "20250201"
#> 
#> $sample_834_06$INS_1_20
#> [1] "DTP"      "349"      "D8"       "20250131"
#> 
#> $sample_834_06$INS_1_21
#>  [1] "REF" "17"  "N"   NA    NA    NA    NA    NA    NA    NA    NA    NA   
#> [13] NA    NA    NA    "1"  
#> 
#> $sample_834_06$INS_1_22
#> [1] "REF" "CE"  "60"  "001" "80"  "891" NA    NA    NA   
#> 
#> $sample_834_06$INS_1_23
#> [1] "REF" "RB"  "60" 
#> 
#> $sample_834_06$INS_1_24
#> [1] "REF" "ZX"  "19" 
#> 
#> $sample_834_06$INS_1_25
#> [1] "REF" "ZZ"  NA    NA    "10" 
#> 
#> $sample_834_06$INS_1_26
#> [1] "HD"  "021" NA    "LTC" "010" "S1" 
#> 
#> $sample_834_06$INS_1_27
#> [1] "DTP"      "348"      "D8"       "20250101"
#> 
#> $sample_834_06$INS_1_28
#> [1] "DTP"      "349"      "D8"       "20250131"
#> 
#> $sample_834_06$INS_1_29
#>  [1] "REF" "17"  "N"   NA    NA    NA    NA    NA    NA    NA    NA    NA   
#> [13] NA    NA    NA    "1"  
#> 
#> $sample_834_06$INS_1_30
#> [1] "REF" "CE"  "60"  "401" "80"  "891" NA    NA    NA   
#> 
#> $sample_834_06$INS_1_31
#> [1] "REF" "RB"  "60" 
#> 
#> $sample_834_06$INS_1_32
#> [1] "REF" "ZX"  "19" 
#> 
#> $sample_834_06$INS_1_33
#> [1] "REF" "ZZ"  NA    NA    "11" 
#> 
#> $sample_834_06$INS_2_1
#> [1] "INS" "Y"   "18"  "001" "AI"  "A"   "C"   NA    "AC" 
#> 
#> $sample_834_06$INS_2_2
#> [1] "REF"             "0F"              "randomMemberId2"
#> 
#> $sample_834_06$INS_2_3
#> [1] "REF"        "1L"         "randomCIN6"
#> 
#> $sample_834_06$INS_2_4
#> [1] "REF"    "17"     NA       NA       "202502"
#> 
#> $sample_834_06$INS_2_5
#> [1] "REF"      "23"       "9"        "20200601" NA        
#> 
#> $sample_834_06$INS_2_6
#> [1] "REF"            "3H"             "19"             "10"            
#> [5] "randomCaseNum2" NA              
#> 
#> $sample_834_06$INS_2_7
#> [1] "REF" "6O"  NA    "A"   "Y"   NA    "25" 
#> 
#> $sample_834_06$INS_2_8
#> [1] "REF"      "DX"       NA         NA         NA         "S5617"    "D635"    
#> [8] "20240901"
#> 
#> $sample_834_06$INS_2_9
#> [1] "REF"       "F6"        "randomId1"
#> 
#> $sample_834_06$INS_2_10
#> [1] "REF"    "QQ"     NA       NA       "202004" "202004"
#> 
#> $sample_834_06$INS_2_11
#>  [1] "REF"   "ZZ"    "01001" NA      NA      NA      NA      "30401" NA     
#> [10] NA      NA     
#> 
#> $sample_834_06$INS_2_12
#> [1] "NM1"          "IL"           "1"            "randomLName2" "randomFName2"
#> [6] "M"           
#> 
#> $sample_834_06$INS_2_13
#> [1] "PER"          "IP"           NA             "TE"           "randomPhone2"
#> 
#> $sample_834_06$INS_2_14
#> [1] "N3"             "randomAddress2"
#> 
#> $sample_834_06$INS_2_15
#> [1] "N4"             "LOS ANGELES CA" "CA"             "90029"         
#> [5] NA               "CY"             "19"            
#> 
#> $sample_834_06$INS_2_16
#> [1] "DMG"         "D8"          "randomDoB2"  "M"           NA           
#> [6] ":RET:2135-2"
#> 
#> $sample_834_06$INS_2_17
#> [1] "HD"  "021" NA    "LTC" "010" "01" 
#> 
#> $sample_834_06$INS_2_18
#> [1] "DTP"      "348"      "D8"       "20250201"
#> 
#> $sample_834_06$INS_2_19
#> [1] "DTP"      "349"      "D8"       "20250228"
#> 
#> $sample_834_06$INS_2_20
#>  [1] "REF" "17"  "D"   NA    NA    NA    NA    NA    NA    NA    NA    NA   
#> [13] NA    NA    NA    "1"  
#> 
#> $sample_834_06$INS_2_21
#> [1] "REF" "9V"  "2"   "2"   "2"  
#> 
#> $sample_834_06$INS_2_22
#> [1] "REF" "CE"  "10"  "401" "9G"  "999" "80"  "401" NA   
#> 
#> $sample_834_06$INS_2_23
#> [1] "REF" "RB"  "10" 
#> 
#> $sample_834_06$INS_2_24
#> [1] "REF" "ZX"  "19" 
#> 
#> $sample_834_06$INS_2_25
#> [1] "REF" "ZZ"  NA    NA    "10" 
#> 
#> $sample_834_06$SE
#> [1] "64"   "0001"
#> 
#> $sample_834_06$GE
#> [1] "1"        "10000005"
#> 
#> $sample_834_06$IEA
#> [1] "1"         "000000005"
#> 
#> 
```
