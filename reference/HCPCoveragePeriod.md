# Health Care Plan coverage period from HD loop

Health Care Plan coverage period from HD loop

## Usage

``` r
HCPCoveragePeriod(
  start_date = (function (.data = double()) 
 {
     .Date(.data)
 })(),
  end_date = (function (.data = double()) 
 {
     .Date(.data)
 })(),
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
#>  @ start_date: 'Date' num(0) 
#>  @ end_date  : 'Date' num(0) 
#>  @ hcp_code  : chr(0) 
#>  @ hcp_status: chr(0) 
#>  @ aid_codes : chr(0) 
```
