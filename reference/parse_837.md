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
index_837(text)

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
purrr::map(hcc::x12_837I, index_837)
#> $`837I_EX1a_institutional_claim`
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1234     
#>   Segments: 46       
#>   Problems: 1        
#>  
#> ISA[1]: 1                           
#>  GS[1]: 2                           
#>  ST[1]: 3                           
#> BPR[1]: 4                           
#> NM1[8]: 5, 7, 10, 17, 21, 31, 35, 38
#> PER[2]: 6, 14                       
#>  HL[2]: 8, 15                       
#>  N3[3]: 11, 18, 36                  
#>  N4[3]: 12, 19, 37                  
#> REF[3]: 13, 22, 32                  
#> SBR[2]: 16, 33                      
#> DMG[1]: 20                          
#>  OI[1]: 34                          
#> CLM[1]: 23                          
#>  HI[5]: 26, 27, 28, 29, 30          
#> PRV[1]: 9                           
#>  LX[2]: 39, 42                      
#> SV2[2]: 40, 43                      
#> DTP[3]: 24, 41, 44                  
#>  SE[1]: 45                          
#>  GE[1]: 46                          
#> IEA[1]: 47                          
#> 
#> $`837I_EX1b_2claims_1provider`
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1273     
#>   Segments: 50       
#>   Problems: 2        
#>  
#> ISA[1]: 1                               
#>  GS[1]: 2                               
#>  ST[1]: 3                               
#> BPR[1]: 4                               
#> NM1[9]: 5, 7, 10, 16, 20, 26, 36, 40, 45
#> PER[1]: 6                               
#>  HL[3]: 8, 14, 34                       
#>  N3[3]: 11, 17, 37                      
#>  N4[3]: 12, 18, 38                      
#> REF[2]: 13, 27                          
#> SBR[2]: 15, 35                          
#> DMG[2]: 19, 39                          
#> CLM[2]: 21, 41                          
#>  HI[3]: 24, 25, 44                      
#> PRV[2]: 9, 46                           
#>  LX[3]: 28, 31, 47                      
#> SV2[3]: 29, 32, 48                      
#> DTP[5]: 22, 30, 33, 42, 49              
#>  SE[1]: 50                              
#>  GE[1]: 51                              
#> IEA[1]: 52                              
#> 
#> $`837I_EX1c_ppo_repriced_claim`
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1382     
#>   Segments: 51       
#>   Problems: 1        
#>  
#> ISA[1]: 1                              
#>  GS[1]: 2                              
#>  ST[1]: 3                              
#> BPR[1]: 4                              
#> NM1[9]: 5, 7, 9, 15, 19, 22, 37, 40, 41
#> PER[1]: 6                              
#>  HL[3]: 8, 13, 20                      
#>  N3[3]: 10, 16, 23                     
#>  N4[3]: 11, 17, 24                     
#> REF[3]: 12, 31, 32                     
#> SBR[2]: 14, 38                         
#> PAT[1]: 21                             
#> AMT[1]: 30                             
#> HCP[3]: 36, 45, 49                     
#> DMG[2]: 18, 25                         
#>  OI[1]: 39                             
#> CLM[1]: 26                             
#>  HI[3]: 33, 34, 35                     
#>  LX[2]: 42, 46                         
#> SV2[2]: 43, 47                         
#> DTP[4]: 27, 28, 44, 48                 
#>  SE[1]: 50                             
#>  GE[1]: 51                             
#> IEA[1]: 52                             
#> 
#> $`837I_EX1d_oon_repriced_claim`
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1000     
#>   Segments: 34       
#>   Problems: 1        
#>  
#> ISA[1]: 1                  
#>  GS[1]: 2                  
#>  ST[1]: 3                  
#> BPR[1]: 4                  
#> NM1[6]: 5, 7, 9, 15, 19, 29
#> PER[1]: 6                  
#>  HL[2]: 8, 13              
#>  N3[2]: 10, 16             
#>  N4[2]: 11, 17             
#> REF[3]: 12, 25, 26         
#> SBR[1]: 14                 
#> AMT[1]: 24                 
#> HCP[1]: 28                 
#> DMG[1]: 18                 
#> CLM[1]: 20                 
#>  HI[1]: 27                 
#>  LX[1]: 30                 
#> SV2[1]: 31                 
#> DTP[3]: 21, 22, 32         
#>  SE[1]: 33                 
#>  GE[1]: 34                 
#> IEA[1]: 35                 
#> 
#> $`837I_EX2_car_accident`
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1184     
#>   Segments: 46       
#>   Problems: 1        
#>  
#> ISA[1]: 1                       
#>  GS[1]: 2                       
#>  ST[1]: 3                       
#> BPR[1]: 4                       
#> NM1[7]: 5, 7, 10, 16, 17, 20, 32
#> PER[1]: 6                       
#>  HL[3]: 8, 14, 18               
#>  N3[2]: 11, 21                  
#>  N4[2]: 12, 22                  
#> REF[3]: 13, 24, 28              
#> SBR[1]: 15                      
#> PAT[1]: 19                      
#> DMG[1]: 23                      
#> CLM[1]: 25                      
#>  HI[3]: 29, 30, 31              
#> PRV[1]: 9                       
#>  LX[4]: 33, 36, 39, 42          
#> SV2[4]: 34, 37, 40, 43          
#> DTP[5]: 26, 35, 38, 41, 44      
#>  SE[1]: 45                      
#>  GE[1]: 46                      
#> IEA[1]: 47                      
#> 
#> $ex_837_inpatient
#> [1] NA
#> 
#> $sample_837I
#> [1] NA
#> 
#> $sample_837_1
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1269     
#>   Segments: 49       
#>   Problems: 0        
#>  
#> ISA[1]: 1                         
#>  GS[1]: 2                         
#>  ST[1]: 3                         
#> BPR[1]: 4                         
#> NM1[4]: 5, 7, 10, 17              
#> PER[3]: 6, 8, 14                  
#>  HL[2]: 9, 15                     
#>  N3[2]: 11, 18                    
#>  N4[2]: 12, 19                    
#> REF[5]: 13, 34, 38, 42, 46        
#> SBR[1]: 16                        
#> CLM[1]: 20                        
#>  HI[7]: 24, 25, 26, 27, 28, 29, 30
#>  LX[4]: 31, 35, 39, 43            
#> SV1[4]: 32, 36, 40, 44            
#> DTP[7]: 21, 22, 23, 33, 37, 41, 45
#>  SE[1]: 47                        
#>  GE[1]: 48                        
#> IEA[1]: 49                        
#> 
#> $sample_837_10
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1100     
#>   Segments: 42       
#>   Problems: 0        
#>  
#> ISA[1]: 1                     
#>  GS[1]: 2                     
#>  ST[1]: 3                     
#> BPR[1]: 4                     
#> NM1[4]: 5, 7, 10, 17          
#> PER[3]: 6, 8, 14              
#>  HL[2]: 9, 15                 
#>  N3[2]: 11, 18                
#>  N4[2]: 12, 19                
#> REF[4]: 13, 31, 35, 39        
#> SBR[1]: 16                    
#> CLM[1]: 20                    
#>  HI[4]: 24, 25, 26, 27        
#>  LX[3]: 28, 32, 36            
#> SV1[3]: 29, 33, 37            
#> DTP[6]: 21, 22, 23, 30, 34, 38
#>  SE[1]: 40                    
#>  GE[1]: 41                    
#> IEA[1]: 42                    
#> 
#> $sample_837_2
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1092     
#>   Segments: 41       
#>   Problems: 0        
#>  
#> ISA[1]: 1                     
#>  GS[1]: 2                     
#>  ST[1]: 3                     
#> BPR[1]: 4                     
#> NM1[4]: 5, 7, 10, 17          
#> PER[3]: 6, 8, 14              
#>  HL[2]: 9, 15                 
#>  N3[2]: 11, 18                
#>  N4[2]: 12, 19                
#> REF[4]: 13, 30, 34, 38        
#> SBR[1]: 16                    
#> CLM[1]: 20                    
#>  HI[3]: 24, 25, 26            
#>  LX[3]: 27, 31, 35            
#> SV1[3]: 28, 32, 36            
#> DTP[6]: 21, 22, 23, 29, 33, 37
#>  SE[1]: 39                    
#>  GE[1]: 40                    
#> IEA[1]: 41                    
#> 
#> $sample_837_3
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1059     
#>   Segments: 40       
#>   Problems: 0        
#>  
#> ISA[1]: 1                     
#>  GS[1]: 2                     
#>  ST[1]: 3                     
#> BPR[1]: 4                     
#> NM1[4]: 5, 7, 10, 17          
#> PER[3]: 6, 8, 14              
#>  HL[2]: 9, 15                 
#>  N3[2]: 11, 18                
#>  N4[2]: 12, 19                
#> REF[3]: 13, 33, 37            
#> SBR[1]: 16                    
#> CLM[1]: 20                    
#>  HI[6]: 24, 25, 26, 27, 28, 29
#>  LX[2]: 30, 34                
#> SV1[2]: 31, 35                
#> DTP[5]: 21, 22, 23, 32, 36    
#>  SE[1]: 38                    
#>  GE[1]: 39                    
#> IEA[1]: 40                    
#> 
#> $sample_837_4
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1034     
#>   Segments: 38       
#>   Problems: 0        
#>  
#> ISA[1]: 1                             
#>  GS[1]: 2                             
#>  ST[1]: 3                             
#> BPR[1]: 4                             
#> NM1[4]: 5, 7, 10, 17                  
#> PER[3]: 6, 8, 14                      
#>  HL[2]: 9, 15                         
#>  N3[2]: 11, 18                        
#>  N4[2]: 12, 19                        
#> REF[2]: 13, 35                        
#> SBR[1]: 16                            
#> CLM[1]: 20                            
#>  HI[8]: 24, 25, 26, 27, 28, 29, 30, 31
#>  LX[1]: 32                            
#> SV1[1]: 33                            
#> DTP[4]: 21, 22, 23, 34                
#>  SE[1]: 36                            
#>  GE[1]: 37                            
#> IEA[1]: 38                            
#> 
#> $sample_837_5
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1250     
#>   Segments: 48       
#>   Problems: 0        
#>  
#> ISA[1]: 1                         
#>  GS[1]: 2                         
#>  ST[1]: 3                         
#> BPR[1]: 4                         
#> NM1[4]: 5, 7, 10, 17              
#> PER[3]: 6, 8, 14                  
#>  HL[2]: 9, 15                     
#>  N3[2]: 11, 18                    
#>  N4[2]: 12, 19                    
#> REF[5]: 13, 33, 37, 41, 45        
#> SBR[1]: 16                        
#> CLM[1]: 20                        
#>  HI[6]: 24, 25, 26, 27, 28, 29    
#>  LX[4]: 30, 34, 38, 42            
#> SV1[4]: 31, 35, 39, 43            
#> DTP[7]: 21, 22, 23, 32, 36, 40, 44
#>  SE[1]: 46                        
#>  GE[1]: 47                        
#> IEA[1]: 48                        
#> 
#> $sample_837_6
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1274     
#>   Segments: 52       
#>   Problems: 0        
#>  
#> ISA[1]: 1                             
#>  GS[1]: 2                             
#>  ST[1]: 3                             
#> BPR[1]: 4                             
#> NM1[4]: 5, 7, 10, 17                  
#> PER[3]: 6, 8, 14                      
#>  HL[2]: 9, 15                         
#>  N3[2]: 11, 18                        
#>  N4[2]: 12, 19                        
#> REF[6]: 13, 33, 37, 41, 45, 49        
#> SBR[1]: 16                            
#> CLM[1]: 20                            
#>  HI[6]: 24, 25, 26, 27, 28, 29        
#>  LX[5]: 30, 34, 38, 42, 46            
#> SV1[5]: 31, 35, 39, 43, 47            
#> DTP[8]: 21, 22, 23, 32, 36, 40, 44, 48
#>  SE[1]: 50                            
#>  GE[1]: 51                            
#> IEA[1]: 52                            
#> 
#> $sample_837_7
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1203     
#>   Segments: 47       
#>   Problems: 0        
#>  
#> ISA[1]: 1                         
#>  GS[1]: 2                         
#>  ST[1]: 3                         
#> BPR[1]: 4                         
#> NM1[4]: 5, 7, 10, 17              
#> PER[3]: 6, 8, 14                  
#>  HL[2]: 9, 15                     
#>  N3[2]: 11, 18                    
#>  N4[2]: 12, 19                    
#> REF[5]: 13, 32, 36, 40, 44        
#> SBR[1]: 16                        
#> CLM[1]: 20                        
#>  HI[5]: 24, 25, 26, 27, 28        
#>  LX[4]: 29, 33, 37, 41            
#> SV1[4]: 30, 34, 38, 42            
#> DTP[7]: 21, 22, 23, 31, 35, 39, 43
#>  SE[1]: 45                        
#>  GE[1]: 46                        
#> IEA[1]: 47                        
#> 
#> $sample_837_8
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1191     
#>   Segments: 45       
#>   Problems: 0        
#>  
#> ISA[1]: 1                         
#>  GS[1]: 2                         
#>  ST[1]: 3                         
#> BPR[1]: 4                         
#> NM1[4]: 5, 7, 10, 17              
#> PER[3]: 6, 8, 14                  
#>  HL[2]: 9, 15                     
#>  N3[2]: 11, 18                    
#>  N4[2]: 12, 19                    
#> REF[5]: 13, 30, 34, 38, 42        
#> SBR[1]: 16                        
#> CLM[1]: 20                        
#>  HI[3]: 24, 25, 26                
#>  LX[4]: 27, 31, 35, 39            
#> SV1[4]: 28, 32, 36, 40            
#> DTP[7]: 21, 22, 23, 29, 33, 37, 41
#>  SE[1]: 43                        
#>  GE[1]: 44                        
#> IEA[1]: 45                        
#> 
#> $sample_837_9
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1290     
#>   Segments: 50       
#>   Problems: 0        
#>  
#> ISA[1]: 1                             
#>  GS[1]: 2                             
#>  ST[1]: 3                             
#> BPR[1]: 4                             
#> NM1[4]: 5, 7, 10, 17                  
#> PER[3]: 6, 8, 14                      
#>  HL[2]: 9, 15                         
#>  N3[2]: 11, 18                        
#>  N4[2]: 12, 19                        
#> REF[5]: 13, 35, 39, 43, 47            
#> SBR[1]: 16                            
#> CLM[1]: 20                            
#>  HI[8]: 24, 25, 26, 27, 28, 29, 30, 31
#>  LX[4]: 32, 36, 40, 44                
#> SV1[4]: 33, 37, 41, 45                
#> DTP[7]: 21, 22, 23, 34, 38, 42, 46    
#>  SE[1]: 48                            
#>  GE[1]: 49                            
#> IEA[1]: 50                            
#> 
# purrr::map(hcc::x12_837I[8:17], parse_837)

purrr::map(hcc::x12_837P, index_837)
#> $`837P_EX10a_drug_adm_office`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 965      
#>   Segments: 35       
#>   Problems: 0        
#>  
#> ISA[1]: 1                  
#>  GS[1]: 2                  
#>  ST[1]: 3                  
#> BPR[1]: 4                  
#> NM1[6]: 5, 7, 9, 15, 19, 22
#> PER[1]: 6                  
#>  HL[2]: 8, 13              
#>  N3[2]: 10, 16             
#>  N4[2]: 11, 17             
#> REF[1]: 12                 
#> SBR[1]: 14                 
#> AMT[1]: 30                 
#> DMG[1]: 18                 
#> CLM[1]: 20                 
#>  HI[1]: 21                 
#> PRV[1]: 23                 
#>  LX[2]: 24, 27             
#> SV1[2]: 25, 28             
#> DTP[2]: 26, 29             
#>  SE[1]: 33                 
#> CTP[1]: 32                 
#> LIN[1]: 31                 
#>  GE[1]: 34                 
#> IEA[1]: 35                 
#> 
#> $`837P_EX11_ppo_repriced_claim`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 1209     
#>   Segments: 41       
#>   Problems: 0        
#>  
#> ISA[1]: 1                          
#>  GS[1]: 2                          
#>  ST[1]: 3                          
#> BPR[1]: 4                          
#> NM1[8]: 5, 7, 9, 16, 20, 26, 27, 28
#> PER[2]: 6, 13                      
#>  HL[2]: 8, 14                      
#>  N3[3]: 10, 17, 29                 
#>  N4[3]: 11, 18, 30                 
#> REF[3]: 12, 22, 23                 
#> SBR[1]: 15                         
#> HCP[3]: 25, 34, 38                 
#> DMG[1]: 19                         
#> CLM[1]: 21                         
#>  HI[1]: 24                         
#>  LX[2]: 31, 35                     
#> SV1[2]: 32, 36                     
#> DTP[2]: 33, 37                     
#>  SE[1]: 39                         
#>  GE[1]: 40                         
#> IEA[1]: 41                         
#> 
#> $`837P_EX12_oon_repriced_claim`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 1204     
#>   Segments: 43       
#>   Problems: 0        
#>  
#> ISA[1]: 1                              
#>  GS[1]: 2                              
#>  ST[1]: 3                              
#> BPR[1]: 4                              
#> NM1[9]: 5, 7, 9, 15, 19, 22, 31, 34, 37
#> PER[1]: 6                              
#>  HL[3]: 8, 13, 20                      
#>  N3[4]: 10, 16, 23, 35                 
#>  N4[4]: 11, 17, 24, 36                 
#> REF[3]: 12, 27, 28                     
#> SBR[2]: 14, 32                         
#> PAT[1]: 21                             
#> HCP[1]: 30                             
#> DMG[2]: 18, 25                         
#>  OI[1]: 33                             
#> CLM[1]: 26                             
#>  HI[1]: 29                             
#>  LX[1]: 38                             
#> SV1[1]: 39                             
#> DTP[1]: 40                             
#>  SE[1]: 41                             
#>  GE[1]: 42                             
#> IEA[1]: 43                             
#> 
#> $`837P_EX1_commercial-insurance`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 1106     
#>   Segments: 46       
#>   Problems: 0        
#>  
#> ISA[1]: 1                       
#>  GS[1]: 2                       
#>  ST[1]: 3                       
#> BPR[1]: 4                       
#> NM1[7]: 5, 7, 10, 14, 19, 21, 25
#> PER[1]: 6                       
#>  HL[3]: 8, 17, 23               
#>  N3[3]: 11, 15, 26              
#>  N4[3]: 12, 16, 27              
#> REF[3]: 13, 22, 30              
#> SBR[1]: 18                      
#> PAT[1]: 24                      
#> DMG[2]: 20, 28                  
#> CLM[1]: 29                      
#>  HI[1]: 31                      
#> PRV[1]: 9                       
#>  LX[4]: 32, 35, 38, 41          
#> SV1[4]: 33, 36, 39, 42          
#> DTP[4]: 34, 37, 40, 43          
#>  SE[1]: 44                      
#>  GE[1]: 45                      
#> IEA[1]: 46                      
#> 
#> $`837P_EX2_encounter`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 1128     
#>   Segments: 45       
#>   Problems: 0        
#>  
#> ISA[1]: 1                       
#>  GS[1]: 2                       
#>  ST[1]: 3                       
#> BPR[1]: 4                       
#> NM1[7]: 5, 7, 10, 14, 19, 23, 28
#> PER[1]: 6                       
#>  HL[2]: 8, 17                   
#>  N3[4]: 11, 15, 20, 29          
#>  N4[4]: 12, 16, 21, 30          
#> REF[2]: 13, 26                  
#> SBR[1]: 18                      
#> DMG[1]: 22                      
#> CLM[1]: 24                      
#>  HI[1]: 27                      
#> PRV[1]: 9                       
#>  LX[4]: 31, 34, 37, 40          
#> SV1[4]: 32, 35, 38, 41          
#> DTP[5]: 25, 33, 36, 39, 42      
#>  SE[1]: 43                      
#>  GE[1]: 44                      
#> IEA[1]: 45                      
#> 
#> $`837P_EX3a_billing_provider_payer_a`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 1379     
#>   Segments: 56       
#>   Problems: 0        
#>  
#>  ISA[1]: 1                                      
#>   GS[1]: 2                                      
#>   ST[1]: 3                                      
#>  BPR[1]: 4                                      
#> NM1[11]: 5, 7, 9, 14, 19, 21, 27, 33, 36, 41, 44
#>  PER[2]: 6, 13                                  
#>   HL[3]: 8, 17, 25                              
#>   N3[6]: 10, 15, 22, 28, 37, 42                 
#>   N4[6]: 11, 16, 23, 29, 38, 43                 
#>  REF[3]: 12, 24, 35                             
#>  SBR[2]: 18, 39                                 
#>  PAT[1]: 26                                     
#>  DMG[2]: 20, 30                                 
#>   OI[1]: 40                                     
#>  CLM[1]: 31                                     
#>   HI[1]: 32                                     
#>  PRV[1]: 34                                     
#>   LX[3]: 45, 48, 51                             
#>  SV1[3]: 46, 49, 52                             
#>  DTP[3]: 47, 50, 53                             
#>   SE[1]: 54                                     
#>   GE[1]: 55                                     
#>  IEA[1]: 56                                     
#> 
#> $`837P_EX4_medicare_secondary_cob`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 1185     
#>   Segments: 46       
#>   Problems: 1        
#>  
#> ISA[1]: 1                              
#>  GS[1]: 2                              
#>  ST[1]: 3                              
#> BPR[1]: 4                              
#> NM1[9]: 5, 7, 9, 16, 20, 25, 27, 34, 37
#> PER[1]: 6                              
#>  HL[2]: 8, 14                          
#>  N3[4]: 10, 17, 21, 35                 
#>  N4[4]: 11, 18, 22, 36                 
#> REF[4]: 12, 13, 26, 29                 
#> SBR[2]: 15, 30                         
#> AMT[2]: 31, 32                         
#> DMG[1]: 19                             
#> CAS[2]: 42, 43                         
#>  OI[1]: 33                             
#> CLM[1]: 23                             
#>  HI[1]: 24                             
#> PRV[1]: 28                             
#>  LX[1]: 38                             
#> SV1[1]: 39                             
#> DTP[2]: 40, 44                         
#>  SE[1]: 45                             
#>  GE[1]: 46                             
#> IEA[1]: 47                             
#> 
#> $`837P_EX5_ambulance`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 1375     
#>   Segments: 57       
#>   Problems: 0        
#>  
#> ISA[1]: 1                       
#>  GS[1]: 2                       
#>  ST[1]: 3                       
#> BPR[1]: 4                       
#> NM1[7]: 5, 7, 10, 16, 20, 29, 32
#> PER[1]: 6                       
#>  HL[2]: 8, 14                   
#>  N3[5]: 11, 17, 21, 30, 33      
#>  N4[5]: 12, 18, 22, 31, 34      
#> REF[5]: 13, 39, 45, 49, 53      
#> SBR[1]: 15                      
#> NTE[1]: 40                      
#> CR1[1]: 25                      
#> CRC[2]: 26, 27                  
#> DMG[1]: 19                      
#> CLM[1]: 23                      
#>  HI[1]: 28                      
#> PRV[1]: 9                       
#>  LX[4]: 35, 41, 46, 50          
#> SV1[4]: 36, 42, 47, 51          
#> DTP[5]: 24, 37, 43, 48, 52      
#>  SE[1]: 54                      
#> NTE[1]: 40                      
#> QTY[2]: 38, 44                  
#>  GE[1]: 55                      
#> IEA[1]: 56                      
#> 
#> $`837P_EX6_chiropractic`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 920      
#>   Segments: 33       
#>   Problems: 0        
#>  
#> ISA[1]: 1              
#>  GS[1]: 2              
#>  ST[1]: 3              
#> BPR[1]: 4              
#> NM1[5]: 5, 7, 9, 16, 20
#> PER[2]: 6, 13          
#>  HL[2]: 8, 14          
#>  N3[2]: 10, 17         
#>  N4[2]: 11, 18         
#> REF[2]: 12, 30         
#> SBR[1]: 15             
#> CR2[1]: 25             
#> DMG[1]: 19             
#> CLM[1]: 21             
#>  HI[1]: 26             
#>  LX[1]: 27             
#> SV1[1]: 28             
#> DTP[4]: 22, 23, 24, 29 
#>  SE[1]: 31             
#>  GE[1]: 32             
#> IEA[1]: 33             
#> 
#> $`837P_EX7_oxygen`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 1501     
#>   Segments: 70       
#>   Problems: 0        
#>  
#>  ISA[1]: 1                                                                     
#>   GS[1]: 2                                                                     
#>   ST[1]: 3                                                                     
#>  BPR[1]: 4                                                                     
#>  NM1[7]: 5, 7, 9, 15, 19, 30, 53                                               
#>  PER[3]: 6, 34, 57                                                             
#>   HL[2]: 8, 13                                                                 
#>   N3[4]: 10, 16, 31, 54                                                        
#>   N4[4]: 11, 17, 32, 55                                                        
#>  REF[3]: 12, 33, 56                                                            
#>  SBR[1]: 14                                                                    
#>  PWK[2]: 24, 47                                                                
#>  CR3[2]: 25, 48                                                                
#>  DMG[1]: 18                                                                    
#>  CLM[1]: 20                                                                    
#>   HI[1]: 21                                                                    
#>   LX[2]: 22, 45                                                                
#>  SV1[2]: 23, 46                                                                
#>  DTP[8]: 26, 27, 28, 29, 49, 50, 51, 52                                        
#>   SE[1]: 68                                                                    
#>   LQ[2]: 35, 58                                                                
#> FRM[18]: 36, 37, 38, 39, 40, 41, 42, 43, 44, 59, 60, 61, 62, 63, 64, 65, 66, 67
#>   GE[1]: 69                                                                    
#>  IEA[1]: 70                                                                    
#> 
#> $`837P_EX8_wheelchair`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 1086     
#>   Segments: 47       
#>   Problems: 0        
#>  
#> ISA[1]: 1                         
#>  GS[1]: 2                         
#>  ST[1]: 3                         
#> BPR[1]: 4                         
#> NM1[6]: 5, 7, 9, 17, 21, 32       
#> PER[2]: 6, 36                     
#>  HL[2]: 8, 14                     
#>  N3[3]: 10, 18, 33                
#>  N4[3]: 11, 19, 34                
#> REF[3]: 12, 13, 35                
#> SBR[1]: 15                        
#> PAT[1]: 16                        
#> PWK[1]: 26                        
#> CR3[1]: 27                        
#> DMG[1]: 20                        
#> MEA[1]: 31                        
#> CLM[1]: 22                        
#>  HI[1]: 23                        
#>  LX[1]: 24                        
#> SV1[1]: 25                        
#> DTP[3]: 28, 29, 30                
#>  SE[1]: 45                        
#>  LQ[1]: 37                        
#> FRM[7]: 38, 39, 40, 41, 42, 43, 44
#>  GE[1]: 46                        
#> IEA[1]: 47                        
#> 
#> $`837P_EX9_anesthesia`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 937      
#>   Segments: 33       
#>   Problems: 0        
#>  
#> ISA[1]: 1                      
#>  GS[1]: 2                      
#>  ST[1]: 3                      
#> BPR[1]: 4                      
#> NM1[7]: 5, 7, 9, 15, 19, 22, 25
#> PER[1]: 6                      
#>  HL[2]: 8, 13                  
#>  N3[3]: 10, 16, 26             
#>  N4[3]: 11, 17, 27             
#> REF[2]: 12, 24                 
#> SBR[1]: 14                     
#> DMG[1]: 18                     
#> CLM[1]: 20                     
#>  HI[1]: 21                     
#> PRV[1]: 23                     
#>  LX[1]: 28                     
#> SV1[1]: 29                     
#> DTP[1]: 30                     
#>  SE[1]: 31                     
#>  GE[1]: 32                     
#> IEA[1]: 33                     
#> 
#> $sample_837P
#> [1] NA
#> 
#> $sample_837_0
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 4940     
#>   Segments: 176      
#>   Problems: 0        
#>  
#>  ISA[1]: 1                                                                     
#>   GS[1]: 2                                                                     
#>   ST[5]: 3, 37, 71, 105, 140                                                   
#>  BPR[5]: 4, 38, 72, 106, 141                                                   
#> NM1[40]: 5, 7, 9, 14, 19, 23, 27, 29, 39, 41, 43, 48, 53, 57, 61, 63, 73, 7....
#> PER[10]: 6, 13, 40, 47, 74, 81, 108, 115, 143, 150                             
#>  HL[10]: 8, 17, 42, 51, 76, 85, 110, 119, 145, 154                             
#>  N3[20]: 10, 15, 20, 30, 44, 49, 54, 64, 78, 83, 88, 98, 112, 117, 122, 132....
#>  N4[20]: 11, 16, 21, 31, 45, 50, 55, 65, 79, 84, 89, 99, 113, 118, 123, 133....
#> REF[15]: 12, 25, 35, 46, 59, 69, 80, 93, 103, 114, 127, 137, 149, 162, 172     
#>  SBR[5]: 18, 52, 86, 120, 155                                                  
#>  NTE[1]: 138                                                                   
#>  DMG[5]: 22, 56, 90, 124, 159                                                  
#>  CLM[5]: 24, 58, 92, 126, 161                                                  
#>   HI[5]: 26, 60, 94, 128, 163                                                  
#>  PRV[5]: 28, 62, 96, 130, 165                                                  
#>   LX[5]: 32, 66, 100, 134, 169                                                 
#>  SV1[5]: 33, 67, 101, 135, 170                                                 
#>  DTP[5]: 34, 68, 102, 136, 171                                                 
#>   SE[5]: 36, 70, 104, 139, 173                                                 
#>  NTE[1]: 138                                                                   
#>   GE[1]: 174                                                                   
#>  IEA[1]: 175                                                                   
#> 
#> $sample_837_11
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 799      
#>   Segments: 29       
#>   Problems: 0        
#>  
#> ISA[1]: 1              
#>  GS[1]: 2              
#>  ST[1]: 3              
#> BPR[1]: 4              
#> NM1[5]: 5, 7, 9, 15, 21
#> PER[1]: 6              
#>  HL[2]: 8, 13          
#>  N3[2]: 10, 16         
#>  N4[2]: 11, 17         
#> REF[1]: 12             
#> SBR[1]: 14             
#> DMG[1]: 18             
#> CLM[1]: 19             
#>  HI[1]: 20             
#> PRV[1]: 22             
#> SV1[1]: 23             
#> DTP[1]: 24             
#>  SE[1]: 27             
#> CTP[1]: 26             
#> LIN[1]: 25             
#>  GE[1]: 28             
#> IEA[1]: 29             
#> 
#> $sample_837_12
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 2807     
#>   Segments: 113      
#>   Problems: 0        
#>  
#>  ISA[1]: 1                                                        
#>   GS[1]: 2                                                        
#>   ST[3]: 3, 28, 66                                                
#>  BPR[3]: 4, 29, 67                                                
#> NM1[13]: 5, 7, 9, 15, 21, 30, 32, 35, 42, 68, 70, 73, 80          
#>  PER[7]: 6, 31, 33, 39, 69, 71, 77                                
#>   HL[6]: 8, 13, 34, 40, 72, 78                                    
#>   N3[6]: 10, 16, 36, 43, 74, 81                                   
#>   N4[6]: 11, 17, 37, 44, 75, 82                                   
#> REF[10]: 12, 38, 56, 60, 64, 76, 98, 102, 106, 110                
#>  SBR[3]: 14, 41, 79                                               
#>  DMG[1]: 18                                                       
#>  CLM[3]: 19, 45, 83                                               
#>  HI[13]: 20, 49, 50, 51, 52, 87, 88, 89, 90, 91, 92, 93, 94       
#>  PRV[1]: 22                                                       
#>   LX[7]: 53, 57, 61, 95, 99, 103, 107                             
#>  SV1[8]: 23, 54, 58, 62, 96, 100, 104, 108                        
#> DTP[14]: 24, 46, 47, 48, 55, 59, 63, 84, 85, 86, 97, 101, 105, 109
#>   SE[3]: 27, 65, 111                                              
#>  CTP[1]: 26                                                       
#>  LIN[1]: 25                                                       
#>   GE[1]: 112                                                      
#>  IEA[1]: 113                                                      
#> 
# purrr::map(hcc::x12_837P[14:16], parse_837)
```
