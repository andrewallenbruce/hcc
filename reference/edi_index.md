# Create an EDI Index Object

Create an EDI Index Object

## Usage

``` r
edi_index(x, ...)
```

## Arguments

- x:

  raw X12 text input

- ...:

  dots

## Value

an `<hcc::IndexEDI>` S7 object

## Details

Methods for `edi_index`:

- `ANY`

- `character`

- `hcc::IndexEDI`

- `hcc::Text820`

- `hcc::Text834`

- `hcc::Text837`

- `list`

## Examples

``` r
edi_index(x12_EX$`834`)
#> $`834_EX2_add_dependent`
#> 
#> ── <hcc::Index834> ─────────────────────────────────────────────────────────────
#>     Type: 834-X220
#> Segments: 19      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header  [3] ISA > GS > ST                   
#>  Detail  [4] BGN > REF > N1                  
#>  Member  [1] INS > REF > DTP > NM1 > DMG > HD
#> Trailer  [3] SE > GE > IEA                   
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`834_EX3_enroll_employee_mco`
#> 
#> ── <hcc::Index834> ─────────────────────────────────────────────────────────────
#>     Type: 834-X220
#> Segments: 22      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header  [3] ISA > GS > ST                                        
#>  Detail  [3] BGN > N1                                             
#>  Member  [1] INS > REF > DTP > NM1 > PER > N3 > N4 > DMG > HD > LX
#> Trailer  [3] SE > GE > IEA                                        
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`834_EX4_add_subscriber_coverage`
#> 
#> ── <hcc::Index834> ─────────────────────────────────────────────────────────────
#>     Type: 834-X220
#> Segments: 16      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header  [3] ISA > GS > ST             
#>  Detail  [4] BGN > REF > N1            
#>  Member  [1] INS > REF > NM1 > HD > DTP
#> Trailer  [3] SE > GE > IEA             
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`834_EX5_change_subscriber_info`
#> 
#> ── <hcc::Index834> ─────────────────────────────────────────────────────────────
#>     Type: 834-X220
#> Segments: 16      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header  [3] ISA > GS > ST        
#>  Detail  [3] BGN > N1             
#>  Member  [1] INS > REF > NM1 > DMG
#> Trailer  [3] SE > GE > IEA        
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`834_EX6_cancel_dependent`
#> 
#> ── <hcc::Index834> ─────────────────────────────────────────────────────────────
#>     Type: 834-X220
#> Segments: 16      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header  [3] ISA > GS > ST              
#>  Detail  [4] BGN > REF > N1             
#>  Member  [1] INS > REF > DTP > NM1 > DMG
#> Trailer  [3] SE > GE > IEA              
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`834_EX7_terminate_subscriber_eligibility`
#> 
#> ── <hcc::Index834> ─────────────────────────────────────────────────────────────
#>     Type: 834-X220
#> Segments: 14      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header  [3] ISA > GS > ST        
#>  Detail  [3] BGN > N1             
#>  Member  [1] INS > REF > DTP > NM1
#> Trailer  [3] SE > GE > IEA        
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`834_EX8_reinstate_employee`
#> 
#> ── <hcc::Index834> ─────────────────────────────────────────────────────────────
#>     Type: 834-X220
#> Segments: 15      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header  [3] ISA > GS > ST        
#>  Detail  [4] BGN > REF > N1       
#>  Member  [1] INS > REF > DTP > NM1
#> Trailer  [3] SE > GE > IEA        
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`834_EX9_reinstate_employee_coverage`
#> 
#> ── <hcc::Index834> ─────────────────────────────────────────────────────────────
#>     Type: 834-X220
#> Segments: 16      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header  [3] ISA > GS > ST             
#>  Detail  [4] BGN > REF > N1            
#>  Member  [1] INS > REF > NM1 > HD > DTP
#> Trailer  [3] SE > GE > IEA             
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $benefit_enrollment_834_220
#> 
#> ── <hcc::Index834> ─────────────────────────────────────────────────────────────
#>     Type: 834-X220
#> Segments: 25      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header  [3] ﻿IS > GS > ST                                          
#>  Detail  [3] BGN > N1                                              
#>  Member  [1] INS > REF > DTP > NM1 > PER > N3 > N4 > DMG > HD > COB
#> Trailer  [3] SE > GE > IEA                                         
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $sample_834_01
#> 
#> ── <hcc::Index834> ─────────────────────────────────────────────────────────────
#>     Type: 834-X220
#> Segments: 71      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header  [3] ISA > GS > ST                                   
#>  Detail  [5] BGN > REF > DTP > N1                            
#>  Member  [5] INS > REF > NM1 > PER > N3 > N4 > DMG > HD > DTP
#> Trailer  [3] SE > GE > IEA                                   
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $sample_834_02
#> 
#> ── <hcc::Index834> ─────────────────────────────────────────────────────────────
#>     Type: 834-X220
#> Segments: 33      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header  [3] ISA > GS > ST                                         
#>  Detail  [4] BGN > QTY > N1                                        
#>  Member  [1] INS > REF > NM1 > PER > N3 > N4 > DMG > LUI > HD > DTP
#> Trailer  [3] SE > GE > IEA                                         
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $sample_834_03
#> 
#> ── <hcc::Index834> ─────────────────────────────────────────────────────────────
#>     Type: 834-X220
#> Segments: 36      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header  [3] ISA > GS > ST                                         
#>  Detail  [4] BGN > QTY > N1                                        
#>  Member  [1] INS > REF > NM1 > PER > N3 > N4 > DMG > LUI > HD > DTP
#> Trailer  [3] SE > GE > IEA                                         
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $sample_834_04
#> 
#> ── <hcc::Index834> ─────────────────────────────────────────────────────────────
#>     Type: 834-X220
#> Segments: 35      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header  [3] ISA > GS > ST                                   
#>  Detail  [4] BGN > QTY > N1                                  
#>  Member  [1] INS > REF > NM1 > PER > N3 > N4 > DMG > HD > DTP
#> Trailer  [3] SE > GE > IEA                                   
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $sample_834_05
#> 
#> ── <hcc::Index834> ─────────────────────────────────────────────────────────────
#>     Type: 834-X220
#> Segments: 35      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header  [3] ISA > GS > ST                                         
#>  Detail  [4] BGN > QTY > N1                                        
#>  Member  [1] INS > REF > NM1 > PER > N3 > N4 > DMG > HD > DTP > AMT
#> Trailer  [3] SE > GE > IEA                                         
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $sample_834_06
#> 
#> ── <hcc::Index834> ─────────────────────────────────────────────────────────────
#>     Type: 834-X220
#> Segments: 68      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header  [3] ISA > GS > ST                                   
#>  Detail  [4] BGN > QTY > N1                                  
#>  Member  [2] INS > REF > NM1 > PER > N3 > N4 > DMG > HD > DTP
#> Trailer  [3] SE > GE > IEA                                   
#> ────────────────────────────────────────────────────────────────────────────────
#> 
edi_index(purrr::list_flatten(x12_EX$`820`))
#> $`218_820_Child_Health_Plus_Payment_EFT`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X218
#> Segments: 23      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                                                   
#>  Detail [5] BPR > TRN > REF•14 > N1•PE > N1•PR
#> Trailer [3] SE > GE > IE                                                                                                                                    
#> 
#> ── Entity Loop [12] ────────────────────────────────────────────────────────────
#>    ENT                                                                                                                                                                                                  
#>    RMR > REF•ZZ                                                                                                                                                                         
#>    RMR > REF•ZZ                                                                                                                                                                         
#>    ENT > NM1•QE                                                                                                                                                         
#>    RMR > REF•ZZ > REF•ZZ > REF•LU > DTM•582
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`218_820_Essentail_Health_Plan`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X218
#> Segments: 21      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                                                                                                                           
#>  Detail [7] BPR > TRN > REF•14 > N1•PE > N1•PR > N3 > N4
#> Trailer [3] SE > GE > IE                                                                                                                                                                                                            
#> 
#> ── Entity Loop [8] ─────────────────────────────────────────────────────────────
#>    ENT > NM1•QE                                                                                                                                                                                                                 
#>    RMR > REF•ZZ > REF•ZZ > REF•LU > REF•ZZ > DTM•582
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`218_820_Premium_Payment_EFT`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X218
#> Segments: 26      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                                                   
#>  Detail [5] BPR > TRN > REF•14 > N1•PE > N1•PR
#> Trailer [3] SE > GE > IE                                                                                                                                    
#> 
#> ── Entity Loop [15] ────────────────────────────────────────────────────────────
#>    ENT                                         
#>    RMR > REF•ZZ                
#>    RMR > REF•ZZ                
#>    RMR > REF•ZZ                
#>    ENT > NM1•QE
#>    RMR > AD                                    
#>    ENT > NM1•QE
#>    RMR > AD                                    
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`218_820_Premium_Payment_NOPMT`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X218
#> Segments: 22      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                                                                                                                           
#>  Detail [7] BPR > TRN > REF•14 > N1•PE > N1•PR > N3 > N4
#> Trailer [3] SE > GE > IE                                                                                                                                                                                                            
#> 
#> ── Entity Loop [9] ─────────────────────────────────────────────────────────────
#>    ENT                                         
#>    RMR > REF•ZZ                
#>    RMR > REF•ZZ                
#>    ENT > NM1•QE
#>    RMR > AD                                    
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`218_payment_order_820_218`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X218
#> Segments: 19      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                                                   
#>  Detail [5] BPR > TRN > REF•14 > N1•PE > N1•PR
#> Trailer [3] SE > GE > IE                                                                                                                                    
#> 
#> ── Entity Loop [8] ─────────────────────────────────────────────────────────────
#>    ENT                                                                                
#>    RMR > IT1 > SLN > SLN
#>    RMR > IT1 > SLN                                     
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`218_sample_820_01`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X218
#> Segments: 104     
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                                                                                                                                                                                                   
#>  Detail [9] BPR > TRN > REF•14 > N1•PE > N3 > N4 > N1•PR > N3 > N4
#> Trailer [3] SE > GE > IE                                                                                                                                                                                                                                                                                    
#> 
#> ── Entity Loop [89] ────────────────────────────────────────────────────────────
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`218_sample_820_02`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X218
#> Segments: 166     
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                                                                                                                                                                                                   
#>  Detail [9] BPR > TRN > REF•14 > N1•PE > N3 > N4 > N1•PR > N3 > N4
#> Trailer [3] SE > GE > IE                                                                                                                                                                                                                                                                                    
#> 
#> ── Entity Loop [151] ───────────────────────────────────────────────────────────
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`218_sample_820_03`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X218
#> Segments: 1146    
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                                                                                                                                                                                                   
#>  Detail [9] BPR > TRN > REF•14 > N1•PE > N3 > N4 > N1•PR > N3 > N4
#> Trailer [3] SE > GE > IE                                                                                                                                                                                                                                                                                    
#> 
#> ── Entity Loop [1131] ──────────────────────────────────────────────────────────
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582 > AD
#>    ENT > NM1•IL                                                                                                                                                                                             
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582                                    
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`218_sample_820_04`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X218
#> Segments: 95      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                                                                                                                                                                                                   
#>  Detail [9] BPR > TRN > REF•14 > N1•PE > N3 > N4 > N1•PR > N3 > N4
#> Trailer [3] SE > GE > IE                                                                                                                                                                                                                                                                                    
#> 
#> ── Entity Loop [80] ────────────────────────────────────────────────────────────
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`218_sample_820_05`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X218
#> Segments: 647     
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                                                                                                                                                                                                   
#>  Detail [9] BPR > TRN > REF•14 > N1•PE > N3 > N4 > N1•PR > N3 > N4
#> Trailer [3] SE > GE > IE                                                                                                                                                                                                                                                                                    
#> 
#> ── Entity Loop [632] ───────────────────────────────────────────────────────────
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#>    ENT > NM1•IL                                                                                                                                                         
#>    RMR > REF•18 > REF•ZZ > REF•ZZ > DTM•582
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX10_debt_covered_by_affiliate1`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X306
#> Segments: 42      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                               
#>  Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#> Trailer [3] SE > GE > IE                                                                                                                
#> 
#> ── Entity Loop [31] ────────────────────────────────────────────────────────────
#>    ENT > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    ENT > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    ENT                                                                                                                                                                                                                                                                         
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX11_debt_covered_by_affiliate2`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X306
#> Segments: 43      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                               
#>  Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#> Trailer [3] SE > GE > IE                                                                                                                
#> 
#> ── Entity Loop [32] ────────────────────────────────────────────────────────────
#>    ENT > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    ENT > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    ENT                                                                                                                                                                                                                                                                         
#>    RMR > REF•0N > DTM•582                                                                                                                                                                                       
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX12_csr_manual_adj`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X306
#> Segments: 34      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                               
#>  Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#> Trailer [3] SE > GE > IE                                                                                                                
#> 
#> ── Entity Loop [23] ────────────────────────────────────────────────────────────
#>    ENT > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    ENT > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    ENT                                                                                                                                                                                                                                                                         
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX1_different_types_of_pmt_by_HIX`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X306
#> Segments: 41      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                                                                                                           
#>  Detail [6] BPR > TRN > REF•38 > REF•TV > N1•PE > N1•RM
#> Trailer [3] SE > GE > IE                                                                                                                                                                                            
#> 
#> ── Entity Loop [29] ────────────────────────────────────────────────────────────
#>    ENT > NM1•IL > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                       
#>    ENT > NM1•IL > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                       
#>    ENT > NM1•IL > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                       
#>    ENT > NM1•IL > REF•PO > REF•AZ                                                        
#>    RMR > DTM•582                                                                                                                                                                                       
#>    RMR > DTM•582                                                                                                                                                                                       
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX2_payments_exceed_charges1`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X306
#> Segments: 38      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                               
#>  Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#> Trailer [3] SE > GE > IE                                                                                                                
#> 
#> ── Entity Loop [27] ────────────────────────────────────────────────────────────
#>    ENT > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    ENT > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    ENT                                                                                                                                                                                                                                                                         
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX3_payments_exceed_charges2`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X306
#> Segments: 35      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                               
#>  Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#> Trailer [3] SE > GE > IE                                                                                                                
#> 
#> ── Entity Loop [24] ────────────────────────────────────────────────────────────
#>    ENT > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    ENT > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX4_charges_exceed_payments1`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X306
#> Segments: 32      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                               
#>  Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#> Trailer [3] SE > GE > IE                                                                                                                
#> 
#> ── Entity Loop [21] ────────────────────────────────────────────────────────────
#>    ENT > NM1•IL > REF•38 > REF•1L > REF•PO > REF•AZ …
#>    RMR > DTM•582                                                                                                                                                                                                                                                                                
#>    ENT > NM1•IL > REF•38 > REF•1L > REF•PO > REF•AZ …
#>    RMR > DTM•582                                                                                                                                                                                                                                                                                
#>    ENT                                                                                                                                                                                                                                                                                                          
#>    RMR > DTM•582                                                                                                                                                                                                                                                                                
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX5_charges_exceed_payments2`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X306
#> Segments: 32      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                               
#>  Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#> Trailer [3] SE > GE > IE                                                                                                                
#> 
#> ── Entity Loop [21] ────────────────────────────────────────────────────────────
#>    ENT > NM1•IL > REF•38 > REF•1L > REF•PO > REF•AZ …
#>    RMR > DTM•582                                                                                                                                                                                                                                                                                
#>    ENT > NM1•IL > REF•38 > REF•1L > REF•PO > REF•AZ …
#>    RMR > DTM•582                                                                                                                                                                                                                                                                                
#>    ENT                                                                                                                                                                                                                                                                                                          
#>    RMR > DTM•582                                                                                                                                                                                                                                                                                
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX6_aptc_adjustments1`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X306
#> Segments: 42      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                               
#>  Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#> Trailer [3] SE > GE > IE                                                                                                                
#> 
#> ── Entity Loop [31] ────────────────────────────────────────────────────────────
#>    ENT > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    ENT > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    ENT                                                                                                                                                                                                                                                                         
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX7_aptc_adjustments2`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X306
#> Segments: 39      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                               
#>  Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#> Trailer [3] SE > GE > IE                                                                                                                
#> 
#> ── Entity Loop [28] ────────────────────────────────────────────────────────────
#>    ENT > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    ENT > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX8_outstanding_debt_owed1`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X306
#> Segments: 38      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                               
#>  Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#> Trailer [3] SE > GE > IE                                                                                                                
#> 
#> ── Entity Loop [27] ────────────────────────────────────────────────────────────
#>    ENT > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    ENT > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    ENT                                                                                                                                                                                                                                                                         
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX9_outstanding_debt_owed2`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X306
#> Segments: 39      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                               
#>  Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#> Trailer [3] SE > GE > IE                                                                                                                
#> 
#> ── Entity Loop [28] ────────────────────────────────────────────────────────────
#>    ENT > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    ENT > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    RMR > DTM•582                                                                                                                                                                                                                                               
#>    ENT                                                                                                                                                                                                                                                                         
#>    RMR > REF•0N > DTM•582                                                                                                                                                                                       
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_payment_order_820_360`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X306
#> Segments: 41      
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header [3] ISA > GS > ST                                                                                                                                                                                           
#>  Detail [6] BPR > TRN > REF•38 > REF•TV > N1•PE > N1•RM
#> Trailer [3] SE > GE > IE                                                                                                                                                                                            
#> 
#> ── Entity Loop [29] ────────────────────────────────────────────────────────────
#>    ENT > NM1•IL > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                       
#>    ENT > NM1•IL > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                       
#>    ENT > NM1•IL > REF•PO > REF•AZ > REF•0F
#>    RMR > DTM•582                                                                                                                                                                                       
#>    ENT > NM1•IL > REF•PO > REF•AZ                                                        
#>    RMR > DTM•582                                                                                                                                                                                       
#>    RMR > DTM•582                                                                                                                                                                                       
#> ────────────────────────────────────────────────────────────────────────────────
#> 
```
