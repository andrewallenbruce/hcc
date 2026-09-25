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
idx = purrr::map(hcc::x12_820, index_x12)
purrr::map(idx[c(10:11, 16L)], parse_820)
#> $`820_EX7_aptc_adjustments2`
#> $`820_EX7_aptc_adjustments2`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "240221"    "1343"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`820_EX7_aptc_adjustments2`$GS
#> [1] "GS"         "RA"         "SENDERGS"   "RECEIVERGS" "20240221"  
#> [6] "134329"     "000000001"  "X"          "005010X306"
#> 
#> $`820_EX7_aptc_adjustments2`$ST
#> [1] "ST"         "820"        "0002"       "005010X306"
#> 
#> $`820_EX7_aptc_adjustments2`$BPR
#>  [1] "BPR"          "I"            "910"          "C"            "ACH"         
#>  [6] "CCP"          NA             NA             NA             NA            
#> [11] NA             NA             "01"           "000000001"    "DA"          
#> [16] "123456772123" "20140228"    
#> 
#> $`820_EX7_aptc_adjustments2`$N1PE
#> [1] "N1"        "PE"        "NATIONAL"  "FI"        "121231233"
#> 
#> $`820_EX7_aptc_adjustments2`$N1RM
#> [1] "N1"  "RM"  "CMS" "58"  "CMS"
#> 
#> $`820_EX7_aptc_adjustments2`$PERIC
#> [1] "PER"                        "IC"                        
#> [3] "EXCHANGE OPERATIONS CENTER" "EM"                        
#> [5] "CMS_FEPS@cms.hhs.gov"       "TE"                        
#> [7] "8002671515"                
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_1_1
#> [1] "ENT" "1"  
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_1_2
#>  [1] "NM1"    "IL"     "1"      "SMITH"  "JANE"   NA       NA       NA      
#>  [9] "C1"     "777222"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_1_3
#> [1] "REF"              "38"               "12345MD000011221"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_1_4
#> [1] "REF"  "POL"  "4567"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_1_5
#> [1] "REF"   "AZ"    "PLAN1"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_1_6
#> [1] "REF"    "0F"     "SUB123"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_1_7
#> [1] "RMR"  "ZZ"   "APTC" NA     "500" 
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_1_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_1_9
#> [1] "RMR" "ZZ"  "CSR" NA    "100"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_1_10
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_1_11
#> [1] "RMR" "ZZ"  "UF"  NA    "-25"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_1_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_1_13
#> [1] "RMR"     "ZZ"      "APTCADJ" NA        "-600"   
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_1_14
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_1_15
#> [1] "RMR"     "ZZ"      "APTCADJ" NA        "500"    
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_1_16
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_2_1
#> [1] "ENT" "2"  
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_2_2
#>  [1] "NM1"    "IL"     "1"      "DOE"    "JOHN"   NA       NA       NA      
#>  [9] "C1"     "777223"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_2_3
#> [1] "REF"              "38"               "12346MD000011232"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_2_4
#> [1] "REF"  "POL"  "5678"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_2_5
#> [1] "REF"   "AZ"    "PLAN2"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_2_6
#> [1] "REF"    "0F"     "SUB234"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_2_7
#> [1] "RMR"  "ZZ"   "APTC" NA     "400" 
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_2_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_2_9
#> [1] "RMR" "ZZ"  "CSR" NA    "50" 
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_2_10
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_2_11
#> [1] "RMR" "ZZ"  "UF"  NA    "-15"
#> 
#> $`820_EX7_aptc_adjustments2`$ENT_2_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX7_aptc_adjustments2`$SE
#> [1] "SE"   "35"   "0002"
#> 
#> $`820_EX7_aptc_adjustments2`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`820_EX7_aptc_adjustments2`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`820_EX8_outstanding_debt_owed1`
#> $`820_EX8_outstanding_debt_owed1`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "240221"    "1345"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`820_EX8_outstanding_debt_owed1`$GS
#> [1] "GS"         "RA"         "SENDERGS"   "RECEIVERGS" "20240221"  
#> [6] "134520"     "000000001"  "X"          "005010X306"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ST
#> [1] "ST"         "820"        "0001"       "005010X306"
#> 
#> $`820_EX8_outstanding_debt_owed1`$BPR
#>  [1] "BPR"      "I"        "0"        "C"        "NON"      NA        
#>  [7] NA         NA         NA         NA         NA         NA        
#> [13] NA         NA         NA         NA         "20140210"
#> 
#> $`820_EX8_outstanding_debt_owed1`$N1PE
#> [1] "N1"        "PE"        "NATIONAL"  "FI"        "121231233"
#> 
#> $`820_EX8_outstanding_debt_owed1`$N1RM
#> [1] "N1"  "RM"  "CMS" "58"  "CMS"
#> 
#> $`820_EX8_outstanding_debt_owed1`$PERIC
#> [1] "PER"                        "IC"                        
#> [3] "EXCHANGE OPERATIONS CENTER" "EM"                        
#> [5] "CMS_FEPS@cms.hhs.gov"       "TE"                        
#> [7] "8002671515"                
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_1_1
#> [1] "ENT" "1"  
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_1_2
#>  [1] "NM1"    "IL"     "1"      "SMITH"  "JANE"   NA       NA       NA      
#>  [9] "C1"     "777222"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_1_3
#> [1] "REF"              "38"               "12345MD000011221"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_1_4
#> [1] "REF"  "POL"  "4567"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_1_5
#> [1] "REF"   "AZ"    "PLAN1"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_1_6
#> [1] "REF"    "0F"     "SUB123"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_1_7
#> [1] "RMR"  "ZZ"   "APTC" NA     "600" 
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_1_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_1_9
#> [1] "RMR" "ZZ"  "CSR" NA    "100"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_1_10
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_1_11
#> [1] "RMR" "ZZ"  "UF"  NA    "-25"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_1_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_2_1
#> [1] "ENT" "2"  
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_2_2
#>  [1] "NM1"    "IL"     "1"      "DOE"    "JOHN"   NA       NA       NA      
#>  [9] "C1"     "777223"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_2_3
#> [1] "REF"              "38"               "12346MD000011232"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_2_4
#> [1] "REF"  "POL"  "5678"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_2_5
#> [1] "REF"   "AZ"    "PLAN2"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_2_6
#> [1] "REF"    "0F"     "SUB234"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_2_7
#> [1] "RMR"  "ZZ"   "APTC" NA     "400" 
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_2_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_2_9
#> [1] "RMR" "ZZ"  "CSR" NA    "50" 
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_2_10
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_2_11
#> [1] "RMR" "ZZ"  "UF"  NA    "-1" 
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_2_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_3_1
#> [1] "ENT" "3"  
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_3_2
#> [1] "RMR"   "ZZ"    "BAL"   NA      "-1100"
#> 
#> $`820_EX8_outstanding_debt_owed1`$ENT_3_3
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX8_outstanding_debt_owed1`$SE
#> [1] "SE"   "34"   "0001"
#> 
#> $`820_EX8_outstanding_debt_owed1`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`820_EX8_outstanding_debt_owed1`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $sample_820_04
#> $sample_820_04$ISA
#>  [1] "ISA"        "00"         NA           "00"         NA          
#>  [6] "ZZ"         "TEST-PAYER" "30"         "TEST-PAYEE" "251217"    
#> [11] "2316"       "+"          "00501"      "000058142"  "0"         
#> [16] "P"          ":"         
#> 
#> $sample_820_04$GS
#> [1] "GS"         "RA"         "TEST-PAYER" "TEST-PAYEE" "20251217"  
#> [6] "231624"     "42755"      "X"          "005010X218"
#> 
#> $sample_820_04$ST
#> [1] "ST"         "820"        "0001"       "005010X218"
#> 
#> $sample_820_04$BPR
#>  [1] "BPR"        "I"          "80865.30"   "C"          "NON"       
#>  [6] NA           NA           NA           NA           NA          
#> [11] "68-0317191" NA           NA           NA           NA          
#> [16] NA           "20251216"  
#> 
#> $sample_820_04$TRN
#> [1] "TRN"             "3"               "TESTTRN04000001"
#> 
#> $sample_820_04$REF14
#> [1] "REF"        "14"         "0000245023"
#> 
#> $sample_820_04$N1PE
#> [1] "N1"                      "PE"                     
#> [3] "TEST PAYEE ORGANIZATION"
#> 
#> $sample_820_04$N3PE
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_820_04$N4PE
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_820_04$N1PR
#> [1] "N1"                "PR"                "TEST PAYER AGENCY"
#> 
#> $sample_820_04$N3PR
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_820_04$N4PR
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_820_04$ENT_1_1
#> [1] "ENT"       "1"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_04$ENT_1_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME01"      
#>  [5] "FIRSTNAME01"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000001"
#> 
#> $sample_820_04$ENT_1_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2511190148000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_04$ENT_1_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_04$ENT_1_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_04$ENT_1_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_04$ENT_1_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251101-20251130"
#> 
#> $sample_820_04$ENT_2_1
#> [1] "ENT"       "2"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_04$ENT_2_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME02"      
#>  [5] "FIRSTNAME02"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000002"
#> 
#> $sample_820_04$ENT_2_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2511190148000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_04$ENT_2_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_04$ENT_2_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_04$ENT_2_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_04$ENT_2_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251101-20251130"
#> 
#> $sample_820_04$ENT_2_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2511190148000P" NA                              
#> [5] "-5101.10"                      
#> 
#> $sample_820_04$ENT_2_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_04$ENT_2_10
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_04$ENT_2_11
#> [1] "REF"             "ZZ"              "Dual-State Only"
#> 
#> $sample_820_04$ENT_2_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251001-20251031"
#> 
#> $sample_820_04$ENT_2_13
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2511190148000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_04$ENT_2_14
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_04$ENT_2_15
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_04$ENT_2_16
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_04$ENT_2_17
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251001-20251031"
#> 
#> $sample_820_04$ENT_3_1
#> [1] "ENT"       "3"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_04$ENT_3_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME03"      
#>  [5] "FIRSTNAME03"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000003"
#> 
#> $sample_820_04$ENT_3_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2511190148000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_04$ENT_3_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_04$ENT_3_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_04$ENT_3_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_04$ENT_3_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251101-20251130"
#> 
#> $sample_820_04$ENT_4_1
#> [1] "ENT"       "4"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_04$ENT_4_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME05"      
#>  [5] "FIRSTNAME05"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000005"
#> 
#> $sample_820_04$ENT_4_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2511190148000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_04$ENT_4_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_04$ENT_4_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_04$ENT_4_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_04$ENT_4_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251101-20251130"
#> 
#> $sample_820_04$ENT_5_1
#> [1] "ENT"       "5"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_04$ENT_5_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME06"      
#>  [5] "FIRSTNAME06"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000006"
#> 
#> $sample_820_04$ENT_5_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2511190148000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_04$ENT_5_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_04$ENT_5_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_04$ENT_5_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_04$ENT_5_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251101-20251130"
#> 
#> $sample_820_04$ENT_6_1
#> [1] "ENT"       "6"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_04$ENT_6_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME08"      
#>  [5] "FIRSTNAME08"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000008"
#> 
#> $sample_820_04$ENT_6_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2511190148000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_04$ENT_6_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_04$ENT_6_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_04$ENT_6_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_04$ENT_6_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251101-20251130"
#> 
#> $sample_820_04$ENT_7_1
#> [1] "ENT"       "7"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_04$ENT_7_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME09"      
#>  [5] "FIRSTNAME09"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000009"
#> 
#> $sample_820_04$ENT_7_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2511190148000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_04$ENT_7_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_04$ENT_7_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_04$ENT_7_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_04$ENT_7_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251101-20251130"
#> 
#> $sample_820_04$ENT_8_1
#> [1] "ENT"       "8"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_04$ENT_8_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME10"      
#>  [5] "FIRSTNAME10"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000010"
#> 
#> $sample_820_04$ENT_8_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2511190148000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_04$ENT_8_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_04$ENT_8_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_04$ENT_8_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_04$ENT_8_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251101-20251130"
#> 
#> $sample_820_04$ENT_9_1
#> [1] "ENT"       "9"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_04$ENT_9_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME11"      
#>  [5] "FIRSTNAME11"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000011"
#> 
#> $sample_820_04$ENT_9_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2511190148000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_04$ENT_9_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_04$ENT_9_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_04$ENT_9_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_04$ENT_9_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251101-20251130"
#> 
#> $sample_820_04$ENT_10_1
#> [1] "ENT"       "10"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_04$ENT_10_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME12"      
#>  [5] "FIRSTNAME12"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000012"
#> 
#> $sample_820_04$ENT_10_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2511190148000P" NA                              
#> [5] "5101.10"                       
#> 
#> $sample_820_04$ENT_10_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_04$ENT_10_5
#> [1] "REF"  "ZZ"   "17;2"
#> 
#> $sample_820_04$ENT_10_6
#> [1] "REF"             "ZZ"              "Dual-State Only"
#> 
#> $sample_820_04$ENT_10_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251001-20251031"
#> 
#> $sample_820_04$SE
#> [1] "SE"   "91"   "0001"
#> 
#> $sample_820_04$GE
#> [1] "GE"    "1"     "42755"
#> 
#> $sample_820_04$IEA
#> [1] "IEA"       "1"         "000058142"
#> 
#> 
```
