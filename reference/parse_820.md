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

- `REF*18`: Rate code (e.g., "957" = PACE rate)

- `REF*ZZ`: Aid code/plan type composite and description

- `DTM*582`: Coverage period date range

- `ADX`: Adjustment amount and reason code

Typical loop structure within an 820:

- Header: `ISA` \> `GS` \> `ST` \> `BPR` \> `TRN` \> `N1*PE` \> `N1*PR`

- Per-member: `ENT` \> `NM1` \> (`RMR` \> `REF*18` \> `REF*ZZ` \>
  `REF*ZZ` \> `DTM*582` \> `ADX`)

- Trailer: `SE` \> `GE` \> `IEA`

## Examples

``` r
x12_type <- hcc:::x12_type
unlist_ <- hcc:::unlist_
whichv_ <- collapse::whichv

x = hcc::x12_820[whichv_(x12_type(hcc::x12_820), "820-X218")]
i = purrr::map(x, index_x12)
p = purrr::map(i, parse_820)
p$sample_820_01
#> $ISA
#>  [1] "ISA"        "00"         NA           "00"         NA          
#>  [6] "ZZ"         "TEST-PAYER" "30"         "TEST-PAYEE" "260118"    
#> [11] "0831"       "+"          "00501"      "000058691"  "0"         
#> [16] "P"          ":"         
#> 
#> $GS
#> [1] "GS"         "RA"         "TEST-PAYER" "TEST-PAYEE" "20260118"  
#> [6] "083122"     "43304"      "X"          "005010X218"
#> 
#> $ST
#> [1] "ST"         "820"        "0001"       "005010X218"
#> 
#> $BPR
#>  [1] "BPR"        "I"          "102139.46"  "C"          "NON"       
#>  [6] NA           NA           NA           NA           NA          
#> [11] "68-0317191" NA           NA           NA           NA          
#> [16] NA           "20260115"  
#> 
#> $TRN
#> [1] "TRN"             "3"               "TESTTRN01000001"
#> 
#> $REF14
#> [1] "REF"        "14"         "0000245023"
#> 
#> $N1PE
#> [1] "N1"                      "PE"                     
#> [3] "TEST PAYEE ORGANIZATION"
#> 
#> $N3PE
#> [1] "N3"              "123 TEST STREET"
#> 
#> $N4PE
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $N1PR
#> [1] "N1"                "PR"                "TEST PAYER AGENCY"
#> 
#> $N3PR
#> [1] "N3"              "123 TEST STREET"
#> 
#> $N4PR
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $ENT_1_1
#> [1] "ENT"       "1"         "2J"        "EI"        "999999999"
#> 
#> $ENT_1_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME01"      
#>  [5] "FIRSTNAME01"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000001"
#> 
#> $ENT_1_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $ENT_1_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_1_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_1_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_1_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $ENT_2_1
#> [1] "ENT"       "2"         "2J"        "EI"        "999999999"
#> 
#> $ENT_2_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME02"      
#>  [5] "FIRSTNAME02"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000002"
#> 
#> $ENT_2_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $ENT_2_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_2_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_2_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_2_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $ENT_3_1
#> [1] "ENT"       "3"         "2J"        "EI"        "999999999"
#> 
#> $ENT_3_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME03"      
#>  [5] "FIRSTNAME03"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000003"
#> 
#> $ENT_3_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $ENT_3_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_3_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $ENT_3_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_3_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $ENT_4_1
#> [1] "ENT"       "4"         "2J"        "EI"        "999999999"
#> 
#> $ENT_4_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME04"      
#>  [5] "FIRSTNAME04"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000004"
#> 
#> $ENT_4_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $ENT_4_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_4_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $ENT_4_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_4_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $ENT_5_1
#> [1] "ENT"       "5"         "2J"        "EI"        "999999999"
#> 
#> $ENT_5_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME05"      
#>  [5] "FIRSTNAME05"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000005"
#> 
#> $ENT_5_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $ENT_5_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_5_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $ENT_5_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_5_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $ENT_6_1
#> [1] "ENT"       "6"         "2J"        "EI"        "999999999"
#> 
#> $ENT_6_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME06"      
#>  [5] "FIRSTNAME06"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000006"
#> 
#> $ENT_6_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $ENT_6_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_6_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_6_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_6_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $ENT_7_1
#> [1] "ENT"       "7"         "2J"        "EI"        "999999999"
#> 
#> $ENT_7_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME07"      
#>  [5] "FIRSTNAME07"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000007"
#> 
#> $ENT_7_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $ENT_7_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_7_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $ENT_7_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_7_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $ENT_7_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $ENT_7_9
#> [1] "REF" "18"  "957"
#> 
#> $ENT_7_10
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $ENT_7_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_7_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251101-20251130"
#> 
#> $ENT_8_1
#> [1] "ENT"       "8"         "2J"        "EI"        "999999999"
#> 
#> $ENT_8_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME08"      
#>  [5] "FIRSTNAME08"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000008"
#> 
#> $ENT_8_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $ENT_8_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_8_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_8_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_8_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $ENT_9_1
#> [1] "ENT"       "9"         "2J"        "EI"        "999999999"
#> 
#> $ENT_9_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME09"      
#>  [5] "FIRSTNAME09"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000009"
#> 
#> $ENT_9_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $ENT_9_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_9_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_9_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_9_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $ENT_10_1
#> [1] "ENT"       "10"        "2J"        "EI"        "999999999"
#> 
#> $ENT_10_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME10"      
#>  [5] "FIRSTNAME10"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000010"
#> 
#> $ENT_10_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $ENT_10_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_10_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_10_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_10_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $ENT_11_1
#> [1] "ENT"       "11"        "2J"        "EI"        "999999999"
#> 
#> $ENT_11_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME11"      
#>  [5] "FIRSTNAME11"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000011"
#> 
#> $ENT_11_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $ENT_11_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_11_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $ENT_11_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_11_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $ENT_12_1
#> [1] "ENT"       "12"        "2J"        "EI"        "999999999"
#> 
#> $ENT_12_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME12"      
#>  [5] "FIRSTNAME12"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000012"
#> 
#> $ENT_12_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "5101.10"                       
#> 
#> $ENT_12_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_12_5
#> [1] "REF"  "ZZ"   "17;2"
#> 
#> $ENT_12_6
#> [1] "REF"             "ZZ"              "Dual-State Only"
#> 
#> $ENT_12_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251101-20251130"
#> 
#> $SE
#> [1] "SE"   "100"  "0001"
#> 
#> $GE
#> [1] "GE"    "1"     "43304"
#> 
#> $IEA
#> [1] "IEA"       "1"         "000058691"
#> 
p$sample_820_02
#> $ISA
#>  [1] "ISA"        "00"         NA           "00"         NA          
#>  [6] "ZZ"         "TEST-PAYER" "30"         "TEST-PAYEE" "260316"    
#> [11] "0855"       "+"          "00501"      "000059660"  "0"         
#> [16] "P"          ":"         
#> 
#> $GS
#> [1] "GS"         "RA"         "TEST-PAYER" "TEST-PAYEE" "20260316"  
#> [6] "085500"     "44273"      "X"          "005010X218"
#> 
#> $ST
#> [1] "ST"         "820"        "0001"       "005010X218"
#> 
#> $BPR
#>  [1] "BPR"        "I"          "91977.81"   "C"          "NON"       
#>  [6] NA           NA           NA           NA           NA          
#> [11] "68-0317191" NA           NA           NA           NA          
#> [16] NA           "20260312"  
#> 
#> $TRN
#> [1] "TRN"             "3"               "TESTTRN02000001"
#> 
#> $REF14
#> [1] "REF"        "14"         "0000245023"
#> 
#> $N1PE
#> [1] "N1"                      "PE"                     
#> [3] "TEST PAYEE ORGANIZATION"
#> 
#> $N3PE
#> [1] "N3"              "123 TEST STREET"
#> 
#> $N4PE
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $N1PR
#> [1] "N1"                "PR"                "TEST PAYER AGENCY"
#> 
#> $N3PR
#> [1] "N3"              "123 TEST STREET"
#> 
#> $N4PR
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $ENT_1_1
#> [1] "ENT"       "1"         "2J"        "EI"        "999999999"
#> 
#> $ENT_1_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME01"      
#>  [5] "FIRSTNAME01"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000001"
#> 
#> $ENT_1_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "5555.82"                       
#> 
#> $ENT_1_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_1_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_1_6
#> [1] "REF"             "ZZ"              "Dual-State Only"
#> 
#> $ENT_1_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $ENT_1_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "454.72"                         "5555.82"                       
#> 
#> $ENT_1_9
#> [1] "REF" "18"  "957"
#> 
#> $ENT_1_10
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_1_11
#> [1] "REF"             "ZZ"              "Dual-State Only"
#> 
#> $ENT_1_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $ENT_1_13
#> [1] "ADX"      "-5101.10" "53"      
#> 
#> $ENT_2_1
#> [1] "ENT"       "2"         "2J"        "EI"        "999999999"
#> 
#> $ENT_2_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME02"      
#>  [5] "FIRSTNAME02"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000002"
#> 
#> $ENT_2_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $ENT_2_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_2_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_2_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_2_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $ENT_2_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "401.72"                         "8488.25"                       
#> 
#> $ENT_2_9
#> [1] "REF" "18"  "957"
#> 
#> $ENT_2_10
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_2_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_2_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $ENT_2_13
#> [1] "ADX"      "-8086.53" "53"      
#> 
#> $ENT_3_1
#> [1] "ENT"       "3"         "2J"        "EI"        "999999999"
#> 
#> $ENT_3_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME03"      
#>  [5] "FIRSTNAME03"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000003"
#> 
#> $ENT_3_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $ENT_3_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_3_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $ENT_3_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_3_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $ENT_3_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "401.72"                         "8488.25"                       
#> 
#> $ENT_3_9
#> [1] "REF" "18"  "957"
#> 
#> $ENT_3_10
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $ENT_3_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_3_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $ENT_3_13
#> [1] "ADX"      "-8086.53" "53"      
#> 
#> $ENT_4_1
#> [1] "ENT"       "4"         "2J"        "EI"        "999999999"
#> 
#> $ENT_4_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME13"      
#>  [5] "FIRSTNAME13"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000013"
#> 
#> $ENT_4_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $ENT_4_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_4_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_4_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_4_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $ENT_4_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $ENT_4_9
#> [1] "REF" "18"  "957"
#> 
#> $ENT_4_10
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_4_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_4_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $ENT_5_1
#> [1] "ENT"       "5"         "2J"        "EI"        "999999999"
#> 
#> $ENT_5_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME04"      
#>  [5] "FIRSTNAME04"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000004"
#> 
#> $ENT_5_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $ENT_5_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_5_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $ENT_5_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_5_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $ENT_5_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "401.72"                         "8488.25"                       
#> 
#> $ENT_5_9
#> [1] "REF" "18"  "957"
#> 
#> $ENT_5_10
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $ENT_5_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_5_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $ENT_5_13
#> [1] "ADX"      "-8086.53" "53"      
#> 
#> $ENT_6_1
#> [1] "ENT"       "6"         "2J"        "EI"        "999999999"
#> 
#> $ENT_6_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME05"      
#>  [5] "FIRSTNAME05"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000005"
#> 
#> $ENT_6_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $ENT_6_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_6_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_6_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_6_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $ENT_6_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "401.72"                         "8488.25"                       
#> 
#> $ENT_6_9
#> [1] "REF" "18"  "957"
#> 
#> $ENT_6_10
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $ENT_6_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_6_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $ENT_6_13
#> [1] "ADX"      "-8086.53" "53"      
#> 
#> $ENT_7_1
#> [1] "ENT"       "7"         "2J"        "EI"        "999999999"
#> 
#> $ENT_7_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME06"      
#>  [5] "FIRSTNAME06"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000006"
#> 
#> $ENT_7_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "-8086.53"                      
#> 
#> $ENT_7_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_7_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_7_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_7_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $ENT_8_1
#> [1] "ENT"       "8"         "2J"        "EI"        "999999999"
#> 
#> $ENT_8_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME07"      
#>  [5] "FIRSTNAME07"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000007"
#> 
#> $ENT_8_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $ENT_8_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_8_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $ENT_8_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_8_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $ENT_8_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "401.72"                         "8488.25"                       
#> 
#> $ENT_8_9
#> [1] "REF" "18"  "957"
#> 
#> $ENT_8_10
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $ENT_8_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_8_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $ENT_8_13
#> [1] "ADX"      "-8086.53" "53"      
#> 
#> $ENT_9_1
#> [1] "ENT"       "9"         "2J"        "EI"        "999999999"
#> 
#> $ENT_9_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME08"      
#>  [5] "FIRSTNAME08"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000008"
#> 
#> $ENT_9_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $ENT_9_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_9_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_9_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_9_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $ENT_9_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "401.72"                         "8488.25"                       
#> 
#> $ENT_9_9
#> [1] "REF" "18"  "957"
#> 
#> $ENT_9_10
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_9_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_9_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $ENT_9_13
#> [1] "ADX"      "-8086.53" "53"      
#> 
#> $ENT_10_1
#> [1] "ENT"       "10"        "2J"        "EI"        "999999999"
#> 
#> $ENT_10_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME09"      
#>  [5] "FIRSTNAME09"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000009"
#> 
#> $ENT_10_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $ENT_10_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_10_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_10_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_10_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $ENT_10_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "401.72"                         "8488.25"                       
#> 
#> $ENT_10_9
#> [1] "REF" "18"  "957"
#> 
#> $ENT_10_10
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_10_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_10_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $ENT_10_13
#> [1] "ADX"      "-8086.53" "53"      
#> 
#> $ENT_11_1
#> [1] "ENT"       "11"        "2J"        "EI"        "999999999"
#> 
#> $ENT_11_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME10"      
#>  [5] "FIRSTNAME10"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000010"
#> 
#> $ENT_11_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "401.72"                         "8488.25"                       
#> 
#> $ENT_11_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_11_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $ENT_11_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_11_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $ENT_11_8
#> [1] "ADX"      "-8086.53" "53"      
#> 
#> $ENT_12_1
#> [1] "ENT"       "12"        "2J"        "EI"        "999999999"
#> 
#> $ENT_12_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME11"      
#>  [5] "FIRSTNAME11"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000011"
#> 
#> $ENT_12_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $ENT_12_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_12_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $ENT_12_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_12_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $ENT_12_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "401.72"                         "8488.25"                       
#> 
#> $ENT_12_9
#> [1] "REF" "18"  "957"
#> 
#> $ENT_12_10
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $ENT_12_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $ENT_12_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $ENT_12_13
#> [1] "ADX"      "-8086.53" "53"      
#> 
#> $ENT_13_1
#> [1] "ENT"       "13"        "2J"        "EI"        "999999999"
#> 
#> $ENT_13_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME12"      
#>  [5] "FIRSTNAME12"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000012"
#> 
#> $ENT_13_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "5555.82"                       
#> 
#> $ENT_13_4
#> [1] "REF" "18"  "957"
#> 
#> $ENT_13_5
#> [1] "REF"  "ZZ"   "17;2"
#> 
#> $ENT_13_6
#> [1] "REF"             "ZZ"              "Dual-State Only"
#> 
#> $ENT_13_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $SE
#> [1] "SE"   "162"  "0001"
#> 
#> $GE
#> [1] "GE"    "1"     "44273"
#> 
#> $IEA
#> [1] "IEA"       "1"         "000059660"
#> 
```
