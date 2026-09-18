# X12-820 (X306/X218) Payment Order/Remittance Advice Parser

Parses X12-820 (005010X218) transactions for Medicaid/Medicare
capitation and premium payments. Designed for California DHCS PACE
capitation remittances but handles the general 820 format used by state
Medicaid agencies.

## Usage

``` r
index_820(text)

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
purrr::map(hcc::x12_820, index_820)
#> $`820_EX10_debt_covered_by_affiliate1`
#> <x12_index>
#>  
#>       Type: X12-820-X306
#> Characters: 1078        
#>   Segments: 42          
#>   Problems: 0           
#>  
#>     ISA[1]: 1                                 
#>      GS[1]: 2                                 
#>      ST[1]: 3                                 
#>     BPR[1]: 4                                 
#>     TRN[1]: 5                                 
#>   N1_PE[1]: 6                                 
#>   N1_RM[1]: 7                                 
#>  PER_IC[1]: 8                                 
#>     ENT[3]: 9, 25, 37                         
#>     NM1[2]: 10, 26                            
#>  REF_38[2]: 11, 27                            
#> REF_POL[2]: 12, 28                            
#>  REF_AZ[2]: 13, 29                            
#>  REF_0F[2]: 14, 30                            
#>     RMR[9]: 15, 17, 19, 21, 23, 31, 33, 35, 38
#> DTM_582[9]: 16, 18, 20, 22, 24, 32, 34, 36, 39
#>      SE[1]: 40                                
#>      GE[1]: 41                                
#>     IEA[1]: 42                                
#> 
#> $`820_EX11_debt_covered_by_affiliate2`
#> <x12_index>
#>  
#>       Type: X12-820-X306
#> Characters: 1119        
#>   Segments: 43          
#>   Problems: 0           
#>  
#>     ISA[1]: 1                                 
#>      GS[1]: 2                                 
#>      ST[1]: 3                                 
#>     BPR[1]: 4                                 
#>     TRN[1]: 5                                 
#>   N1_PE[1]: 6                                 
#>   N1_RM[1]: 7                                 
#>  PER_IC[1]: 8                                 
#>     ENT[3]: 9, 25, 37                         
#>     NM1[2]: 10, 26                            
#>  REF_38[2]: 11, 27                            
#> REF_POL[2]: 12, 28                            
#>  REF_AZ[2]: 13, 29                            
#>  REF_0F[2]: 14, 30                            
#>     RMR[9]: 15, 17, 19, 21, 23, 31, 33, 35, 38
#> DTM_582[9]: 16, 18, 20, 22, 24, 32, 34, 36, 40
#>  REF_0N[1]: 39                                
#>      SE[1]: 41                                
#>      GE[1]: 42                                
#>     IEA[1]: 43                                
#> 
#> $`820_EX12_csr_manual_adj`
#> <x12_index>
#>  
#>       Type: X12-820-X306
#> Characters: 865         
#>   Segments: 34          
#>   Problems: 0           
#>  
#>     ISA[1]: 1                 
#>      GS[1]: 2                 
#>      ST[1]: 3                 
#>     BPR[1]: 4                 
#>     TRN[1]: 5                 
#>   N1_PE[1]: 6                 
#>   N1_RM[1]: 7                 
#>  PER_IC[1]: 8                 
#>     ENT[3]: 9, 19, 29         
#>     NM1[2]: 10, 20            
#>  REF_38[2]: 11, 21            
#> REF_POL[2]: 12, 22            
#>  REF_AZ[2]: 13, 23            
#>  REF_0F[2]: 14, 24            
#>     RMR[5]: 15, 17, 25, 27, 30
#> DTM_582[5]: 16, 18, 26, 28, 31
#>      SE[1]: 32                
#>      GE[1]: 33                
#>     IEA[1]: 34                
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`
#> <x12_index>
#>  
#>       Type: X12-820-X306
#> Characters: 989         
#>   Segments: 41          
#>   Problems: 0           
#>  
#>     ISA[1]: 1                 
#>      GS[1]: 2                 
#>      ST[1]: 3                 
#>     BPR[1]: 4                 
#>     TRN[1]: 5                 
#>  REF_38[1]: 6                 
#>  REF_TV[1]: 7                 
#>   N1_PE[1]: 8                 
#>   N1_RM[1]: 9                 
#>     ENT[4]: 10, 17, 24, 31    
#>     NM1[4]: 11, 18, 25, 32    
#> REF_POL[4]: 12, 19, 26, 33    
#>  REF_AZ[4]: 13, 20, 27, 34    
#>  REF_0F[3]: 14, 21, 28        
#>     RMR[5]: 15, 22, 29, 35, 37
#> DTM_582[5]: 16, 23, 30, 36, 38
#>      SE[1]: 39                
#>      GE[1]: 40                
#>     IEA[1]: 41                
#> 
#> $`820_EX2_payments_exceed_charges1`
#> <x12_index>
#>  
#>       Type: X12-820-X306
#> Characters: 963         
#>   Segments: 38          
#>   Problems: 0           
#>  
#>     ISA[1]: 1                         
#>      GS[1]: 2                         
#>      ST[1]: 3                         
#>     BPR[1]: 4                         
#>     TRN[1]: 5                         
#>   N1_PE[1]: 6                         
#>   N1_RM[1]: 7                         
#>  PER_IC[1]: 8                         
#>     ENT[3]: 9, 21, 33                 
#>     NM1[2]: 10, 22                    
#>  REF_38[2]: 11, 23                    
#> REF_POL[2]: 12, 24                    
#>  REF_AZ[2]: 13, 25                    
#>  REF_0F[2]: 14, 26                    
#>     RMR[7]: 15, 17, 19, 27, 29, 31, 34
#> DTM_582[7]: 16, 18, 20, 28, 30, 32, 35
#>      SE[1]: 36                        
#>      GE[1]: 37                        
#>     IEA[1]: 38                        
#> 
#> $`820_EX3_payments_exceed_charges2`
#> <x12_index>
#>  
#>       Type: X12-820-X306
#> Characters: 937         
#>   Segments: 35          
#>   Problems: 0           
#>  
#>     ISA[1]: 1                     
#>      GS[1]: 2                     
#>      ST[1]: 3                     
#>     BPR[1]: 4                     
#>     TRN[1]: 5                     
#>   N1_PE[1]: 6                     
#>   N1_RM[1]: 7                     
#>  PER_IC[1]: 8                     
#>     ENT[2]: 9, 21                 
#>     NM1[2]: 10, 22                
#>  REF_38[2]: 11, 23                
#> REF_POL[2]: 12, 24                
#>  REF_AZ[2]: 13, 25                
#>  REF_0F[2]: 14, 26                
#>     RMR[6]: 15, 17, 19, 27, 29, 31
#> DTM_582[6]: 16, 18, 20, 28, 30, 32
#>      SE[1]: 33                    
#>      GE[1]: 34                    
#>     IEA[1]: 35                    
#> 
#> $`820_EX4_charges_exceed_payments1`
#> <x12_index>
#>  
#>       Type: X12-820-X306
#> Characters: 788         
#>   Segments: 32          
#>   Problems: 0           
#>  
#>     ISA[1]: 1         
#>      GS[1]: 2         
#>      ST[1]: 3         
#>     BPR[1]: 4         
#>     TRN[1]: 5         
#>   N1_PE[1]: 6         
#>   N1_RM[1]: 7         
#>  PER_IC[1]: 8         
#>     ENT[3]: 9, 18, 27 
#>     NM1[2]: 10, 19    
#>  REF_38[2]: 11, 20    
#>  REF_1L[2]: 12, 21    
#> REF_POL[2]: 13, 22    
#>  REF_AZ[2]: 14, 23    
#>  REF_0F[2]: 15, 24    
#>     RMR[3]: 16, 25, 28
#> DTM_582[3]: 17, 26, 29
#>      SE[1]: 30        
#>      GE[1]: 31        
#>     IEA[1]: 32        
#> 
#> $`820_EX5_charges_exceed_payments2`
#> <x12_index>
#>  
#>       Type: X12-820-X306
#> Characters: 792         
#>   Segments: 32          
#>   Problems: 0           
#>  
#>     ISA[1]: 1         
#>      GS[1]: 2         
#>      ST[1]: 3         
#>     BPR[1]: 4         
#>     TRN[1]: 5         
#>   N1_PE[1]: 6         
#>   N1_RM[1]: 7         
#>  PER_IC[1]: 8         
#>     ENT[3]: 9, 18, 27 
#>     NM1[2]: 10, 19    
#>  REF_38[2]: 11, 20    
#>  REF_1L[2]: 12, 21    
#> REF_POL[2]: 13, 22    
#>  REF_AZ[2]: 14, 23    
#>  REF_0F[2]: 15, 24    
#>     RMR[3]: 16, 25, 28
#> DTM_582[3]: 17, 26, 29
#>      SE[1]: 30        
#>      GE[1]: 31        
#>     IEA[1]: 32        
#> 
#> $`820_EX6_aptc_adjustments1`
#> <x12_index>
#>  
#>       Type: X12-820-X306
#> Characters: 1069        
#>   Segments: 42          
#>   Problems: 0           
#>  
#>     ISA[1]: 1                                 
#>      GS[1]: 2                                 
#>      ST[1]: 3                                 
#>     BPR[1]: 4                                 
#>     TRN[1]: 5                                 
#>   N1_PE[1]: 6                                 
#>   N1_RM[1]: 7                                 
#>  PER_IC[1]: 8                                 
#>     ENT[3]: 9, 25, 37                         
#>     NM1[2]: 10, 26                            
#>  REF_38[2]: 11, 27                            
#> REF_POL[2]: 12, 28                            
#>  REF_AZ[2]: 13, 29                            
#>  REF_0F[2]: 14, 30                            
#>     RMR[9]: 15, 17, 19, 21, 23, 31, 33, 35, 38
#> DTM_582[9]: 16, 18, 20, 22, 24, 32, 34, 36, 39
#>      SE[1]: 40                                
#>      GE[1]: 41                                
#>     IEA[1]: 42                                
#> 
#> $`820_EX7_aptc_adjustments2`
#> <x12_index>
#>  
#>       Type: X12-820-X306
#> Characters: 1043        
#>   Segments: 39          
#>   Problems: 0           
#>  
#>     ISA[1]: 1                             
#>      GS[1]: 2                             
#>      ST[1]: 3                             
#>     BPR[1]: 4                             
#>     TRN[1]: 5                             
#>   N1_PE[1]: 6                             
#>   N1_RM[1]: 7                             
#>  PER_IC[1]: 8                             
#>     ENT[2]: 9, 25                         
#>     NM1[2]: 10, 26                        
#>  REF_38[2]: 11, 27                        
#> REF_POL[2]: 12, 28                        
#>  REF_AZ[2]: 13, 29                        
#>  REF_0F[2]: 14, 30                        
#>     RMR[8]: 15, 17, 19, 21, 23, 31, 33, 35
#> DTM_582[8]: 16, 18, 20, 22, 24, 32, 34, 36
#>      SE[1]: 37                            
#>      GE[1]: 38                            
#>     IEA[1]: 39                            
#> 
#> $`820_EX8_outstanding_debt_owed1`
#> <x12_index>
#>  
#>       Type: X12-820-X306
#> Characters: 960         
#>   Segments: 38          
#>   Problems: 0           
#>  
#>     ISA[1]: 1                         
#>      GS[1]: 2                         
#>      ST[1]: 3                         
#>     BPR[1]: 4                         
#>     TRN[1]: 5                         
#>   N1_PE[1]: 6                         
#>   N1_RM[1]: 7                         
#>  PER_IC[1]: 8                         
#>     ENT[3]: 9, 21, 33                 
#>     NM1[2]: 10, 22                    
#>  REF_38[2]: 11, 23                    
#> REF_POL[2]: 12, 24                    
#>  REF_AZ[2]: 13, 25                    
#>  REF_0F[2]: 14, 26                    
#>     RMR[7]: 15, 17, 19, 27, 29, 31, 34
#> DTM_582[7]: 16, 18, 20, 28, 30, 32, 35
#>      SE[1]: 36                        
#>      GE[1]: 37                        
#>     IEA[1]: 38                        
#> 
#> $`820_EX9_outstanding_debt_owed2`
#> <x12_index>
#>  
#>       Type: X12-820-X306
#> Characters: 1033        
#>   Segments: 39          
#>   Problems: 0           
#>  
#>     ISA[1]: 1                         
#>      GS[1]: 2                         
#>      ST[1]: 3                         
#>     BPR[1]: 4                         
#>     TRN[1]: 5                         
#>   N1_PE[1]: 6                         
#>   N1_RM[1]: 7                         
#>  PER_IC[1]: 8                         
#>     ENT[3]: 9, 21, 33                 
#>     NM1[2]: 10, 22                    
#>  REF_38[2]: 11, 23                    
#> REF_POL[2]: 12, 24                    
#>  REF_AZ[2]: 13, 25                    
#>  REF_0F[2]: 14, 26                    
#>     RMR[7]: 15, 17, 19, 27, 29, 31, 34
#> DTM_582[7]: 16, 18, 20, 28, 30, 32, 36
#>  REF_0N[1]: 35                        
#>      SE[1]: 37                        
#>      GE[1]: 38                        
#>     IEA[1]: 39                        
#> 
#> $sample_820_01
#> <x12_index>
#>  
#>       Type: X12-820-X218
#> Characters: 3118        
#>   Segments: 104         
#>   Problems: 0           
#>  
#>      ISA[1]: 1                                                           
#>       GS[1]: 2                                                           
#>       ST[1]: 3                                                           
#>      BPR[1]: 4                                                           
#>      TRN[1]: 5                                                           
#>   REF_14[1]: 6                                                           
#>    N1_PE[1]: 7                                                           
#>    N3_PE[1]: 8                                                           
#>    N4_PE[1]: 9                                                           
#>    N1_PR[1]: 10                                                          
#>    N3_PR[1]: 11                                                          
#>    N4_PR[1]: 12                                                          
#>     ENT[12]: 13, 20, 27, 34, 41, 48, 55, 67, 74, 81, 88, 95              
#>     NM1[12]: 14, 21, 28, 35, 42, 49, 56, 68, 75, 82, 89, 96              
#>     RMR[13]: 15, 22, 29, 36, 43, 50, 57, 62, 69, 76, 83, 90, 97          
#>  REF_18[13]: 16, 23, 30, 37, 44, 51, 58, 63, 70, 77, 84, 91, 98          
#>  REF_ZZ[26]: 17, 18, 24, 25, 31, 32, 38, 39, 45, 46, 52, 53, 59, 60, ....
#> DTM_582[13]: 19, 26, 33, 40, 47, 54, 61, 66, 73, 80, 87, 94, 101         
#>       SE[1]: 102                                                         
#>       GE[1]: 103                                                         
#>      IEA[1]: 104                                                         
#> 
#> $sample_820_02
#> <x12_index>
#>  
#>       Type: X12-820-X218
#> Characters: 4757        
#>   Segments: 166         
#>   Problems: 0           
#>  
#>      ISA[1]: 1                                                           
#>       GS[1]: 2                                                           
#>       ST[1]: 3                                                           
#>      BPR[1]: 4                                                           
#>      TRN[1]: 5                                                           
#>   REF_14[1]: 6                                                           
#>    N1_PE[1]: 7                                                           
#>    N3_PE[1]: 8                                                           
#>    N4_PE[1]: 9                                                           
#>    N1_PR[1]: 10                                                          
#>    N3_PR[1]: 11                                                          
#>    N4_PR[1]: 12                                                          
#>     ENT[13]: 13, 26, 39, 52, 64, 77, 90, 97, 110, 123, 136, 144, 157     
#>     NM1[13]: 14, 27, 40, 53, 65, 78, 91, 98, 111, 124, 137, 145, 158     
#>     RMR[23]: 15, 20, 28, 33, 41, 46, 54, 59, 66, 71, 79, 84, 92, 99, ....
#>  REF_18[23]: 16, 21, 29, 34, 42, 47, 55, 60, 67, 72, 80, 85, 93, 100,....
#>  REF_ZZ[46]: 17, 18, 22, 23, 30, 31, 35, 36, 43, 44, 48, 49, 56, 57, ....
#> DTM_582[23]: 19, 24, 32, 37, 45, 50, 58, 63, 70, 75, 83, 88, 96, 103,....
#>     ADX[10]: 25, 38, 51, 76, 89, 109, 122, 135, 143, 156                 
#>       SE[1]: 164                                                         
#>       GE[1]: 165                                                         
#>      IEA[1]: 166                                                         
#> 
#> $sample_820_03
#> <x12_index>
#>  
#>       Type: X12-820-X218
#> Characters: 33189       
#>   Segments: 1146        
#>   Problems: 0           
#>  
#>       ISA[1]: 1                                                           
#>        GS[1]: 2                                                           
#>        ST[1]: 3                                                           
#>       BPR[1]: 4                                                           
#>       TRN[1]: 5                                                           
#>    REF_14[1]: 6                                                           
#>     N1_PE[1]: 7                                                           
#>     N3_PE[1]: 8                                                           
#>     N4_PE[1]: 9                                                           
#>     N1_PR[1]: 10                                                          
#>     N3_PR[1]: 11                                                          
#>     N4_PR[1]: 12                                                          
#>      ENT[93]: 13, 26, 39, 46, 59, 72, 79, 92, 99, 112, 125, 138, 151, ....
#>      NM1[93]: 14, 27, 40, 47, 60, 73, 80, 93, 100, 113, 126, 139, 152,....
#>     RMR[176]: 15, 20, 28, 33, 41, 48, 53, 61, 66, 74, 81, 86, 94, 101,....
#>  REF_18[176]: 16, 21, 29, 34, 42, 49, 54, 62, 67, 75, 82, 87, 95, 102,....
#>  REF_ZZ[352]: 17, 18, 22, 23, 30, 31, 35, 36, 43, 44, 50, 51, 55, 56, ....
#> DTM_582[176]: 19, 24, 32, 37, 45, 52, 57, 65, 70, 78, 85, 90, 98, 105,....
#>      ADX[65]: 25, 38, 58, 71, 91, 111, 124, 137, 150, 163, 188, 201, 2....
#>        SE[1]: 1144                                                        
#>        GE[1]: 1145                                                        
#>       IEA[1]: 1146                                                        
#> 
#> $sample_820_04
#> <x12_index>
#>  
#>       Type: X12-820-X218
#> Characters: 2819        
#>   Segments: 95          
#>   Problems: 0           
#>  
#>      ISA[1]: 1                                                           
#>       GS[1]: 2                                                           
#>       ST[1]: 3                                                           
#>      BPR[1]: 4                                                           
#>      TRN[1]: 5                                                           
#>   REF_14[1]: 6                                                           
#>    N1_PE[1]: 7                                                           
#>    N3_PE[1]: 8                                                           
#>    N4_PE[1]: 9                                                           
#>    N1_PR[1]: 10                                                          
#>    N3_PR[1]: 11                                                          
#>    N4_PR[1]: 12                                                          
#>     ENT[10]: 13, 20, 37, 44, 51, 58, 65, 72, 79, 86                      
#>     NM1[10]: 14, 21, 38, 45, 52, 59, 66, 73, 80, 87                      
#>     RMR[12]: 15, 22, 27, 32, 39, 46, 53, 60, 67, 74, 81, 88              
#>  REF_18[12]: 16, 23, 28, 33, 40, 47, 54, 61, 68, 75, 82, 89              
#>  REF_ZZ[24]: 17, 18, 24, 25, 29, 30, 34, 35, 41, 42, 48, 49, 55, 56, ....
#> DTM_582[12]: 19, 26, 31, 36, 43, 50, 57, 64, 71, 78, 85, 92              
#>       SE[1]: 93                                                          
#>       GE[1]: 94                                                          
#>      IEA[1]: 95                                                          
#> 
#> $sample_820_05
#> <x12_index>
#>  
#>       Type: X12-820-X218
#> Characters: 19564       
#>   Segments: 647         
#>   Problems: 0           
#>  
#>      ISA[1]: 1                                                           
#>       GS[1]: 2                                                           
#>       ST[1]: 3                                                           
#>      BPR[1]: 4                                                           
#>      TRN[1]: 5                                                           
#>   REF_14[1]: 6                                                           
#>    N1_PE[1]: 7                                                           
#>    N3_PE[1]: 8                                                           
#>    N4_PE[1]: 9                                                           
#>    N1_PR[1]: 10                                                          
#>    N3_PR[1]: 11                                                          
#>    N4_PR[1]: 12                                                          
#>     ENT[81]: 13, 20, 27, 34, 41, 48, 55, 62, 69, 76, 88, 95, 102, 109....
#>     NM1[81]: 14, 21, 28, 35, 42, 49, 56, 63, 70, 77, 89, 96, 103, 110....
#>     RMR[94]: 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 83, 90, 97, 104,....
#>  REF_18[94]: 16, 23, 30, 37, 44, 51, 58, 65, 72, 79, 84, 91, 98, 105,....
#> REF_ZZ[188]: 17, 18, 24, 25, 31, 32, 38, 39, 45, 46, 52, 53, 59, 60, ....
#> DTM_582[94]: 19, 26, 33, 40, 47, 54, 61, 68, 75, 82, 87, 94, 101, 108....
#>       SE[1]: 645                                                         
#>       GE[1]: 646                                                         
#>      IEA[1]: 647                                                         
#> 
#> $stedi_820_06
#> [1] NA
#> 
#> $stedi_820_07
#> [1] NA
#> 
# purrr::map(hcc::x12_820[13:17], parse_820)
```
