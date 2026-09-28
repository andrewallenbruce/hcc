# Create X12 Indices

Create X12 Indices

## Arguments

- x:

  an `<hcc::Text8XX>` S7 object

- ...:

  dots

## Value

an `<hcc::X12Index>` S7 object

## Examples

``` r
create_index(x = c(x12_820, x12_834, x12_837I, x12_837P))
#> $`820_EX10_debt_covered_by_affiliate1`
#> <hcc::X12Index>
#>  @ type    : chr "820-X306"
#>  @ text    : chr [1:42] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1348*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 19
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
#> 
#> $`820_EX11_debt_covered_by_affiliate2`
#> <hcc::X12Index>
#>  @ type    : chr "820-X306"
#>  @ text    : chr [1:43] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1404*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 20
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
#> 
#> $`820_EX12_csr_manual_adj`
#> <hcc::X12Index>
#>  @ type    : chr "820-X306"
#>  @ text    : chr [1:34] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1405*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 19
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
#> 
#> $`820_EX1_different_types_of_pmt_by_HIX`
#> <hcc::X12Index>
#>  @ type    : chr "820-X306"
#>  @ text    : chr [1:41] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1259*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 19
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
#> 
#> $`820_EX2_payments_exceed_charges1`
#> <hcc::X12Index>
#>  @ type    : chr "820-X306"
#>  @ text    : chr [1:38] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1259*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 19
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
#> 
#> $`820_EX3_payments_exceed_charges2`
#> <hcc::X12Index>
#>  @ type    : chr "820-X306"
#>  @ text    : chr [1:35] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1331*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 19
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
#> 
#> $`820_EX4_charges_exceed_payments1`
#> <hcc::X12Index>
#>  @ type    : chr "820-X306"
#>  @ text    : chr [1:32] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1335*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 20
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
#> 
#> $`820_EX5_charges_exceed_payments2`
#> <hcc::X12Index>
#>  @ type    : chr "820-X306"
#>  @ text    : chr [1:32] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1338*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 20
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
#> 
#> $`820_EX6_aptc_adjustments1`
#> <hcc::X12Index>
#>  @ type    : chr "820-X306"
#>  @ text    : chr [1:42] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1342*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 19
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
#> 
#> $`820_EX7_aptc_adjustments2`
#> <hcc::X12Index>
#>  @ type    : chr "820-X306"
#>  @ text    : chr [1:39] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1343*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 19
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
#> 
#> $`820_EX8_outstanding_debt_owed1`
#> <hcc::X12Index>
#>  @ type    : chr "820-X306"
#>  @ text    : chr [1:38] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1345*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 19
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
#> 
#> $`820_EX9_outstanding_debt_owed2`
#> <hcc::X12Index>
#>  @ type    : chr "820-X306"
#>  @ text    : chr [1:39] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1347*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 20
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
#> 
#> $sample_820_01
#> <hcc::X12Index>
#>  @ type    : chr "820-X218"
#>  @ text    : chr [1:104] "ISA*00*          *00*          *ZZ*TEST-PAYER     *30*TEST-PAYEE     *260118*0831*+*00501*000058691*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 21
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
#> 
#> $sample_820_02
#> <hcc::X12Index>
#>  @ type    : chr "820-X218"
#>  @ text    : chr [1:166] "ISA*00*          *00*          *ZZ*TEST-PAYER     *30*TEST-PAYEE     *260316*0855*+*00501*000059660*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 22
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
#> 
#> $sample_820_03
#> <hcc::X12Index>
#>  @ type    : chr "820-X218"
#>  @ text    : chr [1:1146] "ISA*00*          *00*          *ZZ*TEST-PAYER     *30*TEST-PAYEE     *260316*0854*+*00501*000059659*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 22
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
#> 
#> $sample_820_04
#> <hcc::X12Index>
#>  @ type    : chr "820-X218"
#>  @ text    : chr [1:95] "ISA*00*          *00*          *ZZ*TEST-PAYER     *30*TEST-PAYEE     *251217*2316*+*00501*000058142*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 21
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
#> 
#> $sample_820_05
#> <hcc::X12Index>
#>  @ type    : chr "820-X218"
#>  @ text    : chr [1:647] "ISA*00*          *00*          *ZZ*TEST-PAYER     *30*TEST-PAYEE     *260217*0936*+*00501*000059431*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 21
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
#> 
#> $stedi_820_06
#> [1] NA
#> 
#> $stedi_820_07
#> [1] NA
#> 
#> $`834_EX2_add_dependent`
#> <hcc::X12Index>
#>  @ type    : chr "834-X220"
#>  @ text    : chr [1:19] "ISA*00*          *00*          *ZZ*SENDERNAME     *ZZ*RECEIVERNAME   *041227*1324*^*00501*000000103*0*P*>" ...
#>  @ problems: int NA
#>  @ index   :List of 19
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ REF38 : int 5
#>  .. $ N1P5  : int 6
#>  .. $ N1IN  : int 7
#>  .. $ INS   : int 8
#>  .. $ REF0F : int 9
#>  .. $ REF1L : int 10
#>  .. $ DTP351: int 11
#>  .. $ NM1IL : int 12
#>  .. $ DMGD8 : int 13
#>  .. $ NM1M8 : int 14
#>  .. $ HD    : int 15
#>  .. $ DTP348: int 16
#>  .. $ SE    : int 17
#>  .. $ GE    : int 18
#>  .. $ IEA   : int 19
#> 
#> $`834_EX3_enroll_employee_mco`
#> <hcc::X12Index>
#>  @ type    : chr "834-X220"
#>  @ text    : chr [1:22] "ISA*00*          *00*          *ZZ*SENDERNAME     *ZZ*RECEIVERNAME   *041227*1324*^*00501*000000103*0*P*>" ...
#>  @ problems: int NA
#>  @ index   :List of 22
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ N1P5  : int 5
#>  .. $ N1IN  : int 6
#>  .. $ INS   : int 7
#>  .. $ REF0F : int 8
#>  .. $ REF1L : int 9
#>  .. $ DTP356: int 10
#>  .. $ NM1IL : int 11
#>  .. $ PERIP : int 12
#>  .. $ N3    : int 13
#>  .. $ N4    : int 14
#>  .. $ DMGD8 : int 15
#>  .. $ HD    : int 16
#>  .. $ DTP348: int 17
#>  .. $ LX    : int 18
#>  .. $ NM1P3 : int 19
#>  .. $ SE    : int 20
#>  .. $ GE    : int 21
#>  .. $ IEA   : int 22
#> 
#> $`834_EX4_add_subscriber_coverage`
#> <hcc::X12Index>
#>  @ type    : chr "834-X220"
#>  @ text    : chr [1:16] "ISA*00*          *00*          *ZZ*SENDERNAME     *ZZ*RECEIVERNAME   *041227*1324*^*00501*000000103*0*P*>" ...
#>  @ problems: int NA
#>  @ index   :List of 16
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ REF38 : int 5
#>  .. $ N1P5  : int 6
#>  .. $ N1IN  : int 7
#>  .. $ INS   : int 8
#>  .. $ REF0F : int 9
#>  .. $ REF1L : int 10
#>  .. $ NM1IL : int 11
#>  .. $ HD    : int 12
#>  .. $ DTP348: int 13
#>  .. $ SE    : int 14
#>  .. $ GE    : int 15
#>  .. $ IEA   : int 16
#> 
#> $`834_EX5_change_subscriber_info`
#> <hcc::X12Index>
#>  @ type    : chr "834-X220"
#>  @ text    : chr [1:16] "ISA*00*          *00*          *ZZ*SENDERNAME     *ZZ*RECEIVERNAME   *041227*1324*^*00501*000000103*0*P*>" ...
#>  @ problems: int NA
#>  @ index   :List of 15
#>  .. $ ISA  : int 1
#>  .. $ GS   : int 2
#>  .. $ ST   : int 3
#>  .. $ BGN  : int 4
#>  .. $ N1P5 : int 5
#>  .. $ N1IN : int 6
#>  .. $ INS  : int 7
#>  .. $ REF0F: int 8
#>  .. $ REF1L: int 9
#>  .. $ NM1IL: int 10
#>  .. $ DMGD8: int [1:2] 11 13
#>  .. $ NM170: int 12
#>  .. $ SE   : int 14
#>  .. $ GE   : int 15
#>  .. $ IEA  : int 16
#> 
#> $`834_EX6_cancel_dependent`
#> <hcc::X12Index>
#>  @ type    : chr "834-X220"
#>  @ text    : chr [1:16] "ISA*00*          *00*          *ZZ*SENDERNAME     *ZZ*RECEIVERNAME   *041227*1324*^*00501*000000103*0*P*>" ...
#>  @ problems: int NA
#>  @ index   :List of 16
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ REF38 : int 5
#>  .. $ N1P5  : int 6
#>  .. $ N1IN  : int 7
#>  .. $ INS   : int 8
#>  .. $ REF0F : int 9
#>  .. $ REF1L : int 10
#>  .. $ DTP357: int 11
#>  .. $ NM1IL : int 12
#>  .. $ DMGD8 : int 13
#>  .. $ SE    : int 14
#>  .. $ GE    : int 15
#>  .. $ IEA   : int 16
#> 
#> $`834_EX7_terminate_subscriber_eligibility`
#> <hcc::X12Index>
#>  @ type    : chr "834-X220"
#>  @ text    : chr [1:14] "ISA*00*          *00*          *ZZ*SENDERNAME     *ZZ*RECEIVERNAME   *041227*1324*^*00501*000000103*0*P*>" ...
#>  @ problems: int NA
#>  @ index   :List of 14
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ N1P5  : int 5
#>  .. $ N1IN  : int 6
#>  .. $ INS   : int 7
#>  .. $ REF0F : int 8
#>  .. $ REF1L : int 9
#>  .. $ DTP357: int 10
#>  .. $ NM1IL : int 11
#>  .. $ SE    : int 12
#>  .. $ GE    : int 13
#>  .. $ IEA   : int 14
#> 
#> $`834_EX8_reinstate_employee`
#> <hcc::X12Index>
#>  @ type    : chr "834-X220"
#>  @ text    : chr [1:15] "ISA*00*          *00*          *ZZ*SENDERNAME     *ZZ*RECEIVERNAME   *041227*1324*^*00501*000000103*0*P*>" ...
#>  @ problems: int NA
#>  @ index   :List of 15
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ REF38 : int 5
#>  .. $ N1P5  : int 6
#>  .. $ N1IN  : int 7
#>  .. $ INS   : int 8
#>  .. $ REF0F : int 9
#>  .. $ REF1L : int 10
#>  .. $ DTP303: int 11
#>  .. $ NM1IL : int 12
#>  .. $ SE    : int 13
#>  .. $ GE    : int 14
#>  .. $ IEA   : int 15
#> 
#> $`834_EX9_reinstate_employee_coverage`
#> <hcc::X12Index>
#>  @ type    : chr "834-X220"
#>  @ text    : chr [1:16] "ISA*00*          *00*          *ZZ*SENDERNAME     *ZZ*RECEIVERNAME   *041227*1324*^*00501*000000103*0*P*>" ...
#>  @ problems: int NA
#>  @ index   :List of 16
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ REF38 : int 5
#>  .. $ N1P5  : int 6
#>  .. $ N1IN  : int 7
#>  .. $ INS   : int 8
#>  .. $ REF0F : int 9
#>  .. $ REF1L : int 10
#>  .. $ NM1IL : int 11
#>  .. $ HD    : int 12
#>  .. $ DTP348: int 13
#>  .. $ SE    : int 14
#>  .. $ GE    : int 15
#>  .. $ IEA   : int 16
#> 
#> $sample_834_01
#> <hcc::X12Index>
#>  @ type    : chr "834-X220"
#>  @ text    : chr [1:71] "ISA*00*          *00*          *ZZ*DHCS           *ZZ*HEALTHPLAN     *250108*1430*^*00501*000000001*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 25
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ REF38 : int 5
#>  .. $ DTP007: int 6
#>  .. $ N1P5  : int 7
#>  .. $ N1IN  : int 8
#>  .. $ INS   : int [1:5] 9 23 36 51 60
#>  .. $ REF0F : int [1:5] 10 24 37 52 61
#>  .. $ REF6P : int [1:4] 11 25 38 62
#>  .. $ REF1D : int [1:4] 12 26 39 53
#>  .. $ REFABB: int [1:2] 13 40
#>  .. $ NM1IL : int [1:5] 14 28 41 54 63
#>  .. $ PERIP : int 15
#>  .. $ N3    : int [1:5] 16 29 42 55 64
#>  .. $ N4    : int [1:5] 17 30 43 56 65
#>  .. $ DMGD8 : int [1:5] 18 31 44 57 66
#>  .. $ HD    : int [1:8] 19 21 32 34 45 48 58 67
#>  .. $ DTP348: int [1:8] 20 22 33 35 46 49 59 68
#>  .. $ REFAB : int 27
#>  .. $ DTP349: int [1:2] 47 50
#>  .. $ SE    : int 69
#>  .. $ GE    : int 70
#>  .. $ IEA   : int 71
#> 
#> $sample_834_02
#> <hcc::X12Index>
#>  @ type    : chr "834-X220"
#>  @ text    : chr [1:33] "ISA*00*          *00*          *ZZ*CADHCS_5010_834*30*999999991      *250124*1927*^*00501*000000001*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 31
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ QTY   : int 5
#>  .. $ N1P5  : int 6
#>  .. $ N1IN  : int 7
#>  .. $ INS   : int 8
#>  .. $ REF0F : int 9
#>  .. $ REF1L : int 10
#>  .. $ REF17 : int [1:2] 11 25
#>  .. $ REF23 : int 12
#>  .. $ REF3H : int 13
#>  .. $ REF6O : int 14
#>  .. $ REFZZ : int [1:2] 15 30
#>  .. $ NM1IL : int 16
#>  .. $ PERIP : int 17
#>  .. $ N3    : int 18
#>  .. $ N4    : int 19
#>  .. $ DMGD8 : int 20
#>  .. $ LUILD : int 21
#>  .. $ HD    : int 22
#>  .. $ DTP348: int 23
#>  .. $ DTP349: int 24
#>  .. $ REF9V : int 26
#>  .. $ REFCE : int 27
#>  .. $ REFRB : int 28
#>  .. $ REFZX : int 29
#>  .. $ SE    : int 31
#>  .. $ GE    : int 32
#>  .. $ IEA   : int 33
#> 
#> $sample_834_03
#> <hcc::X12Index>
#>  @ type    : chr "834-X220"
#>  @ text    : chr [1:36] "ISA*00*          *00*          *ZZ*CADHCS_5010_834*30*999999992      *250812*1936*^*00501*000000002*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 34
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ QTY   : int 5
#>  .. $ N1P5  : int 6
#>  .. $ N1IN  : int 7
#>  .. $ INS   : int 8
#>  .. $ REF0F : int 9
#>  .. $ REF1L : int 10
#>  .. $ REF17 : int [1:2] 11 28
#>  .. $ REF23 : int 12
#>  .. $ REF3H : int 13
#>  .. $ REF6O : int 14
#>  .. $ REFDX : int 15
#>  .. $ REFF6 : int 16
#>  .. $ REFQQ : int 17
#>  .. $ REFZZ : int [1:2] 18 33
#>  .. $ NM1IL : int 19
#>  .. $ PERIP : int 20
#>  .. $ N3    : int 21
#>  .. $ N4    : int 22
#>  .. $ DMGD8 : int 23
#>  .. $ LUILD : int 24
#>  .. $ HD    : int 25
#>  .. $ DTP348: int 26
#>  .. $ DTP349: int 27
#>  .. $ REF9V : int 29
#>  .. $ REFCE : int 30
#>  .. $ REFRB : int 31
#>  .. $ REFZX : int 32
#>  .. $ SE    : int 34
#>  .. $ GE    : int 35
#>  .. $ IEA   : int 36
#> 
#> $sample_834_04
#> <hcc::X12Index>
#>  @ type    : chr "834-X220"
#>  @ text    : chr [1:35] "ISA*00*          *00*          *ZZ*CADHCS_5010_834*30*999999992      *251022*2000*^*00501*000000003*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 33
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ QTY   : int 5
#>  .. $ N1P5  : int 6
#>  .. $ N1IN  : int 7
#>  .. $ INS   : int 8
#>  .. $ REF0F : int 9
#>  .. $ REF1L : int 10
#>  .. $ REF17 : int [1:2] 11 27
#>  .. $ REF23 : int 12
#>  .. $ REF3H : int 13
#>  .. $ REF6O : int 14
#>  .. $ REFDX : int 15
#>  .. $ REFF6 : int 16
#>  .. $ REFQQ : int 17
#>  .. $ REFZZ : int [1:2] 18 32
#>  .. $ NM1IL : int 19
#>  .. $ PERIP : int 20
#>  .. $ N3    : int 21
#>  .. $ N4    : int 22
#>  .. $ DMGD8 : int 23
#>  .. $ HD    : int 24
#>  .. $ DTP348: int 25
#>  .. $ DTP349: int 26
#>  .. $ REF9V : int 28
#>  .. $ REFCE : int 29
#>  .. $ REFRB : int 30
#>  .. $ REFZX : int 31
#>  .. $ SE    : int 33
#>  .. $ GE    : int 34
#>  .. $ IEA   : int 35
#> 
#> $sample_834_05
#> <hcc::X12Index>
#>  @ type    : chr "834-X220"
#>  @ text    : chr [1:35] "ISA*00*          *00*          *ZZ*CADHCS_5010_834*30*999999992      *251023*1959*^*00501*000000004*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 33
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ QTY   : int 5
#>  .. $ N1P5  : int 6
#>  .. $ N1IN  : int 7
#>  .. $ INS   : int 8
#>  .. $ REF0F : int 9
#>  .. $ REF1L : int 10
#>  .. $ REF17 : int [1:2] 11 28
#>  .. $ REF23 : int 12
#>  .. $ REF3H : int 13
#>  .. $ REF6O : int 14
#>  .. $ REFDX : int 15
#>  .. $ REFF6 : int 16
#>  .. $ REFQQ : int 17
#>  .. $ REFZZ : int [1:2] 18 32
#>  .. $ NM1IL : int 19
#>  .. $ PERIP : int 20
#>  .. $ N3    : int 21
#>  .. $ N4    : int 22
#>  .. $ DMGD8 : int 23
#>  .. $ HD    : int 24
#>  .. $ DTP348: int 25
#>  .. $ DTP349: int 26
#>  .. $ AMT   : int 27
#>  .. $ REF9V : int 29
#>  .. $ REFCE : int 30
#>  .. $ REFZX : int 31
#>  .. $ SE    : int 33
#>  .. $ GE    : int 34
#>  .. $ IEA   : int 35
#> 
#> $sample_834_06
#> <hcc::X12Index>
#>  @ type    : chr "834-X220"
#>  @ text    : chr [1:68] "ISA*00*          *00*          *ZZ*CADHCS_5010_834*30*999999991      *250206*2008*^*00501*000000005*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 35
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ QTY   : int 5
#>  .. $ N1P5  : int 6
#>  .. $ N1IN  : int 7
#>  .. $ INS   : int [1:2] 8 41
#>  .. $ REF0F : int [1:2] 9 42
#>  .. $ REF1L : int [1:2] 10 43
#>  .. $ REF17 : int [1:5] 11 28 36 44 60
#>  .. $ REF23 : int [1:2] 12 45
#>  .. $ REF3H : int [1:2] 13 46
#>  .. $ REF6O : int [1:2] 14 47
#>  .. $ REFQ4 : int 15
#>  .. $ REFZZ : int [1:5] 16 32 40 51 65
#>  .. $ NM1IL : int [1:2] 17 52
#>  .. $ PERIP : int [1:2] 18 53
#>  .. $ N3    : int [1:3] 19 23 54
#>  .. $ N4    : int [1:3] 20 24 55
#>  .. $ DMGD8 : int [1:2] 21 56
#>  .. $ NM131 : int 22
#>  .. $ HD    : int [1:3] 25 33 57
#>  .. $ DTP348: int [1:3] 26 34 58
#>  .. $ DTP349: int [1:3] 27 35 59
#>  .. $ REFCE : int [1:3] 29 37 62
#>  .. $ REFRB : int [1:3] 30 38 63
#>  .. $ REFZX : int [1:3] 31 39 64
#>  .. $ REFDX : int 48
#>  .. $ REFF6 : int 49
#>  .. $ REFQQ : int 50
#>  .. $ REF9V : int 61
#>  .. $ SE    : int 66
#>  .. $ GE    : int 67
#>  .. $ IEA   : int 68
#> 
#> $`837I_EX1a_institutional_claim`
#> <hcc::X12Index>
#>  @ type    : chr "837I-X223"
#>  @ text    : chr [1:47] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1408*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 36
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int [1:2] 6 14
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 8 15
#>  .. $ PRVBI : int 9
#>  .. $ NM185 : int 10
#>  .. $ N3    : int [1:3] 11 18 36
#>  .. $ N4    : int [1:3] 12 19 37
#>  .. $ REFEI : int 13
#>  .. $ SBRP  : int 16
#>  .. $ NM1IL : int [1:2] 17 35
#>  .. $ DMG   : int 20
#>  .. $ NM1PR : int [1:2] 21 38
#>  .. $ REFG2 : int 22
#>  .. $ CLM   : int 23
#>  .. $ DTP434: int 24
#>  .. $ CL1   : int 25
#>  .. $ HIBK  : int 26
#>  .. $ HIBF  : int 27
#>  .. $ HIBH  : int 28
#>  .. $ HIBE  : int 29
#>  .. $ HIBG  : int 30
#>  .. $ NM171 : int 31
#>  .. $ REF1G : int 32
#>  .. $ SBRS  : int 33
#>  .. $ OI    : int 34
#>  .. $ LX    : int [1:2] 39 42
#>  .. $ SV2   : int [1:2] 40 43
#>  .. $ DTP472: int [1:2] 41 44
#>  .. $ SE    : int 45
#>  .. $ GE    : int 46
#>  .. $ IEA   : int 47
#> 
#> $`837I_EX1b_2claims_1provider`
#> <hcc::X12Index>
#>  @ type    : chr "837I-X223"
#>  @ text    : chr [1:52] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1410*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 31
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int 6
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:3] 8 14 34
#>  .. $ PRVBI : int 9
#>  .. $ NM185 : int 10
#>  .. $ N3    : int [1:3] 11 17 37
#>  .. $ N4    : int [1:3] 12 18 38
#>  .. $ REFEI : int 13
#>  .. $ SBRP  : int [1:2] 15 35
#>  .. $ NM1IL : int [1:2] 16 36
#>  .. $ DMG   : int [1:2] 19 39
#>  .. $ NM1PR : int [1:2] 20 40
#>  .. $ CLM   : int [1:2] 21 41
#>  .. $ DTP434: int [1:2] 22 42
#>  .. $ CL1   : int [1:2] 23 43
#>  .. $ HIBK  : int [1:2] 24 44
#>  .. $ HIBF  : int 25
#>  .. $ NM171 : int [1:2] 26 45
#>  .. $ REF1G : int 27
#>  .. $ LX    : int [1:3] 28 31 47
#>  .. $ SV2   : int [1:3] 29 32 48
#>  .. $ DTP472: int [1:3] 30 33 49
#>  .. $ PRVAT : int 46
#>  .. $ SE    : int 50
#>  .. $ GE    : int 51
#>  .. $ IEA   : int 52
#> 
#> $`837I_EX1c_ppo_repriced_claim`
#> <hcc::X12Index>
#>  @ type    : chr "837I-X223"
#>  @ text    : chr [1:52] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1415*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 38
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int 6
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:3] 8 13 20
#>  .. $ NM185 : int 9
#>  .. $ N3    : int [1:3] 10 16 23
#>  .. $ N4    : int [1:3] 11 17 24
#>  .. $ REFEI : int 12
#>  .. $ SBRP  : int 14
#>  .. $ NM1IL : int [1:2] 15 40
#>  .. $ DMG   : int [1:2] 18 25
#>  .. $ NM1PR : int [1:2] 19 41
#>  .. $ PAT   : int 21
#>  .. $ NM1QC : int 22
#>  .. $ CLM   : int 26
#>  .. $ DTP434: int 27
#>  .. $ DTP435: int 28
#>  .. $ CL1   : int 29
#>  .. $ AMT   : int 30
#>  .. $ REF9A : int 31
#>  .. $ REFD9 : int 32
#>  .. $ HIBK  : int 33
#>  .. $ HIBF  : int 34
#>  .. $ HIBH  : int 35
#>  .. $ HCP   : int [1:3] 36 45 49
#>  .. $ NM171 : int 37
#>  .. $ SBRS  : int 38
#>  .. $ OI    : int 39
#>  .. $ LX    : int [1:2] 42 46
#>  .. $ SV2   : int [1:2] 43 47
#>  .. $ DTP472: int [1:2] 44 48
#>  .. $ SE    : int 50
#>  .. $ GE    : int 51
#>  .. $ IEA   : int 52
#> 
#> $`837I_EX1d_oon_repriced_claim`
#> <hcc::X12Index>
#>  @ type    : chr "837I-X223"
#>  @ text    : chr [1:35] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1415*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 32
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int 6
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 8 13
#>  .. $ NM185 : int 9
#>  .. $ N3    : int [1:2] 10 16
#>  .. $ N4    : int [1:2] 11 17
#>  .. $ REFEI : int 12
#>  .. $ SBRP  : int 14
#>  .. $ NM1IL : int 15
#>  .. $ DMG   : int 18
#>  .. $ NM1PR : int 19
#>  .. $ CLM   : int 20
#>  .. $ DTP434: int 21
#>  .. $ DTP435: int 22
#>  .. $ CL1   : int 23
#>  .. $ AMT   : int 24
#>  .. $ REF9A : int 25
#>  .. $ REFD9 : int 26
#>  .. $ HIBK  : int 27
#>  .. $ HCP   : int 28
#>  .. $ NM171 : int 29
#>  .. $ LX    : int 30
#>  .. $ SV2   : int 31
#>  .. $ DTP472: int 32
#>  .. $ SE    : int 33
#>  .. $ GE    : int 34
#>  .. $ IEA   : int 35
#> 
#> $`837I_EX2_car_accident`
#> <hcc::X12Index>
#>  @ type    : chr "837I-X223"
#>  @ text    : chr [1:47] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1416*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 34
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int 6
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:3] 8 14 18
#>  .. $ PRVBI : int 9
#>  .. $ NM185 : int 10
#>  .. $ N3    : int [1:2] 11 21
#>  .. $ N4    : int [1:2] 12 22
#>  .. $ REFEI : int 13
#>  .. $ SBRP  : int 15
#>  .. $ NM1IL : int 16
#>  .. $ NM1PR : int 17
#>  .. $ PAT   : int 19
#>  .. $ NM1QC : int 20
#>  .. $ DMG   : int 23
#>  .. $ REFY4 : int 24
#>  .. $ CLM   : int 25
#>  .. $ DTP434: int 26
#>  .. $ CL1   : int 27
#>  .. $ REFLU : int 28
#>  .. $ HIBK  : int 29
#>  .. $ HIPR  : int 30
#>  .. $ HIBN  : int 31
#>  .. $ NM171 : int 32
#>  .. $ LX    : int [1:4] 33 36 39 42
#>  .. $ SV2   : int [1:4] 34 37 40 43
#>  .. $ DTP472: int [1:4] 35 38 41 44
#>  .. $ SE    : int 45
#>  .. $ GE    : int 46
#>  .. $ IEA   : int 47
#> 
#> $ex_837_inpatient
#> [1] NA
#> 
#> $sample_837I
#> [1] NA
#> 
#> $sample_837_1
#> <hcc::X12Index>
#>  @ type    : chr "837I-X223"
#>  @ text    : chr [1:49] "ISA*00*          *00*          *ZZ*589155000448185*ZZ*RegenceBluePoin*241205*2042*U*00401*566609694*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 26
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int [1:3] 6 8 14
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 9 15
#>  .. $ NM185 : int 10
#>  .. $ N3    : int [1:2] 11 18
#>  .. $ N4    : int [1:2] 12 19
#>  .. $ REFEI : int 13
#>  .. $ SBRP  : int 16
#>  .. $ NM1IL : int 17
#>  .. $ CLM   : int 20
#>  .. $ DTP434: int 21
#>  .. $ DTP435: int 22
#>  .. $ DTP096: int 23
#>  .. $ HIABK : int [1:7] 24 25 26 27 28 29 30
#>  .. $ LX    : int [1:4] 31 35 39 43
#>  .. $ SV1   : int [1:4] 32 36 40 44
#>  .. $ DTP472: int [1:4] 33 37 41 45
#>  .. $ REF6R : int [1:4] 34 38 42 46
#>  .. $ SE    : int 47
#>  .. $ GE    : int 48
#>  .. $ IEA   : int 49
#> 
#> $sample_837_10
#> <hcc::X12Index>
#>  @ type    : chr "837I-X223"
#>  @ text    : chr [1:42] "ISA*00*          *00*          *ZZ*765613337801994*ZZ*OptimaFourSight*241205*2042*U*00401*351175143*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 26
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int [1:3] 6 8 14
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 9 15
#>  .. $ NM185 : int 10
#>  .. $ N3    : int [1:2] 11 18
#>  .. $ N4    : int [1:2] 12 19
#>  .. $ REFEI : int 13
#>  .. $ SBRP  : int 16
#>  .. $ NM1IL : int 17
#>  .. $ CLM   : int 20
#>  .. $ DTP434: int 21
#>  .. $ DTP435: int 22
#>  .. $ DTP096: int 23
#>  .. $ HIABK : int [1:4] 24 25 26 27
#>  .. $ LX    : int [1:3] 28 32 36
#>  .. $ SV1   : int [1:3] 29 33 37
#>  .. $ DTP472: int [1:3] 30 34 38
#>  .. $ REF6R : int [1:3] 31 35 39
#>  .. $ SE    : int 40
#>  .. $ GE    : int 41
#>  .. $ IEA   : int 42
#> 
#> $sample_837_2
#> <hcc::X12Index>
#>  @ type    : chr "837I-X223"
#>  @ text    : chr [1:41] "ISA*00*          *00*          *ZZ*961285082616691*ZZ*AntidoteGoldSaf*241205*2042*U*00401*030077084*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 26
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int [1:3] 6 8 14
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 9 15
#>  .. $ NM185 : int 10
#>  .. $ N3    : int [1:2] 11 18
#>  .. $ N4    : int [1:2] 12 19
#>  .. $ REFEI : int 13
#>  .. $ SBRP  : int 16
#>  .. $ NM1IL : int 17
#>  .. $ CLM   : int 20
#>  .. $ DTP434: int 21
#>  .. $ DTP435: int 22
#>  .. $ DTP096: int 23
#>  .. $ HIABK : int [1:3] 24 25 26
#>  .. $ LX    : int [1:3] 27 31 35
#>  .. $ SV1   : int [1:3] 28 32 36
#>  .. $ DTP472: int [1:3] 29 33 37
#>  .. $ REF6R : int [1:3] 30 34 38
#>  .. $ SE    : int 39
#>  .. $ GE    : int 40
#>  .. $ IEA   : int 41
#> 
#> $sample_837_3
#> <hcc::X12Index>
#>  @ type    : chr "837I-X223"
#>  @ text    : chr [1:40] "ISA*00*          *00*          *ZZ*657631015478465*ZZ*MOLINAHEALTHCAR*241205*2042*U*00401*828442319*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 26
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int [1:3] 6 8 14
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 9 15
#>  .. $ NM185 : int 10
#>  .. $ N3    : int [1:2] 11 18
#>  .. $ N4    : int [1:2] 12 19
#>  .. $ REFEI : int 13
#>  .. $ SBRP  : int 16
#>  .. $ NM1IL : int 17
#>  .. $ CLM   : int 20
#>  .. $ DTP434: int 21
#>  .. $ DTP435: int 22
#>  .. $ DTP096: int 23
#>  .. $ HIABK : int [1:6] 24 25 26 27 28 29
#>  .. $ LX    : int [1:2] 30 34
#>  .. $ SV1   : int [1:2] 31 35
#>  .. $ DTP472: int [1:2] 32 36
#>  .. $ REF6R : int [1:2] 33 37
#>  .. $ SE    : int 38
#>  .. $ GE    : int 39
#>  .. $ IEA   : int 40
#> 
#> $sample_837_4
#> <hcc::X12Index>
#>  @ type    : chr "837I-X223"
#>  @ text    : chr [1:38] "ISA*00*          *00*          *ZZ*816055286149740*ZZ*HighDeductibleH*241205*2042*U*00401*621402678*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 26
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int [1:3] 6 8 14
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 9 15
#>  .. $ NM185 : int 10
#>  .. $ N3    : int [1:2] 11 18
#>  .. $ N4    : int [1:2] 12 19
#>  .. $ REFEI : int 13
#>  .. $ SBRP  : int 16
#>  .. $ NM1IL : int 17
#>  .. $ CLM   : int 20
#>  .. $ DTP434: int 21
#>  .. $ DTP435: int 22
#>  .. $ DTP096: int 23
#>  .. $ HIABK : int [1:8] 24 25 26 27 28 29 30 31
#>  .. $ LX    : int 32
#>  .. $ SV1   : int 33
#>  .. $ DTP472: int 34
#>  .. $ REF6R : int 35
#>  .. $ SE    : int 36
#>  .. $ GE    : int 37
#>  .. $ IEA   : int 38
#> 
#> $sample_837_5
#> <hcc::X12Index>
#>  @ type    : chr "837I-X223"
#>  @ text    : chr [1:48] "ISA*00*          *00*          *ZZ*051153619573476*ZZ*BlanketStudentA*241205*2042*U*00401*518159636*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 26
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int [1:3] 6 8 14
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 9 15
#>  .. $ NM185 : int 10
#>  .. $ N3    : int [1:2] 11 18
#>  .. $ N4    : int [1:2] 12 19
#>  .. $ REFEI : int 13
#>  .. $ SBRP  : int 16
#>  .. $ NM1IL : int 17
#>  .. $ CLM   : int 20
#>  .. $ DTP434: int 21
#>  .. $ DTP435: int 22
#>  .. $ DTP096: int 23
#>  .. $ HIABK : int [1:6] 24 25 26 27 28 29
#>  .. $ LX    : int [1:4] 30 34 38 42
#>  .. $ SV1   : int [1:4] 31 35 39 43
#>  .. $ DTP472: int [1:4] 32 36 40 44
#>  .. $ REF6R : int [1:4] 33 37 41 45
#>  .. $ SE    : int 46
#>  .. $ GE    : int 47
#>  .. $ IEA   : int 48
#> 
#> $sample_837_6
#> <hcc::X12Index>
#>  @ type    : chr "837I-X223"
#>  @ text    : chr [1:52] "ISA*00*          *00*          *ZZ*336342583485277*ZZ*EHB2015IPLAELIC*241205*2042*U*00401*115983591*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 26
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int [1:3] 6 8 14
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 9 15
#>  .. $ NM185 : int 10
#>  .. $ N3    : int [1:2] 11 18
#>  .. $ N4    : int [1:2] 12 19
#>  .. $ REFEI : int 13
#>  .. $ SBRP  : int 16
#>  .. $ NM1IL : int 17
#>  .. $ CLM   : int 20
#>  .. $ DTP434: int 21
#>  .. $ DTP435: int 22
#>  .. $ DTP096: int 23
#>  .. $ HIABK : int [1:6] 24 25 26 27 28 29
#>  .. $ LX    : int [1:5] 30 34 38 42 46
#>  .. $ SV1   : int [1:5] 31 35 39 43 47
#>  .. $ DTP472: int [1:5] 32 36 40 44 48
#>  .. $ REF6R : int [1:5] 33 37 41 45 49
#>  .. $ SE    : int 50
#>  .. $ GE    : int 51
#>  .. $ IEA   : int 52
#> 
#> $sample_837_7
#> <hcc::X12Index>
#>  @ type    : chr "837I-X223"
#>  @ text    : chr [1:47] "ISA*00*          *00*          *ZZ*879679616399691*ZZ*HSA2000_10A1189*241205*2042*U*00401*871936722*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 26
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int [1:3] 6 8 14
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 9 15
#>  .. $ NM185 : int 10
#>  .. $ N3    : int [1:2] 11 18
#>  .. $ N4    : int [1:2] 12 19
#>  .. $ REFEI : int 13
#>  .. $ SBRP  : int 16
#>  .. $ NM1IL : int 17
#>  .. $ CLM   : int 20
#>  .. $ DTP434: int 21
#>  .. $ DTP435: int 22
#>  .. $ DTP096: int 23
#>  .. $ HIABK : int [1:5] 24 25 26 27 28
#>  .. $ LX    : int [1:4] 29 33 37 41
#>  .. $ SV1   : int [1:4] 30 34 38 42
#>  .. $ DTP472: int [1:4] 31 35 39 43
#>  .. $ REF6R : int [1:4] 32 36 40 44
#>  .. $ SE    : int 45
#>  .. $ GE    : int 46
#>  .. $ IEA   : int 47
#> 
#> $sample_837_8
#> <hcc::X12Index>
#>  @ type    : chr "837I-X223"
#>  @ text    : chr [1:45] "ISA*00*          *00*          *ZZ*719189088449132*ZZ*SimplyBluePPOwi*241205*2042*U*00401*464860572*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 26
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int [1:3] 6 8 14
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 9 15
#>  .. $ NM185 : int 10
#>  .. $ N3    : int [1:2] 11 18
#>  .. $ N4    : int [1:2] 12 19
#>  .. $ REFEI : int 13
#>  .. $ SBRP  : int 16
#>  .. $ NM1IL : int 17
#>  .. $ CLM   : int 20
#>  .. $ DTP434: int 21
#>  .. $ DTP435: int 22
#>  .. $ DTP096: int 23
#>  .. $ HIABK : int [1:3] 24 25 26
#>  .. $ LX    : int [1:4] 27 31 35 39
#>  .. $ SV1   : int [1:4] 28 32 36 40
#>  .. $ DTP472: int [1:4] 29 33 37 41
#>  .. $ REF6R : int [1:4] 30 34 38 42
#>  .. $ SE    : int 43
#>  .. $ GE    : int 44
#>  .. $ IEA   : int 45
#> 
#> $sample_837_9
#> <hcc::X12Index>
#>  @ type    : chr "837I-X223"
#>  @ text    : chr [1:50] "ISA*00*          *00*          *ZZ*913673479406110*ZZ*HMOOffExchangeR*241205*2042*U*00401*253034665*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 26
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int [1:3] 6 8 14
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 9 15
#>  .. $ NM185 : int 10
#>  .. $ N3    : int [1:2] 11 18
#>  .. $ N4    : int [1:2] 12 19
#>  .. $ REFEI : int 13
#>  .. $ SBRP  : int 16
#>  .. $ NM1IL : int 17
#>  .. $ CLM   : int 20
#>  .. $ DTP434: int 21
#>  .. $ DTP435: int 22
#>  .. $ DTP096: int 23
#>  .. $ HIABK : int [1:8] 24 25 26 27 28 29 30 31
#>  .. $ LX    : int [1:4] 32 36 40 44
#>  .. $ SV1   : int [1:4] 33 37 41 45
#>  .. $ DTP472: int [1:4] 34 38 42 46
#>  .. $ REF6R : int [1:4] 35 39 43 47
#>  .. $ SE    : int 48
#>  .. $ GE    : int 49
#>  .. $ IEA   : int 50
#> 
#> $`837P_EX10a_drug_adm_office`
#> <hcc::X12Index>
#>  @ type    : chr "837P-X222"
#>  @ text    : chr [1:35] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1411*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 29
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int 6
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 8 13
#>  .. $ NM185 : int 9
#>  .. $ N3    : int [1:2] 10 16
#>  .. $ N4    : int [1:2] 11 17
#>  .. $ REFEI : int 12
#>  .. $ SBRP  : int 14
#>  .. $ NM1IL : int 15
#>  .. $ DMG   : int 18
#>  .. $ NM1PR : int 19
#>  .. $ CLM   : int 20
#>  .. $ HIBK  : int 21
#>  .. $ NM182 : int 22
#>  .. $ PRVPE : int 23
#>  .. $ LX    : int [1:2] 24 27
#>  .. $ SV1   : int [1:2] 25 28
#>  .. $ DTP472: int [1:2] 26 29
#>  .. $ AMT   : int 30
#>  .. $ LIN   : int 31
#>  .. $ CTP   : int 32
#>  .. $ SE    : int 33
#>  .. $ GE    : int 34
#>  .. $ IEA   : int 35
#> 
#> $`837P_EX11_ppo_repriced_claim`
#> <hcc::X12Index>
#>  @ type    : chr "837P-X222"
#>  @ text    : chr [1:41] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1415*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 30
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int [1:2] 6 13
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 8 14
#>  .. $ NM185 : int 9
#>  .. $ N3    : int [1:3] 10 17 29
#>  .. $ N4    : int [1:3] 11 18 30
#>  .. $ REFEI : int 12
#>  .. $ SBRP  : int 15
#>  .. $ NM1IL : int 16
#>  .. $ DMG   : int 19
#>  .. $ NM1PR : int 20
#>  .. $ CLM   : int 21
#>  .. $ REF9A : int 22
#>  .. $ REFD9 : int 23
#>  .. $ HIBK  : int 24
#>  .. $ HCP   : int [1:3] 25 34 38
#>  .. $ NM1DN : int 26
#>  .. $ NM182 : int 27
#>  .. $ NM177 : int 28
#>  .. $ LX    : int [1:2] 31 35
#>  .. $ SV1   : int [1:2] 32 36
#>  .. $ DTP472: int [1:2] 33 37
#>  .. $ SE    : int 39
#>  .. $ GE    : int 40
#>  .. $ IEA   : int 41
#> 
#> $`837P_EX12_oon_repriced_claim`
#> <hcc::X12Index>
#>  @ type    : chr "837P-X222"
#>  @ text    : chr [1:43] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1416*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 32
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int 6
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:3] 8 13 20
#>  .. $ NM185 : int 9
#>  .. $ N3    : int [1:4] 10 16 23 35
#>  .. $ N4    : int [1:4] 11 17 24 36
#>  .. $ REFEI : int 12
#>  .. $ SBRP  : int 14
#>  .. $ NM1IL : int [1:2] 15 34
#>  .. $ DMG   : int [1:2] 18 25
#>  .. $ NM1PR : int [1:2] 19 37
#>  .. $ PAT   : int 21
#>  .. $ NM1QC : int 22
#>  .. $ CLM   : int 26
#>  .. $ REF9A : int 27
#>  .. $ REFD9 : int 28
#>  .. $ HIBK  : int 29
#>  .. $ HCP   : int 30
#>  .. $ NM182 : int 31
#>  .. $ SBRS  : int 32
#>  .. $ OI    : int 33
#>  .. $ LX    : int 38
#>  .. $ SV1   : int 39
#>  .. $ DTP472: int 40
#>  .. $ SE    : int 41
#>  .. $ GE    : int 42
#>  .. $ IEA   : int 43
#> 
#> $`837P_EX1_commercial-insurance`
#> <hcc::X12Index>
#>  @ type    : chr "837P-X222"
#>  @ text    : chr [1:46] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1408*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 30
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int 6
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:3] 8 17 23
#>  .. $ PRVBI : int 9
#>  .. $ NM185 : int 10
#>  .. $ N3    : int [1:3] 11 15 26
#>  .. $ N4    : int [1:3] 12 16 27
#>  .. $ REFEI : int 13
#>  .. $ NM187 : int 14
#>  .. $ SBRP  : int 18
#>  .. $ NM1IL : int 19
#>  .. $ DMG   : int [1:2] 20 28
#>  .. $ NM1PR : int 21
#>  .. $ REFG2 : int 22
#>  .. $ PAT   : int 24
#>  .. $ NM1QC : int 25
#>  .. $ CLM   : int 29
#>  .. $ REFD9 : int 30
#>  .. $ HIBK  : int 31
#>  .. $ LX    : int [1:4] 32 35 38 41
#>  .. $ SV1   : int [1:4] 33 36 39 42
#>  .. $ DTP472: int [1:4] 34 37 40 43
#>  .. $ SE    : int 44
#>  .. $ GE    : int 45
#>  .. $ IEA   : int 46
#> 
#> $`837P_EX2_encounter`
#> <hcc::X12Index>
#>  @ type    : chr "837P-X222"
#>  @ text    : chr [1:45] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1418*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 29
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int 6
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 8 17
#>  .. $ PRVBI : int 9
#>  .. $ NM185 : int 10
#>  .. $ N3    : int [1:4] 11 15 20 29
#>  .. $ N4    : int [1:4] 12 16 21 30
#>  .. $ REFEI : int 13
#>  .. $ NM187 : int 14
#>  .. $ SBRP  : int 18
#>  .. $ NM1IL : int 19
#>  .. $ DMG   : int 22
#>  .. $ NM1PR : int 23
#>  .. $ CLM   : int 24
#>  .. $ DTP431: int 25
#>  .. $ REFD9 : int 26
#>  .. $ HIBK  : int 27
#>  .. $ NM177 : int 28
#>  .. $ LX    : int [1:4] 31 34 37 40
#>  .. $ SV1   : int [1:4] 32 35 38 41
#>  .. $ DTP472: int [1:4] 33 36 39 42
#>  .. $ SE    : int 43
#>  .. $ GE    : int 44
#>  .. $ IEA   : int 45
#> 
#> $`837P_EX3a_billing_provider_payer_a`
#> <hcc::X12Index>
#>  @ type    : chr "837P-X222"
#>  @ text    : chr [1:56] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1420*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 33
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int [1:2] 6 13
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:3] 8 17 25
#>  .. $ NM185 : int 9
#>  .. $ N3    : int [1:6] 10 15 22 28 37 42
#>  .. $ N4    : int [1:6] 11 16 23 29 38 43
#>  .. $ REFEI : int 12
#>  .. $ NM187 : int 14
#>  .. $ SBRP  : int 18
#>  .. $ NM1IL : int [1:2] 19 41
#>  .. $ DMG   : int [1:2] 20 30
#>  .. $ NM1PR : int [1:2] 21 44
#>  .. $ REFG2 : int [1:2] 24 35
#>  .. $ PAT   : int 26
#>  .. $ NM1QC : int 27
#>  .. $ CLM   : int 31
#>  .. $ HIBK  : int 32
#>  .. $ NM182 : int 33
#>  .. $ PRVPE : int 34
#>  .. $ NM177 : int 36
#>  .. $ SBRS  : int 39
#>  .. $ OI    : int 40
#>  .. $ LX    : int [1:3] 45 48 51
#>  .. $ SV1   : int [1:3] 46 49 52
#>  .. $ DTP472: int [1:3] 47 50 53
#>  .. $ SE    : int 54
#>  .. $ GE    : int 55
#>  .. $ IEA   : int 56
#> 
#> $`837P_EX4_medicare_secondary_cob`
#> <hcc::X12Index>
#>  @ type    : chr "837P-X222"
#>  @ text    : chr [1:47] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1421*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 35
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int 6
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 8 14
#>  .. $ NM185 : int 9
#>  .. $ N3    : int [1:4] 10 17 21 35
#>  .. $ N4    : int [1:4] 11 18 22 36
#>  .. $ REFEI : int 12
#>  .. $ REF1G : int [1:2] 13 26
#>  .. $ SBRS  : int 15
#>  .. $ NM1IL : int [1:2] 16 34
#>  .. $ DMG   : int 19
#>  .. $ NM1PR : int [1:2] 20 37
#>  .. $ CLM   : int 23
#>  .. $ HIBK  : int 24
#>  .. $ NM1DN : int 25
#>  .. $ NM182 : int 27
#>  .. $ PRVPE : int 28
#>  .. $ REFG2 : int 29
#>  .. $ SBRP  : int 30
#>  .. $ AMT   : int [1:2] 31 32
#>  .. $ OI    : int 33
#>  .. $ LX    : int 38
#>  .. $ SV1   : int 39
#>  .. $ DTP472: int 40
#>  .. $ SVD   : int 41
#>  .. $ CAS   : int [1:2] 42 43
#>  .. $ DTP573: int 44
#>  .. $ SE    : int 45
#>  .. $ GE    : int 46
#>  .. $ IEA   : int 47
#> 
#> $`837P_EX5_ambulance`
#> <hcc::X12Index>
#>  @ type    : chr "837P-X222"
#>  @ text    : chr [1:56] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1422*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 33
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int 6
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 8 14
#>  .. $ PRVBI : int 9
#>  .. $ NM185 : int 10
#>  .. $ N3    : int [1:5] 11 17 21 30 33
#>  .. $ N4    : int [1:5] 12 18 22 31 34
#>  .. $ REFEI : int 13
#>  .. $ SBRP  : int 15
#>  .. $ NM1IL : int 16
#>  .. $ DMG   : int 19
#>  .. $ NM1PR : int 20
#>  .. $ CLM   : int 23
#>  .. $ DTP439: int 24
#>  .. $ CR1   : int 25
#>  .. $ CRC   : int [1:2] 26 27
#>  .. $ HIBK  : int 28
#>  .. $ NM1PW : int 29
#>  .. $ NM145 : int 32
#>  .. $ LX    : int [1:4] 35 41 46 50
#>  .. $ SV1   : int [1:4] 36 42 47 51
#>  .. $ DTP472: int [1:4] 37 43 48 52
#>  .. $ QTY   : int [1:2] 38 44
#>  .. $ REF6R : int [1:4] 39 45 49 53
#>  .. $ NTE   : int 40
#>  .. $ SE    : int 54
#>  .. $ GE    : int 55
#>  .. $ IEA   : int 56
#> 
#> $`837P_EX6_chiropractic`
#> <hcc::X12Index>
#>  @ type    : chr "837P-X222"
#>  @ text    : chr [1:33] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1422*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 29
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int [1:2] 6 13
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 8 14
#>  .. $ NM185 : int 9
#>  .. $ N3    : int [1:2] 10 17
#>  .. $ N4    : int [1:2] 11 18
#>  .. $ REFEI : int 12
#>  .. $ SBRP  : int 15
#>  .. $ NM1IL : int 16
#>  .. $ DMG   : int 19
#>  .. $ NM1PR : int 20
#>  .. $ CLM   : int 21
#>  .. $ DTP454: int 22
#>  .. $ DTP453: int 23
#>  .. $ DTP455: int 24
#>  .. $ CR2   : int 25
#>  .. $ HIBK  : int 26
#>  .. $ LX    : int 27
#>  .. $ SV1   : int 28
#>  .. $ DTP472: int 29
#>  .. $ REF6R : int 30
#>  .. $ SE    : int 31
#>  .. $ GE    : int 32
#>  .. $ IEA   : int 33
#> 
#> $`837P_EX7_oxygen`
#> <hcc::X12Index>
#>  @ type    : chr "837P-X222"
#>  @ text    : chr [1:70] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1423*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 33
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int [1:3] 6 34 57
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 8 13
#>  .. $ NM185 : int 9
#>  .. $ N3    : int [1:4] 10 16 31 54
#>  .. $ N4    : int [1:4] 11 17 32 55
#>  .. $ REFEI : int 12
#>  .. $ SBRP  : int 14
#>  .. $ NM1IL : int 15
#>  .. $ DMG   : int 18
#>  .. $ NM1PR : int 19
#>  .. $ CLM   : int 20
#>  .. $ HIBK  : int 21
#>  .. $ LX    : int [1:2] 22 45
#>  .. $ SV1   : int [1:2] 23 46
#>  .. $ PWK   : int [1:2] 24 47
#>  .. $ CR3   : int [1:2] 25 48
#>  .. $ DTP472: int [1:2] 26 49
#>  .. $ DTP607: int [1:2] 27 50
#>  .. $ DTP463: int [1:2] 28 51
#>  .. $ DTP461: int [1:2] 29 52
#>  .. $ NM1DK : int [1:2] 30 53
#>  .. $ REF1G : int [1:2] 33 56
#>  .. $ LQ    : int [1:2] 35 58
#>  .. $ FRM   : int [1:18] 36 37 38 39 40 41 42 43 44 59 ...
#>  .. $ SE    : int 68
#>  .. $ GE    : int 69
#>  .. $ IEA   : int 70
#> 
#> $`837P_EX8_wheelchair`
#> <hcc::X12Index>
#>  @ type    : chr "837P-X222"
#>  @ text    : chr [1:47] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1424*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 34
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int [1:2] 6 36
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 8 14
#>  .. $ NM185 : int 9
#>  .. $ N3    : int [1:3] 10 18 33
#>  .. $ N4    : int [1:3] 11 19 34
#>  .. $ REFEI : int 12
#>  .. $ REF1G : int [1:2] 13 35
#>  .. $ SBRP  : int 15
#>  .. $ PAT   : int 16
#>  .. $ NM1IL : int 17
#>  .. $ DMG   : int 20
#>  .. $ NM1PR : int 21
#>  .. $ CLM   : int 22
#>  .. $ HIBK  : int 23
#>  .. $ LX    : int 24
#>  .. $ SV1   : int 25
#>  .. $ PWK   : int 26
#>  .. $ CR3   : int 27
#>  .. $ DTP472: int 28
#>  .. $ DTP463: int 29
#>  .. $ DTP461: int 30
#>  .. $ MEA   : int 31
#>  .. $ NM1DK : int 32
#>  .. $ LQ    : int 37
#>  .. $ FRM   : int [1:7] 38 39 40 41 42 43 44
#>  .. $ SE    : int 45
#>  .. $ GE    : int 46
#>  .. $ IEA   : int 47
#> 
#> $`837P_EX9_anesthesia`
#> <hcc::X12Index>
#>  @ type    : chr "837P-X222"
#>  @ text    : chr [1:33] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1424*^*00501*000000001*0*T*>" ...
#>  @ problems: int NA
#>  @ index   :List of 28
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int 6
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 8 13
#>  .. $ NM185 : int 9
#>  .. $ N3    : int [1:3] 10 16 26
#>  .. $ N4    : int [1:3] 11 17 27
#>  .. $ REFEI : int 12
#>  .. $ SBRP  : int 14
#>  .. $ NM1IL : int 15
#>  .. $ DMG   : int 18
#>  .. $ NM1PR : int 19
#>  .. $ CLM   : int 20
#>  .. $ HIBK  : int 21
#>  .. $ NM182 : int 22
#>  .. $ PRVPE : int 23
#>  .. $ REFG2 : int 24
#>  .. $ NM177 : int 25
#>  .. $ LX    : int 28
#>  .. $ SV1   : int 29
#>  .. $ DTP472: int 30
#>  .. $ SE    : int 31
#>  .. $ GE    : int 32
#>  .. $ IEA   : int 33
#> 
#> $sample_837P
#> [1] NA
#> 
#> $sample_837_0
#> <hcc::X12Index>
#>  @ type    : chr "837P-X222"
#>  @ text    : chr [1:175] "ISA*00*          *00*          *01*987654321      *ZZ*123456789      *180508*0833*^*00501*697773230*1*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 31
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int [1:5] 3 37 71 105 140
#>  .. $ BHT   : int [1:5] 4 38 72 106 141
#>  .. $ NM141 : int [1:5] 5 39 73 107 142
#>  .. $ PERIC : int [1:10] 6 13 40 47 74 81 108 115 143 150
#>  .. $ NM140 : int [1:5] 7 41 75 109 144
#>  .. $ HL    : int [1:10] 8 17 42 51 76 85 110 119 145 154
#>  .. $ NM185 : int [1:5] 9 43 77 111 146
#>  .. $ N3    : int [1:20] 10 15 20 30 44 49 54 64 78 83 ...
#>  .. $ N4    : int [1:20] 11 16 21 31 45 50 55 65 79 84 ...
#>  .. $ REFEI : int [1:5] 12 46 80 114 149
#>  .. $ NM187 : int [1:5] 14 48 82 116 151
#>  .. $ SBRP  : int [1:5] 18 52 86 120 155
#>  .. $ NM1IL : int [1:5] 19 53 87 121 156
#>  .. $ DMG   : int [1:5] 22 56 90 124 159
#>  .. $ NM1PR : int [1:5] 23 57 91 125 160
#>  .. $ CLM   : int [1:5] 24 58 92 126 161
#>  .. $ REFD9 : int [1:5] 25 59 93 127 162
#>  .. $ HIABK : int [1:5] 26 60 94 128 163
#>  .. $ NM182 : int [1:5] 27 61 95 129 164
#>  .. $ PRVPE : int [1:5] 28 62 96 130 165
#>  .. $ NM177 : int [1:5] 29 63 97 131 166
#>  .. $ LX    : int [1:5] 32 66 100 134 169
#>  .. $ SV1   : int [1:5] 33 67 101 135 170
#>  .. $ DTP472: int [1:5] 34 68 102 136 171
#>  .. $ REF6R : int [1:5] 35 69 103 137 172
#>  .. $ SE    : int [1:5] 36 70 104 139 173
#>  .. $ NTE   : int 138
#>  .. $ GE    : int 174
#>  .. $ IEA   : int 175
#> 
#> $sample_837_11
#> <hcc::X12Index>
#>  @ type    : chr "837P-X222"
#>  @ text    : chr [1:29] "ISA*00*          *00*          *ZZ*SUBMITTER ID   *ZZ*RECEIVER ID    *230516*1145*^*00501*000000001*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 26
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BHT   : int 4
#>  .. $ NM141 : int 5
#>  .. $ PERIC : int 6
#>  .. $ NM140 : int 7
#>  .. $ HL    : int [1:2] 8 13
#>  .. $ NM185 : int 9
#>  .. $ N3    : int [1:2] 10 16
#>  .. $ N4    : int [1:2] 11 17
#>  .. $ REFEI : int 12
#>  .. $ SBRP  : int 14
#>  .. $ NM1IL : int 15
#>  .. $ DMG   : int 18
#>  .. $ CLM   : int 19
#>  .. $ HIABK : int 20
#>  .. $ NM182 : int 21
#>  .. $ PRVPE : int 22
#>  .. $ SV1   : int 23
#>  .. $ DTP472: int 24
#>  .. $ LIN   : int 25
#>  .. $ CTP   : int 26
#>  .. $ SE    : int 27
#>  .. $ GE    : int 28
#>  .. $ IEA   : int 29
#> 
#> $sample_837_12
#> <hcc::X12Index>
#>  @ type    : chr "837P-X222"
#>  @ text    : chr [1:113] "ISA*00*          *00*          *ZZ*SUBMITTER ID   *ZZ*RECEIVER ID    *230516*1145*^*00501*000000001*0*P*:" ...
#>  @ problems: int NA
#>  @ index   :List of 31
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int [1:3] 3 28 66
#>  .. $ BHT   : int [1:3] 4 29 67
#>  .. $ NM141 : int [1:3] 5 30 68
#>  .. $ PERIC : int [1:7] 6 31 33 39 69 71 77
#>  .. $ NM140 : int [1:3] 7 32 70
#>  .. $ HL    : int [1:6] 8 13 34 40 72 78
#>  .. $ NM185 : int [1:3] 9 35 73
#>  .. $ N3    : int [1:6] 10 16 36 43 74 81
#>  .. $ N4    : int [1:6] 11 17 37 44 75 82
#>  .. $ REFEI : int [1:3] 12 38 76
#>  .. $ SBRP  : int [1:3] 14 41 79
#>  .. $ NM1IL : int [1:3] 15 42 80
#>  .. $ DMG   : int 18
#>  .. $ CLM   : int [1:3] 19 45 83
#>  .. $ HIABK : int [1:13] 20 49 50 51 52 87 88 89 90 91 ...
#>  .. $ NM182 : int 21
#>  .. $ PRVPE : int 22
#>  .. $ SV1   : int [1:8] 23 54 58 62 96 100 104 108
#>  .. $ DTP472: int [1:8] 24 55 59 63 97 101 105 109
#>  .. $ LIN   : int 25
#>  .. $ CTP   : int 26
#>  .. $ SE    : int [1:3] 27 65 111
#>  .. $ DTP434: int [1:2] 46 84
#>  .. $ DTP435: int [1:2] 47 85
#>  .. $ DTP096: int [1:2] 48 86
#>  .. $ LX    : int [1:7] 53 57 61 95 99 103 107
#>  .. $ REF6R : int [1:7] 56 60 64 98 102 106 110
#>  .. $ GE    : int 112
#>  .. $ IEA   : int 113
#> 
```
