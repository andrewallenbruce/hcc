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
purrr::map(purrr::map(hcc::x12_820, index_x12), parse_820)
#> $`820_EX10_debt_covered_by_affiliate1`
#> $`820_EX10_debt_covered_by_affiliate1`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "240221"    "1348"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$GS
#> [1] "GS"         "RA"         "SENDERGS"   "RECEIVERGS" "20240221"  
#> [6] "134856"     "000000001"  "X"          "005010X306"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ST
#> [1] "ST"         "820"        "0001"       "005010X306"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$BPR
#>  [1] "BPR"      "I"        "0"        "C"        "NON"      NA        
#>  [7] NA         NA         NA         NA         NA         NA        
#> [13] NA         NA         NA         NA         "20140210"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$N1PE
#> [1] "N1"            "PE"            "NATIONAL EAST" "FI"           
#> [5] "121231244"    
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$N1RM
#> [1] "N1"  "RM"  "CMS" "58"  "CMS"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$PERIC
#> [1] "PER"                        "IC"                        
#> [3] "EXCHANGE OPERATIONS CENTER" "EM"                        
#> [5] "CMS_FEPS@cms.hhs.gov"       "TE"                        
#> [7] "8002671515"                
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_1_1
#> [1] "ENT" "1"  
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_1_2
#>  [1] "NM1"    "IL"     "1"      "HOPE"   "AMY"    NA       NA       NA      
#>  [9] "C1"     "777339"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_1_3
#> [1] "REF"              "38"               "12345MD000011500"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_1_4
#> [1] "REF"  "POL"  "4599"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_1_5
#> [1] "REF"   "AZ"    "PLAN2"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_1_6
#> [1] "REF"     "0F"      "SUB1234"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_1_7
#> [1] "RMR"  "ZZ"   "APTC" NA     "100" 
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_1_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_1_9
#> [1] "RMR" "ZZ"  "CSR" NA    "50" 
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_1_10
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_1_11
#> [1] "RMR" "ZZ"  "UF"  NA    "-35"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_1_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_1_13
#> [1] "RMR"     "ZZ"      "APTCADJ" NA        "-450"   
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_1_14
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_1_15
#> [1] "RMR"     "ZZ"      "APTCADJ" NA        "100"    
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_1_16
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_2_1
#> [1] "ENT" "2"  
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_2_2
#>  [1] "NM1"      "IL"       "1"        "RENEE"    "JENNIFER" NA        
#>  [7] NA         NA         "C1"       "777335"  
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_2_3
#> [1] "REF"              "38"               "12346MD000011501"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_2_4
#> [1] "REF"  "POL"  "5678"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_2_5
#> [1] "REF"   "AZ"    "PLAN4"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_2_6
#> [1] "REF"     "0F"      "SUB2348"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_2_7
#> [1] "RMR"  "ZZ"   "APTC" NA     "100" 
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_2_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_2_9
#> [1] "RMR" "ZZ"  "CSR" NA    "50" 
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_2_10
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_2_11
#> [1] "RMR" "ZZ"  "UF"  NA    "-40"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_2_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_3_1
#> [1] "ENT" "3"  
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_3_2
#> [1] "RMR" "ZZ"  "BAL" NA    "125"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$ENT_3_3
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$SE
#> [1] "SE"   "38"   "0001"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`820_EX10_debt_covered_by_affiliate1`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`820_EX11_debt_covered_by_affiliate2`
#> $`820_EX11_debt_covered_by_affiliate2`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "240221"    "1404"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$GS
#> [1] "GS"         "RA"         "SENDERGS"   "RECEIVERGS" "20240221"  
#> [6] "140425"     "000000001"  "X"          "005010X306"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ST
#> [1] "ST"         "820"        "0002"       "005010X306"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$BPR
#>  [1] "BPR"      "I"        "0"        "C"        "NON"      NA        
#>  [7] NA         NA         NA         NA         NA         NA        
#> [13] NA         NA         NA         NA         "20140228"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$N1PE
#> [1] "N1"            "PE"            "NATIONAL EAST" "FI"           
#> [5] "121231244"    
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$N1RM
#> [1] "N1"  "RM"  "CMS" "58"  "CMS"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$PERIC
#> [1] "PER"                        "IC"                        
#> [3] "EXCHANGE OPERATIONS CENTER" "EM"                        
#> [5] "CMS_FEPS@cms.hhs.gov"       "TE"                        
#> [7] "8002671515"                
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_1_1
#> [1] "ENT" "1"  
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_1_2
#>  [1] "NM1"    "IL"     "1"      "HOPE"   "AMY"    NA       NA       NA      
#>  [9] "C1"     "777339"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_1_3
#> [1] "REF"              "38"               "12345MD000011501"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_1_4
#> [1] "REF"  "POL"  "4599"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_1_5
#> [1] "REF"   "AZ"    "PLAN2"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_1_6
#> [1] "REF"     "0F"      "SUB1234"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_1_7
#> [1] "RMR"  "ZZ"   "APTC" NA     "100" 
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_1_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_1_9
#> [1] "RMR" "ZZ"  "CSR" NA    "50" 
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_1_10
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_1_11
#> [1] "RMR" "ZZ"  "UF"  NA    "-35"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_1_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_1_13
#> [1] "RMR"     "ZZ"      "APTCADJ" NA        "-450"   
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_1_14
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_1_15
#> [1] "RMR"     "ZZ"      "APTCADJ" NA        "100"    
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_1_16
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_2_1
#> [1] "ENT" "2"  
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_2_2
#>  [1] "NM1"      "IL"       "1"        "RENEE"    "JENNIFER" NA        
#>  [7] NA         NA         "C1"       "777335"  
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_2_3
#> [1] "REF"              "38"               "12346MD000011501"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_2_4
#> [1] "REF"  "POL"  "5674"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_2_5
#> [1] "REF"   "AZ"    "PLAN4"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_2_6
#> [1] "REF"     "0F"      "SUB2348"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_2_7
#> [1] "RMR"  "ZZ"   "APTC" NA     "100" 
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_2_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_2_9
#> [1] "RMR" "ZZ"  "CSR" NA    "50" 
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_2_10
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_2_11
#> [1] "RMR" "ZZ"  "UF"  NA    "-40"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_2_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_3_1
#> [1] "ENT" "3"  
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_3_2
#> [1] "RMR"     "ZZ"      "DEBTADJ" NA        "125"    
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_3_3
#> [1] "REF"                     "0N"                     
#> [3] "AFFRPT"                  "5551202-123456789123459"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$ENT_3_4
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$SE
#> [1] "SE"   "39"   "0002"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`820_EX12_csr_manual_adj`
#> $`820_EX12_csr_manual_adj`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "240221"    "1405"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`820_EX12_csr_manual_adj`$GS
#> [1] "GS"         "RA"         "SENDERGS"   "RECEIVERGS" "20240221"  
#> [6] "140549"     "000000001"  "X"          "005010X306"
#> 
#> $`820_EX12_csr_manual_adj`$ST
#> [1] "ST"         "820"        "0001"       "005010X306"
#> 
#> $`820_EX12_csr_manual_adj`$BPR
#>  [1] "BPR"      "I"        "0"        "C"        "NON"      NA        
#>  [7] NA         NA         NA         NA         NA         NA        
#> [13] NA         NA         NA         NA         "20140210"
#> 
#> $`820_EX12_csr_manual_adj`$N1PE
#> [1] "N1"        "PE"        "NATIONAL"  "FI"        "121231233"
#> 
#> $`820_EX12_csr_manual_adj`$N1RM
#> [1] "N1"  "RM"  "CMS" "58"  "CMS"
#> 
#> $`820_EX12_csr_manual_adj`$PERIC
#> [1] "PER"                        "IC"                        
#> [3] "EXCHANGE OPERATIONS CENTER" "EM"                        
#> [5] "CMS_FEPS@cms.hhs.gov"       "TE"                        
#> [7] "8002671515"                
#> 
#> $`820_EX12_csr_manual_adj`$ENT_1_1
#> [1] "ENT" "1"  
#> 
#> $`820_EX12_csr_manual_adj`$ENT_1_2
#>  [1] "NM1"    "IL"     "1"      "SMITH"  "JANE"   NA       NA       NA      
#>  [9] "C1"     "777222"
#> 
#> $`820_EX12_csr_manual_adj`$ENT_1_3
#> [1] "REF"              "38"               "12345MD000011221"
#> 
#> $`820_EX12_csr_manual_adj`$ENT_1_4
#> [1] "REF"  "POL"  "4567"
#> 
#> $`820_EX12_csr_manual_adj`$ENT_1_5
#> [1] "REF"   "AZ"    "PLAN1"
#> 
#> $`820_EX12_csr_manual_adj`$ENT_1_6
#> [1] "REF"    "0F"     "SUB123"
#> 
#> $`820_EX12_csr_manual_adj`$ENT_1_7
#> [1] "RMR"  "ZZ"   "APTC" NA     "100" 
#> 
#> $`820_EX12_csr_manual_adj`$ENT_1_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX12_csr_manual_adj`$ENT_1_9
#> [1] "RMR" "ZZ"  "UF"  NA    "-35"
#> 
#> $`820_EX12_csr_manual_adj`$ENT_1_10
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX12_csr_manual_adj`$ENT_2_1
#> [1] "ENT" "2"  
#> 
#> $`820_EX12_csr_manual_adj`$ENT_2_2
#>  [1] "NM1"    "IL"     "1"      "DOE"    "JOHN"   NA       NA       NA      
#>  [9] "C1"     "777223"
#> 
#> $`820_EX12_csr_manual_adj`$ENT_2_3
#> [1] "REF"              "38"               "12346MD000011232"
#> 
#> $`820_EX12_csr_manual_adj`$ENT_2_4
#> [1] "REF"  "POL"  "5678"
#> 
#> $`820_EX12_csr_manual_adj`$ENT_2_5
#> [1] "REF"   "AZ"    "PLAN2"
#> 
#> $`820_EX12_csr_manual_adj`$ENT_2_6
#> [1] "REF"    "0F"     "SUB234"
#> 
#> $`820_EX12_csr_manual_adj`$ENT_2_7
#> [1] "RMR"  "ZZ"   "APTC" NA     "100" 
#> 
#> $`820_EX12_csr_manual_adj`$ENT_2_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX12_csr_manual_adj`$ENT_2_9
#> [1] "RMR" "ZZ"  "UF"  NA    "-40"
#> 
#> $`820_EX12_csr_manual_adj`$ENT_2_10
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX12_csr_manual_adj`$ENT_3_1
#> [1] "ENT" "3"  
#> 
#> $`820_EX12_csr_manual_adj`$ENT_3_2
#> [1] "RMR"  "ZZ"   "BAL"  NA     "-125"
#> 
#> $`820_EX12_csr_manual_adj`$ENT_3_3
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX12_csr_manual_adj`$SE
#> [1] "SE"   "30"   "0001"
#> 
#> $`820_EX12_csr_manual_adj`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`820_EX12_csr_manual_adj`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`
#> $`820_EX1_different_types_of_pmt_by_HIX`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "240221"    "1259"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$GS
#> [1] "GS"         "RA"         "SENDERGS"   "RECEIVERGS" "20240221"  
#> [6] "125918"     "000000001"  "X"          "005010X306"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ST
#> [1] "ST"         "820"        "0001"       "005010X306"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$BPR
#>  [1] "BPR"       "I"         "220"       "C"         "ACH"       "CCP"      
#>  [7] NA          NA          NA          NA          NA          NA         
#> [13] "01"        "199999999" "DA"        "98765"     "20140604" 
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$N1PE
#> [1] "N1"                 "PE"                 "BATA INSURANCE CO."
#> [4] "FI"                 "012222222"         
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$N1RM
#> [1] "N1"                "RM"                "GOVERNMENT AGENCY"
#> [4] "58"                "123ABC"           
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_1_1
#> [1] "ENT" "1"  
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_1_2
#>  [1] "NM1"    "IL"     "1"      "DOE"    "JOHN"   NA       NA       NA      
#>  [9] "C1"     "777222"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_1_3
#> [1] "REF"     "POL"     "1232456"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_1_4
#> [1] "REF"      "AZ"       "12565496"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_1_5
#> [1] "REF"    "0F"     "555666"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_1_6
#> [1] "RMR"  "ZZ"   "APTC" NA     "35"  
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_1_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20120501-20140531"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_2_1
#> [1] "ENT" "2"  
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_2_2
#>  [1] "NM1"      "IL"       "1"        "FIRSTONE" "EMILY"    NA        
#>  [7] NA         NA         "C1"       "777333"  
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_2_3
#> [1] "REF"     "POL"     "1232457"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_2_4
#> [1] "REF"      "AZ"       "12565497"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_2_5
#> [1] "REF"    "0F"     "555777"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_2_6
#> [1] "RMR"  "ZZ"   "APTC" NA     "35"  
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_2_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20120501-20140531"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_3_1
#> [1] "ENT" "3"  
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_3_2
#>  [1] "NM1"       "IL"        "1"         "MIDDLEONE" "JULIE"     NA         
#>  [7] NA          NA          "C1"        "777444"   
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_3_3
#> [1] "REF"     "POL"     "1232458"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_3_4
#> [1] "REF"      "AZ"       "12565498"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_3_5
#> [1] "REF"    "0F"     "544477"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_3_6
#> [1] "RMR"  "ZZ"   "APTC" NA     "-350"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_3_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140331"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_4_1
#> [1] "ENT" "4"  
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_4_2
#>  [1] "NM1"    "IL"     "1"      "NEWONE" "KELLY"  NA       NA       NA      
#>  [9] "C1"     "777111"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_4_3
#> [1] "REF"     "POL"     "1232459"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_4_4
#> [1] "REF"      "AZ"       "12565499"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_4_5
#> [1] "RMR"  "ZZ"   "APTC" NA     "450" 
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_4_6
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140501-20140531"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_4_7
#> [1] "RMR" "ZZ"  "CSR" NA    "50" 
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$ENT_4_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140501-20140531"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$SE
#> [1] "SE"   "37"   "0001"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`820_EX2_payments_exceed_charges1`
#> $`820_EX2_payments_exceed_charges1`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "240221"    "1259"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`820_EX2_payments_exceed_charges1`$GS
#> [1] "GS"         "RA"         "SENDERGS"   "RECEIVERGS" "20240221"  
#> [6] "125902"     "000000001"  "X"          "005010X306"
#> 
#> $`820_EX2_payments_exceed_charges1`$ST
#> [1] "ST"         "820"        "0001"       "005010X306"
#> 
#> $`820_EX2_payments_exceed_charges1`$BPR
#>  [1] "BPR"      "I"        "0"        "C"        "NON"      NA        
#>  [7] NA         NA         NA         NA         NA         NA        
#> [13] NA         NA         NA         NA         "20140110"
#> 
#> $`820_EX2_payments_exceed_charges1`$N1PE
#> [1] "N1"        "PE"        "NATIONAL"  "FI"        "121231233"
#> 
#> $`820_EX2_payments_exceed_charges1`$N1RM
#> [1] "N1"  "RM"  "CMS" "58"  "CMS"
#> 
#> $`820_EX2_payments_exceed_charges1`$PERIC
#> [1] "PER"                        "IC"                        
#> [3] "EXCHANGE OPERATIONS CENTER" "EM"                        
#> [5] "CMS_FEPS@cms.hhs.gov"       "TE"                        
#> [7] "8002671515"                
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_1_1
#> [1] "ENT" "1"  
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_1_2
#>  [1] "NM1"    "IL"     "1"      "SMITH"  "JANE"   NA       NA       NA      
#>  [9] "C1"     "777222"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_1_3
#> [1] "REF"              "38"               "12345MD000011221"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_1_4
#> [1] "REF"  "POL"  "4567"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_1_5
#> [1] "REF"   "AZ"    "PLAN1"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_1_6
#> [1] "REF"    "0F"     "SUB123"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_1_7
#> [1] "RMR"  "ZZ"   "APTC" NA     "600" 
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_1_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_1_9
#> [1] "RMR" "ZZ"  "CSR" NA    "100"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_1_10
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_1_11
#> [1] "RMR" "ZZ"  "UF"  NA    "-25"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_1_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_2_1
#> [1] "ENT" "2"  
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_2_2
#>  [1] "NM1"    "IL"     "1"      "DOE"    "JOHN"   NA       NA       NA      
#>  [9] "C1"     "777223"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_2_3
#> [1] "REF"              "38"               "12346MD000011232"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_2_4
#> [1] "REF"  "POL"  "5678"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_2_5
#> [1] "REF"   "AZ"    "PLAN2"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_2_6
#> [1] "REF"    "0F"     "SUB234"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_2_7
#> [1] "RMR"  "ZZ"   "APTC" NA     "400" 
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_2_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_2_9
#> [1] "RMR" "ZZ"  "CSR" NA    "50" 
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_2_10
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_2_11
#> [1] "RMR" "ZZ"  "UF"  NA    "-15"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_2_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_3_1
#> [1] "ENT" "3"  
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_3_2
#> [1] "RMR"   "ZZ"    "BAL"   NA      "-1110"
#> 
#> $`820_EX2_payments_exceed_charges1`$ENT_3_3
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX2_payments_exceed_charges1`$SE
#> [1] "SE"   "34"   "0001"
#> 
#> $`820_EX2_payments_exceed_charges1`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`820_EX2_payments_exceed_charges1`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`820_EX3_payments_exceed_charges2`
#> $`820_EX3_payments_exceed_charges2`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "240221"    "1331"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`820_EX3_payments_exceed_charges2`$GS
#> [1] "GS"         "RA"         "SENDERGS"   "RECEIVERGS" "20240221"  
#> [6] "133138"     "000000001"  "X"          "005010X306"
#> 
#> $`820_EX3_payments_exceed_charges2`$ST
#> [1] "ST"         "820"        "0002"       "005010X306"
#> 
#> $`820_EX3_payments_exceed_charges2`$BPR
#>  [1] "BPR"          "I"            "1110"         "C"            "ACH"         
#>  [6] "CCP"          NA             NA             NA             NA            
#> [11] NA             NA             "01"           "000000001"    "DA"          
#> [16] "123456772123" "20140128"    
#> 
#> $`820_EX3_payments_exceed_charges2`$N1PE
#> [1] "N1"        "PE"        "NATIONAL"  "FI"        "121231233"
#> 
#> $`820_EX3_payments_exceed_charges2`$N1RM
#> [1] "N1"  "RM"  "CMS" "58"  "CMS"
#> 
#> $`820_EX3_payments_exceed_charges2`$PERIC
#> [1] "PER"                        "IC"                        
#> [3] "EXCHANGE OPERATIONS CENTER" "EM"                        
#> [5] "CMS_FEPS@cms.hhs.gov"       "TE"                        
#> [7] "8002671515"                
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_1_1
#> [1] "ENT" "1"  
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_1_2
#>  [1] "NM1"    "IL"     "1"      "SMITH"  "JANE"   NA       NA       NA      
#>  [9] "C1"     "777222"
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_1_3
#> [1] "REF"              "38"               "12345MD000011221"
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_1_4
#> [1] "REF"  "POL"  "4567"
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_1_5
#> [1] "REF"   "AZ"    "PLAN1"
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_1_6
#> [1] "REF"    "0F"     "SUB123"
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_1_7
#> [1] "RMR"  "ZZ"   "APTC" NA     "600" 
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_1_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_1_9
#> [1] "RMR" "ZZ"  "CSR" NA    "100"
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_1_10
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_1_11
#> [1] "RMR" "ZZ"  "UF"  NA    "-25"
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_1_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_2_1
#> [1] "ENT" "2"  
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_2_2
#>  [1] "NM1"    "IL"     "1"      "DOE"    "JOHN"   NA       NA       NA      
#>  [9] "C1"     "777223"
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_2_3
#> [1] "REF"              "38"               "12346MD000011232"
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_2_4
#> [1] "REF"  "POL"  "5678"
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_2_5
#> [1] "REF"   "AZ"    "PLAN2"
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_2_6
#> [1] "REF"    "0F"     "SUB234"
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_2_7
#> [1] "RMR"  "ZZ"   "APTC" NA     "400" 
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_2_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_2_9
#> [1] "RMR" "ZZ"  "CSR" NA    "50" 
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_2_10
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_2_11
#> [1] "RMR" "ZZ"  "UF"  NA    "-15"
#> 
#> $`820_EX3_payments_exceed_charges2`$ENT_2_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX3_payments_exceed_charges2`$SE
#> [1] "SE"   "31"   "0002"
#> 
#> $`820_EX3_payments_exceed_charges2`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`820_EX3_payments_exceed_charges2`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`820_EX4_charges_exceed_payments1`
#> $`820_EX4_charges_exceed_payments1`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "240221"    "1335"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`820_EX4_charges_exceed_payments1`$GS
#> [1] "GS"         "RA"         "SENDERGS"   "RECEIVERGS" "20240221"  
#> [6] "133549"     "000000001"  "X"          "005010X306"
#> 
#> $`820_EX4_charges_exceed_payments1`$ST
#> [1] "ST"         "820"        "0001"       "005010X306"
#> 
#> $`820_EX4_charges_exceed_payments1`$BPR
#>  [1] "BPR"      "I"        "0"        "C"        "NON"      NA        
#>  [7] NA         NA         NA         NA         NA         NA        
#> [13] NA         NA         NA         NA         "20140110"
#> 
#> $`820_EX4_charges_exceed_payments1`$N1PE
#> [1] "N1"        "PE"        "USINS"     "FI"        "121231234"
#> 
#> $`820_EX4_charges_exceed_payments1`$N1RM
#> [1] "N1"  "RM"  "CMS" "58"  "CMS"
#> 
#> $`820_EX4_charges_exceed_payments1`$PERIC
#> [1] "PER"                        "IC"                        
#> [3] "EXCHANGE OPERATIONS CENTER" "EM"                        
#> [5] "CMS_FEPS@cms.hhs.gov"       "TE"                        
#> [7] "8002671515"                
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_1_1
#> [1] "ENT" "1"  
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_1_2
#>  [1] "NM1"    "IL"     "1"      "SMITH"  "JANE"   NA       NA       NA      
#>  [9] "C1"     "777222"
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_1_3
#> [1] "REF"              "38"               "12346MD000011222"
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_1_4
#> [1] "REF"    "1L"     "987654"
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_1_5
#> [1] "REF"  "POL"  "4567"
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_1_6
#> [1] "REF"   "AZ"    "PLAN1"
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_1_7
#> [1] "REF"    "0F"     "SUB123"
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_1_8
#> [1] "RMR" "ZZ"  "UF"  NA    "-25"
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_1_9
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_2_1
#> [1] "ENT" "2"  
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_2_2
#>  [1] "NM1"    "IL"     "1"      "DOE"    "JOHN"   NA       NA       NA      
#>  [9] "C1"     "777223"
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_2_3
#> [1] "REF"              "38"               "12346MD000011237"
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_2_4
#> [1] "REF"    "1L"     "678910"
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_2_5
#> [1] "REF"  "POL"  "5678"
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_2_6
#> [1] "REF"   "AZ"    "PLAN2"
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_2_7
#> [1] "REF"    "0F"     "SUB234"
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_2_8
#> [1] "RMR" "ZZ"  "UF"  NA    "-15"
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_2_9
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_3_1
#> [1] "ENT" "3"  
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_3_2
#> [1] "RMR" "ZZ"  "BAL" NA    "40" 
#> 
#> $`820_EX4_charges_exceed_payments1`$ENT_3_3
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX4_charges_exceed_payments1`$SE
#> [1] "SE"   "28"   "0001"
#> 
#> $`820_EX4_charges_exceed_payments1`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`820_EX4_charges_exceed_payments1`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`820_EX5_charges_exceed_payments2`
#> $`820_EX5_charges_exceed_payments2`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "240221"    "1338"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`820_EX5_charges_exceed_payments2`$GS
#> [1] "GS"         "RA"         "SENDERGS"   "RECEIVERGS" "20240221"  
#> [6] "133811"     "000000001"  "X"          "005010X306"
#> 
#> $`820_EX5_charges_exceed_payments2`$ST
#> [1] "ST"         "820"        "0002"       "005010X306"
#> 
#> $`820_EX5_charges_exceed_payments2`$BPR
#>  [1] "BPR"      "I"        "0"        "C"        "NON"      NA        
#>  [7] NA         NA         NA         NA         NA         NA        
#> [13] NA         NA         NA         NA         "20140128"
#> 
#> $`820_EX5_charges_exceed_payments2`$N1PE
#> [1] "N1"        "PE"        "USINS"     "FI"        "121231234"
#> 
#> $`820_EX5_charges_exceed_payments2`$N1RM
#> [1] "N1"  "RM"  "CMS" "58"  "CMS"
#> 
#> $`820_EX5_charges_exceed_payments2`$PERIC
#> [1] "PER"                        "IC"                        
#> [3] "EXCHANGE OPERATIONS CENTER" "EM"                        
#> [5] "CMS_FEPS@cms.hhs.gov"       "TE"                        
#> [7] "8002671515"                
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_1_1
#> [1] "ENT" "1"  
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_1_2
#>  [1] "NM1"    "IL"     "1"      "SMITH"  "JANE"   NA       NA       NA      
#>  [9] "C1"     "777222"
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_1_3
#> [1] "REF"              "38"               "12345MD000011222"
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_1_4
#> [1] "REF"    "1L"     "987654"
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_1_5
#> [1] "REF"  "POL"  "4567"
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_1_6
#> [1] "REF"   "AZ"    "PLAN1"
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_1_7
#> [1] "REF"    "0F"     "SUB123"
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_1_8
#> [1] "RMR" "ZZ"  "UF"  NA    "-25"
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_1_9
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_2_1
#> [1] "ENT" "2"  
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_2_2
#>  [1] "NM1"    "IL"     "1"      "DOE"    "JOHN"   NA       NA       NA      
#>  [9] "C1"     "777223"
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_2_3
#> [1] "REF"              "38"               "12346MD000011237"
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_2_4
#> [1] "REF"    "1L"     "678910"
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_2_5
#> [1] "REF"  "POL"  "5678"
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_2_6
#> [1] "REF"   "AZ"    "PLAN2"
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_2_7
#> [1] "REF"    "0F"     "SUB234"
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_2_8
#> [1] "RMR" "ZZ"  "UF"  NA    "-15"
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_2_9
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_3_1
#> [1] "ENT" "3"  
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_3_2
#> [1] "RMR"     "ZZ"      "INVOICE" NA        "40"     
#> 
#> $`820_EX5_charges_exceed_payments2`$ENT_3_3
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX5_charges_exceed_payments2`$SE
#> [1] "SE"   "28"   "0002"
#> 
#> $`820_EX5_charges_exceed_payments2`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`820_EX5_charges_exceed_payments2`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`820_EX6_aptc_adjustments1`
#> $`820_EX6_aptc_adjustments1`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "240221"    "1342"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`820_EX6_aptc_adjustments1`$GS
#> [1] "GS"         "RA"         "SENDERGS"   "RECEIVERGS" "20240221"  
#> [6] "134200"     "000000001"  "X"          "005010X306"
#> 
#> $`820_EX6_aptc_adjustments1`$ST
#> [1] "ST"         "820"        "0001"       "005010X306"
#> 
#> $`820_EX6_aptc_adjustments1`$BPR
#>  [1] "BPR"      "I"        "0"        "C"        "NON"      NA        
#>  [7] NA         NA         NA         NA         NA         NA        
#> [13] NA         NA         NA         NA         "20140210"
#> 
#> $`820_EX6_aptc_adjustments1`$N1PE
#> [1] "N1"        "PE"        "NATIONAL"  "FI"        "121231233"
#> 
#> $`820_EX6_aptc_adjustments1`$N1RM
#> [1] "N1"  "RM"  "CMS" "58"  "CMS"
#> 
#> $`820_EX6_aptc_adjustments1`$PERIC
#> [1] "PER"                        "IC"                        
#> [3] "EXCHANGE OPERATIONS CENTER" "EM"                        
#> [5] "CMS_FEPS@cms.hhs.gov"       "TE"                        
#> [7] "8002671515"                
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_1_1
#> [1] "ENT" "1"  
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_1_2
#>  [1] "NM1"    "IL"     "1"      "SMITH"  "JANE"   NA       NA       NA      
#>  [9] "C1"     "777222"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_1_3
#> [1] "REF"              "38"               "12345MD000011221"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_1_4
#> [1] "REF"  "POL"  "4567"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_1_5
#> [1] "REF"   "AZ"    "PLAN1"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_1_6
#> [1] "REF"    "0F"     "SUB123"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_1_7
#> [1] "RMR"  "ZZ"   "APTC" NA     "500" 
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_1_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_1_9
#> [1] "RMR" "ZZ"  "CSR" NA    "100"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_1_10
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_1_11
#> [1] "RMR" "ZZ"  "UF"  NA    "-25"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_1_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_1_13
#> [1] "RMR"     "ZZ"      "APTCADJ" NA        "-600"   
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_1_14
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_1_15
#> [1] "RMR"     "ZZ"      "APTCADJ" NA        "500"    
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_1_16
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_2_1
#> [1] "ENT" "2"  
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_2_2
#>  [1] "NM1"    "IL"     "1"      "DOE"    "JOHN"   NA       NA       NA      
#>  [9] "C1"     "777223"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_2_3
#> [1] "REF"              "38"               "12346MD000011232"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_2_4
#> [1] "REF"  "POL"  "5678"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_2_5
#> [1] "REF"   "AZ"    "PLAN2"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_2_6
#> [1] "REF"    "0F"     "SUB234"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_2_7
#> [1] "RMR"  "ZZ"   "APTC" NA     "400" 
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_2_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_2_9
#> [1] "RMR" "ZZ"  "CSR" NA    "50" 
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_2_10
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_2_11
#> [1] "RMR" "ZZ"  "UF"  NA    "-15"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_2_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_3_1
#> [1] "ENT" "3"  
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_3_2
#> [1] "RMR"  "ZZ"   "BAL"  NA     "-910"
#> 
#> $`820_EX6_aptc_adjustments1`$ENT_3_3
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX6_aptc_adjustments1`$SE
#> [1] "SE"   "38"   "0001"
#> 
#> $`820_EX6_aptc_adjustments1`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`820_EX6_aptc_adjustments1`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
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
#> $`820_EX9_outstanding_debt_owed2`
#> $`820_EX9_outstanding_debt_owed2`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "240221"    "1347"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`820_EX9_outstanding_debt_owed2`$GS
#> [1] "GS"         "RA"         "SENDERGS"   "RECEIVERGS" "20240221"  
#> [6] "134721"     "000000001"  "X"          "005010X306"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ST
#> [1] "ST"         "820"        "0002"       "005010X306"
#> 
#> $`820_EX9_outstanding_debt_owed2`$BPR
#>  [1] "BPR"          "I"            "985"          "C"            "ACH"         
#>  [6] "CCP"          NA             NA             NA             NA            
#> [11] NA             NA             "01"           "000000001"    "DA"          
#> [16] "123456772123" "20140228"    
#> 
#> $`820_EX9_outstanding_debt_owed2`$N1PE
#> [1] "N1"        "PE"        "NATIONAL"  "FI"        "121231233"
#> 
#> $`820_EX9_outstanding_debt_owed2`$N1RM
#> [1] "N1"  "RM"  "CMS" "58"  "CMS"
#> 
#> $`820_EX9_outstanding_debt_owed2`$PERIC
#> [1] "PER"                        "IC"                        
#> [3] "EXCHANGE OPERATIONS CENTER" "EM"                        
#> [5] "CMS_FEPS@cms.hhs.gov"       "TE"                        
#> [7] "8002671515"                
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_1_1
#> [1] "ENT" "1"  
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_1_2
#>  [1] "NM1"    "IL"     "1"      "SMITH"  "JANE"   NA       NA       NA      
#>  [9] "C1"     "777222"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_1_3
#> [1] "REF"              "38"               "12345MD000011221"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_1_4
#> [1] "REF"  "POL"  "4567"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_1_5
#> [1] "REF"   "AZ"    "PLAN1"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_1_6
#> [1] "REF"    "0F"     "SUB123"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_1_7
#> [1] "RMR"  "ZZ"   "APTC" NA     "600" 
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_1_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140101-20140131"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_1_9
#> [1] "RMR" "ZZ"  "CSR" NA    "100"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_1_10
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_1_11
#> [1] "RMR" "ZZ"  "UF"  NA    "-25"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_1_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_2_1
#> [1] "ENT" "2"  
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_2_2
#>  [1] "NM1"    "IL"     "1"      "DOE"    "JOHN"   NA       NA       NA      
#>  [9] "C1"     "777223"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_2_3
#> [1] "REF"              "38"               "12346MD000011232"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_2_4
#> [1] "REF"  "POL"  "5678"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_2_5
#> [1] "REF"   "AZ"    "PLAN2"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_2_6
#> [1] "REF"    "0F"     "SUB234"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_2_7
#> [1] "RMR"  "ZZ"   "APTC" NA     "400" 
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_2_8
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_2_9
#> [1] "RMR" "ZZ"  "CSR" NA    "50" 
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_2_10
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_2_11
#> [1] "RMR" "ZZ"  "UF"  NA    "-15"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_2_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_3_1
#> [1] "ENT" "3"  
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_3_2
#> [1] "RMR"     "ZZ"      "REDUCED" NA        "-125"   
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_3_3
#> [1] "REF"                    "0N"                     "AFFRPT"                
#> [4] "5551201-12345678945678"
#> 
#> $`820_EX9_outstanding_debt_owed2`$ENT_3_4
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20140201-20140228"
#> 
#> $`820_EX9_outstanding_debt_owed2`$SE
#> [1] "SE"   "35"   "0002"
#> 
#> $`820_EX9_outstanding_debt_owed2`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`820_EX9_outstanding_debt_owed2`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $sample_820_01
#> $sample_820_01$ISA
#>  [1] "ISA"        "00"         NA           "00"         NA          
#>  [6] "ZZ"         "TEST-PAYER" "30"         "TEST-PAYEE" "260118"    
#> [11] "0831"       "+"          "00501"      "000058691"  "0"         
#> [16] "P"          ":"         
#> 
#> $sample_820_01$GS
#> [1] "GS"         "RA"         "TEST-PAYER" "TEST-PAYEE" "20260118"  
#> [6] "083122"     "43304"      "X"          "005010X218"
#> 
#> $sample_820_01$ST
#> [1] "ST"         "820"        "0001"       "005010X218"
#> 
#> $sample_820_01$BPR
#>  [1] "BPR"        "I"          "102139.46"  "C"          "NON"       
#>  [6] NA           NA           NA           NA           NA          
#> [11] "68-0317191" NA           NA           NA           NA          
#> [16] NA           "20260115"  
#> 
#> $sample_820_01$TRN
#> [1] "TRN"             "3"               "TESTTRN01000001"
#> 
#> $sample_820_01$REF14
#> [1] "REF"        "14"         "0000245023"
#> 
#> $sample_820_01$N1PE
#> [1] "N1"                      "PE"                     
#> [3] "TEST PAYEE ORGANIZATION"
#> 
#> $sample_820_01$N3PE
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_820_01$N4PE
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_820_01$N1PR
#> [1] "N1"                "PR"                "TEST PAYER AGENCY"
#> 
#> $sample_820_01$N3PR
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_820_01$N4PR
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_820_01$ENT_1_1
#> [1] "ENT"       "1"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_01$ENT_1_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME01"      
#>  [5] "FIRSTNAME01"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000001"
#> 
#> $sample_820_01$ENT_1_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_01$ENT_1_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_01$ENT_1_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_01$ENT_1_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_01$ENT_1_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_01$ENT_2_1
#> [1] "ENT"       "2"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_01$ENT_2_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME02"      
#>  [5] "FIRSTNAME02"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000002"
#> 
#> $sample_820_01$ENT_2_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_01$ENT_2_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_01$ENT_2_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_01$ENT_2_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_01$ENT_2_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_01$ENT_3_1
#> [1] "ENT"       "3"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_01$ENT_3_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME03"      
#>  [5] "FIRSTNAME03"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000003"
#> 
#> $sample_820_01$ENT_3_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_01$ENT_3_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_01$ENT_3_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_01$ENT_3_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_01$ENT_3_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_01$ENT_4_1
#> [1] "ENT"       "4"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_01$ENT_4_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME04"      
#>  [5] "FIRSTNAME04"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000004"
#> 
#> $sample_820_01$ENT_4_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_01$ENT_4_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_01$ENT_4_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_01$ENT_4_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_01$ENT_4_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_01$ENT_5_1
#> [1] "ENT"       "5"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_01$ENT_5_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME05"      
#>  [5] "FIRSTNAME05"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000005"
#> 
#> $sample_820_01$ENT_5_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_01$ENT_5_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_01$ENT_5_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_01$ENT_5_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_01$ENT_5_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_01$ENT_6_1
#> [1] "ENT"       "6"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_01$ENT_6_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME06"      
#>  [5] "FIRSTNAME06"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000006"
#> 
#> $sample_820_01$ENT_6_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_01$ENT_6_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_01$ENT_6_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_01$ENT_6_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_01$ENT_6_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_01$ENT_7_1
#> [1] "ENT"       "7"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_01$ENT_7_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME07"      
#>  [5] "FIRSTNAME07"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000007"
#> 
#> $sample_820_01$ENT_7_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_01$ENT_7_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_01$ENT_7_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_01$ENT_7_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_01$ENT_7_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_01$ENT_7_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_01$ENT_7_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_01$ENT_7_10
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_01$ENT_7_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_01$ENT_7_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251101-20251130"
#> 
#> $sample_820_01$ENT_8_1
#> [1] "ENT"       "8"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_01$ENT_8_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME08"      
#>  [5] "FIRSTNAME08"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000008"
#> 
#> $sample_820_01$ENT_8_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_01$ENT_8_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_01$ENT_8_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_01$ENT_8_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_01$ENT_8_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_01$ENT_9_1
#> [1] "ENT"       "9"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_01$ENT_9_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME09"      
#>  [5] "FIRSTNAME09"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000009"
#> 
#> $sample_820_01$ENT_9_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_01$ENT_9_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_01$ENT_9_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_01$ENT_9_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_01$ENT_9_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_01$ENT_10_1
#> [1] "ENT"       "10"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_01$ENT_10_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME10"      
#>  [5] "FIRSTNAME10"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000010"
#> 
#> $sample_820_01$ENT_10_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_01$ENT_10_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_01$ENT_10_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_01$ENT_10_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_01$ENT_10_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_01$ENT_11_1
#> [1] "ENT"       "11"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_01$ENT_11_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME11"      
#>  [5] "FIRSTNAME11"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000011"
#> 
#> $sample_820_01$ENT_11_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "8086.53"                       
#> 
#> $sample_820_01$ENT_11_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_01$ENT_11_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_01$ENT_11_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_01$ENT_11_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_01$ENT_12_1
#> [1] "ENT"       "12"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_01$ENT_12_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME12"      
#>  [5] "FIRSTNAME12"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000012"
#> 
#> $sample_820_01$ENT_12_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2512150225000P" NA                              
#> [5] "5101.10"                       
#> 
#> $sample_820_01$ENT_12_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_01$ENT_12_5
#> [1] "REF"  "ZZ"   "17;2"
#> 
#> $sample_820_01$ENT_12_6
#> [1] "REF"             "ZZ"              "Dual-State Only"
#> 
#> $sample_820_01$ENT_12_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251101-20251130"
#> 
#> $sample_820_01$SE
#> [1] "SE"   "100"  "0001"
#> 
#> $sample_820_01$GE
#> [1] "GE"    "1"     "43304"
#> 
#> $sample_820_01$IEA
#> [1] "IEA"       "1"         "000058691"
#> 
#> 
#> $sample_820_02
#> $sample_820_02$ISA
#>  [1] "ISA"        "00"         NA           "00"         NA          
#>  [6] "ZZ"         "TEST-PAYER" "30"         "TEST-PAYEE" "260316"    
#> [11] "0855"       "+"          "00501"      "000059660"  "0"         
#> [16] "P"          ":"         
#> 
#> $sample_820_02$GS
#> [1] "GS"         "RA"         "TEST-PAYER" "TEST-PAYEE" "20260316"  
#> [6] "085500"     "44273"      "X"          "005010X218"
#> 
#> $sample_820_02$ST
#> [1] "ST"         "820"        "0001"       "005010X218"
#> 
#> $sample_820_02$BPR
#>  [1] "BPR"        "I"          "91977.81"   "C"          "NON"       
#>  [6] NA           NA           NA           NA           NA          
#> [11] "68-0317191" NA           NA           NA           NA          
#> [16] NA           "20260312"  
#> 
#> $sample_820_02$TRN
#> [1] "TRN"             "3"               "TESTTRN02000001"
#> 
#> $sample_820_02$REF14
#> [1] "REF"        "14"         "0000245023"
#> 
#> $sample_820_02$N1PE
#> [1] "N1"                      "PE"                     
#> [3] "TEST PAYEE ORGANIZATION"
#> 
#> $sample_820_02$N3PE
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_820_02$N4PE
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_820_02$N1PR
#> [1] "N1"                "PR"                "TEST PAYER AGENCY"
#> 
#> $sample_820_02$N3PR
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_820_02$N4PR
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_820_02$ENT_1_1
#> [1] "ENT"       "1"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_02$ENT_1_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME01"      
#>  [5] "FIRSTNAME01"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000001"
#> 
#> $sample_820_02$ENT_1_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "5555.82"                       
#> 
#> $sample_820_02$ENT_1_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_1_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_02$ENT_1_6
#> [1] "REF"             "ZZ"              "Dual-State Only"
#> 
#> $sample_820_02$ENT_1_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_02$ENT_1_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "454.72"                         "5555.82"                       
#> 
#> $sample_820_02$ENT_1_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_1_10
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_02$ENT_1_11
#> [1] "REF"             "ZZ"              "Dual-State Only"
#> 
#> $sample_820_02$ENT_1_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_02$ENT_1_13
#> [1] "ADX"      "-5101.10" "53"      
#> 
#> $sample_820_02$ENT_2_1
#> [1] "ENT"       "2"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_02$ENT_2_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME02"      
#>  [5] "FIRSTNAME02"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000002"
#> 
#> $sample_820_02$ENT_2_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $sample_820_02$ENT_2_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_2_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_02$ENT_2_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_2_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_02$ENT_2_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "401.72"                         "8488.25"                       
#> 
#> $sample_820_02$ENT_2_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_2_10
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_02$ENT_2_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_2_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_02$ENT_2_13
#> [1] "ADX"      "-8086.53" "53"      
#> 
#> $sample_820_02$ENT_3_1
#> [1] "ENT"       "3"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_02$ENT_3_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME03"      
#>  [5] "FIRSTNAME03"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000003"
#> 
#> $sample_820_02$ENT_3_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $sample_820_02$ENT_3_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_3_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_02$ENT_3_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_3_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_02$ENT_3_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "401.72"                         "8488.25"                       
#> 
#> $sample_820_02$ENT_3_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_3_10
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_02$ENT_3_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_3_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_02$ENT_3_13
#> [1] "ADX"      "-8086.53" "53"      
#> 
#> $sample_820_02$ENT_4_1
#> [1] "ENT"       "4"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_02$ENT_4_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME13"      
#>  [5] "FIRSTNAME13"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000013"
#> 
#> $sample_820_02$ENT_4_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $sample_820_02$ENT_4_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_4_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_02$ENT_4_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_4_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_02$ENT_4_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $sample_820_02$ENT_4_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_4_10
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_02$ENT_4_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_4_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_02$ENT_5_1
#> [1] "ENT"       "5"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_02$ENT_5_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME04"      
#>  [5] "FIRSTNAME04"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000004"
#> 
#> $sample_820_02$ENT_5_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $sample_820_02$ENT_5_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_5_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_02$ENT_5_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_5_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_02$ENT_5_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "401.72"                         "8488.25"                       
#> 
#> $sample_820_02$ENT_5_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_5_10
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_02$ENT_5_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_5_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_02$ENT_5_13
#> [1] "ADX"      "-8086.53" "53"      
#> 
#> $sample_820_02$ENT_6_1
#> [1] "ENT"       "6"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_02$ENT_6_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME05"      
#>  [5] "FIRSTNAME05"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000005"
#> 
#> $sample_820_02$ENT_6_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $sample_820_02$ENT_6_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_6_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_02$ENT_6_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_6_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_02$ENT_6_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "401.72"                         "8488.25"                       
#> 
#> $sample_820_02$ENT_6_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_6_10
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_02$ENT_6_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_6_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_02$ENT_6_13
#> [1] "ADX"      "-8086.53" "53"      
#> 
#> $sample_820_02$ENT_7_1
#> [1] "ENT"       "7"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_02$ENT_7_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME06"      
#>  [5] "FIRSTNAME06"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000006"
#> 
#> $sample_820_02$ENT_7_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "-8086.53"                      
#> 
#> $sample_820_02$ENT_7_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_7_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_02$ENT_7_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_7_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_02$ENT_8_1
#> [1] "ENT"       "8"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_02$ENT_8_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME07"      
#>  [5] "FIRSTNAME07"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000007"
#> 
#> $sample_820_02$ENT_8_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $sample_820_02$ENT_8_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_8_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_02$ENT_8_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_8_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_02$ENT_8_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "401.72"                         "8488.25"                       
#> 
#> $sample_820_02$ENT_8_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_8_10
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_02$ENT_8_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_8_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_02$ENT_8_13
#> [1] "ADX"      "-8086.53" "53"      
#> 
#> $sample_820_02$ENT_9_1
#> [1] "ENT"       "9"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_02$ENT_9_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME08"      
#>  [5] "FIRSTNAME08"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000008"
#> 
#> $sample_820_02$ENT_9_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $sample_820_02$ENT_9_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_9_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_02$ENT_9_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_9_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_02$ENT_9_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "401.72"                         "8488.25"                       
#> 
#> $sample_820_02$ENT_9_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_9_10
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_02$ENT_9_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_9_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_02$ENT_9_13
#> [1] "ADX"      "-8086.53" "53"      
#> 
#> $sample_820_02$ENT_10_1
#> [1] "ENT"       "10"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_02$ENT_10_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME09"      
#>  [5] "FIRSTNAME09"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000009"
#> 
#> $sample_820_02$ENT_10_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $sample_820_02$ENT_10_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_10_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_02$ENT_10_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_10_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_02$ENT_10_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "401.72"                         "8488.25"                       
#> 
#> $sample_820_02$ENT_10_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_10_10
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_02$ENT_10_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_10_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_02$ENT_10_13
#> [1] "ADX"      "-8086.53" "53"      
#> 
#> $sample_820_02$ENT_11_1
#> [1] "ENT"       "11"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_02$ENT_11_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME10"      
#>  [5] "FIRSTNAME10"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000010"
#> 
#> $sample_820_02$ENT_11_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "401.72"                         "8488.25"                       
#> 
#> $sample_820_02$ENT_11_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_11_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_02$ENT_11_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_11_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_02$ENT_11_8
#> [1] "ADX"      "-8086.53" "53"      
#> 
#> $sample_820_02$ENT_12_1
#> [1] "ENT"       "12"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_02$ENT_12_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME11"      
#>  [5] "FIRSTNAME11"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000011"
#> 
#> $sample_820_02$ENT_12_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "8488.25"                       
#> 
#> $sample_820_02$ENT_12_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_12_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_02$ENT_12_6
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_12_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_02$ENT_12_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "401.72"                         "8488.25"                       
#> 
#> $sample_820_02$ENT_12_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_12_10
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_02$ENT_12_11
#> [1] "REF"                      "ZZ"                      
#> [3] "Medi-Cal Only-State Only"
#> 
#> $sample_820_02$ENT_12_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_02$ENT_12_13
#> [1] "ADX"      "-8086.53" "53"      
#> 
#> $sample_820_02$ENT_13_1
#> [1] "ENT"       "13"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_02$ENT_13_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME12"      
#>  [5] "FIRSTNAME12"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000012"
#> 
#> $sample_820_02$ENT_13_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-SREGLR-2602200043000P" NA                              
#> [5] "5555.82"                       
#> 
#> $sample_820_02$ENT_13_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_02$ENT_13_5
#> [1] "REF"  "ZZ"   "17;2"
#> 
#> $sample_820_02$ENT_13_6
#> [1] "REF"             "ZZ"              "Dual-State Only"
#> 
#> $sample_820_02$ENT_13_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_02$SE
#> [1] "SE"   "162"  "0001"
#> 
#> $sample_820_02$GE
#> [1] "GE"    "1"     "44273"
#> 
#> $sample_820_02$IEA
#> [1] "IEA"       "1"         "000059660"
#> 
#> 
#> $sample_820_03
#> $sample_820_03$ISA
#>  [1] "ISA"        "00"         NA           "00"         NA          
#>  [6] "ZZ"         "TEST-PAYER" "30"         "TEST-PAYEE" "260316"    
#> [11] "0854"       "+"          "00501"      "000059659"  "0"         
#> [16] "P"          ":"         
#> 
#> $sample_820_03$GS
#> [1] "GS"         "RA"         "TEST-PAYER" "TEST-PAYEE" "20260316"  
#> [6] "085458"     "44272"      "X"          "005010X218"
#> 
#> $sample_820_03$ST
#> [1] "ST"         "820"        "0001"       "005010X218"
#> 
#> $sample_820_03$BPR
#>  [1] "BPR"        "I"          "697085.64"  "C"          "NON"       
#>  [6] NA           NA           NA           NA           NA          
#> [11] "68-0317191" NA           NA           NA           NA          
#> [16] NA           "20260312"  
#> 
#> $sample_820_03$TRN
#> [1] "TRN"             "3"               "TESTTRN03000001"
#> 
#> $sample_820_03$REF14
#> [1] "REF"        "14"         "0000245023"
#> 
#> $sample_820_03$N1PE
#> [1] "N1"                      "PE"                     
#> [3] "TEST PAYEE ORGANIZATION"
#> 
#> $sample_820_03$N3PE
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_820_03$N4PE
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_820_03$N1PR
#> [1] "N1"                "PR"                "TEST PAYER AGENCY"
#> 
#> $sample_820_03$N3PR
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_820_03$N4PR
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_820_03$ENT_1_1
#> [1] "ENT"       "1"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_1_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME14"      
#>  [5] "FIRSTNAME14"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000014"
#> 
#> $sample_820_03$ENT_1_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_1_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_1_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_1_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_1_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_1_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_1_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_1_10
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_1_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_1_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_1_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_2_1
#> [1] "ENT"       "2"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_2_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME15"      
#>  [5] "FIRSTNAME15"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000015"
#> 
#> $sample_820_03$ENT_2_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_2_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_2_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_2_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_2_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_2_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_2_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_2_10
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_2_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_2_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_2_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_3_1
#> [1] "ENT"       "3"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_3_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME16"      
#>  [5] "FIRSTNAME16"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000016"
#> 
#> $sample_820_03$ENT_3_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_3_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_3_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_3_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_3_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_4_1
#> [1] "ENT"       "4"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_4_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME17"      
#>  [5] "FIRSTNAME17"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000017"
#> 
#> $sample_820_03$ENT_4_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_4_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_4_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_4_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_4_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_4_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_4_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_4_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_4_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_4_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_4_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_5_1
#> [1] "ENT"       "5"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_5_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME18"      
#>  [5] "FIRSTNAME18"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000018"
#> 
#> $sample_820_03$ENT_5_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_5_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_5_5
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_5_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_5_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_5_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "559.75"                         "9645.74"                       
#> 
#> $sample_820_03$ENT_5_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_5_10
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_5_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_5_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_5_13
#> [1] "ADX"      "-9085.99" "53"      
#> 
#> $sample_820_03$ENT_6_1
#> [1] "ENT"       "6"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_6_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME19"      
#>  [5] "FIRSTNAME19"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000019"
#> 
#> $sample_820_03$ENT_6_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_6_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_6_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_03$ENT_6_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_6_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_7_1
#> [1] "ENT"       "7"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_7_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME20"      
#>  [5] "FIRSTNAME20"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000020"
#> 
#> $sample_820_03$ENT_7_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_7_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_7_5
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_7_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_7_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_7_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "559.75"                         "9645.74"                       
#> 
#> $sample_820_03$ENT_7_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_7_10
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_7_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_7_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_7_13
#> [1] "ADX"      "-9085.99" "53"      
#> 
#> $sample_820_03$ENT_8_1
#> [1] "ENT"       "8"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_8_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME21"      
#>  [5] "FIRSTNAME21"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000021"
#> 
#> $sample_820_03$ENT_8_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_8_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_8_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_03$ENT_8_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_8_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_9_1
#> [1] "ENT"       "9"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_9_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME22"      
#>  [5] "FIRSTNAME22"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000022"
#> 
#> $sample_820_03$ENT_9_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_9_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_9_5
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_03$ENT_9_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_9_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_9_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_9_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_9_10
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_03$ENT_9_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_9_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_9_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_10_1
#> [1] "ENT"       "10"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_10_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME23"      
#>  [5] "FIRSTNAME23"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000023"
#> 
#> $sample_820_03$ENT_10_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_10_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_10_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_10_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_10_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_10_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_10_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_10_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_10_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_10_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_10_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_11_1
#> [1] "ENT"       "11"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_11_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME24"      
#>  [5] "FIRSTNAME24"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000024"
#> 
#> $sample_820_03$ENT_11_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_11_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_11_5
#> [1] "REF"  "ZZ"   "6H;1"
#> 
#> $sample_820_03$ENT_11_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_11_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_11_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_11_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_11_10
#> [1] "REF"  "ZZ"   "6H;1"
#> 
#> $sample_820_03$ENT_11_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_11_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_11_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_12_1
#> [1] "ENT"       "12"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_12_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME25"      
#>  [5] "FIRSTNAME25"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000025"
#> 
#> $sample_820_03$ENT_12_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_12_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_12_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_12_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_12_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_12_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_12_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_12_10
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_12_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_12_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_12_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_13_1
#> [1] "ENT"       "13"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_13_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME26"      
#>  [5] "FIRSTNAME26"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000026"
#> 
#> $sample_820_03$ENT_13_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_13_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_13_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_13_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_13_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_13_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "559.75"                         "9645.74"                       
#> 
#> $sample_820_03$ENT_13_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_13_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_13_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_13_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_13_13
#> [1] "ADX"      "-9085.99" "53"      
#> 
#> $sample_820_03$ENT_14_1
#> [1] "ENT"       "14"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_14_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME27"      
#>  [5] "FIRSTNAME27"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000027"
#> 
#> $sample_820_03$ENT_14_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_14_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_14_5
#> [1] "REF"  "ZZ"   "20;1"
#> 
#> $sample_820_03$ENT_14_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_14_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_14_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_14_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_14_10
#> [1] "REF"  "ZZ"   "20;1"
#> 
#> $sample_820_03$ENT_14_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_14_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_15_1
#> [1] "ENT"       "15"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_15_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME28"      
#>  [5] "FIRSTNAME28"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000028"
#> 
#> $sample_820_03$ENT_15_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_15_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_15_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_15_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_15_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_15_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_15_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_15_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_15_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_15_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_15_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_16_1
#> [1] "ENT"       "16"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_16_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME29"      
#>  [5] "FIRSTNAME29"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000029"
#> 
#> $sample_820_03$ENT_16_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_16_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_16_5
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_16_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_16_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_16_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "559.75"                         "9645.74"                       
#> 
#> $sample_820_03$ENT_16_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_16_10
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_16_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_16_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_16_13
#> [1] "ADX"      "-9085.99" "53"      
#> 
#> $sample_820_03$ENT_17_1
#> [1] "ENT"       "17"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_17_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME30"      
#>  [5] "FIRSTNAME30"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000030"
#> 
#> $sample_820_03$ENT_17_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_17_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_17_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_17_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_17_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_17_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_17_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_17_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_17_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_17_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_17_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_18_1
#> [1] "ENT"       "18"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_18_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME31"      
#>  [5] "FIRSTNAME31"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000031"
#> 
#> $sample_820_03$ENT_18_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_18_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_18_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_18_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_18_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_18_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_18_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_18_10
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_18_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_18_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_18_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_19_1
#> [1] "ENT"       "19"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_19_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME32"      
#>  [5] "FIRSTNAME32"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000032"
#> 
#> $sample_820_03$ENT_19_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_19_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_19_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_19_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_19_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_19_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_19_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_19_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_19_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_19_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_19_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_20_1
#> [1] "ENT"       "20"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_20_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME33"      
#>  [5] "FIRSTNAME33"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000033"
#> 
#> $sample_820_03$ENT_20_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_20_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_20_5
#> [1] "REF"  "ZZ"   "20;1"
#> 
#> $sample_820_03$ENT_20_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_20_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_20_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "559.75"                         "9645.74"                       
#> 
#> $sample_820_03$ENT_20_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_20_10
#> [1] "REF"  "ZZ"   "20;1"
#> 
#> $sample_820_03$ENT_20_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_20_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_20_13
#> [1] "ADX"      "-9085.99" "53"      
#> 
#> $sample_820_03$ENT_21_1
#> [1] "ENT"       "21"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_21_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME34"      
#>  [5] "FIRSTNAME34"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000034"
#> 
#> $sample_820_03$ENT_21_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_21_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_21_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_21_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_21_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_21_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_21_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_21_10
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_21_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_21_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_21_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_22_1
#> [1] "ENT"       "22"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_22_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME35"      
#>  [5] "FIRSTNAME35"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000035"
#> 
#> $sample_820_03$ENT_22_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_22_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_22_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_22_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_22_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_22_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "559.75"                         "9645.74"                       
#> 
#> $sample_820_03$ENT_22_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_22_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_22_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_22_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_22_13
#> [1] "ADX"      "-9085.99" "53"      
#> 
#> $sample_820_03$ENT_23_1
#> [1] "ENT"       "23"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_23_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME36"      
#>  [5] "FIRSTNAME36"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000036"
#> 
#> $sample_820_03$ENT_23_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_23_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_23_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_23_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_23_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_23_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_23_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_23_10
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_23_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_23_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_23_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_24_1
#> [1] "ENT"       "24"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_24_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME37"      
#>  [5] "FIRSTNAME37"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000037"
#> 
#> $sample_820_03$ENT_24_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_24_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_24_5
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_24_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_24_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_24_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "559.75"                         "9645.74"                       
#> 
#> $sample_820_03$ENT_24_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_24_10
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_24_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_24_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_24_13
#> [1] "ADX"      "-9085.99" "53"      
#> 
#> $sample_820_03$ENT_25_1
#> [1] "ENT"       "25"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_25_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME38"      
#>  [5] "FIRSTNAME38"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000038"
#> 
#> $sample_820_03$ENT_25_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_25_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_25_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_25_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_25_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_25_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "559.75"                         "9645.74"                       
#> 
#> $sample_820_03$ENT_25_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_25_10
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_25_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_25_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_25_13
#> [1] "ADX"      "-9085.99" "53"      
#> 
#> $sample_820_03$ENT_26_1
#> [1] "ENT"       "26"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_26_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME39"      
#>  [5] "FIRSTNAME39"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000039"
#> 
#> $sample_820_03$ENT_26_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_26_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_26_5
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_26_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_26_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_26_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "559.75"                         "9645.74"                       
#> 
#> $sample_820_03$ENT_26_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_26_10
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_26_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_26_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_26_13
#> [1] "ADX"      "-9085.99" "53"      
#> 
#> $sample_820_03$ENT_27_1
#> [1] "ENT"       "27"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_27_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME40"      
#>  [5] "FIRSTNAME40"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000040"
#> 
#> $sample_820_03$ENT_27_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_27_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_27_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_27_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_27_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_27_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_27_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_27_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_27_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_27_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_27_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_28_1
#> [1] "ENT"       "28"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_28_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME41"      
#>  [5] "FIRSTNAME41"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000041"
#> 
#> $sample_820_03$ENT_28_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_28_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_28_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_28_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_28_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_28_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_28_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_28_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_28_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_28_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_28_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_29_1
#> [1] "ENT"       "29"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_29_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME42"      
#>  [5] "FIRSTNAME42"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000042"
#> 
#> $sample_820_03$ENT_29_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_29_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_29_5
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_03$ENT_29_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_29_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_29_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_29_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_29_10
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_03$ENT_29_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_29_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_29_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_30_1
#> [1] "ENT"       "30"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_30_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME43"      
#>  [5] "FIRSTNAME43"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000043"
#> 
#> $sample_820_03$ENT_30_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_30_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_30_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_30_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_30_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_30_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_30_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_30_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_30_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_30_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_30_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_31_1
#> [1] "ENT"       "31"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_31_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME44"      
#>  [5] "FIRSTNAME44"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000044"
#> 
#> $sample_820_03$ENT_31_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_31_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_31_5
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_31_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_31_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_31_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_31_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_31_10
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_31_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_31_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_31_13
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_03$ENT_31_14
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_31_15
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_31_16
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_31_17
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_03$ENT_31_18
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_03$ENT_31_19
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_31_20
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_31_21
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_31_22
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251101-20251130"
#> 
#> $sample_820_03$ENT_31_23
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_03$ENT_31_24
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_31_25
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_31_26
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_31_27
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251001-20251031"
#> 
#> $sample_820_03$ENT_32_1
#> [1] "ENT"       "32"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_32_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME45"      
#>  [5] "FIRSTNAME45"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000045"
#> 
#> $sample_820_03$ENT_32_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_32_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_32_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_32_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_32_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_32_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "559.75"                         "9645.74"                       
#> 
#> $sample_820_03$ENT_32_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_32_10
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_32_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_32_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_32_13
#> [1] "ADX"      "-9085.99" "53"      
#> 
#> $sample_820_03$ENT_33_1
#> [1] "ENT"       "33"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_33_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME46"      
#>  [5] "FIRSTNAME46"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000046"
#> 
#> $sample_820_03$ENT_33_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_33_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_33_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_33_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_33_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_33_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_33_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_33_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_33_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_33_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_33_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_34_1
#> [1] "ENT"       "34"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_34_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME47"      
#>  [5] "FIRSTNAME47"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000047"
#> 
#> $sample_820_03$ENT_34_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_34_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_34_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_34_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_34_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_34_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_34_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_34_10
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_34_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_34_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_34_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_35_1
#> [1] "ENT"       "35"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_35_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME48"      
#>  [5] "FIRSTNAME48"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000048"
#> 
#> $sample_820_03$ENT_35_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_35_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_35_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_35_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_35_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_35_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "559.75"                         "9645.74"                       
#> 
#> $sample_820_03$ENT_35_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_35_10
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_35_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_35_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_35_13
#> [1] "ADX"      "-9085.99" "53"      
#> 
#> $sample_820_03$ENT_36_1
#> [1] "ENT"       "36"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_36_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME49"      
#>  [5] "FIRSTNAME49"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000049"
#> 
#> $sample_820_03$ENT_36_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_36_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_36_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_36_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_36_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_36_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_36_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_36_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_36_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_36_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_36_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_37_1
#> [1] "ENT"       "37"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_37_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME50"      
#>  [5] "FIRSTNAME50"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000050"
#> 
#> $sample_820_03$ENT_37_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_37_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_37_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_37_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_37_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_37_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_37_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_37_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_37_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_37_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_37_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_38_1
#> [1] "ENT"       "38"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_38_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME51"      
#>  [5] "FIRSTNAME51"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000051"
#> 
#> $sample_820_03$ENT_38_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_38_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_38_5
#> [1] "REF"  "ZZ"   "M3;1"
#> 
#> $sample_820_03$ENT_38_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_38_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_39_1
#> [1] "ENT"       "39"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_39_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME52"      
#>  [5] "FIRSTNAME52"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000052"
#> 
#> $sample_820_03$ENT_39_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_39_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_39_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_39_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_39_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_39_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_39_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_39_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_39_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_39_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_39_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_40_1
#> [1] "ENT"       "40"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_40_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME53"      
#>  [5] "FIRSTNAME53"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000053"
#> 
#> $sample_820_03$ENT_40_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_40_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_40_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_40_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_40_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_40_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_40_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_40_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_40_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_40_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_41_1
#> [1] "ENT"       "41"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_41_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME54"      
#>  [5] "FIRSTNAME54"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000054"
#> 
#> $sample_820_03$ENT_41_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_41_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_41_5
#> [1] "REF"  "ZZ"   "20;1"
#> 
#> $sample_820_03$ENT_41_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_41_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_41_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_41_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_41_10
#> [1] "REF"  "ZZ"   "20;1"
#> 
#> $sample_820_03$ENT_41_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_41_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_41_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_42_1
#> [1] "ENT"       "42"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_42_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME55"      
#>  [5] "FIRSTNAME55"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000055"
#> 
#> $sample_820_03$ENT_42_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_42_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_42_5
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_03$ENT_42_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_42_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_42_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_42_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_42_10
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_03$ENT_42_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_42_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_42_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_43_1
#> [1] "ENT"       "43"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_43_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME56"      
#>  [5] "FIRSTNAME56"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000056"
#> 
#> $sample_820_03$ENT_43_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_43_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_43_5
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_03$ENT_43_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_43_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_43_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_43_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_43_10
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_03$ENT_43_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_43_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_43_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_44_1
#> [1] "ENT"       "44"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_44_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME57"      
#>  [5] "FIRSTNAME57"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000057"
#> 
#> $sample_820_03$ENT_44_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_44_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_44_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_44_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_44_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_44_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_44_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_44_10
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_44_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_44_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_44_13
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_03$ENT_44_14
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_44_15
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_44_16
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_44_17
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_03$ENT_44_18
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_03$ENT_44_19
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_44_20
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_44_21
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_44_22
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251101-20251130"
#> 
#> $sample_820_03$ENT_44_23
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_03$ENT_44_24
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_44_25
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_44_26
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_44_27
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251001-20251031"
#> 
#> $sample_820_03$ENT_45_1
#> [1] "ENT"       "45"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_45_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME58"      
#>  [5] "FIRSTNAME58"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000058"
#> 
#> $sample_820_03$ENT_45_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_45_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_45_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_45_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_45_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_45_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_45_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_45_10
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_45_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_45_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_45_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_46_1
#> [1] "ENT"       "46"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_46_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME59"      
#>  [5] "FIRSTNAME59"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000059"
#> 
#> $sample_820_03$ENT_46_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_46_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_46_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_46_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_46_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_46_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_46_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_46_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_46_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_46_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_46_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_47_1
#> [1] "ENT"       "47"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_47_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME60"      
#>  [5] "FIRSTNAME60"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000060"
#> 
#> $sample_820_03$ENT_47_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_47_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_47_5
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_03$ENT_47_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_47_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_47_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_47_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_47_10
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_03$ENT_47_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_47_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_47_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_48_1
#> [1] "ENT"       "48"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_48_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME61"      
#>  [5] "FIRSTNAME61"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000061"
#> 
#> $sample_820_03$ENT_48_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_48_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_48_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_48_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_48_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_48_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_48_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_48_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_48_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_48_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_48_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_49_1
#> [1] "ENT"       "49"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_49_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME62"      
#>  [5] "FIRSTNAME62"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000062"
#> 
#> $sample_820_03$ENT_49_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_49_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_49_5
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_03$ENT_49_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_49_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_50_1
#> [1] "ENT"       "50"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_50_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME01"      
#>  [5] "FIRSTNAME01"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000001"
#> 
#> $sample_820_03$ENT_50_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "343.66"                        
#> 
#> $sample_820_03$ENT_50_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_50_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_03$ENT_50_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_50_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_50_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "185.89"                         "343.66"                        
#> 
#> $sample_820_03$ENT_50_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_50_10
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_03$ENT_50_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_50_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_50_13
#> [1] "ADX"     "-157.77" "53"     
#> 
#> $sample_820_03$ENT_51_1
#> [1] "ENT"       "51"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_51_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME63"      
#>  [5] "FIRSTNAME63"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000063"
#> 
#> $sample_820_03$ENT_51_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_51_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_51_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_03$ENT_51_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_51_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_52_1
#> [1] "ENT"       "52"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_52_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME64"      
#>  [5] "FIRSTNAME64"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000064"
#> 
#> $sample_820_03$ENT_52_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_52_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_52_5
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_52_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_52_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_52_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "559.75"                         "9645.74"                       
#> 
#> $sample_820_03$ENT_52_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_52_10
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_52_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_52_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_52_13
#> [1] "ADX"      "-9085.99" "53"      
#> 
#> $sample_820_03$ENT_53_1
#> [1] "ENT"       "53"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_53_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME65"      
#>  [5] "FIRSTNAME65"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000065"
#> 
#> $sample_820_03$ENT_53_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_53_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_53_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_53_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_53_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_53_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "559.75"                         "9645.74"                       
#> 
#> $sample_820_03$ENT_53_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_53_10
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_03$ENT_53_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_53_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_53_13
#> [1] "ADX"      "-9085.99" "53"      
#> 
#> $sample_820_03$ENT_54_1
#> [1] "ENT"       "54"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_54_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME66"      
#>  [5] "FIRSTNAME66"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000066"
#> 
#> $sample_820_03$ENT_54_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_54_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_54_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_54_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_54_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_54_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_54_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_54_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_54_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_54_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_54_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_55_1
#> [1] "ENT"       "55"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_55_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME02"      
#>  [5] "FIRSTNAME02"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000002"
#> 
#> $sample_820_03$ENT_55_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "2314.98"                       
#> 
#> $sample_820_03$ENT_55_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_55_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_03$ENT_55_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_55_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_55_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "1315.52"                        "2314.98"                       
#> 
#> $sample_820_03$ENT_55_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_55_10
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_03$ENT_55_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_55_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_55_13
#> [1] "ADX"     "-999.46" "53"     
#> 
#> $sample_820_03$ENT_56_1
#> [1] "ENT"       "56"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_56_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME67"      
#>  [5] "FIRSTNAME67"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000067"
#> 
#> $sample_820_03$ENT_56_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_56_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_56_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_56_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_56_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_56_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_56_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_56_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_56_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_56_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_56_13
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_03$ENT_56_14
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_56_15
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_56_16
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_56_17
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_03$ENT_56_18
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_03$ENT_56_19
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_56_20
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_56_21
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_56_22
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251101-20251130"
#> 
#> $sample_820_03$ENT_56_23
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_03$ENT_56_24
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_56_25
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_56_26
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_56_27
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251001-20251031"
#> 
#> $sample_820_03$ENT_57_1
#> [1] "ENT"       "57"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_57_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME68"      
#>  [5] "FIRSTNAME68"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000068"
#> 
#> $sample_820_03$ENT_57_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_57_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_57_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_57_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_57_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_57_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_57_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_57_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_57_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_57_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_57_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_58_1
#> [1] "ENT"       "58"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_58_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME03"      
#>  [5] "FIRSTNAME03"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000003"
#> 
#> $sample_820_03$ENT_58_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "2314.98"                       
#> 
#> $sample_820_03$ENT_58_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_58_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_03$ENT_58_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_58_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_58_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "1315.52"                        "2314.98"                       
#> 
#> $sample_820_03$ENT_58_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_58_10
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_03$ENT_58_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_58_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_58_13
#> [1] "ADX"     "-999.46" "53"     
#> 
#> $sample_820_03$ENT_59_1
#> [1] "ENT"       "59"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_59_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME13"      
#>  [5] "FIRSTNAME13"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000013"
#> 
#> $sample_820_03$ENT_59_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "2314.98"                       
#> 
#> $sample_820_03$ENT_59_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_59_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_03$ENT_59_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_59_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_59_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "2314.98"                       
#> 
#> $sample_820_03$ENT_59_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_59_10
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_03$ENT_59_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_59_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_60_1
#> [1] "ENT"       "60"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_60_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME69"      
#>  [5] "FIRSTNAME69"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000069"
#> 
#> $sample_820_03$ENT_60_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_60_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_60_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_03$ENT_60_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_60_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_61_1
#> [1] "ENT"       "61"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_61_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME70"      
#>  [5] "FIRSTNAME70"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000070"
#> 
#> $sample_820_03$ENT_61_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_61_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_61_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_03$ENT_61_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_61_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_62_1
#> [1] "ENT"       "62"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_62_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME71"      
#>  [5] "FIRSTNAME71"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000071"
#> 
#> $sample_820_03$ENT_62_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_62_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_62_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_03$ENT_62_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_62_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_63_1
#> [1] "ENT"       "63"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_63_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME72"      
#>  [5] "FIRSTNAME72"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000072"
#> 
#> $sample_820_03$ENT_63_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_63_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_63_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_63_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_63_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_63_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "559.75"                         "9645.74"                       
#> 
#> $sample_820_03$ENT_63_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_63_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_63_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_63_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_63_13
#> [1] "ADX"      "-9085.99" "53"      
#> 
#> $sample_820_03$ENT_64_1
#> [1] "ENT"       "64"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_64_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME73"      
#>  [5] "FIRSTNAME73"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000073"
#> 
#> $sample_820_03$ENT_64_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_64_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_64_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_03$ENT_64_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_64_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_65_1
#> [1] "ENT"       "65"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_65_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME04"      
#>  [5] "FIRSTNAME04"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000004"
#> 
#> $sample_820_03$ENT_65_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "2314.98"                       
#> 
#> $sample_820_03$ENT_65_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_65_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_03$ENT_65_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_65_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_65_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "1315.52"                        "2314.98"                       
#> 
#> $sample_820_03$ENT_65_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_65_10
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_03$ENT_65_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_65_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_65_13
#> [1] "ADX"     "-999.46" "53"     
#> 
#> $sample_820_03$ENT_66_1
#> [1] "ENT"       "66"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_66_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME05"      
#>  [5] "FIRSTNAME05"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000005"
#> 
#> $sample_820_03$ENT_66_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "2314.98"                       
#> 
#> $sample_820_03$ENT_66_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_66_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_03$ENT_66_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_66_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_66_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "1315.52"                        "2314.98"                       
#> 
#> $sample_820_03$ENT_66_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_66_10
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_03$ENT_66_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_66_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_66_13
#> [1] "ADX"     "-999.46" "53"     
#> 
#> $sample_820_03$ENT_67_1
#> [1] "ENT"       "67"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_67_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME06"      
#>  [5] "FIRSTNAME06"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000006"
#> 
#> $sample_820_03$ENT_67_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_67_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_67_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_67_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_67_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_67_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "-999.46"                       
#> 
#> $sample_820_03$ENT_67_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_67_10
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_03$ENT_67_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_67_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_67_13
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_67_14
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_67_15
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_67_16
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_67_17
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_68_1
#> [1] "ENT"       "68"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_68_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME07"      
#>  [5] "FIRSTNAME07"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000007"
#> 
#> $sample_820_03$ENT_68_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "2314.98"                       
#> 
#> $sample_820_03$ENT_68_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_68_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_03$ENT_68_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_68_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_68_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "1315.52"                        "2314.98"                       
#> 
#> $sample_820_03$ENT_68_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_68_10
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_03$ENT_68_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_68_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_68_13
#> [1] "ADX"     "-999.46" "53"     
#> 
#> $sample_820_03$ENT_69_1
#> [1] "ENT"       "69"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_69_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME08"      
#>  [5] "FIRSTNAME08"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000008"
#> 
#> $sample_820_03$ENT_69_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "2314.98"                       
#> 
#> $sample_820_03$ENT_69_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_69_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_03$ENT_69_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_69_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_69_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "1315.52"                        "2314.98"                       
#> 
#> $sample_820_03$ENT_69_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_69_10
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_03$ENT_69_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_69_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_69_13
#> [1] "ADX"     "-999.46" "53"     
#> 
#> $sample_820_03$ENT_70_1
#> [1] "ENT"       "70"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_70_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME74"      
#>  [5] "FIRSTNAME74"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000074"
#> 
#> $sample_820_03$ENT_70_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_70_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_70_5
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_70_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_70_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_70_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "559.75"                         "9645.74"                       
#> 
#> $sample_820_03$ENT_70_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_70_10
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_70_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_70_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_70_13
#> [1] "ADX"      "-9085.99" "53"      
#> 
#> $sample_820_03$ENT_71_1
#> [1] "ENT"       "71"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_71_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME75"      
#>  [5] "FIRSTNAME75"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000075"
#> 
#> $sample_820_03$ENT_71_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_71_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_71_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_71_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_71_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_71_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_71_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_71_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_71_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_71_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_71_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_72_1
#> [1] "ENT"       "72"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_72_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME76"      
#>  [5] "FIRSTNAME76"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000076"
#> 
#> $sample_820_03$ENT_72_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_72_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_72_5
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_03$ENT_72_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_72_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_72_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_72_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_72_10
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_03$ENT_72_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_72_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_72_13
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_03$ENT_72_14
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_72_15
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_72_16
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_72_17
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_03$ENT_73_1
#> [1] "ENT"       "73"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_73_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME09"      
#>  [5] "FIRSTNAME09"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000009"
#> 
#> $sample_820_03$ENT_73_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "2314.98"                       
#> 
#> $sample_820_03$ENT_73_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_73_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_03$ENT_73_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_73_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_73_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "1315.52"                        "2314.98"                       
#> 
#> $sample_820_03$ENT_73_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_73_10
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_03$ENT_73_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_73_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_73_13
#> [1] "ADX"     "-999.46" "53"     
#> 
#> $sample_820_03$ENT_74_1
#> [1] "ENT"       "74"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_74_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME10"      
#>  [5] "FIRSTNAME10"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000010"
#> 
#> $sample_820_03$ENT_74_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "1315.52"                        "2314.98"                       
#> 
#> $sample_820_03$ENT_74_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_74_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_03$ENT_74_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_74_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_74_8
#> [1] "ADX"     "-999.46" "53"     
#> 
#> $sample_820_03$ENT_75_1
#> [1] "ENT"       "75"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_75_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME77"      
#>  [5] "FIRSTNAME77"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000077"
#> 
#> $sample_820_03$ENT_75_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_75_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_75_5
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_03$ENT_75_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_75_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_75_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_75_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_75_10
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_03$ENT_75_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_75_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_75_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_76_1
#> [1] "ENT"       "76"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_76_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME78"      
#>  [5] "FIRSTNAME78"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000078"
#> 
#> $sample_820_03$ENT_76_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_76_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_76_5
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_03$ENT_76_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_76_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_76_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_76_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_76_10
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_03$ENT_76_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_76_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_76_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_77_1
#> [1] "ENT"       "77"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_77_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME79"      
#>  [5] "FIRSTNAME79"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000079"
#> 
#> $sample_820_03$ENT_77_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_77_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_77_5
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_77_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_77_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_77_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "559.75"                         "9645.74"                       
#> 
#> $sample_820_03$ENT_77_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_77_10
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_03$ENT_77_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_77_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_77_13
#> [1] "ADX"      "-9085.99" "53"      
#> 
#> $sample_820_03$ENT_78_1
#> [1] "ENT"       "78"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_78_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME80"      
#>  [5] "FIRSTNAME80"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000080"
#> 
#> $sample_820_03$ENT_78_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_78_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_78_5
#> [1] "REF"  "ZZ"   "16;1"
#> 
#> $sample_820_03$ENT_78_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_78_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_78_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_78_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_78_10
#> [1] "REF"  "ZZ"   "16;1"
#> 
#> $sample_820_03$ENT_78_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_78_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_78_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_79_1
#> [1] "ENT"       "79"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_79_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME81"      
#>  [5] "FIRSTNAME81"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000081"
#> 
#> $sample_820_03$ENT_79_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_79_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_79_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_79_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_79_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_79_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_79_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_79_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_79_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_79_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_79_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_80_1
#> [1] "ENT"       "80"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_80_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME11"      
#>  [5] "FIRSTNAME11"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000011"
#> 
#> $sample_820_03$ENT_80_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "2314.98"                       
#> 
#> $sample_820_03$ENT_80_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_80_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_03$ENT_80_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_80_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_80_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "1315.52"                        "2314.98"                       
#> 
#> $sample_820_03$ENT_80_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_80_10
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_03$ENT_80_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_80_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_80_13
#> [1] "ADX"     "-999.46" "53"     
#> 
#> $sample_820_03$ENT_81_1
#> [1] "ENT"       "81"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_81_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME82"      
#>  [5] "FIRSTNAME82"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000082"
#> 
#> $sample_820_03$ENT_81_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_81_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_81_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_81_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_81_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_81_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_81_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_81_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_81_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_81_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_81_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_82_1
#> [1] "ENT"       "82"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_82_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME83"      
#>  [5] "FIRSTNAME83"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000083"
#> 
#> $sample_820_03$ENT_82_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_82_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_82_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_82_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_82_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_83_1
#> [1] "ENT"       "83"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_83_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME84"      
#>  [5] "FIRSTNAME84"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000084"
#> 
#> $sample_820_03$ENT_83_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_83_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_83_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_03$ENT_83_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_83_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_84_1
#> [1] "ENT"       "84"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_84_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME85"      
#>  [5] "FIRSTNAME85"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000085"
#> 
#> $sample_820_03$ENT_84_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_84_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_84_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_84_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_84_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_84_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_84_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_84_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_84_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_84_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_84_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_85_1
#> [1] "ENT"       "85"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_85_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME12"      
#>  [5] "FIRSTNAME12"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000012"
#> 
#> $sample_820_03$ENT_85_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "343.66"                        
#> 
#> $sample_820_03$ENT_85_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_85_5
#> [1] "REF"  "ZZ"   "17;2"
#> 
#> $sample_820_03$ENT_85_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_85_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_86_1
#> [1] "ENT"       "86"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_86_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME86"      
#>  [5] "FIRSTNAME86"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000086"
#> 
#> $sample_820_03$ENT_86_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_86_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_86_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_03$ENT_86_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_86_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_87_1
#> [1] "ENT"       "87"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_87_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME87"      
#>  [5] "FIRSTNAME87"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000087"
#> 
#> $sample_820_03$ENT_87_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "9645.74"                       
#> 
#> $sample_820_03$ENT_87_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_87_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_03$ENT_87_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_03$ENT_87_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_88_1
#> [1] "ENT"       "88"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_88_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME88"      
#>  [5] "FIRSTNAME88"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000088"
#> 
#> $sample_820_03$ENT_88_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_88_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_88_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_03$ENT_88_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_88_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_89_1
#> [1] "ENT"       "89"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_89_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME89"      
#>  [5] "FIRSTNAME89"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000089"
#> 
#> $sample_820_03$ENT_89_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_89_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_89_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_03$ENT_89_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_89_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_90_1
#> [1] "ENT"       "90"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_90_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME90"      
#>  [5] "FIRSTNAME90"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000090"
#> 
#> $sample_820_03$ENT_90_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_90_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_90_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_03$ENT_90_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_90_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_91_1
#> [1] "ENT"       "91"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_91_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME91"      
#>  [5] "FIRSTNAME91"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000091"
#> 
#> $sample_820_03$ENT_91_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_91_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_91_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_03$ENT_91_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_91_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_92_1
#> [1] "ENT"       "92"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_92_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME92"      
#>  [5] "FIRSTNAME92"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000092"
#> 
#> $sample_820_03$ENT_92_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_92_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_92_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_92_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_92_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260201-20260228"
#> 
#> $sample_820_03$ENT_92_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "468.79"                         "5727.65"                       
#> 
#> $sample_820_03$ENT_92_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_92_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_03$ENT_92_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_92_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$ENT_92_13
#> [1] "ADX"      "-5258.86" "53"      
#> 
#> $sample_820_03$ENT_93_1
#> [1] "ENT"       "93"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_03$ENT_93_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME93"      
#>  [5] "FIRSTNAME93"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000093"
#> 
#> $sample_820_03$ENT_93_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2602200042000P" NA                              
#> [5] "5727.65"                       
#> 
#> $sample_820_03$ENT_93_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_03$ENT_93_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_03$ENT_93_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_03$ENT_93_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_03$SE
#> [1] "SE"   "1142" "0001"
#> 
#> $sample_820_03$GE
#> [1] "GE"    "1"     "44272"
#> 
#> $sample_820_03$IEA
#> [1] "IEA"       "1"         "000059659"
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
#> $sample_820_05
#> $sample_820_05$ISA
#>  [1] "ISA"        "00"         NA           "00"         NA          
#>  [6] "ZZ"         "TEST-PAYER" "30"         "TEST-PAYEE" "260217"    
#> [11] "0936"       "+"          "00501"      "000059431"  "0"         
#> [16] "P"          ":"         
#> 
#> $sample_820_05$GS
#> [1] "GS"         "RA"         "TEST-PAYER" "TEST-PAYEE" "20260217"  
#> [6] "093627"     "44044"      "X"          "005010X218"
#> 
#> $sample_820_05$ST
#> [1] "ST"         "820"        "0001"       "005010X218"
#> 
#> $sample_820_05$BPR
#>  [1] "BPR"        "I"          "499187.57"  "C"          "NON"       
#>  [6] NA           NA           NA           NA           NA          
#> [11] "68-0317191" NA           NA           NA           NA          
#> [16] NA           "20260212"  
#> 
#> $sample_820_05$TRN
#> [1] "TRN"             "3"               "TESTTRN05000001"
#> 
#> $sample_820_05$REF14
#> [1] "REF"        "14"         "0000245023"
#> 
#> $sample_820_05$N1PE
#> [1] "N1"                      "PE"                     
#> [3] "TEST PAYEE ORGANIZATION"
#> 
#> $sample_820_05$N3PE
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_820_05$N4PE
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_820_05$N1PR
#> [1] "N1"                "PR"                "TEST PAYER AGENCY"
#> 
#> $sample_820_05$N3PR
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_820_05$N4PR
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_820_05$ENT_1_1
#> [1] "ENT"       "1"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_1_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME14"      
#>  [5] "FIRSTNAME14"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000014"
#> 
#> $sample_820_05$ENT_1_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_1_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_1_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_05$ENT_1_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_1_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_2_1
#> [1] "ENT"       "2"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_2_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME15"      
#>  [5] "FIRSTNAME15"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000015"
#> 
#> $sample_820_05$ENT_2_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_2_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_2_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_05$ENT_2_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_2_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_3_1
#> [1] "ENT"       "3"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_3_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME17"      
#>  [5] "FIRSTNAME17"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000017"
#> 
#> $sample_820_05$ENT_3_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_3_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_3_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_3_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_3_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_4_1
#> [1] "ENT"       "4"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_4_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME18"      
#>  [5] "FIRSTNAME18"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000018"
#> 
#> $sample_820_05$ENT_4_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_4_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_4_5
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_05$ENT_4_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_4_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_5_1
#> [1] "ENT"       "5"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_5_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME19"      
#>  [5] "FIRSTNAME19"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000019"
#> 
#> $sample_820_05$ENT_5_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_5_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_5_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_05$ENT_5_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_5_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_6_1
#> [1] "ENT"       "6"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_6_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME20"      
#>  [5] "FIRSTNAME20"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000020"
#> 
#> $sample_820_05$ENT_6_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_6_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_6_5
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_05$ENT_6_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_6_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_7_1
#> [1] "ENT"       "7"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_7_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME21"      
#>  [5] "FIRSTNAME21"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000021"
#> 
#> $sample_820_05$ENT_7_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_7_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_7_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_05$ENT_7_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_7_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_8_1
#> [1] "ENT"       "8"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_8_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME22"      
#>  [5] "FIRSTNAME22"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000022"
#> 
#> $sample_820_05$ENT_8_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_8_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_8_5
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_05$ENT_8_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_8_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_9_1
#> [1] "ENT"       "9"         "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_9_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME23"      
#>  [5] "FIRSTNAME23"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000023"
#> 
#> $sample_820_05$ENT_9_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_9_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_9_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_9_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_9_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_10_1
#> [1] "ENT"       "10"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_10_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME24"      
#>  [5] "FIRSTNAME24"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000024"
#> 
#> $sample_820_05$ENT_10_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_10_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_10_5
#> [1] "REF"  "ZZ"   "6H;1"
#> 
#> $sample_820_05$ENT_10_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_10_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_10_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_10_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_10_10
#> [1] "REF"  "ZZ"   "6H;1"
#> 
#> $sample_820_05$ENT_10_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_10_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_11_1
#> [1] "ENT"       "11"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_11_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME25"      
#>  [5] "FIRSTNAME25"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000025"
#> 
#> $sample_820_05$ENT_11_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_11_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_11_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_05$ENT_11_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_11_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_12_1
#> [1] "ENT"       "12"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_12_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME26"      
#>  [5] "FIRSTNAME26"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000026"
#> 
#> $sample_820_05$ENT_12_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_12_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_12_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_12_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_12_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_13_1
#> [1] "ENT"       "13"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_13_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME28"      
#>  [5] "FIRSTNAME28"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000028"
#> 
#> $sample_820_05$ENT_13_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_13_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_13_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_13_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_13_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_14_1
#> [1] "ENT"       "14"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_14_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME29"      
#>  [5] "FIRSTNAME29"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000029"
#> 
#> $sample_820_05$ENT_14_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_14_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_14_5
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_05$ENT_14_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_14_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_15_1
#> [1] "ENT"       "15"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_15_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME30"      
#>  [5] "FIRSTNAME30"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000030"
#> 
#> $sample_820_05$ENT_15_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_15_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_15_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_15_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_15_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_16_1
#> [1] "ENT"       "16"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_16_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME31"      
#>  [5] "FIRSTNAME31"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000031"
#> 
#> $sample_820_05$ENT_16_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_16_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_16_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_05$ENT_16_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_16_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_16_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_16_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_16_10
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_05$ENT_16_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_16_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_17_1
#> [1] "ENT"       "17"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_17_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME32"      
#>  [5] "FIRSTNAME32"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000032"
#> 
#> $sample_820_05$ENT_17_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_17_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_17_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_17_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_17_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_18_1
#> [1] "ENT"       "18"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_18_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME33"      
#>  [5] "FIRSTNAME33"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000033"
#> 
#> $sample_820_05$ENT_18_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_18_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_18_5
#> [1] "REF"  "ZZ"   "20;1"
#> 
#> $sample_820_05$ENT_18_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_18_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_19_1
#> [1] "ENT"       "19"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_19_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME34"      
#>  [5] "FIRSTNAME34"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000034"
#> 
#> $sample_820_05$ENT_19_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_19_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_19_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_05$ENT_19_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_19_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_20_1
#> [1] "ENT"       "20"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_20_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME35"      
#>  [5] "FIRSTNAME35"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000035"
#> 
#> $sample_820_05$ENT_20_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_20_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_20_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_20_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_20_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_21_1
#> [1] "ENT"       "21"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_21_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME36"      
#>  [5] "FIRSTNAME36"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000036"
#> 
#> $sample_820_05$ENT_21_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_21_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_21_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_05$ENT_21_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_21_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_22_1
#> [1] "ENT"       "22"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_22_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME37"      
#>  [5] "FIRSTNAME37"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000037"
#> 
#> $sample_820_05$ENT_22_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_22_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_22_5
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_05$ENT_22_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_22_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_22_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_22_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_22_10
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_05$ENT_22_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_22_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_23_1
#> [1] "ENT"       "23"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_23_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME38"      
#>  [5] "FIRSTNAME38"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000038"
#> 
#> $sample_820_05$ENT_23_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_23_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_23_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_05$ENT_23_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_23_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_24_1
#> [1] "ENT"       "24"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_24_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME39"      
#>  [5] "FIRSTNAME39"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000039"
#> 
#> $sample_820_05$ENT_24_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_24_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_24_5
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_05$ENT_24_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_24_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_24_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_24_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_24_10
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_05$ENT_24_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_24_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_25_1
#> [1] "ENT"       "25"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_25_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME40"      
#>  [5] "FIRSTNAME40"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000040"
#> 
#> $sample_820_05$ENT_25_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_25_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_25_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_25_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_25_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_25_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_25_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_25_10
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_25_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_25_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_26_1
#> [1] "ENT"       "26"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_26_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME41"      
#>  [5] "FIRSTNAME41"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000041"
#> 
#> $sample_820_05$ENT_26_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_26_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_26_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_26_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_26_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_27_1
#> [1] "ENT"       "27"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_27_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME42"      
#>  [5] "FIRSTNAME42"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000042"
#> 
#> $sample_820_05$ENT_27_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_27_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_27_5
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_05$ENT_27_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_27_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_28_1
#> [1] "ENT"       "28"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_28_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME43"      
#>  [5] "FIRSTNAME43"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000043"
#> 
#> $sample_820_05$ENT_28_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_28_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_28_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_28_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_28_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_29_1
#> [1] "ENT"       "29"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_29_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME45"      
#>  [5] "FIRSTNAME45"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000045"
#> 
#> $sample_820_05$ENT_29_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_29_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_29_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_05$ENT_29_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_29_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_30_1
#> [1] "ENT"       "30"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_30_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME46"      
#>  [5] "FIRSTNAME46"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000046"
#> 
#> $sample_820_05$ENT_30_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_30_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_30_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_30_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_30_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_31_1
#> [1] "ENT"       "31"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_31_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME47"      
#>  [5] "FIRSTNAME47"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000047"
#> 
#> $sample_820_05$ENT_31_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_31_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_31_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_05$ENT_31_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_31_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_32_1
#> [1] "ENT"       "32"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_32_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME48"      
#>  [5] "FIRSTNAME48"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000048"
#> 
#> $sample_820_05$ENT_32_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_32_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_32_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_05$ENT_32_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_32_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_33_1
#> [1] "ENT"       "33"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_33_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME49"      
#>  [5] "FIRSTNAME49"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000049"
#> 
#> $sample_820_05$ENT_33_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_33_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_33_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_33_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_33_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_34_1
#> [1] "ENT"       "34"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_34_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME50"      
#>  [5] "FIRSTNAME50"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000050"
#> 
#> $sample_820_05$ENT_34_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_34_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_34_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_34_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_34_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_35_1
#> [1] "ENT"       "35"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_35_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME52"      
#>  [5] "FIRSTNAME52"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000052"
#> 
#> $sample_820_05$ENT_35_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_35_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_35_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_35_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_35_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_36_1
#> [1] "ENT"       "36"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_36_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME54"      
#>  [5] "FIRSTNAME54"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000054"
#> 
#> $sample_820_05$ENT_36_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_36_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_36_5
#> [1] "REF"  "ZZ"   "20;1"
#> 
#> $sample_820_05$ENT_36_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_36_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_37_1
#> [1] "ENT"       "37"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_37_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME55"      
#>  [5] "FIRSTNAME55"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000055"
#> 
#> $sample_820_05$ENT_37_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_37_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_37_5
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_05$ENT_37_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_37_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_38_1
#> [1] "ENT"       "38"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_38_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME56"      
#>  [5] "FIRSTNAME56"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000056"
#> 
#> $sample_820_05$ENT_38_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_38_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_38_5
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_05$ENT_38_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_38_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_39_1
#> [1] "ENT"       "39"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_39_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME58"      
#>  [5] "FIRSTNAME58"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000058"
#> 
#> $sample_820_05$ENT_39_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_39_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_39_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_05$ENT_39_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_39_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_40_1
#> [1] "ENT"       "40"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_40_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME59"      
#>  [5] "FIRSTNAME59"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000059"
#> 
#> $sample_820_05$ENT_40_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_40_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_40_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_40_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_40_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_40_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_40_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_40_10
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_05$ENT_40_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_40_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_41_1
#> [1] "ENT"       "41"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_41_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME60"      
#>  [5] "FIRSTNAME60"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000060"
#> 
#> $sample_820_05$ENT_41_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_41_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_41_5
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_05$ENT_41_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_41_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_42_1
#> [1] "ENT"       "42"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_42_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME61"      
#>  [5] "FIRSTNAME61"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000061"
#> 
#> $sample_820_05$ENT_42_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_42_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_42_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_42_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_42_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_43_1
#> [1] "ENT"       "43"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_43_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME01"      
#>  [5] "FIRSTNAME01"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000001"
#> 
#> $sample_820_05$ENT_43_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "157.77"                        
#> 
#> $sample_820_05$ENT_43_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_43_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_05$ENT_43_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_43_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_43_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "157.77"                        
#> 
#> $sample_820_05$ENT_43_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_43_10
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_05$ENT_43_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_43_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_43_13
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "-999.46"                       
#> 
#> $sample_820_05$ENT_43_14
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_43_15
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_05$ENT_43_16
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_43_17
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_43_18
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "157.77"                        
#> 
#> $sample_820_05$ENT_43_19
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_43_20
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_05$ENT_43_21
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_43_22
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251101-20251130"
#> 
#> $sample_820_05$ENT_43_23
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "-999.46"                       
#> 
#> $sample_820_05$ENT_43_24
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_43_25
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_05$ENT_43_26
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_43_27
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251101-20251130"
#> 
#> $sample_820_05$ENT_44_1
#> [1] "ENT"       "44"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_44_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME63"      
#>  [5] "FIRSTNAME63"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000063"
#> 
#> $sample_820_05$ENT_44_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_44_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_44_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_05$ENT_44_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_44_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_45_1
#> [1] "ENT"       "45"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_45_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME64"      
#>  [5] "FIRSTNAME64"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000064"
#> 
#> $sample_820_05$ENT_45_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_45_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_45_5
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_05$ENT_45_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_45_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_46_1
#> [1] "ENT"       "46"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_46_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME65"      
#>  [5] "FIRSTNAME65"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000065"
#> 
#> $sample_820_05$ENT_46_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_46_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_46_5
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_05$ENT_46_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_46_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_46_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_46_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_46_10
#> [1] "REF"  "ZZ"   "60;1"
#> 
#> $sample_820_05$ENT_46_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_46_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_47_1
#> [1] "ENT"       "47"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_47_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME66"      
#>  [5] "FIRSTNAME66"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000066"
#> 
#> $sample_820_05$ENT_47_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_47_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_47_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_47_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_47_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_48_1
#> [1] "ENT"       "48"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_48_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME02"      
#>  [5] "FIRSTNAME02"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000002"
#> 
#> $sample_820_05$ENT_48_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "999.46"                        
#> 
#> $sample_820_05$ENT_48_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_48_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_05$ENT_48_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_48_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_49_1
#> [1] "ENT"       "49"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_49_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME68"      
#>  [5] "FIRSTNAME68"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000068"
#> 
#> $sample_820_05$ENT_49_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_49_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_49_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_49_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_49_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_49_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_49_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_49_10
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_05$ENT_49_11
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_49_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_50_1
#> [1] "ENT"       "50"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_50_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME03"      
#>  [5] "FIRSTNAME03"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000003"
#> 
#> $sample_820_05$ENT_50_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "999.46"                        
#> 
#> $sample_820_05$ENT_50_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_50_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_05$ENT_50_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_50_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_51_1
#> [1] "ENT"       "51"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_51_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME69"      
#>  [5] "FIRSTNAME69"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000069"
#> 
#> $sample_820_05$ENT_51_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_51_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_51_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_05$ENT_51_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_51_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_52_1
#> [1] "ENT"       "52"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_52_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME70"      
#>  [5] "FIRSTNAME70"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000070"
#> 
#> $sample_820_05$ENT_52_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_52_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_52_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_05$ENT_52_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_52_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_53_1
#> [1] "ENT"       "53"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_53_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME72"      
#>  [5] "FIRSTNAME72"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000072"
#> 
#> $sample_820_05$ENT_53_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_53_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_53_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_53_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_53_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_54_1
#> [1] "ENT"       "54"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_54_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME73"      
#>  [5] "FIRSTNAME73"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000073"
#> 
#> $sample_820_05$ENT_54_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_54_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_54_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_05$ENT_54_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_54_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_55_1
#> [1] "ENT"       "55"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_55_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME04"      
#>  [5] "FIRSTNAME04"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000004"
#> 
#> $sample_820_05$ENT_55_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "999.46"                        
#> 
#> $sample_820_05$ENT_55_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_55_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_05$ENT_55_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_55_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_56_1
#> [1] "ENT"       "56"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_56_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME05"      
#>  [5] "FIRSTNAME05"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000005"
#> 
#> $sample_820_05$ENT_56_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "999.46"                        
#> 
#> $sample_820_05$ENT_56_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_56_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_05$ENT_56_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_56_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_57_1
#> [1] "ENT"       "57"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_57_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME06"      
#>  [5] "FIRSTNAME06"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000006"
#> 
#> $sample_820_05$ENT_57_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "999.46"                        
#> 
#> $sample_820_05$ENT_57_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_57_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_05$ENT_57_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_57_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_58_1
#> [1] "ENT"       "58"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_58_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME07"      
#>  [5] "FIRSTNAME07"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000007"
#> 
#> $sample_820_05$ENT_58_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "999.46"                        
#> 
#> $sample_820_05$ENT_58_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_58_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_05$ENT_58_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_58_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_59_1
#> [1] "ENT"       "59"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_59_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME08"      
#>  [5] "FIRSTNAME08"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000008"
#> 
#> $sample_820_05$ENT_59_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "999.46"                        
#> 
#> $sample_820_05$ENT_59_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_59_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_05$ENT_59_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_59_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_60_1
#> [1] "ENT"       "60"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_60_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME74"      
#>  [5] "FIRSTNAME74"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000074"
#> 
#> $sample_820_05$ENT_60_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_60_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_60_5
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_05$ENT_60_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_60_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_61_1
#> [1] "ENT"       "61"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_61_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME75"      
#>  [5] "FIRSTNAME75"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000075"
#> 
#> $sample_820_05$ENT_61_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_61_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_61_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_61_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_61_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_62_1
#> [1] "ENT"       "62"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_62_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME09"      
#>  [5] "FIRSTNAME09"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000009"
#> 
#> $sample_820_05$ENT_62_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "999.46"                        
#> 
#> $sample_820_05$ENT_62_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_62_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_05$ENT_62_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_62_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_63_1
#> [1] "ENT"       "63"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_63_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME10"      
#>  [5] "FIRSTNAME10"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000010"
#> 
#> $sample_820_05$ENT_63_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "999.46"                        
#> 
#> $sample_820_05$ENT_63_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_63_5
#> [1] "REF"  "ZZ"   "1H;2"
#> 
#> $sample_820_05$ENT_63_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_63_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_64_1
#> [1] "ENT"       "64"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_64_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME77"      
#>  [5] "FIRSTNAME77"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000077"
#> 
#> $sample_820_05$ENT_64_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_64_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_64_5
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_05$ENT_64_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_64_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_65_1
#> [1] "ENT"       "65"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_65_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME78"      
#>  [5] "FIRSTNAME78"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000078"
#> 
#> $sample_820_05$ENT_65_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_65_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_65_5
#> [1] "REF"  "ZZ"   "10;1"
#> 
#> $sample_820_05$ENT_65_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_65_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_66_1
#> [1] "ENT"       "66"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_66_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME79"      
#>  [5] "FIRSTNAME79"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000079"
#> 
#> $sample_820_05$ENT_66_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_66_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_66_5
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_05$ENT_66_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_66_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_66_8
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_66_9
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_66_10
#> [1] "REF"  "ZZ"   "M1;1"
#> 
#> $sample_820_05$ENT_66_11
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_66_12
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_67_1
#> [1] "ENT"       "67"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_67_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME80"      
#>  [5] "FIRSTNAME80"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000080"
#> 
#> $sample_820_05$ENT_67_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_67_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_67_5
#> [1] "REF"  "ZZ"   "16;1"
#> 
#> $sample_820_05$ENT_67_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_67_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_68_1
#> [1] "ENT"       "68"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_68_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME81"      
#>  [5] "FIRSTNAME81"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000081"
#> 
#> $sample_820_05$ENT_68_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_68_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_68_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_68_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_68_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_69_1
#> [1] "ENT"       "69"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_69_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME11"      
#>  [5] "FIRSTNAME11"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000011"
#> 
#> $sample_820_05$ENT_69_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "999.46"                        
#> 
#> $sample_820_05$ENT_69_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_69_5
#> [1] "REF"  "ZZ"   "M1;2"
#> 
#> $sample_820_05$ENT_69_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_69_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_70_1
#> [1] "ENT"       "70"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_70_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME82"      
#>  [5] "FIRSTNAME82"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000082"
#> 
#> $sample_820_05$ENT_70_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_70_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_70_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_70_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_70_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_71_1
#> [1] "ENT"       "71"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_71_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME84"      
#>  [5] "FIRSTNAME84"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000084"
#> 
#> $sample_820_05$ENT_71_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_71_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_71_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_05$ENT_71_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_71_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_72_1
#> [1] "ENT"       "72"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_72_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME85"      
#>  [5] "FIRSTNAME85"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000085"
#> 
#> $sample_820_05$ENT_72_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_72_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_72_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_72_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_72_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_73_1
#> [1] "ENT"       "73"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_73_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME12"      
#>  [5] "FIRSTNAME12"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000012"
#> 
#> $sample_820_05$ENT_73_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "157.77"                        
#> 
#> $sample_820_05$ENT_73_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_73_5
#> [1] "REF"  "ZZ"   "17;2"
#> 
#> $sample_820_05$ENT_73_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_73_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_74_1
#> [1] "ENT"       "74"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_74_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME86"      
#>  [5] "FIRSTNAME86"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000086"
#> 
#> $sample_820_05$ENT_74_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_74_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_74_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_05$ENT_74_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_74_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_75_1
#> [1] "ENT"       "75"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_75_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME87"      
#>  [5] "FIRSTNAME87"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000087"
#> 
#> $sample_820_05$ENT_75_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "9085.99"                       
#> 
#> $sample_820_05$ENT_75_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_75_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_05$ENT_75_6
#> [1] "REF"                              "ZZ"                              
#> [3] "Primary Capitation Medi-Cal Only"
#> 
#> $sample_820_05$ENT_75_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_76_1
#> [1] "ENT"       "76"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_76_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME88"      
#>  [5] "FIRSTNAME88"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000088"
#> 
#> $sample_820_05$ENT_76_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_76_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_76_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_05$ENT_76_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_76_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_77_1
#> [1] "ENT"       "77"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_77_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME89"      
#>  [5] "FIRSTNAME89"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000089"
#> 
#> $sample_820_05$ENT_77_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_77_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_77_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_05$ENT_77_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_77_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_78_1
#> [1] "ENT"       "78"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_78_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME90"      
#>  [5] "FIRSTNAME90"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000090"
#> 
#> $sample_820_05$ENT_78_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_78_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_78_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_05$ENT_78_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_78_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_79_1
#> [1] "ENT"       "79"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_79_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME91"      
#>  [5] "FIRSTNAME91"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000091"
#> 
#> $sample_820_05$ENT_79_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_79_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_79_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_05$ENT_79_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_79_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$ENT_80_1
#> [1] "ENT"       "80"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_80_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME92"      
#>  [5] "FIRSTNAME92"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000092"
#> 
#> $sample_820_05$ENT_80_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_80_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_80_5
#> [1] "REF"  "ZZ"   "1H;1"
#> 
#> $sample_820_05$ENT_80_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_80_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20260101-20260131"
#> 
#> $sample_820_05$ENT_81_1
#> [1] "ENT"       "81"        "2J"        "EI"        "999999999"
#> 
#> $sample_820_05$ENT_81_2
#>  [1] "NM1"              "IL"               "1"                "LASTNAME93"      
#>  [5] "FIRSTNAME93"      NA                 NA                 NA                
#>  [9] "N"                "TESTMBR000000093"
#> 
#> $sample_820_05$ENT_81_3
#> [1] "RMR"                            "IK"                            
#> [3] "TESTPLAN-PREGLR-2601080201000P" NA                              
#> [5] "5258.86"                       
#> 
#> $sample_820_05$ENT_81_4
#> [1] "REF" "18"  "957"
#> 
#> $sample_820_05$ENT_81_5
#> [1] "REF"  "ZZ"   "17;1"
#> 
#> $sample_820_05$ENT_81_6
#> [1] "REF"                     "ZZ"                     
#> [3] "Primary Capitation Dual"
#> 
#> $sample_820_05$ENT_81_7
#> [1] "DTM"               "582"               NA                 
#> [4] NA                  NA                  "RD8"              
#> [7] "20251201-20251231"
#> 
#> $sample_820_05$SE
#> [1] "SE"   "643"  "0001"
#> 
#> $sample_820_05$GE
#> [1] "GE"    "1"     "44044"
#> 
#> $sample_820_05$IEA
#> [1] "IEA"       "1"         "000059431"
#> 
#> 
#> $stedi_820_06
#> [1] NA
#> 
#> $stedi_820_07
#> [1] NA
#> 
```
