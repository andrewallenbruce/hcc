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
purrr::map(hcc::x12_837[1], parse_837)
#> $minimal_837P
#>    SEG PT        VALUE
#> 1  ISA 01           00
#> 2  ISA 02         <NA>
#> 3  ISA 03           00
#> 4  ISA 04         <NA>
#> 5  ISA 05           ZZ
#> 6  ISA 06   PROVIDER01
#> 7  ISA 07           ZZ
#> 8  ISA 08      PAYER99
#> 9  ISA 09       260415
#> 10 ISA 10         1030
#> 11 ISA 11            U
#> 12 ISA 12        00501
#> 13 ISA 13    000000837
#> 14 ISA 14            0
#> 15 ISA 15            P
#> 16 ISA 16            >
#> 17  GS 01           HC
#> 18  GS 02   PROVIDER01
#> 19  GS 03      PAYER99
#> 20  GS 04     20260415
#> 21  GS 05         1030
#> 22  GS 06            1
#> 23  GS 07            X
#> 24  GS 08 005010X222A1
#> 25  ST 01          837
#> 26  ST 02         0001
#> 27  ST 03 005010X222A1
#> 28 BHT 01         0019
#> 29 BHT 02           00
#> 30 BHT 03  REQ-CLM-001
#> 31 BHT 04     20260415
#> 32 BHT 05         1030
#> 33 BHT 06           CH
#> 
```
