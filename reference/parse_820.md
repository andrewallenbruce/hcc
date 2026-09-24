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
#> <hcc::X12Index>
#>  @ text      : chr [1:42] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1348*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 19
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BPR   : int 4
#>  .. $ TRN   : int 5
#>  .. $ N1PE  : int 6
#>  .. $ N1RM  : int 7
#>  .. $ PERIC : int 8
#>  .. $ ENT   : int [1:3] 9 25 37
#>  .. $ NM1   : int [1:2] 10 26
#>  .. $ REF38 : int [1:2] 11 27
#>  .. $ REFPOL: int [1:2] 12 28
#>  .. $ REFAZ : int [1:2] 13 29
#>  .. $ REF0F : int [1:2] 14 30
#>  .. $ RMR   : int [1:9] 15 17 19 21 23 31 33 35 38
#>  .. $ DTM582: int [1:9] 16 18 20 22 24 32 34 36 39
#>  .. $ SE    : int 40
#>  .. $ GE    : int 41
#>  .. $ IEA   : int 42
#>  @ characters: int [1:42] 105 64 22 33 21 32 16 71 5 30 ...
#>  @ segments  : Named int [1:19] 1 1 1 1 1 1 1 1 3 2 ...
#>  .. - attr(*, "names")= chr [1:19] "ISA" "GS" "ST" "BPR" ...
#>  @ problems  : int 0
#>  @ type      : chr "X12-820-X306"
#> 
#> $`820_EX11_debt_covered_by_affiliate2`
#> <hcc::X12Index>
#>  @ text      : chr [1:43] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1404*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 20
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BPR   : int 4
#>  .. $ TRN   : int 5
#>  .. $ N1PE  : int 6
#>  .. $ N1RM  : int 7
#>  .. $ PERIC : int 8
#>  .. $ ENT   : int [1:3] 9 25 37
#>  .. $ NM1   : int [1:2] 10 26
#>  .. $ REF38 : int [1:2] 11 27
#>  .. $ REFPOL: int [1:2] 12 28
#>  .. $ REFAZ : int [1:2] 13 29
#>  .. $ REF0F : int [1:2] 14 30
#>  .. $ RMR   : int [1:9] 15 17 19 21 23 31 33 35 38
#>  .. $ DTM582: int [1:9] 16 18 20 22 24 32 34 36 40
#>  .. $ REF0N : int 39
#>  .. $ SE    : int 41
#>  .. $ GE    : int 42
#>  .. $ IEA   : int 43
#>  @ characters: int [1:43] 105 64 22 33 20 32 16 71 5 30 ...
#>  @ segments  : Named int [1:20] 1 1 1 1 1 1 1 1 3 2 ...
#>  .. - attr(*, "names")= chr [1:20] "ISA" "GS" "ST" "BPR" ...
#>  @ problems  : int 0
#>  @ type      : chr "X12-820-X306"
#> 
#> $`820_EX12_csr_manual_adj`
#> <hcc::X12Index>
#>  @ text      : chr [1:34] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1405*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 19
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BPR   : int 4
#>  .. $ TRN   : int 5
#>  .. $ N1PE  : int 6
#>  .. $ N1RM  : int 7
#>  .. $ PERIC : int 8
#>  .. $ ENT   : int [1:3] 9 19 29
#>  .. $ NM1   : int [1:2] 10 20
#>  .. $ REF38 : int [1:2] 11 21
#>  .. $ REFPOL: int [1:2] 12 22
#>  .. $ REFAZ : int [1:2] 13 23
#>  .. $ REF0F : int [1:2] 14 24
#>  .. $ RMR   : int [1:5] 15 17 25 27 30
#>  .. $ DTM582: int [1:5] 16 18 26 28 31
#>  .. $ SE    : int 32
#>  .. $ GE    : int 33
#>  .. $ IEA   : int 34
#>  @ characters: int [1:34] 105 64 22 33 21 27 16 71 5 32 ...
#>  @ segments  : Named int [1:19] 1 1 1 1 1 1 1 1 3 2 ...
#>  .. - attr(*, "names")= chr [1:19] "ISA" "GS" "ST" "BPR" ...
#>  @ problems  : int 0
#>  @ type      : chr "X12-820-X306"
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`
#> <hcc::X12Index>
#>  @ text      : chr [1:41] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1259*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 19
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BPR   : int 4
#>  .. $ TRN   : int 5
#>  .. $ REF38 : int 6
#>  .. $ REFTV : int 7
#>  .. $ N1PE  : int 8
#>  .. $ N1RM  : int 9
#>  .. $ ENT   : int [1:4] 10 17 24 31
#>  .. $ NM1   : int [1:4] 11 18 25 32
#>  .. $ REFPOL: int [1:4] 12 19 26 33
#>  .. $ REFAZ : int [1:4] 13 20 27 34
#>  .. $ REF0F : int [1:3] 14 21 28
#>  .. $ RMR   : int [1:5] 15 22 29 35 37
#>  .. $ DTM582: int [1:5] 16 23 30 36 38
#>  .. $ SE    : int 39
#>  .. $ GE    : int 40
#>  .. $ IEA   : int 41
#>  @ characters: int [1:41] 105 64 22 56 11 13 15 37 33 5 ...
#>  @ segments  : Named int [1:19] 1 1 1 1 1 1 1 1 1 4 ...
#>  .. - attr(*, "names")= chr [1:19] "ISA" "GS" "ST" "BPR" ...
#>  @ problems  : int 0
#>  @ type      : chr "X12-820-X306"
#> 
#> $`820_EX2_payments_exceed_charges1`
#> <hcc::X12Index>
#>  @ text      : chr [1:38] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1259*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 19
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BPR   : int 4
#>  .. $ TRN   : int 5
#>  .. $ N1PE  : int 6
#>  .. $ N1RM  : int 7
#>  .. $ PERIC : int 8
#>  .. $ ENT   : int [1:3] 9 21 33
#>  .. $ NM1   : int [1:2] 10 22
#>  .. $ REF38 : int [1:2] 11 23
#>  .. $ REFPOL: int [1:2] 12 24
#>  .. $ REFAZ : int [1:2] 13 25
#>  .. $ REF0F : int [1:2] 14 26
#>  .. $ RMR   : int [1:7] 15 17 19 27 29 31 34
#>  .. $ DTM582: int [1:7] 16 18 20 28 30 32 35
#>  .. $ SE    : int 36
#>  .. $ GE    : int 37
#>  .. $ IEA   : int 38
#>  @ characters: int [1:38] 105 64 22 33 21 27 16 71 5 32 ...
#>  @ segments  : Named int [1:19] 1 1 1 1 1 1 1 1 3 2 ...
#>  .. - attr(*, "names")= chr [1:19] "ISA" "GS" "ST" "BPR" ...
#>  @ problems  : int 0
#>  @ type      : chr "X12-820-X306"
#> 
#> $`820_EX3_payments_exceed_charges2`
#> <hcc::X12Index>
#>  @ text      : chr [1:35] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1331*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 19
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BPR   : int 4
#>  .. $ TRN   : int 5
#>  .. $ N1PE  : int 6
#>  .. $ N1RM  : int 7
#>  .. $ PERIC : int 8
#>  .. $ ENT   : int [1:2] 9 21
#>  .. $ NM1   : int [1:2] 10 22
#>  .. $ REF38 : int [1:2] 11 23
#>  .. $ REFPOL: int [1:2] 12 24
#>  .. $ REFAZ : int [1:2] 13 25
#>  .. $ REF0F : int [1:2] 14 26
#>  .. $ RMR   : int [1:6] 15 17 19 27 29 31
#>  .. $ DTM582: int [1:6] 16 18 20 28 30 32
#>  .. $ SE    : int 33
#>  .. $ GE    : int 34
#>  .. $ IEA   : int 35
#>  @ characters: int [1:35] 105 64 22 64 21 27 16 71 5 32 ...
#>  @ segments  : Named int [1:19] 1 1 1 1 1 1 1 1 2 2 ...
#>  .. - attr(*, "names")= chr [1:19] "ISA" "GS" "ST" "BPR" ...
#>  @ problems  : int 0
#>  @ type      : chr "X12-820-X306"
#> 
#> $`820_EX4_charges_exceed_payments1`
#> <hcc::X12Index>
#>  @ text      : chr [1:32] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1335*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 20
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BPR   : int 4
#>  .. $ TRN   : int 5
#>  .. $ N1PE  : int 6
#>  .. $ N1RM  : int 7
#>  .. $ PERIC : int 8
#>  .. $ ENT   : int [1:3] 9 18 27
#>  .. $ NM1   : int [1:2] 10 19
#>  .. $ REF38 : int [1:2] 11 20
#>  .. $ REF1L : int [1:2] 12 21
#>  .. $ REFPOL: int [1:2] 13 22
#>  .. $ REFAZ : int [1:2] 14 23
#>  .. $ REF0F : int [1:2] 15 24
#>  .. $ RMR   : int [1:3] 16 25 28
#>  .. $ DTM582: int [1:3] 17 26 29
#>  .. $ SE    : int 30
#>  .. $ GE    : int 31
#>  .. $ IEA   : int 32
#>  @ characters: int [1:32] 105 64 22 33 21 24 16 71 5 32 ...
#>  @ segments  : Named int [1:20] 1 1 1 1 1 1 1 1 3 2 ...
#>  .. - attr(*, "names")= chr [1:20] "ISA" "GS" "ST" "BPR" ...
#>  @ problems  : int 0
#>  @ type      : chr "X12-820-X306"
#> 
#> $`820_EX5_charges_exceed_payments2`
#> <hcc::X12Index>
#>  @ text      : chr [1:32] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1338*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 20
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BPR   : int 4
#>  .. $ TRN   : int 5
#>  .. $ N1PE  : int 6
#>  .. $ N1RM  : int 7
#>  .. $ PERIC : int 8
#>  .. $ ENT   : int [1:3] 9 18 27
#>  .. $ NM1   : int [1:2] 10 19
#>  .. $ REF38 : int [1:2] 11 20
#>  .. $ REF1L : int [1:2] 12 21
#>  .. $ REFPOL: int [1:2] 13 22
#>  .. $ REFAZ : int [1:2] 14 23
#>  .. $ REF0F : int [1:2] 15 24
#>  .. $ RMR   : int [1:3] 16 25 28
#>  .. $ DTM582: int [1:3] 17 26 29
#>  .. $ SE    : int 30
#>  .. $ GE    : int 31
#>  .. $ IEA   : int 32
#>  @ characters: int [1:32] 105 64 22 33 21 24 16 71 5 32 ...
#>  @ segments  : Named int [1:20] 1 1 1 1 1 1 1 1 3 2 ...
#>  .. - attr(*, "names")= chr [1:20] "ISA" "GS" "ST" "BPR" ...
#>  @ problems  : int 0
#>  @ type      : chr "X12-820-X306"
#> 
#> $`820_EX6_aptc_adjustments1`
#> <hcc::X12Index>
#>  @ text      : chr [1:42] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1342*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 19
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BPR   : int 4
#>  .. $ TRN   : int 5
#>  .. $ N1PE  : int 6
#>  .. $ N1RM  : int 7
#>  .. $ PERIC : int 8
#>  .. $ ENT   : int [1:3] 9 25 37
#>  .. $ NM1   : int [1:2] 10 26
#>  .. $ REF38 : int [1:2] 11 27
#>  .. $ REFPOL: int [1:2] 12 28
#>  .. $ REFAZ : int [1:2] 13 29
#>  .. $ REF0F : int [1:2] 14 30
#>  .. $ RMR   : int [1:9] 15 17 19 21 23 31 33 35 38
#>  .. $ DTM582: int [1:9] 16 18 20 22 24 32 34 36 39
#>  .. $ SE    : int 40
#>  .. $ GE    : int 41
#>  .. $ IEA   : int 42
#>  @ characters: int [1:42] 105 64 22 33 21 27 16 71 5 32 ...
#>  @ segments  : Named int [1:19] 1 1 1 1 1 1 1 1 3 2 ...
#>  .. - attr(*, "names")= chr [1:19] "ISA" "GS" "ST" "BPR" ...
#>  @ problems  : int 0
#>  @ type      : chr "X12-820-X306"
#> 
#> $`820_EX7_aptc_adjustments2`
#> <hcc::X12Index>
#>  @ text      : chr [1:39] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1343*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 19
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BPR   : int 4
#>  .. $ TRN   : int 5
#>  .. $ N1PE  : int 6
#>  .. $ N1RM  : int 7
#>  .. $ PERIC : int 8
#>  .. $ ENT   : int [1:2] 9 25
#>  .. $ NM1   : int [1:2] 10 26
#>  .. $ REF38 : int [1:2] 11 27
#>  .. $ REFPOL: int [1:2] 12 28
#>  .. $ REFAZ : int [1:2] 13 29
#>  .. $ REF0F : int [1:2] 14 30
#>  .. $ RMR   : int [1:8] 15 17 19 21 23 31 33 35
#>  .. $ DTM582: int [1:8] 16 18 20 22 24 32 34 36
#>  .. $ SE    : int 37
#>  .. $ GE    : int 38
#>  .. $ IEA   : int 39
#>  @ characters: int [1:39] 105 64 22 63 21 27 16 71 5 32 ...
#>  @ segments  : Named int [1:19] 1 1 1 1 1 1 1 1 2 2 ...
#>  .. - attr(*, "names")= chr [1:19] "ISA" "GS" "ST" "BPR" ...
#>  @ problems  : int 0
#>  @ type      : chr "X12-820-X306"
#> 
#> $`820_EX8_outstanding_debt_owed1`
#> <hcc::X12Index>
#>  @ text      : chr [1:38] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1345*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 19
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BPR   : int 4
#>  .. $ TRN   : int 5
#>  .. $ N1PE  : int 6
#>  .. $ N1RM  : int 7
#>  .. $ PERIC : int 8
#>  .. $ ENT   : int [1:3] 9 21 33
#>  .. $ NM1   : int [1:2] 10 22
#>  .. $ REF38 : int [1:2] 11 23
#>  .. $ REFPOL: int [1:2] 12 24
#>  .. $ REFAZ : int [1:2] 13 25
#>  .. $ REF0F : int [1:2] 14 26
#>  .. $ RMR   : int [1:7] 15 17 19 27 29 31 34
#>  .. $ DTM582: int [1:7] 16 18 20 28 30 32 35
#>  .. $ SE    : int 36
#>  .. $ GE    : int 37
#>  .. $ IEA   : int 38
#>  @ characters: int [1:38] 105 64 22 33 19 27 16 71 5 32 ...
#>  @ segments  : Named int [1:19] 1 1 1 1 1 1 1 1 3 2 ...
#>  .. - attr(*, "names")= chr [1:19] "ISA" "GS" "ST" "BPR" ...
#>  @ problems  : int 0
#>  @ type      : chr "X12-820-X306"
#> 
#> $`820_EX9_outstanding_debt_owed2`
#> <hcc::X12Index>
#>  @ text      : chr [1:39] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1347*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 20
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BPR   : int 4
#>  .. $ TRN   : int 5
#>  .. $ N1PE  : int 6
#>  .. $ N1RM  : int 7
#>  .. $ PERIC : int 8
#>  .. $ ENT   : int [1:3] 9 21 33
#>  .. $ NM1   : int [1:2] 10 22
#>  .. $ REF38 : int [1:2] 11 23
#>  .. $ REFPOL: int [1:2] 12 24
#>  .. $ REFAZ : int [1:2] 13 25
#>  .. $ REF0F : int [1:2] 14 26
#>  .. $ RMR   : int [1:7] 15 17 19 27 29 31 34
#>  .. $ DTM582: int [1:7] 16 18 20 28 30 32 36
#>  .. $ REF0N : int 35
#>  .. $ SE    : int 37
#>  .. $ GE    : int 38
#>  .. $ IEA   : int 39
#>  @ characters: int [1:39] 105 64 22 63 21 27 16 71 5 32 ...
#>  @ segments  : Named int [1:20] 1 1 1 1 1 1 1 1 3 2 ...
#>  .. - attr(*, "names")= chr [1:20] "ISA" "GS" "ST" "BPR" ...
#>  @ problems  : int 0
#>  @ type      : chr "X12-820-X306"
#> 
#> $sample_820_01
#> <hcc::X12Index>
#>  @ text      : chr [1:104] "ISA*00*          *00*          *ZZ*TEST-PAYER     *30*TEST-PAYEE     *260118*0831*+*00501*000058691*0*P*:" ...
#>  @ index     :List of 21
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BPR   : int 4
#>  .. $ TRN   : int 5
#>  .. $ REF14 : int 6
#>  .. $ N1PE  : int 7
#>  .. $ N3PE  : int 8
#>  .. $ N4PE  : int 9
#>  .. $ N1PR  : int 10
#>  .. $ N3PR  : int 11
#>  .. $ N4PR  : int 12
#>  .. $ ENT   : int [1:12] 13 20 27 34 41 48 55 67 74 81 ...
#>  .. $ NM1   : int [1:12] 14 21 28 35 42 49 56 68 75 82 ...
#>  .. $ RMR   : int [1:13] 15 22 29 36 43 50 57 62 69 76 ...
#>  .. $ REF18 : int [1:13] 16 23 30 37 44 51 58 63 70 77 ...
#>  .. $ REFZZ : int [1:26] 17 18 24 25 31 32 38 39 45 46 ...
#>  .. $ DTM582: int [1:13] 19 26 33 40 47 54 61 66 73 80 ...
#>  .. $ SE    : int 102
#>  .. $ GE    : int 103
#>  .. $ IEA   : int 104
#>  @ characters: int [1:104] 105 62 22 51 21 17 29 18 20 23 ...
#>  @ segments  : Named int [1:21] 1 1 1 1 1 1 1 1 1 1 ...
#>  .. - attr(*, "names")= chr [1:21] "ISA" "GS" "ST" "BPR" ...
#>  @ problems  : int 0
#>  @ type      : chr "X12-820-X218"
#> 
#> $sample_820_02
#> <hcc::X12Index>
#>  @ text      : chr [1:166] "ISA*00*          *00*          *ZZ*TEST-PAYER     *30*TEST-PAYEE     *260316*0855*+*00501*000059660*0*P*:" ...
#>  @ index     :List of 22
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BPR   : int 4
#>  .. $ TRN   : int 5
#>  .. $ REF14 : int 6
#>  .. $ N1PE  : int 7
#>  .. $ N3PE  : int 8
#>  .. $ N4PE  : int 9
#>  .. $ N1PR  : int 10
#>  .. $ N3PR  : int 11
#>  .. $ N4PR  : int 12
#>  .. $ ENT   : int [1:13] 13 26 39 52 64 77 90 97 110 123 ...
#>  .. $ NM1   : int [1:13] 14 27 40 53 65 78 91 98 111 124 ...
#>  .. $ RMR   : int [1:23] 15 20 28 33 41 46 54 59 66 71 ...
#>  .. $ REF18 : int [1:23] 16 21 29 34 42 47 55 60 67 72 ...
#>  .. $ REFZZ : int [1:46] 17 18 22 23 30 31 35 36 43 44 ...
#>  .. $ DTM582: int [1:23] 19 24 32 37 45 50 58 63 70 75 ...
#>  .. $ ADX   : int [1:10] 25 38 51 76 89 109 122 135 143 156
#>  .. $ SE    : int 164
#>  .. $ GE    : int 165
#>  .. $ IEA   : int 166
#>  @ characters: int [1:166] 105 62 22 50 21 17 29 18 20 23 ...
#>  @ segments  : Named int [1:22] 1 1 1 1 1 1 1 1 1 1 ...
#>  .. - attr(*, "names")= chr [1:22] "ISA" "GS" "ST" "BPR" ...
#>  @ problems  : int 0
#>  @ type      : chr "X12-820-X218"
#> 
#> $sample_820_03
#> <hcc::X12Index>
#>  @ text      : chr [1:1146] "ISA*00*          *00*          *ZZ*TEST-PAYER     *30*TEST-PAYEE     *260316*0854*+*00501*000059659*0*P*:" ...
#>  @ index     :List of 22
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BPR   : int 4
#>  .. $ TRN   : int 5
#>  .. $ REF14 : int 6
#>  .. $ N1PE  : int 7
#>  .. $ N3PE  : int 8
#>  .. $ N4PE  : int 9
#>  .. $ N1PR  : int 10
#>  .. $ N3PR  : int 11
#>  .. $ N4PR  : int 12
#>  .. $ ENT   : int [1:93] 13 26 39 46 59 72 79 92 99 112 ...
#>  .. $ NM1   : int [1:93] 14 27 40 47 60 73 80 93 100 113 ...
#>  .. $ RMR   : int [1:176] 15 20 28 33 41 48 53 61 66 74 ...
#>  .. $ REF18 : int [1:176] 16 21 29 34 42 49 54 62 67 75 ...
#>  .. $ REFZZ : int [1:352] 17 18 22 23 30 31 35 36 43 44 ...
#>  .. $ DTM582: int [1:176] 19 24 32 37 45 52 57 65 70 78 ...
#>  .. $ ADX   : int [1:65] 25 38 58 71 91 111 124 137 150 163 ...
#>  .. $ SE    : int 1144
#>  .. $ GE    : int 1145
#>  .. $ IEA   : int 1146
#>  @ characters: int [1:1146] 105 62 22 51 21 17 29 18 20 23 ...
#>  @ segments  : Named int [1:22] 1 1 1 1 1 1 1 1 1 1 ...
#>  .. - attr(*, "names")= chr [1:22] "ISA" "GS" "ST" "BPR" ...
#>  @ problems  : int 0
#>  @ type      : chr "X12-820-X218"
#> 
#> $sample_820_04
#> <hcc::X12Index>
#>  @ text      : chr [1:95] "ISA*00*          *00*          *ZZ*TEST-PAYER     *30*TEST-PAYEE     *251217*2316*+*00501*000058142*0*P*:" ...
#>  @ index     :List of 21
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BPR   : int 4
#>  .. $ TRN   : int 5
#>  .. $ REF14 : int 6
#>  .. $ N1PE  : int 7
#>  .. $ N3PE  : int 8
#>  .. $ N4PE  : int 9
#>  .. $ N1PR  : int 10
#>  .. $ N3PR  : int 11
#>  .. $ N4PR  : int 12
#>  .. $ ENT   : int [1:10] 13 20 37 44 51 58 65 72 79 86
#>  .. $ NM1   : int [1:10] 14 21 38 45 52 59 66 73 80 87
#>  .. $ RMR   : int [1:12] 15 22 27 32 39 46 53 60 67 74 ...
#>  .. $ REF18 : int [1:12] 16 23 28 33 40 47 54 61 68 75 ...
#>  .. $ REFZZ : int [1:24] 17 18 24 25 29 30 34 35 41 42 ...
#>  .. $ DTM582: int [1:12] 19 26 31 36 43 50 57 64 71 78 ...
#>  .. $ SE    : int 93
#>  .. $ GE    : int 94
#>  .. $ IEA   : int 95
#>  @ characters: int [1:95] 105 62 22 50 21 17 29 18 20 23 ...
#>  @ segments  : Named int [1:21] 1 1 1 1 1 1 1 1 1 1 ...
#>  .. - attr(*, "names")= chr [1:21] "ISA" "GS" "ST" "BPR" ...
#>  @ problems  : int 0
#>  @ type      : chr "X12-820-X218"
#> 
#> $sample_820_05
#> <hcc::X12Index>
#>  @ text      : chr [1:647] "ISA*00*          *00*          *ZZ*TEST-PAYER     *30*TEST-PAYEE     *260217*0936*+*00501*000059431*0*P*:" ...
#>  @ index     :List of 21
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BPR   : int 4
#>  .. $ TRN   : int 5
#>  .. $ REF14 : int 6
#>  .. $ N1PE  : int 7
#>  .. $ N3PE  : int 8
#>  .. $ N4PE  : int 9
#>  .. $ N1PR  : int 10
#>  .. $ N3PR  : int 11
#>  .. $ N4PR  : int 12
#>  .. $ ENT   : int [1:81] 13 20 27 34 41 48 55 62 69 76 ...
#>  .. $ NM1   : int [1:81] 14 21 28 35 42 49 56 63 70 77 ...
#>  .. $ RMR   : int [1:94] 15 22 29 36 43 50 57 64 71 78 ...
#>  .. $ REF18 : int [1:94] 16 23 30 37 44 51 58 65 72 79 ...
#>  .. $ REFZZ : int [1:188] 17 18 24 25 31 32 38 39 45 46 ...
#>  .. $ DTM582: int [1:94] 19 26 33 40 47 54 61 68 75 82 ...
#>  .. $ SE    : int 645
#>  .. $ GE    : int 646
#>  .. $ IEA   : int 647
#>  @ characters: int [1:647] 105 62 22 51 21 17 29 18 20 23 ...
#>  @ segments  : Named int [1:21] 1 1 1 1 1 1 1 1 1 1 ...
#>  .. - attr(*, "names")= chr [1:21] "ISA" "GS" "ST" "BPR" ...
#>  @ problems  : int 0
#>  @ type      : chr "X12-820-X218"
#> 
#> $stedi_820_06
#> [1] NA
#> 
#> $stedi_820_07
#> [1] NA
#> 
# purrr::map(hcc::x12_820[13:17], parse_820)
```
