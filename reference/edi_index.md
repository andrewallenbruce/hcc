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
edi_index(x12_EX$`820`$`218`$sample_820_05)
#> 
#> ── <hcc::Index820> ─────────────────────────────────────────────────────────────
#>     Type: 820-X218
#> Segments: 647     
#> ────────────────────────────────────────────────────────────────────────────────
#>  Header  [3] ISA > GS > ST
#>  Detail  [9] BPR > TRN > REF > N1 > N3 > N4
#> Trailer  [3] SE > GE > IEA
#> 
#> ── Entity Loop ──
#> 
#>      Entity [81] <2>                    
#> Remittances [81] [5]<71> [10]<9> [25]<1>
#> ────────────────────────────────────────────────────────────────────────────────
edi_index(x12_EX$`820`$`306`[[1]])
#> ── <hcc::IndexEDI> ─────────────────────────────────────────────────────────────
#>     Type: 820-X306
#> Segments: 42      
#> ────────────────────────────────────────────────────────────────────────────────
#>    ISA [1] 1                                 
#>     GS [1] 2                                 
#>     ST [1] 3                                 
#>    BPR [1] 4                                 
#> DTM582 [9] 16, 18, 20, 22, 24, 32, 34, 36, 39
#>    ENT [3] 9, 25, 37                         
#>   N1PE [1] 6                                 
#>   N1RM [1] 7                                 
#>    NM1 [2] 10, 26                            
#>  PERIC [1] 8                                 
#>  REF18 [0]                                   
#>  REF23 [0]                                   
#>  REF38 [2] 11, 27                            
#>  REF0F [2] 14, 30                            
#>  REF0N [0]                                   
#>  REF1L [0]                                   
#>  REF1W [0]                                   
#>  REF4A [0]                                   
#>  REF60 [0]                                   
#> REFABY [0]                                   
#>  REFAZ [2] 13, 29                            
#> REFPOL [2] 12, 28                            
#>  REFTV [0]                                   
#>  REFZZ [0]                                   
#>    RMR [9] 15, 17, 19, 21, 23, 31, 33, 35, 38
#>    TRN [1] 5                                 
#>     SE [1] 40                                
#>     GE [1] 41                                
#>    IEA [1] 42                                
#> ────────────────────────────────────────────────────────────────────────────────
```
