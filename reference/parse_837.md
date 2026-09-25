# X12-837I (X223A3) & X12-837P (X222A2) Health Care Claim Parser

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
parse_837(x)
```

## Arguments

- x:

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

- a single `SE`

## Examples

``` r
idx = purrr::map(c(hcc::x12_837I, hcc::x12_837P), index_x12)
purrr::map(idx, parse_837)
#> $`837I_EX1a_institutional_claim`
#> $`837I_EX1a_institutional_claim`$Header
#> $`837I_EX1a_institutional_claim`$Header$ISA
#> $`837I_EX1a_institutional_claim`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`837I_EX1a_institutional_claim`$Header$ISA$`02`
#> [1] NA
#> 
#> $`837I_EX1a_institutional_claim`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`837I_EX1a_institutional_claim`$Header$ISA$`04`
#> [1] NA
#> 
#> $`837I_EX1a_institutional_claim`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`837I_EX1a_institutional_claim`$Header$ISA$`06`
#> [1] "SENDER"
#> 
#> $`837I_EX1a_institutional_claim`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`837I_EX1a_institutional_claim`$Header$ISA$`08`
#> [1] "RECEIVER"
#> 
#> $`837I_EX1a_institutional_claim`$Header$ISA$`09`
#> [1] "231106"
#> 
#> $`837I_EX1a_institutional_claim`$Header$ISA$`10`
#> [1] "1408"
#> 
#> $`837I_EX1a_institutional_claim`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`837I_EX1a_institutional_claim`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`837I_EX1a_institutional_claim`$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $`837I_EX1a_institutional_claim`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`837I_EX1a_institutional_claim`$Header$ISA$`15`
#> [1] "T"
#> 
#> $`837I_EX1a_institutional_claim`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`837I_EX1a_institutional_claim`$Header$GS
#> $`837I_EX1a_institutional_claim`$Header$GS$`01`
#> [1] "HC"
#> 
#> $`837I_EX1a_institutional_claim`$Header$GS$`02`
#> [1] "SENDERGS"
#> 
#> $`837I_EX1a_institutional_claim`$Header$GS$`03`
#> [1] "RECEIVERGS"
#> 
#> $`837I_EX1a_institutional_claim`$Header$GS$`04`
#> [1] "20231106"
#> 
#> $`837I_EX1a_institutional_claim`$Header$GS$`05`
#> [1] "140822"
#> 
#> $`837I_EX1a_institutional_claim`$Header$GS$`06`
#> [1] "000000001"
#> 
#> $`837I_EX1a_institutional_claim`$Header$GS$`07`
#> [1] "X"
#> 
#> $`837I_EX1a_institutional_claim`$Header$GS$`08`
#> [1] "005010X223A2"
#> 
#> 
#> 
#> $`837I_EX1a_institutional_claim`$Transactions
#> $`837I_EX1a_institutional_claim`$Transactions[[1]]
#>  [1] "ST*837*987654*005010X223A2"                                                
#>  [2] "BHT*0019*00*0123*19960918*0932*CH"                                         
#>  [3] "NM1*41*2*JONES HOSPITAL*****46*12345"                                      
#>  [4] "PER*IC*JANE DOE*TE*9005555555"                                             
#>  [5] "NM1*40*2*MEDICARE*****46*00120"                                            
#>  [6] "HL*1**20*1"                                                                
#>  [7] "PRV*BI*PXC*203BA0200N"                                                     
#>  [8] "NM1*85*2*JONES HOSPITAL*****XX*9876540809"                                 
#>  [9] "N3*225 MAIN STREET BARKLEY BUILDING"                                       
#> [10] "N4*CENTERVILLE*PA*17111"                                                   
#> [11] "REF*EI*567891234"                                                          
#> [12] "PER*IC*CONNIE*TE*3055551234"                                               
#> [13] "HL*2*1*22*0"                                                               
#> [14] "SBR*P*18*******MB"                                                         
#> [15] "NM1*IL*1*DOE*JOHN*T***MI*030005074A"                                       
#> [16] "N3*125 CITY AVENUE"                                                        
#> [17] "N4*CENTERVILLE*PA*17111"                                                   
#> [18] "DMG*D8*19261111*M"                                                         
#> [19] "NM1*PR*2*MEDICARE B*****PI*00435"                                          
#> [20] "REF*G2*330127"                                                             
#> [21] "CLM*756048Q*89.93***14>A>1**A*Y*Y"                                         
#> [22] "DTP*434*RD8*19960911"                                                      
#> [23] "CL1*3**01"                                                                 
#> [24] "HI*BK>3669"                                                                
#> [25] "HI*BF>4019*BF>79431"                                                       
#> [26] "HI*BH>A1>D8>19261111*BH>A2>D8>19911101*BH>B1>D8>19261111*BH>B2>D8>19870101"
#> [27] "HI*BE>A2>>>15.31"                                                          
#> [28] "HI*BG>09"                                                                  
#> [29] "NM1*71*1*JONES*JOHN*J"                                                     
#> [30] "REF*1G*B99937"                                                             
#> [31] "SBR*S*01*351630*STATE TEACHERS*****CI"                                     
#> [32] "OI***Y***Y"                                                                
#> [33] "NM1*IL*1*DOE*JANE*S***MI*222004433"                                        
#> [34] "N3*125 CITY AVENUE"                                                        
#> [35] "N4*CENTERVILLE*PA*17111"                                                   
#> [36] "NM1*PR*2*STATE TEACHERS*****PI*1135"                                       
#> [37] "LX*1"                                                                      
#> [38] "SV2*0305*HC>85025*13.39*UN*1"                                              
#> [39] "DTP*472*D8*19960911"                                                       
#> [40] "LX*2"                                                                      
#> [41] "SV2*0730*HC>93005*76.54*UN*3"                                              
#> [42] "DTP*472*D8*19960911"                                                       
#> 
#> 
#> $`837I_EX1a_institutional_claim`$Trailer
#> $`837I_EX1a_institutional_claim`$Trailer$SE
#> $`837I_EX1a_institutional_claim`$Trailer$SE$`01`
#> [1] "43"
#> 
#> $`837I_EX1a_institutional_claim`$Trailer$SE$`02`
#> [1] "987654"
#> 
#> 
#> $`837I_EX1a_institutional_claim`$Trailer$GE
#> $`837I_EX1a_institutional_claim`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`837I_EX1a_institutional_claim`$Trailer$GE$`02`
#> [1] "000000001"
#> 
#> 
#> $`837I_EX1a_institutional_claim`$Trailer$IEA
#> $`837I_EX1a_institutional_claim`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`837I_EX1a_institutional_claim`$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $`837I_EX1b_2claims_1provider`
#> $`837I_EX1b_2claims_1provider`$Header
#> $`837I_EX1b_2claims_1provider`$Header$ISA
#> $`837I_EX1b_2claims_1provider`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$ISA$`02`
#> [1] NA
#> 
#> $`837I_EX1b_2claims_1provider`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$ISA$`04`
#> [1] NA
#> 
#> $`837I_EX1b_2claims_1provider`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$ISA$`06`
#> [1] "SENDER"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$ISA$`08`
#> [1] "RECEIVER"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$ISA$`09`
#> [1] "231106"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$ISA$`10`
#> [1] "1410"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$ISA$`15`
#> [1] "T"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`837I_EX1b_2claims_1provider`$Header$GS
#> $`837I_EX1b_2claims_1provider`$Header$GS$`01`
#> [1] "HC"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$GS$`02`
#> [1] "SENDERGS"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$GS$`03`
#> [1] "RECEIVERGS"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$GS$`04`
#> [1] "20231106"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$GS$`05`
#> [1] "141054"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$GS$`06`
#> [1] "000000001"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$GS$`07`
#> [1] "X"
#> 
#> $`837I_EX1b_2claims_1provider`$Header$GS$`08`
#> [1] "005010X223A2"
#> 
#> 
#> 
#> $`837I_EX1b_2claims_1provider`$Transactions
#> $`837I_EX1b_2claims_1provider`$Transactions[[1]]
#>  [1] "ST*837*987654*005010X223A2"               
#>  [2] "BHT*0019*00*0123*20050630*0932*CH"        
#>  [3] "NM1*41*2*JONES HOSPITAL*****46*12345"     
#>  [4] "PER*IC*JANE DOE*TE*1112223333"            
#>  [5] "NM1*40*2*TRICARE*****46*99999"            
#>  [6] "HL*1**20*1"                               
#>  [7] "PRV*BI*PXC*282N00000X"                    
#>  [8] "NM1*85*2*JONES HOSPITAL*****XX*1234567890"
#>  [9] "N3*225 MAIN STREET"                       
#> [10] "N4*ANYWHERE*PA*17111"                     
#> [11] "REF*EI*123456789"                         
#> [12] "HL*2*1*22*0"                              
#> [13] "SBR*P*18*******CH"                        
#> [14] "NM1*IL*1*DOE*JOHN*T***MI*030005074"       
#> [15] "N3*125 CITY AVENUE"                       
#> [16] "N4*CENTERVILLE*PA*17111"                  
#> [17] "DMG*D8*19681111*M"                        
#> [18] "NM1*PR*2*TRICARE*****PI*99999"            
#> [19] "CLM*756048Q*89.95***13>A>1**C*Y*Y"        
#> [20] "DTP*434*RD8*20050315-20050315"            
#> [21] "CL1*1**01"                                
#> [22] "HI*BK>3669"                               
#> [23] "HI*BF>4019*BF>79431"                      
#> [24] "NM1*71*1*JONES*JOHN*J***XX*1122334455"    
#> [25] "REF*1G*U12345"                            
#> [26] "LX*1"                                     
#> [27] "SV2*0305*HC>85025*13.39*UN*1"             
#> [28] "DTP*472*D8*20050315"                      
#> [29] "LX*2"                                     
#> [30] "SV2*0730*HC>93010*76.56*UN*3"             
#> [31] "DTP*472*D8*20050315"                      
#> [32] "HL*3*1*22*0"                              
#> [33] "SBR*P*18*******CH"                        
#> [34] "NM1*IL*1*SMITH*JOE****MI*123405074"       
#> [35] "N3*5 MAIN STREET"                         
#> [36] "N4*ANYWHERE*PA*17111"                     
#> [37] "DMG*D8*19621210*M"                        
#> [38] "NM1*PR*2*TRICARE*****PI*99999"            
#> [39] "CLM*756049Q*50***13>A>1**C*Y*Y"           
#> [40] "DTP*434*RD8*20050401-20050401"            
#> [41] "CL1*1**01"                                
#> [42] "HI*BK>30000"                              
#> [43] "NM1*71*1*JONES*JUDY*J***XX*9999999999"    
#> [44] "PRV*AT*PXC*363LP0200N"                    
#> [45] "LX*1"                                     
#> [46] "SV2*0300*HC>85087*50*UN*1"                
#> [47] "DTP*472*D8*20050401"                      
#> 
#> 
#> $`837I_EX1b_2claims_1provider`$Trailer
#> $`837I_EX1b_2claims_1provider`$Trailer$SE
#> $`837I_EX1b_2claims_1provider`$Trailer$SE$`01`
#> [1] "48"
#> 
#> $`837I_EX1b_2claims_1provider`$Trailer$SE$`02`
#> [1] "987654"
#> 
#> 
#> $`837I_EX1b_2claims_1provider`$Trailer$GE
#> $`837I_EX1b_2claims_1provider`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`837I_EX1b_2claims_1provider`$Trailer$GE$`02`
#> [1] "000000001"
#> 
#> 
#> $`837I_EX1b_2claims_1provider`$Trailer$IEA
#> $`837I_EX1b_2claims_1provider`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`837I_EX1b_2claims_1provider`$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $`837I_EX1c_ppo_repriced_claim`
#> $`837I_EX1c_ppo_repriced_claim`$Header
#> $`837I_EX1c_ppo_repriced_claim`$Header$ISA
#> $`837I_EX1c_ppo_repriced_claim`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$ISA$`02`
#> [1] NA
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$ISA$`04`
#> [1] NA
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$ISA$`06`
#> [1] "SENDER"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$ISA$`08`
#> [1] "RECEIVER"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$ISA$`09`
#> [1] "231106"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$ISA$`10`
#> [1] "1415"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$ISA$`15`
#> [1] "T"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$GS
#> $`837I_EX1c_ppo_repriced_claim`$Header$GS$`01`
#> [1] "HC"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$GS$`02`
#> [1] "SENDERGS"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$GS$`03`
#> [1] "RECEIVERGS"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$GS$`04`
#> [1] "20231106"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$GS$`05`
#> [1] "141512"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$GS$`06`
#> [1] "000000001"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$GS$`07`
#> [1] "X"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Header$GS$`08`
#> [1] "005010X223A2"
#> 
#> 
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Transactions
#> $`837I_EX1c_ppo_repriced_claim`$Transactions[[1]]
#>  [1] "ST*837*1002*005010X223A2"                        
#>  [2] "BHT*0019*00*1002*20050721*09460000*CH"           
#>  [3] "NM1*41*2*REGIONAL PPO NETWORK*****46*123456789"  
#>  [4] "PER*IC*SUBMITTER CONTACT INFO*TE*8001231234"     
#>  [5] "NM1*40*2*LOCAL INSURANCE COMPANY*****46*54334452"
#>  [6] "HL*1**20*1"                                      
#>  [7] "NM1*85*2*GOOD HEALTH HOSPITAL*****XX*1257234346" 
#>  [8] "N3*592 NORTH ELM STREET"                         
#>  [9] "N4*EDGEWOOD*AZ*860015590"                        
#> [10] "REF*EI*344232321"                                
#> [11] "HL*2*1*22*1"                                     
#> [12] "SBR*P**46522567AW******CI"                       
#> [13] "NM1*IL*1*JONES*JENNY****MI*345U8423H"            
#> [14] "N3*4512 WEST AVENUE"                             
#> [15] "N4*EVANSVILLE*AZ*863030000"                      
#> [16] "DMG*D8*19690731*F"                               
#> [17] "NM1*PR*2*LOCAL INSURANCE COMPANY*****PI*7452723" 
#> [18] "HL*3*2*23*0"                                     
#> [19] "PAT*19"                                          
#> [20] "NM1*QC*1*JONES*JOY"                              
#> [21] "N3*4512 WEST AVENUE"                             
#> [22] "N4*EVANSVILLE*AZ*863030000"                      
#> [23] "DMG*D8*19980820*F"                               
#> [24] "CLM*456DFH43*237.5***13>A>1**A*Y*Y"              
#> [25] "DTP*434*RD8*20050706-20050706"                   
#> [26] "DTP*435*DT*200507060800"                         
#> [27] "CL1*1*2*01"                                      
#> [28] "AMT*F3*237.5"                                    
#> [29] "REF*9A*09459034092"                              
#> [30] "REF*D9*04566877634343456"                        
#> [31] "HI*BK>38181"                                     
#> [32] "HI*BF>38900"                                     
#> [33] "HI*BH>11>D8>20050706"                            
#> [34] "HCP*03*182.88*54.62*123456789"                   
#> [35] "NM1*71*1*JOHNSON*SIMON****XX*5544332211"         
#> [36] "SBR*S*19**T&T PLUMBING COMPANY*****CI"           
#> [37] "OI***Y***Y"                                      
#> [38] "NM1*IL*1*JONES*GEORGE****MI*56454566"            
#> [39] "NM1*PR*2*OTHER COVERAGE COMPANY*****PI*534524"   
#> [40] "LX*1"                                            
#> [41] "SV2*0471*HC>92557*178*UN*1"                      
#> [42] "DTP*472*D8*20050706"                             
#> [43] "HCP*03*137.06*40.94"                             
#> [44] "LX*2"                                            
#> [45] "SV2*0471*HC>92567*59.5*UN*1"                     
#> [46] "DTP*472*D8*20050706"                             
#> [47] "HCP*03*45.82*13.68"                              
#> 
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Trailer
#> $`837I_EX1c_ppo_repriced_claim`$Trailer$SE
#> $`837I_EX1c_ppo_repriced_claim`$Trailer$SE$`01`
#> [1] "48"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Trailer$SE$`02`
#> [1] "1002"
#> 
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Trailer$GE
#> $`837I_EX1c_ppo_repriced_claim`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Trailer$GE$`02`
#> [1] "000000001"
#> 
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Trailer$IEA
#> $`837I_EX1c_ppo_repriced_claim`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $`837I_EX1d_oon_repriced_claim`
#> $`837I_EX1d_oon_repriced_claim`$Header
#> $`837I_EX1d_oon_repriced_claim`$Header$ISA
#> $`837I_EX1d_oon_repriced_claim`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$ISA$`02`
#> [1] NA
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$ISA$`04`
#> [1] NA
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$ISA$`06`
#> [1] "SENDER"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$ISA$`08`
#> [1] "RECEIVER"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$ISA$`09`
#> [1] "231106"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$ISA$`10`
#> [1] "1415"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$ISA$`15`
#> [1] "T"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$GS
#> $`837I_EX1d_oon_repriced_claim`$Header$GS$`01`
#> [1] "HC"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$GS$`02`
#> [1] "SENDERGS"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$GS$`03`
#> [1] "RECEIVERGS"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$GS$`04`
#> [1] "20231106"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$GS$`05`
#> [1] "141557"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$GS$`06`
#> [1] "000000001"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$GS$`07`
#> [1] "X"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Header$GS$`08`
#> [1] "005010X223A2"
#> 
#> 
#> 
#> $`837I_EX1d_oon_repriced_claim`$Transactions
#> $`837I_EX1d_oon_repriced_claim`$Transactions[[1]]
#>  [1] "ST*837*1024*005010X223A2"                        
#>  [2] "BHT*0019*00*1024*20050711*1335*CH"               
#>  [3] "NM1*41*2*REGIONAL PPO NETWORK*****46*123456789"  
#>  [4] "PER*IC*SUBMITTER CONTACT INFO*TE*8001231234"     
#>  [5] "NM1*40*2*CONSERVATIVE INSURANCE*****46*000110002"
#>  [6] "HL*1**20*1"                                      
#>  [7] "NM1*85*2*LOCAL HOSPITAL*****XX*1122334455"       
#>  [8] "N3*3423 SMALL STREET"                            
#>  [9] "N4*COLUMBUS*OH*432150000"                        
#> [10] "REF*EI*111002222"                                
#> [11] "HL*2*1*22*0"                                     
#> [12] "SBR*P*18*34561W******CI"                         
#> [13] "NM1*IL*1*SMITH*JAMES*A***MI*34902390F"           
#> [14] "N3*934 NORTH STREET"                             
#> [15] "N4*COLUMBUS*OH*432150000"                        
#> [16] "DMG*D8*19621015*M"                               
#> [17] "NM1*PR*2*CONSERVATIVE INSURANCE*****PI*0012"     
#> [18] "CLM*W392-49141*14.84***13>A>1**A*Y*Y"            
#> [19] "DTP*434*RD8*20050617-20050617"                   
#> [20] "DTP*435*DT*200506170800"                         
#> [21] "CL1*1*1*01"                                      
#> [22] "AMT*F3*14.84"                                    
#> [23] "REF*9A*459804390823"                             
#> [24] "REF*D9*32423466233"                              
#> [25] "HI*BK>53081"                                     
#> [26] "HCP*00*0**333001234*********T1"                  
#> [27] "NM1*71*1*RIVERS*DAWN****XX*2244224455"           
#> [28] "LX*1"                                            
#> [29] "SV2*0301*HC>82270*14.84*UN*1"                    
#> [30] "DTP*472*D8*20050617"                             
#> 
#> 
#> $`837I_EX1d_oon_repriced_claim`$Trailer
#> $`837I_EX1d_oon_repriced_claim`$Trailer$SE
#> $`837I_EX1d_oon_repriced_claim`$Trailer$SE$`01`
#> [1] "31"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Trailer$SE$`02`
#> [1] "1024"
#> 
#> 
#> $`837I_EX1d_oon_repriced_claim`$Trailer$GE
#> $`837I_EX1d_oon_repriced_claim`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Trailer$GE$`02`
#> [1] "000000001"
#> 
#> 
#> $`837I_EX1d_oon_repriced_claim`$Trailer$IEA
#> $`837I_EX1d_oon_repriced_claim`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`837I_EX1d_oon_repriced_claim`$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $`837I_EX2_car_accident`
#> $`837I_EX2_car_accident`$Header
#> $`837I_EX2_car_accident`$Header$ISA
#> $`837I_EX2_car_accident`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`837I_EX2_car_accident`$Header$ISA$`02`
#> [1] NA
#> 
#> $`837I_EX2_car_accident`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`837I_EX2_car_accident`$Header$ISA$`04`
#> [1] NA
#> 
#> $`837I_EX2_car_accident`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`837I_EX2_car_accident`$Header$ISA$`06`
#> [1] "SENDER"
#> 
#> $`837I_EX2_car_accident`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`837I_EX2_car_accident`$Header$ISA$`08`
#> [1] "RECEIVER"
#> 
#> $`837I_EX2_car_accident`$Header$ISA$`09`
#> [1] "231106"
#> 
#> $`837I_EX2_car_accident`$Header$ISA$`10`
#> [1] "1416"
#> 
#> $`837I_EX2_car_accident`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`837I_EX2_car_accident`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`837I_EX2_car_accident`$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $`837I_EX2_car_accident`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`837I_EX2_car_accident`$Header$ISA$`15`
#> [1] "T"
#> 
#> $`837I_EX2_car_accident`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`837I_EX2_car_accident`$Header$GS
#> $`837I_EX2_car_accident`$Header$GS$`01`
#> [1] "HC"
#> 
#> $`837I_EX2_car_accident`$Header$GS$`02`
#> [1] "SENDERGS"
#> 
#> $`837I_EX2_car_accident`$Header$GS$`03`
#> [1] "RECEIVERGS"
#> 
#> $`837I_EX2_car_accident`$Header$GS$`04`
#> [1] "20231106"
#> 
#> $`837I_EX2_car_accident`$Header$GS$`05`
#> [1] "141625"
#> 
#> $`837I_EX2_car_accident`$Header$GS$`06`
#> [1] "000000001"
#> 
#> $`837I_EX2_car_accident`$Header$GS$`07`
#> [1] "X"
#> 
#> $`837I_EX2_car_accident`$Header$GS$`08`
#> [1] "005010X223A2"
#> 
#> 
#> 
#> $`837I_EX2_car_accident`$Transactions
#> $`837I_EX2_car_accident`$Transactions[[1]]
#>  [1] "ST*837*557766*005010X223A2"                               
#>  [2] "BHT*0019*00*0324*20051111*1800*CH"                        
#>  [3] "NM1*41*2*HALL OF FAME MEMORIAL HOSPITAL*****46*737373737" 
#>  [4] "PER*IC*KATE CASEY*TE*7152569877"                          
#>  [5] "NM1*40*2*HEISMAN INSURANCE COMPANY*****46*999888777"      
#>  [6] "HL*1**20*1"                                               
#>  [7] "PRV*BI*PXC*203BA0200N"                                    
#>  [8] "NM1*85*2*HALL OF FAME MEMORIAL HOSPITAL*****XX*2365259638"
#>  [9] "N3*1 CANTON ROAD"                                         
#> [10] "N4*BROKEN FIELD*CA*99998"                                 
#> [11] "REF*EI*737373737"                                         
#> [12] "HL*2*1*22*1"                                              
#> [13] "SBR*P********AM"                                          
#> [14] "NM1*IL*1*HOWLING*HAL****MI*B999777791G"                   
#> [15] "NM1*PR*2*HEISMAN INSURANCE COMPANY*****PI*999888777"      
#> [16] "HL*3*2*23*0"                                              
#> [17] "PAT*21"                                                   
#> [18] "NM1*QC*1*MEXICO*RON"                                      
#> [19] "N3*32 BUFFALO RUN"                                        
#> [20] "N4*ROCKING HORSE*CA*99666"                                
#> [21] "DMG*D8*19480601*M"                                        
#> [22] "REF*Y4*32323232"                                          
#> [23] "CLM*67236695521*545***13>A>1**A*Y*Y"                      
#> [24] "DTP*434*RD8*20051031-20051101"                            
#> [25] "CL1*3*7*1"                                                
#> [26] "REF*LU*CA"                                                
#> [27] "HI*BK>8842"                                               
#> [28] "HI*PR>8842"                                               
#> [29] "HI*BN>E9750*BN>E9860"                                     
#> [30] "NM1*71*1*LOMBARDO*VINCENT****XX*2533698543"               
#> [31] "LX*1"                                                     
#> [32] "SV2*0450*HC>98765*150*UN*1"                               
#> [33] "DTP*472*D8*20051031"                                      
#> [34] "LX*2"                                                     
#> [35] "SV2*0360*HC>26591*75*UN*1"                                
#> [36] "DTP*472*D8*20051031"                                      
#> [37] "LX*3"                                                     
#> [38] "SV2*0312*HC>86225*100*UN*2"                               
#> [39] "DTP*472*D8*20051031"                                      
#> [40] "LX*4"                                                     
#> [41] "SV2*0360*HC>99283*220*UN*1"                               
#> [42] "DTP*472*D8*20051031"                                      
#> 
#> 
#> $`837I_EX2_car_accident`$Trailer
#> $`837I_EX2_car_accident`$Trailer$SE
#> $`837I_EX2_car_accident`$Trailer$SE$`01`
#> [1] "43"
#> 
#> $`837I_EX2_car_accident`$Trailer$SE$`02`
#> [1] "557766"
#> 
#> 
#> $`837I_EX2_car_accident`$Trailer$GE
#> $`837I_EX2_car_accident`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`837I_EX2_car_accident`$Trailer$GE$`02`
#> [1] "000000001"
#> 
#> 
#> $`837I_EX2_car_accident`$Trailer$IEA
#> $`837I_EX2_car_accident`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`837I_EX2_car_accident`$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $ex_837_inpatient
#> [1] NA
#> 
#> $sample_837I
#> [1] NA
#> 
#> $sample_837_1
#> $sample_837_1$Header
#> $sample_837_1$Header$ISA
#> $sample_837_1$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_837_1$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_837_1$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_837_1$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_837_1$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $sample_837_1$Header$ISA$`06`
#> [1] "589155000448185"
#> 
#> $sample_837_1$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $sample_837_1$Header$ISA$`08`
#> [1] "RegenceBluePoin"
#> 
#> $sample_837_1$Header$ISA$`09`
#> [1] "241205"
#> 
#> $sample_837_1$Header$ISA$`10`
#> [1] "2042"
#> 
#> $sample_837_1$Header$ISA$`11`
#> [1] "U"
#> 
#> $sample_837_1$Header$ISA$`12`
#> [1] "00401"
#> 
#> $sample_837_1$Header$ISA$`13`
#> [1] "566609694"
#> 
#> $sample_837_1$Header$ISA$`14`
#> [1] "0"
#> 
#> $sample_837_1$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_837_1$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_837_1$Header$GS
#> $sample_837_1$Header$GS$`01`
#> [1] "HC"
#> 
#> $sample_837_1$Header$GS$`02`
#> [1] "589155000448185"
#> 
#> $sample_837_1$Header$GS$`03`
#> [1] "RegenceBluePoin"
#> 
#> $sample_837_1$Header$GS$`04`
#> [1] "20241205"
#> 
#> $sample_837_1$Header$GS$`05`
#> [1] "2042"
#> 
#> $sample_837_1$Header$GS$`06`
#> [1] "1"
#> 
#> $sample_837_1$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_837_1$Header$GS$`08`
#> [1] "005010X223A2"
#> 
#> 
#> 
#> $sample_837_1$Transactions
#> $sample_837_1$Transactions[[1]]
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
#> 
#> 
#> $sample_837_1$Trailer
#> $sample_837_1$Trailer$SE
#> $sample_837_1$Trailer$SE$`01`
#> [1] "45"
#> 
#> $sample_837_1$Trailer$SE$`02`
#> [1] "0105"
#> 
#> 
#> $sample_837_1$Trailer$GE
#> $sample_837_1$Trailer$GE$`01`
#> [1] "1"
#> 
#> $sample_837_1$Trailer$GE$`02`
#> [1] "1"
#> 
#> 
#> $sample_837_1$Trailer$IEA
#> $sample_837_1$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_837_1$Trailer$IEA$`02`
#> [1] "566609694"
#> 
#> 
#> 
#> 
#> $sample_837_10
#> $sample_837_10$Header
#> $sample_837_10$Header$ISA
#> $sample_837_10$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_837_10$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_837_10$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_837_10$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_837_10$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $sample_837_10$Header$ISA$`06`
#> [1] "765613337801994"
#> 
#> $sample_837_10$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $sample_837_10$Header$ISA$`08`
#> [1] "OptimaFourSight"
#> 
#> $sample_837_10$Header$ISA$`09`
#> [1] "241205"
#> 
#> $sample_837_10$Header$ISA$`10`
#> [1] "2042"
#> 
#> $sample_837_10$Header$ISA$`11`
#> [1] "U"
#> 
#> $sample_837_10$Header$ISA$`12`
#> [1] "00401"
#> 
#> $sample_837_10$Header$ISA$`13`
#> [1] "351175143"
#> 
#> $sample_837_10$Header$ISA$`14`
#> [1] "0"
#> 
#> $sample_837_10$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_837_10$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_837_10$Header$GS
#> $sample_837_10$Header$GS$`01`
#> [1] "HC"
#> 
#> $sample_837_10$Header$GS$`02`
#> [1] "765613337801994"
#> 
#> $sample_837_10$Header$GS$`03`
#> [1] "OptimaFourSight"
#> 
#> $sample_837_10$Header$GS$`04`
#> [1] "20241205"
#> 
#> $sample_837_10$Header$GS$`05`
#> [1] "2042"
#> 
#> $sample_837_10$Header$GS$`06`
#> [1] "1"
#> 
#> $sample_837_10$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_837_10$Header$GS$`08`
#> [1] "005010X223A2"
#> 
#> 
#> 
#> $sample_837_10$Transactions
#> $sample_837_10$Transactions[[1]]
#>  [1] "ST*837*5856*005010X223A2"                              
#>  [2] "BHT*0019*00*241205204222*20241205*2042*CH"             
#>  [3] "NM1*41*2*HSA PORT ARTHUR, LLC*****XX*1194548073"       
#>  [4] "PER*IC*TEST CONTACT*TE*5555550000"                     
#>  [5] "NM1*40*2*OptimaFourSight*****XX*89242VA018"            
#>  [6] "PER*IC*TEST CONTACT*TE*5555550000"                     
#>  [7] "HL*1**20*1"                                            
#>  [8] "NM1*85*2*HSA PORT ARTHUR, LLC*****XX*1194548073"       
#>  [9] "N3*505 N BRAND BLVD STE 1200"                          
#> [10] "N4*GLENDALE*CA*91203"                                  
#> [11] "REF*EI*71-3391736"                                     
#> [12] "PER*IC*TEST CONTACT*TE*5555550000"                     
#> [13] "HL*2*1*22*0"                                           
#> [14] "SBR*P*18*731323546******CI"                            
#> [15] "NM1*IL*1*TESTLAST01*TESTFIRST01****MI*TESTMBR000000001"
#> [16] "N3*123 TEST STREET"                                    
#> [17] "N4*TESTCITY*CA*00000"                                  
#> [18] "CLM*4742333269*128***11:B:1*Y*A*Y*I"                   
#> [19] "DTP*434*RD8*20240422-20240430"                         
#> [20] "DTP*435*D8*20240809"                                   
#> [21] "DTP*096*TM*2337"                                       
#> [22] "HI*ABK:W214XXA"                                        
#> [23] "HI*ABK:S31813D"                                        
#> [24] "HI*ABK:V0492XD"                                        
#> [25] "HI*ABK:T498X6A"                                        
#> [26] "LX*1"                                                  
#> [27] "SV1*HC:37180*93*UN*1***3:4:1***"                       
#> [28] "DTP*472*D8*20180428"                                   
#> [29] "REF*6R*142671"                                         
#> [30] "LX*2"                                                  
#> [31] "SV1*HC:24000*4*UN*1***1:3:4***"                        
#> [32] "DTP*472*D8*20180428"                                   
#> [33] "REF*6R*142671"                                         
#> [34] "LX*3"                                                  
#> [35] "SV1*HC:16035*31*UN*1***3***"                           
#> [36] "DTP*472*D8*20180428"                                   
#> [37] "REF*6R*142671"                                         
#> 
#> 
#> $sample_837_10$Trailer
#> $sample_837_10$Trailer$SE
#> $sample_837_10$Trailer$SE$`01`
#> [1] "38"
#> 
#> $sample_837_10$Trailer$SE$`02`
#> [1] "5856"
#> 
#> 
#> $sample_837_10$Trailer$GE
#> $sample_837_10$Trailer$GE$`01`
#> [1] "1"
#> 
#> $sample_837_10$Trailer$GE$`02`
#> [1] "1"
#> 
#> 
#> $sample_837_10$Trailer$IEA
#> $sample_837_10$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_837_10$Trailer$IEA$`02`
#> [1] "351175143"
#> 
#> 
#> 
#> 
#> $sample_837_2
#> $sample_837_2$Header
#> $sample_837_2$Header$ISA
#> $sample_837_2$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_837_2$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_837_2$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_837_2$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_837_2$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $sample_837_2$Header$ISA$`06`
#> [1] "961285082616691"
#> 
#> $sample_837_2$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $sample_837_2$Header$ISA$`08`
#> [1] "AntidoteGoldSaf"
#> 
#> $sample_837_2$Header$ISA$`09`
#> [1] "241205"
#> 
#> $sample_837_2$Header$ISA$`10`
#> [1] "2042"
#> 
#> $sample_837_2$Header$ISA$`11`
#> [1] "U"
#> 
#> $sample_837_2$Header$ISA$`12`
#> [1] "00401"
#> 
#> $sample_837_2$Header$ISA$`13`
#> [1] "030077084"
#> 
#> $sample_837_2$Header$ISA$`14`
#> [1] "0"
#> 
#> $sample_837_2$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_837_2$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_837_2$Header$GS
#> $sample_837_2$Header$GS$`01`
#> [1] "HC"
#> 
#> $sample_837_2$Header$GS$`02`
#> [1] "961285082616691"
#> 
#> $sample_837_2$Header$GS$`03`
#> [1] "AntidoteGoldSaf"
#> 
#> $sample_837_2$Header$GS$`04`
#> [1] "20241205"
#> 
#> $sample_837_2$Header$GS$`05`
#> [1] "2042"
#> 
#> $sample_837_2$Header$GS$`06`
#> [1] "1"
#> 
#> $sample_837_2$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_837_2$Header$GS$`08`
#> [1] "005010X223A2"
#> 
#> 
#> 
#> $sample_837_2$Transactions
#> $sample_837_2$Transactions[[1]]
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
#> 
#> 
#> $sample_837_2$Trailer
#> $sample_837_2$Trailer$SE
#> $sample_837_2$Trailer$SE$`01`
#> [1] "37"
#> 
#> $sample_837_2$Trailer$SE$`02`
#> [1] "1462077"
#> 
#> 
#> $sample_837_2$Trailer$GE
#> $sample_837_2$Trailer$GE$`01`
#> [1] "1"
#> 
#> $sample_837_2$Trailer$GE$`02`
#> [1] "1"
#> 
#> 
#> $sample_837_2$Trailer$IEA
#> $sample_837_2$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_837_2$Trailer$IEA$`02`
#> [1] "030077084"
#> 
#> 
#> 
#> 
#> $sample_837_3
#> $sample_837_3$Header
#> $sample_837_3$Header$ISA
#> $sample_837_3$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_837_3$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_837_3$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_837_3$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_837_3$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $sample_837_3$Header$ISA$`06`
#> [1] "657631015478465"
#> 
#> $sample_837_3$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $sample_837_3$Header$ISA$`08`
#> [1] "MOLINAHEALTHCAR"
#> 
#> $sample_837_3$Header$ISA$`09`
#> [1] "241205"
#> 
#> $sample_837_3$Header$ISA$`10`
#> [1] "2042"
#> 
#> $sample_837_3$Header$ISA$`11`
#> [1] "U"
#> 
#> $sample_837_3$Header$ISA$`12`
#> [1] "00401"
#> 
#> $sample_837_3$Header$ISA$`13`
#> [1] "828442319"
#> 
#> $sample_837_3$Header$ISA$`14`
#> [1] "0"
#> 
#> $sample_837_3$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_837_3$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_837_3$Header$GS
#> $sample_837_3$Header$GS$`01`
#> [1] "HC"
#> 
#> $sample_837_3$Header$GS$`02`
#> [1] "657631015478465"
#> 
#> $sample_837_3$Header$GS$`03`
#> [1] "MOLINAHEALTHCAR"
#> 
#> $sample_837_3$Header$GS$`04`
#> [1] "20241205"
#> 
#> $sample_837_3$Header$GS$`05`
#> [1] "2042"
#> 
#> $sample_837_3$Header$GS$`06`
#> [1] "1"
#> 
#> $sample_837_3$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_837_3$Header$GS$`08`
#> [1] "005010X223A2"
#> 
#> 
#> 
#> $sample_837_3$Transactions
#> $sample_837_3$Transactions[[1]]
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
#> 
#> 
#> $sample_837_3$Trailer
#> $sample_837_3$Trailer$SE
#> $sample_837_3$Trailer$SE$`01`
#> [1] "36"
#> 
#> $sample_837_3$Trailer$SE$`02`
#> [1] "93687"
#> 
#> 
#> $sample_837_3$Trailer$GE
#> $sample_837_3$Trailer$GE$`01`
#> [1] "1"
#> 
#> $sample_837_3$Trailer$GE$`02`
#> [1] "1"
#> 
#> 
#> $sample_837_3$Trailer$IEA
#> $sample_837_3$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_837_3$Trailer$IEA$`02`
#> [1] "828442319"
#> 
#> 
#> 
#> 
#> $sample_837_4
#> $sample_837_4$Header
#> $sample_837_4$Header$ISA
#> $sample_837_4$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_837_4$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_837_4$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_837_4$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_837_4$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $sample_837_4$Header$ISA$`06`
#> [1] "816055286149740"
#> 
#> $sample_837_4$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $sample_837_4$Header$ISA$`08`
#> [1] "HighDeductibleH"
#> 
#> $sample_837_4$Header$ISA$`09`
#> [1] "241205"
#> 
#> $sample_837_4$Header$ISA$`10`
#> [1] "2042"
#> 
#> $sample_837_4$Header$ISA$`11`
#> [1] "U"
#> 
#> $sample_837_4$Header$ISA$`12`
#> [1] "00401"
#> 
#> $sample_837_4$Header$ISA$`13`
#> [1] "621402678"
#> 
#> $sample_837_4$Header$ISA$`14`
#> [1] "0"
#> 
#> $sample_837_4$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_837_4$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_837_4$Header$GS
#> $sample_837_4$Header$GS$`01`
#> [1] "HC"
#> 
#> $sample_837_4$Header$GS$`02`
#> [1] "816055286149740"
#> 
#> $sample_837_4$Header$GS$`03`
#> [1] "HighDeductibleH"
#> 
#> $sample_837_4$Header$GS$`04`
#> [1] "20241205"
#> 
#> $sample_837_4$Header$GS$`05`
#> [1] "2042"
#> 
#> $sample_837_4$Header$GS$`06`
#> [1] "1"
#> 
#> $sample_837_4$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_837_4$Header$GS$`08`
#> [1] "005010X223A2"
#> 
#> 
#> 
#> $sample_837_4$Transactions
#> $sample_837_4$Transactions[[1]]
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
#> 
#> 
#> $sample_837_4$Trailer
#> $sample_837_4$Trailer$SE
#> $sample_837_4$Trailer$SE$`01`
#> [1] "34"
#> 
#> $sample_837_4$Trailer$SE$`02`
#> [1] "91529"
#> 
#> 
#> $sample_837_4$Trailer$GE
#> $sample_837_4$Trailer$GE$`01`
#> [1] "1"
#> 
#> $sample_837_4$Trailer$GE$`02`
#> [1] "1"
#> 
#> 
#> $sample_837_4$Trailer$IEA
#> $sample_837_4$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_837_4$Trailer$IEA$`02`
#> [1] "621402678"
#> 
#> 
#> 
#> 
#> $sample_837_5
#> $sample_837_5$Header
#> $sample_837_5$Header$ISA
#> $sample_837_5$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_837_5$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_837_5$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_837_5$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_837_5$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $sample_837_5$Header$ISA$`06`
#> [1] "051153619573476"
#> 
#> $sample_837_5$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $sample_837_5$Header$ISA$`08`
#> [1] "BlanketStudentA"
#> 
#> $sample_837_5$Header$ISA$`09`
#> [1] "241205"
#> 
#> $sample_837_5$Header$ISA$`10`
#> [1] "2042"
#> 
#> $sample_837_5$Header$ISA$`11`
#> [1] "U"
#> 
#> $sample_837_5$Header$ISA$`12`
#> [1] "00401"
#> 
#> $sample_837_5$Header$ISA$`13`
#> [1] "518159636"
#> 
#> $sample_837_5$Header$ISA$`14`
#> [1] "0"
#> 
#> $sample_837_5$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_837_5$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_837_5$Header$GS
#> $sample_837_5$Header$GS$`01`
#> [1] "HC"
#> 
#> $sample_837_5$Header$GS$`02`
#> [1] "051153619573476"
#> 
#> $sample_837_5$Header$GS$`03`
#> [1] "BlanketStudentA"
#> 
#> $sample_837_5$Header$GS$`04`
#> [1] "20241205"
#> 
#> $sample_837_5$Header$GS$`05`
#> [1] "2042"
#> 
#> $sample_837_5$Header$GS$`06`
#> [1] "1"
#> 
#> $sample_837_5$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_837_5$Header$GS$`08`
#> [1] "005010X223A2"
#> 
#> 
#> 
#> $sample_837_5$Transactions
#> $sample_837_5$Transactions[[1]]
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
#> 
#> 
#> $sample_837_5$Trailer
#> $sample_837_5$Trailer$SE
#> $sample_837_5$Trailer$SE$`01`
#> [1] "44"
#> 
#> $sample_837_5$Trailer$SE$`02`
#> [1] "46086"
#> 
#> 
#> $sample_837_5$Trailer$GE
#> $sample_837_5$Trailer$GE$`01`
#> [1] "1"
#> 
#> $sample_837_5$Trailer$GE$`02`
#> [1] "1"
#> 
#> 
#> $sample_837_5$Trailer$IEA
#> $sample_837_5$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_837_5$Trailer$IEA$`02`
#> [1] "518159636"
#> 
#> 
#> 
#> 
#> $sample_837_6
#> $sample_837_6$Header
#> $sample_837_6$Header$ISA
#> $sample_837_6$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_837_6$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_837_6$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_837_6$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_837_6$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $sample_837_6$Header$ISA$`06`
#> [1] "336342583485277"
#> 
#> $sample_837_6$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $sample_837_6$Header$ISA$`08`
#> [1] "EHB2015IPLAELIC"
#> 
#> $sample_837_6$Header$ISA$`09`
#> [1] "241205"
#> 
#> $sample_837_6$Header$ISA$`10`
#> [1] "2042"
#> 
#> $sample_837_6$Header$ISA$`11`
#> [1] "U"
#> 
#> $sample_837_6$Header$ISA$`12`
#> [1] "00401"
#> 
#> $sample_837_6$Header$ISA$`13`
#> [1] "115983591"
#> 
#> $sample_837_6$Header$ISA$`14`
#> [1] "0"
#> 
#> $sample_837_6$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_837_6$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_837_6$Header$GS
#> $sample_837_6$Header$GS$`01`
#> [1] "HC"
#> 
#> $sample_837_6$Header$GS$`02`
#> [1] "336342583485277"
#> 
#> $sample_837_6$Header$GS$`03`
#> [1] "EHB2015IPLAELIC"
#> 
#> $sample_837_6$Header$GS$`04`
#> [1] "20241205"
#> 
#> $sample_837_6$Header$GS$`05`
#> [1] "2042"
#> 
#> $sample_837_6$Header$GS$`06`
#> [1] "1"
#> 
#> $sample_837_6$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_837_6$Header$GS$`08`
#> [1] "005010X223A2"
#> 
#> 
#> 
#> $sample_837_6$Transactions
#> $sample_837_6$Transactions[[1]]
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
#> 
#> 
#> $sample_837_6$Trailer
#> $sample_837_6$Trailer$SE
#> $sample_837_6$Trailer$SE$`01`
#> [1] "48"
#> 
#> $sample_837_6$Trailer$SE$`02`
#> [1] "76134698"
#> 
#> 
#> $sample_837_6$Trailer$GE
#> $sample_837_6$Trailer$GE$`01`
#> [1] "1"
#> 
#> $sample_837_6$Trailer$GE$`02`
#> [1] "1"
#> 
#> 
#> $sample_837_6$Trailer$IEA
#> $sample_837_6$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_837_6$Trailer$IEA$`02`
#> [1] "115983591"
#> 
#> 
#> 
#> 
#> $sample_837_7
#> $sample_837_7$Header
#> $sample_837_7$Header$ISA
#> $sample_837_7$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_837_7$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_837_7$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_837_7$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_837_7$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $sample_837_7$Header$ISA$`06`
#> [1] "879679616399691"
#> 
#> $sample_837_7$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $sample_837_7$Header$ISA$`08`
#> [1] "HSA2000_10A1189"
#> 
#> $sample_837_7$Header$ISA$`09`
#> [1] "241205"
#> 
#> $sample_837_7$Header$ISA$`10`
#> [1] "2042"
#> 
#> $sample_837_7$Header$ISA$`11`
#> [1] "U"
#> 
#> $sample_837_7$Header$ISA$`12`
#> [1] "00401"
#> 
#> $sample_837_7$Header$ISA$`13`
#> [1] "871936722"
#> 
#> $sample_837_7$Header$ISA$`14`
#> [1] "0"
#> 
#> $sample_837_7$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_837_7$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_837_7$Header$GS
#> $sample_837_7$Header$GS$`01`
#> [1] "HC"
#> 
#> $sample_837_7$Header$GS$`02`
#> [1] "879679616399691"
#> 
#> $sample_837_7$Header$GS$`03`
#> [1] "HSA2000_10A1189"
#> 
#> $sample_837_7$Header$GS$`04`
#> [1] "20241205"
#> 
#> $sample_837_7$Header$GS$`05`
#> [1] "2042"
#> 
#> $sample_837_7$Header$GS$`06`
#> [1] "1"
#> 
#> $sample_837_7$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_837_7$Header$GS$`08`
#> [1] "005010X223A2"
#> 
#> 
#> 
#> $sample_837_7$Transactions
#> $sample_837_7$Transactions[[1]]
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
#> 
#> 
#> $sample_837_7$Trailer
#> $sample_837_7$Trailer$SE
#> $sample_837_7$Trailer$SE$`01`
#> [1] "43"
#> 
#> $sample_837_7$Trailer$SE$`02`
#> [1] "7869171"
#> 
#> 
#> $sample_837_7$Trailer$GE
#> $sample_837_7$Trailer$GE$`01`
#> [1] "1"
#> 
#> $sample_837_7$Trailer$GE$`02`
#> [1] "1"
#> 
#> 
#> $sample_837_7$Trailer$IEA
#> $sample_837_7$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_837_7$Trailer$IEA$`02`
#> [1] "871936722"
#> 
#> 
#> 
#> 
#> $sample_837_8
#> $sample_837_8$Header
#> $sample_837_8$Header$ISA
#> $sample_837_8$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_837_8$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_837_8$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_837_8$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_837_8$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $sample_837_8$Header$ISA$`06`
#> [1] "719189088449132"
#> 
#> $sample_837_8$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $sample_837_8$Header$ISA$`08`
#> [1] "SimplyBluePPOwi"
#> 
#> $sample_837_8$Header$ISA$`09`
#> [1] "241205"
#> 
#> $sample_837_8$Header$ISA$`10`
#> [1] "2042"
#> 
#> $sample_837_8$Header$ISA$`11`
#> [1] "U"
#> 
#> $sample_837_8$Header$ISA$`12`
#> [1] "00401"
#> 
#> $sample_837_8$Header$ISA$`13`
#> [1] "464860572"
#> 
#> $sample_837_8$Header$ISA$`14`
#> [1] "0"
#> 
#> $sample_837_8$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_837_8$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_837_8$Header$GS
#> $sample_837_8$Header$GS$`01`
#> [1] "HC"
#> 
#> $sample_837_8$Header$GS$`02`
#> [1] "719189088449132"
#> 
#> $sample_837_8$Header$GS$`03`
#> [1] "SimplyBluePPOwi"
#> 
#> $sample_837_8$Header$GS$`04`
#> [1] "20241205"
#> 
#> $sample_837_8$Header$GS$`05`
#> [1] "2042"
#> 
#> $sample_837_8$Header$GS$`06`
#> [1] "1"
#> 
#> $sample_837_8$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_837_8$Header$GS$`08`
#> [1] "005010X223A2"
#> 
#> 
#> 
#> $sample_837_8$Transactions
#> $sample_837_8$Transactions[[1]]
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
#> 
#> 
#> $sample_837_8$Trailer
#> $sample_837_8$Trailer$SE
#> $sample_837_8$Trailer$SE$`01`
#> [1] "41"
#> 
#> $sample_837_8$Trailer$SE$`02`
#> [1] "57975326"
#> 
#> 
#> $sample_837_8$Trailer$GE
#> $sample_837_8$Trailer$GE$`01`
#> [1] "1"
#> 
#> $sample_837_8$Trailer$GE$`02`
#> [1] "1"
#> 
#> 
#> $sample_837_8$Trailer$IEA
#> $sample_837_8$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_837_8$Trailer$IEA$`02`
#> [1] "464860572"
#> 
#> 
#> 
#> 
#> $sample_837_9
#> $sample_837_9$Header
#> $sample_837_9$Header$ISA
#> $sample_837_9$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_837_9$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_837_9$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_837_9$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_837_9$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $sample_837_9$Header$ISA$`06`
#> [1] "913673479406110"
#> 
#> $sample_837_9$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $sample_837_9$Header$ISA$`08`
#> [1] "HMOOffExchangeR"
#> 
#> $sample_837_9$Header$ISA$`09`
#> [1] "241205"
#> 
#> $sample_837_9$Header$ISA$`10`
#> [1] "2042"
#> 
#> $sample_837_9$Header$ISA$`11`
#> [1] "U"
#> 
#> $sample_837_9$Header$ISA$`12`
#> [1] "00401"
#> 
#> $sample_837_9$Header$ISA$`13`
#> [1] "253034665"
#> 
#> $sample_837_9$Header$ISA$`14`
#> [1] "0"
#> 
#> $sample_837_9$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_837_9$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_837_9$Header$GS
#> $sample_837_9$Header$GS$`01`
#> [1] "HC"
#> 
#> $sample_837_9$Header$GS$`02`
#> [1] "913673479406110"
#> 
#> $sample_837_9$Header$GS$`03`
#> [1] "HMOOffExchangeR"
#> 
#> $sample_837_9$Header$GS$`04`
#> [1] "20241205"
#> 
#> $sample_837_9$Header$GS$`05`
#> [1] "2042"
#> 
#> $sample_837_9$Header$GS$`06`
#> [1] "1"
#> 
#> $sample_837_9$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_837_9$Header$GS$`08`
#> [1] "005010X223A2"
#> 
#> 
#> 
#> $sample_837_9$Transactions
#> $sample_837_9$Transactions[[1]]
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
#> 
#> 
#> $sample_837_9$Trailer
#> $sample_837_9$Trailer$SE
#> $sample_837_9$Trailer$SE$`01`
#> [1] "46"
#> 
#> $sample_837_9$Trailer$SE$`02`
#> [1] "4763033"
#> 
#> 
#> $sample_837_9$Trailer$GE
#> $sample_837_9$Trailer$GE$`01`
#> [1] "1"
#> 
#> $sample_837_9$Trailer$GE$`02`
#> [1] "1"
#> 
#> 
#> $sample_837_9$Trailer$IEA
#> $sample_837_9$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_837_9$Trailer$IEA$`02`
#> [1] "253034665"
#> 
#> 
#> 
#> 
#> $`837P_EX10a_drug_adm_office`
#> $`837P_EX10a_drug_adm_office`$Header
#> $`837P_EX10a_drug_adm_office`$Header$ISA
#> $`837P_EX10a_drug_adm_office`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$ISA$`02`
#> [1] NA
#> 
#> $`837P_EX10a_drug_adm_office`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$ISA$`04`
#> [1] NA
#> 
#> $`837P_EX10a_drug_adm_office`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$ISA$`06`
#> [1] "SENDER"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$ISA$`08`
#> [1] "RECEIVER"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$ISA$`09`
#> [1] "231106"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$ISA$`10`
#> [1] "1411"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$ISA$`15`
#> [1] "T"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`837P_EX10a_drug_adm_office`$Header$GS
#> $`837P_EX10a_drug_adm_office`$Header$GS$`01`
#> [1] "HC"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$GS$`02`
#> [1] "SENDERGS"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$GS$`03`
#> [1] "RECEIVERGS"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$GS$`04`
#> [1] "20231106"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$GS$`05`
#> [1] "141104"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$GS$`06`
#> [1] "000000001"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$GS$`07`
#> [1] "X"
#> 
#> $`837P_EX10a_drug_adm_office`$Header$GS$`08`
#> [1] "005010X222A1"
#> 
#> 
#> 
#> $`837P_EX10a_drug_adm_office`$Transactions
#> $`837P_EX10a_drug_adm_office`$Transactions[[1]]
#>  [1] "ST*837*0711*005010X222A1"                        
#>  [2] "BHT*0019*00*0013*20040801*1200*CH"               
#>  [3] "NM1*41*2*Associates in Medicine*****46*587654321"
#>  [4] "PER*IC*Bud Holly*TE*8017268899"                  
#>  [5] "NM1*40*2*XYZ Receiver*****46*369852758"          
#>  [6] "HL*1**20*1"                                      
#>  [7] "NM1*85*2*Associates in Medicine*****XX*587654321"
#>  [8] "N3*1313 Las Vegas Boulevard"                     
#>  [9] "N4*Las Vegas*NV*89109"                           
#> [10] "REF*EI*587654321"                                
#> [11] "HL*2*1*22*0"                                     
#> [12] "SBR*P*18*GRP01020102******CI"                    
#> [13] "NM1*IL*1*Vaughn*Steve*R***MI*MBRID12345"         
#> [14] "N3*236 Diamond ST"                               
#> [15] "N4*Las Vegas*NV*89109"                           
#> [16] "DMG*D8*19430501*M"                               
#> [17] "NM1*PR*2*R&R Health Plan*****XV*PLANID12345"     
#> [18] "CLM*CLMNO12345*103.37***11>B>1*Y*A*Y*Y"          
#> [19] "HI*BK>03591"                                     
#> [20] "NM1*82*1*Hendrix*Jim****XX*1122333341"           
#> [21] "PRV*PE*PXC*208D00000X"                           
#> [22] "LX*1"                                            
#> [23] "SV1*HC>90782*50*UN*1*11**1"                      
#> [24] "DTP*472*D8*20040711"                             
#> [25] "LX*2"                                            
#> [26] "SV1*HC>J1550*53.37*UN*1*11**1"                   
#> [27] "DTP*472*D8*20040711"                             
#> [28] "AMT*T*3.37"                                      
#> [29] "LIN**N4*00026063512"                             
#> [30] "CTP****10*ML"                                    
#> 
#> 
#> $`837P_EX10a_drug_adm_office`$Trailer
#> $`837P_EX10a_drug_adm_office`$Trailer$SE
#> $`837P_EX10a_drug_adm_office`$Trailer$SE$`01`
#> [1] "31"
#> 
#> $`837P_EX10a_drug_adm_office`$Trailer$SE$`02`
#> [1] "0711"
#> 
#> 
#> $`837P_EX10a_drug_adm_office`$Trailer$GE
#> $`837P_EX10a_drug_adm_office`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`837P_EX10a_drug_adm_office`$Trailer$GE$`02`
#> [1] "000000001"
#> 
#> 
#> $`837P_EX10a_drug_adm_office`$Trailer$IEA
#> $`837P_EX10a_drug_adm_office`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`837P_EX10a_drug_adm_office`$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $`837P_EX11_ppo_repriced_claim`
#> $`837P_EX11_ppo_repriced_claim`$Header
#> $`837P_EX11_ppo_repriced_claim`$Header$ISA
#> $`837P_EX11_ppo_repriced_claim`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$ISA$`02`
#> [1] NA
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$ISA$`04`
#> [1] NA
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$ISA$`06`
#> [1] "SENDER"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$ISA$`08`
#> [1] "RECEIVER"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$ISA$`09`
#> [1] "231106"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$ISA$`10`
#> [1] "1415"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$ISA$`15`
#> [1] "T"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$GS
#> $`837P_EX11_ppo_repriced_claim`$Header$GS$`01`
#> [1] "HC"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$GS$`02`
#> [1] "SENDERGS"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$GS$`03`
#> [1] "RECEIVERGS"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$GS$`04`
#> [1] "20231106"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$GS$`05`
#> [1] "141535"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$GS$`06`
#> [1] "000000001"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$GS$`07`
#> [1] "X"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Header$GS$`08`
#> [1] "005010X222A1"
#> 
#> 
#> 
#> $`837P_EX11_ppo_repriced_claim`$Transactions
#> $`837P_EX11_ppo_repriced_claim`$Transactions[[1]]
#>  [1] "ST*837*1002*005010X222A1"                               
#>  [2] "BHT*0019*00*1002*20050620*09460000*CH"                  
#>  [3] "NM1*41*2*REGIONAL PPO NETWORK*****46*123456789"         
#>  [4] "PER*IC*SUBMITTER CONTACT INFO*TE*8001231234"            
#>  [5] "NM1*40*2*EXTRA HEALTHY INSURANCE*****46*112244"         
#>  [6] "HL*1**20*1"                                             
#>  [7] "NM1*85*2*HAPPY DOCTORS GROUP PRACTICE*****XX*1234567890"
#>  [8] "N3*P O BOX 123"                                         
#>  [9] "N4*FORT WAYNE*IN*462540000"                             
#> [10] "REF*EI*555512345"                                       
#> [11] "PER*IC*SUE BILLINGSWORTH*TE*8881231234"                 
#> [12] "HL*2*1*22*0"                                            
#> [13] "SBR*P*18*123XYZ******CI"                                
#> [14] "NM1*IL*1*RING*DIAMOND*D***MI*00124A089"                 
#> [15] "N3*123 EXAMPLE DRIVE"                                   
#> [16] "N4*INDIANAPOLIS*IN*462290000"                           
#> [17] "DMG*D8*19401229*F"                                      
#> [18] "NM1*PR*2*EXTRA HEALTHY INSURANCE*****PI*12345"          
#> [19] "CLM*ABC123-RI*28.75***11>B>1*Y*A*Y*Y*P"                 
#> [20] "REF*9A*0902352342"                                      
#> [21] "REF*D9*061505501749388"                                 
#> [22] "HI*BK>496*BF>25000"                                     
#> [23] "HCP*03*26.75*2*908231234"                               
#> [24] "NM1*DN*1*DOE*JOHN****XX*9988776655"                     
#> [25] "NM1*82*1*ANTHONY*SUSAN*B***XX*1122334455"               
#> [26] "NM1*77*2*HAPPY DOCTORS GROUP"                           
#> [27] "N3*123 FEEL GOOD ROAD"                                  
#> [28] "N4*WASHINGTON*IN*475010000"                             
#> [29] "LX*1"                                                   
#> [30] "SV1*HC>E0570>RR*25*UN*1***1>2"                          
#> [31] "DTP*472*D8*20050514"                                    
#> [32] "HCP*03*23.75*1.25*908231234"                            
#> [33] "LX*2"                                                   
#> [34] "SV1*HC>A7003>NU*3.75*UN*1***1"                          
#> [35] "DTP*472*D8*20050514"                                    
#> [36] "HCP*03*3*.75*908231234"                                 
#> 
#> 
#> $`837P_EX11_ppo_repriced_claim`$Trailer
#> $`837P_EX11_ppo_repriced_claim`$Trailer$SE
#> $`837P_EX11_ppo_repriced_claim`$Trailer$SE$`01`
#> [1] "37"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Trailer$SE$`02`
#> [1] "1002"
#> 
#> 
#> $`837P_EX11_ppo_repriced_claim`$Trailer$GE
#> $`837P_EX11_ppo_repriced_claim`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Trailer$GE$`02`
#> [1] "000000001"
#> 
#> 
#> $`837P_EX11_ppo_repriced_claim`$Trailer$IEA
#> $`837P_EX11_ppo_repriced_claim`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`837P_EX11_ppo_repriced_claim`$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $`837P_EX12_oon_repriced_claim`
#> $`837P_EX12_oon_repriced_claim`$Header
#> $`837P_EX12_oon_repriced_claim`$Header$ISA
#> $`837P_EX12_oon_repriced_claim`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$ISA$`02`
#> [1] NA
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$ISA$`04`
#> [1] NA
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$ISA$`06`
#> [1] "SENDER"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$ISA$`08`
#> [1] "RECEIVER"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$ISA$`09`
#> [1] "231106"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$ISA$`10`
#> [1] "1416"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$ISA$`15`
#> [1] "T"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$GS
#> $`837P_EX12_oon_repriced_claim`$Header$GS$`01`
#> [1] "HC"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$GS$`02`
#> [1] "SENDERGS"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$GS$`03`
#> [1] "RECEIVERGS"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$GS$`04`
#> [1] "20231106"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$GS$`05`
#> [1] "141631"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$GS$`06`
#> [1] "000000001"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$GS$`07`
#> [1] "X"
#> 
#> $`837P_EX12_oon_repriced_claim`$Header$GS$`08`
#> [1] "005010X222A1"
#> 
#> 
#> 
#> $`837P_EX12_oon_repriced_claim`$Transactions
#> $`837P_EX12_oon_repriced_claim`$Transactions[[1]]
#>  [1] "ST*837*1024*005010X222A1"                             
#>  [2] "BHT*0019*00*1024*20050711*1335*CH"                    
#>  [3] "NM1*41*2*REGIONAL PPO NETWORK*****46*123456789"       
#>  [4] "PER*IC*SUBMITTER CONTACT INFO*TE*8001231234"          
#>  [5] "NM1*40*2*CONSERVATIVE INSURANCE*****46*000110002"     
#>  [6] "HL*1**20*1"                                           
#>  [7] "NM1*85*2*EMERGENCY PHYSICIANS GROUP*****XX*1122334455"
#>  [8] "N3*7423 SUPER STREET"                                 
#>  [9] "N4*BILLINGS*MO*919910000"                             
#> [10] "REF*EI*111002222"                                     
#> [11] "HL*2*1*22*1"                                          
#> [12] "SBR*P**232AA******CI"                                 
#> [13] "NM1*IL*1*SMITH*MATTHEW*R***MI*57976235C"              
#> [14] "N3*5698 SOUTH STREET"                                 
#> [15] "N4*BILLINGS*MO*919910000"                             
#> [16] "DMG*D8*19561015*M"                                    
#> [17] "NM1*PR*2*CONSERVATIVE INSURANCE*****PI*00123"         
#> [18] "HL*3*2*23*0"                                          
#> [19] "PAT*19"                                               
#> [20] "NM1*QC*1*SMITH*TOM*E"                                 
#> [21] "N3*5698 SOUTH STREET"                                 
#> [22] "N4*BILLINGS*MO*919910000"                             
#> [23] "DMG*D8*19960807*M"                                    
#> [24] "CLM*TS234H3*252.71***23>B>1*Y*A*Y*Y*P"                
#> [25] "REF*9A*0902345406"                                    
#> [26] "REF*D9*687534234346"                                  
#> [27] "HI*BK>9951"                                           
#> [28] "HCP*00*0**333001234*********T1"                       
#> [29] "NM1*82*1*BLUE*JACKIE*D***XX*1112223336"               
#> [30] "SBR*S*18*56567******CI"                               
#> [31] "OI***Y***Y"                                           
#> [32] "NM1*IL*1*SMITH*TOM*E***MI*23424570"                   
#> [33] "N3*5698 SOUTH STREET"                                 
#> [34] "N4*BILLINGS*MO*919910000"                             
#> [35] "NM1*PR*2*SECONDARY INSURANCE COMPANY*****PI*95645"    
#> [36] "LX*1"                                                 
#> [37] "SV1*HC>99284*252.71*UN*1***1"                         
#> [38] "DTP*472*D8*20050506"                                  
#> 
#> 
#> $`837P_EX12_oon_repriced_claim`$Trailer
#> $`837P_EX12_oon_repriced_claim`$Trailer$SE
#> $`837P_EX12_oon_repriced_claim`$Trailer$SE$`01`
#> [1] "39"
#> 
#> $`837P_EX12_oon_repriced_claim`$Trailer$SE$`02`
#> [1] "1024"
#> 
#> 
#> $`837P_EX12_oon_repriced_claim`$Trailer$GE
#> $`837P_EX12_oon_repriced_claim`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`837P_EX12_oon_repriced_claim`$Trailer$GE$`02`
#> [1] "000000001"
#> 
#> 
#> $`837P_EX12_oon_repriced_claim`$Trailer$IEA
#> $`837P_EX12_oon_repriced_claim`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`837P_EX12_oon_repriced_claim`$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $`837P_EX1_commercial-insurance`
#> $`837P_EX1_commercial-insurance`$Header
#> $`837P_EX1_commercial-insurance`$Header$ISA
#> $`837P_EX1_commercial-insurance`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`837P_EX1_commercial-insurance`$Header$ISA$`02`
#> [1] NA
#> 
#> $`837P_EX1_commercial-insurance`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`837P_EX1_commercial-insurance`$Header$ISA$`04`
#> [1] NA
#> 
#> $`837P_EX1_commercial-insurance`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`837P_EX1_commercial-insurance`$Header$ISA$`06`
#> [1] "SENDER"
#> 
#> $`837P_EX1_commercial-insurance`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`837P_EX1_commercial-insurance`$Header$ISA$`08`
#> [1] "RECEIVER"
#> 
#> $`837P_EX1_commercial-insurance`$Header$ISA$`09`
#> [1] "231106"
#> 
#> $`837P_EX1_commercial-insurance`$Header$ISA$`10`
#> [1] "1408"
#> 
#> $`837P_EX1_commercial-insurance`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`837P_EX1_commercial-insurance`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`837P_EX1_commercial-insurance`$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $`837P_EX1_commercial-insurance`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`837P_EX1_commercial-insurance`$Header$ISA$`15`
#> [1] "T"
#> 
#> $`837P_EX1_commercial-insurance`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`837P_EX1_commercial-insurance`$Header$GS
#> $`837P_EX1_commercial-insurance`$Header$GS$`01`
#> [1] "HC"
#> 
#> $`837P_EX1_commercial-insurance`$Header$GS$`02`
#> [1] "SENDERGS"
#> 
#> $`837P_EX1_commercial-insurance`$Header$GS$`03`
#> [1] "RECEIVERGS"
#> 
#> $`837P_EX1_commercial-insurance`$Header$GS$`04`
#> [1] "20231106"
#> 
#> $`837P_EX1_commercial-insurance`$Header$GS$`05`
#> [1] "140840"
#> 
#> $`837P_EX1_commercial-insurance`$Header$GS$`06`
#> [1] "000000001"
#> 
#> $`837P_EX1_commercial-insurance`$Header$GS$`07`
#> [1] "X"
#> 
#> $`837P_EX1_commercial-insurance`$Header$GS$`08`
#> [1] "005010X222A1"
#> 
#> 
#> 
#> $`837P_EX1_commercial-insurance`$Transactions
#> $`837P_EX1_commercial-insurance`$Transactions[[1]]
#>  [1] "ST*837*0021*005010X222A1"                       
#>  [2] "BHT*0019*00*244579*20061015*1023*CH"            
#>  [3] "NM1*41*2*PREMIER BILLING SERVICE*****46*TGJ23"  
#>  [4] "PER*IC*JERRY*TE*3055552222*EX*231"              
#>  [5] "NM1*40*2*KEY INSURANCE COMPANY*****46*66783JJT" 
#>  [6] "HL*1**20*1"                                     
#>  [7] "PRV*BI*PXC*203BF0100Y"                          
#>  [8] "NM1*85*2*BEN KILDARE SERVICE*****XX*9876543210" 
#>  [9] "N3*234 SEAWAY ST"                               
#> [10] "N4*MIAMI*FL*33111"                              
#> [11] "REF*EI*587654321"                               
#> [12] "NM1*87*2"                                       
#> [13] "N3*2345 OCEAN BLVD"                             
#> [14] "N4*MIAMI*FL*33111"                              
#> [15] "HL*2*1*22*1"                                    
#> [16] "SBR*P**2222-SJ******CI"                         
#> [17] "NM1*IL*1*SMITH*JANE****MI*JS00111223333"        
#> [18] "DMG*D8*19430501*F"                              
#> [19] "NM1*PR*2*KEY INSURANCE COMPANY*****PI*999996666"
#> [20] "REF*G2*KA6663"                                  
#> [21] "HL*3*2*23*0"                                    
#> [22] "PAT*19"                                         
#> [23] "NM1*QC*1*SMITH*TED"                             
#> [24] "N3*236 N MAIN ST"                               
#> [25] "N4*MIAMI*FL*33413"                              
#> [26] "DMG*D8*19730501*M"                              
#> [27] "CLM*26463774*100***11>B>1*Y*A*Y*I"              
#> [28] "REF*D9*17312345600006351"                       
#> [29] "HI*BK>0340*BF>V7389"                            
#> [30] "LX*1"                                           
#> [31] "SV1*HC>99213*40*UN*1***1"                       
#> [32] "DTP*472*D8*20061003"                            
#> [33] "LX*2"                                           
#> [34] "SV1*HC>87070*15*UN*1***1"                       
#> [35] "DTP*472*D8*20061003"                            
#> [36] "LX*3"                                           
#> [37] "SV1*HC>99214*35*UN*1***2"                       
#> [38] "DTP*472*D8*20061010"                            
#> [39] "LX*4"                                           
#> [40] "SV1*HC>86663*10*UN*1***2"                       
#> [41] "DTP*472*D8*20061010"                            
#> 
#> 
#> $`837P_EX1_commercial-insurance`$Trailer
#> $`837P_EX1_commercial-insurance`$Trailer$SE
#> $`837P_EX1_commercial-insurance`$Trailer$SE$`01`
#> [1] "42"
#> 
#> $`837P_EX1_commercial-insurance`$Trailer$SE$`02`
#> [1] "0021"
#> 
#> 
#> $`837P_EX1_commercial-insurance`$Trailer$GE
#> $`837P_EX1_commercial-insurance`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`837P_EX1_commercial-insurance`$Trailer$GE$`02`
#> [1] "000000001"
#> 
#> 
#> $`837P_EX1_commercial-insurance`$Trailer$IEA
#> $`837P_EX1_commercial-insurance`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`837P_EX1_commercial-insurance`$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $`837P_EX2_encounter`
#> $`837P_EX2_encounter`$Header
#> $`837P_EX2_encounter`$Header$ISA
#> $`837P_EX2_encounter`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`837P_EX2_encounter`$Header$ISA$`02`
#> [1] NA
#> 
#> $`837P_EX2_encounter`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`837P_EX2_encounter`$Header$ISA$`04`
#> [1] NA
#> 
#> $`837P_EX2_encounter`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`837P_EX2_encounter`$Header$ISA$`06`
#> [1] "SENDER"
#> 
#> $`837P_EX2_encounter`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`837P_EX2_encounter`$Header$ISA$`08`
#> [1] "RECEIVER"
#> 
#> $`837P_EX2_encounter`$Header$ISA$`09`
#> [1] "231106"
#> 
#> $`837P_EX2_encounter`$Header$ISA$`10`
#> [1] "1418"
#> 
#> $`837P_EX2_encounter`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`837P_EX2_encounter`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`837P_EX2_encounter`$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $`837P_EX2_encounter`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`837P_EX2_encounter`$Header$ISA$`15`
#> [1] "T"
#> 
#> $`837P_EX2_encounter`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`837P_EX2_encounter`$Header$GS
#> $`837P_EX2_encounter`$Header$GS$`01`
#> [1] "HC"
#> 
#> $`837P_EX2_encounter`$Header$GS$`02`
#> [1] "SENDERGS"
#> 
#> $`837P_EX2_encounter`$Header$GS$`03`
#> [1] "RECEIVERGS"
#> 
#> $`837P_EX2_encounter`$Header$GS$`04`
#> [1] "20231106"
#> 
#> $`837P_EX2_encounter`$Header$GS$`05`
#> [1] "141815"
#> 
#> $`837P_EX2_encounter`$Header$GS$`06`
#> [1] "000000001"
#> 
#> $`837P_EX2_encounter`$Header$GS$`07`
#> [1] "X"
#> 
#> $`837P_EX2_encounter`$Header$GS$`08`
#> [1] "005010X222A1"
#> 
#> 
#> 
#> $`837P_EX2_encounter`$Transactions
#> $`837P_EX2_encounter`$Transactions[[1]]
#>  [1] "ST*837*0021*005010X222A1"                                 
#>  [2] "BHT*0019*00*0123*20061015*1023*RP"                        
#>  [3] "NM1*41*2*PREMIER BILLING SERVICE*****46*TGJ23"            
#>  [4] "PER*IC*JERRY*TE*3055552222*EX*231"                        
#>  [5] "NM1*40*2*AHLIC*****46*66783JJT"                           
#>  [6] "HL*1**20*1"                                               
#>  [7] "PRV*BI*PXC*203BF0100Y"                                    
#>  [8] "NM1*85*2*BEN KILDARE SERVICE*****XX*9876543210"           
#>  [9] "N3*234 SEAWAY ST"                                         
#> [10] "N4*MIAMI*FL*33111"                                        
#> [11] "REF*EI*587654321"                                         
#> [12] "NM1*87*2"                                                 
#> [13] "N3*2345 OCEAN BLVD"                                       
#> [14] "N4*MIAMI*FL*33111"                                        
#> [15] "HL*2*1*22*0"                                              
#> [16] "SBR*P*18*12312-A******HM"                                 
#> [17] "NM1*IL*1*SMITH*TED****MI*000221111"                       
#> [18] "N3*236 N MAIN ST"                                         
#> [19] "N4*MIAMI*FL*33413"                                        
#> [20] "DMG*D8*19430501*M"                                        
#> [21] "NM1*PR*2*ALLIANCE HEALTH AND LIFE INSURANCE*****PI*741234"
#> [22] "CLM*26462967*100***11>B>1*Y*A*Y*I"                        
#> [23] "DTP*431*D8*19981003"                                      
#> [24] "REF*D9*17312345600006351"                                 
#> [25] "HI*BK>0340*BF>V7389"                                      
#> [26] "NM1*77*2*KILDARE ASSOCIATES*****XX*5812345679"            
#> [27] "N3*2345 OCEAN BLVD"                                       
#> [28] "N4*MIAMI*FL*33111"                                        
#> [29] "LX*1"                                                     
#> [30] "SV1*HC>99213*40*UN*1***1"                                 
#> [31] "DTP*472*D8*20061003"                                      
#> [32] "LX*2"                                                     
#> [33] "SV1*HC>87072*15*UN*1***1"                                 
#> [34] "DTP*472*D8*20061003"                                      
#> [35] "LX*3"                                                     
#> [36] "SV1*HC>99214*35*UN*1***2"                                 
#> [37] "DTP*472*D8*20061010"                                      
#> [38] "LX*4"                                                     
#> [39] "SV1*HC>86663*10*UN*1***2"                                 
#> [40] "DTP*472*D8*20061010"                                      
#> 
#> 
#> $`837P_EX2_encounter`$Trailer
#> $`837P_EX2_encounter`$Trailer$SE
#> $`837P_EX2_encounter`$Trailer$SE$`01`
#> [1] "41"
#> 
#> $`837P_EX2_encounter`$Trailer$SE$`02`
#> [1] "0021"
#> 
#> 
#> $`837P_EX2_encounter`$Trailer$GE
#> $`837P_EX2_encounter`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`837P_EX2_encounter`$Trailer$GE$`02`
#> [1] "000000001"
#> 
#> 
#> $`837P_EX2_encounter`$Trailer$IEA
#> $`837P_EX2_encounter`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`837P_EX2_encounter`$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $`837P_EX3a_billing_provider_payer_a`
#> $`837P_EX3a_billing_provider_payer_a`$Header
#> $`837P_EX3a_billing_provider_payer_a`$Header$ISA
#> $`837P_EX3a_billing_provider_payer_a`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$ISA$`02`
#> [1] NA
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$ISA$`04`
#> [1] NA
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$ISA$`06`
#> [1] "SENDER"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$ISA$`08`
#> [1] "RECEIVER"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$ISA$`09`
#> [1] "231106"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$ISA$`10`
#> [1] "1420"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$ISA$`15`
#> [1] "T"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$GS
#> $`837P_EX3a_billing_provider_payer_a`$Header$GS$`01`
#> [1] "HC"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$GS$`02`
#> [1] "SENDERGS"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$GS$`03`
#> [1] "RECEIVERGS"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$GS$`04`
#> [1] "20231106"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$GS$`05`
#> [1] "142058"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$GS$`06`
#> [1] "000000001"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$GS$`07`
#> [1] "X"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Header$GS$`08`
#> [1] "005010X222A1"
#> 
#> 
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Transactions
#> $`837P_EX3a_billing_provider_payer_a`$Transactions[[1]]
#>  [1] "ST*837*0021*005010X222A1"                       
#>  [2] "BHT*0019*00*0123*20051015*1023*CH"              
#>  [3] "NM1*41*2*PREMIER BILLING SERVICE*****46*TGJ23"  
#>  [4] "PER*IC*JERRY*TE*3055552222"                     
#>  [5] "NM1*40*2*XYZ REPRICER*****46*66783JJT"          
#>  [6] "HL*1**20*1"                                     
#>  [7] "NM1*85*1*KILDARE*BEN****XX*1999996666"          
#>  [8] "N3*234 SEAWAY ST"                               
#>  [9] "N4*MIAMI*FL*33111"                              
#> [10] "REF*EI*123456789"                               
#> [11] "PER*IC*CONNIE*TE*3055551234"                    
#> [12] "NM1*87*2"                                       
#> [13] "N3*2345 OCEAN BLVD"                             
#> [14] "N4*MIAMI*FL*33111"                              
#> [15] "HL*2*1*22*1"                                    
#> [16] "SBR*P********CI"                                
#> [17] "NM1*IL*1*SMITH*JANE****MI*111223333"            
#> [18] "DMG*D8*19430501*F"                              
#> [19] "NM1*PR*2*KEY INSURANCE COMPANY*****PI*999996666"
#> [20] "N3*3333 OCEAN ST"                               
#> [21] "N4*SOUTH MIAMI*FL*33000"                        
#> [22] "REF*G2*PBS3334"                                 
#> [23] "HL*3*2*23*0"                                    
#> [24] "PAT*19"                                         
#> [25] "NM1*QC*1*SMITH*TED"                             
#> [26] "N3*236 N MAIN ST"                               
#> [27] "N4*MIAMI*FL*33413"                              
#> [28] "DMG*D8*19730501*M"                              
#> [29] "CLM*26407789*79.04***11>B>1*Y*A*Y*I*P"          
#> [30] "HI*BK>4779*BF>2724*BF>2780*BF>53081"            
#> [31] "NM1*82*1*KILDARE*BEN****XX*1999996666"          
#> [32] "PRV*PE*PXC*204C00000X"                          
#> [33] "REF*G2*KA6663"                                  
#> [34] "NM1*77*2*KILDARE ASSOCIATES*****XX*1581234567"  
#> [35] "N3*2345 OCEAN BLVD"                             
#> [36] "N4*MIAMI*FL*33111"                              
#> [37] "SBR*S*01*******CI"                              
#> [38] "OI***Y*P**Y"                                    
#> [39] "NM1*IL*1*SMITH*JACK****MI*T55TY666"             
#> [40] "N3*236 N MAIN ST"                               
#> [41] "N4*MIAMI*FL*33111"                              
#> [42] "NM1*PR*2*KEY INSURANCE COMPANY*****PI*999996666"
#> [43] "LX*1"                                           
#> [44] "SV1*HC>99213*43*UN*1***1>2>3>4"                 
#> [45] "DTP*472*D8*20051003"                            
#> [46] "LX*2"                                           
#> [47] "SV1*HC>90782*15*UN*1***1>2"                     
#> [48] "DTP*472*D8*20051003"                            
#> [49] "LX*3"                                           
#> [50] "SV1*HC>J3301*21.04*UN*1***1>2"                  
#> [51] "DTP*472*D8*20051003"                            
#> 
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Trailer
#> $`837P_EX3a_billing_provider_payer_a`$Trailer$SE
#> $`837P_EX3a_billing_provider_payer_a`$Trailer$SE$`01`
#> [1] "52"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Trailer$SE$`02`
#> [1] "0021"
#> 
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Trailer$GE
#> $`837P_EX3a_billing_provider_payer_a`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Trailer$GE$`02`
#> [1] "000000001"
#> 
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Trailer$IEA
#> $`837P_EX3a_billing_provider_payer_a`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $`837P_EX4_medicare_secondary_cob`
#> $`837P_EX4_medicare_secondary_cob`$Header
#> $`837P_EX4_medicare_secondary_cob`$Header$ISA
#> $`837P_EX4_medicare_secondary_cob`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$ISA$`02`
#> [1] NA
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$ISA$`04`
#> [1] NA
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$ISA$`06`
#> [1] "SENDER"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$ISA$`08`
#> [1] "RECEIVER"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$ISA$`09`
#> [1] "231106"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$ISA$`10`
#> [1] "1421"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$ISA$`15`
#> [1] "T"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$GS
#> $`837P_EX4_medicare_secondary_cob`$Header$GS$`01`
#> [1] "HC"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$GS$`02`
#> [1] "SENDERGS"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$GS$`03`
#> [1] "RECEIVERGS"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$GS$`04`
#> [1] "20231106"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$GS$`05`
#> [1] "142142"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$GS$`06`
#> [1] "000000001"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$GS$`07`
#> [1] "X"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Header$GS$`08`
#> [1] "005010X222A1"
#> 
#> 
#> 
#> $`837P_EX4_medicare_secondary_cob`$Transactions
#> $`837P_EX4_medicare_secondary_cob`$Transactions[[1]]
#>  [1] "ST*837*0002*005010X222A1"                   
#>  [2] "BHT*0019*00*000001142*20050214*115101*CH"   
#>  [3] "NM1*41*2*SPECIALISTS*****46*1111111"        
#>  [4] "PER*IC*SUE*TE*8005558888"                   
#>  [5] "NM1*40*2*MEDICARE PENNSYLVANIA*****46*10234"
#>  [6] "HL*1**20*1"                                 
#>  [7] "NM1*85*2*SPECIALISTS*****XX*0100000090"     
#>  [8] "N3*5 MAP COURT"                             
#>  [9] "N4*MAYNE*PA*17111"                          
#> [10] "REF*EI*890123456"                           
#> [11] "REF*1G*110101"                              
#> [12] "HL*2*1*22*0"                                
#> [13] "SBR*S*18*MEDICARE*12*****MB"                
#> [14] "NM1*IL*1*MEDYUM*WAYNE*M***MI*102200221B1"   
#> [15] "N3*1010 THOUSAND OAK LANE"                  
#> [16] "N4*MAYN*PA*17089"                           
#> [17] "DMG*D8*19560110*M"                          
#> [18] "NM1*PR*2*MEDICARE PENNSYLVANIA*****PI*10234"
#> [19] "N3*5232 MAYNE AVENUE"                       
#> [20] "N4*LYGHT*PA*17009"                          
#> [21] "CLM*101KEN6055*120***11>B>1*Y*A*Y*Y*P"      
#> [22] "HI*BK>71516*BF>71906"                       
#> [23] "NM1*DN*1*BRYHT*LEE*T"                       
#> [24] "REF*1G*B01010"                              
#> [25] "NM1*82*1*HENZES*JACK****XX*9090909090"      
#> [26] "PRV*PE*PXC*207X00000X"                      
#> [27] "REF*G2*110102CCC"                           
#> [28] "SBR*P*01**COMMERCE*****CI"                  
#> [29] "AMT*D*80"                                   
#> [30] "AMT*A8*15"                                  
#> [31] "OI***Y*P**Y"                                
#> [32] "NM1*IL*1*MEDYUM*CAROL****MI*COM188-404777"  
#> [33] "N3*PO BOX 45"                               
#> [34] "N4*MAYN*PA*17089"                           
#> [35] "NM1*PR*2*COMMERCE*****PI*59999"             
#> [36] "LX*1"                                       
#> [37] "SV1*HC>99203>25*120*UN*1***1>2"             
#> [38] "DTP*472*D8*20050119"                        
#> [39] "SVD*59999*80*HC>99203>25**1"                
#> [40] "CAS*CO*42*25"                               
#> [41] "CAS*PR*2*15"                                
#> [42] "DTP*573*D8*20050128"                        
#> 
#> 
#> $`837P_EX4_medicare_secondary_cob`$Trailer
#> $`837P_EX4_medicare_secondary_cob`$Trailer$SE
#> $`837P_EX4_medicare_secondary_cob`$Trailer$SE$`01`
#> [1] "43"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Trailer$SE$`02`
#> [1] "0002"
#> 
#> 
#> $`837P_EX4_medicare_secondary_cob`$Trailer$GE
#> $`837P_EX4_medicare_secondary_cob`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Trailer$GE$`02`
#> [1] "000000001"
#> 
#> 
#> $`837P_EX4_medicare_secondary_cob`$Trailer$IEA
#> $`837P_EX4_medicare_secondary_cob`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`837P_EX4_medicare_secondary_cob`$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $`837P_EX5_ambulance`
#> $`837P_EX5_ambulance`$Header
#> $`837P_EX5_ambulance`$Header$ISA
#> $`837P_EX5_ambulance`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`837P_EX5_ambulance`$Header$ISA$`02`
#> [1] NA
#> 
#> $`837P_EX5_ambulance`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`837P_EX5_ambulance`$Header$ISA$`04`
#> [1] NA
#> 
#> $`837P_EX5_ambulance`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`837P_EX5_ambulance`$Header$ISA$`06`
#> [1] "SENDER"
#> 
#> $`837P_EX5_ambulance`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`837P_EX5_ambulance`$Header$ISA$`08`
#> [1] "RECEIVER"
#> 
#> $`837P_EX5_ambulance`$Header$ISA$`09`
#> [1] "231106"
#> 
#> $`837P_EX5_ambulance`$Header$ISA$`10`
#> [1] "1422"
#> 
#> $`837P_EX5_ambulance`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`837P_EX5_ambulance`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`837P_EX5_ambulance`$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $`837P_EX5_ambulance`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`837P_EX5_ambulance`$Header$ISA$`15`
#> [1] "T"
#> 
#> $`837P_EX5_ambulance`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`837P_EX5_ambulance`$Header$GS
#> $`837P_EX5_ambulance`$Header$GS$`01`
#> [1] "HC"
#> 
#> $`837P_EX5_ambulance`$Header$GS$`02`
#> [1] "SENDERGS"
#> 
#> $`837P_EX5_ambulance`$Header$GS$`03`
#> [1] "RECEIVERGS"
#> 
#> $`837P_EX5_ambulance`$Header$GS$`04`
#> [1] "20231106"
#> 
#> $`837P_EX5_ambulance`$Header$GS$`05`
#> [1] "142212"
#> 
#> $`837P_EX5_ambulance`$Header$GS$`06`
#> [1] "000000001"
#> 
#> $`837P_EX5_ambulance`$Header$GS$`07`
#> [1] "X"
#> 
#> $`837P_EX5_ambulance`$Header$GS$`08`
#> [1] "005010X222A1"
#> 
#> 
#> 
#> $`837P_EX5_ambulance`$Transactions
#> $`837P_EX5_ambulance`$Transactions[[1]]
#>  [1] "ST*837*000017712*005010X222A1"                   
#>  [2] "BHT*0019*00*000017712*20050208*1112*CH"          
#>  [3] "NM1*41*2*AAA AMBULANCE SERVICE*****46*376985369" 
#>  [4] "PER*IC*LISA SMITH*TE*3037752536"                 
#>  [5] "NM1*40*2*MEDICARE B*****46*123245"               
#>  [6] "HL*1**20*1"                                      
#>  [7] "PRV*BI*PXC*3416L0300X"                           
#>  [8] "NM1*85*2*AAA AMBULANCE SERVICE*****XX*2366554859"
#>  [9] "N3*12202 AIRPORT WAY"                            
#> [10] "N4*BROOMFIELD*CO*800210021"                      
#> [11] "REF*EI*376985369"                                
#> [12] "HL*2*1*22*0"                                     
#> [13] "SBR*P*18*******MB"                               
#> [14] "NM1*IL*1*JONES*SARAH*A***MI*012345678A"          
#> [15] "N3*1129 REINDEER ROAD"                           
#> [16] "N4*CARR*CO*80612"                                
#> [17] "DMG*D8*19630729*F"                               
#> [18] "NM1*PR*2*MEDICARE PART B*****PI*123245"          
#> [19] "N3*PO BOX 3543"                                  
#> [20] "N4*BALTIMORE*MD*666013543"                       
#> [21] "CLM*051068*766.50***41>B>1*Y*A*Y*Y*P*OA"         
#> [22] "DTP*439*D8*20050208"                             
#> [23] "CR1*LB*275**A*DH*21****PATIENT IMOBILIZED"       
#> [24] "CRC*07*Y*04*06*09"                               
#> [25] "CRC*07*N*05*07*08"                               
#> [26] "HI*BK>8628*BF>E8888*BF>9592*BF>8540"             
#> [27] "NM1*PW*2"                                        
#> [28] "N3*1129 REINDEER ROAD"                           
#> [29] "N4*CARR*CO*80612"                                
#> [30] "NM1*45*2"                                        
#> [31] "N3*10005 BANNOCK ST"                             
#> [32] "N4*CHEYENNE*WY*82009"                            
#> [33] "LX*1"                                            
#> [34] "SV1*HC>A0427>RH*700*UN*1***1>2>3>4**Y"           
#> [35] "DTP*472*D8*20050208"                             
#> [36] "QTY*PT*2"                                        
#> [37] "REF*6R*1001"                                     
#> [38] "NTE*ADD*CARDIAC EMERGENCY"                       
#> [39] "LX*2"                                            
#> [40] "SV1*HC>A0425>RH*8.20*UN*21***1>2>3>4**Y"         
#> [41] "DTP*472*D8*20050208"                             
#> [42] "QTY*PT*2"                                        
#> [43] "REF*6R*1002"                                     
#> [44] "LX*3"                                            
#> [45] "SV1*HC>A0422>RH*46*UN*1***1>2>3>4**Y"            
#> [46] "DTP*472*D8*20050208"                             
#> [47] "REF*6R*1003"                                     
#> [48] "LX*4"                                            
#> [49] "SV1*HC>A0382>RH*12.30*UN*1***1>2>3>4**Y"         
#> [50] "DTP*472*D8*20050208"                             
#> [51] "REF*6R*1004"                                     
#> 
#> 
#> $`837P_EX5_ambulance`$Trailer
#> $`837P_EX5_ambulance`$Trailer$SE
#> $`837P_EX5_ambulance`$Trailer$SE$`01`
#> [1] "52"
#> 
#> $`837P_EX5_ambulance`$Trailer$SE$`02`
#> [1] "000017712"
#> 
#> 
#> $`837P_EX5_ambulance`$Trailer$GE
#> $`837P_EX5_ambulance`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`837P_EX5_ambulance`$Trailer$GE$`02`
#> [1] "000000001"
#> 
#> 
#> $`837P_EX5_ambulance`$Trailer$IEA
#> $`837P_EX5_ambulance`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`837P_EX5_ambulance`$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $`837P_EX6_chiropractic`
#> $`837P_EX6_chiropractic`$Header
#> $`837P_EX6_chiropractic`$Header$ISA
#> $`837P_EX6_chiropractic`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`837P_EX6_chiropractic`$Header$ISA$`02`
#> [1] NA
#> 
#> $`837P_EX6_chiropractic`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`837P_EX6_chiropractic`$Header$ISA$`04`
#> [1] NA
#> 
#> $`837P_EX6_chiropractic`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`837P_EX6_chiropractic`$Header$ISA$`06`
#> [1] "SENDER"
#> 
#> $`837P_EX6_chiropractic`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`837P_EX6_chiropractic`$Header$ISA$`08`
#> [1] "RECEIVER"
#> 
#> $`837P_EX6_chiropractic`$Header$ISA$`09`
#> [1] "231106"
#> 
#> $`837P_EX6_chiropractic`$Header$ISA$`10`
#> [1] "1422"
#> 
#> $`837P_EX6_chiropractic`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`837P_EX6_chiropractic`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`837P_EX6_chiropractic`$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $`837P_EX6_chiropractic`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`837P_EX6_chiropractic`$Header$ISA$`15`
#> [1] "T"
#> 
#> $`837P_EX6_chiropractic`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`837P_EX6_chiropractic`$Header$GS
#> $`837P_EX6_chiropractic`$Header$GS$`01`
#> [1] "HC"
#> 
#> $`837P_EX6_chiropractic`$Header$GS$`02`
#> [1] "SENDERGS"
#> 
#> $`837P_EX6_chiropractic`$Header$GS$`03`
#> [1] "RECEIVERGS"
#> 
#> $`837P_EX6_chiropractic`$Header$GS$`04`
#> [1] "20231106"
#> 
#> $`837P_EX6_chiropractic`$Header$GS$`05`
#> [1] "142242"
#> 
#> $`837P_EX6_chiropractic`$Header$GS$`06`
#> [1] "000000001"
#> 
#> $`837P_EX6_chiropractic`$Header$GS$`07`
#> [1] "X"
#> 
#> $`837P_EX6_chiropractic`$Header$GS$`08`
#> [1] "005010X222A1"
#> 
#> 
#> 
#> $`837P_EX6_chiropractic`$Transactions
#> $`837P_EX6_chiropractic`$Transactions[[1]]
#>  [1] "ST*837*3701*005010X222A1"                       
#>  [2] "BHT*0019*00*007227*20050215*075420*CH"          
#>  [3] "NM1*41*2*DAVID GREEN*****46*S01057"             
#>  [4] "PER*IC*KATHY SMITH*TE*4105558888"               
#>  [5] "NM1*40*2*MEDICARE PART B MARYLAND*****46*12345" 
#>  [6] "HL*1**20*1"                                     
#>  [7] "NM1*85*1*GREENE*DAVID*M***XX*1234567890"        
#>  [8] "N3*1264 OAKWOOD AVE"                            
#>  [9] "N4*BALTIMORE*MD*21236"                          
#> [10] "REF*EI*987654321"                               
#> [11] "PER*IC*DR*TE*4105551212"                        
#> [12] "HL*2*1*22*0"                                    
#> [13] "SBR*P*18*******MB"                              
#> [14] "NM1*IL*1*WILLIAMSON*MATTHEW*J***MI*123456789A"  
#> [15] "N3*128 BROADCREEK"                              
#> [16] "N4*BALTIMORE*MD*21234"                          
#> [17] "DMG*D8*19250110*M"                              
#> [18] "NM1*PR*2*MEDICARE PART B MARYLAND*****PI*C12345"
#> [19] "CLM*125WILL*145.5***11>B>1*Y*A*Y*Y"             
#> [20] "DTP*454*D8*20050115"                            
#> [21] "DTP*453*D8*20050110"                            
#> [22] "DTP*455*D8*20050113"                            
#> [23] "CR2********A**CHRONIC PAIN AND DISCOMFORT"      
#> [24] "HI*BK>7215"                                     
#> [25] "LX*1"                                           
#> [26] "SV1*HC>98940*145.5*UN*1***1"                    
#> [27] "DTP*472*D8*20050215"                            
#> [28] "REF*6R*01"                                      
#> 
#> 
#> $`837P_EX6_chiropractic`$Trailer
#> $`837P_EX6_chiropractic`$Trailer$SE
#> $`837P_EX6_chiropractic`$Trailer$SE$`01`
#> [1] "29"
#> 
#> $`837P_EX6_chiropractic`$Trailer$SE$`02`
#> [1] "3701"
#> 
#> 
#> $`837P_EX6_chiropractic`$Trailer$GE
#> $`837P_EX6_chiropractic`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`837P_EX6_chiropractic`$Trailer$GE$`02`
#> [1] "000000001"
#> 
#> 
#> $`837P_EX6_chiropractic`$Trailer$IEA
#> $`837P_EX6_chiropractic`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`837P_EX6_chiropractic`$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $`837P_EX7_oxygen`
#> $`837P_EX7_oxygen`$Header
#> $`837P_EX7_oxygen`$Header$ISA
#> $`837P_EX7_oxygen`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`837P_EX7_oxygen`$Header$ISA$`02`
#> [1] NA
#> 
#> $`837P_EX7_oxygen`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`837P_EX7_oxygen`$Header$ISA$`04`
#> [1] NA
#> 
#> $`837P_EX7_oxygen`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`837P_EX7_oxygen`$Header$ISA$`06`
#> [1] "SENDER"
#> 
#> $`837P_EX7_oxygen`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`837P_EX7_oxygen`$Header$ISA$`08`
#> [1] "RECEIVER"
#> 
#> $`837P_EX7_oxygen`$Header$ISA$`09`
#> [1] "231106"
#> 
#> $`837P_EX7_oxygen`$Header$ISA$`10`
#> [1] "1423"
#> 
#> $`837P_EX7_oxygen`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`837P_EX7_oxygen`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`837P_EX7_oxygen`$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $`837P_EX7_oxygen`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`837P_EX7_oxygen`$Header$ISA$`15`
#> [1] "T"
#> 
#> $`837P_EX7_oxygen`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`837P_EX7_oxygen`$Header$GS
#> $`837P_EX7_oxygen`$Header$GS$`01`
#> [1] "HC"
#> 
#> $`837P_EX7_oxygen`$Header$GS$`02`
#> [1] "SENDERGS"
#> 
#> $`837P_EX7_oxygen`$Header$GS$`03`
#> [1] "RECEIVERGS"
#> 
#> $`837P_EX7_oxygen`$Header$GS$`04`
#> [1] "20231106"
#> 
#> $`837P_EX7_oxygen`$Header$GS$`05`
#> [1] "142340"
#> 
#> $`837P_EX7_oxygen`$Header$GS$`06`
#> [1] "000000001"
#> 
#> $`837P_EX7_oxygen`$Header$GS$`07`
#> [1] "X"
#> 
#> $`837P_EX7_oxygen`$Header$GS$`08`
#> [1] "005010X222A1"
#> 
#> 
#> 
#> $`837P_EX7_oxygen`$Transactions
#> $`837P_EX7_oxygen`$Transactions[[1]]
#>  [1] "ST*837*0001*005010X222A1"                          
#>  [2] "BHT*0019*00*16*20050326*1036*CH"                   
#>  [3] "NM1*41*2*OXYGEN SUPPLY COMPANY*****46*ABC11111"    
#>  [4] "PER*IC*BONNIE*TE*8125551111*EM*HELPDESK@OXYGEN.COM"
#>  [5] "NM1*40*2*DMERC CARRIER*****46*99999"               
#>  [6] "HL*1**20*1"                                        
#>  [7] "NM1*85*2*OXYGEN SUPPLY COMPANY*****XX*9992233334"  
#>  [8] "N3*1800 EAST RIDGE DRIVE"                          
#>  [9] "N4*RICHMOND*IN*46224"                              
#> [10] "REF*EI*389999999"                                  
#> [11] "HL*2*1*22*0"                                       
#> [12] "SBR*P*18*******MB"                                 
#> [13] "NM1*IL*1*SMITH*TERRY****MI*111222333A"             
#> [14] "N3*121 SOUTH ST"                                   
#> [15] "N4*RICHMOND*IN*46236"                              
#> [16] "DMG*D8*19380105*F"                                 
#> [17] "NM1*PR*2*DMERC CARRIER*****PI*99999"               
#> [18] "CLM*R03996273 #01*520.24***11>B>1*Y*A*Y*Y"         
#> [19] "HI*BK>496*BF>51881*BF>2859"                        
#> [20] "LX*1"                                              
#> [21] "SV1*HC>E1390>RR*461.1*UN*1***1>2"                  
#> [22] "PWK*CT*AD"                                         
#> [23] "CR3*R*MO*99"                                       
#> [24] "DTP*472*RD8*20050321-20050321"                     
#> [25] "DTP*607*D8*20050321"                               
#> [26] "DTP*463*D8*20040321"                               
#> [27] "DTP*461*D8*20050321"                               
#> [28] "NM1*DK*1*WILSON*LARRY****XX*5555511111"            
#> [29] "N3*1212 NORTH MERIDIAN"                            
#> [30] "N4*RICHMOND*IN*46223"                              
#> [31] "REF*1G*X99999"                                     
#> [32] "PER*IC*LEE*TE*5554446666"                          
#> [33] "LQ*UT*04.03"                                       
#> [34] "FRM*1A**056"                                       
#> [35] "FRM*1C**20050228"                                  
#> [36] "FRM*2**1"                                          
#> [37] "FRM*3**1"                                          
#> [38] "FRM*4*Y"                                           
#> [39] "FRM*5**2"                                          
#> [40] "FRM*7*Y"                                           
#> [41] "FRM*8*N"                                           
#> [42] "FRM*9*Y"                                           
#> [43] "LX*2"                                              
#> [44] "SV1*HC>E0431>RR*59.14*UN*1***1>2"                  
#> [45] "PWK*CT*AD"                                         
#> [46] "CR3*R*MO*99"                                       
#> [47] "DTP*472*RD8*20050321-20050321"                     
#> [48] "DTP*607*D8*20050321"                               
#> [49] "DTP*463*D8*20040321"                               
#> [50] "DTP*461*D8*20050321"                               
#> [51] "NM1*DK*1*WILSON*LARRY****XX*5555511111"            
#> [52] "N3*1212 NORTH MERIDIAN"                            
#> [53] "N4*RICHMOND*IN*46223"                              
#> [54] "REF*1G*X99999"                                     
#> [55] "PER*IC*LEE*TE*5554446666"                          
#> [56] "LQ*UT*04.03"                                       
#> [57] "FRM*1A**056"                                       
#> [58] "FRM*1C**20050228"                                  
#> [59] "FRM*2**1"                                          
#> [60] "FRM*3**1"                                          
#> [61] "FRM*4*Y"                                           
#> [62] "FRM*5**2"                                          
#> [63] "FRM*7*Y"                                           
#> [64] "FRM*8*N"                                           
#> [65] "FRM*9*Y"                                           
#> 
#> 
#> $`837P_EX7_oxygen`$Trailer
#> $`837P_EX7_oxygen`$Trailer$SE
#> $`837P_EX7_oxygen`$Trailer$SE$`01`
#> [1] "66"
#> 
#> $`837P_EX7_oxygen`$Trailer$SE$`02`
#> [1] "0001"
#> 
#> 
#> $`837P_EX7_oxygen`$Trailer$GE
#> $`837P_EX7_oxygen`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`837P_EX7_oxygen`$Trailer$GE$`02`
#> [1] "000000001"
#> 
#> 
#> $`837P_EX7_oxygen`$Trailer$IEA
#> $`837P_EX7_oxygen`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`837P_EX7_oxygen`$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $`837P_EX8_wheelchair`
#> $`837P_EX8_wheelchair`$Header
#> $`837P_EX8_wheelchair`$Header$ISA
#> $`837P_EX8_wheelchair`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`837P_EX8_wheelchair`$Header$ISA$`02`
#> [1] NA
#> 
#> $`837P_EX8_wheelchair`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`837P_EX8_wheelchair`$Header$ISA$`04`
#> [1] NA
#> 
#> $`837P_EX8_wheelchair`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`837P_EX8_wheelchair`$Header$ISA$`06`
#> [1] "SENDER"
#> 
#> $`837P_EX8_wheelchair`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`837P_EX8_wheelchair`$Header$ISA$`08`
#> [1] "RECEIVER"
#> 
#> $`837P_EX8_wheelchair`$Header$ISA$`09`
#> [1] "231106"
#> 
#> $`837P_EX8_wheelchair`$Header$ISA$`10`
#> [1] "1424"
#> 
#> $`837P_EX8_wheelchair`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`837P_EX8_wheelchair`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`837P_EX8_wheelchair`$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $`837P_EX8_wheelchair`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`837P_EX8_wheelchair`$Header$ISA$`15`
#> [1] "T"
#> 
#> $`837P_EX8_wheelchair`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`837P_EX8_wheelchair`$Header$GS
#> $`837P_EX8_wheelchair`$Header$GS$`01`
#> [1] "HC"
#> 
#> $`837P_EX8_wheelchair`$Header$GS$`02`
#> [1] "SENDERGS"
#> 
#> $`837P_EX8_wheelchair`$Header$GS$`03`
#> [1] "RECEIVERGS"
#> 
#> $`837P_EX8_wheelchair`$Header$GS$`04`
#> [1] "20231106"
#> 
#> $`837P_EX8_wheelchair`$Header$GS$`05`
#> [1] "142406"
#> 
#> $`837P_EX8_wheelchair`$Header$GS$`06`
#> [1] "000000001"
#> 
#> $`837P_EX8_wheelchair`$Header$GS$`07`
#> [1] "X"
#> 
#> $`837P_EX8_wheelchair`$Header$GS$`08`
#> [1] "005010X222A1"
#> 
#> 
#> 
#> $`837P_EX8_wheelchair`$Transactions
#> $`837P_EX8_wheelchair`$Transactions[[1]]
#>  [1] "ST*837*112233*005010X222A1"                   
#>  [2] "BHT*0019*00*16*20050326*1036*CH"              
#>  [3] "NM1*41*2*XYZ WHEELCHAIRS INC*****46*ABC55"    
#>  [4] "PER*IC*JANE*TE*2225551111"                    
#>  [5] "NM1*40*2*DMERC CARRIER*****46*99999"          
#>  [6] "HL*1**20*1"                                   
#>  [7] "NM1*85*2*XYZ WHEELCHAIR INC*****XX*7778889999"
#>  [8] "N3*1440 NORTH STREET"                         
#>  [9] "N4*LAFAYETTE*IN*47904"                        
#> [10] "REF*EI*123567989"                             
#> [11] "REF*1G*0426960001"                            
#> [12] "HL*2*1*22*0"                                  
#> [13] "SBR*P*18*******MB"                            
#> [14] "PAT*******01*155"                             
#> [15] "NM1*IL*1*SMITH*JAMES****MI*987654321A"        
#> [16] "N3*12 MAIN ST"                                
#> [17] "N4*FRANKFORT*IN*46209"                        
#> [18] "DMG*D8*19201023*M"                            
#> [19] "NM1*PR*2*DMERC CARRIER*****PI*99999"          
#> [20] "CLM*SMI123*75***12>B>1*Y*A*Y*Y"               
#> [21] "HI*BK>436*BF>3449"                            
#> [22] "LX*1"                                         
#> [23] "SV1*HC>K0001>RR>KH>BR*75*UN*1***1>2"          
#> [24] "PWK*CT*AD"                                    
#> [25] "CR3*I*MO*99"                                  
#> [26] "DTP*472*RD8*20050321-20050321"                
#> [27] "DTP*463*D8*20040321"                          
#> [28] "DTP*461*D8*20050321"                          
#> [29] "MEA*TR*HT*70"                                 
#> [30] "NM1*DK*1*WILSON*RANDALL****XX*1111155555"     
#> [31] "N3*1226 WEST RAILROAD STREET"                 
#> [32] "N4*LAFAYETTE*IN*47905"                        
#> [33] "REF*1G*M12345"                                
#> [34] "PER*IC*LEE*TE*7659259999"                     
#> [35] "LQ*UT*02.03B"                                 
#> [36] "FRM*1*Y"                                      
#> [37] "FRM*2*N"                                      
#> [38] "FRM*3*N"                                      
#> [39] "FRM*4*N"                                      
#> [40] "FRM*5**8"                                     
#> [41] "FRM*8*N"                                      
#> [42] "FRM*9*Y"                                      
#> 
#> 
#> $`837P_EX8_wheelchair`$Trailer
#> $`837P_EX8_wheelchair`$Trailer$SE
#> $`837P_EX8_wheelchair`$Trailer$SE$`01`
#> [1] "43"
#> 
#> $`837P_EX8_wheelchair`$Trailer$SE$`02`
#> [1] "112233"
#> 
#> 
#> $`837P_EX8_wheelchair`$Trailer$GE
#> $`837P_EX8_wheelchair`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`837P_EX8_wheelchair`$Trailer$GE$`02`
#> [1] "000000001"
#> 
#> 
#> $`837P_EX8_wheelchair`$Trailer$IEA
#> $`837P_EX8_wheelchair`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`837P_EX8_wheelchair`$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $`837P_EX9_anesthesia`
#> $`837P_EX9_anesthesia`$Header
#> $`837P_EX9_anesthesia`$Header$ISA
#> $`837P_EX9_anesthesia`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`837P_EX9_anesthesia`$Header$ISA$`02`
#> [1] NA
#> 
#> $`837P_EX9_anesthesia`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`837P_EX9_anesthesia`$Header$ISA$`04`
#> [1] NA
#> 
#> $`837P_EX9_anesthesia`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`837P_EX9_anesthesia`$Header$ISA$`06`
#> [1] "SENDER"
#> 
#> $`837P_EX9_anesthesia`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`837P_EX9_anesthesia`$Header$ISA$`08`
#> [1] "RECEIVER"
#> 
#> $`837P_EX9_anesthesia`$Header$ISA$`09`
#> [1] "231106"
#> 
#> $`837P_EX9_anesthesia`$Header$ISA$`10`
#> [1] "1424"
#> 
#> $`837P_EX9_anesthesia`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`837P_EX9_anesthesia`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`837P_EX9_anesthesia`$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $`837P_EX9_anesthesia`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`837P_EX9_anesthesia`$Header$ISA$`15`
#> [1] "T"
#> 
#> $`837P_EX9_anesthesia`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`837P_EX9_anesthesia`$Header$GS
#> $`837P_EX9_anesthesia`$Header$GS$`01`
#> [1] "HC"
#> 
#> $`837P_EX9_anesthesia`$Header$GS$`02`
#> [1] "SENDERGS"
#> 
#> $`837P_EX9_anesthesia`$Header$GS$`03`
#> [1] "RECEIVERGS"
#> 
#> $`837P_EX9_anesthesia`$Header$GS$`04`
#> [1] "20231106"
#> 
#> $`837P_EX9_anesthesia`$Header$GS$`05`
#> [1] "142432"
#> 
#> $`837P_EX9_anesthesia`$Header$GS$`06`
#> [1] "000000001"
#> 
#> $`837P_EX9_anesthesia`$Header$GS$`07`
#> [1] "X"
#> 
#> $`837P_EX9_anesthesia`$Header$GS$`08`
#> [1] "005010X222A1"
#> 
#> 
#> 
#> $`837P_EX9_anesthesia`$Transactions
#> $`837P_EX9_anesthesia`$Transactions[[1]]
#>  [1] "ST*837*0001*005010X222A1"                         
#>  [2] "BHT*0019*00*0123*20050117*1023*CH"                
#>  [3] "NM1*41*2*PROVIDER MEDICAL GROUP*****46*N305"      
#>  [4] "PER*IC*NINA*TE*6155551212*EX*911"                 
#>  [5] "NM1*40*2*ABC PAYER*****46*05440"                  
#>  [6] "HL*1**20*1"                                       
#>  [7] "NM1*85*2*PROVIDER MEDICAL GROUP*****XX*2366554859"
#>  [8] "N3*1234 WEST END AVE"                             
#>  [9] "N4*NASHVILLE*TN*37232"                            
#> [10] "REF*EI*756473826"                                 
#> [11] "HL*2*1*22*0"                                      
#> [12] "SBR*P*18*******MB"                                
#> [13] "NM1*IL*1*JONES*MARGARET****MI*123456789A"         
#> [14] "N3*123 RAINBOW ROAD"                              
#> [15] "N4*NASHVILLE*TN*37232"                            
#> [16] "DMG*D8*19740303*F"                                
#> [17] "NM1*PR*2*ABC PAYER*****PI*05440"                  
#> [18] "CLM*153829140*827***22>B>1*Y*A*Y*Y"               
#> [19] "HI*BK>36616"                                      
#> [20] "NM1*82*1*TOWNSEND*JACOB*E***XX*5678912345"        
#> [21] "PRV*PE*PXC*207L00000X"                            
#> [22] "REF*G2*9741234"                                   
#> [23] "NM1*77*2*PROVIDER OP HOSP*****XX*432198765"       
#> [24] "N3*345 MAIN DRIVE"                                
#> [25] "N4*NASHVILLE*TN*37232"                            
#> [26] "LX*1"                                             
#> [27] "SV1*HC>00142>QK>QS>P1*827*MJ*61***1"              
#> [28] "DTP*472*D8*20050112"                              
#> 
#> 
#> $`837P_EX9_anesthesia`$Trailer
#> $`837P_EX9_anesthesia`$Trailer$SE
#> $`837P_EX9_anesthesia`$Trailer$SE$`01`
#> [1] "29"
#> 
#> $`837P_EX9_anesthesia`$Trailer$SE$`02`
#> [1] "0001"
#> 
#> 
#> $`837P_EX9_anesthesia`$Trailer$GE
#> $`837P_EX9_anesthesia`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`837P_EX9_anesthesia`$Trailer$GE$`02`
#> [1] "000000001"
#> 
#> 
#> $`837P_EX9_anesthesia`$Trailer$IEA
#> $`837P_EX9_anesthesia`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`837P_EX9_anesthesia`$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $sample_837P
#> [1] NA
#> 
#> $sample_837_0
#> $sample_837_0$Header
#> $sample_837_0$Header$ISA
#> $sample_837_0$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_837_0$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_837_0$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_837_0$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_837_0$Header$ISA$`05`
#> [1] "01"
#> 
#> $sample_837_0$Header$ISA$`06`
#> [1] "987654321"
#> 
#> $sample_837_0$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $sample_837_0$Header$ISA$`08`
#> [1] "123456789"
#> 
#> $sample_837_0$Header$ISA$`09`
#> [1] "180508"
#> 
#> $sample_837_0$Header$ISA$`10`
#> [1] "0833"
#> 
#> $sample_837_0$Header$ISA$`11`
#> [1] "^"
#> 
#> $sample_837_0$Header$ISA$`12`
#> [1] "00501"
#> 
#> $sample_837_0$Header$ISA$`13`
#> [1] "697773230"
#> 
#> $sample_837_0$Header$ISA$`14`
#> [1] "1"
#> 
#> $sample_837_0$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_837_0$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_837_0$Header$GS
#> $sample_837_0$Header$GS$`01`
#> [1] "HC"
#> 
#> $sample_837_0$Header$GS$`02`
#> [1] "CLEARINGHOUSE"
#> 
#> $sample_837_0$Header$GS$`03`
#> [1] "123456789"
#> 
#> $sample_837_0$Header$GS$`04`
#> [1] "20180508"
#> 
#> $sample_837_0$Header$GS$`05`
#> [1] "0833"
#> 
#> $sample_837_0$Header$GS$`06`
#> [1] "212950697"
#> 
#> $sample_837_0$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_837_0$Header$GS$`08`
#> [1] "005010X222A1"
#> 
#> 
#> 
#> $sample_837_0$Transactions
#> $sample_837_0$Transactions[[1]]
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
#> 
#> $sample_837_0$Transactions[[2]]
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
#> 
#> $sample_837_0$Transactions[[3]]
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
#> 
#> $sample_837_0$Transactions[[4]]
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
#> 
#> $sample_837_0$Transactions[[5]]
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
#> 
#> 
#> $sample_837_0$Trailer
#> $sample_837_0$Trailer$SE
#> $sample_837_0$Trailer$SE$`01`
#> [1] "34"
#> 
#> $sample_837_0$Trailer$SE$`02`
#> [1] "000000001"
#> 
#> 
#> $sample_837_0$Trailer$GE
#> $sample_837_0$Trailer$GE$`01`
#> [1] "5"
#> 
#> $sample_837_0$Trailer$GE$`02`
#> [1] "212950697"
#> 
#> 
#> $sample_837_0$Trailer$IEA
#> $sample_837_0$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_837_0$Trailer$IEA$`02`
#> [1] "697773230"
#> 
#> 
#> 
#> 
#> $sample_837_11
#> $sample_837_11$Header
#> $sample_837_11$Header$ISA
#> $sample_837_11$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_837_11$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_837_11$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_837_11$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_837_11$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $sample_837_11$Header$ISA$`06`
#> [1] "SUBMITTER ID"
#> 
#> $sample_837_11$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $sample_837_11$Header$ISA$`08`
#> [1] "RECEIVER ID"
#> 
#> $sample_837_11$Header$ISA$`09`
#> [1] "230516"
#> 
#> $sample_837_11$Header$ISA$`10`
#> [1] "1145"
#> 
#> $sample_837_11$Header$ISA$`11`
#> [1] "^"
#> 
#> $sample_837_11$Header$ISA$`12`
#> [1] "00501"
#> 
#> $sample_837_11$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $sample_837_11$Header$ISA$`14`
#> [1] "0"
#> 
#> $sample_837_11$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_837_11$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_837_11$Header$GS
#> $sample_837_11$Header$GS$`01`
#> [1] "HC"
#> 
#> $sample_837_11$Header$GS$`02`
#> [1] "SUBMITTER ID"
#> 
#> $sample_837_11$Header$GS$`03`
#> [1] "RECEIVER ID"
#> 
#> $sample_837_11$Header$GS$`04`
#> [1] "20230516"
#> 
#> $sample_837_11$Header$GS$`05`
#> [1] "1145"
#> 
#> $sample_837_11$Header$GS$`06`
#> [1] "1"
#> 
#> $sample_837_11$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_837_11$Header$GS$`08`
#> [1] "005010X222A1"
#> 
#> 
#> 
#> $sample_837_11$Transactions
#> $sample_837_11$Transactions[[1]]
#>  [1] "ST*837*0001*005010X222A1"                   
#>  [2] "BHT*0019*00*244579*20230516*1145*CH"        
#>  [3] "NM1*41*2*SUBMIT CLINIC*****46*12345"        
#>  [4] "PER*IC*CONTACT NAME*TE*5555550000"          
#>  [5] "NM1*40*2*RECEIVER NAME*****46*67890"        
#>  [6] "HL*1**20*1"                                 
#>  [7] "NM1*85*2*BILLING PROVIDER*****XX*1234567893"
#>  [8] "N3*123 TEST STREET"                         
#>  [9] "N4*TESTCITY*GA*00000"                       
#> [10] "REF*EI*123456789"                           
#> [11] "HL*2*1*22*0"                                
#> [12] "SBR*P*18*******MC"                          
#> [13] "NM1*IL*1*DOE*JOHN****MI*12345678901"        
#> [14] "N3*123 TEST STREET"                         
#> [15] "N4*TESTCITY*GA*00000"                       
#> [16] "DMG*D8*19000101*M"                          
#> [17] "CLM*12345*150.00***11:B:1*Y*A*Y*Y"          
#> [18] "HI*ABK:I109"                                
#> [19] "NM1*82*1*PROVIDER*JANE****XX*9876543210"    
#> [20] "PRV*PE*ZZ*207RC0000X"                       
#> [21] "SV1*HC:J1745*150.00*UN*2*11***1"            
#> [22] "DTP*472*D8*20230515"                        
#> [23] "LIN**N4*50242004001"                        
#> [24] "CTP***2*150.00"                             
#> 
#> 
#> $sample_837_11$Trailer
#> $sample_837_11$Trailer$SE
#> $sample_837_11$Trailer$SE$`01`
#> [1] "24"
#> 
#> $sample_837_11$Trailer$SE$`02`
#> [1] "0001"
#> 
#> 
#> $sample_837_11$Trailer$GE
#> $sample_837_11$Trailer$GE$`01`
#> [1] "1"
#> 
#> $sample_837_11$Trailer$GE$`02`
#> [1] "1"
#> 
#> 
#> $sample_837_11$Trailer$IEA
#> $sample_837_11$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_837_11$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $sample_837_12
#> $sample_837_12$Header
#> $sample_837_12$Header$ISA
#> $sample_837_12$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_837_12$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_837_12$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_837_12$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_837_12$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $sample_837_12$Header$ISA$`06`
#> [1] "SUBMITTER ID"
#> 
#> $sample_837_12$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $sample_837_12$Header$ISA$`08`
#> [1] "RECEIVER ID"
#> 
#> $sample_837_12$Header$ISA$`09`
#> [1] "230516"
#> 
#> $sample_837_12$Header$ISA$`10`
#> [1] "1145"
#> 
#> $sample_837_12$Header$ISA$`11`
#> [1] "^"
#> 
#> $sample_837_12$Header$ISA$`12`
#> [1] "00501"
#> 
#> $sample_837_12$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $sample_837_12$Header$ISA$`14`
#> [1] "0"
#> 
#> $sample_837_12$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_837_12$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_837_12$Header$GS
#> $sample_837_12$Header$GS$`01`
#> [1] "HC"
#> 
#> $sample_837_12$Header$GS$`02`
#> [1] "SUBMITTER ID"
#> 
#> $sample_837_12$Header$GS$`03`
#> [1] "RECEIVER ID"
#> 
#> $sample_837_12$Header$GS$`04`
#> [1] "20230516"
#> 
#> $sample_837_12$Header$GS$`05`
#> [1] "1145"
#> 
#> $sample_837_12$Header$GS$`06`
#> [1] "1"
#> 
#> $sample_837_12$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_837_12$Header$GS$`08`
#> [1] "005010X222A1"
#> 
#> 
#> 
#> $sample_837_12$Transactions
#> $sample_837_12$Transactions[[1]]
#>  [1] "ST*837*0001*005010X222A1"                              
#>  [2] "BHT*0019*00*244579*20230516*1145*CH"                   
#>  [3] "NM1*41*2*SUBMIT CLINIC*****46*12345"                   
#>  [4] "PER*IC*TEST CONTACT*TE*5555550000"                     
#>  [5] "NM1*40*2*RECEIVER NAME*****46*67890"                   
#>  [6] "HL*1**20*1"                                            
#>  [7] "NM1*85*2*BILLING PROVIDER*****XX*1234567893"           
#>  [8] "N3*123 BILLING ST"                                     
#>  [9] "N4*CITY*GA*30001"                                      
#> [10] "REF*EI*123456789"                                      
#> [11] "HL*2*1*22*0"                                           
#> [12] "SBR*P*18*******MC"                                     
#> [13] "NM1*IL*1*TESTLAST01*TESTFIRST01****MI*TESTMBR000000001"
#> [14] "N3*123 TEST STREET"                                    
#> [15] "N4*TESTCITY*CA*00000"                                  
#> [16] "DMG*D8*19000101*M"                                     
#> [17] "CLM*12345*150.00***11:B:1*Y*A*Y*Y"                     
#> [18] "HI*ABK:I109"                                           
#> [19] "NM1*82*1*PROVIDER*JANE****XX*9876543210"               
#> [20] "PRV*PE*ZZ*207RC0000X"                                  
#> [21] "SV1*HC:J1745*150.00*UN*2*11***1"                       
#> [22] "DTP*472*D8*20230515"                                   
#> [23] "LIN**N4*50242004001"                                   
#> [24] "CTP***2*150.00"                                        
#> 
#> $sample_837_12$Transactions[[2]]
#>  [1] "ST*837*5856*005010X223A2"                              
#>  [2] "BHT*0019*00*241205204222*20241205*2042*CH"             
#>  [3] "NM1*41*2*HSA PORT ARTHUR, LLC*****XX*1194548073"       
#>  [4] "PER*IC*TEST CONTACT*TE*5555550000"                     
#>  [5] "NM1*40*2*OptimaFourSight*****XX*89242VA018"            
#>  [6] "PER*IC*TEST CONTACT*TE*5555550000"                     
#>  [7] "HL*1**20*1"                                            
#>  [8] "NM1*85*2*HSA PORT ARTHUR, LLC*****XX*1194548073"       
#>  [9] "N3*505 N BRAND BLVD STE 1200"                          
#> [10] "N4*GLENDALE*CA*91203"                                  
#> [11] "REF*EI*71-3391736"                                     
#> [12] "PER*IC*TEST CONTACT*TE*5555550000"                     
#> [13] "HL*2*1*22*0"                                           
#> [14] "SBR*P*18*731323546******CI"                            
#> [15] "NM1*IL*1*TESTLAST02*TESTFIRST02****MI*TESTMBR000000002"
#> [16] "N3*123 TEST STREET"                                    
#> [17] "N4*TESTCITY*CA*00000"                                  
#> [18] "CLM*4742333269*128***11:B:1*Y*A*Y*I"                   
#> [19] "DTP*434*RD8*20240422-20240430"                         
#> [20] "DTP*435*D8*20240809"                                   
#> [21] "DTP*096*TM*2337"                                       
#> [22] "HI*ABK:W214XXA"                                        
#> [23] "HI*ABK:S31813D"                                        
#> [24] "HI*ABK:V0492XD"                                        
#> [25] "HI*ABK:T498X6A"                                        
#> [26] "LX*1"                                                  
#> [27] "SV1*HC:37180*93*UN*1***3:4:1***"                       
#> [28] "DTP*472*D8*20180428"                                   
#> [29] "REF*6R*142671"                                         
#> [30] "LX*2"                                                  
#> [31] "SV1*HC:24000*4*UN*1***1:3:4***"                        
#> [32] "DTP*472*D8*20180428"                                   
#> [33] "REF*6R*142671"                                         
#> [34] "LX*3"                                                  
#> [35] "SV1*HC:16035*31*UN*1***3***"                           
#> [36] "DTP*472*D8*20180428"                                   
#> [37] "REF*6R*142671"                                         
#> 
#> $sample_837_12$Transactions[[3]]
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
#> [15] "NM1*IL*1*TESTLAST03*TESTFIRST03****MI*TESTMBR000000003"           
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
#> 
#> 
#> $sample_837_12$Trailer
#> $sample_837_12$Trailer$SE
#> $sample_837_12$Trailer$SE$`01`
#> [1] "24"
#> 
#> $sample_837_12$Trailer$SE$`02`
#> [1] "0001"
#> 
#> 
#> $sample_837_12$Trailer$GE
#> $sample_837_12$Trailer$GE$`01`
#> [1] "1"
#> 
#> $sample_837_12$Trailer$GE$`02`
#> [1] "1"
#> 
#> 
#> $sample_837_12$Trailer$IEA
#> $sample_837_12$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_837_12$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
```
