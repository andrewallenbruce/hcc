# X12-820 Payment Order/Remittance Advice Parser

Parses X12-820 (005010X218) transactions for Medicaid/Medicare
capitation and premium payments. Designed for California DHCS PACE
capitation remittances but handles the general 820 format used by state
Medicaid agencies.

## Usage

``` r
parse_820(text)
```

## Arguments

- text:

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
purrr::map(hcc::x12_820[1:3], parse_820)
#> $sample_820_01
#> $sample_820_01$HEADER
#>      SEG PT                   VALUE
#> 1    ISA 01                      00
#> 2    ISA 02                    <NA>
#> 3    ISA 03                      00
#> 4    ISA 04                    <NA>
#> 5    ISA 05                      ZZ
#> 6    ISA 06              TEST-PAYER
#> 7    ISA 07                      30
#> 8    ISA 08              TEST-PAYEE
#> 9    ISA 09                  260118
#> 10   ISA 10                    0831
#> 11   ISA 11                       +
#> 12   ISA 12                   00501
#> 13   ISA 13               000058691
#> 14   ISA 14                       0
#> 15   ISA 15                       P
#> 16   ISA 16                       :
#> 17    GS 01                      RA
#> 18    GS 02              TEST-PAYER
#> 19    GS 03              TEST-PAYEE
#> 20    GS 04                20260118
#> 21    GS 05                  083122
#> 22    GS 06                   43304
#> 23    GS 07                       X
#> 24    GS 08              005010X218
#> 25    ST 01                     820
#> 26    ST 02                    0001
#> 27    ST 03              005010X218
#> 28   BPR 01                       I
#> 29   BPR 02               102139.46
#> 30   BPR 03                       C
#> 31   BPR 04                     NON
#> 32   BPR 05                    <NA>
#> 33   BPR 06                    <NA>
#> 34   BPR 07                    <NA>
#> 35   BPR 08                    <NA>
#> 36   BPR 09                    <NA>
#> 37   BPR 10              68-0317191
#> 38   BPR 11                    <NA>
#> 39   BPR 12                    <NA>
#> 40   BPR 13                    <NA>
#> 41   BPR 14                    <NA>
#> 42   BPR 15                    <NA>
#> 43   BPR 16                20260115
#> 44   TRN 01                       3
#> 45   TRN 02         TESTTRN01000001
#> 46   REF 01                      14
#> 47   REF 02              0000245023
#> 48 N1*PE 01                      PE
#> 49 N1*PE 02 TEST PAYEE ORGANIZATION
#> 50 N3*PE 01         123 TEST STREET
#> 51 N4*PE 01                TESTCITY
#> 52 N4*PE 02                      CA
#> 53 N4*PE 03                   00000
#> 54 N1*PR 01                      PR
#> 55 N1*PR 02       TEST PAYER AGENCY
#> 56 N3*PR 01         123 TEST STREET
#> 57 N4*PR 01                TESTCITY
#> 58 N4*PR 02                      CA
#> 59 N4*PR 03                   00000
#> 
#> $sample_820_01$LOOP
#> $sample_820_01$LOOP$L1
#> [1] "ENT*1*2J*EI*999999999"                                
#> [2] "NM1*IL*1*LASTNAME01*FIRSTNAME01****N*TESTMBR000000001"
#> [3] "RMR*IK*TESTPLAN-SREGLR-2512150225000P**8086.53"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*1H;2"                                          
#> [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [7] "DTM*582****RD8*20251201-20251231"                     
#> 
#> $sample_820_01$LOOP$L2
#> [1] "ENT*2*2J*EI*999999999"                                
#> [2] "NM1*IL*1*LASTNAME02*FIRSTNAME02****N*TESTMBR000000002"
#> [3] "RMR*IK*TESTPLAN-SREGLR-2512150225000P**8086.53"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*1H;2"                                          
#> [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [7] "DTM*582****RD8*20251201-20251231"                     
#> 
#> $sample_820_01$LOOP$L3
#> [1] "ENT*3*2J*EI*999999999"                                
#> [2] "NM1*IL*1*LASTNAME03*FIRSTNAME03****N*TESTMBR000000003"
#> [3] "RMR*IK*TESTPLAN-SREGLR-2512150225000P**8086.53"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*M1;2"                                          
#> [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [7] "DTM*582****RD8*20251201-20251231"                     
#> 
#> $sample_820_01$LOOP$L4
#> [1] "ENT*4*2J*EI*999999999"                                
#> [2] "NM1*IL*1*LASTNAME04*FIRSTNAME04****N*TESTMBR000000004"
#> [3] "RMR*IK*TESTPLAN-SREGLR-2512150225000P**8086.53"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*M1;2"                                          
#> [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [7] "DTM*582****RD8*20251201-20251231"                     
#> 
#> $sample_820_01$LOOP$L5
#> [1] "ENT*5*2J*EI*999999999"                                
#> [2] "NM1*IL*1*LASTNAME05*FIRSTNAME05****N*TESTMBR000000005"
#> [3] "RMR*IK*TESTPLAN-SREGLR-2512150225000P**8086.53"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*M1;2"                                          
#> [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [7] "DTM*582****RD8*20251201-20251231"                     
#> 
#> $sample_820_01$LOOP$L6
#> [1] "ENT*6*2J*EI*999999999"                                
#> [2] "NM1*IL*1*LASTNAME06*FIRSTNAME06****N*TESTMBR000000006"
#> [3] "RMR*IK*TESTPLAN-SREGLR-2512150225000P**8086.53"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*1H;2"                                          
#> [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [7] "DTM*582****RD8*20251201-20251231"                     
#> 
#> $sample_820_01$LOOP$L7
#>  [1] "ENT*7*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME07*FIRSTNAME07****N*TESTMBR000000007"
#>  [3] "RMR*IK*TESTPLAN-SREGLR-2512150225000P**8086.53"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*M1;2"                                          
#>  [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#>  [7] "DTM*582****RD8*20251201-20251231"                     
#>  [8] "RMR*IK*TESTPLAN-SREGLR-2512150225000P**8086.53"       
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*M1;2"                                          
#> [11] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [12] "DTM*582****RD8*20251101-20251130"                     
#> 
#> $sample_820_01$LOOP$L8
#> [1] "ENT*8*2J*EI*999999999"                                
#> [2] "NM1*IL*1*LASTNAME08*FIRSTNAME08****N*TESTMBR000000008"
#> [3] "RMR*IK*TESTPLAN-SREGLR-2512150225000P**8086.53"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*1H;2"                                          
#> [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [7] "DTM*582****RD8*20251201-20251231"                     
#> 
#> $sample_820_01$LOOP$L9
#> [1] "ENT*9*2J*EI*999999999"                                
#> [2] "NM1*IL*1*LASTNAME09*FIRSTNAME09****N*TESTMBR000000009"
#> [3] "RMR*IK*TESTPLAN-SREGLR-2512150225000P**8086.53"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*1H;2"                                          
#> [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [7] "DTM*582****RD8*20251201-20251231"                     
#> 
#> $sample_820_01$LOOP$L10
#> [1] "ENT*10*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME10*FIRSTNAME10****N*TESTMBR000000010"
#> [3] "RMR*IK*TESTPLAN-SREGLR-2512150225000P**8086.53"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*1H;2"                                          
#> [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [7] "DTM*582****RD8*20251201-20251231"                     
#> 
#> $sample_820_01$LOOP$L11
#> [1] "ENT*11*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME11*FIRSTNAME11****N*TESTMBR000000011"
#> [3] "RMR*IK*TESTPLAN-SREGLR-2512150225000P**8086.53"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*M1;2"                                          
#> [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [7] "DTM*582****RD8*20251201-20251231"                     
#> 
#> $sample_820_01$LOOP$L12
#> [1] "ENT*12*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME12*FIRSTNAME12****N*TESTMBR000000012"
#> [3] "RMR*IK*TESTPLAN-SREGLR-2512150225000P**5101.10"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*17;2"                                          
#> [6] "REF*ZZ*Dual-State Only"                               
#> [7] "DTM*582****RD8*20251101-20251130"                     
#> 
#> 
#> $sample_820_01$TRAILER
#>   SEG PT     VALUE
#> 1  SE 01       100
#> 2  SE 02      0001
#> 3  GE 01         1
#> 4  GE 02     43304
#> 5 IEA 01         1
#> 6 IEA 02 000058691
#> 
#> 
#> $sample_820_02
#> $sample_820_02$HEADER
#>      SEG PT                   VALUE
#> 1    ISA 01                      00
#> 2    ISA 02                    <NA>
#> 3    ISA 03                      00
#> 4    ISA 04                    <NA>
#> 5    ISA 05                      ZZ
#> 6    ISA 06              TEST-PAYER
#> 7    ISA 07                      30
#> 8    ISA 08              TEST-PAYEE
#> 9    ISA 09                  260316
#> 10   ISA 10                    0855
#> 11   ISA 11                       +
#> 12   ISA 12                   00501
#> 13   ISA 13               000059660
#> 14   ISA 14                       0
#> 15   ISA 15                       P
#> 16   ISA 16                       :
#> 17    GS 01                      RA
#> 18    GS 02              TEST-PAYER
#> 19    GS 03              TEST-PAYEE
#> 20    GS 04                20260316
#> 21    GS 05                  085500
#> 22    GS 06                   44273
#> 23    GS 07                       X
#> 24    GS 08              005010X218
#> 25    ST 01                     820
#> 26    ST 02                    0001
#> 27    ST 03              005010X218
#> 28   BPR 01                       I
#> 29   BPR 02                91977.81
#> 30   BPR 03                       C
#> 31   BPR 04                     NON
#> 32   BPR 05                    <NA>
#> 33   BPR 06                    <NA>
#> 34   BPR 07                    <NA>
#> 35   BPR 08                    <NA>
#> 36   BPR 09                    <NA>
#> 37   BPR 10              68-0317191
#> 38   BPR 11                    <NA>
#> 39   BPR 12                    <NA>
#> 40   BPR 13                    <NA>
#> 41   BPR 14                    <NA>
#> 42   BPR 15                    <NA>
#> 43   BPR 16                20260312
#> 44   TRN 01                       3
#> 45   TRN 02         TESTTRN02000001
#> 46   REF 01                      14
#> 47   REF 02              0000245023
#> 48 N1*PE 01                      PE
#> 49 N1*PE 02 TEST PAYEE ORGANIZATION
#> 50 N3*PE 01         123 TEST STREET
#> 51 N4*PE 01                TESTCITY
#> 52 N4*PE 02                      CA
#> 53 N4*PE 03                   00000
#> 54 N1*PR 01                      PR
#> 55 N1*PR 02       TEST PAYER AGENCY
#> 56 N3*PR 01         123 TEST STREET
#> 57 N4*PR 01                TESTCITY
#> 58 N4*PR 02                      CA
#> 59 N4*PR 03                   00000
#> 
#> $sample_820_02$LOOP
#> $sample_820_02$LOOP$L1
#>  [1] "ENT*1*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME01*FIRSTNAME01****N*TESTMBR000000001"
#>  [3] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**5555.82"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;2"                                          
#>  [6] "REF*ZZ*Dual-State Only"                               
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**454.72*5555.82"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;2"                                          
#> [11] "REF*ZZ*Dual-State Only"                               
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5101.10*53"                                      
#> 
#> $sample_820_02$LOOP$L2
#>  [1] "ENT*2*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME02*FIRSTNAME02****N*TESTMBR000000002"
#>  [3] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**8488.25"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;2"                                          
#>  [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**401.72*8488.25"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;2"                                          
#> [11] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-8086.53*53"                                      
#> 
#> $sample_820_02$LOOP$L3
#>  [1] "ENT*3*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME03*FIRSTNAME03****N*TESTMBR000000003"
#>  [3] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**8488.25"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*M1;2"                                          
#>  [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**401.72*8488.25"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*M1;2"                                          
#> [11] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-8086.53*53"                                      
#> 
#> $sample_820_02$LOOP$L4
#>  [1] "ENT*4*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME13*FIRSTNAME13****N*TESTMBR000000013"
#>  [3] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**8488.25"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;2"                                          
#>  [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**8488.25"       
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;2"                                          
#> [11] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_02$LOOP$L5
#>  [1] "ENT*5*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME04*FIRSTNAME04****N*TESTMBR000000004"
#>  [3] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**8488.25"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*M1;2"                                          
#>  [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**401.72*8488.25"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*M1;2"                                          
#> [11] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-8086.53*53"                                      
#> 
#> $sample_820_02$LOOP$L6
#>  [1] "ENT*6*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME05*FIRSTNAME05****N*TESTMBR000000005"
#>  [3] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**8488.25"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;2"                                          
#>  [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**401.72*8488.25"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*M1;2"                                          
#> [11] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-8086.53*53"                                      
#> 
#> $sample_820_02$LOOP$L7
#> [1] "ENT*7*2J*EI*999999999"                                
#> [2] "NM1*IL*1*LASTNAME06*FIRSTNAME06****N*TESTMBR000000006"
#> [3] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**-8086.53"      
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*1H;2"                                          
#> [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_02$LOOP$L8
#>  [1] "ENT*8*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME07*FIRSTNAME07****N*TESTMBR000000007"
#>  [3] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**8488.25"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*M1;2"                                          
#>  [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**401.72*8488.25"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*M1;2"                                          
#> [11] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-8086.53*53"                                      
#> 
#> $sample_820_02$LOOP$L9
#>  [1] "ENT*9*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME08*FIRSTNAME08****N*TESTMBR000000008"
#>  [3] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**8488.25"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;2"                                          
#>  [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**401.72*8488.25"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;2"                                          
#> [11] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-8086.53*53"                                      
#> 
#> $sample_820_02$LOOP$L10
#>  [1] "ENT*10*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME09*FIRSTNAME09****N*TESTMBR000000009"
#>  [3] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**8488.25"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;2"                                          
#>  [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**401.72*8488.25"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;2"                                          
#> [11] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-8086.53*53"                                      
#> 
#> $sample_820_02$LOOP$L11
#> [1] "ENT*11*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME10*FIRSTNAME10****N*TESTMBR000000010"
#> [3] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**401.72*8488.25"
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*1H;2"                                          
#> [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> [8] "ADX*-8086.53*53"                                      
#> 
#> $sample_820_02$LOOP$L12
#>  [1] "ENT*12*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME11*FIRSTNAME11****N*TESTMBR000000011"
#>  [3] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**8488.25"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*M1;2"                                          
#>  [6] "REF*ZZ*Medi-Cal Only-State Only"                      
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**401.72*8488.25"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*M1;2"                                          
#> [11] "REF*ZZ*Medi-Cal Only-State Only"                      
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-8086.53*53"                                      
#> 
#> $sample_820_02$LOOP$L13
#> [1] "ENT*13*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME12*FIRSTNAME12****N*TESTMBR000000012"
#> [3] "RMR*IK*TESTPLAN-SREGLR-2602200043000P**5555.82"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*17;2"                                          
#> [6] "REF*ZZ*Dual-State Only"                               
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> 
#> 
#> $sample_820_02$TRAILER
#>   SEG PT     VALUE
#> 1  SE 01       162
#> 2  SE 02      0001
#> 3  GE 01         1
#> 4  GE 02     44273
#> 5 IEA 01         1
#> 6 IEA 02 000059660
#> 
#> 
#> $sample_820_03
#> $sample_820_03$HEADER
#>      SEG PT                   VALUE
#> 1    ISA 01                      00
#> 2    ISA 02                    <NA>
#> 3    ISA 03                      00
#> 4    ISA 04                    <NA>
#> 5    ISA 05                      ZZ
#> 6    ISA 06              TEST-PAYER
#> 7    ISA 07                      30
#> 8    ISA 08              TEST-PAYEE
#> 9    ISA 09                  260316
#> 10   ISA 10                    0854
#> 11   ISA 11                       +
#> 12   ISA 12                   00501
#> 13   ISA 13               000059659
#> 14   ISA 14                       0
#> 15   ISA 15                       P
#> 16   ISA 16                       :
#> 17    GS 01                      RA
#> 18    GS 02              TEST-PAYER
#> 19    GS 03              TEST-PAYEE
#> 20    GS 04                20260316
#> 21    GS 05                  085458
#> 22    GS 06                   44272
#> 23    GS 07                       X
#> 24    GS 08              005010X218
#> 25    ST 01                     820
#> 26    ST 02                    0001
#> 27    ST 03              005010X218
#> 28   BPR 01                       I
#> 29   BPR 02               697085.64
#> 30   BPR 03                       C
#> 31   BPR 04                     NON
#> 32   BPR 05                    <NA>
#> 33   BPR 06                    <NA>
#> 34   BPR 07                    <NA>
#> 35   BPR 08                    <NA>
#> 36   BPR 09                    <NA>
#> 37   BPR 10              68-0317191
#> 38   BPR 11                    <NA>
#> 39   BPR 12                    <NA>
#> 40   BPR 13                    <NA>
#> 41   BPR 14                    <NA>
#> 42   BPR 15                    <NA>
#> 43   BPR 16                20260312
#> 44   TRN 01                       3
#> 45   TRN 02         TESTTRN03000001
#> 46   REF 01                      14
#> 47   REF 02              0000245023
#> 48 N1*PE 01                      PE
#> 49 N1*PE 02 TEST PAYEE ORGANIZATION
#> 50 N3*PE 01         123 TEST STREET
#> 51 N4*PE 01                TESTCITY
#> 52 N4*PE 02                      CA
#> 53 N4*PE 03                   00000
#> 54 N1*PR 01                      PR
#> 55 N1*PR 02       TEST PAYER AGENCY
#> 56 N3*PR 01         123 TEST STREET
#> 57 N4*PR 01                TESTCITY
#> 58 N4*PR 02                      CA
#> 59 N4*PR 03                   00000
#> 
#> $sample_820_03$LOOP
#> $sample_820_03$LOOP$L1
#>  [1] "ENT*1*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME14*FIRSTNAME14****N*TESTMBR000000014"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*60;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*60;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L2
#>  [1] "ENT*2*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME15*FIRSTNAME15****N*TESTMBR000000015"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*60;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*60;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L3
#> [1] "ENT*3*2J*EI*999999999"                                
#> [2] "NM1*IL*1*LASTNAME16*FIRSTNAME16****N*TESTMBR000000016"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*1H;1"                                          
#> [6] "REF*ZZ*Primary Capitation Dual"                       
#> [7] "DTM*582****RD8*20260201-20260228"                     
#> 
#> $sample_820_03$LOOP$L4
#>  [1] "ENT*4*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME17*FIRSTNAME17****N*TESTMBR000000017"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L5
#>  [1] "ENT*5*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME18*FIRSTNAME18****N*TESTMBR000000018"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*M1;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**559.75*9645.74"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*M1;1"                                          
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-9085.99*53"                                      
#> 
#> $sample_820_03$LOOP$L6
#> [1] "ENT*6*2J*EI*999999999"                                
#> [2] "NM1*IL*1*LASTNAME19*FIRSTNAME19****N*TESTMBR000000019"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*17;1"                                          
#> [6] "REF*ZZ*Primary Capitation Dual"                       
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L7
#>  [1] "ENT*7*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME20*FIRSTNAME20****N*TESTMBR000000020"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*M1;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**559.75*9645.74"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*M1;1"                                          
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-9085.99*53"                                      
#> 
#> $sample_820_03$LOOP$L8
#> [1] "ENT*8*2J*EI*999999999"                                
#> [2] "NM1*IL*1*LASTNAME21*FIRSTNAME21****N*TESTMBR000000021"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*17;1"                                          
#> [6] "REF*ZZ*Primary Capitation Dual"                       
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L9
#>  [1] "ENT*9*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME22*FIRSTNAME22****N*TESTMBR000000022"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*10;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*10;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L10
#>  [1] "ENT*10*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME23*FIRSTNAME23****N*TESTMBR000000023"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L11
#>  [1] "ENT*11*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME24*FIRSTNAME24****N*TESTMBR000000024"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*6H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*6H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L12
#>  [1] "ENT*12*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME25*FIRSTNAME25****N*TESTMBR000000025"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*60;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*60;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L13
#>  [1] "ENT*13*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME26*FIRSTNAME26****N*TESTMBR000000026"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**559.75*9645.74"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-9085.99*53"                                      
#> 
#> $sample_820_03$LOOP$L14
#>  [1] "ENT*14*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME27*FIRSTNAME27****N*TESTMBR000000027"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*20;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*20;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L15
#>  [1] "ENT*15*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME28*FIRSTNAME28****N*TESTMBR000000028"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L16
#>  [1] "ENT*16*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME29*FIRSTNAME29****N*TESTMBR000000029"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*M1;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**559.75*9645.74"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*M1;1"                                          
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-9085.99*53"                                      
#> 
#> $sample_820_03$LOOP$L17
#>  [1] "ENT*17*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME30*FIRSTNAME30****N*TESTMBR000000030"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L18
#>  [1] "ENT*18*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME31*FIRSTNAME31****N*TESTMBR000000031"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*60;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*60;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L19
#>  [1] "ENT*19*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME32*FIRSTNAME32****N*TESTMBR000000032"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L20
#>  [1] "ENT*20*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME33*FIRSTNAME33****N*TESTMBR000000033"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*20;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**559.75*9645.74"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*20;1"                                          
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-9085.99*53"                                      
#> 
#> $sample_820_03$LOOP$L21
#>  [1] "ENT*21*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME34*FIRSTNAME34****N*TESTMBR000000034"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*60;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*60;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L22
#>  [1] "ENT*22*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME35*FIRSTNAME35****N*TESTMBR000000035"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**559.75*9645.74"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-9085.99*53"                                      
#> 
#> $sample_820_03$LOOP$L23
#>  [1] "ENT*23*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME36*FIRSTNAME36****N*TESTMBR000000036"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*60;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*60;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L24
#>  [1] "ENT*24*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME37*FIRSTNAME37****N*TESTMBR000000037"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*M1;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**559.75*9645.74"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*M1;1"                                          
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-9085.99*53"                                      
#> 
#> $sample_820_03$LOOP$L25
#>  [1] "ENT*25*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME38*FIRSTNAME38****N*TESTMBR000000038"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*60;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**559.75*9645.74"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*60;1"                                          
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-9085.99*53"                                      
#> 
#> $sample_820_03$LOOP$L26
#>  [1] "ENT*26*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME39*FIRSTNAME39****N*TESTMBR000000039"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*M1;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**559.75*9645.74"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*M1;1"                                          
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-9085.99*53"                                      
#> 
#> $sample_820_03$LOOP$L27
#>  [1] "ENT*27*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME40*FIRSTNAME40****N*TESTMBR000000040"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L28
#>  [1] "ENT*28*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME41*FIRSTNAME41****N*TESTMBR000000041"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L29
#>  [1] "ENT*29*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME42*FIRSTNAME42****N*TESTMBR000000042"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*10;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*10;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L30
#>  [1] "ENT*30*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME43*FIRSTNAME43****N*TESTMBR000000043"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L31
#>  [1] "ENT*31*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME44*FIRSTNAME44****N*TESTMBR000000044"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*M1;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*M1;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5258.86"       
#> [14] "REF*18*957"                                           
#> [15] "REF*ZZ*M1;1"                                          
#> [16] "REF*ZZ*Primary Capitation Dual"                       
#> [17] "DTM*582****RD8*20251201-20251231"                     
#> [18] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5258.86"       
#> [19] "REF*18*957"                                           
#> [20] "REF*ZZ*M1;1"                                          
#> [21] "REF*ZZ*Primary Capitation Dual"                       
#> [22] "DTM*582****RD8*20251101-20251130"                     
#> [23] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5258.86"       
#> [24] "REF*18*957"                                           
#> [25] "REF*ZZ*M1;1"                                          
#> [26] "REF*ZZ*Primary Capitation Dual"                       
#> [27] "DTM*582****RD8*20251001-20251031"                     
#> 
#> $sample_820_03$LOOP$L32
#>  [1] "ENT*32*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME45*FIRSTNAME45****N*TESTMBR000000045"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*60;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**559.75*9645.74"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*60;1"                                          
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-9085.99*53"                                      
#> 
#> $sample_820_03$LOOP$L33
#>  [1] "ENT*33*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME46*FIRSTNAME46****N*TESTMBR000000046"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L34
#>  [1] "ENT*34*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME47*FIRSTNAME47****N*TESTMBR000000047"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*60;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*60;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L35
#>  [1] "ENT*35*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME48*FIRSTNAME48****N*TESTMBR000000048"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*60;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**559.75*9645.74"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*60;1"                                          
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-9085.99*53"                                      
#> 
#> $sample_820_03$LOOP$L36
#>  [1] "ENT*36*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME49*FIRSTNAME49****N*TESTMBR000000049"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L37
#>  [1] "ENT*37*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME50*FIRSTNAME50****N*TESTMBR000000050"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L38
#> [1] "ENT*38*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME51*FIRSTNAME51****N*TESTMBR000000051"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*M3;1"                                          
#> [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [7] "DTM*582****RD8*20260201-20260228"                     
#> 
#> $sample_820_03$LOOP$L39
#>  [1] "ENT*39*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME52*FIRSTNAME52****N*TESTMBR000000052"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L40
#>  [1] "ENT*40*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME53*FIRSTNAME53****N*TESTMBR000000053"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L41
#>  [1] "ENT*41*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME54*FIRSTNAME54****N*TESTMBR000000054"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*20;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*20;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L42
#>  [1] "ENT*42*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME55*FIRSTNAME55****N*TESTMBR000000055"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*10;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*10;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L43
#>  [1] "ENT*43*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME56*FIRSTNAME56****N*TESTMBR000000056"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*10;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*10;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L44
#>  [1] "ENT*44*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME57*FIRSTNAME57****N*TESTMBR000000057"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*60;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*60;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5258.86"       
#> [14] "REF*18*957"                                           
#> [15] "REF*ZZ*60;1"                                          
#> [16] "REF*ZZ*Primary Capitation Dual"                       
#> [17] "DTM*582****RD8*20251201-20251231"                     
#> [18] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5258.86"       
#> [19] "REF*18*957"                                           
#> [20] "REF*ZZ*60;1"                                          
#> [21] "REF*ZZ*Primary Capitation Dual"                       
#> [22] "DTM*582****RD8*20251101-20251130"                     
#> [23] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5258.86"       
#> [24] "REF*18*957"                                           
#> [25] "REF*ZZ*60;1"                                          
#> [26] "REF*ZZ*Primary Capitation Dual"                       
#> [27] "DTM*582****RD8*20251001-20251031"                     
#> 
#> $sample_820_03$LOOP$L45
#>  [1] "ENT*45*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME58*FIRSTNAME58****N*TESTMBR000000058"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*60;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*60;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L46
#>  [1] "ENT*46*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME59*FIRSTNAME59****N*TESTMBR000000059"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L47
#>  [1] "ENT*47*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME60*FIRSTNAME60****N*TESTMBR000000060"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*10;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*10;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L48
#>  [1] "ENT*48*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME61*FIRSTNAME61****N*TESTMBR000000061"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L49
#> [1] "ENT*49*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME62*FIRSTNAME62****N*TESTMBR000000062"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*10;1"                                          
#> [6] "REF*ZZ*Primary Capitation Dual"                       
#> [7] "DTM*582****RD8*20260201-20260228"                     
#> 
#> $sample_820_03$LOOP$L50
#>  [1] "ENT*50*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME01*FIRSTNAME01****N*TESTMBR000000001"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**343.66"        
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;2"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**185.89*343.66" 
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;2"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-157.77*53"                                       
#> 
#> $sample_820_03$LOOP$L51
#> [1] "ENT*51*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME63*FIRSTNAME63****N*TESTMBR000000063"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*17;1"                                          
#> [6] "REF*ZZ*Primary Capitation Dual"                       
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L52
#>  [1] "ENT*52*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME64*FIRSTNAME64****N*TESTMBR000000064"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*M1;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**559.75*9645.74"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*M1;1"                                          
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-9085.99*53"                                      
#> 
#> $sample_820_03$LOOP$L53
#>  [1] "ENT*53*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME65*FIRSTNAME65****N*TESTMBR000000065"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*60;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**559.75*9645.74"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*60;1"                                          
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-9085.99*53"                                      
#> 
#> $sample_820_03$LOOP$L54
#>  [1] "ENT*54*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME66*FIRSTNAME66****N*TESTMBR000000066"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L55
#>  [1] "ENT*55*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME02*FIRSTNAME02****N*TESTMBR000000002" 
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**2314.98"        
#>  [4] "REF*18*957"                                            
#>  [5] "REF*ZZ*1H;2"                                           
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"               
#>  [7] "DTM*582****RD8*20260201-20260228"                      
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**1315.52*2314.98"
#>  [9] "REF*18*957"                                            
#> [10] "REF*ZZ*1H;2"                                           
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"               
#> [12] "DTM*582****RD8*20260101-20260131"                      
#> [13] "ADX*-999.46*53"                                        
#> 
#> $sample_820_03$LOOP$L56
#>  [1] "ENT*56*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME67*FIRSTNAME67****N*TESTMBR000000067"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5258.86"       
#> [14] "REF*18*957"                                           
#> [15] "REF*ZZ*1H;1"                                          
#> [16] "REF*ZZ*Primary Capitation Dual"                       
#> [17] "DTM*582****RD8*20251201-20251231"                     
#> [18] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5258.86"       
#> [19] "REF*18*957"                                           
#> [20] "REF*ZZ*1H;1"                                          
#> [21] "REF*ZZ*Primary Capitation Dual"                       
#> [22] "DTM*582****RD8*20251101-20251130"                     
#> [23] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5258.86"       
#> [24] "REF*18*957"                                           
#> [25] "REF*ZZ*1H;1"                                          
#> [26] "REF*ZZ*Primary Capitation Dual"                       
#> [27] "DTM*582****RD8*20251001-20251031"                     
#> 
#> $sample_820_03$LOOP$L57
#>  [1] "ENT*57*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME68*FIRSTNAME68****N*TESTMBR000000068"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L58
#>  [1] "ENT*58*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME03*FIRSTNAME03****N*TESTMBR000000003" 
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**2314.98"        
#>  [4] "REF*18*957"                                            
#>  [5] "REF*ZZ*M1;2"                                           
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"               
#>  [7] "DTM*582****RD8*20260201-20260228"                      
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**1315.52*2314.98"
#>  [9] "REF*18*957"                                            
#> [10] "REF*ZZ*M1;2"                                           
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"               
#> [12] "DTM*582****RD8*20260101-20260131"                      
#> [13] "ADX*-999.46*53"                                        
#> 
#> $sample_820_03$LOOP$L59
#>  [1] "ENT*59*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME13*FIRSTNAME13****N*TESTMBR000000013"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**2314.98"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;2"                                          
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**2314.98"       
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;2"                                          
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L60
#> [1] "ENT*60*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME69*FIRSTNAME69****N*TESTMBR000000069"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*17;1"                                          
#> [6] "REF*ZZ*Primary Capitation Dual"                       
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L61
#> [1] "ENT*61*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME70*FIRSTNAME70****N*TESTMBR000000070"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*17;1"                                          
#> [6] "REF*ZZ*Primary Capitation Dual"                       
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L62
#> [1] "ENT*62*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME71*FIRSTNAME71****N*TESTMBR000000071"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*17;1"                                          
#> [6] "REF*ZZ*Primary Capitation Dual"                       
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L63
#>  [1] "ENT*63*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME72*FIRSTNAME72****N*TESTMBR000000072"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**559.75*9645.74"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-9085.99*53"                                      
#> 
#> $sample_820_03$LOOP$L64
#> [1] "ENT*64*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME73*FIRSTNAME73****N*TESTMBR000000073"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*17;1"                                          
#> [6] "REF*ZZ*Primary Capitation Dual"                       
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L65
#>  [1] "ENT*65*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME04*FIRSTNAME04****N*TESTMBR000000004" 
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**2314.98"        
#>  [4] "REF*18*957"                                            
#>  [5] "REF*ZZ*M1;2"                                           
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"               
#>  [7] "DTM*582****RD8*20260201-20260228"                      
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**1315.52*2314.98"
#>  [9] "REF*18*957"                                            
#> [10] "REF*ZZ*M1;2"                                           
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"               
#> [12] "DTM*582****RD8*20260101-20260131"                      
#> [13] "ADX*-999.46*53"                                        
#> 
#> $sample_820_03$LOOP$L66
#>  [1] "ENT*66*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME05*FIRSTNAME05****N*TESTMBR000000005" 
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**2314.98"        
#>  [4] "REF*18*957"                                            
#>  [5] "REF*ZZ*1H;2"                                           
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"               
#>  [7] "DTM*582****RD8*20260201-20260228"                      
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**1315.52*2314.98"
#>  [9] "REF*18*957"                                            
#> [10] "REF*ZZ*M1;2"                                           
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"               
#> [12] "DTM*582****RD8*20260101-20260131"                      
#> [13] "ADX*-999.46*53"                                        
#> 
#> $sample_820_03$LOOP$L67
#>  [1] "ENT*67*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME06*FIRSTNAME06****N*TESTMBR000000006"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**-999.46"       
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;2"                                          
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#> [14] "REF*18*957"                                           
#> [15] "REF*ZZ*1H;1"                                          
#> [16] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [17] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L68
#>  [1] "ENT*68*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME07*FIRSTNAME07****N*TESTMBR000000007" 
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**2314.98"        
#>  [4] "REF*18*957"                                            
#>  [5] "REF*ZZ*M1;2"                                           
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"               
#>  [7] "DTM*582****RD8*20260201-20260228"                      
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**1315.52*2314.98"
#>  [9] "REF*18*957"                                            
#> [10] "REF*ZZ*M1;2"                                           
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"               
#> [12] "DTM*582****RD8*20260101-20260131"                      
#> [13] "ADX*-999.46*53"                                        
#> 
#> $sample_820_03$LOOP$L69
#>  [1] "ENT*69*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME08*FIRSTNAME08****N*TESTMBR000000008" 
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**2314.98"        
#>  [4] "REF*18*957"                                            
#>  [5] "REF*ZZ*1H;2"                                           
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"               
#>  [7] "DTM*582****RD8*20260201-20260228"                      
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**1315.52*2314.98"
#>  [9] "REF*18*957"                                            
#> [10] "REF*ZZ*1H;2"                                           
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"               
#> [12] "DTM*582****RD8*20260101-20260131"                      
#> [13] "ADX*-999.46*53"                                        
#> 
#> $sample_820_03$LOOP$L70
#>  [1] "ENT*70*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME74*FIRSTNAME74****N*TESTMBR000000074"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*M1;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**559.75*9645.74"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*M1;1"                                          
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-9085.99*53"                                      
#> 
#> $sample_820_03$LOOP$L71
#>  [1] "ENT*71*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME75*FIRSTNAME75****N*TESTMBR000000075"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L72
#>  [1] "ENT*72*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME76*FIRSTNAME76****N*TESTMBR000000076"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*10;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*10;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5258.86"       
#> [14] "REF*18*957"                                           
#> [15] "REF*ZZ*1H;1"                                          
#> [16] "REF*ZZ*Primary Capitation Dual"                       
#> [17] "DTM*582****RD8*20251201-20251231"                     
#> 
#> $sample_820_03$LOOP$L73
#>  [1] "ENT*73*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME09*FIRSTNAME09****N*TESTMBR000000009" 
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**2314.98"        
#>  [4] "REF*18*957"                                            
#>  [5] "REF*ZZ*1H;2"                                           
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"               
#>  [7] "DTM*582****RD8*20260201-20260228"                      
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**1315.52*2314.98"
#>  [9] "REF*18*957"                                            
#> [10] "REF*ZZ*1H;2"                                           
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"               
#> [12] "DTM*582****RD8*20260101-20260131"                      
#> [13] "ADX*-999.46*53"                                        
#> 
#> $sample_820_03$LOOP$L74
#> [1] "ENT*74*2J*EI*999999999"                                
#> [2] "NM1*IL*1*LASTNAME10*FIRSTNAME10****N*TESTMBR000000010" 
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**1315.52*2314.98"
#> [4] "REF*18*957"                                            
#> [5] "REF*ZZ*1H;2"                                           
#> [6] "REF*ZZ*Primary Capitation Medi-Cal Only"               
#> [7] "DTM*582****RD8*20260101-20260131"                      
#> [8] "ADX*-999.46*53"                                        
#> 
#> $sample_820_03$LOOP$L75
#>  [1] "ENT*75*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME77*FIRSTNAME77****N*TESTMBR000000077"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*10;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*10;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L76
#>  [1] "ENT*76*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME78*FIRSTNAME78****N*TESTMBR000000078"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*10;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*10;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L77
#>  [1] "ENT*77*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME79*FIRSTNAME79****N*TESTMBR000000079"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*M1;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**559.75*9645.74"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*M1;1"                                          
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-9085.99*53"                                      
#> 
#> $sample_820_03$LOOP$L78
#>  [1] "ENT*78*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME80*FIRSTNAME80****N*TESTMBR000000080"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*16;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*16;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L79
#>  [1] "ENT*79*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME81*FIRSTNAME81****N*TESTMBR000000081"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L80
#>  [1] "ENT*80*2J*EI*999999999"                                
#>  [2] "NM1*IL*1*LASTNAME11*FIRSTNAME11****N*TESTMBR000000011" 
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**2314.98"        
#>  [4] "REF*18*957"                                            
#>  [5] "REF*ZZ*M1;2"                                           
#>  [6] "REF*ZZ*Primary Capitation Medi-Cal Only"               
#>  [7] "DTM*582****RD8*20260201-20260228"                      
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**1315.52*2314.98"
#>  [9] "REF*18*957"                                            
#> [10] "REF*ZZ*M1;2"                                           
#> [11] "REF*ZZ*Primary Capitation Medi-Cal Only"               
#> [12] "DTM*582****RD8*20260101-20260131"                      
#> [13] "ADX*-999.46*53"                                        
#> 
#> $sample_820_03$LOOP$L81
#>  [1] "ENT*81*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME82*FIRSTNAME82****N*TESTMBR000000082"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L82
#> [1] "ENT*82*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME83*FIRSTNAME83****N*TESTMBR000000083"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*1H;1"                                          
#> [6] "REF*ZZ*Primary Capitation Dual"                       
#> [7] "DTM*582****RD8*20260201-20260228"                     
#> 
#> $sample_820_03$LOOP$L83
#> [1] "ENT*83*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME84*FIRSTNAME84****N*TESTMBR000000084"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*17;1"                                          
#> [6] "REF*ZZ*Primary Capitation Dual"                       
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L84
#>  [1] "ENT*84*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME85*FIRSTNAME85****N*TESTMBR000000085"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L85
#> [1] "ENT*85*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME12*FIRSTNAME12****N*TESTMBR000000012"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**343.66"        
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*17;2"                                          
#> [6] "REF*ZZ*Primary Capitation Dual"                       
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L86
#> [1] "ENT*86*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME86*FIRSTNAME86****N*TESTMBR000000086"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*17;1"                                          
#> [6] "REF*ZZ*Primary Capitation Dual"                       
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L87
#> [1] "ENT*87*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME87*FIRSTNAME87****N*TESTMBR000000087"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**9645.74"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*17;1"                                          
#> [6] "REF*ZZ*Primary Capitation Medi-Cal Only"              
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L88
#> [1] "ENT*88*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME88*FIRSTNAME88****N*TESTMBR000000088"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*17;1"                                          
#> [6] "REF*ZZ*Primary Capitation Dual"                       
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L89
#> [1] "ENT*89*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME89*FIRSTNAME89****N*TESTMBR000000089"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*17;1"                                          
#> [6] "REF*ZZ*Primary Capitation Dual"                       
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L90
#> [1] "ENT*90*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME90*FIRSTNAME90****N*TESTMBR000000090"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*17;1"                                          
#> [6] "REF*ZZ*Primary Capitation Dual"                       
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L91
#> [1] "ENT*91*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME91*FIRSTNAME91****N*TESTMBR000000091"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*17;1"                                          
#> [6] "REF*ZZ*Primary Capitation Dual"                       
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> 
#> $sample_820_03$LOOP$L92
#>  [1] "ENT*92*2J*EI*999999999"                               
#>  [2] "NM1*IL*1*LASTNAME92*FIRSTNAME92****N*TESTMBR000000092"
#>  [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#>  [4] "REF*18*957"                                           
#>  [5] "REF*ZZ*1H;1"                                          
#>  [6] "REF*ZZ*Primary Capitation Dual"                       
#>  [7] "DTM*582****RD8*20260201-20260228"                     
#>  [8] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**468.79*5727.65"
#>  [9] "REF*18*957"                                           
#> [10] "REF*ZZ*1H;1"                                          
#> [11] "REF*ZZ*Primary Capitation Dual"                       
#> [12] "DTM*582****RD8*20260101-20260131"                     
#> [13] "ADX*-5258.86*53"                                      
#> 
#> $sample_820_03$LOOP$L93
#> [1] "ENT*93*2J*EI*999999999"                               
#> [2] "NM1*IL*1*LASTNAME93*FIRSTNAME93****N*TESTMBR000000093"
#> [3] "RMR*IK*TESTPLAN-PREGLR-2602200042000P**5727.65"       
#> [4] "REF*18*957"                                           
#> [5] "REF*ZZ*17;1"                                          
#> [6] "REF*ZZ*Primary Capitation Dual"                       
#> [7] "DTM*582****RD8*20260101-20260131"                     
#> 
#> 
#> $sample_820_03$TRAILER
#>   SEG PT     VALUE
#> 1  SE 01      1142
#> 2  SE 02      0001
#> 3  GE 01         1
#> 4  GE 02     44272
#> 5 IEA 01         1
#> 6 IEA 02 000059659
#> 
#> 
```
