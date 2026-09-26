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
idx = purrr::map(hcc::x12_834, index_x12)
purrr::map(idx[c(1L, 14L)], parse_834)
#> $`834_EX2_add_dependent`
#> $`834_EX2_add_dependent`$ISA
#>  [1] "ISA"          "00"           NA             "00"           NA            
#>  [6] "ZZ"           "SENDERNAME"   "ZZ"           "RECEIVERNAME" "041227"      
#> [11] "1324"         "^"            "00501"        "000000103"    "0"           
#> [16] "P"            ">"           
#> 
#> $`834_EX2_add_dependent`$GS
#> [1] "GS"           "BE"           "SENDERNAME"   "RECEIVERNAME" "20041227"    
#> [6] "1324"         "000000103"    "X"            "005010X220A1"
#> 
#> $`834_EX2_add_dependent`$ST
#> [1] "ST"           "834"          "12345"        "005010X220A1"
#> 
#> $`834_EX2_add_dependent`$BGN
#> [1] "BGN"      "00"       "12456"    "19980520" "1200"     NA         NA        
#> [8] NA         "2"       
#> 
#> $`834_EX2_add_dependent`$REF38
#> [1] "REF"        "38"         "ABCD012354"
#> 
#> $`834_EX2_add_dependent`$BGN00
#> [1] "BGN"      "00"       "12456"    "19980520" "1200"     NA         NA        
#> [8] NA         "2"       
#> 
#> $`834_EX2_add_dependent`$ST834
#> [1] "ST"           "834"          "12345"        "005010X220A1"
#> 
#> $`834_EX2_add_dependent`$GSBE
#> [1] "GS"           "BE"           "SENDERNAME"   "RECEIVERNAME" "20041227"    
#> [6] "1324"         "000000103"    "X"            "005010X220A1"
#> 
#> $`834_EX2_add_dependent`$ISA00
#>  [1] "ISA"             "00"              "          "      "00"             
#>  [5] "          "      "ZZ"              "SENDERNAME     " "ZZ"             
#>  [9] "RECEIVERNAME   " "041227"          "1324"            "^"              
#> [13] "00501"           "000000103"       "0"               "P"              
#> [17] ">"              
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
#> [1] "SE"    "15"    "12345"
#> 
#> $`834_EX2_add_dependent`$GE
#> [1] "GE"        "1"         "000000103"
#> 
#> $`834_EX2_add_dependent`$IEA
#> [1] "IEA"       "1"         "000000103"
#> 
#> 
#> $sample_834_06
#> $sample_834_06$ISA
#>  [1] "ISA"             "00"              NA                "00"             
#>  [5] NA                "ZZ"              "CADHCS_5010_834" "30"             
#>  [9] "999999991"       "250206"          "2008"            "^"              
#> [13] "00501"           "000000005"       "0"               "P"              
#> [17] ":"              
#> 
#> $sample_834_06$GS
#> [1] "GS"              "BE"              "CADHCS_5010_834" "999999991"      
#> [5] "20250206"        "200823"          "10000005"        "X"              
#> [9] "005010X220A1"   
#> 
#> $sample_834_06$ST
#> [1] "ST"           "834"          "0001"         "005010X220A1"
#> 
#> $sample_834_06$BGN
#> [1] "BGN"                                 "00"                                 
#> [3] "DHCS834-DA-20250206-Sample PACE-001" "20250206"                           
#> [5] "20082300"                            NA                                   
#> [7] NA                                    NA                                   
#> [9] "2"                                  
#> 
#> $sample_834_06$QTYTO
#> [1] "QTY" "TO"  "2"  
#> 
#> $sample_834_06$BGN00
#> [1] "BGN"                                 "00"                                 
#> [3] "DHCS834-DA-20250206-Sample PACE-001" "20250206"                           
#> [5] "20082300"                            NA                                   
#> [7] NA                                    NA                                   
#> [9] "2"                                  
#> 
#> $sample_834_06$ST834
#> [1] "ST"           "834"          "0001"         "005010X220A1"
#> 
#> $sample_834_06$GSBE
#> [1] "GS"              "BE"              "CADHCS_5010_834" "999999991"      
#> [5] "20250206"        "200823"          "10000005"        "X"              
#> [9] "005010X220A1"   
#> 
#> $sample_834_06$ISA00
#>  [1] "ISA"             "00"              "          "      "00"             
#>  [5] "          "      "ZZ"              "CADHCS_5010_834" "30"             
#>  [9] "999999991      " "250206"          "2008"            "^"              
#> [13] "00501"           "000000005"       "0"               "P"              
#> [17] ":"              
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
#> [1] "SE"   "64"   "0001"
#> 
#> $sample_834_06$GE
#> [1] "GE"       "1"        "10000005"
#> 
#> $sample_834_06$IEA
#> [1] "IEA"       "1"         "000000005"
#> 
#> 
```
