# X12-834 Benefit Enrollment Parser

The 834 carries *membership events*:

- new enrollment (qualifier 021)

- change (001)

- termination (024)

- audit/reconciliation (030)

## Usage

``` r
parse_834(text)

index_834(text)
```

## Arguments

- text:

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
purrr::map(hcc::x12_834, index_834)
#> $minimal_820
#> $minimal_820$ISA
#> [1] 1
#> 
#> $minimal_820$GS
#> [1] 2
#> 
#> $minimal_820$ST
#> [1] 3
#> 
#> $minimal_820$BGN
#> [1] 4
#> 
#> $minimal_820$QTY
#> integer(0)
#> 
#> $minimal_820$REF
#> [1] 8 9
#> 
#> $minimal_820$DTP
#> [1] 10 14
#> 
#> $minimal_820$N1
#> [1] 5 6
#> 
#> $minimal_820$ACT
#> integer(0)
#> 
#> $minimal_820$INS
#> [1] 7
#> 
#> $minimal_820$NM1
#> [1] 11
#> 
#> $minimal_820$PER
#> integer(0)
#> 
#> $minimal_820$N3
#> integer(0)
#> 
#> $minimal_820$N4
#> integer(0)
#> 
#> $minimal_820$DMG
#> [1] 12
#> 
#> $minimal_820$EC
#> integer(0)
#> 
#> $minimal_820$ICM
#> integer(0)
#> 
#> $minimal_820$AMT
#> integer(0)
#> 
#> $minimal_820$HLH
#> integer(0)
#> 
#> $minimal_820$LUI
#> integer(0)
#> 
#> $minimal_820$DSB
#> integer(0)
#> 
#> $minimal_820$IDC
#> integer(0)
#> 
#> $minimal_820$PLA
#> integer(0)
#> 
#> $minimal_820$COB
#> integer(0)
#> 
#> $minimal_820$LS
#> integer(0)
#> 
#> $minimal_820$LX
#> integer(0)
#> 
#> $minimal_820$LE
#> integer(0)
#> 
#> $minimal_820$HD
#> [1] 13
#> 
#> $minimal_820$SE
#> [1] 15
#> 
#> $minimal_820$GE
#> [1] 16
#> 
#> $minimal_820$IEA
#> [1] 17
#> 
#> 
#> $sample_834_01
#> $sample_834_01$ISA
#> [1] 1
#> 
#> $sample_834_01$GS
#> [1] 2
#> 
#> $sample_834_01$ST
#> [1] 3
#> 
#> $sample_834_01$BGN
#> [1] 4
#> 
#> $sample_834_01$QTY
#> integer(0)
#> 
#> $sample_834_01$REF
#>  [1]  5 10 11 12 13 24 25 26 27 37 38 39 40 52 53 61 62
#> 
#> $sample_834_01$DTP
#>  [1]  6 20 22 33 35 46 47 49 50 59 68
#> 
#> $sample_834_01$N1
#> [1] 7 8
#> 
#> $sample_834_01$ACT
#> integer(0)
#> 
#> $sample_834_01$INS
#> [1]  9 23 36 51 60
#> 
#> $sample_834_01$NM1
#> [1] 14 28 41 54 63
#> 
#> $sample_834_01$PER
#> [1] 15
#> 
#> $sample_834_01$N3
#> [1] 16 29 42 55 64
#> 
#> $sample_834_01$N4
#> [1] 17 30 43 56 65
#> 
#> $sample_834_01$DMG
#> [1] 18 31 44 57 66
#> 
#> $sample_834_01$EC
#> integer(0)
#> 
#> $sample_834_01$ICM
#> integer(0)
#> 
#> $sample_834_01$AMT
#> integer(0)
#> 
#> $sample_834_01$HLH
#> integer(0)
#> 
#> $sample_834_01$LUI
#> integer(0)
#> 
#> $sample_834_01$DSB
#> integer(0)
#> 
#> $sample_834_01$IDC
#> integer(0)
#> 
#> $sample_834_01$PLA
#> integer(0)
#> 
#> $sample_834_01$COB
#> integer(0)
#> 
#> $sample_834_01$LS
#> integer(0)
#> 
#> $sample_834_01$LX
#> integer(0)
#> 
#> $sample_834_01$LE
#> integer(0)
#> 
#> $sample_834_01$HD
#> [1] 19 21 32 34 45 48 58 67
#> 
#> $sample_834_01$SE
#> [1] 69
#> 
#> $sample_834_01$GE
#> [1] 70
#> 
#> $sample_834_01$IEA
#> [1] 71
#> 
#> 
#> $sample_834_02
#> $sample_834_02$ISA
#> [1] 1
#> 
#> $sample_834_02$GS
#> [1] 2
#> 
#> $sample_834_02$ST
#> [1] 3
#> 
#> $sample_834_02$BGN
#> [1] 4
#> 
#> $sample_834_02$QTY
#> [1] 5
#> 
#> $sample_834_02$REF
#>  [1]  9 10 11 12 13 14 15 25 26 27 28 29 30
#> 
#> $sample_834_02$DTP
#> [1] 23 24
#> 
#> $sample_834_02$N1
#> [1] 6 7
#> 
#> $sample_834_02$ACT
#> integer(0)
#> 
#> $sample_834_02$INS
#> [1] 8
#> 
#> $sample_834_02$NM1
#> [1] 16
#> 
#> $sample_834_02$PER
#> [1] 17
#> 
#> $sample_834_02$N3
#> [1] 18
#> 
#> $sample_834_02$N4
#> [1] 19
#> 
#> $sample_834_02$DMG
#> [1] 20
#> 
#> $sample_834_02$EC
#> integer(0)
#> 
#> $sample_834_02$ICM
#> integer(0)
#> 
#> $sample_834_02$AMT
#> integer(0)
#> 
#> $sample_834_02$HLH
#> integer(0)
#> 
#> $sample_834_02$LUI
#> [1] 21
#> 
#> $sample_834_02$DSB
#> integer(0)
#> 
#> $sample_834_02$IDC
#> integer(0)
#> 
#> $sample_834_02$PLA
#> integer(0)
#> 
#> $sample_834_02$COB
#> integer(0)
#> 
#> $sample_834_02$LS
#> integer(0)
#> 
#> $sample_834_02$LX
#> integer(0)
#> 
#> $sample_834_02$LE
#> integer(0)
#> 
#> $sample_834_02$HD
#> [1] 22
#> 
#> $sample_834_02$SE
#> [1] 31
#> 
#> $sample_834_02$GE
#> [1] 32
#> 
#> $sample_834_02$IEA
#> [1] 33
#> 
#> 
#> $sample_834_03
#> $sample_834_03$ISA
#> [1] 1
#> 
#> $sample_834_03$GS
#> [1] 2
#> 
#> $sample_834_03$ST
#> [1] 3
#> 
#> $sample_834_03$BGN
#> [1] 4
#> 
#> $sample_834_03$QTY
#> [1] 5
#> 
#> $sample_834_03$REF
#>  [1]  9 10 11 12 13 14 15 16 17 18 28 29 30 31 32 33
#> 
#> $sample_834_03$DTP
#> [1] 26 27
#> 
#> $sample_834_03$N1
#> [1] 6 7
#> 
#> $sample_834_03$ACT
#> integer(0)
#> 
#> $sample_834_03$INS
#> [1] 8
#> 
#> $sample_834_03$NM1
#> [1] 19
#> 
#> $sample_834_03$PER
#> [1] 20
#> 
#> $sample_834_03$N3
#> [1] 21
#> 
#> $sample_834_03$N4
#> [1] 22
#> 
#> $sample_834_03$DMG
#> [1] 23
#> 
#> $sample_834_03$EC
#> integer(0)
#> 
#> $sample_834_03$ICM
#> integer(0)
#> 
#> $sample_834_03$AMT
#> integer(0)
#> 
#> $sample_834_03$HLH
#> integer(0)
#> 
#> $sample_834_03$LUI
#> [1] 24
#> 
#> $sample_834_03$DSB
#> integer(0)
#> 
#> $sample_834_03$IDC
#> integer(0)
#> 
#> $sample_834_03$PLA
#> integer(0)
#> 
#> $sample_834_03$COB
#> integer(0)
#> 
#> $sample_834_03$LS
#> integer(0)
#> 
#> $sample_834_03$LX
#> integer(0)
#> 
#> $sample_834_03$LE
#> integer(0)
#> 
#> $sample_834_03$HD
#> [1] 25
#> 
#> $sample_834_03$SE
#> [1] 34
#> 
#> $sample_834_03$GE
#> [1] 35
#> 
#> $sample_834_03$IEA
#> [1] 36
#> 
#> 
#> $sample_834_04
#> $sample_834_04$ISA
#> [1] 1
#> 
#> $sample_834_04$GS
#> [1] 2
#> 
#> $sample_834_04$ST
#> [1] 3
#> 
#> $sample_834_04$BGN
#> [1] 4
#> 
#> $sample_834_04$QTY
#> [1] 5
#> 
#> $sample_834_04$REF
#>  [1]  9 10 11 12 13 14 15 16 17 18 27 28 29 30 31 32
#> 
#> $sample_834_04$DTP
#> [1] 25 26
#> 
#> $sample_834_04$N1
#> [1] 6 7
#> 
#> $sample_834_04$ACT
#> integer(0)
#> 
#> $sample_834_04$INS
#> [1] 8
#> 
#> $sample_834_04$NM1
#> [1] 19
#> 
#> $sample_834_04$PER
#> [1] 20
#> 
#> $sample_834_04$N3
#> [1] 21
#> 
#> $sample_834_04$N4
#> [1] 22
#> 
#> $sample_834_04$DMG
#> [1] 23
#> 
#> $sample_834_04$EC
#> integer(0)
#> 
#> $sample_834_04$ICM
#> integer(0)
#> 
#> $sample_834_04$AMT
#> integer(0)
#> 
#> $sample_834_04$HLH
#> integer(0)
#> 
#> $sample_834_04$LUI
#> integer(0)
#> 
#> $sample_834_04$DSB
#> integer(0)
#> 
#> $sample_834_04$IDC
#> integer(0)
#> 
#> $sample_834_04$PLA
#> integer(0)
#> 
#> $sample_834_04$COB
#> integer(0)
#> 
#> $sample_834_04$LS
#> integer(0)
#> 
#> $sample_834_04$LX
#> integer(0)
#> 
#> $sample_834_04$LE
#> integer(0)
#> 
#> $sample_834_04$HD
#> [1] 24
#> 
#> $sample_834_04$SE
#> [1] 33
#> 
#> $sample_834_04$GE
#> [1] 34
#> 
#> $sample_834_04$IEA
#> [1] 35
#> 
#> 
#> $sample_834_05
#> $sample_834_05$ISA
#> [1] 1
#> 
#> $sample_834_05$GS
#> [1] 2
#> 
#> $sample_834_05$ST
#> [1] 3
#> 
#> $sample_834_05$BGN
#> [1] 4
#> 
#> $sample_834_05$QTY
#> [1] 5
#> 
#> $sample_834_05$REF
#>  [1]  9 10 11 12 13 14 15 16 17 18 28 29 30 31 32
#> 
#> $sample_834_05$DTP
#> [1] 25 26
#> 
#> $sample_834_05$N1
#> [1] 6 7
#> 
#> $sample_834_05$ACT
#> integer(0)
#> 
#> $sample_834_05$INS
#> [1] 8
#> 
#> $sample_834_05$NM1
#> [1] 19
#> 
#> $sample_834_05$PER
#> [1] 20
#> 
#> $sample_834_05$N3
#> [1] 21
#> 
#> $sample_834_05$N4
#> [1] 22
#> 
#> $sample_834_05$DMG
#> [1] 23
#> 
#> $sample_834_05$EC
#> integer(0)
#> 
#> $sample_834_05$ICM
#> integer(0)
#> 
#> $sample_834_05$AMT
#> [1] 27
#> 
#> $sample_834_05$HLH
#> integer(0)
#> 
#> $sample_834_05$LUI
#> integer(0)
#> 
#> $sample_834_05$DSB
#> integer(0)
#> 
#> $sample_834_05$IDC
#> integer(0)
#> 
#> $sample_834_05$PLA
#> integer(0)
#> 
#> $sample_834_05$COB
#> integer(0)
#> 
#> $sample_834_05$LS
#> integer(0)
#> 
#> $sample_834_05$LX
#> integer(0)
#> 
#> $sample_834_05$LE
#> integer(0)
#> 
#> $sample_834_05$HD
#> [1] 24
#> 
#> $sample_834_05$SE
#> [1] 33
#> 
#> $sample_834_05$GE
#> [1] 34
#> 
#> $sample_834_05$IEA
#> [1] 35
#> 
#> 
#> $sample_834_06
#> $sample_834_06$ISA
#> [1] 1
#> 
#> $sample_834_06$GS
#> [1] 2
#> 
#> $sample_834_06$ST
#> [1] 3
#> 
#> $sample_834_06$BGN
#> [1] 4
#> 
#> $sample_834_06$QTY
#> [1] 5
#> 
#> $sample_834_06$REF
#>  [1]  9 10 11 12 13 14 15 16 28 29 30 31 32 36 37 38 39 40 42 43 44 45 46 47 48
#> [26] 49 50 51 60 61 62 63 64 65
#> 
#> $sample_834_06$DTP
#> [1] 26 27 34 35 58 59
#> 
#> $sample_834_06$N1
#> [1] 6 7
#> 
#> $sample_834_06$ACT
#> integer(0)
#> 
#> $sample_834_06$INS
#> [1]  8 41
#> 
#> $sample_834_06$NM1
#> [1] 17 22 52
#> 
#> $sample_834_06$PER
#> [1] 18 53
#> 
#> $sample_834_06$N3
#> [1] 19 23 54
#> 
#> $sample_834_06$N4
#> [1] 20 24 55
#> 
#> $sample_834_06$DMG
#> [1] 21 56
#> 
#> $sample_834_06$EC
#> integer(0)
#> 
#> $sample_834_06$ICM
#> integer(0)
#> 
#> $sample_834_06$AMT
#> integer(0)
#> 
#> $sample_834_06$HLH
#> integer(0)
#> 
#> $sample_834_06$LUI
#> integer(0)
#> 
#> $sample_834_06$DSB
#> integer(0)
#> 
#> $sample_834_06$IDC
#> integer(0)
#> 
#> $sample_834_06$PLA
#> integer(0)
#> 
#> $sample_834_06$COB
#> integer(0)
#> 
#> $sample_834_06$LS
#> integer(0)
#> 
#> $sample_834_06$LX
#> integer(0)
#> 
#> $sample_834_06$LE
#> integer(0)
#> 
#> $sample_834_06$HD
#> [1] 25 33 57
#> 
#> $sample_834_06$SE
#> [1] 66
#> 
#> $sample_834_06$GE
#> [1] 67
#> 
#> $sample_834_06$IEA
#> [1] 68
#> 
#> 
purrr::map(hcc::x12_834, parse_834)
#> $minimal_820
#>  [1] "ISA*00*          *00*          *ZZ*EMPLOYER01     *ZZ*PAYER99        *260513*1500*U*00501*000000834*0*P*>"
#>  [2] "GS*BE*EMPLOYER01*PAYER99*20260513*1500*1*X*005010X220A1"                                                  
#>  [3] "ST*834*0001*005010X220A1"                                                                                 
#>  [4] "BGN*00*FILE-ENROLL-2026Q2*20260513*1500***4"                                                              
#>  [5] "N1*P5*ACME EMPLOYER*FI*987654321"                                                                         
#>  [6] "N1*IN*PAYER99*FI*111223333"                                                                               
#>  [7] "INS*Y*18*030*XN*A***FT"                                                                                   
#>  [8] "REF*0F*MEMBER12345"                                                                                       
#>  [9] "REF*1L*GROUP4567"                                                                                         
#> [10] "DTP*356*D8*20260601"                                                                                      
#> [11] "NM1*IL*1*DOE*JANE****34*123456789"                                                                        
#> [12] "DMG*D8*19850412*F"                                                                                        
#> [13] "HD*030**HLT*PPO-GOLD-2026"                                                                                
#> [14] "DTP*348*D8*20260601"                                                                                      
#> [15] "SE*13*0001"                                                                                               
#> [16] "GE*1*1"                                                                                                   
#> [17] "IEA*1*000000834"                                                                                          
#> 
#> $sample_834_01
#>  [1] "ISA*00*          *00*          *ZZ*DHCS           *ZZ*HEALTHPLAN     *250108*1430*^*00501*000000001*0*P*:"
#>  [2] "GS*BE*DHCS*HEALTHPLAN*20250108*1430*1*X*005010X220A1"                                                     
#>  [3] "ST*834*0001*005010X220A1"                                                                                 
#>  [4] "BGN*00*12345*20250108*1430****2"                                                                          
#>  [5] "REF*38*MEDI-CAL"                                                                                          
#>  [6] "DTP*007*D8*20250108"                                                                                      
#>  [7] "N1*P5*CALIFORNIA DHCS*FI*953654321"                                                                       
#>  [8] "N1*IN*HEALTH PLAN NAME*FI*987654321"                                                                      
#>  [9] "INS*Y*18*021***FT***AC"                                                                                   
#> [10] "REF*0F*MBR001"                                                                                            
#> [11] "REF*6P*TESTMBI000000001"                                                                                  
#> [12] "REF*1D*TESTMCD000000001"                                                                                  
#> [13] "REF*ABB*QMBPLUS"                                                                                          
#> [14] "NM1*IL*1*TESTLAST01*TESTFIRST01****MI*TESTMBR000000001"                                                   
#> [15] "PER*IP**HP*5555550000"                                                                                    
#> [16] "N3*123 TEST STREET"                                                                                       
#> [17] "N4*TESTCITY*CA*00000"                                                                                     
#> [18] "DMG*D8*19000101*F"                                                                                        
#> [19] "HD*021**HLT*MEDICARE ADVANTAGE D-SNP"                                                                     
#> [20] "DTP*348*D8*20240101"                                                                                      
#> [21] "HD*021**HLT*MEDI-CAL"                                                                                     
#> [22] "DTP*348*D8*20240101"                                                                                      
#> [23] "INS*Y*18*001***FT***AC"                                                                                   
#> [24] "REF*0F*MBR002"                                                                                            
#> [25] "REF*6P*TESTMBI000000002"                                                                                  
#> [26] "REF*1D*TESTMCD000000002"                                                                                  
#> [27] "REF*AB*4M"                                                                                                
#> [28] "NM1*IL*1*TESTLAST02*TESTFIRST02****MI*TESTMBR000000002"                                                   
#> [29] "N3*123 TEST STREET"                                                                                       
#> [30] "N4*TESTCITY*CA*00000"                                                                                     
#> [31] "DMG*D8*19000101*M"                                                                                        
#> [32] "HD*001**HLT*MEDICARE PART C"                                                                              
#> [33] "DTP*348*D8*20230515"                                                                                      
#> [34] "HD*001**HLT*MEDI-CAL"                                                                                     
#> [35] "DTP*348*D8*20240101"                                                                                      
#> [36] "INS*Y*18*024***FT***TE"                                                                                   
#> [37] "REF*0F*MBR003"                                                                                            
#> [38] "REF*6P*TESTMBI000000003"                                                                                  
#> [39] "REF*1D*TESTMCD000000003"                                                                                  
#> [40] "REF*ABB*SLMBPLUS"                                                                                         
#> [41] "NM1*IL*1*TESTLAST03*TESTFIRST03****MI*TESTMBR000000003"                                                   
#> [42] "N3*123 TEST STREET"                                                                                       
#> [43] "N4*TESTCITY*CA*00000"                                                                                     
#> [44] "DMG*D8*19000101*F"                                                                                        
#> [45] "HD*024**HLT*MEDICARE PART A"                                                                              
#> [46] "DTP*348*D8*20220101"                                                                                      
#> [47] "DTP*349*D8*20250228"                                                                                      
#> [48] "HD*024**HLT*MEDI-CAL"                                                                                     
#> [49] "DTP*348*D8*20220101"                                                                                      
#> [50] "DTP*349*D8*20250228"                                                                                      
#> [51] "INS*Y*18*021***FT***AC"                                                                                   
#> [52] "REF*0F*MBR004"                                                                                            
#> [53] "REF*1D*TESTMCD000000004"                                                                                  
#> [54] "NM1*IL*1*TESTLAST04*TESTFIRST04****MI*TESTMBR000000004"                                                   
#> [55] "N3*123 TEST STREET"                                                                                       
#> [56] "N4*TESTCITY*CA*00000"                                                                                     
#> [57] "DMG*D8*19000101*M"                                                                                        
#> [58] "HD*021**HLT*MEDI-CAL"                                                                                     
#> [59] "DTP*348*D8*20250101"                                                                                      
#> [60] "INS*Y*18*021***FT***AC"                                                                                   
#> [61] "REF*0F*MBR005"                                                                                            
#> [62] "REF*6P*TESTMBI000000005"                                                                                  
#> [63] "NM1*IL*1*TESTLAST05*TESTFIRST05****MI*TESTMBR000000005"                                                   
#> [64] "N3*123 TEST STREET"                                                                                       
#> [65] "N4*TESTCITY*CA*00000"                                                                                     
#> [66] "DMG*D8*19000101*M"                                                                                        
#> [67] "HD*021**HLT*MEDICARE PART C"                                                                              
#> [68] "DTP*348*D8*20250901"                                                                                      
#> [69] "SE*68*0001"                                                                                               
#> [70] "GE*1*1"                                                                                                   
#> [71] "IEA*1*000000001"                                                                                          
#> 
#> $sample_834_02
#>  [1] "ISA*00*          *00*          *ZZ*CADHCS_5010_834*30*999999991      *250124*1927*^*00501*000000001*0*P*:"
#>  [2] "GS*BE*CADHCS_5010_834*999999991*20250124*192730*10000001*X*005010X220A1"                                  
#>  [3] "ST*834*0001*005010X220A1"                                                                                 
#>  [4] "BGN*00*DHCS834-DA-20250124-Sample PACE-001*20250124*19273000****2"                                        
#>  [5] "QTY*TO*1"                                                                                                 
#>  [6] "N1*P5*California Department of Health Care Services.........*FI*999999990"                                
#>  [7] "N1*IN*Sample PACE Inc.*FI*999999991"                                                                      
#>  [8] "INS*Y*18*001*AI*A*E**AC"                                                                                  
#>  [9] "REF*0F*randomParticipantID"                                                                               
#> [10] "REF*1L*randomCIN1"                                                                                        
#> [11] "REF*17*;;202501;"                                                                                         
#> [12] "REF*23*4;20200101;;"                                                                                      
#> [13] "REF*3H*19;10;randomCaseNum1;;"                                                                            
#> [14] "REF*6O*;W;Y;;60;"                                                                                         
#> [15] "REF*ZZ*01051;41609;;;;30451;41651;;;"                                                                     
#> [16] "NM1*IL*1*randomLastName*randomFirstName*A"                                                                
#> [17] "PER*IP**TE*randomPhone"                                                                                   
#> [18] "N3*randomStreetAddress1"                                                                                  
#> [19] "N4*LOS ANGELES CA*CA*90019**CY*19"                                                                        
#> [20] "DMG*D8*randomDoB*F**7"                                                                                    
#> [21] "LUI*LD*SPA**7"                                                                                            
#> [22] "HD*021**LTC*010;51"                                                                                       
#> [23] "DTP*348*D8*20250101"                                                                                      
#> [24] "DTP*349*D8*20250131"                                                                                      
#> [25] "REF*17*N;;;;;;;;;;;;;1"                                                                                   
#> [26] "REF*9V*9;9;0"                                                                                             
#> [27] "REF*CE*10;401;;;;;;"                                                                                      
#> [28] "REF*RB*10"                                                                                                
#> [29] "REF*ZX*19"                                                                                                
#> [30] "REF*ZZ*;;10"                                                                                              
#> [31] "SE*29*0001"                                                                                               
#> [32] "GE*1*10000001"                                                                                            
#> [33] "IEA*1*000000001"                                                                                          
#> 
#> $sample_834_03
#>  [1] "ISA*00*          *00*          *ZZ*CADHCS_5010_834*30*999999992      *250812*1936*^*00501*000000002*0*P*:"
#>  [2] "GS*BE*CADHCS_5010_834*999999992*20250812*193641*10000002*X*005010X220A1"                                  
#>  [3] "ST*834*0001*005010X220A1"                                                                                 
#>  [4] "BGN*00*DHCS834-DA-20250812-Sample South LA PACE-957-001*20250812*19364100****2"                           
#>  [5] "QTY*TO*1"                                                                                                 
#>  [6] "N1*P5*California Department of Health Care Services.........*FI*999999990"                                
#>  [7] "N1*IN*Sample South LA PACE Inc.*FI*999999992"                                                             
#>  [8] "INS*Y*18*001*AI*A*C**AC"                                                                                  
#>  [9] "REF*0F*randomMemberId"                                                                                    
#> [10] "REF*1L*randomCIN2"                                                                                        
#> [11] "REF*17*;;202508;"                                                                                         
#> [12] "REF*23*2;20200201;;;"                                                                                     
#> [13] "REF*3H*19;60;randomCaseNum2;;"                                                                            
#> [14] "REF*6O*;W;Y;;08;"                                                                                         
#> [15] "REF*DX*H9999;006;20250201;;;"                                                                             
#> [16] "REF*F6*randomMbi"                                                                                         
#> [17] "REF*QQ*;;202001;202001"                                                                                   
#> [18] "REF*ZZ*95701;;;;;35201;;;;"                                                                               
#> [19] "NM1*IL*1*randomLastName*randomFirstName"                                                                  
#> [20] "PER*IP**TE*randomPhone"                                                                                   
#> [21] "N3*randomAddress1"                                                                                        
#> [22] "N4*LONG BEACH CA*CA*90813**CY*19"                                                                         
#> [23] "DMG*D8*randomDoB*F**7"                                                                                    
#> [24] "LUI*LD*SPA**7"                                                                                            
#> [25] "HD*021**LTC*957;01"                                                                                       
#> [26] "DTP*348*D8*20250801"                                                                                      
#> [27] "DTP*349*D8*20250831"                                                                                      
#> [28] "REF*17*F;;;;;;;;;;;;;1"                                                                                   
#> [29] "REF*9V*2;2;2"                                                                                             
#> [30] "REF*CE*60;401;80;401;;;;"                                                                                 
#> [31] "REF*RB*60"                                                                                                
#> [32] "REF*ZX*19"                                                                                                
#> [33] "REF*ZZ*;;10"                                                                                              
#> [34] "SE*32*0001"                                                                                               
#> [35] "GE*1*10000002"                                                                                            
#> [36] "IEA*1*000000002"                                                                                          
#> 
#> $sample_834_04
#>  [1] "ISA*00*          *00*          *ZZ*CADHCS_5010_834*30*999999992      *251022*2000*^*00501*000000003*0*P*:"
#>  [2] "GS*BE*CADHCS_5010_834*999999992*20251022*200019*10000003*X*005010X220A1"                                  
#>  [3] "ST*834*0001*005010X220A1"                                                                                 
#>  [4] "BGN*00*DHCS834-DA-20251022-Sample South LA PACE-957-001*20251022*20001900****2"                           
#>  [5] "QTY*TO*1"                                                                                                 
#>  [6] "N1*P5*California Department of Health Care Services.........*FI*999999990"                                
#>  [7] "N1*IN*Sample South LA PACE Inc.*FI*999999992"                                                             
#>  [8] "INS*Y*18*001*AI*A*C**AC"                                                                                  
#>  [9] "REF*0F*randomMemberId"                                                                                    
#> [10] "REF*1L*randomCIN3"                                                                                        
#> [11] "REF*17*202605;;202510;"                                                                                   
#> [12] "REF*23*2;20200301;;;"                                                                                     
#> [13] "REF*3H*19;16;randomCode;;08"                                                                              
#> [14] "REF*6O*;A;Y;;29;"                                                                                         
#> [15] "REF*DX*H9999;001;20251101;;;"                                                                             
#> [16] "REF*F6*randomMbi"                                                                                         
#> [17] "REF*QQ*;;202002;202002"                                                                                   
#> [18] "REF*ZZ*95701;;;;;20101;;;;"                                                                               
#> [19] "NM1*IL*1*randomLastName*randomFirstName"                                                                  
#> [20] "PER*IP**TE*randomPhone"                                                                                   
#> [21] "N3*randomAddress1"                                                                                        
#> [22] "N4*LOS ANGELES CA*CA*90044**CY*19"                                                                        
#> [23] "DMG*D8*randomDoB*F**:RET:2054-5"                                                                          
#> [24] "HD*021**LTC*957;01"                                                                                       
#> [25] "DTP*348*D8*20251001"                                                                                      
#> [26] "DTP*349*D8*20251031"                                                                                      
#> [27] "REF*17*F;;;;1"                                                                                            
#> [28] "REF*9V*3;2;2"                                                                                             
#> [29] "REF*CE*16;401;80;401;;;;"                                                                                 
#> [30] "REF*RB*16"                                                                                                
#> [31] "REF*ZX*19"                                                                                                
#> [32] "REF*ZZ*;;10"                                                                                              
#> [33] "SE*31*0001"                                                                                               
#> [34] "GE*1*10000003"                                                                                            
#> [35] "IEA*1*000000003"                                                                                          
#> 
#> $sample_834_05
#>  [1] "ISA*00*          *00*          *ZZ*CADHCS_5010_834*30*999999992      *251023*1959*^*00501*000000004*0*P*:"
#>  [2] "GS*BE*CADHCS_5010_834*999999992*20251023*195928*10000004*X*005010X220A1"                                  
#>  [3] "ST*834*0001*005010X220A1"                                                                                 
#>  [4] "BGN*00*DHCS834-DA-20251023-Sample South LA PACE-957-001*20251023*19592800****2"                           
#>  [5] "QTY*TO*1"                                                                                                 
#>  [6] "N1*P5*California Department of Health Care Services.........*FI*999999990"                                
#>  [7] "N1*IN*Sample South LA PACE Inc.*FI*999999992"                                                             
#>  [8] "INS*Y*18*001*AI*A*C**AC"                                                                                  
#>  [9] "REF*0F*randomMemberId"                                                                                    
#> [10] "REF*1L*randomCIN4"                                                                                        
#> [11] "REF*17*202601;;202510;"                                                                                   
#> [12] "REF*23*6;20200401;20200101;;"                                                                             
#> [13] "REF*3H*19;17;randomId1;;07"                                                                               
#> [14] "REF*6O*;W;Y;;19;"                                                                                         
#> [15] "REF*DX*H9999;006;20230401;;;"                                                                             
#> [16] "REF*F6*randomId2"                                                                                         
#> [17] "REF*QQ*;;202003;202003"                                                                                   
#> [18] "REF*ZZ*957P4;;;;;;;;;"                                                                                    
#> [19] "NM1*IL*1*randomLastName*randomFirstName"                                                                  
#> [20] "PER*IP**TE*randomPhone"                                                                                   
#> [21] "N3*randomAddress1"                                                                                        
#> [22] "N4*LONG BEACH CA*CA*90810**CY*19"                                                                         
#> [23] "DMG*D8*randomDoB*F**:RET:2135-2"                                                                          
#> [24] "HD*001**LTC*957;P4"                                                                                       
#> [25] "DTP*348*D8*20251001"                                                                                      
#> [26] "DTP*349*D8*20250930"                                                                                      
#> [27] "AMT*R*1237"                                                                                               
#> [28] "REF*17*F;;;;1"                                                                                            
#> [29] "REF*9V*3;1;0"                                                                                             
#> [30] "REF*CE*17;501;2K;691;;;;"                                                                                 
#> [31] "REF*ZX*19"                                                                                                
#> [32] "REF*ZZ*;;10"                                                                                              
#> [33] "SE*31*0001"                                                                                               
#> [34] "GE*1*10000004"                                                                                            
#> [35] "IEA*1*000000004"                                                                                          
#> 
#> $sample_834_06
#>  [1] "ISA*00*          *00*          *ZZ*CADHCS_5010_834*30*999999991      *250206*2008*^*00501*000000005*0*P*:"
#>  [2] "GS*BE*CADHCS_5010_834*999999991*20250206*200823*10000005*X*005010X220A1"                                  
#>  [3] "ST*834*0001*005010X220A1"                                                                                 
#>  [4] "BGN*00*DHCS834-DA-20250206-Sample PACE-001*20250206*20082300****2"                                        
#>  [5] "QTY*TO*2"                                                                                                 
#>  [6] "N1*P5*California Department of Health Care Services.........*FI*999999990"                                
#>  [7] "N1*IN*Sample PACE Inc.*FI*999999991"                                                                      
#>  [8] "INS*Y*18*001*AI*A*E**AC"                                                                                  
#>  [9] "REF*0F*randomMemberId"                                                                                    
#> [10] "REF*1L*randomCIN5"                                                                                        
#> [11] "REF*17*;;202502;"                                                                                         
#> [12] "REF*23*3;20200501;;"                                                                                      
#> [13] "REF*3H*19;60;randomCaseNum1;;"                                                                            
#> [14] "REF*6O*;A;Y;D;67;"                                                                                        
#> [15] "REF*Q4*randomProviderId;"                                                                                 
#> [16] "REF*ZZ*01059;;;;;010S1;;;;"                                                                               
#> [17] "NM1*IL*1*randomLName1*randomFName1"                                                                       
#> [18] "PER*IP**TE*randomPhone1"                                                                                  
#> [19] "N3*randomFullAddress1"                                                                                    
#> [20] "N4*LOS ANGELES CA*CA*90037**CY*19"                                                                        
#> [21] "DMG*D8*randomDoB1*F**:RET:2054-5"                                                                         
#> [22] "NM1*31*1"                                                                                                 
#> [23] "N3*randomAddress"                                                                                         
#> [24] "N4*LOS ANGELES CA*CA*90037"                                                                               
#> [25] "HD*001**LTC*010;59"                                                                                       
#> [26] "DTP*348*D8*20250201"                                                                                      
#> [27] "DTP*349*D8*20250131"                                                                                      
#> [28] "REF*17*N;;;;;;;;;;;;;1"                                                                                   
#> [29] "REF*CE*60;001;80;891;;;;"                                                                                 
#> [30] "REF*RB*60"                                                                                                
#> [31] "REF*ZX*19"                                                                                                
#> [32] "REF*ZZ*;;10"                                                                                              
#> [33] "HD*021**LTC*010;S1"                                                                                       
#> [34] "DTP*348*D8*20250101"                                                                                      
#> [35] "DTP*349*D8*20250131"                                                                                      
#> [36] "REF*17*N;;;;;;;;;;;;;1"                                                                                   
#> [37] "REF*CE*60;401;80;891;;;;"                                                                                 
#> [38] "REF*RB*60"                                                                                                
#> [39] "REF*ZX*19"                                                                                                
#> [40] "REF*ZZ*;;11"                                                                                              
#> [41] "INS*Y*18*001*AI*A*C**AC"                                                                                  
#> [42] "REF*0F*randomMemberId2"                                                                                   
#> [43] "REF*1L*randomCIN6"                                                                                        
#> [44] "REF*17*;;202502;"                                                                                         
#> [45] "REF*23*9;20200601;;"                                                                                      
#> [46] "REF*3H*19;10;randomCaseNum2;;"                                                                            
#> [47] "REF*6O*;A;Y;;25;"                                                                                         
#> [48] "REF*DX*;;;S5617;D635;20240901"                                                                            
#> [49] "REF*F6*randomId1"                                                                                         
#> [50] "REF*QQ*;;202004;202004"                                                                                   
#> [51] "REF*ZZ*01001;;;;;30401;;;;"                                                                               
#> [52] "NM1*IL*1*randomLName2*randomFName2*M"                                                                     
#> [53] "PER*IP**TE*randomPhone2"                                                                                  
#> [54] "N3*randomAddress2"                                                                                        
#> [55] "N4*LOS ANGELES CA*CA*90029**CY*19"                                                                        
#> [56] "DMG*D8*randomDoB2*M**:RET:2135-2"                                                                         
#> [57] "HD*021**LTC*010;01"                                                                                       
#> [58] "DTP*348*D8*20250201"                                                                                      
#> [59] "DTP*349*D8*20250228"                                                                                      
#> [60] "REF*17*D;;;;;;;;;;;;;1"                                                                                   
#> [61] "REF*9V*2;2;2"                                                                                             
#> [62] "REF*CE*10;401;9G;999;80;401;;"                                                                            
#> [63] "REF*RB*10"                                                                                                
#> [64] "REF*ZX*19"                                                                                                
#> [65] "REF*ZZ*;;10"                                                                                              
#> [66] "SE*64*0001"                                                                                               
#> [67] "GE*1*10000005"                                                                                            
#> [68] "IEA*1*000000005"                                                                                          
#> 
```
