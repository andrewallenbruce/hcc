# X12-820 Payment Order/Remittance Advice Parser

Parses X12-820 (005010X218) transactions for Medicaid/Medicare
capitation and premium payments. Designed for California DHCS PACE
capitation remittances but handles the general 820 format used by state
Medicaid agencies.

## Usage

``` r
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
  `REF*ZZ` \> `DTM*582` \> `ADX`?)

- Trailer: `SE` \> `GE` \> `IEA`

## Examples

``` r
purrr::map(hcc::x12_820, parse_820)
#> $sample_820_01
#>      SEG  N                     VAL
#> 1    ISA 01                      00
#> 2    ISA 02                    <NA>
#> 3    ISA 03                      00
#> 4    ISA 04                    <NA>
#> 5    ISA 05                      ZZ
#> 6    ISA 06              TEST-PAYER
#> 7    ISA 07                      30
#> 8    ISA 08              TEST-PAYEE
#> 9    ISA 09                  260118
#> 10   ISA 10                    0831
#> 11   ISA 11                       +
#> 12   ISA 12                   00501
#> 13   ISA 13               000058691
#> 14   ISA 14                       0
#> 15   ISA 15                       P
#> 16   ISA 16                       :
#> 17    GS 01                      RA
#> 18    GS 02              TEST-PAYER
#> 19    GS 03              TEST-PAYEE
#> 20    GS 04                20260118
#> 21    GS 05                  083122
#> 22    GS 06                   43304
#> 23    GS 07                       X
#> 24    GS 08              005010X218
#> 25    ST 01                     820
#> 26    ST 02                    0001
#> 27    ST 03              005010X218
#> 28   BPR 01                       I
#> 29   BPR 02               102139.46
#> 30   BPR 03                       C
#> 31   BPR 04                     NON
#> 32   BPR 05                    <NA>
#> 33   BPR 06                    <NA>
#> 34   BPR 07                    <NA>
#> 35   BPR 08                    <NA>
#> 36   BPR 09                    <NA>
#> 37   BPR 10              68-0317191
#> 38   BPR 11                    <NA>
#> 39   BPR 12                    <NA>
#> 40   BPR 13                    <NA>
#> 41   BPR 14                    <NA>
#> 42   BPR 15                    <NA>
#> 43   BPR 16                20260115
#> 44   TRN 01                       3
#> 45   TRN 02         TESTTRN01000001
#> 46   REF 01                      14
#> 47   REF 02              0000245023
#> 48 N1*PE 01                      PE
#> 49 N1*PE 02 TEST PAYEE ORGANIZATION
#> 50 N3*PE 01         123 TEST STREET
#> 51 N4*PE 01                TESTCITY
#> 52 N4*PE 02                      CA
#> 53 N4*PE 03                   00000
#> 54 N1*PR 01                      PR
#> 55 N1*PR 02       TEST PAYER AGENCY
#> 56 N3*PR 01         123 TEST STREET
#> 57 N4*PR 01                TESTCITY
#> 58 N4*PR 02                      CA
#> 59 N4*PR 03                   00000
#> 
#> $sample_820_02
#>      SEG  N                     VAL
#> 1    ISA 01                      00
#> 2    ISA 02                    <NA>
#> 3    ISA 03                      00
#> 4    ISA 04                    <NA>
#> 5    ISA 05                      ZZ
#> 6    ISA 06              TEST-PAYER
#> 7    ISA 07                      30
#> 8    ISA 08              TEST-PAYEE
#> 9    ISA 09                  260316
#> 10   ISA 10                    0855
#> 11   ISA 11                       +
#> 12   ISA 12                   00501
#> 13   ISA 13               000059660
#> 14   ISA 14                       0
#> 15   ISA 15                       P
#> 16   ISA 16                       :
#> 17    GS 01                      RA
#> 18    GS 02              TEST-PAYER
#> 19    GS 03              TEST-PAYEE
#> 20    GS 04                20260316
#> 21    GS 05                  085500
#> 22    GS 06                   44273
#> 23    GS 07                       X
#> 24    GS 08              005010X218
#> 25    ST 01                     820
#> 26    ST 02                    0001
#> 27    ST 03              005010X218
#> 28   BPR 01                       I
#> 29   BPR 02                91977.81
#> 30   BPR 03                       C
#> 31   BPR 04                     NON
#> 32   BPR 05                    <NA>
#> 33   BPR 06                    <NA>
#> 34   BPR 07                    <NA>
#> 35   BPR 08                    <NA>
#> 36   BPR 09                    <NA>
#> 37   BPR 10              68-0317191
#> 38   BPR 11                    <NA>
#> 39   BPR 12                    <NA>
#> 40   BPR 13                    <NA>
#> 41   BPR 14                    <NA>
#> 42   BPR 15                    <NA>
#> 43   BPR 16                20260312
#> 44   TRN 01                       3
#> 45   TRN 02         TESTTRN02000001
#> 46   REF 01                      14
#> 47   REF 02              0000245023
#> 48 N1*PE 01                      PE
#> 49 N1*PE 02 TEST PAYEE ORGANIZATION
#> 50 N3*PE 01         123 TEST STREET
#> 51 N4*PE 01                TESTCITY
#> 52 N4*PE 02                      CA
#> 53 N4*PE 03                   00000
#> 54 N1*PR 01                      PR
#> 55 N1*PR 02       TEST PAYER AGENCY
#> 56 N3*PR 01         123 TEST STREET
#> 57 N4*PR 01                TESTCITY
#> 58 N4*PR 02                      CA
#> 59 N4*PR 03                   00000
#> 
#> $sample_820_03
#>      SEG  N                     VAL
#> 1    ISA 01                      00
#> 2    ISA 02                    <NA>
#> 3    ISA 03                      00
#> 4    ISA 04                    <NA>
#> 5    ISA 05                      ZZ
#> 6    ISA 06              TEST-PAYER
#> 7    ISA 07                      30
#> 8    ISA 08              TEST-PAYEE
#> 9    ISA 09                  260316
#> 10   ISA 10                    0854
#> 11   ISA 11                       +
#> 12   ISA 12                   00501
#> 13   ISA 13               000059659
#> 14   ISA 14                       0
#> 15   ISA 15                       P
#> 16   ISA 16                       :
#> 17    GS 01                      RA
#> 18    GS 02              TEST-PAYER
#> 19    GS 03              TEST-PAYEE
#> 20    GS 04                20260316
#> 21    GS 05                  085458
#> 22    GS 06                   44272
#> 23    GS 07                       X
#> 24    GS 08              005010X218
#> 25    ST 01                     820
#> 26    ST 02                    0001
#> 27    ST 03              005010X218
#> 28   BPR 01                       I
#> 29   BPR 02               697085.64
#> 30   BPR 03                       C
#> 31   BPR 04                     NON
#> 32   BPR 05                    <NA>
#> 33   BPR 06                    <NA>
#> 34   BPR 07                    <NA>
#> 35   BPR 08                    <NA>
#> 36   BPR 09                    <NA>
#> 37   BPR 10              68-0317191
#> 38   BPR 11                    <NA>
#> 39   BPR 12                    <NA>
#> 40   BPR 13                    <NA>
#> 41   BPR 14                    <NA>
#> 42   BPR 15                    <NA>
#> 43   BPR 16                20260312
#> 44   TRN 01                       3
#> 45   TRN 02         TESTTRN03000001
#> 46   REF 01                      14
#> 47   REF 02              0000245023
#> 48 N1*PE 01                      PE
#> 49 N1*PE 02 TEST PAYEE ORGANIZATION
#> 50 N3*PE 01         123 TEST STREET
#> 51 N4*PE 01                TESTCITY
#> 52 N4*PE 02                      CA
#> 53 N4*PE 03                   00000
#> 54 N1*PR 01                      PR
#> 55 N1*PR 02       TEST PAYER AGENCY
#> 56 N3*PR 01         123 TEST STREET
#> 57 N4*PR 01                TESTCITY
#> 58 N4*PR 02                      CA
#> 59 N4*PR 03                   00000
#> 
#> $sample_820_04
#>      SEG  N                     VAL
#> 1    ISA 01                      00
#> 2    ISA 02                    <NA>
#> 3    ISA 03                      00
#> 4    ISA 04                    <NA>
#> 5    ISA 05                      ZZ
#> 6    ISA 06              TEST-PAYER
#> 7    ISA 07                      30
#> 8    ISA 08              TEST-PAYEE
#> 9    ISA 09                  251217
#> 10   ISA 10                    2316
#> 11   ISA 11                       +
#> 12   ISA 12                   00501
#> 13   ISA 13               000058142
#> 14   ISA 14                       0
#> 15   ISA 15                       P
#> 16   ISA 16                       :
#> 17    GS 01                      RA
#> 18    GS 02              TEST-PAYER
#> 19    GS 03              TEST-PAYEE
#> 20    GS 04                20251217
#> 21    GS 05                  231624
#> 22    GS 06                   42755
#> 23    GS 07                       X
#> 24    GS 08              005010X218
#> 25    ST 01                     820
#> 26    ST 02                    0001
#> 27    ST 03              005010X218
#> 28   BPR 01                       I
#> 29   BPR 02                80865.30
#> 30   BPR 03                       C
#> 31   BPR 04                     NON
#> 32   BPR 05                    <NA>
#> 33   BPR 06                    <NA>
#> 34   BPR 07                    <NA>
#> 35   BPR 08                    <NA>
#> 36   BPR 09                    <NA>
#> 37   BPR 10              68-0317191
#> 38   BPR 11                    <NA>
#> 39   BPR 12                    <NA>
#> 40   BPR 13                    <NA>
#> 41   BPR 14                    <NA>
#> 42   BPR 15                    <NA>
#> 43   BPR 16                20251216
#> 44   TRN 01                       3
#> 45   TRN 02         TESTTRN04000001
#> 46   REF 01                      14
#> 47   REF 02              0000245023
#> 48 N1*PE 01                      PE
#> 49 N1*PE 02 TEST PAYEE ORGANIZATION
#> 50 N3*PE 01         123 TEST STREET
#> 51 N4*PE 01                TESTCITY
#> 52 N4*PE 02                      CA
#> 53 N4*PE 03                   00000
#> 54 N1*PR 01                      PR
#> 55 N1*PR 02       TEST PAYER AGENCY
#> 56 N3*PR 01         123 TEST STREET
#> 57 N4*PR 01                TESTCITY
#> 58 N4*PR 02                      CA
#> 59 N4*PR 03                   00000
#> 
#> $sample_820_05
#>      SEG  N                     VAL
#> 1    ISA 01                      00
#> 2    ISA 02                    <NA>
#> 3    ISA 03                      00
#> 4    ISA 04                    <NA>
#> 5    ISA 05                      ZZ
#> 6    ISA 06              TEST-PAYER
#> 7    ISA 07                      30
#> 8    ISA 08              TEST-PAYEE
#> 9    ISA 09                  260217
#> 10   ISA 10                    0936
#> 11   ISA 11                       +
#> 12   ISA 12                   00501
#> 13   ISA 13               000059431
#> 14   ISA 14                       0
#> 15   ISA 15                       P
#> 16   ISA 16                       :
#> 17    GS 01                      RA
#> 18    GS 02              TEST-PAYER
#> 19    GS 03              TEST-PAYEE
#> 20    GS 04                20260217
#> 21    GS 05                  093627
#> 22    GS 06                   44044
#> 23    GS 07                       X
#> 24    GS 08              005010X218
#> 25    ST 01                     820
#> 26    ST 02                    0001
#> 27    ST 03              005010X218
#> 28   BPR 01                       I
#> 29   BPR 02               499187.57
#> 30   BPR 03                       C
#> 31   BPR 04                     NON
#> 32   BPR 05                    <NA>
#> 33   BPR 06                    <NA>
#> 34   BPR 07                    <NA>
#> 35   BPR 08                    <NA>
#> 36   BPR 09                    <NA>
#> 37   BPR 10              68-0317191
#> 38   BPR 11                    <NA>
#> 39   BPR 12                    <NA>
#> 40   BPR 13                    <NA>
#> 41   BPR 14                    <NA>
#> 42   BPR 15                    <NA>
#> 43   BPR 16                20260212
#> 44   TRN 01                       3
#> 45   TRN 02         TESTTRN05000001
#> 46   REF 01                      14
#> 47   REF 02              0000245023
#> 48 N1*PE 01                      PE
#> 49 N1*PE 02 TEST PAYEE ORGANIZATION
#> 50 N3*PE 01         123 TEST STREET
#> 51 N4*PE 01                TESTCITY
#> 52 N4*PE 02                      CA
#> 53 N4*PE 03                   00000
#> 54 N1*PR 01                      PR
#> 55 N1*PR 02       TEST PAYER AGENCY
#> 56 N3*PR 01         123 TEST STREET
#> 57 N4*PR 01                TESTCITY
#> 58 N4*PR 02                      CA
#> 59 N4*PR 03                   00000
#> 
```
