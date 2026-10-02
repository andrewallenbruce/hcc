# Health Care Plan Coverage Period

Health Care Plan coverage period from HD loop

## Usage

``` r
HCPCoveragePeriod(
  start_date = .Date(numeric(0L)),
  end_date = .Date(numeric(0L)),
  hcp_code = character(0),
  hcp_status = character(0),
  aid_codes = character(0)
)
```

## Arguments

- start_date:

  `<Date>` coverage start date

- end_date:

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
HCPCoveragePeriod(start_date = "2026-08-20", end_date = "2026-08-25")
#> <hcc::HCPCoveragePeriod>
#>  @ start_date: Date[1:1], format: "2026-08-20"
#>  @ end_date  : Date[1:1], format: "2026-08-25"
#>  @ hcp_code  : chr(0) 
#>  @ hcp_status: chr(0) 
#>  @ aid_codes : chr(0) 
```
