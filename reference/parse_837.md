# X12-837I (X223A3) & X12-837P (X222A2) Health Care Claim Parser

The 837 describes the care event: who (rendering provider, supervising
physician, referring), for whom (subscriber, patient), for what (ICD-10
diagnosis, CPT/HCPCS procedure), when (service date, units), where
(place of service), and how much (charged amount, contractual
reference). Three `TR3`s segment the audience:

- `005010X222A1`: **837P** Professional (Physicians, Ambulatory,
  Telemedicine)

- `005010X223A2`: **837I** Institutional (Hospitals, ED, Hospice)

- `005010X224A2`: **837D** Dental

## Usage

``` r
index_837(text)

parse_837(text)
```

## Arguments

- text:

  `<chr>` string of raw X12-837 text

## Value

list

## Details

The 837 is the highest-volume transaction in US healthcare EDI. Every
commercial and public payer (Medicare, Medicaid, Tricare) consumes
hundreds of millions per month.

The entire provider-side billing revolves around its generation: from
the EHR (Epic, Cerner, Athenahealth, NextGen) or the PMS (Kareo,
AdvancedMD, eClinicalWorks), through a clearinghouse (Availity, Change
Healthcare, Waystar, Trizetto), with `277CA`, `999`, and ultimately
`835` returns.

### Common segments

#### Transaction Set Header

- `BHT`: Beginning of Hierarchical Transaction

  - Purpose `00` (Original)

  - Transaction type `CH` (Chargeable)

  - `RP` Reporting

  - Submitter `NM1*41`

  - Receiver `NM1*40`

#### Detail: Three hierarchical levels

- `2000A` Billing Provider (Practice or Facility, with NPI, Taxonomy,
  TIN)

- `2000B` Subscriber Loop (Contract Holder)

  - `SBR`:

    - Subscriber Information with relationship code

    - Claim filing indicator (`CI` Commercial Insurance, `MB` Medicare
      Part B, `MC` Medicaid, etc.)

- `2000C` Patient Loop (the Patient when different from the Subscriber).

  - At the claim level, `CLM` Claim Information carries the patient
    account, total charge, facility code, claim frequency.

  - `HI` Health Care Information Codes carries ICD-10 diagnoses
    (qualifier `ABK` Principal Diagnosis, `ABF` Other Diagnosis).

  - The service section groups `LX` + `SV1` (Professional) / `SV2`
    (Institutional) / `SV3` (Dental) detailing each procedure with its
    CPT / HCPCS / CDT code, modifiers, units, charge, and service date
    via `DTP`.

#### Summary

— a single `SE`

## Examples

``` r
purrr::map(hcc::x12_837I, index_837)
#> $`837I_EX1a_institutional_claim`
#> <hcc::X12Index>
#>  @ text      : chr [1:47] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1408*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 36
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
#>  @ characters: int [1:47] 105 66 26 33 36 29 30 10 21 41 ...
#>  @ segments  : Named int [1:36] 1 1 1 1 1 2 1 2 1 1 ...
#>  .. - attr(*, "names")= chr [1:36] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837I-X223"
#> 
#> $`837I_EX1b_2claims_1provider`
#> <hcc::X12Index>
#>  @ text      : chr [1:52] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1410*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 31
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
#>  @ characters: int [1:52] 105 66 26 33 36 29 29 10 21 41 ...
#>  @ segments  : Named int [1:31] 1 1 1 1 1 1 1 3 1 1 ...
#>  .. - attr(*, "names")= chr [1:31] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837I-X223"
#> 
#> $`837I_EX1c_ppo_repriced_claim`
#> <hcc::X12Index>
#>  @ text      : chr [1:52] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1415*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 38
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
#>  @ characters: int [1:52] 105 66 24 37 46 43 48 10 47 23 ...
#>  @ segments  : Named int [1:38] 1 1 1 1 1 1 1 3 1 3 ...
#>  .. - attr(*, "names")= chr [1:38] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837I-X223"
#> 
#> $`837I_EX1d_oon_repriced_claim`
#> <hcc::X12Index>
#>  @ text      : chr [1:35] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1415*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 32
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
#>  @ characters: int [1:35] 105 66 24 33 46 43 48 10 41 20 ...
#>  @ segments  : Named int [1:32] 1 1 1 1 1 1 1 2 1 2 ...
#>  .. - attr(*, "names")= chr [1:32] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837I-X223"
#> 
#> $`837I_EX2_car_accident`
#> <hcc::X12Index>
#>  @ text      : chr [1:47] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1416*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 34
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
#>  @ characters: int [1:47] 105 66 26 33 56 31 51 10 21 57 ...
#>  @ segments  : Named int [1:34] 1 1 1 1 1 1 1 3 1 1 ...
#>  .. - attr(*, "names")= chr [1:34] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837I-X223"
#> 
#> $ex_837_inpatient
#> [1] NA
#> 
#> $sample_837I
#> [1] NA
#> 
#> $sample_837_1
#> <hcc::X12Index>
#>  @ text      : chr [1:49] "ISA*00*          *00*          *ZZ*589155000448185*ZZ*RegenceBluePoin*241205*2042*U*00401*566609694*0*P*:" ...
#>  @ index     :List of 26
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
#>  @ characters: int [1:49] 105 68 24 41 53 33 81 33 10 53 ...
#>  @ segments  : Named int [1:26] 1 1 1 1 1 3 1 2 1 2 ...
#>  .. - attr(*, "names")= chr [1:26] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837I-X223"
#> 
#> $sample_837_10
#> <hcc::X12Index>
#>  @ text      : chr [1:42] "ISA*00*          *00*          *ZZ*765613337801994*ZZ*OptimaFourSight*241205*2042*U*00401*351175143*0*P*:" ...
#>  @ index     :List of 26
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
#>  @ characters: int [1:42] 105 68 24 41 47 33 42 33 10 47 ...
#>  @ segments  : Named int [1:26] 1 1 1 1 1 3 1 2 1 2 ...
#>  .. - attr(*, "names")= chr [1:26] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837I-X223"
#> 
#> $sample_837_2
#> <hcc::X12Index>
#>  @ text      : chr [1:41] "ISA*00*          *00*          *ZZ*961285082616691*ZZ*AntidoteGoldSaf*241205*2042*U*00401*030077084*0*P*:" ...
#>  @ index     :List of 26
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
#>  @ characters: int [1:41] 105 68 27 41 48 33 54 33 10 48 ...
#>  @ segments  : Named int [1:26] 1 1 1 1 1 3 1 2 1 2 ...
#>  .. - attr(*, "names")= chr [1:26] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837I-X223"
#> 
#> $sample_837_3
#> <hcc::X12Index>
#>  @ text      : chr [1:40] "ISA*00*          *00*          *ZZ*657631015478465*ZZ*MOLINAHEALTHCAR*241205*2042*U*00401*828442319*0*P*:" ...
#>  @ index     :List of 26
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
#>  @ characters: int [1:40] 105 68 25 41 48 33 43 33 10 48 ...
#>  @ segments  : Named int [1:26] 1 1 1 1 1 3 1 2 1 2 ...
#>  .. - attr(*, "names")= chr [1:26] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837I-X223"
#> 
#> $sample_837_4
#> <hcc::X12Index>
#>  @ text      : chr [1:38] "ISA*00*          *00*          *ZZ*816055286149740*ZZ*HighDeductibleH*241205*2042*U*00401*621402678*0*P*:" ...
#>  @ index     :List of 26
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
#>  @ characters: int [1:38] 105 68 25 41 46 33 56 33 10 46 ...
#>  @ segments  : Named int [1:26] 1 1 1 1 1 3 1 2 1 2 ...
#>  .. - attr(*, "names")= chr [1:26] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837I-X223"
#> 
#> $sample_837_5
#> <hcc::X12Index>
#>  @ text      : chr [1:48] "ISA*00*          *00*          *ZZ*051153619573476*ZZ*BlanketStudentA*241205*2042*U*00401*518159636*0*P*:" ...
#>  @ index     :List of 26
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
#>  @ characters: int [1:48] 105 68 25 41 53 33 73 33 10 53 ...
#>  @ segments  : Named int [1:26] 1 1 1 1 1 3 1 2 1 2 ...
#>  .. - attr(*, "names")= chr [1:26] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837I-X223"
#> 
#> $sample_837_6
#> <hcc::X12Index>
#>  @ text      : chr [1:52] "ISA*00*          *00*          *ZZ*336342583485277*ZZ*EHB2015IPLAELIC*241205*2042*U*00401*115983591*0*P*:" ...
#>  @ index     :List of 26
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
#>  @ characters: int [1:52] 105 68 28 41 52 33 42 33 10 52 ...
#>  @ segments  : Named int [1:26] 1 1 1 1 1 3 1 2 1 2 ...
#>  .. - attr(*, "names")= chr [1:26] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837I-X223"
#> 
#> $sample_837_7
#> <hcc::X12Index>
#>  @ text      : chr [1:47] "ISA*00*          *00*          *ZZ*879679616399691*ZZ*HSA2000_10A1189*241205*2042*U*00401*871936722*0*P*:" ...
#>  @ index     :List of 26
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
#>  @ characters: int [1:47] 105 68 27 41 53 33 39 33 10 53 ...
#>  @ segments  : Named int [1:26] 1 1 1 1 1 3 1 2 1 2 ...
#>  .. - attr(*, "names")= chr [1:26] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837I-X223"
#> 
#> $sample_837_8
#> <hcc::X12Index>
#>  @ text      : chr [1:45] "ISA*00*          *00*          *ZZ*719189088449132*ZZ*SimplyBluePPOwi*241205*2042*U*00401*464860572*0*P*:" ...
#>  @ index     :List of 26
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
#>  @ characters: int [1:45] 105 68 28 41 58 33 60 33 10 58 ...
#>  @ segments  : Named int [1:26] 1 1 1 1 1 3 1 2 1 2 ...
#>  .. - attr(*, "names")= chr [1:26] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837I-X223"
#> 
#> $sample_837_9
#> <hcc::X12Index>
#>  @ text      : chr [1:50] "ISA*00*          *00*          *ZZ*913673479406110*ZZ*HMOOffExchangeR*241205*2042*U*00401*253034665*0*P*:" ...
#>  @ index     :List of 26
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
#>  @ characters: int [1:50] 105 68 27 41 65 33 48 33 10 65 ...
#>  @ segments  : Named int [1:26] 1 1 1 1 1 3 1 2 1 2 ...
#>  .. - attr(*, "names")= chr [1:26] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837I-X223"
#> 
# purrr::map(hcc::x12_837I[8:17], parse_837)

purrr::map(hcc::x12_837P, index_837)
#> $`837P_EX10a_drug_adm_office`
#> <hcc::X12Index>
#>  @ text      : chr [1:35] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1411*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 29
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
#>  @ characters: int [1:35] 105 66 24 33 48 30 38 10 48 27 ...
#>  @ segments  : Named int [1:29] 1 1 1 1 1 1 1 2 1 2 ...
#>  .. - attr(*, "names")= chr [1:29] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837P-X222"
#> 
#> $`837P_EX11_ppo_repriced_claim`
#> <hcc::X12Index>
#>  @ text      : chr [1:41] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1415*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 30
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
#>  @ characters: int [1:41] 105 66 24 37 46 43 46 10 55 14 ...
#>  @ segments  : Named int [1:30] 1 1 1 1 1 2 1 2 1 3 ...
#>  .. - attr(*, "names")= chr [1:30] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837P-X222"
#> 
#> $`837P_EX12_oon_repriced_claim`
#> <hcc::X12Index>
#>  @ text      : chr [1:43] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1416*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 32
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
#>  @ characters: int [1:43] 105 66 24 33 46 43 48 10 53 20 ...
#>  @ segments  : Named int [1:32] 1 1 1 1 1 1 1 3 1 4 ...
#>  .. - attr(*, "names")= chr [1:32] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837P-X222"
#> 
#> $`837P_EX1_commercial-insurance`
#> <hcc::X12Index>
#>  @ text      : chr [1:46] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1408*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 30
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
#>  @ characters: int [1:46] 105 66 24 35 45 33 46 10 21 46 ...
#>  @ segments  : Named int [1:30] 1 1 1 1 1 1 1 3 1 1 ...
#>  .. - attr(*, "names")= chr [1:30] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837P-X222"
#> 
#> $`837P_EX2_encounter`
#> <hcc::X12Index>
#>  @ text      : chr [1:45] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1418*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 29
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
#>  @ characters: int [1:45] 105 66 24 33 45 33 30 10 21 46 ...
#>  @ segments  : Named int [1:29] 1 1 1 1 1 1 1 2 1 1 ...
#>  .. - attr(*, "names")= chr [1:29] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837P-X222"
#> 
#> $`837P_EX3a_billing_provider_payer_a`
#> <hcc::X12Index>
#>  @ text      : chr [1:56] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1420*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 33
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
#>  @ characters: int [1:56] 105 66 24 33 45 26 37 10 37 16 ...
#>  @ segments  : Named int [1:33] 1 1 1 1 1 2 1 3 1 6 ...
#>  .. - attr(*, "names")= chr [1:33] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837P-X222"
#> 
#> $`837P_EX4_medicare_secondary_cob`
#> <hcc::X12Index>
#>  @ text      : chr [1:47] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1421*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 35
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
#>  @ characters: int [1:47] 105 66 24 40 35 24 43 10 38 14 ...
#>  @ segments  : Named int [1:35] 1 1 1 1 1 1 1 2 1 4 ...
#>  .. - attr(*, "names")= chr [1:35] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837P-X222"
#> 
#> $`837P_EX5_ambulance`
#> <hcc::X12Index>
#>  @ text      : chr [1:56] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1422*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 33
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
#>  .. $ QTYPT : int [1:2] 38 44
#>  .. $ REF6R : int [1:4] 39 45 49 53
#>  .. $ NTE   : int 40
#>  .. $ SE    : int 54
#>  .. $ GE    : int 55
#>  .. $ IEA   : int 56
#>  @ characters: int [1:56] 105 66 29 38 47 31 33 10 21 48 ...
#>  @ segments  : Named int [1:33] 1 1 1 1 1 1 1 2 1 1 ...
#>  .. - attr(*, "names")= chr [1:33] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837P-X222"
#> 
#> $`837P_EX6_chiropractic`
#> <hcc::X12Index>
#>  @ text      : chr [1:33] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1422*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 29
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
#>  @ characters: int [1:33] 105 66 24 37 34 32 46 10 39 19 ...
#>  @ segments  : Named int [1:29] 1 1 1 1 1 2 1 2 1 2 ...
#>  .. - attr(*, "names")= chr [1:29] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837P-X222"
#> 
#> $`837P_EX7_oxygen`
#> <hcc::X12Index>
#>  @ text      : chr [1:70] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1423*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 33
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
#>  .. $ LQUT  : int [1:2] 35 58
#>  .. $ FRM   : int [1:18] 36 37 38 39 40 41 42 43 44 59 ...
#>  .. $ SE    : int 68
#>  .. $ GE    : int 69
#>  .. $ IEA   : int 70
#>  @ characters: int [1:70] 105 66 24 31 46 50 35 10 48 24 ...
#>  @ segments  : Named int [1:33] 1 1 1 1 1 3 1 2 1 4 ...
#>  .. - attr(*, "names")= chr [1:33] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837P-X222"
#> 
#> $`837P_EX8_wheelchair`
#> <hcc::X12Index>
#>  @ text      : chr [1:47] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1424*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 34
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
#>  .. $ LQUT  : int 37
#>  .. $ FRM   : int [1:7] 38 39 40 41 42 43 44
#>  .. $ SE    : int 45
#>  .. $ GE    : int 46
#>  .. $ IEA   : int 47
#>  @ characters: int [1:47] 105 66 26 31 41 25 35 10 45 20 ...
#>  @ segments  : Named int [1:34] 1 1 1 1 1 2 1 2 1 3 ...
#>  .. - attr(*, "names")= chr [1:34] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837P-X222"
#> 
#> $`837P_EX9_anesthesia`
#> <hcc::X12Index>
#>  @ text      : chr [1:33] "ISA*00*          *00*          *ZZ*SENDER         *ZZ*RECEIVER       *231106*1424*^*00501*000000001*0*T*>" ...
#>  @ index     :List of 28
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
#>  @ characters: int [1:33] 105 66 24 33 43 32 31 10 49 20 ...
#>  @ segments  : Named int [1:28] 1 1 1 1 1 1 1 2 1 3 ...
#>  .. - attr(*, "names")= chr [1:28] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837P-X222"
#> 
#> $sample_837P
#> [1] NA
#> 
#> $sample_837_0
#> <hcc::X12Index>
#>  @ text      : chr [1:175] "ISA*00*          *00*          *01*987654321      *ZZ*123456789      *180508*0833*^*00501*697773230*1*P*:" ...
#>  @ index     :List of 31
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
#>  @ characters: int [1:175] 105 68 29 39 43 64 31 10 49 16 ...
#>  @ segments  : Named int [1:31] 1 1 5 5 5 10 5 10 5 20 ...
#>  .. - attr(*, "names")= chr [1:31] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837P-X222"
#> 
#> $sample_837_11
#> <hcc::X12Index>
#>  @ text      : chr [1:29] "ISA*00*          *00*          *ZZ*SUBMITTER ID   *ZZ*RECEIVER ID    *230516*1145*^*00501*000000001*0*P*:" ...
#>  @ index     :List of 26
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
#>  @ characters: int [1:29] 105 61 24 35 35 33 35 10 43 18 ...
#>  @ segments  : Named int [1:26] 1 1 1 1 1 1 1 2 1 2 ...
#>  .. - attr(*, "names")= chr [1:26] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837P-X222"
#> 
#> $sample_837_12
#> <hcc::X12Index>
#>  @ text      : chr [1:113] "ISA*00*          *00*          *ZZ*SUBMITTER ID   *ZZ*RECEIVER ID    *230516*1145*^*00501*000000001*0*P*:" ...
#>  @ index     :List of 31
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
#>  @ characters: int [1:113] 105 61 24 35 35 33 35 10 43 17 ...
#>  @ segments  : Named int [1:31] 1 1 3 3 3 7 3 6 3 6 ...
#>  .. - attr(*, "names")= chr [1:31] "ISA" "GS" "ST" "BHT" ...
#>  @ problems  : int 0
#>  @ type      : chr "837P-X222"
#> 
# purrr::map(hcc::x12_837P[14:16], parse_837)
```
