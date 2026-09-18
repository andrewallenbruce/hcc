# X12-834 (X220A1) Benefit Enrollment Parser

The 834 carries *membership events*:

- new enrollment (qualifier 021)

- change (001)

- termination (024)

- audit/reconciliation (030)

## Usage

``` r
index_834(text)

parse_834(index)
```

## Arguments

- text:

  `<chr>` string of raw X12-834 text

- index:

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
#> $`834_EX2_add_dependent`
#> <x12_index>
#>  
#>       Type: 834-X220
#> Characters: 528     
#>   Segments: 19      
#>   Problems: 0       
#>  
#>     ISA[1]: 1     
#>      GS[1]: 2     
#>      ST[1]: 3     
#>     BGN[1]: 4     
#>  REF_38[1]: 5     
#>  REF_0F[1]: 9     
#>  REF_1L[1]: 10    
#> DTP_348[1]: 16    
#> DTP_351[1]: 11    
#>      N1[2]: 6, 7  
#>     INS[1]: 8     
#>     NM1[2]: 12, 14
#>     DMG[1]: 13    
#>      HD[1]: 15    
#>      SE[1]: 17    
#>      GE[1]: 18    
#>     IEA[1]: 19    
#> 
#> $`834_EX3_enroll_employee_mco`
#> <x12_index>
#>  
#>       Type: 834-X220
#> Characters: 614     
#>   Segments: 22      
#>   Problems: 0       
#>  
#>     ISA[1]: 1     
#>      GS[1]: 2     
#>      ST[1]: 3     
#>     BGN[1]: 4     
#>  REF_0F[1]: 8     
#>  REF_1L[1]: 9     
#> DTP_348[1]: 17    
#> DTP_356[1]: 10    
#>      N1[2]: 5, 6  
#>     INS[1]: 7     
#>     NM1[2]: 11, 19
#>     PER[1]: 12    
#>      N3[1]: 13    
#>      N4[1]: 14    
#>     DMG[1]: 15    
#>      LX[1]: 18    
#>      HD[1]: 16    
#>      SE[1]: 20    
#>      GE[1]: 21    
#>     IEA[1]: 22    
#> 
#> $`834_EX4_add_subscriber_coverage`
#> <x12_index>
#>  
#>       Type: 834-X220
#> Characters: 463     
#>   Segments: 16      
#>   Problems: 0       
#>  
#>     ISA[1]: 1   
#>      GS[1]: 2   
#>      ST[1]: 3   
#>     BGN[1]: 4   
#>  REF_38[1]: 5   
#>  REF_0F[1]: 9   
#>  REF_1L[1]: 10  
#> DTP_348[1]: 13  
#>      N1[2]: 6, 7
#>     INS[1]: 8   
#>     NM1[1]: 11  
#>      HD[1]: 12  
#>      SE[1]: 14  
#>      GE[1]: 15  
#>     IEA[1]: 16  
#> 
#> $`834_EX5_change_subscriber_info`
#> <x12_index>
#>  
#>       Type: 834-X220
#> Characters: 490     
#>   Segments: 16      
#>   Problems: 0       
#>  
#>    ISA[1]: 1     
#>     GS[1]: 2     
#>     ST[1]: 3     
#>    BGN[1]: 4     
#> REF_0F[1]: 8     
#> REF_1L[1]: 9     
#>     N1[2]: 5, 6  
#>    INS[1]: 7     
#>    NM1[2]: 10, 12
#>    DMG[2]: 11, 13
#>     SE[1]: 14    
#>     GE[1]: 15    
#>    IEA[1]: 16    
#> 
#> $`834_EX6_cancel_dependent`
#> <x12_index>
#>  
#>       Type: 834-X220
#> Characters: 460     
#>   Segments: 16      
#>   Problems: 0       
#>  
#>     ISA[1]: 1   
#>      GS[1]: 2   
#>      ST[1]: 3   
#>     BGN[1]: 4   
#>  REF_38[1]: 5   
#>  REF_0F[1]: 9   
#>  REF_1L[1]: 10  
#> DTP_357[1]: 11  
#>      N1[2]: 6, 7
#>     INS[1]: 8   
#>     NM1[1]: 12  
#>     DMG[1]: 13  
#>      SE[1]: 14  
#>      GE[1]: 15  
#>     IEA[1]: 16  
#> 
#> $`834_EX7_terminate_subscriber_eligibility`
#> <x12_index>
#>  
#>       Type: 834-X220
#> Characters: 428     
#>   Segments: 14      
#>   Problems: 0       
#>  
#>     ISA[1]: 1   
#>      GS[1]: 2   
#>      ST[1]: 3   
#>     BGN[1]: 4   
#>  REF_0F[1]: 8   
#>  REF_1L[1]: 9   
#> DTP_357[1]: 10  
#>      N1[2]: 5, 6
#>     INS[1]: 7   
#>     NM1[1]: 11  
#>      SE[1]: 12  
#>      GE[1]: 13  
#>     IEA[1]: 14  
#> 
#> $`834_EX8_reinstate_employee`
#> <x12_index>
#>  
#>       Type: 834-X220
#> Characters: 446     
#>   Segments: 15      
#>   Problems: 0       
#>  
#>     ISA[1]: 1   
#>      GS[1]: 2   
#>      ST[1]: 3   
#>     BGN[1]: 4   
#>  REF_38[1]: 5   
#>  REF_0F[1]: 9   
#>  REF_1L[1]: 10  
#> DTP_303[1]: 11  
#>      N1[2]: 6, 7
#>     INS[1]: 8   
#>     NM1[1]: 12  
#>      SE[1]: 13  
#>      GE[1]: 14  
#>     IEA[1]: 15  
#> 
#> $`834_EX9_reinstate_employee_coverage`
#> <x12_index>
#>  
#>       Type: 834-X220
#> Characters: 460     
#>   Segments: 16      
#>   Problems: 0       
#>  
#>     ISA[1]: 1   
#>      GS[1]: 2   
#>      ST[1]: 3   
#>     BGN[1]: 4   
#>  REF_38[1]: 5   
#>  REF_0F[1]: 9   
#>  REF_1L[1]: 10  
#> DTP_348[1]: 13  
#>      N1[2]: 6, 7
#>     INS[1]: 8   
#>     NM1[1]: 11  
#>      HD[1]: 12  
#>      SE[1]: 14  
#>      GE[1]: 15  
#>     IEA[1]: 16  
#> 
#> $sample_834_01
#> <x12_index>
#>  
#>       Type: 834-X220
#> Characters: 1769    
#>   Segments: 71      
#>   Problems: 0       
#>  
#>     ISA[1]: 1                             
#>      GS[1]: 2                             
#>      ST[1]: 3                             
#>     BGN[1]: 4                             
#>  REF_38[1]: 5                             
#>  REF_0F[5]: 10, 24, 37, 52, 61            
#>  REF_1D[4]: 12, 26, 39, 53                
#>  REF_6P[4]: 11, 25, 38, 62                
#>  REF_AB[1]: 27                            
#> REF_ABB[2]: 13, 40                        
#> DTP_007[1]: 6                             
#> DTP_348[8]: 20, 22, 33, 35, 46, 49, 59, 68
#> DTP_349[2]: 47, 50                        
#>      N1[2]: 7, 8                          
#>     INS[5]: 9, 23, 36, 51, 60             
#>     NM1[5]: 14, 28, 41, 54, 63            
#>     PER[1]: 15                            
#>      N3[5]: 16, 29, 42, 55, 64            
#>      N4[5]: 17, 30, 43, 56, 65            
#>     DMG[5]: 18, 31, 44, 57, 66            
#>      HD[8]: 19, 21, 32, 34, 45, 48, 58, 67
#>      SE[1]: 69                            
#>      GE[1]: 70                            
#>     IEA[1]: 71                            
#> 
#> $sample_834_02
#> <x12_index>
#>  
#>       Type: 834-X220
#> Characters: 925     
#>   Segments: 33      
#>   Problems: 0       
#>  
#>     ISA[1]: 1     
#>      GS[1]: 2     
#>      ST[1]: 3     
#>     BGN[1]: 4     
#>     QTY[1]: 5     
#>  REF_0F[1]: 9     
#>  REF_1L[1]: 10    
#>  REF_17[2]: 11, 25
#>  REF_23[1]: 12    
#>  REF_3H[1]: 13    
#>  REF_6O[1]: 14    
#>  REF_ZZ[2]: 15, 30
#>  REF_ZX[1]: 29    
#>  REF_CE[1]: 27    
#>  REF_RB[1]: 28    
#>  REF_9V[1]: 26    
#> DTP_348[1]: 23    
#> DTP_349[1]: 24    
#>      N1[2]: 6, 7  
#>     INS[1]: 8     
#>     NM1[1]: 16    
#>     PER[1]: 17    
#>      N3[1]: 18    
#>      N4[1]: 19    
#>     DMG[1]: 20    
#>     LUI[1]: 21    
#>      HD[1]: 22    
#>      SE[1]: 31    
#>      GE[1]: 32    
#>     IEA[1]: 33    
#> 
#> $sample_834_03
#> <x12_index>
#>  
#>       Type: 834-X220
#> Characters: 998     
#>   Segments: 36      
#>   Problems: 0       
#>  
#>     ISA[1]: 1     
#>      GS[1]: 2     
#>      ST[1]: 3     
#>     BGN[1]: 4     
#>     QTY[1]: 5     
#>  REF_0F[1]: 9     
#>  REF_1L[1]: 10    
#>  REF_17[2]: 11, 28
#>  REF_23[1]: 12    
#>  REF_3H[1]: 13    
#>  REF_6O[1]: 14    
#>  REF_ZZ[2]: 18, 33
#>  REF_ZX[1]: 32    
#>  REF_CE[1]: 30    
#>  REF_RB[1]: 31    
#>  REF_DX[1]: 15    
#>  REF_F6[1]: 16    
#>  REF_QQ[1]: 17    
#>  REF_9V[1]: 29    
#> DTP_348[1]: 26    
#> DTP_349[1]: 27    
#>      N1[2]: 6, 7  
#>     INS[1]: 8     
#>     NM1[1]: 19    
#>     PER[1]: 20    
#>      N3[1]: 21    
#>      N4[1]: 22    
#>     DMG[1]: 23    
#>     LUI[1]: 24    
#>      HD[1]: 25    
#>      SE[1]: 34    
#>      GE[1]: 35    
#>     IEA[1]: 36    
#> 
#> $sample_834_04
#> <x12_index>
#>  
#>       Type: 834-X220
#> Characters: 990     
#>   Segments: 35      
#>   Problems: 0       
#>  
#>     ISA[1]: 1     
#>      GS[1]: 2     
#>      ST[1]: 3     
#>     BGN[1]: 4     
#>     QTY[1]: 5     
#>  REF_0F[1]: 9     
#>  REF_1L[1]: 10    
#>  REF_17[2]: 11, 27
#>  REF_23[1]: 12    
#>  REF_3H[1]: 13    
#>  REF_6O[1]: 14    
#>  REF_ZZ[2]: 18, 32
#>  REF_ZX[1]: 31    
#>  REF_CE[1]: 29    
#>  REF_RB[1]: 30    
#>  REF_DX[1]: 15    
#>  REF_F6[1]: 16    
#>  REF_QQ[1]: 17    
#>  REF_9V[1]: 28    
#> DTP_348[1]: 25    
#> DTP_349[1]: 26    
#>      N1[2]: 6, 7  
#>     INS[1]: 8     
#>     NM1[1]: 19    
#>     PER[1]: 20    
#>      N3[1]: 21    
#>      N4[1]: 22    
#>     DMG[1]: 23    
#>      HD[1]: 24    
#>      SE[1]: 33    
#>      GE[1]: 34    
#>     IEA[1]: 35    
#> 
#> $sample_834_05
#> <x12_index>
#>  
#>       Type: 834-X220
#> Characters: 992     
#>   Segments: 35      
#>   Problems: 0       
#>  
#>     ISA[1]: 1     
#>      GS[1]: 2     
#>      ST[1]: 3     
#>     BGN[1]: 4     
#>     QTY[1]: 5     
#>  REF_0F[1]: 9     
#>  REF_1L[1]: 10    
#>  REF_17[2]: 11, 28
#>  REF_23[1]: 12    
#>  REF_3H[1]: 13    
#>  REF_6O[1]: 14    
#>  REF_ZZ[2]: 18, 32
#>  REF_ZX[1]: 31    
#>  REF_CE[1]: 30    
#>  REF_DX[1]: 15    
#>  REF_F6[1]: 16    
#>  REF_QQ[1]: 17    
#>  REF_9V[1]: 29    
#> DTP_348[1]: 25    
#> DTP_349[1]: 26    
#>      N1[2]: 6, 7  
#>     INS[1]: 8     
#>     NM1[1]: 19    
#>     PER[1]: 20    
#>      N3[1]: 21    
#>      N4[1]: 22    
#>     DMG[1]: 23    
#>     AMT[1]: 27    
#>      HD[1]: 24    
#>      SE[1]: 33    
#>      GE[1]: 34    
#>     IEA[1]: 35    
#> 
#> $sample_834_06
#> <x12_index>
#>  
#>       Type: 834-X220
#> Characters: 1658    
#>   Segments: 68      
#>   Problems: 0       
#>  
#>     ISA[1]: 1                 
#>      GS[1]: 2                 
#>      ST[1]: 3                 
#>     BGN[1]: 4                 
#>     QTY[1]: 5                 
#>  REF_0F[2]: 9, 42             
#>  REF_1L[2]: 10, 43            
#>  REF_17[5]: 11, 28, 36, 44, 60
#>  REF_23[2]: 12, 45            
#>  REF_3H[2]: 13, 46            
#>  REF_6O[2]: 14, 47            
#>  REF_Q4[1]: 15                
#>  REF_ZZ[5]: 16, 32, 40, 51, 65
#>  REF_ZX[3]: 31, 39, 64        
#>  REF_CE[3]: 29, 37, 62        
#>  REF_RB[3]: 30, 38, 63        
#>  REF_DX[1]: 48                
#>  REF_F6[1]: 49                
#>  REF_QQ[1]: 50                
#>  REF_9V[1]: 61                
#> DTP_348[3]: 26, 34, 58        
#> DTP_349[3]: 27, 35, 59        
#>      N1[2]: 6, 7              
#>     INS[2]: 8, 41             
#>     NM1[3]: 17, 22, 52        
#>     PER[2]: 18, 53            
#>      N3[3]: 19, 23, 54        
#>      N4[3]: 20, 24, 55        
#>     DMG[2]: 21, 56            
#>      HD[3]: 25, 33, 57        
#>      SE[1]: 66                
#>      GE[1]: 67                
#>     IEA[1]: 68                
#> 
```
