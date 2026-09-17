# X12-820 Payment Order/Remittance Advice Parser

Parses X12-820 (005010X218) transactions for Medicaid/Medicare
capitation and premium payments. Designed for California DHCS PACE
capitation remittances but handles the general 820 format used by state
Medicaid agencies.

## Usage

``` r
parse_820(text)

index_820(text)
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
#>       Type: X12-820
#> Characters: 1078   
#>   Segments: 42     
#>   Problems: 0      
#>  
#>    ISA: 1
#>     GS: 1
#>     ST: 1
#>    BPR: 1
#>    TRN: 1
#>   N1PE: 1
#>   N3PE: 1
#>   N4PE: 1
#>  REF0F: 2
#>  REF38: 2
#>  REFAZ: 2
#> REFPOL: 2
#>    ENT: 3
#>    NM1: 2
#>    RMR: 9
#>    DTM: 9
#>     SE: 1
#>     GE: 1
#>    IEA: 1
#> 
#> $`820_EX11_debt_covered_by_affiliate2`
#> <x12_index>
#>  
#>       Type: X12-820
#> Characters: 1119   
#>   Segments: 43     
#>   Problems: 0      
#>  
#>    ISA: 1
#>     GS: 1
#>     ST: 1
#>    BPR: 1
#>    TRN: 1
#>   N1PE: 1
#>   N3PE: 1
#>   N4PE: 1
#>  REF0F: 2
#>  REF0N: 1
#>  REF38: 2
#>  REFAZ: 2
#> REFPOL: 2
#>    ENT: 3
#>    NM1: 2
#>    RMR: 9
#>    DTM: 9
#>     SE: 1
#>     GE: 1
#>    IEA: 1
#> 
#> $`820_EX12_csr_manual_adj`
#> <x12_index>
#>  
#>       Type: X12-820
#> Characters: 865    
#>   Segments: 34     
#>   Problems: 0      
#>  
#>    ISA: 1
#>     GS: 1
#>     ST: 1
#>    BPR: 1
#>    TRN: 1
#>   N1PE: 1
#>   N3PE: 1
#>   N4PE: 1
#>  REF0F: 2
#>  REF38: 2
#>  REFAZ: 2
#> REFPOL: 2
#>    ENT: 3
#>    NM1: 2
#>    RMR: 5
#>    DTM: 5
#>     SE: 1
#>     GE: 1
#>    IEA: 1
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`
#> <x12_index>
#>  
#>       Type: X12-820
#> Characters: 989    
#>   Segments: 42     
#>   Problems: 0      
#>  
#>    ISA: 1
#>     GS: 1
#>     ST: 1
#>    BPR: 1
#>    TRN: 1
#>   N1PE: 1
#>   N3PE: 1
#>   N4PE: 1
#>  REF0F: 3
#>  REF38: 1
#>  REFAZ: 4
#> REFPOL: 4
#>  REFTV: 1
#>    ENT: 4
#>    NM1: 4
#>    RMR: 5
#>    DTM: 5
#>     SE: 1
#>     GE: 1
#>    IEA: 1
#> 
#> $`820_EX2_payments_exceed_charges1`
#> <x12_index>
#>  
#>       Type: X12-820
#> Characters: 963    
#>   Segments: 38     
#>   Problems: 0      
#>  
#>    ISA: 1
#>     GS: 1
#>     ST: 1
#>    BPR: 1
#>    TRN: 1
#>   N1PE: 1
#>   N3PE: 1
#>   N4PE: 1
#>  REF0F: 2
#>  REF38: 2
#>  REFAZ: 2
#> REFPOL: 2
#>    ENT: 3
#>    NM1: 2
#>    RMR: 7
#>    DTM: 7
#>     SE: 1
#>     GE: 1
#>    IEA: 1
#> 
#> $`820_EX3_payments_exceed_charges2`
#> <x12_index>
#>  
#>       Type: X12-820
#> Characters: 937    
#>   Segments: 35     
#>   Problems: 0      
#>  
#>    ISA: 1
#>     GS: 1
#>     ST: 1
#>    BPR: 1
#>    TRN: 1
#>   N1PE: 1
#>   N3PE: 1
#>   N4PE: 1
#>  REF0F: 2
#>  REF38: 2
#>  REFAZ: 2
#> REFPOL: 2
#>    ENT: 2
#>    NM1: 2
#>    RMR: 6
#>    DTM: 6
#>     SE: 1
#>     GE: 1
#>    IEA: 1
#> 
#> $`820_EX4_charges_exceed_payments1`
#> <x12_index>
#>  
#>       Type: X12-820
#> Characters: 788    
#>   Segments: 32     
#>   Problems: 0      
#>  
#>    ISA: 1
#>     GS: 1
#>     ST: 1
#>    BPR: 1
#>    TRN: 1
#>   N1PE: 1
#>   N3PE: 1
#>   N4PE: 1
#>  REF0F: 2
#>  REF1L: 2
#>  REF38: 2
#>  REFAZ: 2
#> REFPOL: 2
#>    ENT: 3
#>    NM1: 2
#>    RMR: 3
#>    DTM: 3
#>     SE: 1
#>     GE: 1
#>    IEA: 1
#> 
#> $`820_EX5_charges_exceed_payments2`
#> <x12_index>
#>  
#>       Type: X12-820
#> Characters: 792    
#>   Segments: 32     
#>   Problems: 0      
#>  
#>    ISA: 1
#>     GS: 1
#>     ST: 1
#>    BPR: 1
#>    TRN: 1
#>   N1PE: 1
#>   N3PE: 1
#>   N4PE: 1
#>  REF0F: 2
#>  REF1L: 2
#>  REF38: 2
#>  REFAZ: 2
#> REFPOL: 2
#>    ENT: 3
#>    NM1: 2
#>    RMR: 3
#>    DTM: 3
#>     SE: 1
#>     GE: 1
#>    IEA: 1
#> 
#> $`820_EX6_aptc_adjustments1`
#> <x12_index>
#>  
#>       Type: X12-820
#> Characters: 1069   
#>   Segments: 42     
#>   Problems: 0      
#>  
#>    ISA: 1
#>     GS: 1
#>     ST: 1
#>    BPR: 1
#>    TRN: 1
#>   N1PE: 1
#>   N3PE: 1
#>   N4PE: 1
#>  REF0F: 2
#>  REF38: 2
#>  REFAZ: 2
#> REFPOL: 2
#>    ENT: 3
#>    NM1: 2
#>    RMR: 9
#>    DTM: 9
#>     SE: 1
#>     GE: 1
#>    IEA: 1
#> 
#> $`820_EX7_aptc_adjustments2`
#> <x12_index>
#>  
#>       Type: X12-820
#> Characters: 1043   
#>   Segments: 39     
#>   Problems: 0      
#>  
#>    ISA: 1
#>     GS: 1
#>     ST: 1
#>    BPR: 1
#>    TRN: 1
#>   N1PE: 1
#>   N3PE: 1
#>   N4PE: 1
#>  REF0F: 2
#>  REF38: 2
#>  REFAZ: 2
#> REFPOL: 2
#>    ENT: 2
#>    NM1: 2
#>    RMR: 8
#>    DTM: 8
#>     SE: 1
#>     GE: 1
#>    IEA: 1
#> 
#> $`820_EX8_outstanding_debt_owed1`
#> <x12_index>
#>  
#>       Type: X12-820
#> Characters: 960    
#>   Segments: 38     
#>   Problems: 0      
#>  
#>    ISA: 1
#>     GS: 1
#>     ST: 1
#>    BPR: 1
#>    TRN: 1
#>   N1PE: 1
#>   N3PE: 1
#>   N4PE: 1
#>  REF0F: 2
#>  REF38: 2
#>  REFAZ: 2
#> REFPOL: 2
#>    ENT: 3
#>    NM1: 2
#>    RMR: 7
#>    DTM: 7
#>     SE: 1
#>     GE: 1
#>    IEA: 1
#> 
#> $`820_EX9_outstanding_debt_owed2`
#> <x12_index>
#>  
#>       Type: X12-820
#> Characters: 1033   
#>   Segments: 39     
#>   Problems: 0      
#>  
#>    ISA: 1
#>     GS: 1
#>     ST: 1
#>    BPR: 1
#>    TRN: 1
#>   N1PE: 1
#>   N3PE: 1
#>   N4PE: 1
#>  REF0F: 2
#>  REF0N: 1
#>  REF38: 2
#>  REFAZ: 2
#> REFPOL: 2
#>    ENT: 3
#>    NM1: 2
#>    RMR: 7
#>    DTM: 7
#>     SE: 1
#>     GE: 1
#>    IEA: 1
#> 
#> $sample_820_01
#> <x12_index>
#>  
#>       Type: X12-820
#> Characters: 3118   
#>   Segments: 104    
#>   Problems: 0      
#>  
#>   ISA:  1
#>    GS:  1
#>    ST:  1
#>   BPR:  1
#>   TRN:  1
#> REF14:  1
#>  N1PE:  1
#>  N3PE:  1
#>  N4PE:  1
#>  N1PR:  1
#>  N3PR:  1
#>  N4PR:  1
#>   ENT: 12
#>   NM1: 12
#>   RMR: 13
#> REF18: 13
#> REFZZ: 26
#>   DTM: 13
#>    SE:  1
#>    GE:  1
#>   IEA:  1
#> 
#> $sample_820_02
#> <x12_index>
#>  
#>       Type: X12-820
#> Characters: 4757   
#>   Segments: 166    
#>   Problems: 0      
#>  
#>   ISA:  1
#>    GS:  1
#>    ST:  1
#>   BPR:  1
#>   TRN:  1
#> REF14:  1
#>  N1PE:  1
#>  N3PE:  1
#>  N4PE:  1
#>  N1PR:  1
#>  N3PR:  1
#>  N4PR:  1
#>   ENT: 13
#>   NM1: 13
#>   RMR: 23
#> REF18: 23
#> REFZZ: 46
#>   DTM: 23
#>   ADX: 10
#>    SE:  1
#>    GE:  1
#>   IEA:  1
#> 
#> $sample_820_03
#> <x12_index>
#>  
#>       Type: X12-820
#> Characters: 33189  
#>   Segments: 1146   
#>   Problems: 0      
#>  
#>   ISA:   1
#>    GS:   1
#>    ST:   1
#>   BPR:   1
#>   TRN:   1
#> REF14:   1
#>  N1PE:   1
#>  N3PE:   1
#>  N4PE:   1
#>  N1PR:   1
#>  N3PR:   1
#>  N4PR:   1
#>   ENT:  93
#>   NM1:  93
#>   RMR: 176
#> REF18: 176
#> REFZZ: 352
#>   DTM: 176
#>   ADX:  65
#>    SE:   1
#>    GE:   1
#>   IEA:   1
#> 
#> $sample_820_04
#> <x12_index>
#>  
#>       Type: X12-820
#> Characters: 2819   
#>   Segments: 95     
#>   Problems: 0      
#>  
#>   ISA:  1
#>    GS:  1
#>    ST:  1
#>   BPR:  1
#>   TRN:  1
#> REF14:  1
#>  N1PE:  1
#>  N3PE:  1
#>  N4PE:  1
#>  N1PR:  1
#>  N3PR:  1
#>  N4PR:  1
#>   ENT: 10
#>   NM1: 10
#>   RMR: 12
#> REF18: 12
#> REFZZ: 24
#>   DTM: 12
#>    SE:  1
#>    GE:  1
#>   IEA:  1
#> 
#> $sample_820_05
#> <x12_index>
#>  
#>       Type: X12-820
#> Characters: 19564  
#>   Segments: 647    
#>   Problems: 0      
#>  
#>   ISA:   1
#>    GS:   1
#>    ST:   1
#>   BPR:   1
#>   TRN:   1
#> REF14:   1
#>  N1PE:   1
#>  N3PE:   1
#>  N4PE:   1
#>  N1PR:   1
#>  N3PR:   1
#>  N4PR:   1
#>   ENT:  81
#>   NM1:  81
#>   RMR:  94
#> REF18:  94
#> REFZZ: 188
#>   DTM:  94
#>    SE:   1
#>    GE:   1
#>   IEA:   1
#> 
#> $stedi_820_06
#> [1] "input is X12-850 not X12-820"
#> 
#> $stedi_820_07
#> [1] "input is X12-850 not X12-820"
#> 
purrr::map(hcc::x12_820[13:17], parse_820)
#> $sample_820_01
#> # A tibble: 429 × 3
#>    SEG   PT    VALUE     
#>    <chr> <chr> <chr>     
#>  1 ISA   01    00        
#>  2 ISA   02    NA        
#>  3 ISA   03    00        
#>  4 ISA   04    NA        
#>  5 ISA   05    ZZ        
#>  6 ISA   06    TEST-PAYER
#>  7 ISA   07    30        
#>  8 ISA   08    TEST-PAYEE
#>  9 ISA   09    260118    
#> 10 ISA   10    0831      
#> # ℹ 419 more rows
#> 
#> $sample_820_02
#> # A tibble: 632 × 3
#>    SEG   PT    VALUE     
#>    <chr> <chr> <chr>     
#>  1 ISA   01    00        
#>  2 ISA   02    NA        
#>  3 ISA   03    00        
#>  4 ISA   04    NA        
#>  5 ISA   05    ZZ        
#>  6 ISA   06    TEST-PAYER
#>  7 ISA   07    30        
#>  8 ISA   08    TEST-PAYEE
#>  9 ISA   09    260316    
#> 10 ISA   10    0855      
#> # ℹ 622 more rows
#> 
#> $sample_820_03
#> # A tibble: 4,285 × 3
#>    SEG   PT    VALUE     
#>    <chr> <chr> <chr>     
#>  1 ISA   01    00        
#>  2 ISA   02    NA        
#>  3 ISA   03    00        
#>  4 ISA   04    NA        
#>  5 ISA   05    ZZ        
#>  6 ISA   06    TEST-PAYER
#>  7 ISA   07    30        
#>  8 ISA   08    TEST-PAYEE
#>  9 ISA   09    260316    
#> 10 ISA   10    0854      
#> # ℹ 4,275 more rows
#> 
#> $sample_820_04
#> # A tibble: 387 × 3
#>    SEG   PT    VALUE     
#>    <chr> <chr> <chr>     
#>  1 ISA   01    00        
#>  2 ISA   02    NA        
#>  3 ISA   03    00        
#>  4 ISA   04    NA        
#>  5 ISA   05    ZZ        
#>  6 ISA   06    TEST-PAYER
#>  7 ISA   07    30        
#>  8 ISA   08    TEST-PAYEE
#>  9 ISA   09    251217    
#> 10 ISA   10    2316      
#> # ℹ 377 more rows
#> 
#> $sample_820_05
#> # A tibble: 2,622 × 3
#>    SEG   PT    VALUE     
#>    <chr> <chr> <chr>     
#>  1 ISA   01    00        
#>  2 ISA   02    NA        
#>  3 ISA   03    00        
#>  4 ISA   04    NA        
#>  5 ISA   05    ZZ        
#>  6 ISA   06    TEST-PAYER
#>  7 ISA   07    30        
#>  8 ISA   08    TEST-PAYEE
#>  9 ISA   09    260217    
#> 10 ISA   10    0936      
#> # ℹ 2,612 more rows
#> 
```
