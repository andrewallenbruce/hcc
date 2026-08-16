# X12-834 Benefit Enrollment Parser

Extracts enrollment and demographic data from 834 transactions with
focus on:

- Risk adjustment fields (dual eligibility, OREC/CREC, SNP, LTI)

- CA DHCS FAME-specific fields

- HCP (Health Care Plan) coverage history

## Usage

``` r
parse_834(text)
```

## Arguments

- text:

  `<chr>` string of raw X12-834 text

## Value

list

## Examples

``` r
if (FALSE) {
purrr::map(hcc::x12_834, parse_834)
}
```
