# X12-837 Health Care Claim Parser

The 837 describes the care event: who (rendering provider, supervising
physician, referring), for whom (subscriber, patient), for what (ICD-10
diagnosis, CPT/HCPCS procedure), when (service date, units), where
(place of service), and how much (charged amount, contractual
reference). Three `TR3`s segment the audience:

- `005010X222A1`: **837P** Professional (Physicians, Ambulatory,
  Telemedicine)

- `005010X223A2`: **837I** Institutional (Hospitals, ED, Hospice)

- `005010X224A2`: **837D** Dental

## Usage

``` r
parse_837(text)
```

## Arguments

- text:

  `<chr>` string of raw X12-837 text

## Value

list

## Details

The 837 is the highest-volume transaction in US healthcare EDI. Every
commercial and public payer (Medicare, Medicaid, Tricare) consumes
hundreds of millions per month.

The entire provider-side billing revolves around its generation: from
the EHR (Epic, Cerner, Athenahealth, NextGen) or the PMS (Kareo,
AdvancedMD, eClinicalWorks), through a clearinghouse (Availity, Change
Healthcare, Waystar, Trizetto), with `277CA`, `999`, and ultimately
`835` returns.

### Common segments

#### Transaction Set Header

- `BHT`: Beginning of Hierarchical Transaction

  - Purpose `00` (Original)

  - Transaction type `CH` (Chargeable)

  - `RP` Reporting

  - Submitter `NM1*41`

  - Receiver `NM1*40`

#### Detail: Three hierarchical levels

- `2000A` Billing Provider (Practice or Facility, with NPI, Taxonomy,
  TIN)

- `2000B` Subscriber Loop (Contract Holder)

  - `SBR`:

    - Subscriber Information with relationship code

    - Claim filing indicator (`CI` Commercial Insurance, `MB` Medicare
      Part B, `MC` Medicaid, etc.)

- `2000C` Patient Loop (the Patient when different from the Subscriber).

  - At the claim level, `CLM` Claim Information carries the patient
    account, total charge, facility code, claim frequency.

  - `HI` Health Care Information Codes carries ICD-10 diagnoses
    (qualifier `ABK` Principal Diagnosis, `ABF` Other Diagnosis).

  - The service section groups `LX` + `SV1` (Professional) / `SV2`
    (Institutional) / `SV3` (Dental) detailing each procedure with its
    CPT / HCPCS / CDT code, modifiers, units, charge, and service date
    via `DTP`.

#### Summary

— a single `SE`

## Examples

``` r
purrr::map(hcc::x12_837, parse_837)
#> $minimal_837P
#> $minimal_837P$HEADER
#>    SEG PT        VALUE
#> 1  ISA 01           00
#> 2  ISA 02         <NA>
#> 3  ISA 03           00
#> 4  ISA 04         <NA>
#> 5  ISA 05           ZZ
#> 6  ISA 06   PROVIDER01
#> 7  ISA 07           ZZ
#> 8  ISA 08      PAYER99
#> 9  ISA 09       260415
#> 10 ISA 10         1030
#> 11 ISA 11            U
#> 12 ISA 12        00501
#> 13 ISA 13    000000837
#> 14 ISA 14            0
#> 15 ISA 15            P
#> 16 ISA 16            >
#> 17  GS 01           HC
#> 18  GS 02   PROVIDER01
#> 19  GS 03      PAYER99
#> 20  GS 04     20260415
#> 21  GS 05         1030
#> 22  GS 06            1
#> 23  GS 07            X
#> 24  GS 08 005010X222A1
#> 
#> $minimal_837P$TRANSACTIONS
#> $minimal_837P$TRANSACTIONS[[1]]
#>  [1] "ST*837*0001*005010X222A1"                
#>  [2] "BHT*0019*00*REQ-CLM-001*20260415*1030*CH"
#>  [3] "NM1*41*2*ACME CLINIC*****46*1234567890"  
#>  [4] "PER*IC*BILLING DEPT*TE*5551234567"       
#>  [5] "NM1*40*2*PAYER99*****46*PAYER99"         
#>  [6] "HL*1**20*1"                              
#>  [7] "NM1*85*2*ACME CLINIC*****XX*1234567890"  
#>  [8] "N3*100 MAIN ST"                          
#>  [9] "N4*ATLANTA*GA*30303"                     
#> [10] "REF*EI*987654321"                        
#> [11] "HL*2*1*22*0"                             
#> [12] "SBR*P*18*GRP4567*****CI"                 
#> [13] "NM1*IL*1*DOE*JANE****MI*MEMBER12345"     
#> [14] "N3*250 OAK AVE"                          
#> [15] "N4*ATLANTA*GA*30309"                     
#> [16] "DMG*D8*19850412*F"                       
#> [17] "NM1*PR*2*PAYER99*****PI*PAYER99"         
#> [18] "CLM*PATACCT-9911*620.00***11:B:1*Y*A*Y*Y"
#> [19] "HI*ABK:M5435"                            
#> [20] "LX*1"                                    
#> [21] "SV1*HC:99213*120.00*UN*1***1"            
#> [22] "DTP*472*D8*20260401"                     
#> [23] "LX*2"                                    
#> [24] "SV1*HC:90834*500.00*UN*1***1"            
#> [25] "DTP*472*D8*20260401"                     
#> [26] "SE*26*0001"                              
#> 
#> 
#> $minimal_837P$TRAILER
#>   SEG PT     VALUE
#> 1  GE 01         1
#> 2  GE 02         1
#> 3 IEA 01         1
#> 4 IEA 02 000000837
#> 
#> 
#> $sample_837_0
#> $sample_837_0$HEADER
#>    SEG PT         VALUE
#> 1  ISA 01            00
#> 2  ISA 02          <NA>
#> 3  ISA 03            00
#> 4  ISA 04          <NA>
#> 5  ISA 05            01
#> 6  ISA 06     987654321
#> 7  ISA 07            ZZ
#> 8  ISA 08     123456789
#> 9  ISA 09        180508
#> 10 ISA 10          0833
#> 11 ISA 11             ^
#> 12 ISA 12         00501
#> 13 ISA 13     697773230
#> 14 ISA 14             1
#> 15 ISA 15             P
#> 16 ISA 16             :
#> 17  GS 01            HC
#> 18  GS 02 CLEARINGHOUSE
#> 19  GS 03     123456789
#> 20  GS 04      20180508
#> 21  GS 05          0833
#> 22  GS 06     212950697
#> 23  GS 07             X
#> 24  GS 08  005010X222A1
#> 
#> $sample_837_0$TRANSACTIONS
#> $sample_837_0$TRANSACTIONS[[1]]
#>  [1] "ST*837*000000001*005010X222A1"                                   
#>  [2] "BHT*0019*00*7349063984*20180508*0833*CH"                         
#>  [3] "NM1*41*2*CLEARINGHOUSE LLC*****46*987654321"                     
#>  [4] "PER*IC*CLEARINGHOUSE CLIENT SERVICES*TE*5555550000*FX*5555550000"
#>  [5] "NM1*40*2*123456789*****46*CHPWA"                                 
#>  [6] "HL*1**20*1"                                                      
#>  [7] "NM1*85*2*BH CLINIC OF VANCOUVER*****XX*1122334455"               
#>  [8] "N3*12345 MAIN ST"                                                
#>  [9] "N4*VANCOUVER*WA*98662"                                           
#> [10] "REF*EI*720000000"                                                
#> [11] "PER*IC*CONTACT*TE*5555550000"                                    
#> [12] "NM1*87*2"                                                        
#> [13] "N3*PO BOX 1234"                                                  
#> [14] "N4*VANCOUVER*WA*986681234"                                       
#> [15] "HL*2*1*22*0"                                                     
#> [16] "SBR*P*18**COMMUNITY HLTH PLAN OF WASH*****CI"                    
#> [17] "NM1*IL*1*SUBSCRIBER*JOHN*J***MI*987321"                          
#> [18] "N3*123 TEST STREET"                                              
#> [19] "N4*TESTCITY*CA*00000"                                            
#> [20] "DMG*D8*19000101*M"                                               
#> [21] "NM1*PR*2*COMMUNITY HEALTH PLAN OF WASHINGTON*****PI*CHPWA"       
#> [22] "CLM*1805080AV3648339*20***57:B:1*Y*A*Y*Y"                        
#> [23] "REF*D9*7349065509"                                               
#> [24] "HI*ABK:F1120"                                                    
#> [25] "NM1*82*1*PROVIDER*JAMES****XX*1112223338"                        
#> [26] "PRV*PE*PXC*261QR0405X"                                           
#> [27] "NM1*77*2*BH CLINIC OF VANCOUVER*****XX*1122334455"               
#> [28] "N3*12345 MAIN ST SUITE A1"                                       
#> [29] "N4*VANCOUVER*WA*98662"                                           
#> [30] "LX*1"                                                            
#> [31] "SV1*HC:H0003*20*UN*1***1"                                        
#> [32] "DTP*472*D8*20180428"                                             
#> [33] "REF*6R*142671"                                                   
#> [34] "SE*34*000000001"                                                 
#> 
#> $sample_837_0$TRANSACTIONS[[2]]
#>  [1] "ST*837*000000002*005010X222A1"                                   
#>  [2] "BHT*0019*00*7349063984*20180508*0833*CH"                         
#>  [3] "NM1*41*2*CLEARINGHOUSE LLC*****46*987654321"                     
#>  [4] "PER*IC*CLEARINGHOUSE CLIENT SERVICES*TE*5555550000*FX*5555550000"
#>  [5] "NM1*40*2*123456789*****46*CHPWA"                                 
#>  [6] "HL*63**20*1"                                                     
#>  [7] "NM1*85*2*BH CLINIC OF VANCOUVER*****XX*1122334455"               
#>  [8] "N3*12345 MAIN ST"                                                
#>  [9] "N4*VANCOUVER*WA*98662"                                           
#> [10] "REF*EI*720000000"                                                
#> [11] "PER*IC*CONTACT*TE*5555550000"                                    
#> [12] "NM1*87*2"                                                        
#> [13] "N3*PO BOX 1234"                                                  
#> [14] "N4*VANCOUVER*WA*986681234"                                       
#> [15] "HL*64*63*22*0"                                                   
#> [16] "SBR*P*18**COMMUNITY HLTH PLAN OF WASH*****CI"                    
#> [17] "NM1*IL*1*PATIENT*SUSAN*E***MI*765123"                            
#> [18] "N3*123 TEST STREET"                                              
#> [19] "N4*TESTCITY*CA*00000"                                            
#> [20] "DMG*D8*19000101*F"                                               
#> [21] "NM1*PR*2*COMMUNITY HEALTH PLAN OF WASHINGTON*****PI*CHPWA"       
#> [22] "CLM*1805080AV3648347*50.1***57:B:1*Y*A*Y*Y"                      
#> [23] "REF*D9*7349065730"                                               
#> [24] "HI*ABK:F1520*ABF:F1220"                                          
#> [25] "NM1*82*1*PROVIDER*SUSAN****XX*1112223346"                        
#> [26] "PRV*PE*PXC*261QR0405X"                                           
#> [27] "NM1*77*2*BH CLINIC OF VANCOUVER*****XX*1122334455"               
#> [28] "N3*12345 MAIN ST SUITE A1"                                       
#> [29] "N4*VANCOUVER*WA*98662"                                           
#> [30] "LX*1"                                                            
#> [31] "SV1*HC:96153:HF*50.1*UN*6***1:2"                                 
#> [32] "DTP*472*D8*20180426"                                             
#> [33] "REF*6R*143792"                                                   
#> [34] "SE*34*000000002"                                                 
#> 
#> $sample_837_0$TRANSACTIONS[[3]]
#>  [1] "ST*837*000000003*005010X222A1"                                   
#>  [2] "BHT*0019*00*7349063984*20180508*0833*CH"                         
#>  [3] "NM1*41*2*CLEARINGHOUSE LLC*****46*987654321"                     
#>  [4] "PER*IC*CLEARINGHOUSE CLIENT SERVICES*TE*5555550000*FX*5555550000"
#>  [5] "NM1*40*2*123456789*****46*CHPWA"                                 
#>  [6] "HL*49**20*1"                                                     
#>  [7] "NM1*85*2*BH CLINIC OF VANCOUVER*****XX*1122334455"               
#>  [8] "N3*12345 MAIN ST"                                                
#>  [9] "N4*VANCOUVER*WA*98662"                                           
#> [10] "REF*EI*720000000"                                                
#> [11] "PER*IC*CONTACT*TE*5555550000"                                    
#> [12] "NM1*87*2"                                                        
#> [13] "N3*PO BOX 1234"                                                  
#> [14] "N4*VANCOUVER*WA*986681234"                                       
#> [15] "HL*50*49*22*0"                                                   
#> [16] "SBR*P*18**COMMUNITY HLTH PLAN OF WASH*****CI"                    
#> [17] "NM1*IL*1*SUBSCRIBER*JOHN*J***MI*987321"                          
#> [18] "N3*123 TEST STREET"                                              
#> [19] "N4*TESTCITY*CA*00000"                                            
#> [20] "DMG*D8*19000101*M"                                               
#> [21] "NM1*PR*2*COMMUNITY HEALTH PLAN OF WASHINGTON*****PI*CHPWA"       
#> [22] "CLM*1805080AV3648340*11.64***57:B:1*Y*A*Y*Y"                     
#> [23] "REF*D9*7349065492"                                               
#> [24] "HI*ABK:F1020*ABF:F1220"                                          
#> [25] "NM1*82*1*PROVIDER*SUSAN****XX*1112223346"                        
#> [26] "PRV*PE*PXC*261QR0405X"                                           
#> [27] "NM1*77*2*BH CLINIC OF VANCOUVER*****XX*1122334455"               
#> [28] "N3*12345 MAIN ST SUITE A1"                                       
#> [29] "N4*VANCOUVER*WA*98662"                                           
#> [30] "LX*1"                                                            
#> [31] "SV1*HC:T1017:HF*11.64*UN*1***1:2"                                
#> [32] "DTP*472*D8*20180427"                                             
#> [33] "REF*6R*140976"                                                   
#> [34] "SE*34*000000003"                                                 
#> 
#> $sample_837_0$TRANSACTIONS[[4]]
#>  [1] "ST*837*000000004*005010X222A1"                                   
#>  [2] "BHT*0019*00*7349063984*20180508*0833*CH"                         
#>  [3] "NM1*41*2*CLEARINGHOUSE LLC*****46*987654321"                     
#>  [4] "PER*IC*CLEARINGHOUSE CLIENT SERVICES*TE*5555550000*FX*5555550000"
#>  [5] "NM1*40*2*123456789*****46*CHPWA"                                 
#>  [6] "HL*75**20*1"                                                     
#>  [7] "NM1*85*2*BH CLINIC OF VANCOUVER*****XX*1122334455"               
#>  [8] "N3*12345 MAIN ST"                                                
#>  [9] "N4*VANCOUVER*WA*98662"                                           
#> [10] "REF*EI*720000000"                                                
#> [11] "PER*IC*CONTACT*TE*5555550000"                                    
#> [12] "NM1*87*2"                                                        
#> [13] "N3*PO BOX 1234"                                                  
#> [14] "N4*VANCOUVER*WA*986681234"                                       
#> [15] "HL*76*75*22*0"                                                   
#> [16] "SBR*P*18**COMMUNITY HLTH PLAN OF WASH*****CI"                    
#> [17] "NM1*IL*1*PATIENT*SUSAN*E***MI*765123"                            
#> [18] "N3*123 TEST STREET"                                              
#> [19] "N4*TESTCITY*CA*00000"                                            
#> [20] "DMG*D8*19000101*F"                                               
#> [21] "NM1*PR*2*COMMUNITY HEALTH PLAN OF WASHINGTON*****PI*CHPWA"       
#> [22] "CLM*1805080AV3648353*234***53:B:1*Y*A*Y*Y"                       
#> [23] "REF*D9*7349064290"                                               
#> [24] "HI*ABK:F251"                                                     
#> [25] "NM1*82*1*PROVIDER*SUSAN****XX*1112223346"                        
#> [26] "PRV*PE*PXC*251S00000X"                                           
#> [27] "NM1*77*2*BH CLINIC OF VANCOUVER*****XX*1122334455"               
#> [28] "N3*12345 MAIN ST SUITE A1"                                       
#> [29] "N4*VANCOUVER*WA*98662"                                           
#> [30] "LX*1"                                                            
#> [31] "SV1*HC:90853*234*UN*120***1"                                     
#> [32] "DTP*472*D8*20180427"                                             
#> [33] "REF*6R*140787"                                                   
#> [34] "NTE*ADD*05"                                                      
#> [35] "SE*35*000000004"                                                 
#> 
#> $sample_837_0$TRANSACTIONS[[5]]
#>  [1] "ST*837*000000005*005010X222A1"                                   
#>  [2] "BHT*0019*00*7349063984*20180508*0833*CH"                         
#>  [3] "NM1*41*2*CLEARINGHOUSE LLC*****46*987654321"                     
#>  [4] "PER*IC*CLEARINGHOUSE CLIENT SERVICES*TE*5555550000*FX*5555550000"
#>  [5] "NM1*40*2*123456789*****46*CHPWA"                                 
#>  [6] "HL*79**20*1"                                                     
#>  [7] "NM1*85*2*BH CLINIC OF VANCOUVER*****XX*1122334455"               
#>  [8] "N3*12345 MAIN ST"                                                
#>  [9] "N4*VANCOUVER*WA*98662"                                           
#> [10] "REF*EI*720000000"                                                
#> [11] "PER*IC*CONTACT*TE*5555550000"                                    
#> [12] "NM1*87*2"                                                        
#> [13] "N3*PO BOX 1234"                                                  
#> [14] "N4*VANCOUVER*WA*986681234"                                       
#> [15] "HL*80*79*22*0"                                                   
#> [16] "SBR*P*18**COMMUNITY HLTH PLAN OF WASH*****CI"                    
#> [17] "NM1*IL*1*SUBSCRIBER*JOHN*J***MI*987321"                          
#> [18] "N3*123 TEST STREET"                                              
#> [19] "N4*TESTCITY*CA*00000"                                            
#> [20] "DMG*D8*19000101*M"                                               
#> [21] "NM1*PR*2*COMMUNITY HEALTH PLAN OF WASHINGTON*****PI*CHPWA"       
#> [22] "CLM*1805080AV3648355*20***57:B:1*Y*A*Y*Y"                        
#> [23] "REF*D9*7349064036"                                               
#> [24] "HI*ABK:F1020*ABF:F1120"                                          
#> [25] "NM1*82*1*PROVIDER*JAMES****XX*1112223338"                        
#> [26] "PRV*PE*PXC*261QR0405X"                                           
#> [27] "NM1*77*2*BH CLINIC OF VANCOUVER*****XX*1122334455"               
#> [28] "N3*12345 MAIN ST SUITE A1"                                       
#> [29] "N4*VANCOUVER*WA*98662"                                           
#> [30] "LX*1"                                                            
#> [31] "SV1*HC:H0003*20*UN*1***1:2"                                      
#> [32] "DTP*472*D8*20180427"                                             
#> [33] "REF*6R*143907"                                                   
#> [34] "SE*34*000000005"                                                 
#> 
#> 
#> $sample_837_0$TRAILER
#>   SEG PT     VALUE
#> 1  GE 01         5
#> 2  GE 02 212950697
#> 3 IEA 01         1
#> 4 IEA 02 697773230
#> 
#> 
#> $sample_837_1
#> $sample_837_1$HEADER
#>    SEG PT           VALUE
#> 1  ISA 01              00
#> 2  ISA 02            <NA>
#> 3  ISA 03              00
#> 4  ISA 04            <NA>
#> 5  ISA 05              ZZ
#> 6  ISA 06 589155000448185
#> 7  ISA 07              ZZ
#> 8  ISA 08 RegenceBluePoin
#> 9  ISA 09          241205
#> 10 ISA 10            2042
#> 11 ISA 11               U
#> 12 ISA 12           00401
#> 13 ISA 13       566609694
#> 14 ISA 14               0
#> 15 ISA 15               P
#> 16 ISA 16               :
#> 17  GS 01              HC
#> 18  GS 02 589155000448185
#> 19  GS 03 RegenceBluePoin
#> 20  GS 04        20241205
#> 21  GS 05            2042
#> 22  GS 06               1
#> 23  GS 07               X
#> 24  GS 08    005010X223A2
#> 
#> $sample_837_1$TRANSACTIONS
#> $sample_837_1$TRANSACTIONS[[1]]
#>  [1] "ST*837*0105*005010X223A2"                                                         
#>  [2] "BHT*0019*00*241205204217*20241205*2042*CH"                                        
#>  [3] "NM1*41*2*NATIONAL BIRTH CENTERS INC*****XX*1578387320"                            
#>  [4] "PER*IC*TEST CONTACT*TE*5555550000"                                                
#>  [5] "NM1*40*2*RegenceBluePointGoldHSAwithSpinalManipulationVisionEAP*****XX*22013UT245"
#>  [6] "PER*IC*TEST CONTACT*TE*5555550000"                                                
#>  [7] "HL*1**20*1"                                                                       
#>  [8] "NM1*85*2*NATIONAL BIRTH CENTERS INC*****XX*1578387320"                            
#>  [9] "N3*1141 N LOOP 1604 E # 105436"                                                   
#> [10] "N4*SAN ANTONIO*TX*78232"                                                          
#> [11] "REF*EI*46-4072679"                                                                
#> [12] "PER*IC*TEST CONTACT*TE*5555550000"                                                
#> [13] "HL*2*1*22*0"                                                                      
#> [14] "SBR*P*18*068094280******CI"                                                       
#> [15] "NM1*IL*1*TESTLAST01*TESTFIRST01****MI*TESTMBR000000001"                           
#> [16] "N3*123 TEST STREET"                                                               
#> [17] "N4*TESTCITY*CA*00000"                                                             
#> [18] "CLM*4742333269*297***11:B:1*Y*A*Y*I"                                              
#> [19] "DTP*434*RD8*20240422-20240430"                                                    
#> [20] "DTP*435*D8*20240809"                                                              
#> [21] "DTP*096*TM*2337"                                                                  
#> [22] "HI*ABK:S00459S"                                                                   
#> [23] "HI*ABK:T426X6A"                                                                   
#> [24] "HI*ABK:S35496D"                                                                   
#> [25] "HI*ABK:O368913"                                                                   
#> [26] "HI*ABK:T368X6A"                                                                   
#> [27] "HI*ABK:S36118D"                                                                   
#> [28] "HI*ABK:S46229A"                                                                   
#> [29] "LX*1"                                                                             
#> [30] "SV1*HC:33222*62*UN*1***6:2:7:4***"                                                
#> [31] "DTP*472*D8*20180428"                                                              
#> [32] "REF*6R*142671"                                                                    
#> [33] "LX*2"                                                                             
#> [34] "SV1*HC:27005*80*UN*1***7:1***"                                                    
#> [35] "DTP*472*D8*20180428"                                                              
#> [36] "REF*6R*142671"                                                                    
#> [37] "LX*3"                                                                             
#> [38] "SV1*HC:65860*65*UN*1***7***"                                                      
#> [39] "DTP*472*D8*20180428"                                                              
#> [40] "REF*6R*142671"                                                                    
#> [41] "LX*4"                                                                             
#> [42] "SV1*HC:75891*90*UN*1***4***"                                                      
#> [43] "DTP*472*D8*20180428"                                                              
#> [44] "REF*6R*142671"                                                                    
#> [45] "SE*45*0105"                                                                       
#> 
#> 
#> $sample_837_1$TRAILER
#>   SEG PT     VALUE
#> 1  GE 01         1
#> 2  GE 02         1
#> 3 IEA 01         1
#> 4 IEA 02 566609694
#> 
#> 
#> $sample_837_2
#> $sample_837_2$HEADER
#>    SEG PT           VALUE
#> 1  ISA 01              00
#> 2  ISA 02            <NA>
#> 3  ISA 03              00
#> 4  ISA 04            <NA>
#> 5  ISA 05              ZZ
#> 6  ISA 06 961285082616691
#> 7  ISA 07              ZZ
#> 8  ISA 08 AntidoteGoldSaf
#> 9  ISA 09          241205
#> 10 ISA 10            2042
#> 11 ISA 11               U
#> 12 ISA 12           00401
#> 13 ISA 13       030077084
#> 14 ISA 14               0
#> 15 ISA 15               P
#> 16 ISA 16               :
#> 17  GS 01              HC
#> 18  GS 02 961285082616691
#> 19  GS 03 AntidoteGoldSaf
#> 20  GS 04        20241205
#> 21  GS 05            2042
#> 22  GS 06               1
#> 23  GS 07               X
#> 24  GS 08    005010X223A2
#> 
#> $sample_837_2$TRANSACTIONS
#> $sample_837_2$TRANSACTIONS[[1]]
#>  [1] "ST*837*1462077*005010X223A2"                           
#>  [2] "BHT*0019*00*241205204218*20241205*2042*CH"             
#>  [3] "NM1*41*2*COMMUNITY BIRTH GROUP*****XX*1942024799"      
#>  [4] "PER*IC*TEST CONTACT*TE*5555550000"                     
#>  [5] "NM1*40*2*AntidoteGoldSafeGuard0TopRx*****XX*68445DE003"
#>  [6] "PER*IC*TEST CONTACT*TE*5555550000"                     
#>  [7] "HL*1**20*1"                                            
#>  [8] "NM1*85*2*COMMUNITY BIRTH GROUP*****XX*1942024799"      
#>  [9] "N3*216 TOWER RD"                                       
#> [10] "N4*SAN ANTONIO*TX*78223"                               
#> [11] "REF*EI*98-2541777"                                     
#> [12] "PER*IC*TEST CONTACT*TE*5555550000"                     
#> [13] "HL*2*1*22*0"                                           
#> [14] "SBR*P*18*404250129******CI"                            
#> [15] "NM1*IL*1*TESTLAST01*TESTFIRST01****MI*TESTMBR000000001"
#> [16] "N3*123 TEST STREET"                                    
#> [17] "N4*TESTCITY*CA*00000"                                  
#> [18] "CLM*4742333269*180***11:B:1*Y*A*Y*I"                   
#> [19] "DTP*434*RD8*20240422-20240430"                         
#> [20] "DTP*435*D8*20240809"                                   
#> [21] "DTP*096*TM*2337"                                       
#> [22] "HI*ABK:S43396S"                                        
#> [23] "HI*ABK:S52263J"                                        
#> [24] "HI*ABK:V0009XD"                                        
#> [25] "LX*1"                                                  
#> [26] "SV1*HC:77522*27*UN*1***3:1***"                         
#> [27] "DTP*472*D8*20180428"                                   
#> [28] "REF*6R*142671"                                         
#> [29] "LX*2"                                                  
#> [30] "SV1*HC:86304*3*UN*1***3:2***"                          
#> [31] "DTP*472*D8*20180428"                                   
#> [32] "REF*6R*142671"                                         
#> [33] "LX*3"                                                  
#> [34] "SV1*HC:43848*150*UN*1***3***"                          
#> [35] "DTP*472*D8*20180428"                                   
#> [36] "REF*6R*142671"                                         
#> [37] "SE*37*1462077"                                         
#> 
#> 
#> $sample_837_2$TRAILER
#>   SEG PT     VALUE
#> 1  GE 01         1
#> 2  GE 02         1
#> 3 IEA 01         1
#> 4 IEA 02 030077084
#> 
#> 
#> $sample_837_3
#> $sample_837_3$HEADER
#>    SEG PT           VALUE
#> 1  ISA 01              00
#> 2  ISA 02            <NA>
#> 3  ISA 03              00
#> 4  ISA 04            <NA>
#> 5  ISA 05              ZZ
#> 6  ISA 06 657631015478465
#> 7  ISA 07              ZZ
#> 8  ISA 08 MOLINAHEALTHCAR
#> 9  ISA 09          241205
#> 10 ISA 10            2042
#> 11 ISA 11               U
#> 12 ISA 12           00401
#> 13 ISA 13       828442319
#> 14 ISA 14               0
#> 15 ISA 15               P
#> 16 ISA 16               :
#> 17  GS 01              HC
#> 18  GS 02 657631015478465
#> 19  GS 03 MOLINAHEALTHCAR
#> 20  GS 04        20241205
#> 21  GS 05            2042
#> 22  GS 06               1
#> 23  GS 07               X
#> 24  GS 08    005010X223A2
#> 
#> $sample_837_3$TRANSACTIONS
#> $sample_837_3$TRANSACTIONS[[1]]
#>  [1] "ST*837*93687*005010X223A2"                             
#>  [2] "BHT*0019*00*241205204218*20241205*2042*CH"             
#>  [3] "NM1*41*2*MARYVIEW HOSPITAL LLC*****XX*1316313414"      
#>  [4] "PER*IC*TEST CONTACT*TE*5555550000"                     
#>  [5] "NM1*40*2*MOLINAHEALTHCARE*****XX*64353OH001"           
#>  [6] "PER*IC*TEST CONTACT*TE*5555550000"                     
#>  [7] "HL*1**20*1"                                            
#>  [8] "NM1*85*2*MARYVIEW HOSPITAL LLC*****XX*1316313414"      
#>  [9] "N3*8580 MAGELLAN PKWY"                                 
#> [10] "N4*RICHMOND*VA*23227"                                  
#> [11] "REF*EI*40-3601447"                                     
#> [12] "PER*IC*TEST CONTACT*TE*5555550000"                     
#> [13] "HL*2*1*22*0"                                           
#> [14] "SBR*P*18*520458393******CI"                            
#> [15] "NM1*IL*1*TESTLAST01*TESTFIRST01****MI*TESTMBR000000001"
#> [16] "N3*123 TEST STREET"                                    
#> [17] "N4*TESTCITY*CA*00000"                                  
#> [18] "CLM*4742333269*626***11:B:1*Y*A*Y*I"                   
#> [19] "DTP*434*RD8*20240422-20240430"                         
#> [20] "DTP*435*D8*20240809"                                   
#> [21] "DTP*096*TM*2337"                                       
#> [22] "HI*ABK:S25412A"                                        
#> [23] "HI*ABK:S55209S"                                        
#> [24] "HI*ABK:H05033"                                         
#> [25] "HI*ABK:M61529"                                         
#> [26] "HI*ABK:S12500S"                                        
#> [27] "HI*ABK:S62661G"                                        
#> [28] "LX*1"                                                  
#> [29] "SV1*HC:32662*83*UN*1***1:3:2:5***"                     
#> [30] "DTP*472*D8*20180428"                                   
#> [31] "REF*6R*142671"                                         
#> [32] "LX*2"                                                  
#> [33] "SV1*HC:42509*543*UN*1***6***"                          
#> [34] "DTP*472*D8*20180428"                                   
#> [35] "REF*6R*142671"                                         
#> [36] "SE*36*93687"                                           
#> 
#> 
#> $sample_837_3$TRAILER
#>   SEG PT     VALUE
#> 1  GE 01         1
#> 2  GE 02         1
#> 3 IEA 01         1
#> 4 IEA 02 828442319
#> 
#> 
#> $sample_837_4
#> $sample_837_4$HEADER
#>    SEG PT           VALUE
#> 1  ISA 01              00
#> 2  ISA 02            <NA>
#> 3  ISA 03              00
#> 4  ISA 04            <NA>
#> 5  ISA 05              ZZ
#> 6  ISA 06 816055286149740
#> 7  ISA 07              ZZ
#> 8  ISA 08 HighDeductibleH
#> 9  ISA 09          241205
#> 10 ISA 10            2042
#> 11 ISA 11               U
#> 12 ISA 12           00401
#> 13 ISA 13       621402678
#> 14 ISA 14               0
#> 15 ISA 15               P
#> 16 ISA 16               :
#> 17  GS 01              HC
#> 18  GS 02 816055286149740
#> 19  GS 03 HighDeductibleH
#> 20  GS 04        20241205
#> 21  GS 05            2042
#> 22  GS 06               1
#> 23  GS 07               X
#> 24  GS 08    005010X223A2
#> 
#> $sample_837_4$TRANSACTIONS
#> $sample_837_4$TRANSACTIONS[[1]]
#>  [1] "ST*837*91529*005010X223A2"                               
#>  [2] "BHT*0019*00*241205204219*20241205*2042*CH"               
#>  [3] "NM1*41*2*HSA ST. JOSEPH, LLC*****XX*1639992514"          
#>  [4] "PER*IC*TEST CONTACT*TE*5555550000"                       
#>  [5] "NM1*40*2*HighDeductibleHealthPlanHSA30*****XX*44197WI008"
#>  [6] "PER*IC*TEST CONTACT*TE*5555550000"                       
#>  [7] "HL*1**20*1"                                              
#>  [8] "NM1*85*2*HSA ST. JOSEPH, LLC*****XX*1639992514"          
#>  [9] "N3*505 N BRAND BLVD STE 1200"                            
#> [10] "N4*GLENDALE*CA*91203"                                    
#> [11] "REF*EI*38-4035437"                                       
#> [12] "PER*IC*TEST CONTACT*TE*5555550000"                       
#> [13] "HL*2*1*22*0"                                             
#> [14] "SBR*P*18*812162750******CI"                              
#> [15] "NM1*IL*1*TESTLAST01*TESTFIRST01****MI*TESTMBR000000001"  
#> [16] "N3*123 TEST STREET"                                      
#> [17] "N4*TESTCITY*CA*00000"                                    
#> [18] "CLM*4742333269*836***11:B:1*Y*A*Y*I"                     
#> [19] "DTP*434*RD8*20240422-20240430"                           
#> [20] "DTP*435*D8*20240809"                                     
#> [21] "DTP*096*TM*2337"                                         
#> [22] "HI*ABK:S42453G"                                          
#> [23] "HI*ABK:M25775"                                           
#> [24] "HI*ABK:S32421K"                                          
#> [25] "HI*ABK:V275XXD"                                          
#> [26] "HI*ABK:X130XXS"                                          
#> [27] "HI*ABK:T1512XD"                                          
#> [28] "HI*ABK:M70859"                                           
#> [29] "HI*ABK:S82454S"                                          
#> [30] "LX*1"                                                    
#> [31] "SV1*HC:64823*836*UN*1***6:3***"                          
#> [32] "DTP*472*D8*20180428"                                     
#> [33] "REF*6R*142671"                                           
#> [34] "SE*34*91529"                                             
#> 
#> 
#> $sample_837_4$TRAILER
#>   SEG PT     VALUE
#> 1  GE 01         1
#> 2  GE 02         1
#> 3 IEA 01         1
#> 4 IEA 02 621402678
#> 
#> 
#> $sample_837_5
#> $sample_837_5$HEADER
#>    SEG PT           VALUE
#> 1  ISA 01              00
#> 2  ISA 02            <NA>
#> 3  ISA 03              00
#> 4  ISA 04            <NA>
#> 5  ISA 05              ZZ
#> 6  ISA 06 051153619573476
#> 7  ISA 07              ZZ
#> 8  ISA 08 BlanketStudentA
#> 9  ISA 09          241205
#> 10 ISA 10            2042
#> 11 ISA 11               U
#> 12 ISA 12           00401
#> 13 ISA 13       518159636
#> 14 ISA 14               0
#> 15 ISA 15               P
#> 16 ISA 16               :
#> 17  GS 01              HC
#> 18  GS 02 051153619573476
#> 19  GS 03 BlanketStudentA
#> 20  GS 04        20241205
#> 21  GS 05            2042
#> 22  GS 06               1
#> 23  GS 07               X
#> 24  GS 08    005010X223A2
#> 
#> $sample_837_5$TRANSACTIONS
#> $sample_837_5$TRANSACTIONS[[1]]
#>  [1] "ST*837*46086*005010X223A2"                                                
#>  [2] "BHT*0019*00*241205204219*20241205*2042*CH"                                
#>  [3] "NM1*41*2*NATIONAL BIRTH CENTERS INC*****XX*1578387320"                    
#>  [4] "PER*IC*TEST CONTACT*TE*5555550000"                                        
#>  [5] "NM1*40*2*BlanketStudentAccidentandSicknessUnivofWYPlan1*****XX*49714WY010"
#>  [6] "PER*IC*TEST CONTACT*TE*5555550000"                                        
#>  [7] "HL*1**20*1"                                                               
#>  [8] "NM1*85*2*NATIONAL BIRTH CENTERS INC*****XX*1578387320"                    
#>  [9] "N3*1141 N LOOP 1604 E # 105436"                                           
#> [10] "N4*SAN ANTONIO*TX*78232"                                                  
#> [11] "REF*EI*58-1127151"                                                        
#> [12] "PER*IC*TEST CONTACT*TE*5555550000"                                        
#> [13] "HL*2*1*22*0"                                                              
#> [14] "SBR*P*18*518691181******CI"                                               
#> [15] "NM1*IL*1*TESTLAST01*TESTFIRST01****MI*TESTMBR000000001"                   
#> [16] "N3*123 TEST STREET"                                                       
#> [17] "N4*TESTCITY*CA*00000"                                                     
#> [18] "CLM*4742333269*157***11:B:1*Y*A*Y*I"                                      
#> [19] "DTP*434*RD8*20240422-20240430"                                            
#> [20] "DTP*435*D8*20240809"                                                      
#> [21] "DTP*096*TM*2337"                                                          
#> [22] "HI*ABK:S89219K"                                                           
#> [23] "HI*ABK:S50349S"                                                           
#> [24] "HI*ABK:S81052D"                                                           
#> [25] "HI*ABK:D434"                                                              
#> [26] "HI*ABK:S00451A"                                                           
#> [27] "HI*ABK:T81505D"                                                           
#> [28] "LX*1"                                                                     
#> [29] "SV1*HC:0029T*97*UN*1***1:3:6***"                                          
#> [30] "DTP*472*D8*20180428"                                                      
#> [31] "REF*6R*142671"                                                            
#> [32] "LX*2"                                                                     
#> [33] "SV1*HC:86490*6*UN*1***3:4:6:1:5***"                                       
#> [34] "DTP*472*D8*20180428"                                                      
#> [35] "REF*6R*142671"                                                            
#> [36] "LX*3"                                                                     
#> [37] "SV1*HC:57545*21*UN*1***2:3***"                                            
#> [38] "DTP*472*D8*20180428"                                                      
#> [39] "REF*6R*142671"                                                            
#> [40] "LX*4"                                                                     
#> [41] "SV1*HC:62258*33*UN*1***6***"                                              
#> [42] "DTP*472*D8*20180428"                                                      
#> [43] "REF*6R*142671"                                                            
#> [44] "SE*44*46086"                                                              
#> 
#> 
#> $sample_837_5$TRAILER
#>   SEG PT     VALUE
#> 1  GE 01         1
#> 2  GE 02         1
#> 3 IEA 01         1
#> 4 IEA 02 518159636
#> 
#> 
#> $sample_837_6
#> $sample_837_6$HEADER
#>    SEG PT           VALUE
#> 1  ISA 01              00
#> 2  ISA 02            <NA>
#> 3  ISA 03              00
#> 4  ISA 04            <NA>
#> 5  ISA 05              ZZ
#> 6  ISA 06 336342583485277
#> 7  ISA 07              ZZ
#> 8  ISA 08 EHB2015IPLAELIC
#> 9  ISA 09          241205
#> 10 ISA 10            2042
#> 11 ISA 11               U
#> 12 ISA 12           00401
#> 13 ISA 13       115983591
#> 14 ISA 14               0
#> 15 ISA 15               P
#> 16 ISA 16               :
#> 17  GS 01              HC
#> 18  GS 02 336342583485277
#> 19  GS 03 EHB2015IPLAELIC
#> 20  GS 04        20241205
#> 21  GS 05            2042
#> 22  GS 06               1
#> 23  GS 07               X
#> 24  GS 08    005010X223A2
#> 
#> $sample_837_6$TRANSACTIONS
#> $sample_837_6$TRANSACTIONS[[1]]
#>  [1] "ST*837*76134698*005010X223A2"                          
#>  [2] "BHT*0019*00*241205204220*20241205*2042*CH"             
#>  [3] "NM1*41*2*OKEECHOBEE HOSPITAL, INC.*****XX*1215974134"  
#>  [4] "PER*IC*TEST CONTACT*TE*5555550000"                     
#>  [5] "NM1*40*2*EHB2015IPLAELIC*****XX*85570LA014"            
#>  [6] "PER*IC*TEST CONTACT*TE*5555550000"                     
#>  [7] "HL*1**20*1"                                            
#>  [8] "NM1*85*2*OKEECHOBEE HOSPITAL, INC.*****XX*1215974134"  
#>  [9] "N3*PO BOX 1307"                                        
#> [10] "N4*OKEECHOBEE*FL*34973"                                
#> [11] "REF*EI*47-2705172"                                     
#> [12] "PER*IC*TEST CONTACT*TE*5555550000"                     
#> [13] "HL*2*1*22*0"                                           
#> [14] "SBR*P*18*768417323******CI"                            
#> [15] "NM1*IL*1*TESTLAST01*TESTFIRST01****MI*TESTMBR000000001"
#> [16] "N3*123 TEST STREET"                                    
#> [17] "N4*TESTCITY*CA*00000"                                  
#> [18] "CLM*4742333269*766***11:B:1*Y*A*Y*I"                   
#> [19] "DTP*434*RD8*20240422-20240430"                         
#> [20] "DTP*435*D8*20240809"                                   
#> [21] "DTP*096*TM*2337"                                       
#> [22] "HI*ABK:F551"                                           
#> [23] "HI*ABK:S43201D"                                        
#> [24] "HI*ABK:T6194XA"                                        
#> [25] "HI*ABK:S92505K"                                        
#> [26] "HI*ABK:T280XXS"                                        
#> [27] "HI*ABK:S71011D"                                        
#> [28] "LX*1"                                                  
#> [29] "SV1*HC:27606*61*UN*1***5:1:4:3:6:2***"                 
#> [30] "DTP*472*D8*20180428"                                   
#> [31] "REF*6R*142671"                                         
#> [32] "LX*2"                                                  
#> [33] "SV1*HC:44960*371*UN*1***6***"                          
#> [34] "DTP*472*D8*20180428"                                   
#> [35] "REF*6R*142671"                                         
#> [36] "LX*3"                                                  
#> [37] "SV1*HC:90680*34*UN*1***3***"                           
#> [38] "DTP*472*D8*20180428"                                   
#> [39] "REF*6R*142671"                                         
#> [40] "LX*4"                                                  
#> [41] "SV1*HC:92551*267*UN*1***3***"                          
#> [42] "DTP*472*D8*20180428"                                   
#> [43] "REF*6R*142671"                                         
#> [44] "LX*5"                                                  
#> [45] "SV1*HC:31237*33*UN*1***4:1***"                         
#> [46] "DTP*472*D8*20180428"                                   
#> [47] "REF*6R*142671"                                         
#> [48] "SE*48*76134698"                                        
#> 
#> 
#> $sample_837_6$TRAILER
#>   SEG PT     VALUE
#> 1  GE 01         1
#> 2  GE 02         1
#> 3 IEA 01         1
#> 4 IEA 02 115983591
#> 
#> 
#> $sample_837_7
#> $sample_837_7$HEADER
#>    SEG PT           VALUE
#> 1  ISA 01              00
#> 2  ISA 02            <NA>
#> 3  ISA 03              00
#> 4  ISA 04            <NA>
#> 5  ISA 05              ZZ
#> 6  ISA 06 879679616399691
#> 7  ISA 07              ZZ
#> 8  ISA 08 HSA2000_10A1189
#> 9  ISA 09          241205
#> 10 ISA 10            2042
#> 11 ISA 11               U
#> 12 ISA 12           00401
#> 13 ISA 13       871936722
#> 14 ISA 14               0
#> 15 ISA 15               P
#> 16 ISA 16               :
#> 17  GS 01              HC
#> 18  GS 02 879679616399691
#> 19  GS 03 HSA2000_10A1189
#> 20  GS 04        20241205
#> 21  GS 05            2042
#> 22  GS 06               1
#> 23  GS 07               X
#> 24  GS 08    005010X223A2
#> 
#> $sample_837_7$TRANSACTIONS
#> $sample_837_7$TRANSACTIONS[[1]]
#>  [1] "ST*837*7869171*005010X223A2"                           
#>  [2] "BHT*0019*00*241205204220*20241205*2042*CH"             
#>  [3] "NM1*41*2*ELMHURST MEMORIAL HOSPITAL*****XX*1548306343" 
#>  [4] "PER*IC*TEST CONTACT*TE*5555550000"                     
#>  [5] "NM1*40*2*HSA2000_10A1*****XX*39424OR071"               
#>  [6] "PER*IC*TEST CONTACT*TE*5555550000"                     
#>  [7] "HL*1**20*1"                                            
#>  [8] "NM1*85*2*ELMHURST MEMORIAL HOSPITAL*****XX*1548306343" 
#>  [9] "N3*155 E BRUSH HILL RD"                                
#> [10] "N4*ELMHURST*IL*60126"                                  
#> [11] "REF*EI*78-1631771"                                     
#> [12] "PER*IC*TEST CONTACT*TE*5555550000"                     
#> [13] "HL*2*1*22*0"                                           
#> [14] "SBR*P*18*270183084******CI"                            
#> [15] "NM1*IL*1*TESTLAST01*TESTFIRST01****MI*TESTMBR000000001"
#> [16] "N3*123 TEST STREET"                                    
#> [17] "N4*TESTCITY*CA*00000"                                  
#> [18] "CLM*4742333269*349***11:B:1*Y*A*Y*I"                   
#> [19] "DTP*434*RD8*20240422-20240430"                         
#> [20] "DTP*435*D8*20240809"                                   
#> [21] "DTP*096*TM*2337"                                       
#> [22] "HI*ABK:S00249D"                                        
#> [23] "HI*ABK:S99131K"                                        
#> [24] "HI*ABK:S32425K"                                        
#> [25] "HI*ABK:S52501J"                                        
#> [26] "HI*ABK:S72114P"                                        
#> [27] "LX*1"                                                  
#> [28] "SV1*HC:38724*36*UN*1***1:3:5:2:4***"                   
#> [29] "DTP*472*D8*20180428"                                   
#> [30] "REF*6R*142671"                                         
#> [31] "LX*2"                                                  
#> [32] "SV1*HC:86701*213*UN*1***5:4***"                        
#> [33] "DTP*472*D8*20180428"                                   
#> [34] "REF*6R*142671"                                         
#> [35] "LX*3"                                                  
#> [36] "SV1*HC:92325*70*UN*1***3:2:4***"                       
#> [37] "DTP*472*D8*20180428"                                   
#> [38] "REF*6R*142671"                                         
#> [39] "LX*4"                                                  
#> [40] "SV1*HC:89060*30*UN*1***3:4:5***"                       
#> [41] "DTP*472*D8*20180428"                                   
#> [42] "REF*6R*142671"                                         
#> [43] "SE*43*7869171"                                         
#> 
#> 
#> $sample_837_7$TRAILER
#>   SEG PT     VALUE
#> 1  GE 01         1
#> 2  GE 02         1
#> 3 IEA 01         1
#> 4 IEA 02 871936722
#> 
#> 
#> $sample_837_8
#> $sample_837_8$HEADER
#>    SEG PT           VALUE
#> 1  ISA 01              00
#> 2  ISA 02            <NA>
#> 3  ISA 03              00
#> 4  ISA 04            <NA>
#> 5  ISA 05              ZZ
#> 6  ISA 06 719189088449132
#> 7  ISA 07              ZZ
#> 8  ISA 08 SimplyBluePPOwi
#> 9  ISA 09          241205
#> 10 ISA 10            2042
#> 11 ISA 11               U
#> 12 ISA 12           00401
#> 13 ISA 13       464860572
#> 14 ISA 14               0
#> 15 ISA 15               P
#> 16 ISA 16               :
#> 17  GS 01              HC
#> 18  GS 02 719189088449132
#> 19  GS 03 SimplyBluePPOwi
#> 20  GS 04        20241205
#> 21  GS 05            2042
#> 22  GS 06               1
#> 23  GS 07               X
#> 24  GS 08    005010X223A2
#> 
#> $sample_837_8$TRANSACTIONS
#> $sample_837_8$TRANSACTIONS[[1]]
#>  [1] "ST*837*57975326*005010X223A2"                                
#>  [2] "BHT*0019*00*241205204221*20241205*2042*CH"                   
#>  [3] "NM1*41*2*GUTHRIE CORTLAND MEDICAL CENTER*****XX*1740287531"  
#>  [4] "PER*IC*TEST CONTACT*TE*5555550000"                           
#>  [5] "NM1*40*2*SimplyBluePPOwithabortioncoverage*****XX*15560MI055"
#>  [6] "PER*IC*TEST CONTACT*TE*5555550000"                           
#>  [7] "HL*1**20*1"                                                  
#>  [8] "NM1*85*2*GUTHRIE CORTLAND MEDICAL CENTER*****XX*1740287531"  
#>  [9] "N3*PO BOX 2060"                                              
#> [10] "N4*CORTLAND*NY*13045"                                        
#> [11] "REF*EI*92-6992381"                                           
#> [12] "PER*IC*TEST CONTACT*TE*5555550000"                           
#> [13] "HL*2*1*22*0"                                                 
#> [14] "SBR*P*18*406068712******CI"                                  
#> [15] "NM1*IL*1*TESTLAST01*TESTFIRST01****MI*TESTMBR000000001"      
#> [16] "N3*123 TEST STREET"                                          
#> [17] "N4*TESTCITY*CA*00000"                                        
#> [18] "CLM*4742333269*434***11:B:1*Y*A*Y*I"                         
#> [19] "DTP*434*RD8*20240422-20240430"                               
#> [20] "DTP*435*D8*20240809"                                         
#> [21] "DTP*096*TM*2337"                                             
#> [22] "HI*ABK:S62511K"                                              
#> [23] "HI*ABK:T578X3S"                                              
#> [24] "HI*ABK:S72342G"                                              
#> [25] "LX*1"                                                        
#> [26] "SV1*HC:43280*41*UN*1***1:2***"                               
#> [27] "DTP*472*D8*20180428"                                         
#> [28] "REF*6R*142671"                                               
#> [29] "LX*2"                                                        
#> [30] "SV1*HC:46250*35*UN*1***2:3***"                               
#> [31] "DTP*472*D8*20180428"                                         
#> [32] "REF*6R*142671"                                               
#> [33] "LX*3"                                                        
#> [34] "SV1*HC:33305*197*UN*1***3:2***"                              
#> [35] "DTP*472*D8*20180428"                                         
#> [36] "REF*6R*142671"                                               
#> [37] "LX*4"                                                        
#> [38] "SV1*HC:90947*161*UN*1***1:3:2***"                            
#> [39] "DTP*472*D8*20180428"                                         
#> [40] "REF*6R*142671"                                               
#> [41] "SE*41*57975326"                                              
#> 
#> 
#> $sample_837_8$TRAILER
#>   SEG PT     VALUE
#> 1  GE 01         1
#> 2  GE 02         1
#> 3 IEA 01         1
#> 4 IEA 02 464860572
#> 
#> 
#> $sample_837_9
#> $sample_837_9$HEADER
#>    SEG PT           VALUE
#> 1  ISA 01              00
#> 2  ISA 02            <NA>
#> 3  ISA 03              00
#> 4  ISA 04            <NA>
#> 5  ISA 05              ZZ
#> 6  ISA 06 913673479406110
#> 7  ISA 07              ZZ
#> 8  ISA 08 HMOOffExchangeR
#> 9  ISA 09          241205
#> 10 ISA 10            2042
#> 11 ISA 11               U
#> 12 ISA 12           00401
#> 13 ISA 13       253034665
#> 14 ISA 14               0
#> 15 ISA 15               P
#> 16 ISA 16               :
#> 17  GS 01              HC
#> 18  GS 02 913673479406110
#> 19  GS 03 HMOOffExchangeR
#> 20  GS 04        20241205
#> 21  GS 05            2042
#> 22  GS 06               1
#> 23  GS 07               X
#> 24  GS 08    005010X223A2
#> 
#> $sample_837_9$TRANSACTIONS
#> $sample_837_9$TRANSACTIONS[[1]]
#>  [1] "ST*837*4763033*005010X223A2"                                      
#>  [2] "BHT*0019*00*241205204221*20241205*2042*CH"                        
#>  [3] "NM1*41*2*HCA HEALTH SERVICES OF TENNESSEE, INC.*****XX*1265487193"
#>  [4] "PER*IC*TEST CONTACT*TE*5555550000"                                
#>  [5] "NM1*40*2*HMOOffExchangeRegion7*****XX*84014CA002"                 
#>  [6] "PER*IC*TEST CONTACT*TE*5555550000"                                
#>  [7] "HL*1**20*1"                                                       
#>  [8] "NM1*85*2*HCA HEALTH SERVICES OF TENNESSEE, INC.*****XX*1265487193"
#>  [9] "N3*313 N MAIN ST"                                                 
#> [10] "N4*ASHLAND CITY*TN*37015"                                         
#> [11] "REF*EI*99-5971744"                                                
#> [12] "PER*IC*TEST CONTACT*TE*5555550000"                                
#> [13] "HL*2*1*22*0"                                                      
#> [14] "SBR*P*18*556791994******CI"                                       
#> [15] "NM1*IL*1*TESTLAST01*TESTFIRST01****MI*TESTMBR000000001"           
#> [16] "N3*123 TEST STREET"                                               
#> [17] "N4*TESTCITY*CA*00000"                                             
#> [18] "CLM*4742333269*839***11:B:1*Y*A*Y*I"                              
#> [19] "DTP*434*RD8*20240422-20240430"                                    
#> [20] "DTP*435*D8*20240809"                                              
#> [21] "DTP*096*TM*2337"                                                  
#> [22] "HI*ABK:V9421XS"                                                   
#> [23] "HI*ABK:S35292S"                                                   
#> [24] "HI*ABK:S52272S"                                                   
#> [25] "HI*ABK:H68022"                                                    
#> [26] "HI*ABK:T4144XD"                                                   
#> [27] "HI*ABK:H1030"                                                     
#> [28] "HI*ABK:S82832J"                                                   
#> [29] "HI*ABK:B340"                                                      
#> [30] "LX*1"                                                             
#> [31] "SV1*HC:35650*161*UN*1***7:3:4:5:8***"                             
#> [32] "DTP*472*D8*20180428"                                              
#> [33] "REF*6R*142671"                                                    
#> [34] "LX*2"                                                             
#> [35] "SV1*HC:73200*383*UN*1***5:2:7:4:3:6:8:1***"                       
#> [36] "DTP*472*D8*20180428"                                              
#> [37] "REF*6R*142671"                                                    
#> [38] "LX*3"                                                             
#> [39] "SV1*HC:28262*194*UN*1***7:1:8***"                                 
#> [40] "DTP*472*D8*20180428"                                              
#> [41] "REF*6R*142671"                                                    
#> [42] "LX*4"                                                             
#> [43] "SV1*HC:84480*101*UN*1***6:3:1:2***"                               
#> [44] "DTP*472*D8*20180428"                                              
#> [45] "REF*6R*142671"                                                    
#> [46] "SE*46*4763033"                                                    
#> 
#> 
#> $sample_837_9$TRAILER
#>   SEG PT     VALUE
#> 1  GE 01         1
#> 2  GE 02         1
#> 3 IEA 01         1
#> 4 IEA 02 253034665
#> 
#> 
```
