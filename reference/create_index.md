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
c(x12_820[1],
  x12_834[1],
  x12_837I[1],
  x12_837P[1]
) |>
  x12_type() |>
  create_index()
#> $`820_EX10_debt_covered_by_affiliate1`
#> <hcc::X12Index>
#>  @ type    : chr "820-X306"
#>  @ text    : chr [1:42] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *240221*1348*^*00501*000000001*0*T*>" ...
#>  @ segments: int 42
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
#> $`834_EX2_add_dependent`
#> <hcc::X12Index>
#>  @ type    : chr "834-X220"
#>  @ text    : chr [1:19] "ISA*00*          *00*          *ZZ*SENDERNAME     *ZZ*RECEIVERNAME   *041227*1324*^*00501*000000103*0*P*>" ...
#>  @ segments: int 19
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
#> $`837I_EX1a_institutional_claim`
#> <hcc::X12Index>
#>  @ type    : chr "837I-X223"
#>  @ text    : chr [1:47] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1408*^*00501*000000001*0*T*>" ...
#>  @ segments: int 47
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
#> $`837P_EX10a_drug_adm_office`
#> <hcc::X12Index>
#>  @ type    : chr "837P-X222"
#>  @ text    : chr [1:35] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1411*^*00501*000000001*0*T*>" ...
#>  @ segments: int 35
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
```
