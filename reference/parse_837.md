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
#>   Segments: 47       
#>   Problems: 0        
#>  
#>    ISA[1]: 1         
#>     GS[1]: 2         
#>     ST[1]: 3         
#>    BHT[1]: 4         
#>  NM141[1]: 5         
#>  PERIC[2]: 6, 14     
#>  NM140[1]: 7         
#>     HL[2]: 8, 15     
#>  PRVBI[1]: 9         
#>  NM185[1]: 10        
#>     N3[3]: 11, 18, 36
#>     N4[3]: 12, 19, 37
#>  REFEI[1]: 13        
#>   SBRP[1]: 16        
#>  NM1IL[2]: 17, 35    
#>    DMG[1]: 20        
#>  NM1PR[2]: 21, 38    
#>  REFG2[1]: 22        
#>    CLM[1]: 23        
#> DTP434[1]: 24        
#>    CL1[1]: 25        
#>   HIBK[1]: 26        
#>   HIBF[1]: 27        
#>   HIBH[1]: 28        
#>   HIBE[1]: 29        
#>   HIBG[1]: 30        
#>  NM171[1]: 31        
#>  REF1G[1]: 32        
#>   SBRS[1]: 33        
#>     OI[1]: 34        
#>     LX[2]: 39, 42    
#>    SV2[2]: 40, 43    
#> DTP472[2]: 41, 44    
#>     SE[1]: 45        
#>     GE[1]: 46        
#>    IEA[1]: 47        
#> 
#> $`837I_EX1b_2claims_1provider`
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1273     
#>   Segments: 52       
#>   Problems: 0        
#>  
#>    ISA[1]: 1         
#>     GS[1]: 2         
#>     ST[1]: 3         
#>    BHT[1]: 4         
#>  NM141[1]: 5         
#>  PERIC[1]: 6         
#>  NM140[1]: 7         
#>     HL[3]: 8, 14, 34 
#>  PRVBI[1]: 9         
#>  NM185[1]: 10        
#>     N3[3]: 11, 17, 37
#>     N4[3]: 12, 18, 38
#>  REFEI[1]: 13        
#>   SBRP[2]: 15, 35    
#>  NM1IL[2]: 16, 36    
#>    DMG[2]: 19, 39    
#>  NM1PR[2]: 20, 40    
#>    CLM[2]: 21, 41    
#> DTP434[2]: 22, 42    
#>    CL1[2]: 23, 43    
#>   HIBK[2]: 24, 44    
#>   HIBF[1]: 25        
#>  NM171[2]: 26, 45    
#>  REF1G[1]: 27        
#>     LX[3]: 28, 31, 47
#>    SV2[3]: 29, 32, 48
#> DTP472[3]: 30, 33, 49
#>  PRVAT[1]: 46        
#>     SE[1]: 50        
#>     GE[1]: 51        
#>    IEA[1]: 52        
#> 
#> $`837I_EX1c_ppo_repriced_claim`
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1382     
#>   Segments: 52       
#>   Problems: 0        
#>  
#>    ISA[1]: 1         
#>     GS[1]: 2         
#>     ST[1]: 3         
#>    BHT[1]: 4         
#>  NM141[1]: 5         
#>  PERIC[1]: 6         
#>  NM140[1]: 7         
#>     HL[3]: 8, 13, 20 
#>  NM185[1]: 9         
#>     N3[3]: 10, 16, 23
#>     N4[3]: 11, 17, 24
#>  REFEI[1]: 12        
#>   SBRP[1]: 14        
#>  NM1IL[2]: 15, 40    
#>    DMG[2]: 18, 25    
#>  NM1PR[2]: 19, 41    
#>    PAT[1]: 21        
#>  NM1QC[1]: 22        
#>    CLM[1]: 26        
#> DTP434[1]: 27        
#> DTP435[1]: 28        
#>    CL1[1]: 29        
#>    AMT[1]: 30        
#>  REF9A[1]: 31        
#>  REFD9[1]: 32        
#>   HIBK[1]: 33        
#>   HIBF[1]: 34        
#>   HIBH[1]: 35        
#>    HCP[3]: 36, 45, 49
#>  NM171[1]: 37        
#>   SBRS[1]: 38        
#>     OI[1]: 39        
#>     LX[2]: 42, 46    
#>    SV2[2]: 43, 47    
#> DTP472[2]: 44, 48    
#>     SE[1]: 50        
#>     GE[1]: 51        
#>    IEA[1]: 52        
#> 
#> $`837I_EX1d_oon_repriced_claim`
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1000     
#>   Segments: 35       
#>   Problems: 0        
#>  
#>    ISA[1]: 1     
#>     GS[1]: 2     
#>     ST[1]: 3     
#>    BHT[1]: 4     
#>  NM141[1]: 5     
#>  PERIC[1]: 6     
#>  NM140[1]: 7     
#>     HL[2]: 8, 13 
#>  NM185[1]: 9     
#>     N3[2]: 10, 16
#>     N4[2]: 11, 17
#>  REFEI[1]: 12    
#>   SBRP[1]: 14    
#>  NM1IL[1]: 15    
#>    DMG[1]: 18    
#>  NM1PR[1]: 19    
#>    CLM[1]: 20    
#> DTP434[1]: 21    
#> DTP435[1]: 22    
#>    CL1[1]: 23    
#>    AMT[1]: 24    
#>  REF9A[1]: 25    
#>  REFD9[1]: 26    
#>   HIBK[1]: 27    
#>    HCP[1]: 28    
#>  NM171[1]: 29    
#>     LX[1]: 30    
#>    SV2[1]: 31    
#> DTP472[1]: 32    
#>     SE[1]: 33    
#>     GE[1]: 34    
#>    IEA[1]: 35    
#> 
#> $`837I_EX2_car_accident`
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1184     
#>   Segments: 47       
#>   Problems: 0        
#>  
#>    ISA[1]: 1             
#>     GS[1]: 2             
#>     ST[1]: 3             
#>    BHT[1]: 4             
#>  NM141[1]: 5             
#>  PERIC[1]: 6             
#>  NM140[1]: 7             
#>     HL[3]: 8, 14, 18     
#>  PRVBI[1]: 9             
#>  NM185[1]: 10            
#>     N3[2]: 11, 21        
#>     N4[2]: 12, 22        
#>  REFEI[1]: 13            
#>   SBRP[1]: 15            
#>  NM1IL[1]: 16            
#>  NM1PR[1]: 17            
#>    PAT[1]: 19            
#>  NM1QC[1]: 20            
#>    DMG[1]: 23            
#>  REFY4[1]: 24            
#>    CLM[1]: 25            
#> DTP434[1]: 26            
#>    CL1[1]: 27            
#>  REFLU[1]: 28            
#>   HIBK[1]: 29            
#>   HIPR[1]: 30            
#>   HIBN[1]: 31            
#>  NM171[1]: 32            
#>     LX[4]: 33, 36, 39, 42
#>    SV2[4]: 34, 37, 40, 43
#> DTP472[4]: 35, 38, 41, 44
#>     SE[1]: 45            
#>     GE[1]: 46            
#>    IEA[1]: 47            
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
#>    ISA[1]: 1                         
#>     GS[1]: 2                         
#>     ST[1]: 3                         
#>    BHT[1]: 4                         
#>  NM141[1]: 5                         
#>  PERIC[3]: 6, 8, 14                  
#>  NM140[1]: 7                         
#>     HL[2]: 9, 15                     
#>  NM185[1]: 10                        
#>     N3[2]: 11, 18                    
#>     N4[2]: 12, 19                    
#>  REFEI[1]: 13                        
#>   SBRP[1]: 16                        
#>  NM1IL[1]: 17                        
#>    CLM[1]: 20                        
#> DTP434[1]: 21                        
#> DTP435[1]: 22                        
#> DTP096[1]: 23                        
#>  HIABK[7]: 24, 25, 26, 27, 28, 29, 30
#>     LX[4]: 31, 35, 39, 43            
#>    SV1[4]: 32, 36, 40, 44            
#> DTP472[4]: 33, 37, 41, 45            
#>  REF6R[4]: 34, 38, 42, 46            
#>     SE[1]: 47                        
#>     GE[1]: 48                        
#>    IEA[1]: 49                        
#> 
#> $sample_837_10
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1100     
#>   Segments: 42       
#>   Problems: 0        
#>  
#>    ISA[1]: 1             
#>     GS[1]: 2             
#>     ST[1]: 3             
#>    BHT[1]: 4             
#>  NM141[1]: 5             
#>  PERIC[3]: 6, 8, 14      
#>  NM140[1]: 7             
#>     HL[2]: 9, 15         
#>  NM185[1]: 10            
#>     N3[2]: 11, 18        
#>     N4[2]: 12, 19        
#>  REFEI[1]: 13            
#>   SBRP[1]: 16            
#>  NM1IL[1]: 17            
#>    CLM[1]: 20            
#> DTP434[1]: 21            
#> DTP435[1]: 22            
#> DTP096[1]: 23            
#>  HIABK[4]: 24, 25, 26, 27
#>     LX[3]: 28, 32, 36    
#>    SV1[3]: 29, 33, 37    
#> DTP472[3]: 30, 34, 38    
#>  REF6R[3]: 31, 35, 39    
#>     SE[1]: 40            
#>     GE[1]: 41            
#>    IEA[1]: 42            
#> 
#> $sample_837_2
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1092     
#>   Segments: 41       
#>   Problems: 0        
#>  
#>    ISA[1]: 1         
#>     GS[1]: 2         
#>     ST[1]: 3         
#>    BHT[1]: 4         
#>  NM141[1]: 5         
#>  PERIC[3]: 6, 8, 14  
#>  NM140[1]: 7         
#>     HL[2]: 9, 15     
#>  NM185[1]: 10        
#>     N3[2]: 11, 18    
#>     N4[2]: 12, 19    
#>  REFEI[1]: 13        
#>   SBRP[1]: 16        
#>  NM1IL[1]: 17        
#>    CLM[1]: 20        
#> DTP434[1]: 21        
#> DTP435[1]: 22        
#> DTP096[1]: 23        
#>  HIABK[3]: 24, 25, 26
#>     LX[3]: 27, 31, 35
#>    SV1[3]: 28, 32, 36
#> DTP472[3]: 29, 33, 37
#>  REF6R[3]: 30, 34, 38
#>     SE[1]: 39        
#>     GE[1]: 40        
#>    IEA[1]: 41        
#> 
#> $sample_837_3
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1059     
#>   Segments: 40       
#>   Problems: 0        
#>  
#>    ISA[1]: 1                     
#>     GS[1]: 2                     
#>     ST[1]: 3                     
#>    BHT[1]: 4                     
#>  NM141[1]: 5                     
#>  PERIC[3]: 6, 8, 14              
#>  NM140[1]: 7                     
#>     HL[2]: 9, 15                 
#>  NM185[1]: 10                    
#>     N3[2]: 11, 18                
#>     N4[2]: 12, 19                
#>  REFEI[1]: 13                    
#>   SBRP[1]: 16                    
#>  NM1IL[1]: 17                    
#>    CLM[1]: 20                    
#> DTP434[1]: 21                    
#> DTP435[1]: 22                    
#> DTP096[1]: 23                    
#>  HIABK[6]: 24, 25, 26, 27, 28, 29
#>     LX[2]: 30, 34                
#>    SV1[2]: 31, 35                
#> DTP472[2]: 32, 36                
#>  REF6R[2]: 33, 37                
#>     SE[1]: 38                    
#>     GE[1]: 39                    
#>    IEA[1]: 40                    
#> 
#> $sample_837_4
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1034     
#>   Segments: 38       
#>   Problems: 0        
#>  
#>    ISA[1]: 1                             
#>     GS[1]: 2                             
#>     ST[1]: 3                             
#>    BHT[1]: 4                             
#>  NM141[1]: 5                             
#>  PERIC[3]: 6, 8, 14                      
#>  NM140[1]: 7                             
#>     HL[2]: 9, 15                         
#>  NM185[1]: 10                            
#>     N3[2]: 11, 18                        
#>     N4[2]: 12, 19                        
#>  REFEI[1]: 13                            
#>   SBRP[1]: 16                            
#>  NM1IL[1]: 17                            
#>    CLM[1]: 20                            
#> DTP434[1]: 21                            
#> DTP435[1]: 22                            
#> DTP096[1]: 23                            
#>  HIABK[8]: 24, 25, 26, 27, 28, 29, 30, 31
#>     LX[1]: 32                            
#>    SV1[1]: 33                            
#> DTP472[1]: 34                            
#>  REF6R[1]: 35                            
#>     SE[1]: 36                            
#>     GE[1]: 37                            
#>    IEA[1]: 38                            
#> 
#> $sample_837_5
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1250     
#>   Segments: 48       
#>   Problems: 0        
#>  
#>    ISA[1]: 1                     
#>     GS[1]: 2                     
#>     ST[1]: 3                     
#>    BHT[1]: 4                     
#>  NM141[1]: 5                     
#>  PERIC[3]: 6, 8, 14              
#>  NM140[1]: 7                     
#>     HL[2]: 9, 15                 
#>  NM185[1]: 10                    
#>     N3[2]: 11, 18                
#>     N4[2]: 12, 19                
#>  REFEI[1]: 13                    
#>   SBRP[1]: 16                    
#>  NM1IL[1]: 17                    
#>    CLM[1]: 20                    
#> DTP434[1]: 21                    
#> DTP435[1]: 22                    
#> DTP096[1]: 23                    
#>  HIABK[6]: 24, 25, 26, 27, 28, 29
#>     LX[4]: 30, 34, 38, 42        
#>    SV1[4]: 31, 35, 39, 43        
#> DTP472[4]: 32, 36, 40, 44        
#>  REF6R[4]: 33, 37, 41, 45        
#>     SE[1]: 46                    
#>     GE[1]: 47                    
#>    IEA[1]: 48                    
#> 
#> $sample_837_6
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1274     
#>   Segments: 52       
#>   Problems: 0        
#>  
#>    ISA[1]: 1                     
#>     GS[1]: 2                     
#>     ST[1]: 3                     
#>    BHT[1]: 4                     
#>  NM141[1]: 5                     
#>  PERIC[3]: 6, 8, 14              
#>  NM140[1]: 7                     
#>     HL[2]: 9, 15                 
#>  NM185[1]: 10                    
#>     N3[2]: 11, 18                
#>     N4[2]: 12, 19                
#>  REFEI[1]: 13                    
#>   SBRP[1]: 16                    
#>  NM1IL[1]: 17                    
#>    CLM[1]: 20                    
#> DTP434[1]: 21                    
#> DTP435[1]: 22                    
#> DTP096[1]: 23                    
#>  HIABK[6]: 24, 25, 26, 27, 28, 29
#>     LX[5]: 30, 34, 38, 42, 46    
#>    SV1[5]: 31, 35, 39, 43, 47    
#> DTP472[5]: 32, 36, 40, 44, 48    
#>  REF6R[5]: 33, 37, 41, 45, 49    
#>     SE[1]: 50                    
#>     GE[1]: 51                    
#>    IEA[1]: 52                    
#> 
#> $sample_837_7
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1203     
#>   Segments: 47       
#>   Problems: 0        
#>  
#>    ISA[1]: 1                 
#>     GS[1]: 2                 
#>     ST[1]: 3                 
#>    BHT[1]: 4                 
#>  NM141[1]: 5                 
#>  PERIC[3]: 6, 8, 14          
#>  NM140[1]: 7                 
#>     HL[2]: 9, 15             
#>  NM185[1]: 10                
#>     N3[2]: 11, 18            
#>     N4[2]: 12, 19            
#>  REFEI[1]: 13                
#>   SBRP[1]: 16                
#>  NM1IL[1]: 17                
#>    CLM[1]: 20                
#> DTP434[1]: 21                
#> DTP435[1]: 22                
#> DTP096[1]: 23                
#>  HIABK[5]: 24, 25, 26, 27, 28
#>     LX[4]: 29, 33, 37, 41    
#>    SV1[4]: 30, 34, 38, 42    
#> DTP472[4]: 31, 35, 39, 43    
#>  REF6R[4]: 32, 36, 40, 44    
#>     SE[1]: 45                
#>     GE[1]: 46                
#>    IEA[1]: 47                
#> 
#> $sample_837_8
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1191     
#>   Segments: 45       
#>   Problems: 0        
#>  
#>    ISA[1]: 1             
#>     GS[1]: 2             
#>     ST[1]: 3             
#>    BHT[1]: 4             
#>  NM141[1]: 5             
#>  PERIC[3]: 6, 8, 14      
#>  NM140[1]: 7             
#>     HL[2]: 9, 15         
#>  NM185[1]: 10            
#>     N3[2]: 11, 18        
#>     N4[2]: 12, 19        
#>  REFEI[1]: 13            
#>   SBRP[1]: 16            
#>  NM1IL[1]: 17            
#>    CLM[1]: 20            
#> DTP434[1]: 21            
#> DTP435[1]: 22            
#> DTP096[1]: 23            
#>  HIABK[3]: 24, 25, 26    
#>     LX[4]: 27, 31, 35, 39
#>    SV1[4]: 28, 32, 36, 40
#> DTP472[4]: 29, 33, 37, 41
#>  REF6R[4]: 30, 34, 38, 42
#>     SE[1]: 43            
#>     GE[1]: 44            
#>    IEA[1]: 45            
#> 
#> $sample_837_9
#> <x12_index>
#>  
#>       Type: 837I-X223
#> Characters: 1290     
#>   Segments: 50       
#>   Problems: 0        
#>  
#>    ISA[1]: 1                             
#>     GS[1]: 2                             
#>     ST[1]: 3                             
#>    BHT[1]: 4                             
#>  NM141[1]: 5                             
#>  PERIC[3]: 6, 8, 14                      
#>  NM140[1]: 7                             
#>     HL[2]: 9, 15                         
#>  NM185[1]: 10                            
#>     N3[2]: 11, 18                        
#>     N4[2]: 12, 19                        
#>  REFEI[1]: 13                            
#>   SBRP[1]: 16                            
#>  NM1IL[1]: 17                            
#>    CLM[1]: 20                            
#> DTP434[1]: 21                            
#> DTP435[1]: 22                            
#> DTP096[1]: 23                            
#>  HIABK[8]: 24, 25, 26, 27, 28, 29, 30, 31
#>     LX[4]: 32, 36, 40, 44                
#>    SV1[4]: 33, 37, 41, 45                
#> DTP472[4]: 34, 38, 42, 46                
#>  REF6R[4]: 35, 39, 43, 47                
#>     SE[1]: 48                            
#>     GE[1]: 49                            
#>    IEA[1]: 50                            
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
#>    ISA[1]: 1     
#>     GS[1]: 2     
#>     ST[1]: 3     
#>    BHT[1]: 4     
#>  NM141[1]: 5     
#>  PERIC[1]: 6     
#>  NM140[1]: 7     
#>     HL[2]: 8, 13 
#>  NM185[1]: 9     
#>     N3[2]: 10, 16
#>     N4[2]: 11, 17
#>  REFEI[1]: 12    
#>   SBRP[1]: 14    
#>  NM1IL[1]: 15    
#>    DMG[1]: 18    
#>  NM1PR[1]: 19    
#>    CLM[1]: 20    
#>   HIBK[1]: 21    
#>  NM182[1]: 22    
#>  PRVPE[1]: 23    
#>     LX[2]: 24, 27
#>    SV1[2]: 25, 28
#> DTP472[2]: 26, 29
#>    AMT[1]: 30    
#>    LIN[1]: 31    
#>    CTP[1]: 32    
#>     SE[1]: 33    
#>     GE[1]: 34    
#>    IEA[1]: 35    
#> 
#> $`837P_EX11_ppo_repriced_claim`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 1209     
#>   Segments: 40       
#>   Problems: 1        
#>  
#>    ISA[1]: 1         
#>     GS[1]: 2         
#>     ST[1]: 3         
#>    BHT[1]: 4         
#>  NM141[1]: 5         
#>  PERIC[2]: 6, 13     
#>  NM140[1]: 7         
#>     HL[2]: 8, 14     
#>  NM185[1]: 9         
#>     N3[3]: 10, 17, 29
#>     N4[3]: 11, 18, 30
#>  REFEI[1]: 12        
#>   SBRP[1]: 15        
#>  NM1IL[1]: 16        
#>    DMG[1]: 19        
#>  NM1PR[1]: 20        
#>    CLM[1]: 21        
#>  REFD9[1]: 23        
#>   HIBK[1]: 24        
#>    HCP[3]: 25, 34, 38
#>  NM1DN[1]: 26        
#>  NM182[1]: 27        
#>  NM177[1]: 28        
#>     LX[2]: 31, 35    
#>    SV1[2]: 32, 36    
#> DTP472[2]: 33, 37    
#>     SE[1]: 39        
#>     GE[1]: 40        
#>    IEA[1]: 41        
#> 
#> $`837P_EX12_oon_repriced_claim`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 1204     
#>   Segments: 42       
#>   Problems: 1        
#>  
#>    ISA[1]: 1             
#>     GS[1]: 2             
#>     ST[1]: 3             
#>    BHT[1]: 4             
#>  NM141[1]: 5             
#>  PERIC[1]: 6             
#>  NM140[1]: 7             
#>     HL[3]: 8, 13, 20     
#>  NM185[1]: 9             
#>     N3[4]: 10, 16, 23, 35
#>     N4[4]: 11, 17, 24, 36
#>  REFEI[1]: 12            
#>   SBRP[1]: 14            
#>  NM1IL[2]: 15, 34        
#>    DMG[2]: 18, 25        
#>  NM1PR[2]: 19, 37        
#>    PAT[1]: 21            
#>  NM1QC[1]: 22            
#>    CLM[1]: 26            
#>  REFD9[1]: 28            
#>   HIBK[1]: 29            
#>    HCP[1]: 30            
#>  NM182[1]: 31            
#>   SBRS[1]: 32            
#>     OI[1]: 33            
#>     LX[1]: 38            
#>    SV1[1]: 39            
#> DTP472[1]: 40            
#>     SE[1]: 41            
#>     GE[1]: 42            
#>    IEA[1]: 43            
#> 
#> $`837P_EX1_commercial-insurance`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 1106     
#>   Segments: 46       
#>   Problems: 0        
#>  
#>    ISA[1]: 1             
#>     GS[1]: 2             
#>     ST[1]: 3             
#>    BHT[1]: 4             
#>  NM141[1]: 5             
#>  PERIC[1]: 6             
#>  NM140[1]: 7             
#>     HL[3]: 8, 17, 23     
#>  PRVBI[1]: 9             
#>  NM185[1]: 10            
#>     N3[3]: 11, 15, 26    
#>     N4[3]: 12, 16, 27    
#>  REFEI[1]: 13            
#>  NM187[1]: 14            
#>   SBRP[1]: 18            
#>  NM1IL[1]: 19            
#>    DMG[2]: 20, 28        
#>  NM1PR[1]: 21            
#>  REFG2[1]: 22            
#>    PAT[1]: 24            
#>  NM1QC[1]: 25            
#>    CLM[1]: 29            
#>  REFD9[1]: 30            
#>   HIBK[1]: 31            
#>     LX[4]: 32, 35, 38, 41
#>    SV1[4]: 33, 36, 39, 42
#> DTP472[4]: 34, 37, 40, 43
#>     SE[1]: 44            
#>     GE[1]: 45            
#>    IEA[1]: 46            
#> 
#> $`837P_EX2_encounter`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 1128     
#>   Segments: 45       
#>   Problems: 0        
#>  
#>    ISA[1]: 1             
#>     GS[1]: 2             
#>     ST[1]: 3             
#>    BHT[1]: 4             
#>  NM141[1]: 5             
#>  PERIC[1]: 6             
#>  NM140[1]: 7             
#>     HL[2]: 8, 17         
#>  PRVBI[1]: 9             
#>  NM185[1]: 10            
#>     N3[4]: 11, 15, 20, 29
#>     N4[4]: 12, 16, 21, 30
#>  REFEI[1]: 13            
#>  NM187[1]: 14            
#>   SBRP[1]: 18            
#>  NM1IL[1]: 19            
#>    DMG[1]: 22            
#>  NM1PR[1]: 23            
#>    CLM[1]: 24            
#> DTP431[1]: 25            
#>  REFD9[1]: 26            
#>   HIBK[1]: 27            
#>  NM177[1]: 28            
#>     LX[4]: 31, 34, 37, 40
#>    SV1[4]: 32, 35, 38, 41
#> DTP472[4]: 33, 36, 39, 42
#>     SE[1]: 43            
#>     GE[1]: 44            
#>    IEA[1]: 45            
#> 
#> $`837P_EX3a_billing_provider_payer_a`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 1379     
#>   Segments: 56       
#>   Problems: 0        
#>  
#>    ISA[1]: 1                     
#>     GS[1]: 2                     
#>     ST[1]: 3                     
#>    BHT[1]: 4                     
#>  NM141[1]: 5                     
#>  PERIC[2]: 6, 13                 
#>  NM140[1]: 7                     
#>     HL[3]: 8, 17, 25             
#>  NM185[1]: 9                     
#>     N3[6]: 10, 15, 22, 28, 37, 42
#>     N4[6]: 11, 16, 23, 29, 38, 43
#>  REFEI[1]: 12                    
#>  NM187[1]: 14                    
#>   SBRP[1]: 18                    
#>  NM1IL[2]: 19, 41                
#>    DMG[2]: 20, 30                
#>  NM1PR[2]: 21, 44                
#>  REFG2[2]: 24, 35                
#>    PAT[1]: 26                    
#>  NM1QC[1]: 27                    
#>    CLM[1]: 31                    
#>   HIBK[1]: 32                    
#>  NM182[1]: 33                    
#>  PRVPE[1]: 34                    
#>  NM177[1]: 36                    
#>   SBRS[1]: 39                    
#>     OI[1]: 40                    
#>     LX[3]: 45, 48, 51            
#>    SV1[3]: 46, 49, 52            
#> DTP472[3]: 47, 50, 53            
#>     SE[1]: 54                    
#>     GE[1]: 55                    
#>    IEA[1]: 56                    
#> 
#> $`837P_EX4_medicare_secondary_cob`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 1185     
#>   Segments: 46       
#>   Problems: 1        
#>  
#>    ISA[1]: 1             
#>     GS[1]: 2             
#>     ST[1]: 3             
#>    BHT[1]: 4             
#>  NM141[1]: 5             
#>  PERIC[1]: 6             
#>  NM140[1]: 7             
#>     HL[2]: 8, 14         
#>  NM185[1]: 9             
#>     N3[4]: 10, 17, 21, 35
#>     N4[4]: 11, 18, 22, 36
#>  REFEI[1]: 12            
#>  REF1G[2]: 13, 26        
#>   SBRS[1]: 15            
#>  NM1IL[2]: 16, 34        
#>    DMG[1]: 19            
#>  NM1PR[2]: 20, 37        
#>    CLM[1]: 23            
#>   HIBK[1]: 24            
#>  NM1DN[1]: 25            
#>  NM182[1]: 27            
#>  PRVPE[1]: 28            
#>  REFG2[1]: 29            
#>   SBRP[1]: 30            
#>    AMT[2]: 31, 32        
#>     OI[1]: 33            
#>     LX[1]: 38            
#>    SV1[1]: 39            
#> DTP472[1]: 40            
#>    CAS[2]: 42, 43        
#> DTP573[1]: 44            
#>     SE[1]: 45            
#>     GE[1]: 46            
#>    IEA[1]: 47            
#> 
#> $`837P_EX5_ambulance`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 1375     
#>   Segments: 56       
#>   Problems: 0        
#>  
#>    ISA[1]: 1                 
#>     GS[1]: 2                 
#>     ST[1]: 3                 
#>    BHT[1]: 4                 
#>  NM141[1]: 5                 
#>  PERIC[1]: 6                 
#>  NM140[1]: 7                 
#>     HL[2]: 8, 14             
#>  PRVBI[1]: 9                 
#>  NM185[1]: 10                
#>     N3[5]: 11, 17, 21, 30, 33
#>     N4[5]: 12, 18, 22, 31, 34
#>  REFEI[1]: 13                
#>   SBRP[1]: 15                
#>  NM1IL[1]: 16                
#>    DMG[1]: 19                
#>  NM1PR[1]: 20                
#>    CLM[1]: 23                
#> DTP439[1]: 24                
#>    CR1[1]: 25                
#>    CRC[2]: 26, 27            
#>   HIBK[1]: 28                
#>  NM1PW[1]: 29                
#>  NM145[1]: 32                
#>     LX[4]: 35, 41, 46, 50    
#>    SV1[4]: 36, 42, 47, 51    
#> DTP472[4]: 37, 43, 48, 52    
#>  QTYPT[2]: 38, 44            
#>  REF6R[4]: 39, 45, 49, 53    
#>    NTE[1]: 40                
#>     SE[1]: 54                
#>     GE[1]: 55                
#>    IEA[1]: 56                
#> 
#> $`837P_EX6_chiropractic`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 920      
#>   Segments: 33       
#>   Problems: 0        
#>  
#>    ISA[1]: 1     
#>     GS[1]: 2     
#>     ST[1]: 3     
#>    BHT[1]: 4     
#>  NM141[1]: 5     
#>  PERIC[2]: 6, 13 
#>  NM140[1]: 7     
#>     HL[2]: 8, 14 
#>  NM185[1]: 9     
#>     N3[2]: 10, 17
#>     N4[2]: 11, 18
#>  REFEI[1]: 12    
#>   SBRP[1]: 15    
#>  NM1IL[1]: 16    
#>    DMG[1]: 19    
#>  NM1PR[1]: 20    
#>    CLM[1]: 21    
#> DTP454[1]: 22    
#> DTP453[1]: 23    
#> DTP455[1]: 24    
#>    CR2[1]: 25    
#>   HIBK[1]: 26    
#>     LX[1]: 27    
#>    SV1[1]: 28    
#> DTP472[1]: 29    
#>  REF6R[1]: 30    
#>     SE[1]: 31    
#>     GE[1]: 32    
#>    IEA[1]: 33    
#> 
#> $`837P_EX7_oxygen`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 1501     
#>   Segments: 66       
#>   Problems: 4        
#>  
#>    ISA[1]: 1                                                           
#>     GS[1]: 2                                                           
#>     ST[1]: 3                                                           
#>    BHT[1]: 4                                                           
#>  NM141[1]: 5                                                           
#>  PERIC[3]: 6, 34, 57                                                   
#>  NM140[1]: 7                                                           
#>     HL[2]: 8, 13                                                       
#>  NM185[1]: 9                                                           
#>     N3[4]: 10, 16, 31, 54                                              
#>     N4[4]: 11, 17, 32, 55                                              
#>  REFEI[1]: 12                                                          
#>   SBRP[1]: 14                                                          
#>  NM1IL[1]: 15                                                          
#>    DMG[1]: 18                                                          
#>  NM1PR[1]: 19                                                          
#>    CLM[1]: 20                                                          
#>   HIBK[1]: 21                                                          
#>     LX[2]: 22, 45                                                      
#>    SV1[2]: 23, 46                                                      
#>    PWK[2]: 24, 47                                                      
#>    CR3[2]: 25, 48                                                      
#> DTP472[2]: 26, 49                                                      
#> DTP463[2]: 28, 51                                                      
#> DTP461[2]: 29, 52                                                      
#>  REF1G[2]: 33, 56                                                      
#>   LQUT[2]: 35, 58                                                      
#>   FRM[18]: 36, 37, 38, 39, 40, 41, 42, 43, 44, 59, 60, 61, 62, 63, ....
#>     SE[1]: 68                                                          
#>     GE[1]: 69                                                          
#>    IEA[1]: 70                                                          
#> 
#> $`837P_EX8_wheelchair`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 1086     
#>   Segments: 46       
#>   Problems: 1        
#>  
#>    ISA[1]: 1                         
#>     GS[1]: 2                         
#>     ST[1]: 3                         
#>    BHT[1]: 4                         
#>  NM141[1]: 5                         
#>  PERIC[2]: 6, 36                     
#>  NM140[1]: 7                         
#>     HL[2]: 8, 14                     
#>  NM185[1]: 9                         
#>     N3[3]: 10, 18, 33                
#>     N4[3]: 11, 19, 34                
#>  REFEI[1]: 12                        
#>  REF1G[2]: 13, 35                    
#>   SBRP[1]: 15                        
#>    PAT[1]: 16                        
#>  NM1IL[1]: 17                        
#>    DMG[1]: 20                        
#>  NM1PR[1]: 21                        
#>    CLM[1]: 22                        
#>   HIBK[1]: 23                        
#>     LX[1]: 24                        
#>    SV1[1]: 25                        
#>    PWK[1]: 26                        
#>    CR3[1]: 27                        
#> DTP472[1]: 28                        
#> DTP463[1]: 29                        
#> DTP461[1]: 30                        
#>    MEA[1]: 31                        
#>   LQUT[1]: 37                        
#>    FRM[7]: 38, 39, 40, 41, 42, 43, 44
#>     SE[1]: 45                        
#>     GE[1]: 46                        
#>    IEA[1]: 47                        
#> 
#> $`837P_EX9_anesthesia`
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 937      
#>   Segments: 33       
#>   Problems: 0        
#>  
#>    ISA[1]: 1         
#>     GS[1]: 2         
#>     ST[1]: 3         
#>    BHT[1]: 4         
#>  NM141[1]: 5         
#>  PERIC[1]: 6         
#>  NM140[1]: 7         
#>     HL[2]: 8, 13     
#>  NM185[1]: 9         
#>     N3[3]: 10, 16, 26
#>     N4[3]: 11, 17, 27
#>  REFEI[1]: 12        
#>   SBRP[1]: 14        
#>  NM1IL[1]: 15        
#>    DMG[1]: 18        
#>  NM1PR[1]: 19        
#>    CLM[1]: 20        
#>   HIBK[1]: 21        
#>  NM182[1]: 22        
#>  PRVPE[1]: 23        
#>  REFG2[1]: 24        
#>  NM177[1]: 25        
#>     LX[1]: 28        
#>    SV1[1]: 29        
#> DTP472[1]: 30        
#>     SE[1]: 31        
#>     GE[1]: 32        
#>    IEA[1]: 33        
#> 
#> $sample_837P
#> [1] NA
#> 
#> $sample_837_0
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 4940     
#>   Segments: 175      
#>   Problems: 0        
#>  
#>    ISA[1]: 1                                                           
#>     GS[1]: 2                                                           
#>     ST[5]: 3, 37, 71, 105, 140                                         
#>    BHT[5]: 4, 38, 72, 106, 141                                         
#>  NM141[5]: 5, 39, 73, 107, 142                                         
#> PERIC[10]: 6, 13, 40, 47, 74, 81, 108, 115, 143, 150                   
#>  NM140[5]: 7, 41, 75, 109, 144                                         
#>    HL[10]: 8, 17, 42, 51, 76, 85, 110, 119, 145, 154                   
#>  NM185[5]: 9, 43, 77, 111, 146                                         
#>    N3[20]: 10, 15, 20, 30, 44, 49, 54, 64, 78, 83, 88, 98, 112, 117....
#>    N4[20]: 11, 16, 21, 31, 45, 50, 55, 65, 79, 84, 89, 99, 113, 118....
#>  REFEI[5]: 12, 46, 80, 114, 149                                        
#>  NM187[5]: 14, 48, 82, 116, 151                                        
#>   SBRP[5]: 18, 52, 86, 120, 155                                        
#>  NM1IL[5]: 19, 53, 87, 121, 156                                        
#>    DMG[5]: 22, 56, 90, 124, 159                                        
#>  NM1PR[5]: 23, 57, 91, 125, 160                                        
#>    CLM[5]: 24, 58, 92, 126, 161                                        
#>  REFD9[5]: 25, 59, 93, 127, 162                                        
#>  HIABK[5]: 26, 60, 94, 128, 163                                        
#>  NM182[5]: 27, 61, 95, 129, 164                                        
#>  PRVPE[5]: 28, 62, 96, 130, 165                                        
#>  NM177[5]: 29, 63, 97, 131, 166                                        
#>     LX[5]: 32, 66, 100, 134, 169                                       
#>    SV1[5]: 33, 67, 101, 135, 170                                       
#> DTP472[5]: 34, 68, 102, 136, 171                                       
#>  REF6R[5]: 35, 69, 103, 137, 172                                       
#>     SE[5]: 36, 70, 104, 139, 173                                       
#>    NTE[1]: 138                                                         
#>     GE[1]: 174                                                         
#>    IEA[1]: 175                                                         
#> 
#> $sample_837_11
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 799      
#>   Segments: 29       
#>   Problems: 0        
#>  
#>    ISA[1]: 1     
#>     GS[1]: 2     
#>     ST[1]: 3     
#>    BHT[1]: 4     
#>  NM141[1]: 5     
#>  PERIC[1]: 6     
#>  NM140[1]: 7     
#>     HL[2]: 8, 13 
#>  NM185[1]: 9     
#>     N3[2]: 10, 16
#>     N4[2]: 11, 17
#>  REFEI[1]: 12    
#>   SBRP[1]: 14    
#>  NM1IL[1]: 15    
#>    DMG[1]: 18    
#>    CLM[1]: 19    
#>  HIABK[1]: 20    
#>  NM182[1]: 21    
#>  PRVPE[1]: 22    
#>    SV1[1]: 23    
#> DTP472[1]: 24    
#>    LIN[1]: 25    
#>    CTP[1]: 26    
#>     SE[1]: 27    
#>     GE[1]: 28    
#>    IEA[1]: 29    
#> 
#> $sample_837_12
#> <x12_index>
#>  
#>       Type: 837P-X222
#> Characters: 2807     
#>   Segments: 113      
#>   Problems: 0        
#>  
#>    ISA[1]: 1                                                 
#>     GS[1]: 2                                                 
#>     ST[3]: 3, 28, 66                                         
#>    BHT[3]: 4, 29, 67                                         
#>  NM141[3]: 5, 30, 68                                         
#>  PERIC[7]: 6, 31, 33, 39, 69, 71, 77                         
#>  NM140[3]: 7, 32, 70                                         
#>     HL[6]: 8, 13, 34, 40, 72, 78                             
#>  NM185[3]: 9, 35, 73                                         
#>     N3[6]: 10, 16, 36, 43, 74, 81                            
#>     N4[6]: 11, 17, 37, 44, 75, 82                            
#>  REFEI[3]: 12, 38, 76                                        
#>   SBRP[3]: 14, 41, 79                                        
#>  NM1IL[3]: 15, 42, 80                                        
#>    DMG[1]: 18                                                
#>    CLM[3]: 19, 45, 83                                        
#> HIABK[13]: 20, 49, 50, 51, 52, 87, 88, 89, 90, 91, 92, 93, 94
#>  NM182[1]: 21                                                
#>  PRVPE[1]: 22                                                
#>    SV1[8]: 23, 54, 58, 62, 96, 100, 104, 108                 
#> DTP472[8]: 24, 55, 59, 63, 97, 101, 105, 109                 
#>    LIN[1]: 25                                                
#>    CTP[1]: 26                                                
#>     SE[3]: 27, 65, 111                                       
#> DTP434[2]: 46, 84                                            
#> DTP435[2]: 47, 85                                            
#> DTP096[2]: 48, 86                                            
#>     LX[7]: 53, 57, 61, 95, 99, 103, 107                      
#>  REF6R[7]: 56, 60, 64, 98, 102, 106, 110                     
#>     GE[1]: 112                                               
#>    IEA[1]: 113                                               
#> 
# purrr::map(hcc::x12_837P[14:16], parse_837)
```
