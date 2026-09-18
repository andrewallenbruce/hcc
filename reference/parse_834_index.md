# X12-834 (X220A1) Benefit Enrollment Parser

The 834 carries *membership events*:

- new enrollment (qualifier 021)

- change (001)

- termination (024)

- audit/reconciliation (030)

## Usage

``` r
index_834(text)

parse_834_index(index)
```

## Arguments

- text:

  `<chr>` string of raw X12-834 text

- index:

  `<chr>` string of raw X12-834 text

## Value

list

## Details

It transports member demographics, dependents, chosen plan, effective
and end dates, premium amounts, occasionally tax elements and primary
care provider. It is the system of record for membership on the payer
side.

The 834 is heavily used by BPaaS (Benefits Administration as a Service):

- Workday Benefits

- ADP TotalSource

- bswift

- BenefitFocus

- Empyrean

It is also the official pipe between ACA state exchanges / marketplaces
and payers. The Open Enrollment window (November – December) produces
volume spikes that stress overnight batch jobs.

Extracts enrollment and demographic data from 834 transactions with
focus on:

- Risk adjustment fields (dual eligibility, OREC/CREC, SNP, LTI)

- CA DHCS FAME-specific fields

- HCP (Health Care Plan) coverage history

## Examples

``` r
purrr::map(hcc::x12_834, index_834)
#> $`834_EX2_add_dependent`
#> [1] NA
#> 
#> $`834_EX3_enroll_employee_mco`
#> [1] NA
#> 
#> $`834_EX4_add_subscriber_coverage`
#> [1] NA
#> 
#> $`834_EX5_change_subscriber_info`
#> [1] NA
#> 
#> $`834_EX6_cancel_dependent`
#> [1] NA
#> 
#> $`834_EX7_terminate_subscriber_eligibility`
#> [1] NA
#> 
#> $`834_EX8_reinstate_employee`
#> [1] NA
#> 
#> $`834_EX9_reinstate_employee_coverage`
#> [1] NA
#> 
#> $sample_834_01
#> [1] NA
#> 
#> $sample_834_02
#> [1] NA
#> 
#> $sample_834_03
#> [1] NA
#> 
#> $sample_834_04
#> [1] NA
#> 
#> $sample_834_05
#> [1] NA
#> 
#> $sample_834_06
#> [1] NA
#> 
```
