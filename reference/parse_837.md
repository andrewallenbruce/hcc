# X12-837 Health Care Claim Parser

The 837 is the highest-volume transaction in US healthcare EDI. Every
commercial and public payer (Medicare, Medicaid, Tricare) consumes
hundreds of millions per month.

## Usage

``` r
parse_837(text)
```

## Arguments

- text:

  `<chr>` string of raw X12-837 text

## Value

list

## Details

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

  - `SBR` Subscriber Information with relationship code, claim filing
    indicator CI Commercial Insurance, MB Medicare Part B, MC Medicaid,
    etc.)

- `2000C` Patient Loop (the Patient when different from the Subscriber).
  At the claim level, CLM Claim Information carries the patient account,
  total charge, facility code, claim frequency. HI Health Care
  Information Codes carries ICD-10 diagnoses (qualifier ABK Principal
  Diagnosis, ABF Other Diagnosis). The service section groups LX + SV1
  (Professional) / SV2 (Institutional) / SV3 (Dental) detailing each
  procedure with its CPT / HCPCS / CDT code, modifiers, units, charge,
  and service date via DTP.

#### Summary

— a single `SE`

## Examples

``` r
purrr::map(hcc::x12_837[1], parse_837)
#> $minimal_837P
#> $minimal_837P$`NM1*41`
#> $minimal_837P$`NM1*41`$`01`
#> [1] "41"
#> 
#> $minimal_837P$`NM1*41`$`02`
#> [1] "2"
#> 
#> $minimal_837P$`NM1*41`$`03`
#> [1] "ACME CLINIC"
#> 
#> $minimal_837P$`NM1*41`$`04`
#> [1] ""
#> 
#> $minimal_837P$`NM1*41`$`05`
#> [1] ""
#> 
#> $minimal_837P$`NM1*41`$`06`
#> [1] ""
#> 
#> $minimal_837P$`NM1*41`$`07`
#> [1] ""
#> 
#> $minimal_837P$`NM1*41`$`08`
#> [1] "46"
#> 
#> $minimal_837P$`NM1*41`$`09`
#> [1] "1234567890"
#> 
#> 
#> $minimal_837P$PER
#> $minimal_837P$PER$`01`
#> [1] "IC"
#> 
#> $minimal_837P$PER$`02`
#> [1] "BILLING DEPT"
#> 
#> $minimal_837P$PER$`03`
#> [1] "TE"
#> 
#> $minimal_837P$PER$`04`
#> [1] "5551234567"
#> 
#> 
#> $minimal_837P$`NM1*40`
#> $minimal_837P$`NM1*40`$`01`
#> [1] "40"
#> 
#> $minimal_837P$`NM1*40`$`02`
#> [1] "2"
#> 
#> $minimal_837P$`NM1*40`$`03`
#> [1] "PAYER99"
#> 
#> $minimal_837P$`NM1*40`$`04`
#> [1] ""
#> 
#> $minimal_837P$`NM1*40`$`05`
#> [1] ""
#> 
#> $minimal_837P$`NM1*40`$`06`
#> [1] ""
#> 
#> $minimal_837P$`NM1*40`$`07`
#> [1] ""
#> 
#> $minimal_837P$`NM1*40`$`08`
#> [1] "46"
#> 
#> $minimal_837P$`NM1*40`$`09`
#> [1] "PAYER99"
#> 
#> 
#> 
```
