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

list of `<hcc::X12_820_218>` S7 objects

## Details

Key segments parsed:

- `ISA/GS`: Interchange and group headers (source ID, report date)

- `BPR`: Payment amount and effective date

- `TRN`: EFT/check trace number

- `N1/N3/N4`: Payer and payee name and address

- `ENT`: Per-member entity loop start

- `NM1`: Member name and ID

- `RMR`: Remittance line item (reference number, payment amount)

- `REF*18`: Rate code (e.g., `957` = PACE rate)

- `REF*ZZ`: Aid code/plan type composite and description

- `DTM*582`: Coverage period date range

- `ADX`: Adjustment amount and reason code

Typical loop structure within an `820-X218`:

- Header: `ISA` \> `GS` \> `ST` \> `BPR` \> `TRN` \> `N1*PE` \> `N1*PR`

- Per-member: `ENT` \> `NM1` \> (`RMR` \> `REF*18` \> `REF*ZZ` \>
  `REF*ZZ` \> `DTM*582` \> `ADX`)

- Trailer: `SE` \> `GE` \> `IEA`

## Examples

``` r
edi_index(hcc::x12_EX$`820`$`218`) |>
  purrr::map(parse_820) |>
  str(list.len = 10L)
#> List of 10
#>  $ 820_Child_Health_Plus_Payment_EFT: chr NA
#>  $ 820_Essentail_Health_Plan        : chr NA
#>  $ 820_Premium_Payment_EFT          : chr NA
#>  $ 820_Premium_Payment_NOPMT        : chr NA
#>  $ payment_order_820_218            : chr NA
#>  $ sample_820_01                    : chr NA
#>  $ sample_820_02                    : chr NA
#>  $ sample_820_03                    : chr NA
#>  $ sample_820_04                    : chr NA
#>  $ sample_820_05                    : chr NA
```
