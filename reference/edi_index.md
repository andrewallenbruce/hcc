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
# edi_index(x12_EX$`834`)
edi_index(purrr::list_flatten(x12_EX$`820`))
#> $`218_820_Child_Health_Plus_Payment_EFT`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X218                           
#>  Segments: [23]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                                   
#>    Detail [5] BPR > TRN > REF•14 > N1•PE > N1•PR
#>   Trailer [3] SE > GE > IE                                                                                    
#> 
#> ── Entity [12] ─────────────────────────────────────────────────────────────────
#>    ENT 01                                                                                                              
#>    RMR•1L > REF•ZZ                                                                                                                     
#>    RMR•1L > REF•ZZ                                                                                                                     
#>    ENT 02 > NM1•QE                                                                      
#>    RMR•AZ > REF•ZZ > REF•ZZ > REF•LU > DTM
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`218_820_Essentail_Health_Plan`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X218                           
#>  Segments: [21]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                                                                                                           
#>    Detail [7] BPR > TRN > REF•14 > N1•PE > N1•PR > N3 > N4
#>   Trailer [3] SE > GE > IE                                                                                                                                                            
#> 
#> ── Entity [8] ──────────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•QE                                                                                                              
#>    RMR•AZ > REF•ZZ > REF•ZZ > REF•LU > REF•ZZ > DTM
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`218_820_Premium_Payment_EFT`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X218                           
#>  Segments: [26]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                                   
#>    Detail [5] BPR > TRN > REF•14 > N1•PE > N1•PR
#>   Trailer [3] SE > GE > IE                                                                                    
#> 
#> ── Entity [15] ─────────────────────────────────────────────────────────────────
#>    ENT 01                                        
#>    RMR•1L > REF•ZZ                                               
#>    RMR•1L > REF•ZZ                                               
#>    RMR•1L > REF•ZZ                                               
#>    ENT 02 > NM1•QE
#>    RMR•IK > ADX                                                  
#>    ENT 03 > NM1•QE
#>    RMR•IK > ADX                                                  
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`218_820_Premium_Payment_NOPMT`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X218                           
#>  Segments: [22]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                                                                                                           
#>    Detail [7] BPR > TRN > REF•14 > N1•PE > N1•PR > N3 > N4
#>   Trailer [3] SE > GE > IE                                                                                                                                                            
#> 
#> ── Entity [9] ──────────────────────────────────────────────────────────────────
#>    ENT 01                                        
#>    RMR•1L > REF•ZZ                                               
#>    RMR•1L > REF•ZZ                                               
#>    ENT 02 > NM1•QE
#>    RMR•IK > ADX                                                  
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`218_payment_order_820_218`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X218                           
#>  Segments: [19]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                                   
#>    Detail [5] BPR > TRN > REF•14 > N1•PE > N1•PR
#>   Trailer [3] SE > GE > IE                                                                                    
#> 
#> ── Entity [8] ──────────────────────────────────────────────────────────────────
#>    ENT 01                                                                
#>    RMR•IK > IT1 > SLN > SLN
#>    RMR•IK > IT1 > SLN                                     
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`218_sample_820_01`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X218                            
#>  Segments: [104]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                                                                                                                                                                                   
#>    Detail [9] BPR > TRN > REF•14 > N1•PE > N3 > N4 > N1•PR > N3 > N4
#>   Trailer [3] SE > GE > IE                                                                                                                                                                                                                                    
#> 
#> ── Entity [89] ─────────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 02 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 03 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 04 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 05 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 06 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 07 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 08 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 09 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 10 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 11 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 12 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`218_sample_820_02`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X218                            
#>  Segments: [166]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                                                                                                                                                                                   
#>    Detail [9] BPR > TRN > REF•14 > N1•PE > N3 > N4 > N1•PR > N3 > N4
#>   Trailer [3] SE > GE > IE                                                                                                                                                                                                                                    
#> 
#> ── Entity [151] ────────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 02 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 03 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 04 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 05 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 06 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 07 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 08 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 09 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 10 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 11 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 12 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 13 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`218_sample_820_03`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X218                             
#>  Segments: [1146]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                                                                                                                                                                                   
#>    Detail [9] BPR > TRN > REF•14 > N1•PE > N3 > N4 > N1•PR > N3 > N4
#>   Trailer [3] SE > GE > IE                                                                                                                                                                                                                                    
#> 
#> ── Entity [1131] ───────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 02 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 03 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 04 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 05 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 06 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 07 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 08 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 09 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 10 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 11 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 12 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 13 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 14 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 15 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 16 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 17 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 18 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 19 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 20 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 21 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 22 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 23 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 24 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 25 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 26 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 27 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 28 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 29 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 30 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 31 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 32 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 33 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 34 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 35 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 36 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 37 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 38 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 39 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 40 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 41 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 42 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 43 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 44 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 45 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 46 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 47 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 48 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 49 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 50 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 51 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 52 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 53 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 54 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 55 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 56 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 57 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 58 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 59 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 60 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 61 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 62 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 63 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 64 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 65 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 66 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 67 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 68 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 69 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 70 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 71 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 72 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 73 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 74 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 75 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 76 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 77 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 78 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 79 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 80 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 81 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 82 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 83 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 84 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 85 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 86 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 87 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 88 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 89 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 90 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 91 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    ENT 92 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM > ADX
#>    ENT 93 > NM1•IL                                                                                                           
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM                                     
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`218_sample_820_04`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X218                           
#>  Segments: [95]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                                                                                                                                                                                   
#>    Detail [9] BPR > TRN > REF•14 > N1•PE > N3 > N4 > N1•PR > N3 > N4
#>   Trailer [3] SE > GE > IE                                                                                                                                                                                                                                    
#> 
#> ── Entity [80] ─────────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 02 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 03 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 04 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 05 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 06 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 07 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 08 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 09 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 10 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`218_sample_820_05`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X218                            
#>  Segments: [647]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                                                                                                                                                                                   
#>    Detail [9] BPR > TRN > REF•14 > N1•PE > N3 > N4 > N1•PR > N3 > N4
#>   Trailer [3] SE > GE > IE                                                                                                                                                                                                                                    
#> 
#> ── Entity [632] ────────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 02 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 03 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 04 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 05 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 06 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 07 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 08 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 09 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 10 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 11 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 12 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 13 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 14 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 15 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 16 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 17 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 18 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 19 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 20 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 21 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 22 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 23 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 24 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 25 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 26 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 27 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 28 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 29 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 30 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 31 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 32 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 33 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 34 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 35 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 36 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 37 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 38 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 39 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 40 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 41 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 42 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 43 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 44 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 45 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 46 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 47 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 48 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 49 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 50 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 51 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 52 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 53 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 54 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 55 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 56 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 57 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 58 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 59 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 60 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 61 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 62 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 63 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 64 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 65 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 66 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 67 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 68 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 69 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 70 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 71 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 72 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 73 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 74 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 75 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 76 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 77 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 78 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 79 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 80 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#>    ENT 81 > NM1•IL                                                                      
#>    RMR•IK > REF•18 > REF•ZZ > REF•ZZ > DTM
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX10_debt_covered_by_affiliate1`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X306                           
#>  Segments: [42]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                               
#>    Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#>   Trailer [3] SE > GE > IE                                                                                
#> 
#> ── Entity [31] ─────────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    ENT 02 > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    ENT 03                                                                                                                                                                                                        
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX11_debt_covered_by_affiliate2`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X306                           
#>  Segments: [43]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                               
#>    Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#>   Trailer [3] SE > GE > IE                                                                                
#> 
#> ── Entity [32] ─────────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    ENT 02 > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    ENT 03                                                                                                                                                                                                        
#>    RMR•ZZ > REF•0N > DTM                                                                                                                                                                          
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX12_csr_manual_adj`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X306                           
#>  Segments: [34]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                               
#>    Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#>   Trailer [3] SE > GE > IE                                                                                
#> 
#> ── Entity [23] ─────────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    ENT 02 > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    ENT 03                                                                                                                                                                                                        
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX1_different_types_of_pmt_by_HIX`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X306                           
#>  Segments: [41]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                                                                           
#>    Detail [6] BPR > TRN > REF•38 > REF•TV > N1•PE > N1•RM
#>   Trailer [3] SE > GE > IE                                                                                                                            
#> 
#> ── Entity [29] ─────────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•IL > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                          
#>    ENT 02 > NM1•IL > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                          
#>    ENT 03 > NM1•IL > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                          
#>    ENT 04 > NM1•IL > REF•PO > REF•AZ                                        
#>    RMR•ZZ > DTM                                                                                                                                                                          
#>    RMR•ZZ > DTM                                                                                                                                                                          
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX2_payments_exceed_charges1`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X306                           
#>  Segments: [38]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                               
#>    Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#>   Trailer [3] SE > GE > IE                                                                                
#> 
#> ── Entity [27] ─────────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    ENT 02 > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    ENT 03                                                                                                                                                                                                        
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX3_payments_exceed_charges2`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X306                           
#>  Segments: [35]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                               
#>    Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#>   Trailer [3] SE > GE > IE                                                                                
#> 
#> ── Entity [24] ─────────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    ENT 02 > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX4_charges_exceed_payments1`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X306                           
#>  Segments: [32]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                               
#>    Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#>   Trailer [3] SE > GE > IE                                                                                
#> 
#> ── Entity [21] ─────────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•IL > REF•38 > REF•1L > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                                                          
#>    ENT 02 > NM1•IL > REF•38 > REF•1L > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                                                          
#>    ENT 03                                                                                                                                                                                                                                                
#>    RMR•ZZ > DTM                                                                                                                                                                                                                                                          
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX5_charges_exceed_payments2`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X306                           
#>  Segments: [32]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                               
#>    Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#>   Trailer [3] SE > GE > IE                                                                                
#> 
#> ── Entity [21] ─────────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•IL > REF•38 > REF•1L > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                                                          
#>    ENT 02 > NM1•IL > REF•38 > REF•1L > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                                                          
#>    ENT 03                                                                                                                                                                                                                                                
#>    RMR•ZZ > DTM                                                                                                                                                                                                                                                          
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX6_aptc_adjustments1`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X306                           
#>  Segments: [42]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                               
#>    Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#>   Trailer [3] SE > GE > IE                                                                                
#> 
#> ── Entity [31] ─────────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    ENT 02 > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    ENT 03                                                                                                                                                                                                        
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX7_aptc_adjustments2`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X306                           
#>  Segments: [39]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                               
#>    Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#>   Trailer [3] SE > GE > IE                                                                                
#> 
#> ── Entity [28] ─────────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    ENT 02 > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX8_outstanding_debt_owed1`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X306                           
#>  Segments: [38]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                               
#>    Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#>   Trailer [3] SE > GE > IE                                                                                
#> 
#> ── Entity [27] ─────────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    ENT 02 > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    ENT 03                                                                                                                                                                                                        
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_820_EX9_outstanding_debt_owed2`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X306                           
#>  Segments: [39]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                               
#>    Detail [5] BPR > TRN > N1•PE > N1•RM > PE
#>   Trailer [3] SE > GE > IE                                                                                
#> 
#> ── Entity [28] ─────────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    ENT 02 > NM1•IL > REF•38 > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    RMR•ZZ > DTM                                                                                                                                                                                                                  
#>    ENT 03                                                                                                                                                                                                        
#>    RMR•ZZ > REF•0N > DTM                                                                                                                                                                          
#> ────────────────────────────────────────────────────────────────────────────────
#> 
#> $`306_payment_order_820_360`
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>      Type: 820-X306                           
#>  Segments: [41]
#> ────────────────────────────────────────────────────────────────────────────────
#>    Header [3] ISA > GS > ST                                                                                                                           
#>    Detail [6] BPR > TRN > REF•38 > REF•TV > N1•PE > N1•RM
#>   Trailer [3] SE > GE > IE                                                                                                                            
#> 
#> ── Entity [29] ─────────────────────────────────────────────────────────────────
#>    ENT 01 > NM1•IL > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                          
#>    ENT 02 > NM1•IL > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                          
#>    ENT 03 > NM1•IL > REF•PO > REF•AZ > REF•0F
#>    RMR•ZZ > DTM                                                                                                                                                                          
#>    ENT 04 > NM1•IL > REF•PO > REF•AZ                                        
#>    RMR•ZZ > DTM                                                                                                                                                                          
#>    RMR•ZZ > DTM                                                                                                                                                                          
#> ────────────────────────────────────────────────────────────────────────────────
#> 
```
