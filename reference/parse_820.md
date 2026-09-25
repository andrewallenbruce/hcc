# X12-820 (X306/X218) Payment Order/Remittance Advice Parser

Parses X12-820 (005010X218) transactions for Medicaid/Medicare
capitation and premium payments. Designed for California DHCS PACE
capitation remittances but handles the general 820 format used by state
Medicaid agencies.

## Usage

``` r
parse_820(x)
```

## Arguments

- x:

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
x12_type <- hcc:::x12_type
unlist_ <- hcc:::unlist_
whichv_ <- collapse::whichv

x = hcc::x12_820
x = x[whichv_(x12_type(x), "820-X218")]
i = purrr::map(x, index_x12)
p = purrr::map(i, parse_820)
p = p$sample_820_01
list(
  ISA = unlist_(p$Header$ISA),
  GS = unlist_(p$Header$GS),
  ST = unlist_(p$Header$ST),
  BPR = unlist_(p$Header$BPR),
  TRN = unlist_(p$Header$TRN),
  REF14 = unlist_(p$Header$REF14),
  SE = unlist_(p$Trailer$SE),
  GE = unlist_(p$Trailer$GE),
  IEA = unlist_(p$Trailer$IEA)
 )
#> $ISA
#>  [1] "00"         NA           "00"         NA           "ZZ"        
#>  [6] "TEST-PAYER" "30"         "TEST-PAYEE" "260118"     "0831"      
#> [11] "+"          "00501"      "000058691"  "0"          "P"         
#> [16] ":"         
#> 
#> $GS
#> [1] "RA"         "TEST-PAYER" "TEST-PAYEE" "20260118"   "083122"    
#> [6] "43304"      "X"          "005010X218"
#> 
#> $ST
#> [1] "820"        "0001"       "005010X218"
#> 
#> $BPR
#>  [1] "I"          "102139.46"  "C"          "NON"        NA          
#>  [6] NA           NA           NA           NA           "68-0317191"
#> [11] NA           NA           NA           NA           NA          
#> [16] "20260115"  
#> 
#> $TRN
#> [1] "3"               "TESTTRN01000001"
#> 
#> $REF14
#> [1] "14"         "0000245023"
#> 
#> $SE
#> [1] "100"  "0001"
#> 
#> $GE
#> [1] "1"     "43304"
#> 
#> $IEA
#> [1] "1"         "000058691"
#> 
```
