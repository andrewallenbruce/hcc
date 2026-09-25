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
x = hcc::x12_820
x = x[collapse::whichv(x12_type(x), "820-X218")]
#> Error in x12_type(x): could not find function "x12_type"
i = purrr::map(x, index_x12)
p = purrr::map(i, parse_820)
#> Error in purrr::map(i, parse_820): ℹ In index: 1.
#> ℹ With name: 820_EX10_debt_covered_by_affiliate1.
#> Caused by error in `star(x, i)[[1]]`:
#> ! subscript out of bounds
p = p$sample_820_01
#> Error: object 'p' not found
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
#> Error in unlist_(p$Header$ISA): could not find function "unlist_"
```
