# Health Care Plan Coverage Period

Health Care Plan coverage period from HD loop

## Usage

``` r
HCPCoveragePeriod(
  date_range = c(.Date(numeric(0L)), .Date(numeric(0L))),
  hcp_code = character(0),
  hcp_status = character(0),
  aid_codes = character(0)
)
```

## Arguments

- date_range:

  `<Date>` coverage start date

- hcp_code:

  `<chr>` HCP code

- hcp_status:

  `<chr>` HCP status

- aid_codes:

  `<chr>` REF\*CE composite

## Value

An `<HCPCoveragePeriod>` S7 object

## Examples

``` r
HCPCoveragePeriod(date_range = c("2026-08-20", "2026-08-25"))
#> <hcc::HCPCoveragePeriod>
#>  @ date_range: iv<date> [1:1] [2026-08-20, 2026-08-26)
#>  @ hcp_code  : chr(0) 
#>  @ hcp_status: chr(0) 
#>  @ aid_codes : chr(0) 
```
