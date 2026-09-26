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
parse_837(x)
```

## Arguments

- x:

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

- a single `SE`

## Examples

``` r
purrr::map(hcc::x12_837I, index_x12) |> purrr::map(parse_837)
#> $`837I_EX1a_institutional_claim`
#> $`837I_EX1a_institutional_claim`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "231106"    "1408"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`837I_EX1a_institutional_claim`$GS
#> [1] "GS"           "HC"           "SENDERGS"     "RECEIVERGS"   "20231106"    
#> [6] "140822"       "000000001"    "X"            "005010X223A2"
#> 
#> $`837I_EX1a_institutional_claim`$ST
#> [1] "ST"           "837"          "987654"       "005010X223A2"
#> 
#> $`837I_EX1a_institutional_claim`$BHT
#> [1] "BHT"      "0019"     "00"       "0123"     "19960918" "0932"     "CH"      
#> 
#> $`837I_EX1a_institutional_claim`$NM141
#>  [1] "NM1"            "41"             "2"              "JONES HOSPITAL"
#>  [5] NA               NA               NA               NA              
#>  [9] "46"             "12345"         
#> 
#> $`837I_EX1a_institutional_claim`$PERIC
#> [1] "PER"        "IC"         "JANE DOE"   "TE"         "9005555555"
#> 
#> $`837I_EX1a_institutional_claim`$NM140
#>  [1] "NM1"      "40"       "2"        "MEDICARE" NA         NA        
#>  [7] NA         NA         "46"       "00120"   
#> 
#> $`837I_EX1a_institutional_claim`$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $`837I_EX1a_institutional_claim`$PRVBI
#> [1] "PRV"        "BI"         "PXC"        "203BA0200N"
#> 
#> $`837I_EX1a_institutional_claim`$NM185
#>  [1] "NM1"            "85"             "2"              "JONES HOSPITAL"
#>  [5] NA               NA               NA               NA              
#>  [9] "XX"             "9876540809"    
#> 
#> $`837I_EX1a_institutional_claim`$`N3225 MAIN STREET BARKLEY BUILDING`
#> [1] "N3"                               "225 MAIN STREET BARKLEY BUILDING"
#> 
#> $`837I_EX1a_institutional_claim`$N4CENTERVILLE
#> [1] "N4"          "CENTERVILLE" "PA"          "17111"      
#> 
#> $`837I_EX1a_institutional_claim`$REFEI
#> [1] "REF"       "EI"        "567891234"
#> 
#> $`837I_EX1a_institutional_claim`$PERIC
#> [1] "PER"        "IC"         "CONNIE"     "TE"         "3055551234"
#> 
#> $`837I_EX1a_institutional_claim`$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $`837I_EX1a_institutional_claim`$SBRP
#>  [1] "SBR" "P"   "18"  NA    NA    NA    NA    NA    NA    "MB" 
#> 
#> $`837I_EX1a_institutional_claim`$NM1IL
#>  [1] "NM1"        "IL"         "1"          "DOE"        "JOHN"      
#>  [6] "T"          NA           NA           "MI"         "030005074A"
#> 
#> $`837I_EX1a_institutional_claim`$`N3125 CITY AVENUE`
#> [1] "N3"              "125 CITY AVENUE"
#> 
#> $`837I_EX1a_institutional_claim`$N4CENTERVILLE
#> [1] "N4"          "CENTERVILLE" "PA"          "17111"      
#> 
#> $`837I_EX1a_institutional_claim`$DMGD8
#> [1] "DMG"      "D8"       "19261111" "M"       
#> 
#> $`837I_EX1a_institutional_claim`$NM1PR
#>  [1] "NM1"        "PR"         "2"          "MEDICARE B" NA          
#>  [6] NA           NA           NA           "PI"         "00435"     
#> 
#> $`837I_EX1a_institutional_claim`$REFG2
#> [1] "REF"    "G2"     "330127"
#> 
#> $`837I_EX1a_institutional_claim`[[23]]
#>  [1] "CLM"     "756048Q" "89.93"   NA        NA        "14>A>1"  NA       
#>  [8] "A"       "Y"       "Y"      
#> 
#> $`837I_EX1a_institutional_claim`[[24]]
#> [1] "DTP"      "434"      "RD8"      "19960911"
#> 
#> $`837I_EX1a_institutional_claim`[[25]]
#> [1] "CL1" "3"   NA    "01" 
#> 
#> $`837I_EX1a_institutional_claim`[[26]]
#> [1] "HI"      "BK>3669"
#> 
#> $`837I_EX1a_institutional_claim`[[27]]
#> [1] "HI"       "BF>4019"  "BF>79431"
#> 
#> $`837I_EX1a_institutional_claim`[[28]]
#> [1] "HI"                "BH>A1>D8>19261111" "BH>A2>D8>19911101"
#> [4] "BH>B1>D8>19261111" "BH>B2>D8>19870101"
#> 
#> $`837I_EX1a_institutional_claim`[[29]]
#> [1] "HI"            "BE>A2>>>15.31"
#> 
#> $`837I_EX1a_institutional_claim`[[30]]
#> [1] "HI"    "BG>09"
#> 
#> $`837I_EX1a_institutional_claim`[[31]]
#> [1] "NM1"   "71"    "1"     "JONES" "JOHN"  "J"    
#> 
#> $`837I_EX1a_institutional_claim`[[32]]
#> [1] "REF"    "1G"     "B99937"
#> 
#> $`837I_EX1a_institutional_claim`[[33]]
#>  [1] "SBR"            "S"              "01"             "351630"        
#>  [5] "STATE TEACHERS" NA               NA               NA              
#>  [9] NA               "CI"            
#> 
#> $`837I_EX1a_institutional_claim`[[34]]
#> [1] "OI" NA   NA   "Y"  NA   NA   "Y" 
#> 
#> $`837I_EX1a_institutional_claim`[[35]]
#>  [1] "NM1"       "IL"        "1"         "DOE"       "JANE"      "S"        
#>  [7] NA          NA          "MI"        "222004433"
#> 
#> $`837I_EX1a_institutional_claim`[[36]]
#> [1] "N3"              "125 CITY AVENUE"
#> 
#> $`837I_EX1a_institutional_claim`[[37]]
#> [1] "N4"          "CENTERVILLE" "PA"          "17111"      
#> 
#> $`837I_EX1a_institutional_claim`[[38]]
#>  [1] "NM1"            "PR"             "2"              "STATE TEACHERS"
#>  [5] NA               NA               NA               NA              
#>  [9] "PI"             "1135"          
#> 
#> $`837I_EX1a_institutional_claim`[[39]]
#> [1] "LX" "1" 
#> 
#> $`837I_EX1a_institutional_claim`[[40]]
#> [1] "SV2"      "0305"     "HC>85025" "13.39"    "UN"       "1"       
#> 
#> $`837I_EX1a_institutional_claim`[[41]]
#> [1] "DTP"      "472"      "D8"       "19960911"
#> 
#> $`837I_EX1a_institutional_claim`[[42]]
#> [1] "LX" "2" 
#> 
#> $`837I_EX1a_institutional_claim`[[43]]
#> [1] "SV2"      "0730"     "HC>93005" "76.54"    "UN"       "3"       
#> 
#> $`837I_EX1a_institutional_claim`[[44]]
#> [1] "DTP"      "472"      "D8"       "19960911"
#> 
#> $`837I_EX1a_institutional_claim`$SE
#> [1] "SE"     "43"     "987654"
#> 
#> $`837I_EX1a_institutional_claim`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`837I_EX1a_institutional_claim`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`837I_EX1b_2claims_1provider`
#> $`837I_EX1b_2claims_1provider`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "231106"    "1410"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`837I_EX1b_2claims_1provider`$GS
#> [1] "GS"           "HC"           "SENDERGS"     "RECEIVERGS"   "20231106"    
#> [6] "141054"       "000000001"    "X"            "005010X223A2"
#> 
#> $`837I_EX1b_2claims_1provider`$ST
#> [1] "ST"           "837"          "987654"       "005010X223A2"
#> 
#> $`837I_EX1b_2claims_1provider`$BHT
#> [1] "BHT"      "0019"     "00"       "0123"     "20050630" "0932"     "CH"      
#> 
#> $`837I_EX1b_2claims_1provider`$NM141
#>  [1] "NM1"            "41"             "2"              "JONES HOSPITAL"
#>  [5] NA               NA               NA               NA              
#>  [9] "46"             "12345"         
#> 
#> $`837I_EX1b_2claims_1provider`$PERIC
#> [1] "PER"        "IC"         "JANE DOE"   "TE"         "1112223333"
#> 
#> $`837I_EX1b_2claims_1provider`$NM140
#>  [1] "NM1"     "40"      "2"       "TRICARE" NA        NA        NA       
#>  [8] NA        "46"      "99999"  
#> 
#> $`837I_EX1b_2claims_1provider`$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $`837I_EX1b_2claims_1provider`$PRVBI
#> [1] "PRV"        "BI"         "PXC"        "282N00000X"
#> 
#> $`837I_EX1b_2claims_1provider`$NM185
#>  [1] "NM1"            "85"             "2"              "JONES HOSPITAL"
#>  [5] NA               NA               NA               NA              
#>  [9] "XX"             "1234567890"    
#> 
#> $`837I_EX1b_2claims_1provider`$`N3225 MAIN STREET`
#> [1] "N3"              "225 MAIN STREET"
#> 
#> $`837I_EX1b_2claims_1provider`$N4ANYWHERE
#> [1] "N4"       "ANYWHERE" "PA"       "17111"   
#> 
#> $`837I_EX1b_2claims_1provider`$REFEI
#> [1] "REF"       "EI"        "123456789"
#> 
#> $`837I_EX1b_2claims_1provider`$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $`837I_EX1b_2claims_1provider`$SBRP
#>  [1] "SBR" "P"   "18"  NA    NA    NA    NA    NA    NA    "CH" 
#> 
#> $`837I_EX1b_2claims_1provider`$NM1IL
#>  [1] "NM1"       "IL"        "1"         "DOE"       "JOHN"      "T"        
#>  [7] NA          NA          "MI"        "030005074"
#> 
#> $`837I_EX1b_2claims_1provider`$`N3125 CITY AVENUE`
#> [1] "N3"              "125 CITY AVENUE"
#> 
#> $`837I_EX1b_2claims_1provider`$N4CENTERVILLE
#> [1] "N4"          "CENTERVILLE" "PA"          "17111"      
#> 
#> $`837I_EX1b_2claims_1provider`$DMGD8
#> [1] "DMG"      "D8"       "19681111" "M"       
#> 
#> $`837I_EX1b_2claims_1provider`$NM1PR
#>  [1] "NM1"     "PR"      "2"       "TRICARE" NA        NA        NA       
#>  [8] NA        "PI"      "99999"  
#> 
#> $`837I_EX1b_2claims_1provider`$NM141
#>  [1] "NM1"            "41"             "2"              "JONES HOSPITAL"
#>  [5] NA               NA               NA               NA              
#>  [9] "46"             "12345"         
#> 
#> $`837I_EX1b_2claims_1provider`$PERIC
#> [1] "PER"        "IC"         "JANE DOE"   "TE"         "1112223333"
#> 
#> $`837I_EX1b_2claims_1provider`$NM140
#>  [1] "NM1"     "40"      "2"       "TRICARE" NA        NA        NA       
#>  [8] NA        "46"      "99999"  
#> 
#> $`837I_EX1b_2claims_1provider`$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $`837I_EX1b_2claims_1provider`$PRVBI
#> [1] "PRV"        "BI"         "PXC"        "282N00000X"
#> 
#> $`837I_EX1b_2claims_1provider`$NM185
#>  [1] "NM1"            "85"             "2"              "JONES HOSPITAL"
#>  [5] NA               NA               NA               NA              
#>  [9] "XX"             "1234567890"    
#> 
#> $`837I_EX1b_2claims_1provider`$`N3225 MAIN STREET`
#> [1] "N3"              "225 MAIN STREET"
#> 
#> $`837I_EX1b_2claims_1provider`$N4ANYWHERE
#> [1] "N4"       "ANYWHERE" "PA"       "17111"   
#> 
#> $`837I_EX1b_2claims_1provider`$REFEI
#> [1] "REF"       "EI"        "123456789"
#> 
#> $`837I_EX1b_2claims_1provider`$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $`837I_EX1b_2claims_1provider`$SBRP
#>  [1] "SBR" "P"   "18"  NA    NA    NA    NA    NA    NA    "CH" 
#> 
#> $`837I_EX1b_2claims_1provider`$NM1IL
#>  [1] "NM1"       "IL"        "1"         "DOE"       "JOHN"      "T"        
#>  [7] NA          NA          "MI"        "030005074"
#> 
#> $`837I_EX1b_2claims_1provider`$`N3125 CITY AVENUE`
#> [1] "N3"              "125 CITY AVENUE"
#> 
#> $`837I_EX1b_2claims_1provider`$N4CENTERVILLE
#> [1] "N4"          "CENTERVILLE" "PA"          "17111"      
#> 
#> $`837I_EX1b_2claims_1provider`$DMGD8
#> [1] "DMG"      "D8"       "19681111" "M"       
#> 
#> $`837I_EX1b_2claims_1provider`$NM1PR
#>  [1] "NM1"     "PR"      "2"       "TRICARE" NA        NA        NA       
#>  [8] NA        "PI"      "99999"  
#> 
#> $`837I_EX1b_2claims_1provider`$CLM756048Q
#>  [1] "CLM"     "756048Q" "89.95"   NA        NA        "13>A>1"  NA       
#>  [8] "C"       "Y"       "Y"      
#> 
#> $`837I_EX1b_2claims_1provider`$DTP434
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20050315-20050315"
#> 
#> $`837I_EX1b_2claims_1provider`$CL11
#> [1] "CL1" "1"   NA    "01" 
#> 
#> $`837I_EX1b_2claims_1provider`$`HIBK>3669`
#> [1] "HI"      "BK>3669"
#> 
#> $`837I_EX1b_2claims_1provider`$`HIBF>4019`
#> [1] "HI"       "BF>4019"  "BF>79431"
#> 
#> $`837I_EX1b_2claims_1provider`$NM171
#>  [1] "NM1"        "71"         "1"          "JONES"      "JOHN"      
#>  [6] "J"          NA           NA           "XX"         "1122334455"
#> 
#> $`837I_EX1b_2claims_1provider`$REF1G
#> [1] "REF"    "1G"     "U12345"
#> 
#> $`837I_EX1b_2claims_1provider`$LX1
#> [1] "LX" "1" 
#> 
#> $`837I_EX1b_2claims_1provider`$SV20305
#> [1] "SV2"      "0305"     "HC>85025" "13.39"    "UN"       "1"       
#> 
#> $`837I_EX1b_2claims_1provider`$DTP472
#> [1] "DTP"      "472"      "D8"       "20050315"
#> 
#> $`837I_EX1b_2claims_1provider`$LX2
#> [1] "LX" "2" 
#> 
#> $`837I_EX1b_2claims_1provider`$SV20730
#> [1] "SV2"      "0730"     "HC>93010" "76.56"    "UN"       "3"       
#> 
#> $`837I_EX1b_2claims_1provider`$DTP472
#> [1] "DTP"      "472"      "D8"       "20050315"
#> 
#> $`837I_EX1b_2claims_1provider`$HL3
#> [1] "HL" "3"  "1"  "22" "0" 
#> 
#> $`837I_EX1b_2claims_1provider`$SBRP
#>  [1] "SBR" "P"   "18"  NA    NA    NA    NA    NA    NA    "CH" 
#> 
#> $`837I_EX1b_2claims_1provider`$NM1IL
#>  [1] "NM1"       "IL"        "1"         "SMITH"     "JOE"       NA         
#>  [7] NA          NA          "MI"        "123405074"
#> 
#> $`837I_EX1b_2claims_1provider`$`N35 MAIN STREET`
#> [1] "N3"            "5 MAIN STREET"
#> 
#> $`837I_EX1b_2claims_1provider`$N4ANYWHERE
#> [1] "N4"       "ANYWHERE" "PA"       "17111"   
#> 
#> $`837I_EX1b_2claims_1provider`$DMGD8
#> [1] "DMG"      "D8"       "19621210" "M"       
#> 
#> $`837I_EX1b_2claims_1provider`$NM1PR
#>  [1] "NM1"     "PR"      "2"       "TRICARE" NA        NA        NA       
#>  [8] NA        "PI"      "99999"  
#> 
#> $`837I_EX1b_2claims_1provider`[[57]]
#>  [1] "CLM"     "756048Q" "89.95"   NA        NA        "13>A>1"  NA       
#>  [8] "C"       "Y"       "Y"      
#> 
#> $`837I_EX1b_2claims_1provider`[[58]]
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20050315-20050315"
#> 
#> $`837I_EX1b_2claims_1provider`[[59]]
#> [1] "CL1" "1"   NA    "01" 
#> 
#> $`837I_EX1b_2claims_1provider`[[60]]
#> [1] "HI"      "BK>3669"
#> 
#> $`837I_EX1b_2claims_1provider`[[61]]
#> [1] "HI"       "BF>4019"  "BF>79431"
#> 
#> $`837I_EX1b_2claims_1provider`[[62]]
#>  [1] "NM1"        "71"         "1"          "JONES"      "JOHN"      
#>  [6] "J"          NA           NA           "XX"         "1122334455"
#> 
#> $`837I_EX1b_2claims_1provider`[[63]]
#> [1] "REF"    "1G"     "U12345"
#> 
#> $`837I_EX1b_2claims_1provider`[[64]]
#> [1] "LX" "1" 
#> 
#> $`837I_EX1b_2claims_1provider`[[65]]
#> [1] "SV2"      "0305"     "HC>85025" "13.39"    "UN"       "1"       
#> 
#> $`837I_EX1b_2claims_1provider`[[66]]
#> [1] "DTP"      "472"      "D8"       "20050315"
#> 
#> $`837I_EX1b_2claims_1provider`[[67]]
#> [1] "LX" "2" 
#> 
#> $`837I_EX1b_2claims_1provider`[[68]]
#> [1] "SV2"      "0730"     "HC>93010" "76.56"    "UN"       "3"       
#> 
#> $`837I_EX1b_2claims_1provider`[[69]]
#> [1] "DTP"      "472"      "D8"       "20050315"
#> 
#> $`837I_EX1b_2claims_1provider`[[70]]
#> [1] "HL" "3"  "1"  "22" "0" 
#> 
#> $`837I_EX1b_2claims_1provider`[[71]]
#>  [1] "SBR" "P"   "18"  NA    NA    NA    NA    NA    NA    "CH" 
#> 
#> $`837I_EX1b_2claims_1provider`[[72]]
#>  [1] "NM1"       "IL"        "1"         "SMITH"     "JOE"       NA         
#>  [7] NA          NA          "MI"        "123405074"
#> 
#> $`837I_EX1b_2claims_1provider`[[73]]
#> [1] "N3"            "5 MAIN STREET"
#> 
#> $`837I_EX1b_2claims_1provider`[[74]]
#> [1] "N4"       "ANYWHERE" "PA"       "17111"   
#> 
#> $`837I_EX1b_2claims_1provider`[[75]]
#> [1] "DMG"      "D8"       "19621210" "M"       
#> 
#> $`837I_EX1b_2claims_1provider`[[76]]
#>  [1] "NM1"     "PR"      "2"       "TRICARE" NA        NA        NA       
#>  [8] NA        "PI"      "99999"  
#> 
#> $`837I_EX1b_2claims_1provider`[[77]]
#>  [1] "CLM"     "756049Q" "50"      NA        NA        "13>A>1"  NA       
#>  [8] "C"       "Y"       "Y"      
#> 
#> $`837I_EX1b_2claims_1provider`[[78]]
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20050401-20050401"
#> 
#> $`837I_EX1b_2claims_1provider`[[79]]
#> [1] "CL1" "1"   NA    "01" 
#> 
#> $`837I_EX1b_2claims_1provider`[[80]]
#> [1] "HI"       "BK>30000"
#> 
#> $`837I_EX1b_2claims_1provider`[[81]]
#>  [1] "NM1"        "71"         "1"          "JONES"      "JUDY"      
#>  [6] "J"          NA           NA           "XX"         "9999999999"
#> 
#> $`837I_EX1b_2claims_1provider`[[82]]
#> [1] "PRV"        "AT"         "PXC"        "363LP0200N"
#> 
#> $`837I_EX1b_2claims_1provider`[[83]]
#> [1] "LX" "1" 
#> 
#> $`837I_EX1b_2claims_1provider`[[84]]
#> [1] "SV2"      "0300"     "HC>85087" "50"       "UN"       "1"       
#> 
#> $`837I_EX1b_2claims_1provider`[[85]]
#> [1] "DTP"      "472"      "D8"       "20050401"
#> 
#> $`837I_EX1b_2claims_1provider`[[86]]
#>  [1] "CLM"     "756049Q" "50"      NA        NA        "13>A>1"  NA       
#>  [8] "C"       "Y"       "Y"      
#> 
#> $`837I_EX1b_2claims_1provider`[[87]]
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20050401-20050401"
#> 
#> $`837I_EX1b_2claims_1provider`[[88]]
#> [1] "CL1" "1"   NA    "01" 
#> 
#> $`837I_EX1b_2claims_1provider`[[89]]
#> [1] "HI"       "BK>30000"
#> 
#> $`837I_EX1b_2claims_1provider`[[90]]
#>  [1] "NM1"        "71"         "1"          "JONES"      "JUDY"      
#>  [6] "J"          NA           NA           "XX"         "9999999999"
#> 
#> $`837I_EX1b_2claims_1provider`[[91]]
#> [1] "PRV"        "AT"         "PXC"        "363LP0200N"
#> 
#> $`837I_EX1b_2claims_1provider`[[92]]
#> [1] "LX" "1" 
#> 
#> $`837I_EX1b_2claims_1provider`[[93]]
#> [1] "SV2"      "0300"     "HC>85087" "50"       "UN"       "1"       
#> 
#> $`837I_EX1b_2claims_1provider`[[94]]
#> [1] "DTP"      "472"      "D8"       "20050401"
#> 
#> $`837I_EX1b_2claims_1provider`$SE
#> [1] "SE"     "48"     "987654"
#> 
#> $`837I_EX1b_2claims_1provider`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`837I_EX1b_2claims_1provider`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`837I_EX1c_ppo_repriced_claim`
#> $`837I_EX1c_ppo_repriced_claim`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "231106"    "1415"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`837I_EX1c_ppo_repriced_claim`$GS
#> [1] "GS"           "HC"           "SENDERGS"     "RECEIVERGS"   "20231106"    
#> [6] "141512"       "000000001"    "X"            "005010X223A2"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$ST
#> [1] "ST"           "837"          "1002"         "005010X223A2"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$BHT
#> [1] "BHT"      "0019"     "00"       "1002"     "20050721" "09460000" "CH"      
#> 
#> $`837I_EX1c_ppo_repriced_claim`$NM141
#>  [1] "NM1"                  "41"                   "2"                   
#>  [4] "REGIONAL PPO NETWORK" NA                     NA                    
#>  [7] NA                     NA                     "46"                  
#> [10] "123456789"           
#> 
#> $`837I_EX1c_ppo_repriced_claim`$PERIC
#> [1] "PER"                    "IC"                     "SUBMITTER CONTACT INFO"
#> [4] "TE"                     "8001231234"            
#> 
#> $`837I_EX1c_ppo_repriced_claim`$NM140
#>  [1] "NM1"                     "40"                     
#>  [3] "2"                       "LOCAL INSURANCE COMPANY"
#>  [5] NA                        NA                       
#>  [7] NA                        NA                       
#>  [9] "46"                      "54334452"               
#> 
#> $`837I_EX1c_ppo_repriced_claim`$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $`837I_EX1c_ppo_repriced_claim`$NM185
#>  [1] "NM1"                  "85"                   "2"                   
#>  [4] "GOOD HEALTH HOSPITAL" NA                     NA                    
#>  [7] NA                     NA                     "XX"                  
#> [10] "1257234346"          
#> 
#> $`837I_EX1c_ppo_repriced_claim`$`N3592 NORTH ELM STREET`
#> [1] "N3"                   "592 NORTH ELM STREET"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$N4EDGEWOOD
#> [1] "N4"        "EDGEWOOD"  "AZ"        "860015590"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$REFEI
#> [1] "REF"       "EI"        "344232321"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$HL2
#> [1] "HL" "2"  "1"  "22" "1" 
#> 
#> $`837I_EX1c_ppo_repriced_claim`$SBRP
#>  [1] "SBR"        "P"          NA           "46522567AW" NA          
#>  [6] NA           NA           NA           NA           "CI"        
#> 
#> $`837I_EX1c_ppo_repriced_claim`$NM1IL
#>  [1] "NM1"       "IL"        "1"         "JONES"     "JENNY"     NA         
#>  [7] NA          NA          "MI"        "345U8423H"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$`N34512 WEST AVENUE`
#> [1] "N3"               "4512 WEST AVENUE"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$N4EVANSVILLE
#> [1] "N4"         "EVANSVILLE" "AZ"         "863030000" 
#> 
#> $`837I_EX1c_ppo_repriced_claim`$DMGD8
#> [1] "DMG"      "D8"       "19690731" "F"       
#> 
#> $`837I_EX1c_ppo_repriced_claim`$NM1PR
#>  [1] "NM1"                     "PR"                     
#>  [3] "2"                       "LOCAL INSURANCE COMPANY"
#>  [5] NA                        NA                       
#>  [7] NA                        NA                       
#>  [9] "PI"                      "7452723"                
#> 
#> $`837I_EX1c_ppo_repriced_claim`$HL3
#> [1] "HL" "3"  "2"  "23" "0" 
#> 
#> $`837I_EX1c_ppo_repriced_claim`$PAT19
#> [1] "PAT" "19" 
#> 
#> $`837I_EX1c_ppo_repriced_claim`$NM1QC
#> [1] "NM1"   "QC"    "1"     "JONES" "JOY"  
#> 
#> $`837I_EX1c_ppo_repriced_claim`$`N34512 WEST AVENUE`
#> [1] "N3"               "4512 WEST AVENUE"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$N4EVANSVILLE
#> [1] "N4"         "EVANSVILLE" "AZ"         "863030000" 
#> 
#> $`837I_EX1c_ppo_repriced_claim`$DMGD8
#> [1] "DMG"      "D8"       "19980820" "F"       
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[26]]
#>  [1] "CLM"      "456DFH43" "237.5"    NA         NA         "13>A>1"  
#>  [7] NA         "A"        "Y"        "Y"       
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[27]]
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20050706-20050706"
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[28]]
#> [1] "DTP"          "435"          "DT"           "200507060800"
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[29]]
#> [1] "CL1" "1"   "2"   "01" 
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[30]]
#> [1] "AMT"   "F3"    "237.5"
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[31]]
#> [1] "REF"         "9A"          "09459034092"
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[32]]
#> [1] "REF"               "D9"                "04566877634343456"
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[33]]
#> [1] "HI"       "BK>38181"
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[34]]
#> [1] "HI"       "BF>38900"
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[35]]
#> [1] "HI"                "BH>11>D8>20050706"
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[36]]
#> [1] "HCP"       "03"        "182.88"    "54.62"     "123456789"
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[37]]
#>  [1] "NM1"        "71"         "1"          "JOHNSON"    "SIMON"     
#>  [6] NA           NA           NA           "XX"         "5544332211"
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[38]]
#>  [1] "SBR"                  "S"                    "19"                  
#>  [4] NA                     "T&T PLUMBING COMPANY" NA                    
#>  [7] NA                     NA                     NA                    
#> [10] "CI"                  
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[39]]
#> [1] "OI" NA   NA   "Y"  NA   NA   "Y" 
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[40]]
#>  [1] "NM1"      "IL"       "1"        "JONES"    "GEORGE"   NA        
#>  [7] NA         NA         "MI"       "56454566"
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[41]]
#>  [1] "NM1"                    "PR"                     "2"                     
#>  [4] "OTHER COVERAGE COMPANY" NA                       NA                      
#>  [7] NA                       NA                       "PI"                    
#> [10] "534524"                
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[42]]
#> [1] "LX" "1" 
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[43]]
#> [1] "SV2"      "0471"     "HC>92557" "178"      "UN"       "1"       
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[44]]
#> [1] "DTP"      "472"      "D8"       "20050706"
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[45]]
#> [1] "HCP"    "03"     "137.06" "40.94" 
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[46]]
#> [1] "LX" "2" 
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[47]]
#> [1] "SV2"      "0471"     "HC>92567" "59.5"     "UN"       "1"       
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[48]]
#> [1] "DTP"      "472"      "D8"       "20050706"
#> 
#> $`837I_EX1c_ppo_repriced_claim`[[49]]
#> [1] "HCP"   "03"    "45.82" "13.68"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$SE
#> [1] "SE"   "48"   "1002"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`837I_EX1c_ppo_repriced_claim`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`837I_EX1d_oon_repriced_claim`
#> $`837I_EX1d_oon_repriced_claim`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "231106"    "1415"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`837I_EX1d_oon_repriced_claim`$GS
#> [1] "GS"           "HC"           "SENDERGS"     "RECEIVERGS"   "20231106"    
#> [6] "141557"       "000000001"    "X"            "005010X223A2"
#> 
#> $`837I_EX1d_oon_repriced_claim`$ST
#> [1] "ST"           "837"          "1024"         "005010X223A2"
#> 
#> $`837I_EX1d_oon_repriced_claim`$BHT
#> [1] "BHT"      "0019"     "00"       "1024"     "20050711" "1335"     "CH"      
#> 
#> $`837I_EX1d_oon_repriced_claim`$NM141
#>  [1] "NM1"                  "41"                   "2"                   
#>  [4] "REGIONAL PPO NETWORK" NA                     NA                    
#>  [7] NA                     NA                     "46"                  
#> [10] "123456789"           
#> 
#> $`837I_EX1d_oon_repriced_claim`$PERIC
#> [1] "PER"                    "IC"                     "SUBMITTER CONTACT INFO"
#> [4] "TE"                     "8001231234"            
#> 
#> $`837I_EX1d_oon_repriced_claim`$NM140
#>  [1] "NM1"                    "40"                     "2"                     
#>  [4] "CONSERVATIVE INSURANCE" NA                       NA                      
#>  [7] NA                       NA                       "46"                    
#> [10] "000110002"             
#> 
#> $`837I_EX1d_oon_repriced_claim`$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $`837I_EX1d_oon_repriced_claim`$NM185
#>  [1] "NM1"            "85"             "2"              "LOCAL HOSPITAL"
#>  [5] NA               NA               NA               NA              
#>  [9] "XX"             "1122334455"    
#> 
#> $`837I_EX1d_oon_repriced_claim`$`N33423 SMALL STREET`
#> [1] "N3"                "3423 SMALL STREET"
#> 
#> $`837I_EX1d_oon_repriced_claim`$N4COLUMBUS
#> [1] "N4"        "COLUMBUS"  "OH"        "432150000"
#> 
#> $`837I_EX1d_oon_repriced_claim`$REFEI
#> [1] "REF"       "EI"        "111002222"
#> 
#> $`837I_EX1d_oon_repriced_claim`$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $`837I_EX1d_oon_repriced_claim`$SBRP
#>  [1] "SBR"    "P"      "18"     "34561W" NA       NA       NA       NA      
#>  [9] NA       "CI"    
#> 
#> $`837I_EX1d_oon_repriced_claim`$NM1IL
#>  [1] "NM1"       "IL"        "1"         "SMITH"     "JAMES"     "A"        
#>  [7] NA          NA          "MI"        "34902390F"
#> 
#> $`837I_EX1d_oon_repriced_claim`$`N3934 NORTH STREET`
#> [1] "N3"               "934 NORTH STREET"
#> 
#> $`837I_EX1d_oon_repriced_claim`$N4COLUMBUS
#> [1] "N4"        "COLUMBUS"  "OH"        "432150000"
#> 
#> $`837I_EX1d_oon_repriced_claim`$DMGD8
#> [1] "DMG"      "D8"       "19621015" "M"       
#> 
#> $`837I_EX1d_oon_repriced_claim`$NM1PR
#>  [1] "NM1"                    "PR"                     "2"                     
#>  [4] "CONSERVATIVE INSURANCE" NA                       NA                      
#>  [7] NA                       NA                       "PI"                    
#> [10] "0012"                  
#> 
#> $`837I_EX1d_oon_repriced_claim`[[20]]
#>  [1] "CLM"        "W392-49141" "14.84"      NA           NA          
#>  [6] "13>A>1"     NA           "A"          "Y"          "Y"         
#> 
#> $`837I_EX1d_oon_repriced_claim`[[21]]
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20050617-20050617"
#> 
#> $`837I_EX1d_oon_repriced_claim`[[22]]
#> [1] "DTP"          "435"          "DT"           "200506170800"
#> 
#> $`837I_EX1d_oon_repriced_claim`[[23]]
#> [1] "CL1" "1"   "1"   "01" 
#> 
#> $`837I_EX1d_oon_repriced_claim`[[24]]
#> [1] "AMT"   "F3"    "14.84"
#> 
#> $`837I_EX1d_oon_repriced_claim`[[25]]
#> [1] "REF"          "9A"           "459804390823"
#> 
#> $`837I_EX1d_oon_repriced_claim`[[26]]
#> [1] "REF"         "D9"          "32423466233"
#> 
#> $`837I_EX1d_oon_repriced_claim`[[27]]
#> [1] "HI"       "BK>53081"
#> 
#> $`837I_EX1d_oon_repriced_claim`[[28]]
#>  [1] "HCP"       "00"        "0"         NA          "333001234" NA         
#>  [7] NA          NA          NA          NA          NA          NA         
#> [13] NA          "T1"       
#> 
#> $`837I_EX1d_oon_repriced_claim`[[29]]
#>  [1] "NM1"        "71"         "1"          "RIVERS"     "DAWN"      
#>  [6] NA           NA           NA           "XX"         "2244224455"
#> 
#> $`837I_EX1d_oon_repriced_claim`[[30]]
#> [1] "LX" "1" 
#> 
#> $`837I_EX1d_oon_repriced_claim`[[31]]
#> [1] "SV2"      "0301"     "HC>82270" "14.84"    "UN"       "1"       
#> 
#> $`837I_EX1d_oon_repriced_claim`[[32]]
#> [1] "DTP"      "472"      "D8"       "20050617"
#> 
#> $`837I_EX1d_oon_repriced_claim`$SE
#> [1] "SE"   "31"   "1024"
#> 
#> $`837I_EX1d_oon_repriced_claim`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`837I_EX1d_oon_repriced_claim`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`837I_EX2_car_accident`
#> $`837I_EX2_car_accident`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "231106"    "1416"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`837I_EX2_car_accident`$GS
#> [1] "GS"           "HC"           "SENDERGS"     "RECEIVERGS"   "20231106"    
#> [6] "141625"       "000000001"    "X"            "005010X223A2"
#> 
#> $`837I_EX2_car_accident`$ST
#> [1] "ST"           "837"          "557766"       "005010X223A2"
#> 
#> $`837I_EX2_car_accident`$BHT
#> [1] "BHT"      "0019"     "00"       "0324"     "20051111" "1800"     "CH"      
#> 
#> $`837I_EX2_car_accident`$NM141
#>  [1] "NM1"                            "41"                            
#>  [3] "2"                              "HALL OF FAME MEMORIAL HOSPITAL"
#>  [5] NA                               NA                              
#>  [7] NA                               NA                              
#>  [9] "46"                             "737373737"                     
#> 
#> $`837I_EX2_car_accident`$PERIC
#> [1] "PER"        "IC"         "KATE CASEY" "TE"         "7152569877"
#> 
#> $`837I_EX2_car_accident`$NM140
#>  [1] "NM1"                       "40"                       
#>  [3] "2"                         "HEISMAN INSURANCE COMPANY"
#>  [5] NA                          NA                         
#>  [7] NA                          NA                         
#>  [9] "46"                        "999888777"                
#> 
#> $`837I_EX2_car_accident`$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $`837I_EX2_car_accident`$PRVBI
#> [1] "PRV"        "BI"         "PXC"        "203BA0200N"
#> 
#> $`837I_EX2_car_accident`$NM185
#>  [1] "NM1"                            "85"                            
#>  [3] "2"                              "HALL OF FAME MEMORIAL HOSPITAL"
#>  [5] NA                               NA                              
#>  [7] NA                               NA                              
#>  [9] "XX"                             "2365259638"                    
#> 
#> $`837I_EX2_car_accident`$`N31 CANTON ROAD`
#> [1] "N3"            "1 CANTON ROAD"
#> 
#> $`837I_EX2_car_accident`$`N4BROKEN FIELD`
#> [1] "N4"           "BROKEN FIELD" "CA"           "99998"       
#> 
#> $`837I_EX2_car_accident`$REFEI
#> [1] "REF"       "EI"        "737373737"
#> 
#> $`837I_EX2_car_accident`$HL2
#> [1] "HL" "2"  "1"  "22" "1" 
#> 
#> $`837I_EX2_car_accident`$SBRP
#>  [1] "SBR" "P"   NA    NA    NA    NA    NA    NA    NA    "AM" 
#> 
#> $`837I_EX2_car_accident`$NM1IL
#>  [1] "NM1"         "IL"          "1"           "HOWLING"     "HAL"        
#>  [6] NA            NA            NA            "MI"          "B999777791G"
#> 
#> $`837I_EX2_car_accident`$NM1PR
#>  [1] "NM1"                       "PR"                       
#>  [3] "2"                         "HEISMAN INSURANCE COMPANY"
#>  [5] NA                          NA                         
#>  [7] NA                          NA                         
#>  [9] "PI"                        "999888777"                
#> 
#> $`837I_EX2_car_accident`$HL3
#> [1] "HL" "3"  "2"  "23" "0" 
#> 
#> $`837I_EX2_car_accident`$PAT21
#> [1] "PAT" "21" 
#> 
#> $`837I_EX2_car_accident`$NM1QC
#> [1] "NM1"    "QC"     "1"      "MEXICO" "RON"   
#> 
#> $`837I_EX2_car_accident`$`N332 BUFFALO RUN`
#> [1] "N3"             "32 BUFFALO RUN"
#> 
#> $`837I_EX2_car_accident`$`N4ROCKING HORSE`
#> [1] "N4"            "ROCKING HORSE" "CA"            "99666"        
#> 
#> $`837I_EX2_car_accident`$DMGD8
#> [1] "DMG"      "D8"       "19480601" "M"       
#> 
#> $`837I_EX2_car_accident`$REFY4
#> [1] "REF"      "Y4"       "32323232"
#> 
#> $`837I_EX2_car_accident`[[25]]
#>  [1] "CLM"         "67236695521" "545"         NA            NA           
#>  [6] "13>A>1"      NA            "A"           "Y"           "Y"          
#> 
#> $`837I_EX2_car_accident`[[26]]
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20051031-20051101"
#> 
#> $`837I_EX2_car_accident`[[27]]
#> [1] "CL1" "3"   "7"   "1"  
#> 
#> $`837I_EX2_car_accident`[[28]]
#> [1] "REF" "LU"  "CA" 
#> 
#> $`837I_EX2_car_accident`[[29]]
#> [1] "HI"      "BK>8842"
#> 
#> $`837I_EX2_car_accident`[[30]]
#> [1] "HI"      "PR>8842"
#> 
#> $`837I_EX2_car_accident`[[31]]
#> [1] "HI"       "BN>E9750" "BN>E9860"
#> 
#> $`837I_EX2_car_accident`[[32]]
#>  [1] "NM1"        "71"         "1"          "LOMBARDO"   "VINCENT"   
#>  [6] NA           NA           NA           "XX"         "2533698543"
#> 
#> $`837I_EX2_car_accident`[[33]]
#> [1] "LX" "1" 
#> 
#> $`837I_EX2_car_accident`[[34]]
#> [1] "SV2"      "0450"     "HC>98765" "150"      "UN"       "1"       
#> 
#> $`837I_EX2_car_accident`[[35]]
#> [1] "DTP"      "472"      "D8"       "20051031"
#> 
#> $`837I_EX2_car_accident`[[36]]
#> [1] "LX" "2" 
#> 
#> $`837I_EX2_car_accident`[[37]]
#> [1] "SV2"      "0360"     "HC>26591" "75"       "UN"       "1"       
#> 
#> $`837I_EX2_car_accident`[[38]]
#> [1] "DTP"      "472"      "D8"       "20051031"
#> 
#> $`837I_EX2_car_accident`[[39]]
#> [1] "LX" "3" 
#> 
#> $`837I_EX2_car_accident`[[40]]
#> [1] "SV2"      "0312"     "HC>86225" "100"      "UN"       "2"       
#> 
#> $`837I_EX2_car_accident`[[41]]
#> [1] "DTP"      "472"      "D8"       "20051031"
#> 
#> $`837I_EX2_car_accident`[[42]]
#> [1] "LX" "4" 
#> 
#> $`837I_EX2_car_accident`[[43]]
#> [1] "SV2"      "0360"     "HC>99283" "220"      "UN"       "1"       
#> 
#> $`837I_EX2_car_accident`[[44]]
#> [1] "DTP"      "472"      "D8"       "20051031"
#> 
#> $`837I_EX2_car_accident`$SE
#> [1] "SE"     "43"     "557766"
#> 
#> $`837I_EX2_car_accident`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`837I_EX2_car_accident`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $ex_837_inpatient
#> [1] NA
#> 
#> $sample_837I
#> [1] NA
#> 
#> $sample_837_1
#> $sample_837_1$ISA
#>  [1] "ISA"             "00"              NA                "00"             
#>  [5] NA                "ZZ"              "589155000448185" "ZZ"             
#>  [9] "RegenceBluePoin" "241205"          "2042"            "U"              
#> [13] "00401"           "566609694"       "0"               "P"              
#> [17] ":"              
#> 
#> $sample_837_1$GS
#> [1] "GS"              "HC"              "589155000448185" "RegenceBluePoin"
#> [5] "20241205"        "2042"            "1"               "X"              
#> [9] "005010X223A2"   
#> 
#> $sample_837_1$ST
#> [1] "ST"           "837"          "0105"         "005010X223A2"
#> 
#> $sample_837_1$BHT
#> [1] "BHT"          "0019"         "00"           "241205204217" "20241205"    
#> [6] "2042"         "CH"          
#> 
#> $sample_837_1$NM141
#>  [1] "NM1"                        "41"                        
#>  [3] "2"                          "NATIONAL BIRTH CENTERS INC"
#>  [5] NA                           NA                          
#>  [7] NA                           NA                          
#>  [9] "XX"                         "1578387320"                
#> 
#> $sample_837_1$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_1$NM140
#>  [1] "NM1"                                                   
#>  [2] "40"                                                    
#>  [3] "2"                                                     
#>  [4] "RegenceBluePointGoldHSAwithSpinalManipulationVisionEAP"
#>  [5] NA                                                      
#>  [6] NA                                                      
#>  [7] NA                                                      
#>  [8] NA                                                      
#>  [9] "XX"                                                    
#> [10] "22013UT245"                                            
#> 
#> $sample_837_1$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_1$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $sample_837_1$NM185
#>  [1] "NM1"                        "85"                        
#>  [3] "2"                          "NATIONAL BIRTH CENTERS INC"
#>  [5] NA                           NA                          
#>  [7] NA                           NA                          
#>  [9] "XX"                         "1578387320"                
#> 
#> $sample_837_1$`N31141 N LOOP 1604 E # 105436`
#> [1] "N3"                          "1141 N LOOP 1604 E # 105436"
#> 
#> $sample_837_1$`N4SAN ANTONIO`
#> [1] "N4"          "SAN ANTONIO" "TX"          "78232"      
#> 
#> $sample_837_1$REFEI
#> [1] "REF"        "EI"         "46-4072679"
#> 
#> $sample_837_1$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_1$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $sample_837_1$SBRP
#>  [1] "SBR"       "P"         "18"        "068094280" NA          NA         
#>  [7] NA          NA          NA          "CI"       
#> 
#> $sample_837_1$NM1IL
#>  [1] "NM1"              "IL"               "1"                "TESTLAST01"      
#>  [5] "TESTFIRST01"      NA                 NA                 NA                
#>  [9] "MI"               "TESTMBR000000001"
#> 
#> $sample_837_1$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_1$N4TESTCITY
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_837_1[[20]]
#>  [1] "CLM"        "4742333269" "297"        NA           NA          
#>  [6] "11:B:1"     "Y"          "A"          "Y"          "I"         
#> 
#> $sample_837_1[[21]]
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20240422-20240430"
#> 
#> $sample_837_1[[22]]
#> [1] "DTP"      "435"      "D8"       "20240809"
#> 
#> $sample_837_1[[23]]
#> [1] "DTP"  "096"  "TM"   "2337"
#> 
#> $sample_837_1[[24]]
#> [1] "HI"          "ABK:S00459S"
#> 
#> $sample_837_1[[25]]
#> [1] "HI"          "ABK:T426X6A"
#> 
#> $sample_837_1[[26]]
#> [1] "HI"          "ABK:S35496D"
#> 
#> $sample_837_1[[27]]
#> [1] "HI"          "ABK:O368913"
#> 
#> $sample_837_1[[28]]
#> [1] "HI"          "ABK:T368X6A"
#> 
#> $sample_837_1[[29]]
#> [1] "HI"          "ABK:S36118D"
#> 
#> $sample_837_1[[30]]
#> [1] "HI"          "ABK:S46229A"
#> 
#> $sample_837_1[[31]]
#> [1] "LX" "1" 
#> 
#> $sample_837_1[[32]]
#>  [1] "SV1"      "HC:33222" "62"       "UN"       "1"        NA        
#>  [7] NA         "6:2:7:4"  NA         NA        
#> 
#> $sample_837_1[[33]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_1[[34]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_1[[35]]
#> [1] "LX" "2" 
#> 
#> $sample_837_1[[36]]
#>  [1] "SV1"      "HC:27005" "80"       "UN"       "1"        NA        
#>  [7] NA         "7:1"      NA         NA        
#> 
#> $sample_837_1[[37]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_1[[38]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_1[[39]]
#> [1] "LX" "3" 
#> 
#> $sample_837_1[[40]]
#>  [1] "SV1"      "HC:65860" "65"       "UN"       "1"        NA        
#>  [7] NA         "7"        NA         NA        
#> 
#> $sample_837_1[[41]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_1[[42]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_1[[43]]
#> [1] "LX" "4" 
#> 
#> $sample_837_1[[44]]
#>  [1] "SV1"      "HC:75891" "90"       "UN"       "1"        NA        
#>  [7] NA         "4"        NA         NA        
#> 
#> $sample_837_1[[45]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_1[[46]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_1$SE
#> [1] "SE"   "45"   "0105"
#> 
#> $sample_837_1$GE
#> [1] "GE" "1"  "1" 
#> 
#> $sample_837_1$IEA
#> [1] "IEA"       "1"         "566609694"
#> 
#> 
#> $sample_837_10
#> $sample_837_10$ISA
#>  [1] "ISA"             "00"              NA                "00"             
#>  [5] NA                "ZZ"              "765613337801994" "ZZ"             
#>  [9] "OptimaFourSight" "241205"          "2042"            "U"              
#> [13] "00401"           "351175143"       "0"               "P"              
#> [17] ":"              
#> 
#> $sample_837_10$GS
#> [1] "GS"              "HC"              "765613337801994" "OptimaFourSight"
#> [5] "20241205"        "2042"            "1"               "X"              
#> [9] "005010X223A2"   
#> 
#> $sample_837_10$ST
#> [1] "ST"           "837"          "5856"         "005010X223A2"
#> 
#> $sample_837_10$BHT
#> [1] "BHT"          "0019"         "00"           "241205204222" "20241205"    
#> [6] "2042"         "CH"          
#> 
#> $sample_837_10$NM141
#>  [1] "NM1"                  "41"                   "2"                   
#>  [4] "HSA PORT ARTHUR, LLC" NA                     NA                    
#>  [7] NA                     NA                     "XX"                  
#> [10] "1194548073"          
#> 
#> $sample_837_10$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_10$NM140
#>  [1] "NM1"             "40"              "2"               "OptimaFourSight"
#>  [5] NA                NA                NA                NA               
#>  [9] "XX"              "89242VA018"     
#> 
#> $sample_837_10$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_10$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $sample_837_10$NM185
#>  [1] "NM1"                  "85"                   "2"                   
#>  [4] "HSA PORT ARTHUR, LLC" NA                     NA                    
#>  [7] NA                     NA                     "XX"                  
#> [10] "1194548073"          
#> 
#> $sample_837_10$`N3505 N BRAND BLVD STE 1200`
#> [1] "N3"                        "505 N BRAND BLVD STE 1200"
#> 
#> $sample_837_10$N4GLENDALE
#> [1] "N4"       "GLENDALE" "CA"       "91203"   
#> 
#> $sample_837_10$REFEI
#> [1] "REF"        "EI"         "71-3391736"
#> 
#> $sample_837_10$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_10$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $sample_837_10$SBRP
#>  [1] "SBR"       "P"         "18"        "731323546" NA          NA         
#>  [7] NA          NA          NA          "CI"       
#> 
#> $sample_837_10$NM1IL
#>  [1] "NM1"              "IL"               "1"                "TESTLAST01"      
#>  [5] "TESTFIRST01"      NA                 NA                 NA                
#>  [9] "MI"               "TESTMBR000000001"
#> 
#> $sample_837_10$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_10$N4TESTCITY
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_837_10[[20]]
#>  [1] "CLM"        "4742333269" "128"        NA           NA          
#>  [6] "11:B:1"     "Y"          "A"          "Y"          "I"         
#> 
#> $sample_837_10[[21]]
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20240422-20240430"
#> 
#> $sample_837_10[[22]]
#> [1] "DTP"      "435"      "D8"       "20240809"
#> 
#> $sample_837_10[[23]]
#> [1] "DTP"  "096"  "TM"   "2337"
#> 
#> $sample_837_10[[24]]
#> [1] "HI"          "ABK:W214XXA"
#> 
#> $sample_837_10[[25]]
#> [1] "HI"          "ABK:S31813D"
#> 
#> $sample_837_10[[26]]
#> [1] "HI"          "ABK:V0492XD"
#> 
#> $sample_837_10[[27]]
#> [1] "HI"          "ABK:T498X6A"
#> 
#> $sample_837_10[[28]]
#> [1] "LX" "1" 
#> 
#> $sample_837_10[[29]]
#>  [1] "SV1"      "HC:37180" "93"       "UN"       "1"        NA        
#>  [7] NA         "3:4:1"    NA         NA        
#> 
#> $sample_837_10[[30]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_10[[31]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_10[[32]]
#> [1] "LX" "2" 
#> 
#> $sample_837_10[[33]]
#>  [1] "SV1"      "HC:24000" "4"        "UN"       "1"        NA        
#>  [7] NA         "1:3:4"    NA         NA        
#> 
#> $sample_837_10[[34]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_10[[35]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_10[[36]]
#> [1] "LX" "3" 
#> 
#> $sample_837_10[[37]]
#>  [1] "SV1"      "HC:16035" "31"       "UN"       "1"        NA        
#>  [7] NA         "3"        NA         NA        
#> 
#> $sample_837_10[[38]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_10[[39]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_10$SE
#> [1] "SE"   "38"   "5856"
#> 
#> $sample_837_10$GE
#> [1] "GE" "1"  "1" 
#> 
#> $sample_837_10$IEA
#> [1] "IEA"       "1"         "351175143"
#> 
#> 
#> $sample_837_2
#> $sample_837_2$ISA
#>  [1] "ISA"             "00"              NA                "00"             
#>  [5] NA                "ZZ"              "961285082616691" "ZZ"             
#>  [9] "AntidoteGoldSaf" "241205"          "2042"            "U"              
#> [13] "00401"           "030077084"       "0"               "P"              
#> [17] ":"              
#> 
#> $sample_837_2$GS
#> [1] "GS"              "HC"              "961285082616691" "AntidoteGoldSaf"
#> [5] "20241205"        "2042"            "1"               "X"              
#> [9] "005010X223A2"   
#> 
#> $sample_837_2$ST
#> [1] "ST"           "837"          "1462077"      "005010X223A2"
#> 
#> $sample_837_2$BHT
#> [1] "BHT"          "0019"         "00"           "241205204218" "20241205"    
#> [6] "2042"         "CH"          
#> 
#> $sample_837_2$NM141
#>  [1] "NM1"                   "41"                    "2"                    
#>  [4] "COMMUNITY BIRTH GROUP" NA                      NA                     
#>  [7] NA                      NA                      "XX"                   
#> [10] "1942024799"           
#> 
#> $sample_837_2$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_2$NM140
#>  [1] "NM1"                         "40"                         
#>  [3] "2"                           "AntidoteGoldSafeGuard0TopRx"
#>  [5] NA                            NA                           
#>  [7] NA                            NA                           
#>  [9] "XX"                          "68445DE003"                 
#> 
#> $sample_837_2$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_2$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $sample_837_2$NM185
#>  [1] "NM1"                   "85"                    "2"                    
#>  [4] "COMMUNITY BIRTH GROUP" NA                      NA                     
#>  [7] NA                      NA                      "XX"                   
#> [10] "1942024799"           
#> 
#> $sample_837_2$`N3216 TOWER RD`
#> [1] "N3"           "216 TOWER RD"
#> 
#> $sample_837_2$`N4SAN ANTONIO`
#> [1] "N4"          "SAN ANTONIO" "TX"          "78223"      
#> 
#> $sample_837_2$REFEI
#> [1] "REF"        "EI"         "98-2541777"
#> 
#> $sample_837_2$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_2$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $sample_837_2$SBRP
#>  [1] "SBR"       "P"         "18"        "404250129" NA          NA         
#>  [7] NA          NA          NA          "CI"       
#> 
#> $sample_837_2$NM1IL
#>  [1] "NM1"              "IL"               "1"                "TESTLAST01"      
#>  [5] "TESTFIRST01"      NA                 NA                 NA                
#>  [9] "MI"               "TESTMBR000000001"
#> 
#> $sample_837_2$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_2$N4TESTCITY
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_837_2[[20]]
#>  [1] "CLM"        "4742333269" "180"        NA           NA          
#>  [6] "11:B:1"     "Y"          "A"          "Y"          "I"         
#> 
#> $sample_837_2[[21]]
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20240422-20240430"
#> 
#> $sample_837_2[[22]]
#> [1] "DTP"      "435"      "D8"       "20240809"
#> 
#> $sample_837_2[[23]]
#> [1] "DTP"  "096"  "TM"   "2337"
#> 
#> $sample_837_2[[24]]
#> [1] "HI"          "ABK:S43396S"
#> 
#> $sample_837_2[[25]]
#> [1] "HI"          "ABK:S52263J"
#> 
#> $sample_837_2[[26]]
#> [1] "HI"          "ABK:V0009XD"
#> 
#> $sample_837_2[[27]]
#> [1] "LX" "1" 
#> 
#> $sample_837_2[[28]]
#>  [1] "SV1"      "HC:77522" "27"       "UN"       "1"        NA        
#>  [7] NA         "3:1"      NA         NA        
#> 
#> $sample_837_2[[29]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_2[[30]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_2[[31]]
#> [1] "LX" "2" 
#> 
#> $sample_837_2[[32]]
#>  [1] "SV1"      "HC:86304" "3"        "UN"       "1"        NA        
#>  [7] NA         "3:2"      NA         NA        
#> 
#> $sample_837_2[[33]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_2[[34]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_2[[35]]
#> [1] "LX" "3" 
#> 
#> $sample_837_2[[36]]
#>  [1] "SV1"      "HC:43848" "150"      "UN"       "1"        NA        
#>  [7] NA         "3"        NA         NA        
#> 
#> $sample_837_2[[37]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_2[[38]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_2$SE
#> [1] "SE"      "37"      "1462077"
#> 
#> $sample_837_2$GE
#> [1] "GE" "1"  "1" 
#> 
#> $sample_837_2$IEA
#> [1] "IEA"       "1"         "030077084"
#> 
#> 
#> $sample_837_3
#> $sample_837_3$ISA
#>  [1] "ISA"             "00"              NA                "00"             
#>  [5] NA                "ZZ"              "657631015478465" "ZZ"             
#>  [9] "MOLINAHEALTHCAR" "241205"          "2042"            "U"              
#> [13] "00401"           "828442319"       "0"               "P"              
#> [17] ":"              
#> 
#> $sample_837_3$GS
#> [1] "GS"              "HC"              "657631015478465" "MOLINAHEALTHCAR"
#> [5] "20241205"        "2042"            "1"               "X"              
#> [9] "005010X223A2"   
#> 
#> $sample_837_3$ST
#> [1] "ST"           "837"          "93687"        "005010X223A2"
#> 
#> $sample_837_3$BHT
#> [1] "BHT"          "0019"         "00"           "241205204218" "20241205"    
#> [6] "2042"         "CH"          
#> 
#> $sample_837_3$NM141
#>  [1] "NM1"                   "41"                    "2"                    
#>  [4] "MARYVIEW HOSPITAL LLC" NA                      NA                     
#>  [7] NA                      NA                      "XX"                   
#> [10] "1316313414"           
#> 
#> $sample_837_3$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_3$NM140
#>  [1] "NM1"              "40"               "2"                "MOLINAHEALTHCARE"
#>  [5] NA                 NA                 NA                 NA                
#>  [9] "XX"               "64353OH001"      
#> 
#> $sample_837_3$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_3$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $sample_837_3$NM185
#>  [1] "NM1"                   "85"                    "2"                    
#>  [4] "MARYVIEW HOSPITAL LLC" NA                      NA                     
#>  [7] NA                      NA                      "XX"                   
#> [10] "1316313414"           
#> 
#> $sample_837_3$`N38580 MAGELLAN PKWY`
#> [1] "N3"                 "8580 MAGELLAN PKWY"
#> 
#> $sample_837_3$N4RICHMOND
#> [1] "N4"       "RICHMOND" "VA"       "23227"   
#> 
#> $sample_837_3$REFEI
#> [1] "REF"        "EI"         "40-3601447"
#> 
#> $sample_837_3$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_3$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $sample_837_3$SBRP
#>  [1] "SBR"       "P"         "18"        "520458393" NA          NA         
#>  [7] NA          NA          NA          "CI"       
#> 
#> $sample_837_3$NM1IL
#>  [1] "NM1"              "IL"               "1"                "TESTLAST01"      
#>  [5] "TESTFIRST01"      NA                 NA                 NA                
#>  [9] "MI"               "TESTMBR000000001"
#> 
#> $sample_837_3$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_3$N4TESTCITY
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_837_3[[20]]
#>  [1] "CLM"        "4742333269" "626"        NA           NA          
#>  [6] "11:B:1"     "Y"          "A"          "Y"          "I"         
#> 
#> $sample_837_3[[21]]
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20240422-20240430"
#> 
#> $sample_837_3[[22]]
#> [1] "DTP"      "435"      "D8"       "20240809"
#> 
#> $sample_837_3[[23]]
#> [1] "DTP"  "096"  "TM"   "2337"
#> 
#> $sample_837_3[[24]]
#> [1] "HI"          "ABK:S25412A"
#> 
#> $sample_837_3[[25]]
#> [1] "HI"          "ABK:S55209S"
#> 
#> $sample_837_3[[26]]
#> [1] "HI"         "ABK:H05033"
#> 
#> $sample_837_3[[27]]
#> [1] "HI"         "ABK:M61529"
#> 
#> $sample_837_3[[28]]
#> [1] "HI"          "ABK:S12500S"
#> 
#> $sample_837_3[[29]]
#> [1] "HI"          "ABK:S62661G"
#> 
#> $sample_837_3[[30]]
#> [1] "LX" "1" 
#> 
#> $sample_837_3[[31]]
#>  [1] "SV1"      "HC:32662" "83"       "UN"       "1"        NA        
#>  [7] NA         "1:3:2:5"  NA         NA        
#> 
#> $sample_837_3[[32]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_3[[33]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_3[[34]]
#> [1] "LX" "2" 
#> 
#> $sample_837_3[[35]]
#>  [1] "SV1"      "HC:42509" "543"      "UN"       "1"        NA        
#>  [7] NA         "6"        NA         NA        
#> 
#> $sample_837_3[[36]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_3[[37]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_3$SE
#> [1] "SE"    "36"    "93687"
#> 
#> $sample_837_3$GE
#> [1] "GE" "1"  "1" 
#> 
#> $sample_837_3$IEA
#> [1] "IEA"       "1"         "828442319"
#> 
#> 
#> $sample_837_4
#> $sample_837_4$ISA
#>  [1] "ISA"             "00"              NA                "00"             
#>  [5] NA                "ZZ"              "816055286149740" "ZZ"             
#>  [9] "HighDeductibleH" "241205"          "2042"            "U"              
#> [13] "00401"           "621402678"       "0"               "P"              
#> [17] ":"              
#> 
#> $sample_837_4$GS
#> [1] "GS"              "HC"              "816055286149740" "HighDeductibleH"
#> [5] "20241205"        "2042"            "1"               "X"              
#> [9] "005010X223A2"   
#> 
#> $sample_837_4$ST
#> [1] "ST"           "837"          "91529"        "005010X223A2"
#> 
#> $sample_837_4$BHT
#> [1] "BHT"          "0019"         "00"           "241205204219" "20241205"    
#> [6] "2042"         "CH"          
#> 
#> $sample_837_4$NM141
#>  [1] "NM1"                 "41"                  "2"                  
#>  [4] "HSA ST. JOSEPH, LLC" NA                    NA                   
#>  [7] NA                    NA                    "XX"                 
#> [10] "1639992514"         
#> 
#> $sample_837_4$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_4$NM140
#>  [1] "NM1"                           "40"                           
#>  [3] "2"                             "HighDeductibleHealthPlanHSA30"
#>  [5] NA                              NA                             
#>  [7] NA                              NA                             
#>  [9] "XX"                            "44197WI008"                   
#> 
#> $sample_837_4$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_4$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $sample_837_4$NM185
#>  [1] "NM1"                 "85"                  "2"                  
#>  [4] "HSA ST. JOSEPH, LLC" NA                    NA                   
#>  [7] NA                    NA                    "XX"                 
#> [10] "1639992514"         
#> 
#> $sample_837_4$`N3505 N BRAND BLVD STE 1200`
#> [1] "N3"                        "505 N BRAND BLVD STE 1200"
#> 
#> $sample_837_4$N4GLENDALE
#> [1] "N4"       "GLENDALE" "CA"       "91203"   
#> 
#> $sample_837_4$REFEI
#> [1] "REF"        "EI"         "38-4035437"
#> 
#> $sample_837_4$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_4$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $sample_837_4$SBRP
#>  [1] "SBR"       "P"         "18"        "812162750" NA          NA         
#>  [7] NA          NA          NA          "CI"       
#> 
#> $sample_837_4$NM1IL
#>  [1] "NM1"              "IL"               "1"                "TESTLAST01"      
#>  [5] "TESTFIRST01"      NA                 NA                 NA                
#>  [9] "MI"               "TESTMBR000000001"
#> 
#> $sample_837_4$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_4$N4TESTCITY
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_837_4[[20]]
#>  [1] "CLM"        "4742333269" "836"        NA           NA          
#>  [6] "11:B:1"     "Y"          "A"          "Y"          "I"         
#> 
#> $sample_837_4[[21]]
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20240422-20240430"
#> 
#> $sample_837_4[[22]]
#> [1] "DTP"      "435"      "D8"       "20240809"
#> 
#> $sample_837_4[[23]]
#> [1] "DTP"  "096"  "TM"   "2337"
#> 
#> $sample_837_4[[24]]
#> [1] "HI"          "ABK:S42453G"
#> 
#> $sample_837_4[[25]]
#> [1] "HI"         "ABK:M25775"
#> 
#> $sample_837_4[[26]]
#> [1] "HI"          "ABK:S32421K"
#> 
#> $sample_837_4[[27]]
#> [1] "HI"          "ABK:V275XXD"
#> 
#> $sample_837_4[[28]]
#> [1] "HI"          "ABK:X130XXS"
#> 
#> $sample_837_4[[29]]
#> [1] "HI"          "ABK:T1512XD"
#> 
#> $sample_837_4[[30]]
#> [1] "HI"         "ABK:M70859"
#> 
#> $sample_837_4[[31]]
#> [1] "HI"          "ABK:S82454S"
#> 
#> $sample_837_4[[32]]
#> [1] "LX" "1" 
#> 
#> $sample_837_4[[33]]
#>  [1] "SV1"      "HC:64823" "836"      "UN"       "1"        NA        
#>  [7] NA         "6:3"      NA         NA        
#> 
#> $sample_837_4[[34]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_4[[35]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_4$SE
#> [1] "SE"    "34"    "91529"
#> 
#> $sample_837_4$GE
#> [1] "GE" "1"  "1" 
#> 
#> $sample_837_4$IEA
#> [1] "IEA"       "1"         "621402678"
#> 
#> 
#> $sample_837_5
#> $sample_837_5$ISA
#>  [1] "ISA"             "00"              NA                "00"             
#>  [5] NA                "ZZ"              "051153619573476" "ZZ"             
#>  [9] "BlanketStudentA" "241205"          "2042"            "U"              
#> [13] "00401"           "518159636"       "0"               "P"              
#> [17] ":"              
#> 
#> $sample_837_5$GS
#> [1] "GS"              "HC"              "051153619573476" "BlanketStudentA"
#> [5] "20241205"        "2042"            "1"               "X"              
#> [9] "005010X223A2"   
#> 
#> $sample_837_5$ST
#> [1] "ST"           "837"          "46086"        "005010X223A2"
#> 
#> $sample_837_5$BHT
#> [1] "BHT"          "0019"         "00"           "241205204219" "20241205"    
#> [6] "2042"         "CH"          
#> 
#> $sample_837_5$NM141
#>  [1] "NM1"                        "41"                        
#>  [3] "2"                          "NATIONAL BIRTH CENTERS INC"
#>  [5] NA                           NA                          
#>  [7] NA                           NA                          
#>  [9] "XX"                         "1578387320"                
#> 
#> $sample_837_5$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_5$NM140
#>  [1] "NM1"                                           
#>  [2] "40"                                            
#>  [3] "2"                                             
#>  [4] "BlanketStudentAccidentandSicknessUnivofWYPlan1"
#>  [5] NA                                              
#>  [6] NA                                              
#>  [7] NA                                              
#>  [8] NA                                              
#>  [9] "XX"                                            
#> [10] "49714WY010"                                    
#> 
#> $sample_837_5$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_5$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $sample_837_5$NM185
#>  [1] "NM1"                        "85"                        
#>  [3] "2"                          "NATIONAL BIRTH CENTERS INC"
#>  [5] NA                           NA                          
#>  [7] NA                           NA                          
#>  [9] "XX"                         "1578387320"                
#> 
#> $sample_837_5$`N31141 N LOOP 1604 E # 105436`
#> [1] "N3"                          "1141 N LOOP 1604 E # 105436"
#> 
#> $sample_837_5$`N4SAN ANTONIO`
#> [1] "N4"          "SAN ANTONIO" "TX"          "78232"      
#> 
#> $sample_837_5$REFEI
#> [1] "REF"        "EI"         "58-1127151"
#> 
#> $sample_837_5$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_5$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $sample_837_5$SBRP
#>  [1] "SBR"       "P"         "18"        "518691181" NA          NA         
#>  [7] NA          NA          NA          "CI"       
#> 
#> $sample_837_5$NM1IL
#>  [1] "NM1"              "IL"               "1"                "TESTLAST01"      
#>  [5] "TESTFIRST01"      NA                 NA                 NA                
#>  [9] "MI"               "TESTMBR000000001"
#> 
#> $sample_837_5$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_5$N4TESTCITY
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_837_5[[20]]
#>  [1] "CLM"        "4742333269" "157"        NA           NA          
#>  [6] "11:B:1"     "Y"          "A"          "Y"          "I"         
#> 
#> $sample_837_5[[21]]
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20240422-20240430"
#> 
#> $sample_837_5[[22]]
#> [1] "DTP"      "435"      "D8"       "20240809"
#> 
#> $sample_837_5[[23]]
#> [1] "DTP"  "096"  "TM"   "2337"
#> 
#> $sample_837_5[[24]]
#> [1] "HI"          "ABK:S89219K"
#> 
#> $sample_837_5[[25]]
#> [1] "HI"          "ABK:S50349S"
#> 
#> $sample_837_5[[26]]
#> [1] "HI"          "ABK:S81052D"
#> 
#> $sample_837_5[[27]]
#> [1] "HI"       "ABK:D434"
#> 
#> $sample_837_5[[28]]
#> [1] "HI"          "ABK:S00451A"
#> 
#> $sample_837_5[[29]]
#> [1] "HI"          "ABK:T81505D"
#> 
#> $sample_837_5[[30]]
#> [1] "LX" "1" 
#> 
#> $sample_837_5[[31]]
#>  [1] "SV1"      "HC:0029T" "97"       "UN"       "1"        NA        
#>  [7] NA         "1:3:6"    NA         NA        
#> 
#> $sample_837_5[[32]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_5[[33]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_5[[34]]
#> [1] "LX" "2" 
#> 
#> $sample_837_5[[35]]
#>  [1] "SV1"       "HC:86490"  "6"         "UN"        "1"         NA         
#>  [7] NA          "3:4:6:1:5" NA          NA         
#> 
#> $sample_837_5[[36]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_5[[37]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_5[[38]]
#> [1] "LX" "3" 
#> 
#> $sample_837_5[[39]]
#>  [1] "SV1"      "HC:57545" "21"       "UN"       "1"        NA        
#>  [7] NA         "2:3"      NA         NA        
#> 
#> $sample_837_5[[40]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_5[[41]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_5[[42]]
#> [1] "LX" "4" 
#> 
#> $sample_837_5[[43]]
#>  [1] "SV1"      "HC:62258" "33"       "UN"       "1"        NA        
#>  [7] NA         "6"        NA         NA        
#> 
#> $sample_837_5[[44]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_5[[45]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_5$SE
#> [1] "SE"    "44"    "46086"
#> 
#> $sample_837_5$GE
#> [1] "GE" "1"  "1" 
#> 
#> $sample_837_5$IEA
#> [1] "IEA"       "1"         "518159636"
#> 
#> 
#> $sample_837_6
#> $sample_837_6$ISA
#>  [1] "ISA"             "00"              NA                "00"             
#>  [5] NA                "ZZ"              "336342583485277" "ZZ"             
#>  [9] "EHB2015IPLAELIC" "241205"          "2042"            "U"              
#> [13] "00401"           "115983591"       "0"               "P"              
#> [17] ":"              
#> 
#> $sample_837_6$GS
#> [1] "GS"              "HC"              "336342583485277" "EHB2015IPLAELIC"
#> [5] "20241205"        "2042"            "1"               "X"              
#> [9] "005010X223A2"   
#> 
#> $sample_837_6$ST
#> [1] "ST"           "837"          "76134698"     "005010X223A2"
#> 
#> $sample_837_6$BHT
#> [1] "BHT"          "0019"         "00"           "241205204220" "20241205"    
#> [6] "2042"         "CH"          
#> 
#> $sample_837_6$NM141
#>  [1] "NM1"                       "41"                       
#>  [3] "2"                         "OKEECHOBEE HOSPITAL, INC."
#>  [5] NA                          NA                         
#>  [7] NA                          NA                         
#>  [9] "XX"                        "1215974134"               
#> 
#> $sample_837_6$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_6$NM140
#>  [1] "NM1"             "40"              "2"               "EHB2015IPLAELIC"
#>  [5] NA                NA                NA                NA               
#>  [9] "XX"              "85570LA014"     
#> 
#> $sample_837_6$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_6$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $sample_837_6$NM185
#>  [1] "NM1"                       "85"                       
#>  [3] "2"                         "OKEECHOBEE HOSPITAL, INC."
#>  [5] NA                          NA                         
#>  [7] NA                          NA                         
#>  [9] "XX"                        "1215974134"               
#> 
#> $sample_837_6$`N3PO BOX 1307`
#> [1] "N3"          "PO BOX 1307"
#> 
#> $sample_837_6$N4OKEECHOBEE
#> [1] "N4"         "OKEECHOBEE" "FL"         "34973"     
#> 
#> $sample_837_6$REFEI
#> [1] "REF"        "EI"         "47-2705172"
#> 
#> $sample_837_6$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_6$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $sample_837_6$SBRP
#>  [1] "SBR"       "P"         "18"        "768417323" NA          NA         
#>  [7] NA          NA          NA          "CI"       
#> 
#> $sample_837_6$NM1IL
#>  [1] "NM1"              "IL"               "1"                "TESTLAST01"      
#>  [5] "TESTFIRST01"      NA                 NA                 NA                
#>  [9] "MI"               "TESTMBR000000001"
#> 
#> $sample_837_6$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_6$N4TESTCITY
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_837_6[[20]]
#>  [1] "CLM"        "4742333269" "766"        NA           NA          
#>  [6] "11:B:1"     "Y"          "A"          "Y"          "I"         
#> 
#> $sample_837_6[[21]]
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20240422-20240430"
#> 
#> $sample_837_6[[22]]
#> [1] "DTP"      "435"      "D8"       "20240809"
#> 
#> $sample_837_6[[23]]
#> [1] "DTP"  "096"  "TM"   "2337"
#> 
#> $sample_837_6[[24]]
#> [1] "HI"       "ABK:F551"
#> 
#> $sample_837_6[[25]]
#> [1] "HI"          "ABK:S43201D"
#> 
#> $sample_837_6[[26]]
#> [1] "HI"          "ABK:T6194XA"
#> 
#> $sample_837_6[[27]]
#> [1] "HI"          "ABK:S92505K"
#> 
#> $sample_837_6[[28]]
#> [1] "HI"          "ABK:T280XXS"
#> 
#> $sample_837_6[[29]]
#> [1] "HI"          "ABK:S71011D"
#> 
#> $sample_837_6[[30]]
#> [1] "LX" "1" 
#> 
#> $sample_837_6[[31]]
#>  [1] "SV1"         "HC:27606"    "61"          "UN"          "1"          
#>  [6] NA            NA            "5:1:4:3:6:2" NA            NA           
#> 
#> $sample_837_6[[32]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_6[[33]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_6[[34]]
#> [1] "LX" "2" 
#> 
#> $sample_837_6[[35]]
#>  [1] "SV1"      "HC:44960" "371"      "UN"       "1"        NA        
#>  [7] NA         "6"        NA         NA        
#> 
#> $sample_837_6[[36]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_6[[37]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_6[[38]]
#> [1] "LX" "3" 
#> 
#> $sample_837_6[[39]]
#>  [1] "SV1"      "HC:90680" "34"       "UN"       "1"        NA        
#>  [7] NA         "3"        NA         NA        
#> 
#> $sample_837_6[[40]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_6[[41]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_6[[42]]
#> [1] "LX" "4" 
#> 
#> $sample_837_6[[43]]
#>  [1] "SV1"      "HC:92551" "267"      "UN"       "1"        NA        
#>  [7] NA         "3"        NA         NA        
#> 
#> $sample_837_6[[44]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_6[[45]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_6[[46]]
#> [1] "LX" "5" 
#> 
#> $sample_837_6[[47]]
#>  [1] "SV1"      "HC:31237" "33"       "UN"       "1"        NA        
#>  [7] NA         "4:1"      NA         NA        
#> 
#> $sample_837_6[[48]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_6[[49]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_6$SE
#> [1] "SE"       "48"       "76134698"
#> 
#> $sample_837_6$GE
#> [1] "GE" "1"  "1" 
#> 
#> $sample_837_6$IEA
#> [1] "IEA"       "1"         "115983591"
#> 
#> 
#> $sample_837_7
#> $sample_837_7$ISA
#>  [1] "ISA"             "00"              NA                "00"             
#>  [5] NA                "ZZ"              "879679616399691" "ZZ"             
#>  [9] "HSA2000_10A1189" "241205"          "2042"            "U"              
#> [13] "00401"           "871936722"       "0"               "P"              
#> [17] ":"              
#> 
#> $sample_837_7$GS
#> [1] "GS"              "HC"              "879679616399691" "HSA2000_10A1189"
#> [5] "20241205"        "2042"            "1"               "X"              
#> [9] "005010X223A2"   
#> 
#> $sample_837_7$ST
#> [1] "ST"           "837"          "7869171"      "005010X223A2"
#> 
#> $sample_837_7$BHT
#> [1] "BHT"          "0019"         "00"           "241205204220" "20241205"    
#> [6] "2042"         "CH"          
#> 
#> $sample_837_7$NM141
#>  [1] "NM1"                        "41"                        
#>  [3] "2"                          "ELMHURST MEMORIAL HOSPITAL"
#>  [5] NA                           NA                          
#>  [7] NA                           NA                          
#>  [9] "XX"                         "1548306343"                
#> 
#> $sample_837_7$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_7$NM140
#>  [1] "NM1"          "40"           "2"            "HSA2000_10A1" NA            
#>  [6] NA             NA             NA             "XX"           "39424OR071"  
#> 
#> $sample_837_7$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_7$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $sample_837_7$NM185
#>  [1] "NM1"                        "85"                        
#>  [3] "2"                          "ELMHURST MEMORIAL HOSPITAL"
#>  [5] NA                           NA                          
#>  [7] NA                           NA                          
#>  [9] "XX"                         "1548306343"                
#> 
#> $sample_837_7$`N3155 E BRUSH HILL RD`
#> [1] "N3"                  "155 E BRUSH HILL RD"
#> 
#> $sample_837_7$N4ELMHURST
#> [1] "N4"       "ELMHURST" "IL"       "60126"   
#> 
#> $sample_837_7$REFEI
#> [1] "REF"        "EI"         "78-1631771"
#> 
#> $sample_837_7$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_7$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $sample_837_7$SBRP
#>  [1] "SBR"       "P"         "18"        "270183084" NA          NA         
#>  [7] NA          NA          NA          "CI"       
#> 
#> $sample_837_7$NM1IL
#>  [1] "NM1"              "IL"               "1"                "TESTLAST01"      
#>  [5] "TESTFIRST01"      NA                 NA                 NA                
#>  [9] "MI"               "TESTMBR000000001"
#> 
#> $sample_837_7$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_7$N4TESTCITY
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_837_7[[20]]
#>  [1] "CLM"        "4742333269" "349"        NA           NA          
#>  [6] "11:B:1"     "Y"          "A"          "Y"          "I"         
#> 
#> $sample_837_7[[21]]
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20240422-20240430"
#> 
#> $sample_837_7[[22]]
#> [1] "DTP"      "435"      "D8"       "20240809"
#> 
#> $sample_837_7[[23]]
#> [1] "DTP"  "096"  "TM"   "2337"
#> 
#> $sample_837_7[[24]]
#> [1] "HI"          "ABK:S00249D"
#> 
#> $sample_837_7[[25]]
#> [1] "HI"          "ABK:S99131K"
#> 
#> $sample_837_7[[26]]
#> [1] "HI"          "ABK:S32425K"
#> 
#> $sample_837_7[[27]]
#> [1] "HI"          "ABK:S52501J"
#> 
#> $sample_837_7[[28]]
#> [1] "HI"          "ABK:S72114P"
#> 
#> $sample_837_7[[29]]
#> [1] "LX" "1" 
#> 
#> $sample_837_7[[30]]
#>  [1] "SV1"       "HC:38724"  "36"        "UN"        "1"         NA         
#>  [7] NA          "1:3:5:2:4" NA          NA         
#> 
#> $sample_837_7[[31]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_7[[32]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_7[[33]]
#> [1] "LX" "2" 
#> 
#> $sample_837_7[[34]]
#>  [1] "SV1"      "HC:86701" "213"      "UN"       "1"        NA        
#>  [7] NA         "5:4"      NA         NA        
#> 
#> $sample_837_7[[35]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_7[[36]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_7[[37]]
#> [1] "LX" "3" 
#> 
#> $sample_837_7[[38]]
#>  [1] "SV1"      "HC:92325" "70"       "UN"       "1"        NA        
#>  [7] NA         "3:2:4"    NA         NA        
#> 
#> $sample_837_7[[39]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_7[[40]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_7[[41]]
#> [1] "LX" "4" 
#> 
#> $sample_837_7[[42]]
#>  [1] "SV1"      "HC:89060" "30"       "UN"       "1"        NA        
#>  [7] NA         "3:4:5"    NA         NA        
#> 
#> $sample_837_7[[43]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_7[[44]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_7$SE
#> [1] "SE"      "43"      "7869171"
#> 
#> $sample_837_7$GE
#> [1] "GE" "1"  "1" 
#> 
#> $sample_837_7$IEA
#> [1] "IEA"       "1"         "871936722"
#> 
#> 
#> $sample_837_8
#> $sample_837_8$ISA
#>  [1] "ISA"             "00"              NA                "00"             
#>  [5] NA                "ZZ"              "719189088449132" "ZZ"             
#>  [9] "SimplyBluePPOwi" "241205"          "2042"            "U"              
#> [13] "00401"           "464860572"       "0"               "P"              
#> [17] ":"              
#> 
#> $sample_837_8$GS
#> [1] "GS"              "HC"              "719189088449132" "SimplyBluePPOwi"
#> [5] "20241205"        "2042"            "1"               "X"              
#> [9] "005010X223A2"   
#> 
#> $sample_837_8$ST
#> [1] "ST"           "837"          "57975326"     "005010X223A2"
#> 
#> $sample_837_8$BHT
#> [1] "BHT"          "0019"         "00"           "241205204221" "20241205"    
#> [6] "2042"         "CH"          
#> 
#> $sample_837_8$NM141
#>  [1] "NM1"                             "41"                             
#>  [3] "2"                               "GUTHRIE CORTLAND MEDICAL CENTER"
#>  [5] NA                                NA                               
#>  [7] NA                                NA                               
#>  [9] "XX"                              "1740287531"                     
#> 
#> $sample_837_8$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_8$NM140
#>  [1] "NM1"                               "40"                               
#>  [3] "2"                                 "SimplyBluePPOwithabortioncoverage"
#>  [5] NA                                  NA                                 
#>  [7] NA                                  NA                                 
#>  [9] "XX"                                "15560MI055"                       
#> 
#> $sample_837_8$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_8$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $sample_837_8$NM185
#>  [1] "NM1"                             "85"                             
#>  [3] "2"                               "GUTHRIE CORTLAND MEDICAL CENTER"
#>  [5] NA                                NA                               
#>  [7] NA                                NA                               
#>  [9] "XX"                              "1740287531"                     
#> 
#> $sample_837_8$`N3PO BOX 2060`
#> [1] "N3"          "PO BOX 2060"
#> 
#> $sample_837_8$N4CORTLAND
#> [1] "N4"       "CORTLAND" "NY"       "13045"   
#> 
#> $sample_837_8$REFEI
#> [1] "REF"        "EI"         "92-6992381"
#> 
#> $sample_837_8$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_8$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $sample_837_8$SBRP
#>  [1] "SBR"       "P"         "18"        "406068712" NA          NA         
#>  [7] NA          NA          NA          "CI"       
#> 
#> $sample_837_8$NM1IL
#>  [1] "NM1"              "IL"               "1"                "TESTLAST01"      
#>  [5] "TESTFIRST01"      NA                 NA                 NA                
#>  [9] "MI"               "TESTMBR000000001"
#> 
#> $sample_837_8$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_8$N4TESTCITY
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_837_8[[20]]
#>  [1] "CLM"        "4742333269" "434"        NA           NA          
#>  [6] "11:B:1"     "Y"          "A"          "Y"          "I"         
#> 
#> $sample_837_8[[21]]
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20240422-20240430"
#> 
#> $sample_837_8[[22]]
#> [1] "DTP"      "435"      "D8"       "20240809"
#> 
#> $sample_837_8[[23]]
#> [1] "DTP"  "096"  "TM"   "2337"
#> 
#> $sample_837_8[[24]]
#> [1] "HI"          "ABK:S62511K"
#> 
#> $sample_837_8[[25]]
#> [1] "HI"          "ABK:T578X3S"
#> 
#> $sample_837_8[[26]]
#> [1] "HI"          "ABK:S72342G"
#> 
#> $sample_837_8[[27]]
#> [1] "LX" "1" 
#> 
#> $sample_837_8[[28]]
#>  [1] "SV1"      "HC:43280" "41"       "UN"       "1"        NA        
#>  [7] NA         "1:2"      NA         NA        
#> 
#> $sample_837_8[[29]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_8[[30]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_8[[31]]
#> [1] "LX" "2" 
#> 
#> $sample_837_8[[32]]
#>  [1] "SV1"      "HC:46250" "35"       "UN"       "1"        NA        
#>  [7] NA         "2:3"      NA         NA        
#> 
#> $sample_837_8[[33]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_8[[34]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_8[[35]]
#> [1] "LX" "3" 
#> 
#> $sample_837_8[[36]]
#>  [1] "SV1"      "HC:33305" "197"      "UN"       "1"        NA        
#>  [7] NA         "3:2"      NA         NA        
#> 
#> $sample_837_8[[37]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_8[[38]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_8[[39]]
#> [1] "LX" "4" 
#> 
#> $sample_837_8[[40]]
#>  [1] "SV1"      "HC:90947" "161"      "UN"       "1"        NA        
#>  [7] NA         "1:3:2"    NA         NA        
#> 
#> $sample_837_8[[41]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_8[[42]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_8$SE
#> [1] "SE"       "41"       "57975326"
#> 
#> $sample_837_8$GE
#> [1] "GE" "1"  "1" 
#> 
#> $sample_837_8$IEA
#> [1] "IEA"       "1"         "464860572"
#> 
#> 
#> $sample_837_9
#> $sample_837_9$ISA
#>  [1] "ISA"             "00"              NA                "00"             
#>  [5] NA                "ZZ"              "913673479406110" "ZZ"             
#>  [9] "HMOOffExchangeR" "241205"          "2042"            "U"              
#> [13] "00401"           "253034665"       "0"               "P"              
#> [17] ":"              
#> 
#> $sample_837_9$GS
#> [1] "GS"              "HC"              "913673479406110" "HMOOffExchangeR"
#> [5] "20241205"        "2042"            "1"               "X"              
#> [9] "005010X223A2"   
#> 
#> $sample_837_9$ST
#> [1] "ST"           "837"          "4763033"      "005010X223A2"
#> 
#> $sample_837_9$BHT
#> [1] "BHT"          "0019"         "00"           "241205204221" "20241205"    
#> [6] "2042"         "CH"          
#> 
#> $sample_837_9$NM141
#>  [1] "NM1"                                   
#>  [2] "41"                                    
#>  [3] "2"                                     
#>  [4] "HCA HEALTH SERVICES OF TENNESSEE, INC."
#>  [5] NA                                      
#>  [6] NA                                      
#>  [7] NA                                      
#>  [8] NA                                      
#>  [9] "XX"                                    
#> [10] "1265487193"                            
#> 
#> $sample_837_9$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_9$NM140
#>  [1] "NM1"                   "40"                    "2"                    
#>  [4] "HMOOffExchangeRegion7" NA                      NA                     
#>  [7] NA                      NA                      "XX"                   
#> [10] "84014CA002"           
#> 
#> $sample_837_9$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_9$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $sample_837_9$NM185
#>  [1] "NM1"                                   
#>  [2] "85"                                    
#>  [3] "2"                                     
#>  [4] "HCA HEALTH SERVICES OF TENNESSEE, INC."
#>  [5] NA                                      
#>  [6] NA                                      
#>  [7] NA                                      
#>  [8] NA                                      
#>  [9] "XX"                                    
#> [10] "1265487193"                            
#> 
#> $sample_837_9$`N3313 N MAIN ST`
#> [1] "N3"            "313 N MAIN ST"
#> 
#> $sample_837_9$`N4ASHLAND CITY`
#> [1] "N4"           "ASHLAND CITY" "TN"           "37015"       
#> 
#> $sample_837_9$REFEI
#> [1] "REF"        "EI"         "99-5971744"
#> 
#> $sample_837_9$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_9$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $sample_837_9$SBRP
#>  [1] "SBR"       "P"         "18"        "556791994" NA          NA         
#>  [7] NA          NA          NA          "CI"       
#> 
#> $sample_837_9$NM1IL
#>  [1] "NM1"              "IL"               "1"                "TESTLAST01"      
#>  [5] "TESTFIRST01"      NA                 NA                 NA                
#>  [9] "MI"               "TESTMBR000000001"
#> 
#> $sample_837_9$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_9$N4TESTCITY
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_837_9[[20]]
#>  [1] "CLM"        "4742333269" "839"        NA           NA          
#>  [6] "11:B:1"     "Y"          "A"          "Y"          "I"         
#> 
#> $sample_837_9[[21]]
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20240422-20240430"
#> 
#> $sample_837_9[[22]]
#> [1] "DTP"      "435"      "D8"       "20240809"
#> 
#> $sample_837_9[[23]]
#> [1] "DTP"  "096"  "TM"   "2337"
#> 
#> $sample_837_9[[24]]
#> [1] "HI"          "ABK:V9421XS"
#> 
#> $sample_837_9[[25]]
#> [1] "HI"          "ABK:S35292S"
#> 
#> $sample_837_9[[26]]
#> [1] "HI"          "ABK:S52272S"
#> 
#> $sample_837_9[[27]]
#> [1] "HI"         "ABK:H68022"
#> 
#> $sample_837_9[[28]]
#> [1] "HI"          "ABK:T4144XD"
#> 
#> $sample_837_9[[29]]
#> [1] "HI"        "ABK:H1030"
#> 
#> $sample_837_9[[30]]
#> [1] "HI"          "ABK:S82832J"
#> 
#> $sample_837_9[[31]]
#> [1] "HI"       "ABK:B340"
#> 
#> $sample_837_9[[32]]
#> [1] "LX" "1" 
#> 
#> $sample_837_9[[33]]
#>  [1] "SV1"       "HC:35650"  "161"       "UN"        "1"         NA         
#>  [7] NA          "7:3:4:5:8" NA          NA         
#> 
#> $sample_837_9[[34]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_9[[35]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_9[[36]]
#> [1] "LX" "2" 
#> 
#> $sample_837_9[[37]]
#>  [1] "SV1"             "HC:73200"        "383"             "UN"             
#>  [5] "1"               NA                NA                "5:2:7:4:3:6:8:1"
#>  [9] NA                NA               
#> 
#> $sample_837_9[[38]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_9[[39]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_9[[40]]
#> [1] "LX" "3" 
#> 
#> $sample_837_9[[41]]
#>  [1] "SV1"      "HC:28262" "194"      "UN"       "1"        NA        
#>  [7] NA         "7:1:8"    NA         NA        
#> 
#> $sample_837_9[[42]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_9[[43]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_9[[44]]
#> [1] "LX" "4" 
#> 
#> $sample_837_9[[45]]
#>  [1] "SV1"      "HC:84480" "101"      "UN"       "1"        NA        
#>  [7] NA         "6:3:1:2"  NA         NA        
#> 
#> $sample_837_9[[46]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_9[[47]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_9$SE
#> [1] "SE"      "46"      "4763033"
#> 
#> $sample_837_9$GE
#> [1] "GE" "1"  "1" 
#> 
#> $sample_837_9$IEA
#> [1] "IEA"       "1"         "253034665"
#> 
#> 
purrr::map(hcc::x12_837P, index_x12) |> purrr::map(parse_837)
#> $`837P_EX10a_drug_adm_office`
#> $`837P_EX10a_drug_adm_office`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "231106"    "1411"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`837P_EX10a_drug_adm_office`$GS
#> [1] "GS"           "HC"           "SENDERGS"     "RECEIVERGS"   "20231106"    
#> [6] "141104"       "000000001"    "X"            "005010X222A1"
#> 
#> $`837P_EX10a_drug_adm_office`$ST
#> [1] "ST"           "837"          "0711"         "005010X222A1"
#> 
#> $`837P_EX10a_drug_adm_office`$BHT
#> [1] "BHT"      "0019"     "00"       "0013"     "20040801" "1200"     "CH"      
#> 
#> $`837P_EX10a_drug_adm_office`$NM141
#>  [1] "NM1"                    "41"                     "2"                     
#>  [4] "Associates in Medicine" NA                       NA                      
#>  [7] NA                       NA                       "46"                    
#> [10] "587654321"             
#> 
#> $`837P_EX10a_drug_adm_office`$PERIC
#> [1] "PER"        "IC"         "Bud Holly"  "TE"         "8017268899"
#> 
#> $`837P_EX10a_drug_adm_office`$NM140
#>  [1] "NM1"          "40"           "2"            "XYZ Receiver" NA            
#>  [6] NA             NA             NA             "46"           "369852758"   
#> 
#> $`837P_EX10a_drug_adm_office`$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $`837P_EX10a_drug_adm_office`$NM185
#>  [1] "NM1"                    "85"                     "2"                     
#>  [4] "Associates in Medicine" NA                       NA                      
#>  [7] NA                       NA                       "XX"                    
#> [10] "587654321"             
#> 
#> $`837P_EX10a_drug_adm_office`$`N31313 Las Vegas Boulevard`
#> [1] "N3"                       "1313 Las Vegas Boulevard"
#> 
#> $`837P_EX10a_drug_adm_office`$`N4Las Vegas`
#> [1] "N4"        "Las Vegas" "NV"        "89109"    
#> 
#> $`837P_EX10a_drug_adm_office`$REFEI
#> [1] "REF"       "EI"        "587654321"
#> 
#> $`837P_EX10a_drug_adm_office`$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $`837P_EX10a_drug_adm_office`$SBRP
#>  [1] "SBR"         "P"           "18"          "GRP01020102" NA           
#>  [6] NA            NA            NA            NA            "CI"         
#> 
#> $`837P_EX10a_drug_adm_office`$NM1IL
#>  [1] "NM1"        "IL"         "1"          "Vaughn"     "Steve"     
#>  [6] "R"          NA           NA           "MI"         "MBRID12345"
#> 
#> $`837P_EX10a_drug_adm_office`$`N3236 Diamond ST`
#> [1] "N3"             "236 Diamond ST"
#> 
#> $`837P_EX10a_drug_adm_office`$`N4Las Vegas`
#> [1] "N4"        "Las Vegas" "NV"        "89109"    
#> 
#> $`837P_EX10a_drug_adm_office`$DMGD8
#> [1] "DMG"      "D8"       "19430501" "M"       
#> 
#> $`837P_EX10a_drug_adm_office`$NM1PR
#>  [1] "NM1"             "PR"              "2"               "R&R Health Plan"
#>  [5] NA                NA                NA                NA               
#>  [9] "XV"              "PLANID12345"    
#> 
#> $`837P_EX10a_drug_adm_office`[[20]]
#>  [1] "CLM"        "CLMNO12345" "103.37"     NA           NA          
#>  [6] "11>B>1"     "Y"          "A"          "Y"          "Y"         
#> 
#> $`837P_EX10a_drug_adm_office`[[21]]
#> [1] "HI"       "BK>03591"
#> 
#> $`837P_EX10a_drug_adm_office`[[22]]
#>  [1] "NM1"        "82"         "1"          "Hendrix"    "Jim"       
#>  [6] NA           NA           NA           "XX"         "1122333341"
#> 
#> $`837P_EX10a_drug_adm_office`[[23]]
#> [1] "PRV"        "PE"         "PXC"        "208D00000X"
#> 
#> $`837P_EX10a_drug_adm_office`[[24]]
#> [1] "LX" "1" 
#> 
#> $`837P_EX10a_drug_adm_office`[[25]]
#> [1] "SV1"      "HC>90782" "50"       "UN"       "1"        "11"       NA        
#> [8] "1"       
#> 
#> $`837P_EX10a_drug_adm_office`[[26]]
#> [1] "DTP"      "472"      "D8"       "20040711"
#> 
#> $`837P_EX10a_drug_adm_office`[[27]]
#> [1] "LX" "2" 
#> 
#> $`837P_EX10a_drug_adm_office`[[28]]
#> [1] "SV1"      "HC>J1550" "53.37"    "UN"       "1"        "11"       NA        
#> [8] "1"       
#> 
#> $`837P_EX10a_drug_adm_office`[[29]]
#> [1] "DTP"      "472"      "D8"       "20040711"
#> 
#> $`837P_EX10a_drug_adm_office`[[30]]
#> [1] "AMT"  "T"    "3.37"
#> 
#> $`837P_EX10a_drug_adm_office`[[31]]
#> [1] "LIN"         NA            "N4"          "00026063512"
#> 
#> $`837P_EX10a_drug_adm_office`[[32]]
#> [1] "CTP" NA    NA    NA    "10"  "ML" 
#> 
#> $`837P_EX10a_drug_adm_office`$SE
#> [1] "SE"   "31"   "0711"
#> 
#> $`837P_EX10a_drug_adm_office`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`837P_EX10a_drug_adm_office`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`837P_EX11_ppo_repriced_claim`
#> $`837P_EX11_ppo_repriced_claim`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "231106"    "1415"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`837P_EX11_ppo_repriced_claim`$GS
#> [1] "GS"           "HC"           "SENDERGS"     "RECEIVERGS"   "20231106"    
#> [6] "141535"       "000000001"    "X"            "005010X222A1"
#> 
#> $`837P_EX11_ppo_repriced_claim`$ST
#> [1] "ST"           "837"          "1002"         "005010X222A1"
#> 
#> $`837P_EX11_ppo_repriced_claim`$BHT
#> [1] "BHT"      "0019"     "00"       "1002"     "20050620" "09460000" "CH"      
#> 
#> $`837P_EX11_ppo_repriced_claim`$NM141
#>  [1] "NM1"                  "41"                   "2"                   
#>  [4] "REGIONAL PPO NETWORK" NA                     NA                    
#>  [7] NA                     NA                     "46"                  
#> [10] "123456789"           
#> 
#> $`837P_EX11_ppo_repriced_claim`$PERIC
#> [1] "PER"                    "IC"                     "SUBMITTER CONTACT INFO"
#> [4] "TE"                     "8001231234"            
#> 
#> $`837P_EX11_ppo_repriced_claim`$NM140
#>  [1] "NM1"                     "40"                     
#>  [3] "2"                       "EXTRA HEALTHY INSURANCE"
#>  [5] NA                        NA                       
#>  [7] NA                        NA                       
#>  [9] "46"                      "112244"                 
#> 
#> $`837P_EX11_ppo_repriced_claim`$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $`837P_EX11_ppo_repriced_claim`$NM185
#>  [1] "NM1"                          "85"                          
#>  [3] "2"                            "HAPPY DOCTORS GROUP PRACTICE"
#>  [5] NA                             NA                            
#>  [7] NA                             NA                            
#>  [9] "XX"                           "1234567890"                  
#> 
#> $`837P_EX11_ppo_repriced_claim`$`N3P O BOX 123`
#> [1] "N3"          "P O BOX 123"
#> 
#> $`837P_EX11_ppo_repriced_claim`$`N4FORT WAYNE`
#> [1] "N4"         "FORT WAYNE" "IN"         "462540000" 
#> 
#> $`837P_EX11_ppo_repriced_claim`$REFEI
#> [1] "REF"       "EI"        "555512345"
#> 
#> $`837P_EX11_ppo_repriced_claim`$PERIC
#> [1] "PER"               "IC"                "SUE BILLINGSWORTH"
#> [4] "TE"                "8881231234"       
#> 
#> $`837P_EX11_ppo_repriced_claim`$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $`837P_EX11_ppo_repriced_claim`$SBRP
#>  [1] "SBR"    "P"      "18"     "123XYZ" NA       NA       NA       NA      
#>  [9] NA       "CI"    
#> 
#> $`837P_EX11_ppo_repriced_claim`$NM1IL
#>  [1] "NM1"       "IL"        "1"         "RING"      "DIAMOND"   "D"        
#>  [7] NA          NA          "MI"        "00124A089"
#> 
#> $`837P_EX11_ppo_repriced_claim`$`N3123 EXAMPLE DRIVE`
#> [1] "N3"                "123 EXAMPLE DRIVE"
#> 
#> $`837P_EX11_ppo_repriced_claim`$N4INDIANAPOLIS
#> [1] "N4"           "INDIANAPOLIS" "IN"           "462290000"   
#> 
#> $`837P_EX11_ppo_repriced_claim`$DMGD8
#> [1] "DMG"      "D8"       "19401229" "F"       
#> 
#> $`837P_EX11_ppo_repriced_claim`$NM1PR
#>  [1] "NM1"                     "PR"                     
#>  [3] "2"                       "EXTRA HEALTHY INSURANCE"
#>  [5] NA                        NA                       
#>  [7] NA                        NA                       
#>  [9] "PI"                      "12345"                  
#> 
#> $`837P_EX11_ppo_repriced_claim`[[21]]
#>  [1] "CLM"       "ABC123-RI" "28.75"     NA          NA          "11>B>1"   
#>  [7] "Y"         "A"         "Y"         "Y"         "P"        
#> 
#> $`837P_EX11_ppo_repriced_claim`[[22]]
#> [1] "REF"        "9A"         "0902352342"
#> 
#> $`837P_EX11_ppo_repriced_claim`[[23]]
#> [1] "REF"             "D9"              "061505501749388"
#> 
#> $`837P_EX11_ppo_repriced_claim`[[24]]
#> [1] "HI"       "BK>496"   "BF>25000"
#> 
#> $`837P_EX11_ppo_repriced_claim`[[25]]
#> [1] "HCP"       "03"        "26.75"     "2"         "908231234"
#> 
#> $`837P_EX11_ppo_repriced_claim`[[26]]
#>  [1] "NM1"        "DN"         "1"          "DOE"        "JOHN"      
#>  [6] NA           NA           NA           "XX"         "9988776655"
#> 
#> $`837P_EX11_ppo_repriced_claim`[[27]]
#>  [1] "NM1"        "82"         "1"          "ANTHONY"    "SUSAN"     
#>  [6] "B"          NA           NA           "XX"         "1122334455"
#> 
#> $`837P_EX11_ppo_repriced_claim`[[28]]
#> [1] "NM1"                 "77"                  "2"                  
#> [4] "HAPPY DOCTORS GROUP"
#> 
#> $`837P_EX11_ppo_repriced_claim`[[29]]
#> [1] "N3"                 "123 FEEL GOOD ROAD"
#> 
#> $`837P_EX11_ppo_repriced_claim`[[30]]
#> [1] "N4"         "WASHINGTON" "IN"         "475010000" 
#> 
#> $`837P_EX11_ppo_repriced_claim`[[31]]
#> [1] "LX" "1" 
#> 
#> $`837P_EX11_ppo_repriced_claim`[[32]]
#> [1] "SV1"         "HC>E0570>RR" "25"          "UN"          "1"          
#> [6] NA            NA            "1>2"        
#> 
#> $`837P_EX11_ppo_repriced_claim`[[33]]
#> [1] "DTP"      "472"      "D8"       "20050514"
#> 
#> $`837P_EX11_ppo_repriced_claim`[[34]]
#> [1] "HCP"       "03"        "23.75"     "1.25"      "908231234"
#> 
#> $`837P_EX11_ppo_repriced_claim`[[35]]
#> [1] "LX" "2" 
#> 
#> $`837P_EX11_ppo_repriced_claim`[[36]]
#> [1] "SV1"         "HC>A7003>NU" "3.75"        "UN"          "1"          
#> [6] NA            NA            "1"          
#> 
#> $`837P_EX11_ppo_repriced_claim`[[37]]
#> [1] "DTP"      "472"      "D8"       "20050514"
#> 
#> $`837P_EX11_ppo_repriced_claim`[[38]]
#> [1] "HCP"       "03"        "3"         ".75"       "908231234"
#> 
#> $`837P_EX11_ppo_repriced_claim`$SE
#> [1] "SE"   "37"   "1002"
#> 
#> $`837P_EX11_ppo_repriced_claim`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`837P_EX11_ppo_repriced_claim`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`837P_EX12_oon_repriced_claim`
#> $`837P_EX12_oon_repriced_claim`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "231106"    "1416"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`837P_EX12_oon_repriced_claim`$GS
#> [1] "GS"           "HC"           "SENDERGS"     "RECEIVERGS"   "20231106"    
#> [6] "141631"       "000000001"    "X"            "005010X222A1"
#> 
#> $`837P_EX12_oon_repriced_claim`$ST
#> [1] "ST"           "837"          "1024"         "005010X222A1"
#> 
#> $`837P_EX12_oon_repriced_claim`$BHT
#> [1] "BHT"      "0019"     "00"       "1024"     "20050711" "1335"     "CH"      
#> 
#> $`837P_EX12_oon_repriced_claim`$NM141
#>  [1] "NM1"                  "41"                   "2"                   
#>  [4] "REGIONAL PPO NETWORK" NA                     NA                    
#>  [7] NA                     NA                     "46"                  
#> [10] "123456789"           
#> 
#> $`837P_EX12_oon_repriced_claim`$PERIC
#> [1] "PER"                    "IC"                     "SUBMITTER CONTACT INFO"
#> [4] "TE"                     "8001231234"            
#> 
#> $`837P_EX12_oon_repriced_claim`$NM140
#>  [1] "NM1"                    "40"                     "2"                     
#>  [4] "CONSERVATIVE INSURANCE" NA                       NA                      
#>  [7] NA                       NA                       "46"                    
#> [10] "000110002"             
#> 
#> $`837P_EX12_oon_repriced_claim`$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $`837P_EX12_oon_repriced_claim`$NM185
#>  [1] "NM1"                        "85"                        
#>  [3] "2"                          "EMERGENCY PHYSICIANS GROUP"
#>  [5] NA                           NA                          
#>  [7] NA                           NA                          
#>  [9] "XX"                         "1122334455"                
#> 
#> $`837P_EX12_oon_repriced_claim`$`N37423 SUPER STREET`
#> [1] "N3"                "7423 SUPER STREET"
#> 
#> $`837P_EX12_oon_repriced_claim`$N4BILLINGS
#> [1] "N4"        "BILLINGS"  "MO"        "919910000"
#> 
#> $`837P_EX12_oon_repriced_claim`$REFEI
#> [1] "REF"       "EI"        "111002222"
#> 
#> $`837P_EX12_oon_repriced_claim`$HL2
#> [1] "HL" "2"  "1"  "22" "1" 
#> 
#> $`837P_EX12_oon_repriced_claim`$SBRP
#>  [1] "SBR"   "P"     NA      "232AA" NA      NA      NA      NA      NA     
#> [10] "CI"   
#> 
#> $`837P_EX12_oon_repriced_claim`$NM1IL
#>  [1] "NM1"       "IL"        "1"         "SMITH"     "MATTHEW"   "R"        
#>  [7] NA          NA          "MI"        "57976235C"
#> 
#> $`837P_EX12_oon_repriced_claim`$`N35698 SOUTH STREET`
#> [1] "N3"                "5698 SOUTH STREET"
#> 
#> $`837P_EX12_oon_repriced_claim`$N4BILLINGS
#> [1] "N4"        "BILLINGS"  "MO"        "919910000"
#> 
#> $`837P_EX12_oon_repriced_claim`$DMGD8
#> [1] "DMG"      "D8"       "19561015" "M"       
#> 
#> $`837P_EX12_oon_repriced_claim`$NM1PR
#>  [1] "NM1"                    "PR"                     "2"                     
#>  [4] "CONSERVATIVE INSURANCE" NA                       NA                      
#>  [7] NA                       NA                       "PI"                    
#> [10] "00123"                 
#> 
#> $`837P_EX12_oon_repriced_claim`$HL3
#> [1] "HL" "3"  "2"  "23" "0" 
#> 
#> $`837P_EX12_oon_repriced_claim`$PAT19
#> [1] "PAT" "19" 
#> 
#> $`837P_EX12_oon_repriced_claim`$NM1QC
#> [1] "NM1"   "QC"    "1"     "SMITH" "TOM"   "E"    
#> 
#> $`837P_EX12_oon_repriced_claim`$`N35698 SOUTH STREET`
#> [1] "N3"                "5698 SOUTH STREET"
#> 
#> $`837P_EX12_oon_repriced_claim`$N4BILLINGS
#> [1] "N4"        "BILLINGS"  "MO"        "919910000"
#> 
#> $`837P_EX12_oon_repriced_claim`$DMGD8
#> [1] "DMG"      "D8"       "19960807" "M"       
#> 
#> $`837P_EX12_oon_repriced_claim`[[26]]
#>  [1] "CLM"     "TS234H3" "252.71"  NA        NA        "23>B>1"  "Y"      
#>  [8] "A"       "Y"       "Y"       "P"      
#> 
#> $`837P_EX12_oon_repriced_claim`[[27]]
#> [1] "REF"        "9A"         "0902345406"
#> 
#> $`837P_EX12_oon_repriced_claim`[[28]]
#> [1] "REF"          "D9"           "687534234346"
#> 
#> $`837P_EX12_oon_repriced_claim`[[29]]
#> [1] "HI"      "BK>9951"
#> 
#> $`837P_EX12_oon_repriced_claim`[[30]]
#>  [1] "HCP"       "00"        "0"         NA          "333001234" NA         
#>  [7] NA          NA          NA          NA          NA          NA         
#> [13] NA          "T1"       
#> 
#> $`837P_EX12_oon_repriced_claim`[[31]]
#>  [1] "NM1"        "82"         "1"          "BLUE"       "JACKIE"    
#>  [6] "D"          NA           NA           "XX"         "1112223336"
#> 
#> $`837P_EX12_oon_repriced_claim`[[32]]
#>  [1] "SBR"   "S"     "18"    "56567" NA      NA      NA      NA      NA     
#> [10] "CI"   
#> 
#> $`837P_EX12_oon_repriced_claim`[[33]]
#> [1] "OI" NA   NA   "Y"  NA   NA   "Y" 
#> 
#> $`837P_EX12_oon_repriced_claim`[[34]]
#>  [1] "NM1"      "IL"       "1"        "SMITH"    "TOM"      "E"       
#>  [7] NA         NA         "MI"       "23424570"
#> 
#> $`837P_EX12_oon_repriced_claim`[[35]]
#> [1] "N3"                "5698 SOUTH STREET"
#> 
#> $`837P_EX12_oon_repriced_claim`[[36]]
#> [1] "N4"        "BILLINGS"  "MO"        "919910000"
#> 
#> $`837P_EX12_oon_repriced_claim`[[37]]
#>  [1] "NM1"                         "PR"                         
#>  [3] "2"                           "SECONDARY INSURANCE COMPANY"
#>  [5] NA                            NA                           
#>  [7] NA                            NA                           
#>  [9] "PI"                          "95645"                      
#> 
#> $`837P_EX12_oon_repriced_claim`[[38]]
#> [1] "LX" "1" 
#> 
#> $`837P_EX12_oon_repriced_claim`[[39]]
#> [1] "SV1"      "HC>99284" "252.71"   "UN"       "1"        NA         NA        
#> [8] "1"       
#> 
#> $`837P_EX12_oon_repriced_claim`[[40]]
#> [1] "DTP"      "472"      "D8"       "20050506"
#> 
#> $`837P_EX12_oon_repriced_claim`$SE
#> [1] "SE"   "39"   "1024"
#> 
#> $`837P_EX12_oon_repriced_claim`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`837P_EX12_oon_repriced_claim`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`837P_EX1_commercial-insurance`
#> $`837P_EX1_commercial-insurance`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "231106"    "1408"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`837P_EX1_commercial-insurance`$GS
#> [1] "GS"           "HC"           "SENDERGS"     "RECEIVERGS"   "20231106"    
#> [6] "140840"       "000000001"    "X"            "005010X222A1"
#> 
#> $`837P_EX1_commercial-insurance`$ST
#> [1] "ST"           "837"          "0021"         "005010X222A1"
#> 
#> $`837P_EX1_commercial-insurance`$BHT
#> [1] "BHT"      "0019"     "00"       "244579"   "20061015" "1023"     "CH"      
#> 
#> $`837P_EX1_commercial-insurance`$NM141
#>  [1] "NM1"                     "41"                     
#>  [3] "2"                       "PREMIER BILLING SERVICE"
#>  [5] NA                        NA                       
#>  [7] NA                        NA                       
#>  [9] "46"                      "TGJ23"                  
#> 
#> $`837P_EX1_commercial-insurance`$PERIC
#> [1] "PER"        "IC"         "JERRY"      "TE"         "3055552222"
#> [6] "EX"         "231"       
#> 
#> $`837P_EX1_commercial-insurance`$NM140
#>  [1] "NM1"                   "40"                    "2"                    
#>  [4] "KEY INSURANCE COMPANY" NA                      NA                     
#>  [7] NA                      NA                      "46"                   
#> [10] "66783JJT"             
#> 
#> $`837P_EX1_commercial-insurance`$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $`837P_EX1_commercial-insurance`$PRVBI
#> [1] "PRV"        "BI"         "PXC"        "203BF0100Y"
#> 
#> $`837P_EX1_commercial-insurance`$NM185
#>  [1] "NM1"                 "85"                  "2"                  
#>  [4] "BEN KILDARE SERVICE" NA                    NA                   
#>  [7] NA                    NA                    "XX"                 
#> [10] "9876543210"         
#> 
#> $`837P_EX1_commercial-insurance`$`N3234 SEAWAY ST`
#> [1] "N3"            "234 SEAWAY ST"
#> 
#> $`837P_EX1_commercial-insurance`$N4MIAMI
#> [1] "N4"    "MIAMI" "FL"    "33111"
#> 
#> $`837P_EX1_commercial-insurance`$REFEI
#> [1] "REF"       "EI"        "587654321"
#> 
#> $`837P_EX1_commercial-insurance`$NM187
#> [1] "NM1" "87"  "2"  
#> 
#> $`837P_EX1_commercial-insurance`$`N32345 OCEAN BLVD`
#> [1] "N3"              "2345 OCEAN BLVD"
#> 
#> $`837P_EX1_commercial-insurance`$N4MIAMI
#> [1] "N4"    "MIAMI" "FL"    "33111"
#> 
#> $`837P_EX1_commercial-insurance`$HL2
#> [1] "HL" "2"  "1"  "22" "1" 
#> 
#> $`837P_EX1_commercial-insurance`$SBRP
#>  [1] "SBR"     "P"       NA        "2222-SJ" NA        NA        NA       
#>  [8] NA        NA        "CI"     
#> 
#> $`837P_EX1_commercial-insurance`$NM1IL
#>  [1] "NM1"           "IL"            "1"             "SMITH"        
#>  [5] "JANE"          NA              NA              NA             
#>  [9] "MI"            "JS00111223333"
#> 
#> $`837P_EX1_commercial-insurance`$DMGD8
#> [1] "DMG"      "D8"       "19430501" "F"       
#> 
#> $`837P_EX1_commercial-insurance`$NM1PR
#>  [1] "NM1"                   "PR"                    "2"                    
#>  [4] "KEY INSURANCE COMPANY" NA                      NA                     
#>  [7] NA                      NA                      "PI"                   
#> [10] "999996666"            
#> 
#> $`837P_EX1_commercial-insurance`$REFG2
#> [1] "REF"    "G2"     "KA6663"
#> 
#> $`837P_EX1_commercial-insurance`$HL3
#> [1] "HL" "3"  "2"  "23" "0" 
#> 
#> $`837P_EX1_commercial-insurance`$PAT19
#> [1] "PAT" "19" 
#> 
#> $`837P_EX1_commercial-insurance`$NM1QC
#> [1] "NM1"   "QC"    "1"     "SMITH" "TED"  
#> 
#> $`837P_EX1_commercial-insurance`$`N3236 N MAIN ST`
#> [1] "N3"            "236 N MAIN ST"
#> 
#> $`837P_EX1_commercial-insurance`$N4MIAMI
#> [1] "N4"    "MIAMI" "FL"    "33413"
#> 
#> $`837P_EX1_commercial-insurance`$DMGD8
#> [1] "DMG"      "D8"       "19730501" "M"       
#> 
#> $`837P_EX1_commercial-insurance`[[29]]
#>  [1] "CLM"      "26463774" "100"      NA         NA         "11>B>1"  
#>  [7] "Y"        "A"        "Y"        "I"       
#> 
#> $`837P_EX1_commercial-insurance`[[30]]
#> [1] "REF"               "D9"                "17312345600006351"
#> 
#> $`837P_EX1_commercial-insurance`[[31]]
#> [1] "HI"       "BK>0340"  "BF>V7389"
#> 
#> $`837P_EX1_commercial-insurance`[[32]]
#> [1] "LX" "1" 
#> 
#> $`837P_EX1_commercial-insurance`[[33]]
#> [1] "SV1"      "HC>99213" "40"       "UN"       "1"        NA         NA        
#> [8] "1"       
#> 
#> $`837P_EX1_commercial-insurance`[[34]]
#> [1] "DTP"      "472"      "D8"       "20061003"
#> 
#> $`837P_EX1_commercial-insurance`[[35]]
#> [1] "LX" "2" 
#> 
#> $`837P_EX1_commercial-insurance`[[36]]
#> [1] "SV1"      "HC>87070" "15"       "UN"       "1"        NA         NA        
#> [8] "1"       
#> 
#> $`837P_EX1_commercial-insurance`[[37]]
#> [1] "DTP"      "472"      "D8"       "20061003"
#> 
#> $`837P_EX1_commercial-insurance`[[38]]
#> [1] "LX" "3" 
#> 
#> $`837P_EX1_commercial-insurance`[[39]]
#> [1] "SV1"      "HC>99214" "35"       "UN"       "1"        NA         NA        
#> [8] "2"       
#> 
#> $`837P_EX1_commercial-insurance`[[40]]
#> [1] "DTP"      "472"      "D8"       "20061010"
#> 
#> $`837P_EX1_commercial-insurance`[[41]]
#> [1] "LX" "4" 
#> 
#> $`837P_EX1_commercial-insurance`[[42]]
#> [1] "SV1"      "HC>86663" "10"       "UN"       "1"        NA         NA        
#> [8] "2"       
#> 
#> $`837P_EX1_commercial-insurance`[[43]]
#> [1] "DTP"      "472"      "D8"       "20061010"
#> 
#> $`837P_EX1_commercial-insurance`$SE
#> [1] "SE"   "42"   "0021"
#> 
#> $`837P_EX1_commercial-insurance`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`837P_EX1_commercial-insurance`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`837P_EX2_encounter`
#> $`837P_EX2_encounter`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "231106"    "1418"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`837P_EX2_encounter`$GS
#> [1] "GS"           "HC"           "SENDERGS"     "RECEIVERGS"   "20231106"    
#> [6] "141815"       "000000001"    "X"            "005010X222A1"
#> 
#> $`837P_EX2_encounter`$ST
#> [1] "ST"           "837"          "0021"         "005010X222A1"
#> 
#> $`837P_EX2_encounter`$BHT
#> [1] "BHT"      "0019"     "00"       "0123"     "20061015" "1023"     "RP"      
#> 
#> $`837P_EX2_encounter`$NM141
#>  [1] "NM1"                     "41"                     
#>  [3] "2"                       "PREMIER BILLING SERVICE"
#>  [5] NA                        NA                       
#>  [7] NA                        NA                       
#>  [9] "46"                      "TGJ23"                  
#> 
#> $`837P_EX2_encounter`$PERIC
#> [1] "PER"        "IC"         "JERRY"      "TE"         "3055552222"
#> [6] "EX"         "231"       
#> 
#> $`837P_EX2_encounter`$NM140
#>  [1] "NM1"      "40"       "2"        "AHLIC"    NA         NA        
#>  [7] NA         NA         "46"       "66783JJT"
#> 
#> $`837P_EX2_encounter`$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $`837P_EX2_encounter`$PRVBI
#> [1] "PRV"        "BI"         "PXC"        "203BF0100Y"
#> 
#> $`837P_EX2_encounter`$NM185
#>  [1] "NM1"                 "85"                  "2"                  
#>  [4] "BEN KILDARE SERVICE" NA                    NA                   
#>  [7] NA                    NA                    "XX"                 
#> [10] "9876543210"         
#> 
#> $`837P_EX2_encounter`$`N3234 SEAWAY ST`
#> [1] "N3"            "234 SEAWAY ST"
#> 
#> $`837P_EX2_encounter`$N4MIAMI
#> [1] "N4"    "MIAMI" "FL"    "33111"
#> 
#> $`837P_EX2_encounter`$REFEI
#> [1] "REF"       "EI"        "587654321"
#> 
#> $`837P_EX2_encounter`$NM187
#> [1] "NM1" "87"  "2"  
#> 
#> $`837P_EX2_encounter`$`N32345 OCEAN BLVD`
#> [1] "N3"              "2345 OCEAN BLVD"
#> 
#> $`837P_EX2_encounter`$N4MIAMI
#> [1] "N4"    "MIAMI" "FL"    "33111"
#> 
#> $`837P_EX2_encounter`$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $`837P_EX2_encounter`$SBRP
#>  [1] "SBR"     "P"       "18"      "12312-A" NA        NA        NA       
#>  [8] NA        NA        "HM"     
#> 
#> $`837P_EX2_encounter`$NM1IL
#>  [1] "NM1"       "IL"        "1"         "SMITH"     "TED"       NA         
#>  [7] NA          NA          "MI"        "000221111"
#> 
#> $`837P_EX2_encounter`$`N3236 N MAIN ST`
#> [1] "N3"            "236 N MAIN ST"
#> 
#> $`837P_EX2_encounter`$N4MIAMI
#> [1] "N4"    "MIAMI" "FL"    "33413"
#> 
#> $`837P_EX2_encounter`$DMGD8
#> [1] "DMG"      "D8"       "19430501" "M"       
#> 
#> $`837P_EX2_encounter`$NM1PR
#>  [1] "NM1"                                "PR"                                
#>  [3] "2"                                  "ALLIANCE HEALTH AND LIFE INSURANCE"
#>  [5] NA                                   NA                                  
#>  [7] NA                                   NA                                  
#>  [9] "PI"                                 "741234"                            
#> 
#> $`837P_EX2_encounter`[[24]]
#>  [1] "CLM"      "26462967" "100"      NA         NA         "11>B>1"  
#>  [7] "Y"        "A"        "Y"        "I"       
#> 
#> $`837P_EX2_encounter`[[25]]
#> [1] "DTP"      "431"      "D8"       "19981003"
#> 
#> $`837P_EX2_encounter`[[26]]
#> [1] "REF"               "D9"                "17312345600006351"
#> 
#> $`837P_EX2_encounter`[[27]]
#> [1] "HI"       "BK>0340"  "BF>V7389"
#> 
#> $`837P_EX2_encounter`[[28]]
#>  [1] "NM1"                "77"                 "2"                 
#>  [4] "KILDARE ASSOCIATES" NA                   NA                  
#>  [7] NA                   NA                   "XX"                
#> [10] "5812345679"        
#> 
#> $`837P_EX2_encounter`[[29]]
#> [1] "N3"              "2345 OCEAN BLVD"
#> 
#> $`837P_EX2_encounter`[[30]]
#> [1] "N4"    "MIAMI" "FL"    "33111"
#> 
#> $`837P_EX2_encounter`[[31]]
#> [1] "LX" "1" 
#> 
#> $`837P_EX2_encounter`[[32]]
#> [1] "SV1"      "HC>99213" "40"       "UN"       "1"        NA         NA        
#> [8] "1"       
#> 
#> $`837P_EX2_encounter`[[33]]
#> [1] "DTP"      "472"      "D8"       "20061003"
#> 
#> $`837P_EX2_encounter`[[34]]
#> [1] "LX" "2" 
#> 
#> $`837P_EX2_encounter`[[35]]
#> [1] "SV1"      "HC>87072" "15"       "UN"       "1"        NA         NA        
#> [8] "1"       
#> 
#> $`837P_EX2_encounter`[[36]]
#> [1] "DTP"      "472"      "D8"       "20061003"
#> 
#> $`837P_EX2_encounter`[[37]]
#> [1] "LX" "3" 
#> 
#> $`837P_EX2_encounter`[[38]]
#> [1] "SV1"      "HC>99214" "35"       "UN"       "1"        NA         NA        
#> [8] "2"       
#> 
#> $`837P_EX2_encounter`[[39]]
#> [1] "DTP"      "472"      "D8"       "20061010"
#> 
#> $`837P_EX2_encounter`[[40]]
#> [1] "LX" "4" 
#> 
#> $`837P_EX2_encounter`[[41]]
#> [1] "SV1"      "HC>86663" "10"       "UN"       "1"        NA         NA        
#> [8] "2"       
#> 
#> $`837P_EX2_encounter`[[42]]
#> [1] "DTP"      "472"      "D8"       "20061010"
#> 
#> $`837P_EX2_encounter`$SE
#> [1] "SE"   "41"   "0021"
#> 
#> $`837P_EX2_encounter`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`837P_EX2_encounter`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`837P_EX3a_billing_provider_payer_a`
#> $`837P_EX3a_billing_provider_payer_a`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "231106"    "1420"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`837P_EX3a_billing_provider_payer_a`$GS
#> [1] "GS"           "HC"           "SENDERGS"     "RECEIVERGS"   "20231106"    
#> [6] "142058"       "000000001"    "X"            "005010X222A1"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$ST
#> [1] "ST"           "837"          "0021"         "005010X222A1"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$BHT
#> [1] "BHT"      "0019"     "00"       "0123"     "20051015" "1023"     "CH"      
#> 
#> $`837P_EX3a_billing_provider_payer_a`$NM141
#>  [1] "NM1"                     "41"                     
#>  [3] "2"                       "PREMIER BILLING SERVICE"
#>  [5] NA                        NA                       
#>  [7] NA                        NA                       
#>  [9] "46"                      "TGJ23"                  
#> 
#> $`837P_EX3a_billing_provider_payer_a`$PERIC
#> [1] "PER"        "IC"         "JERRY"      "TE"         "3055552222"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$NM140
#>  [1] "NM1"          "40"           "2"            "XYZ REPRICER" NA            
#>  [6] NA             NA             NA             "46"           "66783JJT"    
#> 
#> $`837P_EX3a_billing_provider_payer_a`$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $`837P_EX3a_billing_provider_payer_a`$NM185
#>  [1] "NM1"        "85"         "1"          "KILDARE"    "BEN"       
#>  [6] NA           NA           NA           "XX"         "1999996666"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$`N3234 SEAWAY ST`
#> [1] "N3"            "234 SEAWAY ST"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$N4MIAMI
#> [1] "N4"    "MIAMI" "FL"    "33111"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$REFEI
#> [1] "REF"       "EI"        "123456789"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$PERIC
#> [1] "PER"        "IC"         "CONNIE"     "TE"         "3055551234"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$NM187
#> [1] "NM1" "87"  "2"  
#> 
#> $`837P_EX3a_billing_provider_payer_a`$`N32345 OCEAN BLVD`
#> [1] "N3"              "2345 OCEAN BLVD"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$N4MIAMI
#> [1] "N4"    "MIAMI" "FL"    "33111"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$HL2
#> [1] "HL" "2"  "1"  "22" "1" 
#> 
#> $`837P_EX3a_billing_provider_payer_a`$SBRP
#>  [1] "SBR" "P"   NA    NA    NA    NA    NA    NA    NA    "CI" 
#> 
#> $`837P_EX3a_billing_provider_payer_a`$NM1IL
#>  [1] "NM1"       "IL"        "1"         "SMITH"     "JANE"      NA         
#>  [7] NA          NA          "MI"        "111223333"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$DMGD8
#> [1] "DMG"      "D8"       "19430501" "F"       
#> 
#> $`837P_EX3a_billing_provider_payer_a`$NM1PR
#>  [1] "NM1"                   "PR"                    "2"                    
#>  [4] "KEY INSURANCE COMPANY" NA                      NA                     
#>  [7] NA                      NA                      "PI"                   
#> [10] "999996666"            
#> 
#> $`837P_EX3a_billing_provider_payer_a`$`N33333 OCEAN ST`
#> [1] "N3"            "3333 OCEAN ST"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$`N4SOUTH MIAMI`
#> [1] "N4"          "SOUTH MIAMI" "FL"          "33000"      
#> 
#> $`837P_EX3a_billing_provider_payer_a`$REFG2
#> [1] "REF"     "G2"      "PBS3334"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$HL3
#> [1] "HL" "3"  "2"  "23" "0" 
#> 
#> $`837P_EX3a_billing_provider_payer_a`$PAT19
#> [1] "PAT" "19" 
#> 
#> $`837P_EX3a_billing_provider_payer_a`$NM1QC
#> [1] "NM1"   "QC"    "1"     "SMITH" "TED"  
#> 
#> $`837P_EX3a_billing_provider_payer_a`$`N3236 N MAIN ST`
#> [1] "N3"            "236 N MAIN ST"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$N4MIAMI
#> [1] "N4"    "MIAMI" "FL"    "33413"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$DMGD8
#> [1] "DMG"      "D8"       "19730501" "M"       
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[31]]
#>  [1] "CLM"      "26407789" "79.04"    NA         NA         "11>B>1"  
#>  [7] "Y"        "A"        "Y"        "I"        "P"       
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[32]]
#> [1] "HI"       "BK>4779"  "BF>2724"  "BF>2780"  "BF>53081"
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[33]]
#>  [1] "NM1"        "82"         "1"          "KILDARE"    "BEN"       
#>  [6] NA           NA           NA           "XX"         "1999996666"
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[34]]
#> [1] "PRV"        "PE"         "PXC"        "204C00000X"
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[35]]
#> [1] "REF"    "G2"     "KA6663"
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[36]]
#>  [1] "NM1"                "77"                 "2"                 
#>  [4] "KILDARE ASSOCIATES" NA                   NA                  
#>  [7] NA                   NA                   "XX"                
#> [10] "1581234567"        
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[37]]
#> [1] "N3"              "2345 OCEAN BLVD"
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[38]]
#> [1] "N4"    "MIAMI" "FL"    "33111"
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[39]]
#>  [1] "SBR" "S"   "01"  NA    NA    NA    NA    NA    NA    "CI" 
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[40]]
#> [1] "OI" NA   NA   "Y"  "P"  NA   "Y" 
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[41]]
#>  [1] "NM1"      "IL"       "1"        "SMITH"    "JACK"     NA        
#>  [7] NA         NA         "MI"       "T55TY666"
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[42]]
#> [1] "N3"            "236 N MAIN ST"
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[43]]
#> [1] "N4"    "MIAMI" "FL"    "33111"
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[44]]
#>  [1] "NM1"                   "PR"                    "2"                    
#>  [4] "KEY INSURANCE COMPANY" NA                      NA                     
#>  [7] NA                      NA                      "PI"                   
#> [10] "999996666"            
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[45]]
#> [1] "LX" "1" 
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[46]]
#> [1] "SV1"      "HC>99213" "43"       "UN"       "1"        NA         NA        
#> [8] "1>2>3>4" 
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[47]]
#> [1] "DTP"      "472"      "D8"       "20051003"
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[48]]
#> [1] "LX" "2" 
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[49]]
#> [1] "SV1"      "HC>90782" "15"       "UN"       "1"        NA         NA        
#> [8] "1>2"     
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[50]]
#> [1] "DTP"      "472"      "D8"       "20051003"
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[51]]
#> [1] "LX" "3" 
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[52]]
#> [1] "SV1"      "HC>J3301" "21.04"    "UN"       "1"        NA         NA        
#> [8] "1>2"     
#> 
#> $`837P_EX3a_billing_provider_payer_a`[[53]]
#> [1] "DTP"      "472"      "D8"       "20051003"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$SE
#> [1] "SE"   "52"   "0021"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`837P_EX3a_billing_provider_payer_a`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`837P_EX4_medicare_secondary_cob`
#> $`837P_EX4_medicare_secondary_cob`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "231106"    "1421"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`837P_EX4_medicare_secondary_cob`$GS
#> [1] "GS"           "HC"           "SENDERGS"     "RECEIVERGS"   "20231106"    
#> [6] "142142"       "000000001"    "X"            "005010X222A1"
#> 
#> $`837P_EX4_medicare_secondary_cob`$ST
#> [1] "ST"           "837"          "0002"         "005010X222A1"
#> 
#> $`837P_EX4_medicare_secondary_cob`$BHT
#> [1] "BHT"       "0019"      "00"        "000001142" "20050214"  "115101"   
#> [7] "CH"       
#> 
#> $`837P_EX4_medicare_secondary_cob`$NM141
#>  [1] "NM1"         "41"          "2"           "SPECIALISTS" NA           
#>  [6] NA            NA            NA            "46"          "1111111"    
#> 
#> $`837P_EX4_medicare_secondary_cob`$PERIC
#> [1] "PER"        "IC"         "SUE"        "TE"         "8005558888"
#> 
#> $`837P_EX4_medicare_secondary_cob`$NM140
#>  [1] "NM1"                   "40"                    "2"                    
#>  [4] "MEDICARE PENNSYLVANIA" NA                      NA                     
#>  [7] NA                      NA                      "46"                   
#> [10] "10234"                
#> 
#> $`837P_EX4_medicare_secondary_cob`$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $`837P_EX4_medicare_secondary_cob`$NM185
#>  [1] "NM1"         "85"          "2"           "SPECIALISTS" NA           
#>  [6] NA            NA            NA            "XX"          "0100000090" 
#> 
#> $`837P_EX4_medicare_secondary_cob`$`N35 MAP COURT`
#> [1] "N3"          "5 MAP COURT"
#> 
#> $`837P_EX4_medicare_secondary_cob`$N4MAYNE
#> [1] "N4"    "MAYNE" "PA"    "17111"
#> 
#> $`837P_EX4_medicare_secondary_cob`$REFEI
#> [1] "REF"       "EI"        "890123456"
#> 
#> $`837P_EX4_medicare_secondary_cob`$REF1G
#> [1] "REF"    "1G"     "110101"
#> 
#> $`837P_EX4_medicare_secondary_cob`$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $`837P_EX4_medicare_secondary_cob`$SBRS
#>  [1] "SBR"      "S"        "18"       "MEDICARE" "12"       NA        
#>  [7] NA         NA         NA         "MB"      
#> 
#> $`837P_EX4_medicare_secondary_cob`$NM1IL
#>  [1] "NM1"         "IL"          "1"           "MEDYUM"      "WAYNE"      
#>  [6] "M"           NA            NA            "MI"          "102200221B1"
#> 
#> $`837P_EX4_medicare_secondary_cob`$`N31010 THOUSAND OAK LANE`
#> [1] "N3"                     "1010 THOUSAND OAK LANE"
#> 
#> $`837P_EX4_medicare_secondary_cob`$N4MAYN
#> [1] "N4"    "MAYN"  "PA"    "17089"
#> 
#> $`837P_EX4_medicare_secondary_cob`$DMGD8
#> [1] "DMG"      "D8"       "19560110" "M"       
#> 
#> $`837P_EX4_medicare_secondary_cob`$NM1PR
#>  [1] "NM1"                   "PR"                    "2"                    
#>  [4] "MEDICARE PENNSYLVANIA" NA                      NA                     
#>  [7] NA                      NA                      "PI"                   
#> [10] "10234"                
#> 
#> $`837P_EX4_medicare_secondary_cob`$`N35232 MAYNE AVENUE`
#> [1] "N3"                "5232 MAYNE AVENUE"
#> 
#> $`837P_EX4_medicare_secondary_cob`$N4LYGHT
#> [1] "N4"    "LYGHT" "PA"    "17009"
#> 
#> $`837P_EX4_medicare_secondary_cob`[[23]]
#>  [1] "CLM"        "101KEN6055" "120"        NA           NA          
#>  [6] "11>B>1"     "Y"          "A"          "Y"          "Y"         
#> [11] "P"         
#> 
#> $`837P_EX4_medicare_secondary_cob`[[24]]
#> [1] "HI"       "BK>71516" "BF>71906"
#> 
#> $`837P_EX4_medicare_secondary_cob`[[25]]
#> [1] "NM1"   "DN"    "1"     "BRYHT" "LEE"   "T"    
#> 
#> $`837P_EX4_medicare_secondary_cob`[[26]]
#> [1] "REF"    "1G"     "B01010"
#> 
#> $`837P_EX4_medicare_secondary_cob`[[27]]
#>  [1] "NM1"        "82"         "1"          "HENZES"     "JACK"      
#>  [6] NA           NA           NA           "XX"         "9090909090"
#> 
#> $`837P_EX4_medicare_secondary_cob`[[28]]
#> [1] "PRV"        "PE"         "PXC"        "207X00000X"
#> 
#> $`837P_EX4_medicare_secondary_cob`[[29]]
#> [1] "REF"       "G2"        "110102CCC"
#> 
#> $`837P_EX4_medicare_secondary_cob`[[30]]
#>  [1] "SBR"      "P"        "01"       NA         "COMMERCE" NA        
#>  [7] NA         NA         NA         "CI"      
#> 
#> $`837P_EX4_medicare_secondary_cob`[[31]]
#> [1] "AMT" "D"   "80" 
#> 
#> $`837P_EX4_medicare_secondary_cob`[[32]]
#> [1] "AMT" "A8"  "15" 
#> 
#> $`837P_EX4_medicare_secondary_cob`[[33]]
#> [1] "OI" NA   NA   "Y"  "P"  NA   "Y" 
#> 
#> $`837P_EX4_medicare_secondary_cob`[[34]]
#>  [1] "NM1"           "IL"            "1"             "MEDYUM"       
#>  [5] "CAROL"         NA              NA              NA             
#>  [9] "MI"            "COM188-404777"
#> 
#> $`837P_EX4_medicare_secondary_cob`[[35]]
#> [1] "N3"        "PO BOX 45"
#> 
#> $`837P_EX4_medicare_secondary_cob`[[36]]
#> [1] "N4"    "MAYN"  "PA"    "17089"
#> 
#> $`837P_EX4_medicare_secondary_cob`[[37]]
#>  [1] "NM1"      "PR"       "2"        "COMMERCE" NA         NA        
#>  [7] NA         NA         "PI"       "59999"   
#> 
#> $`837P_EX4_medicare_secondary_cob`[[38]]
#> [1] "LX" "1" 
#> 
#> $`837P_EX4_medicare_secondary_cob`[[39]]
#> [1] "SV1"         "HC>99203>25" "120"         "UN"          "1"          
#> [6] NA            NA            "1>2"        
#> 
#> $`837P_EX4_medicare_secondary_cob`[[40]]
#> [1] "DTP"      "472"      "D8"       "20050119"
#> 
#> $`837P_EX4_medicare_secondary_cob`[[41]]
#> [1] "SVD"         "59999"       "80"          "HC>99203>25" NA           
#> [6] "1"          
#> 
#> $`837P_EX4_medicare_secondary_cob`[[42]]
#> [1] "CAS" "CO"  "42"  "25" 
#> 
#> $`837P_EX4_medicare_secondary_cob`[[43]]
#> [1] "CAS" "PR"  "2"   "15" 
#> 
#> $`837P_EX4_medicare_secondary_cob`[[44]]
#> [1] "DTP"      "573"      "D8"       "20050128"
#> 
#> $`837P_EX4_medicare_secondary_cob`$SE
#> [1] "SE"   "43"   "0002"
#> 
#> $`837P_EX4_medicare_secondary_cob`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`837P_EX4_medicare_secondary_cob`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`837P_EX5_ambulance`
#> $`837P_EX5_ambulance`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "231106"    "1422"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`837P_EX5_ambulance`$GS
#> [1] "GS"           "HC"           "SENDERGS"     "RECEIVERGS"   "20231106"    
#> [6] "142212"       "000000001"    "X"            "005010X222A1"
#> 
#> $`837P_EX5_ambulance`$ST
#> [1] "ST"           "837"          "000017712"    "005010X222A1"
#> 
#> $`837P_EX5_ambulance`$BHT
#> [1] "BHT"       "0019"      "00"        "000017712" "20050208"  "1112"     
#> [7] "CH"       
#> 
#> $`837P_EX5_ambulance`$NM141
#>  [1] "NM1"                   "41"                    "2"                    
#>  [4] "AAA AMBULANCE SERVICE" NA                      NA                     
#>  [7] NA                      NA                      "46"                   
#> [10] "376985369"            
#> 
#> $`837P_EX5_ambulance`$PERIC
#> [1] "PER"        "IC"         "LISA SMITH" "TE"         "3037752536"
#> 
#> $`837P_EX5_ambulance`$NM140
#>  [1] "NM1"        "40"         "2"          "MEDICARE B" NA          
#>  [6] NA           NA           NA           "46"         "123245"    
#> 
#> $`837P_EX5_ambulance`$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $`837P_EX5_ambulance`$PRVBI
#> [1] "PRV"        "BI"         "PXC"        "3416L0300X"
#> 
#> $`837P_EX5_ambulance`$NM185
#>  [1] "NM1"                   "85"                    "2"                    
#>  [4] "AAA AMBULANCE SERVICE" NA                      NA                     
#>  [7] NA                      NA                      "XX"                   
#> [10] "2366554859"           
#> 
#> $`837P_EX5_ambulance`$`N312202 AIRPORT WAY`
#> [1] "N3"                "12202 AIRPORT WAY"
#> 
#> $`837P_EX5_ambulance`$N4BROOMFIELD
#> [1] "N4"         "BROOMFIELD" "CO"         "800210021" 
#> 
#> $`837P_EX5_ambulance`$REFEI
#> [1] "REF"       "EI"        "376985369"
#> 
#> $`837P_EX5_ambulance`$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $`837P_EX5_ambulance`$SBRP
#>  [1] "SBR" "P"   "18"  NA    NA    NA    NA    NA    NA    "MB" 
#> 
#> $`837P_EX5_ambulance`$NM1IL
#>  [1] "NM1"        "IL"         "1"          "JONES"      "SARAH"     
#>  [6] "A"          NA           NA           "MI"         "012345678A"
#> 
#> $`837P_EX5_ambulance`$`N31129 REINDEER ROAD`
#> [1] "N3"                 "1129 REINDEER ROAD"
#> 
#> $`837P_EX5_ambulance`$N4CARR
#> [1] "N4"    "CARR"  "CO"    "80612"
#> 
#> $`837P_EX5_ambulance`$DMGD8
#> [1] "DMG"      "D8"       "19630729" "F"       
#> 
#> $`837P_EX5_ambulance`$NM1PR
#>  [1] "NM1"             "PR"              "2"               "MEDICARE PART B"
#>  [5] NA                NA                NA                NA               
#>  [9] "PI"              "123245"         
#> 
#> $`837P_EX5_ambulance`$`N3PO BOX 3543`
#> [1] "N3"          "PO BOX 3543"
#> 
#> $`837P_EX5_ambulance`$N4BALTIMORE
#> [1] "N4"        "BALTIMORE" "MD"        "666013543"
#> 
#> $`837P_EX5_ambulance`[[23]]
#>  [1] "CLM"    "051068" "766.50" NA       NA       "41>B>1" "Y"      "A"     
#>  [9] "Y"      "Y"      "P"      "OA"    
#> 
#> $`837P_EX5_ambulance`[[24]]
#> [1] "DTP"      "439"      "D8"       "20050208"
#> 
#> $`837P_EX5_ambulance`[[25]]
#>  [1] "CR1"                "LB"                 "275"               
#>  [4] NA                   "A"                  "DH"                
#>  [7] "21"                 NA                   NA                  
#> [10] NA                   "PATIENT IMOBILIZED"
#> 
#> $`837P_EX5_ambulance`[[26]]
#> [1] "CRC" "07"  "Y"   "04"  "06"  "09" 
#> 
#> $`837P_EX5_ambulance`[[27]]
#> [1] "CRC" "07"  "N"   "05"  "07"  "08" 
#> 
#> $`837P_EX5_ambulance`[[28]]
#> [1] "HI"       "BK>8628"  "BF>E8888" "BF>9592"  "BF>8540" 
#> 
#> $`837P_EX5_ambulance`[[29]]
#> [1] "NM1" "PW"  "2"  
#> 
#> $`837P_EX5_ambulance`[[30]]
#> [1] "N3"                 "1129 REINDEER ROAD"
#> 
#> $`837P_EX5_ambulance`[[31]]
#> [1] "N4"    "CARR"  "CO"    "80612"
#> 
#> $`837P_EX5_ambulance`[[32]]
#> [1] "NM1" "45"  "2"  
#> 
#> $`837P_EX5_ambulance`[[33]]
#> [1] "N3"               "10005 BANNOCK ST"
#> 
#> $`837P_EX5_ambulance`[[34]]
#> [1] "N4"       "CHEYENNE" "WY"       "82009"   
#> 
#> $`837P_EX5_ambulance`[[35]]
#> [1] "LX" "1" 
#> 
#> $`837P_EX5_ambulance`[[36]]
#>  [1] "SV1"         "HC>A0427>RH" "700"         "UN"          "1"          
#>  [6] NA            NA            "1>2>3>4"     NA            "Y"          
#> 
#> $`837P_EX5_ambulance`[[37]]
#> [1] "DTP"      "472"      "D8"       "20050208"
#> 
#> $`837P_EX5_ambulance`[[38]]
#> [1] "QTY" "PT"  "2"  
#> 
#> $`837P_EX5_ambulance`[[39]]
#> [1] "REF"  "6R"   "1001"
#> 
#> $`837P_EX5_ambulance`[[40]]
#> [1] "NTE"               "ADD"               "CARDIAC EMERGENCY"
#> 
#> $`837P_EX5_ambulance`[[41]]
#> [1] "LX" "2" 
#> 
#> $`837P_EX5_ambulance`[[42]]
#>  [1] "SV1"         "HC>A0425>RH" "8.20"        "UN"          "21"         
#>  [6] NA            NA            "1>2>3>4"     NA            "Y"          
#> 
#> $`837P_EX5_ambulance`[[43]]
#> [1] "DTP"      "472"      "D8"       "20050208"
#> 
#> $`837P_EX5_ambulance`[[44]]
#> [1] "QTY" "PT"  "2"  
#> 
#> $`837P_EX5_ambulance`[[45]]
#> [1] "REF"  "6R"   "1002"
#> 
#> $`837P_EX5_ambulance`[[46]]
#> [1] "LX" "3" 
#> 
#> $`837P_EX5_ambulance`[[47]]
#>  [1] "SV1"         "HC>A0422>RH" "46"          "UN"          "1"          
#>  [6] NA            NA            "1>2>3>4"     NA            "Y"          
#> 
#> $`837P_EX5_ambulance`[[48]]
#> [1] "DTP"      "472"      "D8"       "20050208"
#> 
#> $`837P_EX5_ambulance`[[49]]
#> [1] "REF"  "6R"   "1003"
#> 
#> $`837P_EX5_ambulance`[[50]]
#> [1] "LX" "4" 
#> 
#> $`837P_EX5_ambulance`[[51]]
#>  [1] "SV1"         "HC>A0382>RH" "12.30"       "UN"          "1"          
#>  [6] NA            NA            "1>2>3>4"     NA            "Y"          
#> 
#> $`837P_EX5_ambulance`[[52]]
#> [1] "DTP"      "472"      "D8"       "20050208"
#> 
#> $`837P_EX5_ambulance`[[53]]
#> [1] "REF"  "6R"   "1004"
#> 
#> $`837P_EX5_ambulance`$SE
#> [1] "SE"        "52"        "000017712"
#> 
#> $`837P_EX5_ambulance`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`837P_EX5_ambulance`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`837P_EX6_chiropractic`
#> $`837P_EX6_chiropractic`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "231106"    "1422"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`837P_EX6_chiropractic`$GS
#> [1] "GS"           "HC"           "SENDERGS"     "RECEIVERGS"   "20231106"    
#> [6] "142242"       "000000001"    "X"            "005010X222A1"
#> 
#> $`837P_EX6_chiropractic`$ST
#> [1] "ST"           "837"          "3701"         "005010X222A1"
#> 
#> $`837P_EX6_chiropractic`$BHT
#> [1] "BHT"      "0019"     "00"       "007227"   "20050215" "075420"   "CH"      
#> 
#> $`837P_EX6_chiropractic`$NM141
#>  [1] "NM1"         "41"          "2"           "DAVID GREEN" NA           
#>  [6] NA            NA            NA            "46"          "S01057"     
#> 
#> $`837P_EX6_chiropractic`$PERIC
#> [1] "PER"         "IC"          "KATHY SMITH" "TE"          "4105558888" 
#> 
#> $`837P_EX6_chiropractic`$NM140
#>  [1] "NM1"                      "40"                      
#>  [3] "2"                        "MEDICARE PART B MARYLAND"
#>  [5] NA                         NA                        
#>  [7] NA                         NA                        
#>  [9] "46"                       "12345"                   
#> 
#> $`837P_EX6_chiropractic`$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $`837P_EX6_chiropractic`$NM185
#>  [1] "NM1"        "85"         "1"          "GREENE"     "DAVID"     
#>  [6] "M"          NA           NA           "XX"         "1234567890"
#> 
#> $`837P_EX6_chiropractic`$`N31264 OAKWOOD AVE`
#> [1] "N3"               "1264 OAKWOOD AVE"
#> 
#> $`837P_EX6_chiropractic`$N4BALTIMORE
#> [1] "N4"        "BALTIMORE" "MD"        "21236"    
#> 
#> $`837P_EX6_chiropractic`$REFEI
#> [1] "REF"       "EI"        "987654321"
#> 
#> $`837P_EX6_chiropractic`$PERIC
#> [1] "PER"        "IC"         "DR"         "TE"         "4105551212"
#> 
#> $`837P_EX6_chiropractic`$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $`837P_EX6_chiropractic`$SBRP
#>  [1] "SBR" "P"   "18"  NA    NA    NA    NA    NA    NA    "MB" 
#> 
#> $`837P_EX6_chiropractic`$NM1IL
#>  [1] "NM1"        "IL"         "1"          "WILLIAMSON" "MATTHEW"   
#>  [6] "J"          NA           NA           "MI"         "123456789A"
#> 
#> $`837P_EX6_chiropractic`$`N3128 BROADCREEK`
#> [1] "N3"             "128 BROADCREEK"
#> 
#> $`837P_EX6_chiropractic`$N4BALTIMORE
#> [1] "N4"        "BALTIMORE" "MD"        "21234"    
#> 
#> $`837P_EX6_chiropractic`$DMGD8
#> [1] "DMG"      "D8"       "19250110" "M"       
#> 
#> $`837P_EX6_chiropractic`$NM1PR
#>  [1] "NM1"                      "PR"                      
#>  [3] "2"                        "MEDICARE PART B MARYLAND"
#>  [5] NA                         NA                        
#>  [7] NA                         NA                        
#>  [9] "PI"                       "C12345"                  
#> 
#> $`837P_EX6_chiropractic`[[21]]
#>  [1] "CLM"     "125WILL" "145.5"   NA        NA        "11>B>1"  "Y"      
#>  [8] "A"       "Y"       "Y"      
#> 
#> $`837P_EX6_chiropractic`[[22]]
#> [1] "DTP"      "454"      "D8"       "20050115"
#> 
#> $`837P_EX6_chiropractic`[[23]]
#> [1] "DTP"      "453"      "D8"       "20050110"
#> 
#> $`837P_EX6_chiropractic`[[24]]
#> [1] "DTP"      "455"      "D8"       "20050113"
#> 
#> $`837P_EX6_chiropractic`[[25]]
#>  [1] "CR2"                         NA                           
#>  [3] NA                            NA                           
#>  [5] NA                            NA                           
#>  [7] NA                            NA                           
#>  [9] "A"                           NA                           
#> [11] "CHRONIC PAIN AND DISCOMFORT"
#> 
#> $`837P_EX6_chiropractic`[[26]]
#> [1] "HI"      "BK>7215"
#> 
#> $`837P_EX6_chiropractic`[[27]]
#> [1] "LX" "1" 
#> 
#> $`837P_EX6_chiropractic`[[28]]
#> [1] "SV1"      "HC>98940" "145.5"    "UN"       "1"        NA         NA        
#> [8] "1"       
#> 
#> $`837P_EX6_chiropractic`[[29]]
#> [1] "DTP"      "472"      "D8"       "20050215"
#> 
#> $`837P_EX6_chiropractic`[[30]]
#> [1] "REF" "6R"  "01" 
#> 
#> $`837P_EX6_chiropractic`$SE
#> [1] "SE"   "29"   "3701"
#> 
#> $`837P_EX6_chiropractic`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`837P_EX6_chiropractic`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`837P_EX7_oxygen`
#> $`837P_EX7_oxygen`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "231106"    "1423"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`837P_EX7_oxygen`$GS
#> [1] "GS"           "HC"           "SENDERGS"     "RECEIVERGS"   "20231106"    
#> [6] "142340"       "000000001"    "X"            "005010X222A1"
#> 
#> $`837P_EX7_oxygen`$ST
#> [1] "ST"           "837"          "0001"         "005010X222A1"
#> 
#> $`837P_EX7_oxygen`$BHT
#> [1] "BHT"      "0019"     "00"       "16"       "20050326" "1036"     "CH"      
#> 
#> $`837P_EX7_oxygen`$NM141
#>  [1] "NM1"                   "41"                    "2"                    
#>  [4] "OXYGEN SUPPLY COMPANY" NA                      NA                     
#>  [7] NA                      NA                      "46"                   
#> [10] "ABC11111"             
#> 
#> $`837P_EX7_oxygen`$PERIC
#> [1] "PER"                 "IC"                  "BONNIE"             
#> [4] "TE"                  "8125551111"          "EM"                 
#> [7] "HELPDESK@OXYGEN.COM"
#> 
#> $`837P_EX7_oxygen`$NM140
#>  [1] "NM1"           "40"            "2"             "DMERC CARRIER"
#>  [5] NA              NA              NA              NA             
#>  [9] "46"            "99999"        
#> 
#> $`837P_EX7_oxygen`$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $`837P_EX7_oxygen`$NM185
#>  [1] "NM1"                   "85"                    "2"                    
#>  [4] "OXYGEN SUPPLY COMPANY" NA                      NA                     
#>  [7] NA                      NA                      "XX"                   
#> [10] "9992233334"           
#> 
#> $`837P_EX7_oxygen`$`N31800 EAST RIDGE DRIVE`
#> [1] "N3"                    "1800 EAST RIDGE DRIVE"
#> 
#> $`837P_EX7_oxygen`$N4RICHMOND
#> [1] "N4"       "RICHMOND" "IN"       "46224"   
#> 
#> $`837P_EX7_oxygen`$REFEI
#> [1] "REF"       "EI"        "389999999"
#> 
#> $`837P_EX7_oxygen`$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $`837P_EX7_oxygen`$SBRP
#>  [1] "SBR" "P"   "18"  NA    NA    NA    NA    NA    NA    "MB" 
#> 
#> $`837P_EX7_oxygen`$NM1IL
#>  [1] "NM1"        "IL"         "1"          "SMITH"      "TERRY"     
#>  [6] NA           NA           NA           "MI"         "111222333A"
#> 
#> $`837P_EX7_oxygen`$`N3121 SOUTH ST`
#> [1] "N3"           "121 SOUTH ST"
#> 
#> $`837P_EX7_oxygen`$N4RICHMOND
#> [1] "N4"       "RICHMOND" "IN"       "46236"   
#> 
#> $`837P_EX7_oxygen`$DMGD8
#> [1] "DMG"      "D8"       "19380105" "F"       
#> 
#> $`837P_EX7_oxygen`$NM1PR
#>  [1] "NM1"           "PR"            "2"             "DMERC CARRIER"
#>  [5] NA              NA              NA              NA             
#>  [9] "PI"            "99999"        
#> 
#> $`837P_EX7_oxygen`[[20]]
#>  [1] "CLM"           "R03996273 #01" "520.24"        NA             
#>  [5] NA              "11>B>1"        "Y"             "A"            
#>  [9] "Y"             "Y"            
#> 
#> $`837P_EX7_oxygen`[[21]]
#> [1] "HI"       "BK>496"   "BF>51881" "BF>2859" 
#> 
#> $`837P_EX7_oxygen`[[22]]
#> [1] "LX" "1" 
#> 
#> $`837P_EX7_oxygen`[[23]]
#> [1] "SV1"         "HC>E1390>RR" "461.1"       "UN"          "1"          
#> [6] NA            NA            "1>2"        
#> 
#> $`837P_EX7_oxygen`[[24]]
#> [1] "PWK" "CT"  "AD" 
#> 
#> $`837P_EX7_oxygen`[[25]]
#> [1] "CR3" "R"   "MO"  "99" 
#> 
#> $`837P_EX7_oxygen`[[26]]
#> [1] "DTP"               "472"               "RD8"              
#> [4] "20050321-20050321"
#> 
#> $`837P_EX7_oxygen`[[27]]
#> [1] "DTP"      "607"      "D8"       "20050321"
#> 
#> $`837P_EX7_oxygen`[[28]]
#> [1] "DTP"      "463"      "D8"       "20040321"
#> 
#> $`837P_EX7_oxygen`[[29]]
#> [1] "DTP"      "461"      "D8"       "20050321"
#> 
#> $`837P_EX7_oxygen`[[30]]
#>  [1] "NM1"        "DK"         "1"          "WILSON"     "LARRY"     
#>  [6] NA           NA           NA           "XX"         "5555511111"
#> 
#> $`837P_EX7_oxygen`[[31]]
#> [1] "N3"                  "1212 NORTH MERIDIAN"
#> 
#> $`837P_EX7_oxygen`[[32]]
#> [1] "N4"       "RICHMOND" "IN"       "46223"   
#> 
#> $`837P_EX7_oxygen`[[33]]
#> [1] "REF"    "1G"     "X99999"
#> 
#> $`837P_EX7_oxygen`[[34]]
#> [1] "PER"        "IC"         "LEE"        "TE"         "5554446666"
#> 
#> $`837P_EX7_oxygen`[[35]]
#> [1] "LQ"    "UT"    "04.03"
#> 
#> $`837P_EX7_oxygen`[[36]]
#> [1] "FRM" "1A"  NA    "056"
#> 
#> $`837P_EX7_oxygen`[[37]]
#> [1] "FRM"      "1C"       NA         "20050228"
#> 
#> $`837P_EX7_oxygen`[[38]]
#> [1] "FRM" "2"   NA    "1"  
#> 
#> $`837P_EX7_oxygen`[[39]]
#> [1] "FRM" "3"   NA    "1"  
#> 
#> $`837P_EX7_oxygen`[[40]]
#> [1] "FRM" "4"   "Y"  
#> 
#> $`837P_EX7_oxygen`[[41]]
#> [1] "FRM" "5"   NA    "2"  
#> 
#> $`837P_EX7_oxygen`[[42]]
#> [1] "FRM" "7"   "Y"  
#> 
#> $`837P_EX7_oxygen`[[43]]
#> [1] "FRM" "8"   "N"  
#> 
#> $`837P_EX7_oxygen`[[44]]
#> [1] "FRM" "9"   "Y"  
#> 
#> $`837P_EX7_oxygen`[[45]]
#> [1] "LX" "2" 
#> 
#> $`837P_EX7_oxygen`[[46]]
#> [1] "SV1"         "HC>E0431>RR" "59.14"       "UN"          "1"          
#> [6] NA            NA            "1>2"        
#> 
#> $`837P_EX7_oxygen`[[47]]
#> [1] "PWK" "CT"  "AD" 
#> 
#> $`837P_EX7_oxygen`[[48]]
#> [1] "CR3" "R"   "MO"  "99" 
#> 
#> $`837P_EX7_oxygen`[[49]]
#> [1] "DTP"               "472"               "RD8"              
#> [4] "20050321-20050321"
#> 
#> $`837P_EX7_oxygen`[[50]]
#> [1] "DTP"      "607"      "D8"       "20050321"
#> 
#> $`837P_EX7_oxygen`[[51]]
#> [1] "DTP"      "463"      "D8"       "20040321"
#> 
#> $`837P_EX7_oxygen`[[52]]
#> [1] "DTP"      "461"      "D8"       "20050321"
#> 
#> $`837P_EX7_oxygen`[[53]]
#>  [1] "NM1"        "DK"         "1"          "WILSON"     "LARRY"     
#>  [6] NA           NA           NA           "XX"         "5555511111"
#> 
#> $`837P_EX7_oxygen`[[54]]
#> [1] "N3"                  "1212 NORTH MERIDIAN"
#> 
#> $`837P_EX7_oxygen`[[55]]
#> [1] "N4"       "RICHMOND" "IN"       "46223"   
#> 
#> $`837P_EX7_oxygen`[[56]]
#> [1] "REF"    "1G"     "X99999"
#> 
#> $`837P_EX7_oxygen`[[57]]
#> [1] "PER"        "IC"         "LEE"        "TE"         "5554446666"
#> 
#> $`837P_EX7_oxygen`[[58]]
#> [1] "LQ"    "UT"    "04.03"
#> 
#> $`837P_EX7_oxygen`[[59]]
#> [1] "FRM" "1A"  NA    "056"
#> 
#> $`837P_EX7_oxygen`[[60]]
#> [1] "FRM"      "1C"       NA         "20050228"
#> 
#> $`837P_EX7_oxygen`[[61]]
#> [1] "FRM" "2"   NA    "1"  
#> 
#> $`837P_EX7_oxygen`[[62]]
#> [1] "FRM" "3"   NA    "1"  
#> 
#> $`837P_EX7_oxygen`[[63]]
#> [1] "FRM" "4"   "Y"  
#> 
#> $`837P_EX7_oxygen`[[64]]
#> [1] "FRM" "5"   NA    "2"  
#> 
#> $`837P_EX7_oxygen`[[65]]
#> [1] "FRM" "7"   "Y"  
#> 
#> $`837P_EX7_oxygen`[[66]]
#> [1] "FRM" "8"   "N"  
#> 
#> $`837P_EX7_oxygen`[[67]]
#> [1] "FRM" "9"   "Y"  
#> 
#> $`837P_EX7_oxygen`$SE
#> [1] "SE"   "66"   "0001"
#> 
#> $`837P_EX7_oxygen`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`837P_EX7_oxygen`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`837P_EX8_wheelchair`
#> $`837P_EX8_wheelchair`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "231106"    "1424"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`837P_EX8_wheelchair`$GS
#> [1] "GS"           "HC"           "SENDERGS"     "RECEIVERGS"   "20231106"    
#> [6] "142406"       "000000001"    "X"            "005010X222A1"
#> 
#> $`837P_EX8_wheelchair`$ST
#> [1] "ST"           "837"          "112233"       "005010X222A1"
#> 
#> $`837P_EX8_wheelchair`$BHT
#> [1] "BHT"      "0019"     "00"       "16"       "20050326" "1036"     "CH"      
#> 
#> $`837P_EX8_wheelchair`$NM141
#>  [1] "NM1"                 "41"                  "2"                  
#>  [4] "XYZ WHEELCHAIRS INC" NA                    NA                   
#>  [7] NA                    NA                    "46"                 
#> [10] "ABC55"              
#> 
#> $`837P_EX8_wheelchair`$PERIC
#> [1] "PER"        "IC"         "JANE"       "TE"         "2225551111"
#> 
#> $`837P_EX8_wheelchair`$NM140
#>  [1] "NM1"           "40"            "2"             "DMERC CARRIER"
#>  [5] NA              NA              NA              NA             
#>  [9] "46"            "99999"        
#> 
#> $`837P_EX8_wheelchair`$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $`837P_EX8_wheelchair`$NM185
#>  [1] "NM1"                "85"                 "2"                 
#>  [4] "XYZ WHEELCHAIR INC" NA                   NA                  
#>  [7] NA                   NA                   "XX"                
#> [10] "7778889999"        
#> 
#> $`837P_EX8_wheelchair`$`N31440 NORTH STREET`
#> [1] "N3"                "1440 NORTH STREET"
#> 
#> $`837P_EX8_wheelchair`$N4LAFAYETTE
#> [1] "N4"        "LAFAYETTE" "IN"        "47904"    
#> 
#> $`837P_EX8_wheelchair`$REFEI
#> [1] "REF"       "EI"        "123567989"
#> 
#> $`837P_EX8_wheelchair`$REF1G
#> [1] "REF"        "1G"         "0426960001"
#> 
#> $`837P_EX8_wheelchair`$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $`837P_EX8_wheelchair`$SBRP
#>  [1] "SBR" "P"   "18"  NA    NA    NA    NA    NA    NA    "MB" 
#> 
#> $`837P_EX8_wheelchair`$PATNA
#> [1] "PAT" NA    NA    NA    NA    NA    NA    "01"  "155"
#> 
#> $`837P_EX8_wheelchair`$NM1IL
#>  [1] "NM1"        "IL"         "1"          "SMITH"      "JAMES"     
#>  [6] NA           NA           NA           "MI"         "987654321A"
#> 
#> $`837P_EX8_wheelchair`$`N312 MAIN ST`
#> [1] "N3"         "12 MAIN ST"
#> 
#> $`837P_EX8_wheelchair`$N4FRANKFORT
#> [1] "N4"        "FRANKFORT" "IN"        "46209"    
#> 
#> $`837P_EX8_wheelchair`$DMGD8
#> [1] "DMG"      "D8"       "19201023" "M"       
#> 
#> $`837P_EX8_wheelchair`$NM1PR
#>  [1] "NM1"           "PR"            "2"             "DMERC CARRIER"
#>  [5] NA              NA              NA              NA             
#>  [9] "PI"            "99999"        
#> 
#> $`837P_EX8_wheelchair`[[22]]
#>  [1] "CLM"    "SMI123" "75"     NA       NA       "12>B>1" "Y"      "A"     
#>  [9] "Y"      "Y"     
#> 
#> $`837P_EX8_wheelchair`[[23]]
#> [1] "HI"      "BK>436"  "BF>3449"
#> 
#> $`837P_EX8_wheelchair`[[24]]
#> [1] "LX" "1" 
#> 
#> $`837P_EX8_wheelchair`[[25]]
#> [1] "SV1"               "HC>K0001>RR>KH>BR" "75"               
#> [4] "UN"                "1"                 NA                 
#> [7] NA                  "1>2"              
#> 
#> $`837P_EX8_wheelchair`[[26]]
#> [1] "PWK" "CT"  "AD" 
#> 
#> $`837P_EX8_wheelchair`[[27]]
#> [1] "CR3" "I"   "MO"  "99" 
#> 
#> $`837P_EX8_wheelchair`[[28]]
#> [1] "DTP"               "472"               "RD8"              
#> [4] "20050321-20050321"
#> 
#> $`837P_EX8_wheelchair`[[29]]
#> [1] "DTP"      "463"      "D8"       "20040321"
#> 
#> $`837P_EX8_wheelchair`[[30]]
#> [1] "DTP"      "461"      "D8"       "20050321"
#> 
#> $`837P_EX8_wheelchair`[[31]]
#> [1] "MEA" "TR"  "HT"  "70" 
#> 
#> $`837P_EX8_wheelchair`[[32]]
#>  [1] "NM1"        "DK"         "1"          "WILSON"     "RANDALL"   
#>  [6] NA           NA           NA           "XX"         "1111155555"
#> 
#> $`837P_EX8_wheelchair`[[33]]
#> [1] "N3"                        "1226 WEST RAILROAD STREET"
#> 
#> $`837P_EX8_wheelchair`[[34]]
#> [1] "N4"        "LAFAYETTE" "IN"        "47905"    
#> 
#> $`837P_EX8_wheelchair`[[35]]
#> [1] "REF"    "1G"     "M12345"
#> 
#> $`837P_EX8_wheelchair`[[36]]
#> [1] "PER"        "IC"         "LEE"        "TE"         "7659259999"
#> 
#> $`837P_EX8_wheelchair`[[37]]
#> [1] "LQ"     "UT"     "02.03B"
#> 
#> $`837P_EX8_wheelchair`[[38]]
#> [1] "FRM" "1"   "Y"  
#> 
#> $`837P_EX8_wheelchair`[[39]]
#> [1] "FRM" "2"   "N"  
#> 
#> $`837P_EX8_wheelchair`[[40]]
#> [1] "FRM" "3"   "N"  
#> 
#> $`837P_EX8_wheelchair`[[41]]
#> [1] "FRM" "4"   "N"  
#> 
#> $`837P_EX8_wheelchair`[[42]]
#> [1] "FRM" "5"   NA    "8"  
#> 
#> $`837P_EX8_wheelchair`[[43]]
#> [1] "FRM" "8"   "N"  
#> 
#> $`837P_EX8_wheelchair`[[44]]
#> [1] "FRM" "9"   "Y"  
#> 
#> $`837P_EX8_wheelchair`$SE
#> [1] "SE"     "43"     "112233"
#> 
#> $`837P_EX8_wheelchair`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`837P_EX8_wheelchair`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $`837P_EX9_anesthesia`
#> $`837P_EX9_anesthesia`$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "ZZ"       
#>  [7] "SENDER"    "ZZ"        "RECEIVER"  "231106"    "1424"      "^"        
#> [13] "00501"     "000000001" "0"         "T"         ">"        
#> 
#> $`837P_EX9_anesthesia`$GS
#> [1] "GS"           "HC"           "SENDERGS"     "RECEIVERGS"   "20231106"    
#> [6] "142432"       "000000001"    "X"            "005010X222A1"
#> 
#> $`837P_EX9_anesthesia`$ST
#> [1] "ST"           "837"          "0001"         "005010X222A1"
#> 
#> $`837P_EX9_anesthesia`$BHT
#> [1] "BHT"      "0019"     "00"       "0123"     "20050117" "1023"     "CH"      
#> 
#> $`837P_EX9_anesthesia`$NM141
#>  [1] "NM1"                    "41"                     "2"                     
#>  [4] "PROVIDER MEDICAL GROUP" NA                       NA                      
#>  [7] NA                       NA                       "46"                    
#> [10] "N305"                  
#> 
#> $`837P_EX9_anesthesia`$PERIC
#> [1] "PER"        "IC"         "NINA"       "TE"         "6155551212"
#> [6] "EX"         "911"       
#> 
#> $`837P_EX9_anesthesia`$NM140
#>  [1] "NM1"       "40"        "2"         "ABC PAYER" NA          NA         
#>  [7] NA          NA          "46"        "05440"    
#> 
#> $`837P_EX9_anesthesia`$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $`837P_EX9_anesthesia`$NM185
#>  [1] "NM1"                    "85"                     "2"                     
#>  [4] "PROVIDER MEDICAL GROUP" NA                       NA                      
#>  [7] NA                       NA                       "XX"                    
#> [10] "2366554859"            
#> 
#> $`837P_EX9_anesthesia`$`N31234 WEST END AVE`
#> [1] "N3"                "1234 WEST END AVE"
#> 
#> $`837P_EX9_anesthesia`$N4NASHVILLE
#> [1] "N4"        "NASHVILLE" "TN"        "37232"    
#> 
#> $`837P_EX9_anesthesia`$REFEI
#> [1] "REF"       "EI"        "756473826"
#> 
#> $`837P_EX9_anesthesia`$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $`837P_EX9_anesthesia`$SBRP
#>  [1] "SBR" "P"   "18"  NA    NA    NA    NA    NA    NA    "MB" 
#> 
#> $`837P_EX9_anesthesia`$NM1IL
#>  [1] "NM1"        "IL"         "1"          "JONES"      "MARGARET"  
#>  [6] NA           NA           NA           "MI"         "123456789A"
#> 
#> $`837P_EX9_anesthesia`$`N3123 RAINBOW ROAD`
#> [1] "N3"               "123 RAINBOW ROAD"
#> 
#> $`837P_EX9_anesthesia`$N4NASHVILLE
#> [1] "N4"        "NASHVILLE" "TN"        "37232"    
#> 
#> $`837P_EX9_anesthesia`$DMGD8
#> [1] "DMG"      "D8"       "19740303" "F"       
#> 
#> $`837P_EX9_anesthesia`$NM1PR
#>  [1] "NM1"       "PR"        "2"         "ABC PAYER" NA          NA         
#>  [7] NA          NA          "PI"        "05440"    
#> 
#> $`837P_EX9_anesthesia`[[20]]
#>  [1] "CLM"       "153829140" "827"       NA          NA          "22>B>1"   
#>  [7] "Y"         "A"         "Y"         "Y"        
#> 
#> $`837P_EX9_anesthesia`[[21]]
#> [1] "HI"       "BK>36616"
#> 
#> $`837P_EX9_anesthesia`[[22]]
#>  [1] "NM1"        "82"         "1"          "TOWNSEND"   "JACOB"     
#>  [6] "E"          NA           NA           "XX"         "5678912345"
#> 
#> $`837P_EX9_anesthesia`[[23]]
#> [1] "PRV"        "PE"         "PXC"        "207L00000X"
#> 
#> $`837P_EX9_anesthesia`[[24]]
#> [1] "REF"     "G2"      "9741234"
#> 
#> $`837P_EX9_anesthesia`[[25]]
#>  [1] "NM1"              "77"               "2"                "PROVIDER OP HOSP"
#>  [5] NA                 NA                 NA                 NA                
#>  [9] "XX"               "432198765"       
#> 
#> $`837P_EX9_anesthesia`[[26]]
#> [1] "N3"             "345 MAIN DRIVE"
#> 
#> $`837P_EX9_anesthesia`[[27]]
#> [1] "N4"        "NASHVILLE" "TN"        "37232"    
#> 
#> $`837P_EX9_anesthesia`[[28]]
#> [1] "LX" "1" 
#> 
#> $`837P_EX9_anesthesia`[[29]]
#> [1] "SV1"               "HC>00142>QK>QS>P1" "827"              
#> [4] "MJ"                "61"                NA                 
#> [7] NA                  "1"                
#> 
#> $`837P_EX9_anesthesia`[[30]]
#> [1] "DTP"      "472"      "D8"       "20050112"
#> 
#> $`837P_EX9_anesthesia`$SE
#> [1] "SE"   "29"   "0001"
#> 
#> $`837P_EX9_anesthesia`$GE
#> [1] "GE"        "1"         "000000001"
#> 
#> $`837P_EX9_anesthesia`$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $sample_837P
#> [1] NA
#> 
#> $sample_837_0
#> $sample_837_0$ISA
#>  [1] "ISA"       "00"        NA          "00"        NA          "01"       
#>  [7] "987654321" "ZZ"        "123456789" "180508"    "0833"      "^"        
#> [13] "00501"     "697773230" "1"         "P"         ":"        
#> 
#> $sample_837_0$GS
#> [1] "GS"            "HC"            "CLEARINGHOUSE" "123456789"    
#> [5] "20180508"      "0833"          "212950697"     "X"            
#> [9] "005010X222A1" 
#> 
#> $sample_837_0$ST
#> [1] "ST"           "837"          "000000001"    "005010X222A1"
#> 
#> $sample_837_0$BHT
#> [1] "BHT"        "0019"       "00"         "7349063984" "20180508"  
#> [6] "0833"       "CH"        
#> 
#> $sample_837_0$NM141
#>  [1] "NM1"               "41"                "2"                
#>  [4] "CLEARINGHOUSE LLC" NA                  NA                 
#>  [7] NA                  NA                  "46"               
#> [10] "987654321"        
#> 
#> $sample_837_0$PERIC
#> [1] "PER"                           "IC"                           
#> [3] "CLEARINGHOUSE CLIENT SERVICES" "TE"                           
#> [5] "5555550000"                    "FX"                           
#> [7] "5555550000"                   
#> 
#> $sample_837_0$NM140
#>  [1] "NM1"       "40"        "2"         "123456789" NA          NA         
#>  [7] NA          NA          "46"        "CHPWA"    
#> 
#> $sample_837_0$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $sample_837_0$NM185
#>  [1] "NM1"                    "85"                     "2"                     
#>  [4] "BH CLINIC OF VANCOUVER" NA                       NA                      
#>  [7] NA                       NA                       "XX"                    
#> [10] "1122334455"            
#> 
#> $sample_837_0$`N312345 MAIN ST`
#> [1] "N3"            "12345 MAIN ST"
#> 
#> $sample_837_0$N4VANCOUVER
#> [1] "N4"        "VANCOUVER" "WA"        "98662"    
#> 
#> $sample_837_0$REFEI
#> [1] "REF"       "EI"        "720000000"
#> 
#> $sample_837_0$PERIC
#> [1] "PER"        "IC"         "CONTACT"    "TE"         "5555550000"
#> 
#> $sample_837_0$NM187
#> [1] "NM1" "87"  "2"  
#> 
#> $sample_837_0$`N3PO BOX 1234`
#> [1] "N3"          "PO BOX 1234"
#> 
#> $sample_837_0$N4VANCOUVER
#> [1] "N4"        "VANCOUVER" "WA"        "986681234"
#> 
#> $sample_837_0$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $sample_837_0$SBRP
#>  [1] "SBR"                         "P"                          
#>  [3] "18"                          NA                           
#>  [5] "COMMUNITY HLTH PLAN OF WASH" NA                           
#>  [7] NA                            NA                           
#>  [9] NA                            "CI"                         
#> 
#> $sample_837_0$NM1IL
#>  [1] "NM1"        "IL"         "1"          "SUBSCRIBER" "JOHN"      
#>  [6] "J"          NA           NA           "MI"         "987321"    
#> 
#> $sample_837_0$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_0$N4TESTCITY
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_837_0$DMGD8
#> [1] "DMG"      "D8"       "19000101" "M"       
#> 
#> $sample_837_0$NM1PR
#>  [1] "NM1"                                 "PR"                                 
#>  [3] "2"                                   "COMMUNITY HEALTH PLAN OF WASHINGTON"
#>  [5] NA                                    NA                                   
#>  [7] NA                                    NA                                   
#>  [9] "PI"                                  "CHPWA"                              
#> 
#> $sample_837_0$NM141
#>  [1] "NM1"               "41"                "2"                
#>  [4] "CLEARINGHOUSE LLC" NA                  NA                 
#>  [7] NA                  NA                  "46"               
#> [10] "987654321"        
#> 
#> $sample_837_0$PERIC
#> [1] "PER"                           "IC"                           
#> [3] "CLEARINGHOUSE CLIENT SERVICES" "TE"                           
#> [5] "5555550000"                    "FX"                           
#> [7] "5555550000"                   
#> 
#> $sample_837_0$NM140
#>  [1] "NM1"       "40"        "2"         "123456789" NA          NA         
#>  [7] NA          NA          "46"        "CHPWA"    
#> 
#> $sample_837_0$HL63
#> [1] "HL" "63" NA   "20" "1" 
#> 
#> $sample_837_0$NM185
#>  [1] "NM1"                    "85"                     "2"                     
#>  [4] "BH CLINIC OF VANCOUVER" NA                       NA                      
#>  [7] NA                       NA                       "XX"                    
#> [10] "1122334455"            
#> 
#> $sample_837_0$`N312345 MAIN ST`
#> [1] "N3"            "12345 MAIN ST"
#> 
#> $sample_837_0$N4VANCOUVER
#> [1] "N4"        "VANCOUVER" "WA"        "98662"    
#> 
#> $sample_837_0$REFEI
#> [1] "REF"       "EI"        "720000000"
#> 
#> $sample_837_0$PERIC
#> [1] "PER"        "IC"         "CONTACT"    "TE"         "5555550000"
#> 
#> $sample_837_0$NM187
#> [1] "NM1" "87"  "2"  
#> 
#> $sample_837_0$`N3PO BOX 1234`
#> [1] "N3"          "PO BOX 1234"
#> 
#> $sample_837_0$N4VANCOUVER
#> [1] "N4"        "VANCOUVER" "WA"        "986681234"
#> 
#> $sample_837_0$HL64
#> [1] "HL" "64" "63" "22" "0" 
#> 
#> $sample_837_0$SBRP
#>  [1] "SBR"                         "P"                          
#>  [3] "18"                          NA                           
#>  [5] "COMMUNITY HLTH PLAN OF WASH" NA                           
#>  [7] NA                            NA                           
#>  [9] NA                            "CI"                         
#> 
#> $sample_837_0$NM1IL
#>  [1] "NM1"     "IL"      "1"       "PATIENT" "SUSAN"   "E"       NA       
#>  [8] NA        "MI"      "765123" 
#> 
#> $sample_837_0$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_0$N4TESTCITY
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_837_0$DMGD8
#> [1] "DMG"      "D8"       "19000101" "F"       
#> 
#> $sample_837_0$NM1PR
#>  [1] "NM1"                                 "PR"                                 
#>  [3] "2"                                   "COMMUNITY HEALTH PLAN OF WASHINGTON"
#>  [5] NA                                    NA                                   
#>  [7] NA                                    NA                                   
#>  [9] "PI"                                  "CHPWA"                              
#> 
#> $sample_837_0$NM141
#>  [1] "NM1"               "41"                "2"                
#>  [4] "CLEARINGHOUSE LLC" NA                  NA                 
#>  [7] NA                  NA                  "46"               
#> [10] "987654321"        
#> 
#> $sample_837_0$PERIC
#> [1] "PER"                           "IC"                           
#> [3] "CLEARINGHOUSE CLIENT SERVICES" "TE"                           
#> [5] "5555550000"                    "FX"                           
#> [7] "5555550000"                   
#> 
#> $sample_837_0$NM140
#>  [1] "NM1"       "40"        "2"         "123456789" NA          NA         
#>  [7] NA          NA          "46"        "CHPWA"    
#> 
#> $sample_837_0$HL49
#> [1] "HL" "49" NA   "20" "1" 
#> 
#> $sample_837_0$NM185
#>  [1] "NM1"                    "85"                     "2"                     
#>  [4] "BH CLINIC OF VANCOUVER" NA                       NA                      
#>  [7] NA                       NA                       "XX"                    
#> [10] "1122334455"            
#> 
#> $sample_837_0$`N312345 MAIN ST`
#> [1] "N3"            "12345 MAIN ST"
#> 
#> $sample_837_0$N4VANCOUVER
#> [1] "N4"        "VANCOUVER" "WA"        "98662"    
#> 
#> $sample_837_0$REFEI
#> [1] "REF"       "EI"        "720000000"
#> 
#> $sample_837_0$PERIC
#> [1] "PER"        "IC"         "CONTACT"    "TE"         "5555550000"
#> 
#> $sample_837_0$NM187
#> [1] "NM1" "87"  "2"  
#> 
#> $sample_837_0$`N3PO BOX 1234`
#> [1] "N3"          "PO BOX 1234"
#> 
#> $sample_837_0$N4VANCOUVER
#> [1] "N4"        "VANCOUVER" "WA"        "986681234"
#> 
#> $sample_837_0$HL50
#> [1] "HL" "50" "49" "22" "0" 
#> 
#> $sample_837_0$SBRP
#>  [1] "SBR"                         "P"                          
#>  [3] "18"                          NA                           
#>  [5] "COMMUNITY HLTH PLAN OF WASH" NA                           
#>  [7] NA                            NA                           
#>  [9] NA                            "CI"                         
#> 
#> $sample_837_0$NM1IL
#>  [1] "NM1"        "IL"         "1"          "SUBSCRIBER" "JOHN"      
#>  [6] "J"          NA           NA           "MI"         "987321"    
#> 
#> $sample_837_0$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_0$N4TESTCITY
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_837_0$DMGD8
#> [1] "DMG"      "D8"       "19000101" "M"       
#> 
#> $sample_837_0$NM1PR
#>  [1] "NM1"                                 "PR"                                 
#>  [3] "2"                                   "COMMUNITY HEALTH PLAN OF WASHINGTON"
#>  [5] NA                                    NA                                   
#>  [7] NA                                    NA                                   
#>  [9] "PI"                                  "CHPWA"                              
#> 
#> $sample_837_0$NM141
#>  [1] "NM1"               "41"                "2"                
#>  [4] "CLEARINGHOUSE LLC" NA                  NA                 
#>  [7] NA                  NA                  "46"               
#> [10] "987654321"        
#> 
#> $sample_837_0$PERIC
#> [1] "PER"                           "IC"                           
#> [3] "CLEARINGHOUSE CLIENT SERVICES" "TE"                           
#> [5] "5555550000"                    "FX"                           
#> [7] "5555550000"                   
#> 
#> $sample_837_0$NM140
#>  [1] "NM1"       "40"        "2"         "123456789" NA          NA         
#>  [7] NA          NA          "46"        "CHPWA"    
#> 
#> $sample_837_0$HL75
#> [1] "HL" "75" NA   "20" "1" 
#> 
#> $sample_837_0$NM185
#>  [1] "NM1"                    "85"                     "2"                     
#>  [4] "BH CLINIC OF VANCOUVER" NA                       NA                      
#>  [7] NA                       NA                       "XX"                    
#> [10] "1122334455"            
#> 
#> $sample_837_0$`N312345 MAIN ST`
#> [1] "N3"            "12345 MAIN ST"
#> 
#> $sample_837_0$N4VANCOUVER
#> [1] "N4"        "VANCOUVER" "WA"        "98662"    
#> 
#> $sample_837_0$REFEI
#> [1] "REF"       "EI"        "720000000"
#> 
#> $sample_837_0$PERIC
#> [1] "PER"        "IC"         "CONTACT"    "TE"         "5555550000"
#> 
#> $sample_837_0$NM187
#> [1] "NM1" "87"  "2"  
#> 
#> $sample_837_0$`N3PO BOX 1234`
#> [1] "N3"          "PO BOX 1234"
#> 
#> $sample_837_0$N4VANCOUVER
#> [1] "N4"        "VANCOUVER" "WA"        "986681234"
#> 
#> $sample_837_0$HL76
#> [1] "HL" "76" "75" "22" "0" 
#> 
#> $sample_837_0$SBRP
#>  [1] "SBR"                         "P"                          
#>  [3] "18"                          NA                           
#>  [5] "COMMUNITY HLTH PLAN OF WASH" NA                           
#>  [7] NA                            NA                           
#>  [9] NA                            "CI"                         
#> 
#> $sample_837_0$NM1IL
#>  [1] "NM1"     "IL"      "1"       "PATIENT" "SUSAN"   "E"       NA       
#>  [8] NA        "MI"      "765123" 
#> 
#> $sample_837_0$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_0$N4TESTCITY
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_837_0$DMGD8
#> [1] "DMG"      "D8"       "19000101" "F"       
#> 
#> $sample_837_0$NM1PR
#>  [1] "NM1"                                 "PR"                                 
#>  [3] "2"                                   "COMMUNITY HEALTH PLAN OF WASHINGTON"
#>  [5] NA                                    NA                                   
#>  [7] NA                                    NA                                   
#>  [9] "PI"                                  "CHPWA"                              
#> 
#> $sample_837_0$NM141
#>  [1] "NM1"               "41"                "2"                
#>  [4] "CLEARINGHOUSE LLC" NA                  NA                 
#>  [7] NA                  NA                  "46"               
#> [10] "987654321"        
#> 
#> $sample_837_0$PERIC
#> [1] "PER"                           "IC"                           
#> [3] "CLEARINGHOUSE CLIENT SERVICES" "TE"                           
#> [5] "5555550000"                    "FX"                           
#> [7] "5555550000"                   
#> 
#> $sample_837_0$NM140
#>  [1] "NM1"       "40"        "2"         "123456789" NA          NA         
#>  [7] NA          NA          "46"        "CHPWA"    
#> 
#> $sample_837_0$HL79
#> [1] "HL" "79" NA   "20" "1" 
#> 
#> $sample_837_0$NM185
#>  [1] "NM1"                    "85"                     "2"                     
#>  [4] "BH CLINIC OF VANCOUVER" NA                       NA                      
#>  [7] NA                       NA                       "XX"                    
#> [10] "1122334455"            
#> 
#> $sample_837_0$`N312345 MAIN ST`
#> [1] "N3"            "12345 MAIN ST"
#> 
#> $sample_837_0$N4VANCOUVER
#> [1] "N4"        "VANCOUVER" "WA"        "98662"    
#> 
#> $sample_837_0$REFEI
#> [1] "REF"       "EI"        "720000000"
#> 
#> $sample_837_0$PERIC
#> [1] "PER"        "IC"         "CONTACT"    "TE"         "5555550000"
#> 
#> $sample_837_0$NM187
#> [1] "NM1" "87"  "2"  
#> 
#> $sample_837_0$`N3PO BOX 1234`
#> [1] "N3"          "PO BOX 1234"
#> 
#> $sample_837_0$N4VANCOUVER
#> [1] "N4"        "VANCOUVER" "WA"        "986681234"
#> 
#> $sample_837_0$HL80
#> [1] "HL" "80" "79" "22" "0" 
#> 
#> $sample_837_0$SBRP
#>  [1] "SBR"                         "P"                          
#>  [3] "18"                          NA                           
#>  [5] "COMMUNITY HLTH PLAN OF WASH" NA                           
#>  [7] NA                            NA                           
#>  [9] NA                            "CI"                         
#> 
#> $sample_837_0$NM1IL
#>  [1] "NM1"        "IL"         "1"          "SUBSCRIBER" "JOHN"      
#>  [6] "J"          NA           NA           "MI"         "987321"    
#> 
#> $sample_837_0$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_0$N4TESTCITY
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_837_0$DMGD8
#> [1] "DMG"      "D8"       "19000101" "M"       
#> 
#> $sample_837_0$NM1PR
#>  [1] "NM1"                                 "PR"                                 
#>  [3] "2"                                   "COMMUNITY HEALTH PLAN OF WASHINGTON"
#>  [5] NA                                    NA                                   
#>  [7] NA                                    NA                                   
#>  [9] "PI"                                  "CHPWA"                              
#> 
#> $sample_837_0[[100]]
#>  [1] "CLM"              "1805080AV3648339" "20"               NA                
#>  [5] NA                 "57:B:1"           "Y"                "A"               
#>  [9] "Y"                "Y"               
#> 
#> $sample_837_0[[101]]
#> [1] "REF"        "D9"         "7349065509"
#> 
#> $sample_837_0[[102]]
#> [1] "HI"        "ABK:F1120"
#> 
#> $sample_837_0[[103]]
#>  [1] "NM1"        "82"         "1"          "PROVIDER"   "JAMES"     
#>  [6] NA           NA           NA           "XX"         "1112223338"
#> 
#> $sample_837_0[[104]]
#> [1] "PRV"        "PE"         "PXC"        "261QR0405X"
#> 
#> $sample_837_0[[105]]
#>  [1] "NM1"                    "77"                     "2"                     
#>  [4] "BH CLINIC OF VANCOUVER" NA                       NA                      
#>  [7] NA                       NA                       "XX"                    
#> [10] "1122334455"            
#> 
#> $sample_837_0[[106]]
#> [1] "N3"                     "12345 MAIN ST SUITE A1"
#> 
#> $sample_837_0[[107]]
#> [1] "N4"        "VANCOUVER" "WA"        "98662"    
#> 
#> $sample_837_0[[108]]
#> [1] "LX" "1" 
#> 
#> $sample_837_0[[109]]
#> [1] "SV1"      "HC:H0003" "20"       "UN"       "1"        NA         NA        
#> [8] "1"       
#> 
#> $sample_837_0[[110]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_0[[111]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_0[[112]]
#>  [1] "CLM"              "1805080AV3648347" "50.1"             NA                
#>  [5] NA                 "57:B:1"           "Y"                "A"               
#>  [9] "Y"                "Y"               
#> 
#> $sample_837_0[[113]]
#> [1] "REF"        "D9"         "7349065730"
#> 
#> $sample_837_0[[114]]
#> [1] "HI"        "ABK:F1520" "ABF:F1220"
#> 
#> $sample_837_0[[115]]
#>  [1] "NM1"        "82"         "1"          "PROVIDER"   "SUSAN"     
#>  [6] NA           NA           NA           "XX"         "1112223346"
#> 
#> $sample_837_0[[116]]
#> [1] "PRV"        "PE"         "PXC"        "261QR0405X"
#> 
#> $sample_837_0[[117]]
#>  [1] "NM1"                    "77"                     "2"                     
#>  [4] "BH CLINIC OF VANCOUVER" NA                       NA                      
#>  [7] NA                       NA                       "XX"                    
#> [10] "1122334455"            
#> 
#> $sample_837_0[[118]]
#> [1] "N3"                     "12345 MAIN ST SUITE A1"
#> 
#> $sample_837_0[[119]]
#> [1] "N4"        "VANCOUVER" "WA"        "98662"    
#> 
#> $sample_837_0[[120]]
#> [1] "LX" "1" 
#> 
#> $sample_837_0[[121]]
#> [1] "SV1"         "HC:96153:HF" "50.1"        "UN"          "6"          
#> [6] NA            NA            "1:2"        
#> 
#> $sample_837_0[[122]]
#> [1] "DTP"      "472"      "D8"       "20180426"
#> 
#> $sample_837_0[[123]]
#> [1] "REF"    "6R"     "143792"
#> 
#> $sample_837_0[[124]]
#>  [1] "CLM"              "1805080AV3648340" "11.64"            NA                
#>  [5] NA                 "57:B:1"           "Y"                "A"               
#>  [9] "Y"                "Y"               
#> 
#> $sample_837_0[[125]]
#> [1] "REF"        "D9"         "7349065492"
#> 
#> $sample_837_0[[126]]
#> [1] "HI"        "ABK:F1020" "ABF:F1220"
#> 
#> $sample_837_0[[127]]
#>  [1] "NM1"        "82"         "1"          "PROVIDER"   "SUSAN"     
#>  [6] NA           NA           NA           "XX"         "1112223346"
#> 
#> $sample_837_0[[128]]
#> [1] "PRV"        "PE"         "PXC"        "261QR0405X"
#> 
#> $sample_837_0[[129]]
#>  [1] "NM1"                    "77"                     "2"                     
#>  [4] "BH CLINIC OF VANCOUVER" NA                       NA                      
#>  [7] NA                       NA                       "XX"                    
#> [10] "1122334455"            
#> 
#> $sample_837_0[[130]]
#> [1] "N3"                     "12345 MAIN ST SUITE A1"
#> 
#> $sample_837_0[[131]]
#> [1] "N4"        "VANCOUVER" "WA"        "98662"    
#> 
#> $sample_837_0[[132]]
#> [1] "LX" "1" 
#> 
#> $sample_837_0[[133]]
#> [1] "SV1"         "HC:T1017:HF" "11.64"       "UN"          "1"          
#> [6] NA            NA            "1:2"        
#> 
#> $sample_837_0[[134]]
#> [1] "DTP"      "472"      "D8"       "20180427"
#> 
#> $sample_837_0[[135]]
#> [1] "REF"    "6R"     "140976"
#> 
#> $sample_837_0[[136]]
#>  [1] "CLM"              "1805080AV3648353" "234"              NA                
#>  [5] NA                 "53:B:1"           "Y"                "A"               
#>  [9] "Y"                "Y"               
#> 
#> $sample_837_0[[137]]
#> [1] "REF"        "D9"         "7349064290"
#> 
#> $sample_837_0[[138]]
#> [1] "HI"       "ABK:F251"
#> 
#> $sample_837_0[[139]]
#>  [1] "NM1"        "82"         "1"          "PROVIDER"   "SUSAN"     
#>  [6] NA           NA           NA           "XX"         "1112223346"
#> 
#> $sample_837_0[[140]]
#> [1] "PRV"        "PE"         "PXC"        "251S00000X"
#> 
#> $sample_837_0[[141]]
#>  [1] "NM1"                    "77"                     "2"                     
#>  [4] "BH CLINIC OF VANCOUVER" NA                       NA                      
#>  [7] NA                       NA                       "XX"                    
#> [10] "1122334455"            
#> 
#> $sample_837_0[[142]]
#> [1] "N3"                     "12345 MAIN ST SUITE A1"
#> 
#> $sample_837_0[[143]]
#> [1] "N4"        "VANCOUVER" "WA"        "98662"    
#> 
#> $sample_837_0[[144]]
#> [1] "LX" "1" 
#> 
#> $sample_837_0[[145]]
#> [1] "SV1"      "HC:90853" "234"      "UN"       "120"      NA         NA        
#> [8] "1"       
#> 
#> $sample_837_0[[146]]
#> [1] "DTP"      "472"      "D8"       "20180427"
#> 
#> $sample_837_0[[147]]
#> [1] "REF"    "6R"     "140787"
#> 
#> $sample_837_0[[148]]
#> [1] "NTE" "ADD" "05" 
#> 
#> $sample_837_0[[149]]
#>  [1] "CLM"              "1805080AV3648355" "20"               NA                
#>  [5] NA                 "57:B:1"           "Y"                "A"               
#>  [9] "Y"                "Y"               
#> 
#> $sample_837_0[[150]]
#> [1] "REF"        "D9"         "7349064036"
#> 
#> $sample_837_0[[151]]
#> [1] "HI"        "ABK:F1020" "ABF:F1120"
#> 
#> $sample_837_0[[152]]
#>  [1] "NM1"        "82"         "1"          "PROVIDER"   "JAMES"     
#>  [6] NA           NA           NA           "XX"         "1112223338"
#> 
#> $sample_837_0[[153]]
#> [1] "PRV"        "PE"         "PXC"        "261QR0405X"
#> 
#> $sample_837_0[[154]]
#>  [1] "NM1"                    "77"                     "2"                     
#>  [4] "BH CLINIC OF VANCOUVER" NA                       NA                      
#>  [7] NA                       NA                       "XX"                    
#> [10] "1122334455"            
#> 
#> $sample_837_0[[155]]
#> [1] "N3"                     "12345 MAIN ST SUITE A1"
#> 
#> $sample_837_0[[156]]
#> [1] "N4"        "VANCOUVER" "WA"        "98662"    
#> 
#> $sample_837_0[[157]]
#> [1] "LX" "1" 
#> 
#> $sample_837_0[[158]]
#> [1] "SV1"      "HC:H0003" "20"       "UN"       "1"        NA         NA        
#> [8] "1:2"     
#> 
#> $sample_837_0[[159]]
#> [1] "DTP"      "472"      "D8"       "20180427"
#> 
#> $sample_837_0[[160]]
#> [1] "REF"    "6R"     "143907"
#> 
#> $sample_837_0$SE
#> [1] "SE"        "34"        "000000001"
#> 
#> $sample_837_0$GE
#> [1] "GE"        "5"         "212950697"
#> 
#> $sample_837_0$IEA
#> [1] "IEA"       "1"         "697773230"
#> 
#> 
#> $sample_837_11
#> $sample_837_11$ISA
#>  [1] "ISA"          "00"           NA             "00"           NA            
#>  [6] "ZZ"           "SUBMITTER ID" "ZZ"           "RECEIVER ID"  "230516"      
#> [11] "1145"         "^"            "00501"        "000000001"    "0"           
#> [16] "P"            ":"           
#> 
#> $sample_837_11$GS
#> [1] "GS"           "HC"           "SUBMITTER ID" "RECEIVER ID"  "20230516"    
#> [6] "1145"         "1"            "X"            "005010X222A1"
#> 
#> $sample_837_11$ST
#> [1] "ST"           "837"          "0001"         "005010X222A1"
#> 
#> $sample_837_11$BHT
#> [1] "BHT"      "0019"     "00"       "244579"   "20230516" "1145"     "CH"      
#> 
#> $sample_837_11$NM141
#>  [1] "NM1"           "41"            "2"             "SUBMIT CLINIC"
#>  [5] NA              NA              NA              NA             
#>  [9] "46"            "12345"        
#> 
#> $sample_837_11$PERIC
#> [1] "PER"          "IC"           "CONTACT NAME" "TE"           "5555550000"  
#> 
#> $sample_837_11$NM140
#>  [1] "NM1"           "40"            "2"             "RECEIVER NAME"
#>  [5] NA              NA              NA              NA             
#>  [9] "46"            "67890"        
#> 
#> $sample_837_11$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $sample_837_11$NM185
#>  [1] "NM1"              "85"               "2"                "BILLING PROVIDER"
#>  [5] NA                 NA                 NA                 NA                
#>  [9] "XX"               "1234567893"      
#> 
#> $sample_837_11$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_11$N4TESTCITY
#> [1] "N4"       "TESTCITY" "GA"       "00000"   
#> 
#> $sample_837_11$REFEI
#> [1] "REF"       "EI"        "123456789"
#> 
#> $sample_837_11$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $sample_837_11$SBRP
#>  [1] "SBR" "P"   "18"  NA    NA    NA    NA    NA    NA    "MC" 
#> 
#> $sample_837_11$NM1IL
#>  [1] "NM1"         "IL"          "1"           "DOE"         "JOHN"       
#>  [6] NA            NA            NA            "MI"          "12345678901"
#> 
#> $sample_837_11$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_11$N4TESTCITY
#> [1] "N4"       "TESTCITY" "GA"       "00000"   
#> 
#> $sample_837_11$DMGD8
#> [1] "DMG"      "D8"       "19000101" "M"       
#> 
#> $sample_837_11[[19]]
#>  [1] "CLM"    "12345"  "150.00" NA       NA       "11:B:1" "Y"      "A"     
#>  [9] "Y"      "Y"     
#> 
#> $sample_837_11[[20]]
#> [1] "HI"       "ABK:I109"
#> 
#> $sample_837_11[[21]]
#>  [1] "NM1"        "82"         "1"          "PROVIDER"   "JANE"      
#>  [6] NA           NA           NA           "XX"         "9876543210"
#> 
#> $sample_837_11[[22]]
#> [1] "PRV"        "PE"         "ZZ"         "207RC0000X"
#> 
#> $sample_837_11[[23]]
#> [1] "SV1"      "HC:J1745" "150.00"   "UN"       "2"        "11"       NA        
#> [8] NA         "1"       
#> 
#> $sample_837_11[[24]]
#> [1] "DTP"      "472"      "D8"       "20230515"
#> 
#> $sample_837_11[[25]]
#> [1] "LIN"         NA            "N4"          "50242004001"
#> 
#> $sample_837_11[[26]]
#> [1] "CTP"    NA       NA       "2"      "150.00"
#> 
#> $sample_837_11$SE
#> [1] "SE"   "24"   "0001"
#> 
#> $sample_837_11$GE
#> [1] "GE" "1"  "1" 
#> 
#> $sample_837_11$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
#> $sample_837_12
#> $sample_837_12$ISA
#>  [1] "ISA"          "00"           NA             "00"           NA            
#>  [6] "ZZ"           "SUBMITTER ID" "ZZ"           "RECEIVER ID"  "230516"      
#> [11] "1145"         "^"            "00501"        "000000001"    "0"           
#> [16] "P"            ":"           
#> 
#> $sample_837_12$GS
#> [1] "GS"           "HC"           "SUBMITTER ID" "RECEIVER ID"  "20230516"    
#> [6] "1145"         "1"            "X"            "005010X222A1"
#> 
#> $sample_837_12$ST
#> [1] "ST"           "837"          "0001"         "005010X222A1"
#> 
#> $sample_837_12$BHT
#> [1] "BHT"      "0019"     "00"       "244579"   "20230516" "1145"     "CH"      
#> 
#> $sample_837_12$NM141
#>  [1] "NM1"           "41"            "2"             "SUBMIT CLINIC"
#>  [5] NA              NA              NA              NA             
#>  [9] "46"            "12345"        
#> 
#> $sample_837_12$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_12$NM140
#>  [1] "NM1"           "40"            "2"             "RECEIVER NAME"
#>  [5] NA              NA              NA              NA             
#>  [9] "46"            "67890"        
#> 
#> $sample_837_12$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $sample_837_12$NM185
#>  [1] "NM1"              "85"               "2"                "BILLING PROVIDER"
#>  [5] NA                 NA                 NA                 NA                
#>  [9] "XX"               "1234567893"      
#> 
#> $sample_837_12$`N3123 BILLING ST`
#> [1] "N3"             "123 BILLING ST"
#> 
#> $sample_837_12$N4CITY
#> [1] "N4"    "CITY"  "GA"    "30001"
#> 
#> $sample_837_12$REFEI
#> [1] "REF"       "EI"        "123456789"
#> 
#> $sample_837_12$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $sample_837_12$SBRP
#>  [1] "SBR" "P"   "18"  NA    NA    NA    NA    NA    NA    "MC" 
#> 
#> $sample_837_12$NM1IL
#>  [1] "NM1"              "IL"               "1"                "TESTLAST01"      
#>  [5] "TESTFIRST01"      NA                 NA                 NA                
#>  [9] "MI"               "TESTMBR000000001"
#> 
#> $sample_837_12$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_12$N4TESTCITY
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_837_12$DMGD8
#> [1] "DMG"      "D8"       "19000101" "M"       
#> 
#> $sample_837_12$NM141
#>  [1] "NM1"                  "41"                   "2"                   
#>  [4] "HSA PORT ARTHUR, LLC" NA                     NA                    
#>  [7] NA                     NA                     "XX"                  
#> [10] "1194548073"          
#> 
#> $sample_837_12$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_12$NM140
#>  [1] "NM1"             "40"              "2"               "OptimaFourSight"
#>  [5] NA                NA                NA                NA               
#>  [9] "XX"              "89242VA018"     
#> 
#> $sample_837_12$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_12$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $sample_837_12$NM185
#>  [1] "NM1"                  "85"                   "2"                   
#>  [4] "HSA PORT ARTHUR, LLC" NA                     NA                    
#>  [7] NA                     NA                     "XX"                  
#> [10] "1194548073"          
#> 
#> $sample_837_12$`N3505 N BRAND BLVD STE 1200`
#> [1] "N3"                        "505 N BRAND BLVD STE 1200"
#> 
#> $sample_837_12$N4GLENDALE
#> [1] "N4"       "GLENDALE" "CA"       "91203"   
#> 
#> $sample_837_12$REFEI
#> [1] "REF"        "EI"         "71-3391736"
#> 
#> $sample_837_12$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_12$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $sample_837_12$SBRP
#>  [1] "SBR"       "P"         "18"        "731323546" NA          NA         
#>  [7] NA          NA          NA          "CI"       
#> 
#> $sample_837_12$NM1IL
#>  [1] "NM1"              "IL"               "1"                "TESTLAST02"      
#>  [5] "TESTFIRST02"      NA                 NA                 NA                
#>  [9] "MI"               "TESTMBR000000002"
#> 
#> $sample_837_12$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_12$N4TESTCITY
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_837_12$NM141
#>  [1] "NM1"                                   
#>  [2] "41"                                    
#>  [3] "2"                                     
#>  [4] "HCA HEALTH SERVICES OF TENNESSEE, INC."
#>  [5] NA                                      
#>  [6] NA                                      
#>  [7] NA                                      
#>  [8] NA                                      
#>  [9] "XX"                                    
#> [10] "1265487193"                            
#> 
#> $sample_837_12$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_12$NM140
#>  [1] "NM1"                   "40"                    "2"                    
#>  [4] "HMOOffExchangeRegion7" NA                      NA                     
#>  [7] NA                      NA                      "XX"                   
#> [10] "84014CA002"           
#> 
#> $sample_837_12$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_12$HL1
#> [1] "HL" "1"  NA   "20" "1" 
#> 
#> $sample_837_12$NM185
#>  [1] "NM1"                                   
#>  [2] "85"                                    
#>  [3] "2"                                     
#>  [4] "HCA HEALTH SERVICES OF TENNESSEE, INC."
#>  [5] NA                                      
#>  [6] NA                                      
#>  [7] NA                                      
#>  [8] NA                                      
#>  [9] "XX"                                    
#> [10] "1265487193"                            
#> 
#> $sample_837_12$`N3313 N MAIN ST`
#> [1] "N3"            "313 N MAIN ST"
#> 
#> $sample_837_12$`N4ASHLAND CITY`
#> [1] "N4"           "ASHLAND CITY" "TN"           "37015"       
#> 
#> $sample_837_12$REFEI
#> [1] "REF"        "EI"         "99-5971744"
#> 
#> $sample_837_12$PERIC
#> [1] "PER"          "IC"           "TEST CONTACT" "TE"           "5555550000"  
#> 
#> $sample_837_12$HL2
#> [1] "HL" "2"  "1"  "22" "0" 
#> 
#> $sample_837_12$SBRP
#>  [1] "SBR"       "P"         "18"        "556791994" NA          NA         
#>  [7] NA          NA          NA          "CI"       
#> 
#> $sample_837_12$NM1IL
#>  [1] "NM1"              "IL"               "1"                "TESTLAST03"      
#>  [5] "TESTFIRST03"      NA                 NA                 NA                
#>  [9] "MI"               "TESTMBR000000003"
#> 
#> $sample_837_12$`N3123 TEST STREET`
#> [1] "N3"              "123 TEST STREET"
#> 
#> $sample_837_12$N4TESTCITY
#> [1] "N4"       "TESTCITY" "CA"       "00000"   
#> 
#> $sample_837_12[[49]]
#>  [1] "CLM"    "12345"  "150.00" NA       NA       "11:B:1" "Y"      "A"     
#>  [9] "Y"      "Y"     
#> 
#> $sample_837_12[[50]]
#> [1] "HI"       "ABK:I109"
#> 
#> $sample_837_12[[51]]
#>  [1] "NM1"        "82"         "1"          "PROVIDER"   "JANE"      
#>  [6] NA           NA           NA           "XX"         "9876543210"
#> 
#> $sample_837_12[[52]]
#> [1] "PRV"        "PE"         "ZZ"         "207RC0000X"
#> 
#> $sample_837_12[[53]]
#> [1] "SV1"      "HC:J1745" "150.00"   "UN"       "2"        "11"       NA        
#> [8] NA         "1"       
#> 
#> $sample_837_12[[54]]
#> [1] "DTP"      "472"      "D8"       "20230515"
#> 
#> $sample_837_12[[55]]
#> [1] "LIN"         NA            "N4"          "50242004001"
#> 
#> $sample_837_12[[56]]
#> [1] "CTP"    NA       NA       "2"      "150.00"
#> 
#> $sample_837_12[[57]]
#>  [1] "CLM"        "4742333269" "128"        NA           NA          
#>  [6] "11:B:1"     "Y"          "A"          "Y"          "I"         
#> 
#> $sample_837_12[[58]]
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20240422-20240430"
#> 
#> $sample_837_12[[59]]
#> [1] "DTP"      "435"      "D8"       "20240809"
#> 
#> $sample_837_12[[60]]
#> [1] "DTP"  "096"  "TM"   "2337"
#> 
#> $sample_837_12[[61]]
#> [1] "HI"          "ABK:W214XXA"
#> 
#> $sample_837_12[[62]]
#> [1] "HI"          "ABK:S31813D"
#> 
#> $sample_837_12[[63]]
#> [1] "HI"          "ABK:V0492XD"
#> 
#> $sample_837_12[[64]]
#> [1] "HI"          "ABK:T498X6A"
#> 
#> $sample_837_12[[65]]
#> [1] "LX" "1" 
#> 
#> $sample_837_12[[66]]
#>  [1] "SV1"      "HC:37180" "93"       "UN"       "1"        NA        
#>  [7] NA         "3:4:1"    NA         NA        
#> 
#> $sample_837_12[[67]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_12[[68]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_12[[69]]
#> [1] "LX" "2" 
#> 
#> $sample_837_12[[70]]
#>  [1] "SV1"      "HC:24000" "4"        "UN"       "1"        NA        
#>  [7] NA         "1:3:4"    NA         NA        
#> 
#> $sample_837_12[[71]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_12[[72]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_12[[73]]
#> [1] "LX" "3" 
#> 
#> $sample_837_12[[74]]
#>  [1] "SV1"      "HC:16035" "31"       "UN"       "1"        NA        
#>  [7] NA         "3"        NA         NA        
#> 
#> $sample_837_12[[75]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_12[[76]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_12[[77]]
#>  [1] "CLM"        "4742333269" "839"        NA           NA          
#>  [6] "11:B:1"     "Y"          "A"          "Y"          "I"         
#> 
#> $sample_837_12[[78]]
#> [1] "DTP"               "434"               "RD8"              
#> [4] "20240422-20240430"
#> 
#> $sample_837_12[[79]]
#> [1] "DTP"      "435"      "D8"       "20240809"
#> 
#> $sample_837_12[[80]]
#> [1] "DTP"  "096"  "TM"   "2337"
#> 
#> $sample_837_12[[81]]
#> [1] "HI"          "ABK:V9421XS"
#> 
#> $sample_837_12[[82]]
#> [1] "HI"          "ABK:S35292S"
#> 
#> $sample_837_12[[83]]
#> [1] "HI"          "ABK:S52272S"
#> 
#> $sample_837_12[[84]]
#> [1] "HI"         "ABK:H68022"
#> 
#> $sample_837_12[[85]]
#> [1] "HI"          "ABK:T4144XD"
#> 
#> $sample_837_12[[86]]
#> [1] "HI"        "ABK:H1030"
#> 
#> $sample_837_12[[87]]
#> [1] "HI"          "ABK:S82832J"
#> 
#> $sample_837_12[[88]]
#> [1] "HI"       "ABK:B340"
#> 
#> $sample_837_12[[89]]
#> [1] "LX" "1" 
#> 
#> $sample_837_12[[90]]
#>  [1] "SV1"       "HC:35650"  "161"       "UN"        "1"         NA         
#>  [7] NA          "7:3:4:5:8" NA          NA         
#> 
#> $sample_837_12[[91]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_12[[92]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_12[[93]]
#> [1] "LX" "2" 
#> 
#> $sample_837_12[[94]]
#>  [1] "SV1"             "HC:73200"        "383"             "UN"             
#>  [5] "1"               NA                NA                "5:2:7:4:3:6:8:1"
#>  [9] NA                NA               
#> 
#> $sample_837_12[[95]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_12[[96]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_12[[97]]
#> [1] "LX" "3" 
#> 
#> $sample_837_12[[98]]
#>  [1] "SV1"      "HC:28262" "194"      "UN"       "1"        NA        
#>  [7] NA         "7:1:8"    NA         NA        
#> 
#> $sample_837_12[[99]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_12[[100]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_12[[101]]
#> [1] "LX" "4" 
#> 
#> $sample_837_12[[102]]
#>  [1] "SV1"      "HC:84480" "101"      "UN"       "1"        NA        
#>  [7] NA         "6:3:1:2"  NA         NA        
#> 
#> $sample_837_12[[103]]
#> [1] "DTP"      "472"      "D8"       "20180428"
#> 
#> $sample_837_12[[104]]
#> [1] "REF"    "6R"     "142671"
#> 
#> $sample_837_12$SE
#> [1] "SE"   "24"   "0001"
#> 
#> $sample_837_12$GE
#> [1] "GE" "1"  "1" 
#> 
#> $sample_837_12$IEA
#> [1] "IEA"       "1"         "000000001"
#> 
#> 
```
