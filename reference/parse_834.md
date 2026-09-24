# X12-834 (X220A1) Benefit Enrollment Parser

The 834 carries *membership events*:

- new enrollment (qualifier 021)

- change (001)

- termination (024)

- audit/reconciliation (030)

## Usage

``` r
index_834(text)

parse_834(index)
```

## Arguments

- text:

  `<chr>` string of raw X12-834 text

- index:

  `<chr>` string of raw X12-834 text

## Value

list

## Details

It transports member demographics, dependents, chosen plan, effective
and end dates, premium amounts, occasionally tax elements and primary
care provider. It is the system of record for membership on the payer
side.

The 834 is heavily used by BPaaS (Benefits Administration as a Service):

- Workday Benefits

- ADP TotalSource

- bswift

- BenefitFocus

- Empyrean

It is also the official pipe between ACA state exchanges / marketplaces
and payers. The Open Enrollment window (November – December) produces
volume spikes that stress overnight batch jobs.

Extracts enrollment and demographic data from 834 transactions with
focus on:

- Risk adjustment fields (dual eligibility, OREC/CREC, SNP, LTI)

- CA DHCS FAME-specific fields

- HCP (Health Care Plan) coverage history

## Examples

``` r
purrr::map(hcc::x12_834, index_834)
#> $`834_EX2_add_dependent`
#> <hcc::X12Index>
#>  @ text      : chr [1:19] "ISA*00*          *00*          *ZZ*SENDERNAME     *ZZ*RECEIVERNAME   *041227*1324*^*00501*000000103*0*P*>" ...
#>  @ index     :List of 17
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ REF38 : int 5
#>  .. $ N1    : int [1:2] 6 7
#>  .. $ INS   : int 8
#>  .. $ REF0F : int 9
#>  .. $ REF1L : int 10
#>  .. $ DTP351: int 11
#>  .. $ NM1   : int [1:2] 12 14
#>  .. $ DMG   : int 13
#>  .. $ HD    : int 15
#>  .. $ DTP348: int 16
#>  .. $ SE    : int 17
#>  .. $ GE    : int 18
#>  .. $ IEA   : int 19
#>  @ characters: int [1:19] 105 68 25 31 17 19 19 22 16 16 ...
#>  @ segments  : Named int [1:17] 1 1 1 1 1 2 1 1 1 1 ...
#>  .. - attr(*, "names")= chr [1:17] "ISA" "GS" "ST" "BGN" ...
#>  @ problems  : int 0
#>  @ type      : chr "834-X220"
#> 
#> $`834_EX3_enroll_employee_mco`
#> <hcc::X12Index>
#>  @ text      : chr [1:22] "ISA*00*          *00*          *ZZ*SENDERNAME     *ZZ*RECEIVERNAME   *041227*1324*^*00501*000000103*0*P*>" ...
#>  @ index     :List of 20
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ N1    : int [1:2] 5 6
#>  .. $ INS   : int 7
#>  .. $ REF0F : int 8
#>  .. $ REF1L : int 9
#>  .. $ DTP356: int 10
#>  .. $ NM1   : int [1:2] 11 19
#>  .. $ PER   : int 12
#>  .. $ N3    : int 13
#>  .. $ N4    : int 14
#>  .. $ DMG   : int 15
#>  .. $ HD    : int 16
#>  .. $ DTP348: int 17
#>  .. $ LX    : int 18
#>  .. $ SE    : int 20
#>  .. $ GE    : int 21
#>  .. $ IEA   : int 22
#>  @ characters: int [1:22] 105 68 25 31 19 19 22 16 16 19 ...
#>  @ segments  : Named int [1:20] 1 1 1 1 2 1 1 1 1 2 ...
#>  .. - attr(*, "names")= chr [1:20] "ISA" "GS" "ST" "BGN" ...
#>  @ problems  : int 0
#>  @ type      : chr "834-X220"
#> 
#> $`834_EX4_add_subscriber_coverage`
#> <hcc::X12Index>
#>  @ text      : chr [1:16] "ISA*00*          *00*          *ZZ*SENDERNAME     *ZZ*RECEIVERNAME   *041227*1324*^*00501*000000103*0*P*>" ...
#>  @ index     :List of 15
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ REF38 : int 5
#>  .. $ N1    : int [1:2] 6 7
#>  .. $ INS   : int 8
#>  .. $ REF0F : int 9
#>  .. $ REF1L : int 10
#>  .. $ NM1   : int 11
#>  .. $ HD    : int 12
#>  .. $ DTP348: int 13
#>  .. $ SE    : int 14
#>  .. $ GE    : int 15
#>  .. $ IEA   : int 16
#>  @ characters: int [1:16] 105 68 25 31 17 19 19 22 16 16 ...
#>  @ segments  : Named int [1:15] 1 1 1 1 1 2 1 1 1 1 ...
#>  .. - attr(*, "names")= chr [1:15] "ISA" "GS" "ST" "BGN" ...
#>  @ problems  : int 0
#>  @ type      : chr "834-X220"
#> 
#> $`834_EX5_change_subscriber_info`
#> <hcc::X12Index>
#>  @ text      : chr [1:16] "ISA*00*          *00*          *ZZ*SENDERNAME     *ZZ*RECEIVERNAME   *041227*1324*^*00501*000000103*0*P*>" ...
#>  @ index     :List of 13
#>  .. $ ISA  : int 1
#>  .. $ GS   : int 2
#>  .. $ ST   : int 3
#>  .. $ BGN  : int 4
#>  .. $ N1   : int [1:2] 5 6
#>  .. $ INS  : int 7
#>  .. $ REF0F: int 8
#>  .. $ REF1L: int 9
#>  .. $ NM1  : int [1:2] 10 12
#>  .. $ DMG  : int [1:2] 11 13
#>  .. $ SE   : int 14
#>  .. $ GE   : int 15
#>  .. $ IEA  : int 16
#>  @ characters: int [1:16] 105 68 25 31 30 32 22 16 16 35 ...
#>  @ segments  : Named int [1:13] 1 1 1 1 2 1 1 1 2 2 ...
#>  .. - attr(*, "names")= chr [1:13] "ISA" "GS" "ST" "BGN" ...
#>  @ problems  : int 0
#>  @ type      : chr "834-X220"
#> 
#> $`834_EX6_cancel_dependent`
#> <hcc::X12Index>
#>  @ text      : chr [1:16] "ISA*00*          *00*          *ZZ*SENDERNAME     *ZZ*RECEIVERNAME   *041227*1324*^*00501*000000103*0*P*>" ...
#>  @ index     :List of 15
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ REF38 : int 5
#>  .. $ N1    : int [1:2] 6 7
#>  .. $ INS   : int 8
#>  .. $ REF0F : int 9
#>  .. $ REF1L : int 10
#>  .. $ DTP357: int 11
#>  .. $ NM1   : int 12
#>  .. $ DMG   : int 13
#>  .. $ SE    : int 14
#>  .. $ GE    : int 15
#>  .. $ IEA   : int 16
#>  @ characters: int [1:16] 105 68 25 31 17 19 19 17 16 16 ...
#>  @ segments  : Named int [1:15] 1 1 1 1 1 2 1 1 1 1 ...
#>  .. - attr(*, "names")= chr [1:15] "ISA" "GS" "ST" "BGN" ...
#>  @ problems  : int 0
#>  @ type      : chr "834-X220"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`
#> <hcc::X12Index>
#>  @ text      : chr [1:14] "ISA*00*          *00*          *ZZ*SENDERNAME     *ZZ*RECEIVERNAME   *041227*1324*^*00501*000000103*0*P*>" ...
#>  @ index     :List of 13
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ N1    : int [1:2] 5 6
#>  .. $ INS   : int 7
#>  .. $ REF0F : int 8
#>  .. $ REF1L : int 9
#>  .. $ DTP357: int 10
#>  .. $ NM1   : int 11
#>  .. $ SE    : int 12
#>  .. $ GE    : int 13
#>  .. $ IEA   : int 14
#>  @ characters: int [1:14] 105 68 25 31 19 19 22 16 16 19 ...
#>  @ segments  : Named int [1:13] 1 1 1 1 2 1 1 1 1 1 ...
#>  .. - attr(*, "names")= chr [1:13] "ISA" "GS" "ST" "BGN" ...
#>  @ problems  : int 0
#>  @ type      : chr "834-X220"
#> 
#> $`834_EX8_reinstate_employee`
#> <hcc::X12Index>
#>  @ text      : chr [1:15] "ISA*00*          *00*          *ZZ*SENDERNAME     *ZZ*RECEIVERNAME   *041227*1324*^*00501*000000103*0*P*>" ...
#>  @ index     :List of 14
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ REF38 : int 5
#>  .. $ N1    : int [1:2] 6 7
#>  .. $ INS   : int 8
#>  .. $ REF0F : int 9
#>  .. $ REF1L : int 10
#>  .. $ DTP303: int 11
#>  .. $ NM1   : int 12
#>  .. $ SE    : int 13
#>  .. $ GE    : int 14
#>  .. $ IEA   : int 15
#>  @ characters: int [1:15] 105 68 25 31 17 19 19 22 16 16 ...
#>  @ segments  : Named int [1:14] 1 1 1 1 1 2 1 1 1 1 ...
#>  .. - attr(*, "names")= chr [1:14] "ISA" "GS" "ST" "BGN" ...
#>  @ problems  : int 0
#>  @ type      : chr "834-X220"
#> 
#> $`834_EX9_reinstate_employee_coverage`
#> <hcc::X12Index>
#>  @ text      : chr [1:16] "ISA*00*          *00*          *ZZ*SENDERNAME     *ZZ*RECEIVERNAME   *041227*1324*^*00501*000000103*0*P*>" ...
#>  @ index     :List of 15
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ REF38 : int 5
#>  .. $ N1    : int [1:2] 6 7
#>  .. $ INS   : int 8
#>  .. $ REF0F : int 9
#>  .. $ REF1L : int 10
#>  .. $ NM1   : int 11
#>  .. $ HD    : int 12
#>  .. $ DTP348: int 13
#>  .. $ SE    : int 14
#>  .. $ GE    : int 15
#>  .. $ IEA   : int 16
#>  @ characters: int [1:16] 105 68 25 31 17 19 19 20 16 16 ...
#>  @ segments  : Named int [1:15] 1 1 1 1 1 2 1 1 1 1 ...
#>  .. - attr(*, "names")= chr [1:15] "ISA" "GS" "ST" "BGN" ...
#>  @ problems  : int 0
#>  @ type      : chr "834-X220"
#> 
#> $sample_834_01
#> <hcc::X12Index>
#>  @ text      : chr [1:71] "ISA*00*          *00*          *ZZ*DHCS           *ZZ*HEALTHPLAN     *250108*1430*^*00501*000000001*0*P*:" ...
#>  @ index     :List of 24
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ REF38 : int 5
#>  .. $ DTP007: int 6
#>  .. $ N1    : int [1:2] 7 8
#>  .. $ INS   : int [1:5] 9 23 36 51 60
#>  .. $ REF0F : int [1:5] 10 24 37 52 61
#>  .. $ REF6P : int [1:4] 11 25 38 62
#>  .. $ REF1D : int [1:4] 12 26 39 53
#>  .. $ REFABB: int [1:2] 13 40
#>  .. $ NM1   : int [1:5] 14 28 41 54 63
#>  .. $ PER   : int 15
#>  .. $ N3    : int [1:5] 16 29 42 55 64
#>  .. $ N4    : int [1:5] 17 30 43 56 65
#>  .. $ DMG   : int [1:5] 18 31 44 57 66
#>  .. $ HD    : int [1:8] 19 21 32 34 45 48 58 67
#>  .. $ DTP348: int [1:8] 20 22 33 35 46 49 59 68
#>  .. $ REFAB : int 27
#>  .. $ DTP349: int [1:2] 47 50
#>  .. $ SE    : int 69
#>  .. $ GE    : int 70
#>  .. $ IEA   : int 71
#>  @ characters: int [1:71] 105 52 24 31 15 19 34 35 22 13 ...
#>  @ segments  : Named int [1:24] 1 1 1 1 1 1 2 5 5 4 ...
#>  .. - attr(*, "names")= chr [1:24] "ISA" "GS" "ST" "BGN" ...
#>  @ problems  : int 0
#>  @ type      : chr "834-X220"
#> 
#> $sample_834_02
#> <hcc::X12Index>
#>  @ text      : chr [1:33] "ISA*00*          *00*          *ZZ*CADHCS_5010_834*30*999999991      *250124*1927*^*00501*000000001*0*P*:" ...
#>  @ index     :List of 30
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ QTY   : int 5
#>  .. $ N1    : int [1:2] 6 7
#>  .. $ INS   : int 8
#>  .. $ REF0F : int 9
#>  .. $ REF1L : int 10
#>  .. $ REF17 : int [1:2] 11 25
#>  .. $ REF23 : int 12
#>  .. $ REF3H : int 13
#>  .. $ REF6O : int 14
#>  .. $ REFZZ : int [1:2] 15 30
#>  .. $ NM1   : int 16
#>  .. $ PER   : int 17
#>  .. $ N3    : int 18
#>  .. $ N4    : int 19
#>  .. $ DMG   : int 20
#>  .. $ LUI   : int 21
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
#>  @ characters: int [1:33] 105 71 24 65 8 73 35 23 26 17 ...
#>  @ segments  : Named int [1:30] 1 1 1 1 1 2 1 1 1 2 ...
#>  .. - attr(*, "names")= chr [1:30] "ISA" "GS" "ST" "BGN" ...
#>  @ problems  : int 0
#>  @ type      : chr "834-X220"
#> 
#> $sample_834_03
#> <hcc::X12Index>
#>  @ text      : chr [1:36] "ISA*00*          *00*          *ZZ*CADHCS_5010_834*30*999999992      *250812*1936*^*00501*000000002*0*P*:" ...
#>  @ index     :List of 33
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ QTY   : int 5
#>  .. $ N1    : int [1:2] 6 7
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
#>  .. $ NM1   : int 19
#>  .. $ PER   : int 20
#>  .. $ N3    : int 21
#>  .. $ N4    : int 22
#>  .. $ DMG   : int 23
#>  .. $ LUI   : int 24
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
#>  @ characters: int [1:36] 105 71 24 78 8 73 44 23 21 17 ...
#>  @ segments  : Named int [1:33] 1 1 1 1 1 2 1 1 1 2 ...
#>  .. - attr(*, "names")= chr [1:33] "ISA" "GS" "ST" "BGN" ...
#>  @ problems  : int 0
#>  @ type      : chr "834-X220"
#> 
#> $sample_834_04
#> <hcc::X12Index>
#>  @ text      : chr [1:35] "ISA*00*          *00*          *ZZ*CADHCS_5010_834*30*999999992      *251022*2000*^*00501*000000003*0*P*:" ...
#>  @ index     :List of 32
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ QTY   : int 5
#>  .. $ N1    : int [1:2] 6 7
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
#>  .. $ NM1   : int 19
#>  .. $ PER   : int 20
#>  .. $ N3    : int 21
#>  .. $ N4    : int 22
#>  .. $ DMG   : int 23
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
#>  @ characters: int [1:35] 105 71 24 78 8 73 44 23 21 17 ...
#>  @ segments  : Named int [1:32] 1 1 1 1 1 2 1 1 1 2 ...
#>  .. - attr(*, "names")= chr [1:32] "ISA" "GS" "ST" "BGN" ...
#>  @ problems  : int 0
#>  @ type      : chr "834-X220"
#> 
#> $sample_834_05
#> <hcc::X12Index>
#>  @ text      : chr [1:35] "ISA*00*          *00*          *ZZ*CADHCS_5010_834*30*999999992      *251023*1959*^*00501*000000004*0*P*:" ...
#>  @ index     :List of 32
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ QTY   : int 5
#>  .. $ N1    : int [1:2] 6 7
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
#>  .. $ NM1   : int 19
#>  .. $ PER   : int 20
#>  .. $ N3    : int 21
#>  .. $ N4    : int 22
#>  .. $ DMG   : int 23
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
#>  @ characters: int [1:35] 105 71 24 78 8 73 44 23 21 17 ...
#>  @ segments  : Named int [1:32] 1 1 1 1 1 2 1 1 1 2 ...
#>  .. - attr(*, "names")= chr [1:32] "ISA" "GS" "ST" "BGN" ...
#>  @ problems  : int 0
#>  @ type      : chr "834-X220"
#> 
#> $sample_834_06
#> <hcc::X12Index>
#>  @ text      : chr [1:68] "ISA*00*          *00*          *ZZ*CADHCS_5010_834*30*999999991      *250206*2008*^*00501*000000005*0*P*:" ...
#>  @ index     :List of 33
#>  .. $ ISA   : int 1
#>  .. $ GS    : int 2
#>  .. $ ST    : int 3
#>  .. $ BGN   : int 4
#>  .. $ QTY   : int 5
#>  .. $ N1    : int [1:2] 6 7
#>  .. $ INS   : int [1:2] 8 41
#>  .. $ REF0F : int [1:2] 9 42
#>  .. $ REF1L : int [1:2] 10 43
#>  .. $ REF17 : int [1:5] 11 28 36 44 60
#>  .. $ REF23 : int [1:2] 12 45
#>  .. $ REF3H : int [1:2] 13 46
#>  .. $ REF6O : int [1:2] 14 47
#>  .. $ REFQ4 : int 15
#>  .. $ REFZZ : int [1:5] 16 32 40 51 65
#>  .. $ NM1   : int [1:3] 17 22 52
#>  .. $ PER   : int [1:2] 18 53
#>  .. $ N3    : int [1:3] 19 23 54
#>  .. $ N4    : int [1:3] 20 24 55
#>  .. $ DMG   : int [1:2] 21 56
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
#>  @ characters: int [1:68] 105 71 24 65 8 73 35 23 21 17 ...
#>  @ segments  : Named int [1:33] 1 1 1 1 1 2 2 2 2 5 ...
#>  .. - attr(*, "names")= chr [1:33] "ISA" "GS" "ST" "BGN" ...
#>  @ problems  : int 0
#>  @ type      : chr "834-X220"
#> 
```
