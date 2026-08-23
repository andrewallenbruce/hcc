# Health Care Plan coverage period from HD loop

Health Care Plan coverage period from HD loop

## Usage

``` r
HCPCoveragePeriod(
  start_date = structure(20688, class = "Date"),
  end_date = structure(20689, class = "Date"),
  hcp_code = character(0),
  hcp_status = character(0),
  aid_codes = character(0)
)
```

## Arguments

- start_date:

  `<date>` coverage start date

- end_date:

  `<date>` coverage start date

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
HCPCoveragePeriod()
#> <hcc::HCPCoveragePeriod>
#>  @ start_date: Date[1:1], format: "2026-08-23"
#>  @ end_date  : Date[1:1], format: "2026-08-24"
#>  @ hcp_code  : chr(0) 
#>  @ hcp_status: chr(0) 
#>  @ aid_codes : chr(0) 
```
