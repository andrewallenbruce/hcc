# X12-834 (X220A1) Benefit Enrollment Parser

The 834 carries *membership events*:

- new enrollment (qualifier 021)

- change (001)

- termination (024)

- audit/reconciliation (030)

## Usage

``` r
parse_834(x)
```

## Arguments

- x:

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
idx = purrr::map(hcc::x12_834, index_x12)
purrr::map(idx, parse_834)
#> $`834_EX2_add_dependent`
#> $`834_EX2_add_dependent`$Header
#> $`834_EX2_add_dependent`$Header$ISA
#> $`834_EX2_add_dependent`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`834_EX2_add_dependent`$Header$ISA$`02`
#> [1] NA
#> 
#> $`834_EX2_add_dependent`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`834_EX2_add_dependent`$Header$ISA$`04`
#> [1] NA
#> 
#> $`834_EX2_add_dependent`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`834_EX2_add_dependent`$Header$ISA$`06`
#> [1] "SENDERNAME"
#> 
#> $`834_EX2_add_dependent`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`834_EX2_add_dependent`$Header$ISA$`08`
#> [1] "RECEIVERNAME"
#> 
#> $`834_EX2_add_dependent`$Header$ISA$`09`
#> [1] "041227"
#> 
#> $`834_EX2_add_dependent`$Header$ISA$`10`
#> [1] "1324"
#> 
#> $`834_EX2_add_dependent`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`834_EX2_add_dependent`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`834_EX2_add_dependent`$Header$ISA$`13`
#> [1] "000000103"
#> 
#> $`834_EX2_add_dependent`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`834_EX2_add_dependent`$Header$ISA$`15`
#> [1] "P"
#> 
#> $`834_EX2_add_dependent`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`834_EX2_add_dependent`$Header$GS
#> $`834_EX2_add_dependent`$Header$GS$`01`
#> [1] "BE"
#> 
#> $`834_EX2_add_dependent`$Header$GS$`02`
#> [1] "SENDERNAME"
#> 
#> $`834_EX2_add_dependent`$Header$GS$`03`
#> [1] "RECEIVERNAME"
#> 
#> $`834_EX2_add_dependent`$Header$GS$`04`
#> [1] "20041227"
#> 
#> $`834_EX2_add_dependent`$Header$GS$`05`
#> [1] "1324"
#> 
#> $`834_EX2_add_dependent`$Header$GS$`06`
#> [1] "000000103"
#> 
#> $`834_EX2_add_dependent`$Header$GS$`07`
#> [1] "X"
#> 
#> $`834_EX2_add_dependent`$Header$GS$`08`
#> [1] "005010X220A1"
#> 
#> 
#> $`834_EX2_add_dependent`$Header$ST
#> $`834_EX2_add_dependent`$Header$ST$`01`
#> [1] "834"
#> 
#> $`834_EX2_add_dependent`$Header$ST$`02`
#> [1] "12345"
#> 
#> $`834_EX2_add_dependent`$Header$ST$`03`
#> [1] "005010X220A1"
#> 
#> 
#> $`834_EX2_add_dependent`$Header$BGN
#> $`834_EX2_add_dependent`$Header$BGN$`01`
#> [1] "00"
#> 
#> $`834_EX2_add_dependent`$Header$BGN$`02`
#> [1] "12456"
#> 
#> $`834_EX2_add_dependent`$Header$BGN$`03`
#> [1] "19980520"
#> 
#> $`834_EX2_add_dependent`$Header$BGN$`04`
#> [1] "1200"
#> 
#> $`834_EX2_add_dependent`$Header$BGN$`05`
#> [1] NA
#> 
#> $`834_EX2_add_dependent`$Header$BGN$`06`
#> [1] NA
#> 
#> $`834_EX2_add_dependent`$Header$BGN$`07`
#> [1] NA
#> 
#> $`834_EX2_add_dependent`$Header$BGN$`08`
#> [1] "2"
#> 
#> 
#> $`834_EX2_add_dependent`$Header$QTY
#> NULL
#> 
#> 
#> $`834_EX2_add_dependent`$Trailer
#> $`834_EX2_add_dependent`$Trailer$SE
#> $`834_EX2_add_dependent`$Trailer$SE$`01`
#> [1] "15"
#> 
#> $`834_EX2_add_dependent`$Trailer$SE$`02`
#> [1] "12345"
#> 
#> 
#> $`834_EX2_add_dependent`$Trailer$GE
#> $`834_EX2_add_dependent`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`834_EX2_add_dependent`$Trailer$GE$`02`
#> [1] "000000103"
#> 
#> 
#> $`834_EX2_add_dependent`$Trailer$IEA
#> $`834_EX2_add_dependent`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`834_EX2_add_dependent`$Trailer$IEA$`02`
#> [1] "000000103"
#> 
#> 
#> 
#> 
#> $`834_EX3_enroll_employee_mco`
#> $`834_EX3_enroll_employee_mco`$Header
#> $`834_EX3_enroll_employee_mco`$Header$ISA
#> $`834_EX3_enroll_employee_mco`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$ISA$`02`
#> [1] NA
#> 
#> $`834_EX3_enroll_employee_mco`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$ISA$`04`
#> [1] NA
#> 
#> $`834_EX3_enroll_employee_mco`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$ISA$`06`
#> [1] "SENDERNAME"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$ISA$`08`
#> [1] "RECEIVERNAME"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$ISA$`09`
#> [1] "041227"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$ISA$`10`
#> [1] "1324"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$ISA$`13`
#> [1] "000000103"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$ISA$`15`
#> [1] "P"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`834_EX3_enroll_employee_mco`$Header$GS
#> $`834_EX3_enroll_employee_mco`$Header$GS$`01`
#> [1] "BE"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$GS$`02`
#> [1] "SENDERNAME"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$GS$`03`
#> [1] "RECEIVERNAME"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$GS$`04`
#> [1] "20041227"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$GS$`05`
#> [1] "1324"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$GS$`06`
#> [1] "000000103"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$GS$`07`
#> [1] "X"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$GS$`08`
#> [1] "005010X220A1"
#> 
#> 
#> $`834_EX3_enroll_employee_mco`$Header$ST
#> $`834_EX3_enroll_employee_mco`$Header$ST$`01`
#> [1] "834"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$ST$`02`
#> [1] "12345"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$ST$`03`
#> [1] "005010X220A1"
#> 
#> 
#> $`834_EX3_enroll_employee_mco`$Header$BGN
#> $`834_EX3_enroll_employee_mco`$Header$BGN$`01`
#> [1] "00"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$BGN$`02`
#> [1] "12456"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$BGN$`03`
#> [1] "19980520"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$BGN$`04`
#> [1] "1200"
#> 
#> $`834_EX3_enroll_employee_mco`$Header$BGN$`05`
#> [1] NA
#> 
#> $`834_EX3_enroll_employee_mco`$Header$BGN$`06`
#> [1] NA
#> 
#> $`834_EX3_enroll_employee_mco`$Header$BGN$`07`
#> [1] NA
#> 
#> $`834_EX3_enroll_employee_mco`$Header$BGN$`08`
#> [1] "2"
#> 
#> 
#> $`834_EX3_enroll_employee_mco`$Header$QTY
#> NULL
#> 
#> 
#> $`834_EX3_enroll_employee_mco`$Trailer
#> $`834_EX3_enroll_employee_mco`$Trailer$SE
#> $`834_EX3_enroll_employee_mco`$Trailer$SE$`01`
#> [1] "18"
#> 
#> $`834_EX3_enroll_employee_mco`$Trailer$SE$`02`
#> [1] "12345"
#> 
#> 
#> $`834_EX3_enroll_employee_mco`$Trailer$GE
#> $`834_EX3_enroll_employee_mco`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`834_EX3_enroll_employee_mco`$Trailer$GE$`02`
#> [1] "000000103"
#> 
#> 
#> $`834_EX3_enroll_employee_mco`$Trailer$IEA
#> $`834_EX3_enroll_employee_mco`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`834_EX3_enroll_employee_mco`$Trailer$IEA$`02`
#> [1] "000000103"
#> 
#> 
#> 
#> 
#> $`834_EX4_add_subscriber_coverage`
#> $`834_EX4_add_subscriber_coverage`$Header
#> $`834_EX4_add_subscriber_coverage`$Header$ISA
#> $`834_EX4_add_subscriber_coverage`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$ISA$`02`
#> [1] NA
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$ISA$`04`
#> [1] NA
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$ISA$`06`
#> [1] "SENDERNAME"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$ISA$`08`
#> [1] "RECEIVERNAME"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$ISA$`09`
#> [1] "041227"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$ISA$`10`
#> [1] "1324"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$ISA$`13`
#> [1] "000000103"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$ISA$`15`
#> [1] "P"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$GS
#> $`834_EX4_add_subscriber_coverage`$Header$GS$`01`
#> [1] "BE"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$GS$`02`
#> [1] "SENDERNAME"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$GS$`03`
#> [1] "RECEIVERNAME"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$GS$`04`
#> [1] "20041227"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$GS$`05`
#> [1] "1324"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$GS$`06`
#> [1] "000000103"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$GS$`07`
#> [1] "X"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$GS$`08`
#> [1] "005010X220A1"
#> 
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$ST
#> $`834_EX4_add_subscriber_coverage`$Header$ST$`01`
#> [1] "834"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$ST$`02`
#> [1] "12345"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$ST$`03`
#> [1] "005010X220A1"
#> 
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$BGN
#> $`834_EX4_add_subscriber_coverage`$Header$BGN$`01`
#> [1] "00"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$BGN$`02`
#> [1] "12456"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$BGN$`03`
#> [1] "20020601"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$BGN$`04`
#> [1] "1200"
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$BGN$`05`
#> [1] NA
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$BGN$`06`
#> [1] NA
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$BGN$`07`
#> [1] NA
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$BGN$`08`
#> [1] "2"
#> 
#> 
#> $`834_EX4_add_subscriber_coverage`$Header$QTY
#> NULL
#> 
#> 
#> $`834_EX4_add_subscriber_coverage`$Trailer
#> $`834_EX4_add_subscriber_coverage`$Trailer$SE
#> $`834_EX4_add_subscriber_coverage`$Trailer$SE$`01`
#> [1] "12"
#> 
#> $`834_EX4_add_subscriber_coverage`$Trailer$SE$`02`
#> [1] "12345"
#> 
#> 
#> $`834_EX4_add_subscriber_coverage`$Trailer$GE
#> $`834_EX4_add_subscriber_coverage`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`834_EX4_add_subscriber_coverage`$Trailer$GE$`02`
#> [1] "000000103"
#> 
#> 
#> $`834_EX4_add_subscriber_coverage`$Trailer$IEA
#> $`834_EX4_add_subscriber_coverage`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`834_EX4_add_subscriber_coverage`$Trailer$IEA$`02`
#> [1] "000000103"
#> 
#> 
#> 
#> 
#> $`834_EX5_change_subscriber_info`
#> $`834_EX5_change_subscriber_info`$Header
#> $`834_EX5_change_subscriber_info`$Header$ISA
#> $`834_EX5_change_subscriber_info`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`834_EX5_change_subscriber_info`$Header$ISA$`02`
#> [1] NA
#> 
#> $`834_EX5_change_subscriber_info`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`834_EX5_change_subscriber_info`$Header$ISA$`04`
#> [1] NA
#> 
#> $`834_EX5_change_subscriber_info`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`834_EX5_change_subscriber_info`$Header$ISA$`06`
#> [1] "SENDERNAME"
#> 
#> $`834_EX5_change_subscriber_info`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`834_EX5_change_subscriber_info`$Header$ISA$`08`
#> [1] "RECEIVERNAME"
#> 
#> $`834_EX5_change_subscriber_info`$Header$ISA$`09`
#> [1] "041227"
#> 
#> $`834_EX5_change_subscriber_info`$Header$ISA$`10`
#> [1] "1324"
#> 
#> $`834_EX5_change_subscriber_info`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`834_EX5_change_subscriber_info`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`834_EX5_change_subscriber_info`$Header$ISA$`13`
#> [1] "000000103"
#> 
#> $`834_EX5_change_subscriber_info`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`834_EX5_change_subscriber_info`$Header$ISA$`15`
#> [1] "P"
#> 
#> $`834_EX5_change_subscriber_info`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`834_EX5_change_subscriber_info`$Header$GS
#> $`834_EX5_change_subscriber_info`$Header$GS$`01`
#> [1] "BE"
#> 
#> $`834_EX5_change_subscriber_info`$Header$GS$`02`
#> [1] "SENDERNAME"
#> 
#> $`834_EX5_change_subscriber_info`$Header$GS$`03`
#> [1] "RECEIVERNAME"
#> 
#> $`834_EX5_change_subscriber_info`$Header$GS$`04`
#> [1] "20041227"
#> 
#> $`834_EX5_change_subscriber_info`$Header$GS$`05`
#> [1] "1324"
#> 
#> $`834_EX5_change_subscriber_info`$Header$GS$`06`
#> [1] "000000103"
#> 
#> $`834_EX5_change_subscriber_info`$Header$GS$`07`
#> [1] "X"
#> 
#> $`834_EX5_change_subscriber_info`$Header$GS$`08`
#> [1] "005010X220A1"
#> 
#> 
#> $`834_EX5_change_subscriber_info`$Header$ST
#> $`834_EX5_change_subscriber_info`$Header$ST$`01`
#> [1] "834"
#> 
#> $`834_EX5_change_subscriber_info`$Header$ST$`02`
#> [1] "12345"
#> 
#> $`834_EX5_change_subscriber_info`$Header$ST$`03`
#> [1] "005010X220A1"
#> 
#> 
#> $`834_EX5_change_subscriber_info`$Header$BGN
#> $`834_EX5_change_subscriber_info`$Header$BGN$`01`
#> [1] "00"
#> 
#> $`834_EX5_change_subscriber_info`$Header$BGN$`02`
#> [1] "12456"
#> 
#> $`834_EX5_change_subscriber_info`$Header$BGN$`03`
#> [1] "19980520"
#> 
#> $`834_EX5_change_subscriber_info`$Header$BGN$`04`
#> [1] "1200"
#> 
#> $`834_EX5_change_subscriber_info`$Header$BGN$`05`
#> [1] NA
#> 
#> $`834_EX5_change_subscriber_info`$Header$BGN$`06`
#> [1] NA
#> 
#> $`834_EX5_change_subscriber_info`$Header$BGN$`07`
#> [1] NA
#> 
#> $`834_EX5_change_subscriber_info`$Header$BGN$`08`
#> [1] "2"
#> 
#> 
#> $`834_EX5_change_subscriber_info`$Header$QTY
#> NULL
#> 
#> 
#> $`834_EX5_change_subscriber_info`$Trailer
#> $`834_EX5_change_subscriber_info`$Trailer$SE
#> $`834_EX5_change_subscriber_info`$Trailer$SE$`01`
#> [1] "12"
#> 
#> $`834_EX5_change_subscriber_info`$Trailer$SE$`02`
#> [1] "12345"
#> 
#> 
#> $`834_EX5_change_subscriber_info`$Trailer$GE
#> $`834_EX5_change_subscriber_info`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`834_EX5_change_subscriber_info`$Trailer$GE$`02`
#> [1] "000000103"
#> 
#> 
#> $`834_EX5_change_subscriber_info`$Trailer$IEA
#> $`834_EX5_change_subscriber_info`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`834_EX5_change_subscriber_info`$Trailer$IEA$`02`
#> [1] "000000103"
#> 
#> 
#> 
#> 
#> $`834_EX6_cancel_dependent`
#> $`834_EX6_cancel_dependent`$Header
#> $`834_EX6_cancel_dependent`$Header$ISA
#> $`834_EX6_cancel_dependent`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`834_EX6_cancel_dependent`$Header$ISA$`02`
#> [1] NA
#> 
#> $`834_EX6_cancel_dependent`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`834_EX6_cancel_dependent`$Header$ISA$`04`
#> [1] NA
#> 
#> $`834_EX6_cancel_dependent`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`834_EX6_cancel_dependent`$Header$ISA$`06`
#> [1] "SENDERNAME"
#> 
#> $`834_EX6_cancel_dependent`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`834_EX6_cancel_dependent`$Header$ISA$`08`
#> [1] "RECEIVERNAME"
#> 
#> $`834_EX6_cancel_dependent`$Header$ISA$`09`
#> [1] "041227"
#> 
#> $`834_EX6_cancel_dependent`$Header$ISA$`10`
#> [1] "1324"
#> 
#> $`834_EX6_cancel_dependent`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`834_EX6_cancel_dependent`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`834_EX6_cancel_dependent`$Header$ISA$`13`
#> [1] "000000103"
#> 
#> $`834_EX6_cancel_dependent`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`834_EX6_cancel_dependent`$Header$ISA$`15`
#> [1] "P"
#> 
#> $`834_EX6_cancel_dependent`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`834_EX6_cancel_dependent`$Header$GS
#> $`834_EX6_cancel_dependent`$Header$GS$`01`
#> [1] "BE"
#> 
#> $`834_EX6_cancel_dependent`$Header$GS$`02`
#> [1] "SENDERNAME"
#> 
#> $`834_EX6_cancel_dependent`$Header$GS$`03`
#> [1] "RECEIVERNAME"
#> 
#> $`834_EX6_cancel_dependent`$Header$GS$`04`
#> [1] "20041227"
#> 
#> $`834_EX6_cancel_dependent`$Header$GS$`05`
#> [1] "1324"
#> 
#> $`834_EX6_cancel_dependent`$Header$GS$`06`
#> [1] "000000103"
#> 
#> $`834_EX6_cancel_dependent`$Header$GS$`07`
#> [1] "X"
#> 
#> $`834_EX6_cancel_dependent`$Header$GS$`08`
#> [1] "005010X220A1"
#> 
#> 
#> $`834_EX6_cancel_dependent`$Header$ST
#> $`834_EX6_cancel_dependent`$Header$ST$`01`
#> [1] "834"
#> 
#> $`834_EX6_cancel_dependent`$Header$ST$`02`
#> [1] "12345"
#> 
#> $`834_EX6_cancel_dependent`$Header$ST$`03`
#> [1] "005010X220A1"
#> 
#> 
#> $`834_EX6_cancel_dependent`$Header$BGN
#> $`834_EX6_cancel_dependent`$Header$BGN$`01`
#> [1] "00"
#> 
#> $`834_EX6_cancel_dependent`$Header$BGN$`02`
#> [1] "12456"
#> 
#> $`834_EX6_cancel_dependent`$Header$BGN$`03`
#> [1] "19980520"
#> 
#> $`834_EX6_cancel_dependent`$Header$BGN$`04`
#> [1] "1200"
#> 
#> $`834_EX6_cancel_dependent`$Header$BGN$`05`
#> [1] NA
#> 
#> $`834_EX6_cancel_dependent`$Header$BGN$`06`
#> [1] NA
#> 
#> $`834_EX6_cancel_dependent`$Header$BGN$`07`
#> [1] NA
#> 
#> $`834_EX6_cancel_dependent`$Header$BGN$`08`
#> [1] "2"
#> 
#> 
#> $`834_EX6_cancel_dependent`$Header$QTY
#> NULL
#> 
#> 
#> $`834_EX6_cancel_dependent`$Trailer
#> $`834_EX6_cancel_dependent`$Trailer$SE
#> $`834_EX6_cancel_dependent`$Trailer$SE$`01`
#> [1] "12"
#> 
#> $`834_EX6_cancel_dependent`$Trailer$SE$`02`
#> [1] "12345"
#> 
#> 
#> $`834_EX6_cancel_dependent`$Trailer$GE
#> $`834_EX6_cancel_dependent`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`834_EX6_cancel_dependent`$Trailer$GE$`02`
#> [1] "000000103"
#> 
#> 
#> $`834_EX6_cancel_dependent`$Trailer$IEA
#> $`834_EX6_cancel_dependent`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`834_EX6_cancel_dependent`$Trailer$IEA$`02`
#> [1] "000000103"
#> 
#> 
#> 
#> 
#> $`834_EX7_terminate_subscriber_eligibility`
#> $`834_EX7_terminate_subscriber_eligibility`$Header
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ISA
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ISA$`02`
#> [1] NA
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ISA$`04`
#> [1] NA
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ISA$`06`
#> [1] "SENDERNAME"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ISA$`08`
#> [1] "RECEIVERNAME"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ISA$`09`
#> [1] "041227"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ISA$`10`
#> [1] "1324"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ISA$`13`
#> [1] "000000103"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ISA$`15`
#> [1] "P"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$GS
#> $`834_EX7_terminate_subscriber_eligibility`$Header$GS$`01`
#> [1] "BE"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$GS$`02`
#> [1] "SENDERNAME"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$GS$`03`
#> [1] "RECEIVERNAME"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$GS$`04`
#> [1] "20041227"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$GS$`05`
#> [1] "1324"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$GS$`06`
#> [1] "000000103"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$GS$`07`
#> [1] "X"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$GS$`08`
#> [1] "005010X220A1"
#> 
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ST
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ST$`01`
#> [1] "834"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ST$`02`
#> [1] "12345"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$ST$`03`
#> [1] "005010X220A1"
#> 
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$BGN
#> $`834_EX7_terminate_subscriber_eligibility`$Header$BGN$`01`
#> [1] "00"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$BGN$`02`
#> [1] "12456"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$BGN$`03`
#> [1] "19980520"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$BGN$`04`
#> [1] "1200"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$BGN$`05`
#> [1] NA
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$BGN$`06`
#> [1] NA
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$BGN$`07`
#> [1] NA
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$BGN$`08`
#> [1] "2"
#> 
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Header$QTY
#> NULL
#> 
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Trailer
#> $`834_EX7_terminate_subscriber_eligibility`$Trailer$SE
#> $`834_EX7_terminate_subscriber_eligibility`$Trailer$SE$`01`
#> [1] "10"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Trailer$SE$`02`
#> [1] "12345"
#> 
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Trailer$GE
#> $`834_EX7_terminate_subscriber_eligibility`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Trailer$GE$`02`
#> [1] "000000103"
#> 
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Trailer$IEA
#> $`834_EX7_terminate_subscriber_eligibility`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`834_EX7_terminate_subscriber_eligibility`$Trailer$IEA$`02`
#> [1] "000000103"
#> 
#> 
#> 
#> 
#> $`834_EX8_reinstate_employee`
#> $`834_EX8_reinstate_employee`$Header
#> $`834_EX8_reinstate_employee`$Header$ISA
#> $`834_EX8_reinstate_employee`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`834_EX8_reinstate_employee`$Header$ISA$`02`
#> [1] NA
#> 
#> $`834_EX8_reinstate_employee`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`834_EX8_reinstate_employee`$Header$ISA$`04`
#> [1] NA
#> 
#> $`834_EX8_reinstate_employee`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`834_EX8_reinstate_employee`$Header$ISA$`06`
#> [1] "SENDERNAME"
#> 
#> $`834_EX8_reinstate_employee`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`834_EX8_reinstate_employee`$Header$ISA$`08`
#> [1] "RECEIVERNAME"
#> 
#> $`834_EX8_reinstate_employee`$Header$ISA$`09`
#> [1] "041227"
#> 
#> $`834_EX8_reinstate_employee`$Header$ISA$`10`
#> [1] "1324"
#> 
#> $`834_EX8_reinstate_employee`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`834_EX8_reinstate_employee`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`834_EX8_reinstate_employee`$Header$ISA$`13`
#> [1] "000000103"
#> 
#> $`834_EX8_reinstate_employee`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`834_EX8_reinstate_employee`$Header$ISA$`15`
#> [1] "P"
#> 
#> $`834_EX8_reinstate_employee`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`834_EX8_reinstate_employee`$Header$GS
#> $`834_EX8_reinstate_employee`$Header$GS$`01`
#> [1] "BE"
#> 
#> $`834_EX8_reinstate_employee`$Header$GS$`02`
#> [1] "SENDERNAME"
#> 
#> $`834_EX8_reinstate_employee`$Header$GS$`03`
#> [1] "RECEIVERNAME"
#> 
#> $`834_EX8_reinstate_employee`$Header$GS$`04`
#> [1] "20041227"
#> 
#> $`834_EX8_reinstate_employee`$Header$GS$`05`
#> [1] "1324"
#> 
#> $`834_EX8_reinstate_employee`$Header$GS$`06`
#> [1] "000000103"
#> 
#> $`834_EX8_reinstate_employee`$Header$GS$`07`
#> [1] "X"
#> 
#> $`834_EX8_reinstate_employee`$Header$GS$`08`
#> [1] "005010X220A1"
#> 
#> 
#> $`834_EX8_reinstate_employee`$Header$ST
#> $`834_EX8_reinstate_employee`$Header$ST$`01`
#> [1] "834"
#> 
#> $`834_EX8_reinstate_employee`$Header$ST$`02`
#> [1] "12345"
#> 
#> $`834_EX8_reinstate_employee`$Header$ST$`03`
#> [1] "005010X220A1"
#> 
#> 
#> $`834_EX8_reinstate_employee`$Header$BGN
#> $`834_EX8_reinstate_employee`$Header$BGN$`01`
#> [1] "00"
#> 
#> $`834_EX8_reinstate_employee`$Header$BGN$`02`
#> [1] "12456"
#> 
#> $`834_EX8_reinstate_employee`$Header$BGN$`03`
#> [1] "19980520"
#> 
#> $`834_EX8_reinstate_employee`$Header$BGN$`04`
#> [1] "1200"
#> 
#> $`834_EX8_reinstate_employee`$Header$BGN$`05`
#> [1] NA
#> 
#> $`834_EX8_reinstate_employee`$Header$BGN$`06`
#> [1] NA
#> 
#> $`834_EX8_reinstate_employee`$Header$BGN$`07`
#> [1] NA
#> 
#> $`834_EX8_reinstate_employee`$Header$BGN$`08`
#> [1] "2"
#> 
#> 
#> $`834_EX8_reinstate_employee`$Header$QTY
#> NULL
#> 
#> 
#> $`834_EX8_reinstate_employee`$Trailer
#> $`834_EX8_reinstate_employee`$Trailer$SE
#> $`834_EX8_reinstate_employee`$Trailer$SE$`01`
#> [1] "11"
#> 
#> $`834_EX8_reinstate_employee`$Trailer$SE$`02`
#> [1] "12345"
#> 
#> 
#> $`834_EX8_reinstate_employee`$Trailer$GE
#> $`834_EX8_reinstate_employee`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`834_EX8_reinstate_employee`$Trailer$GE$`02`
#> [1] "000000103"
#> 
#> 
#> $`834_EX8_reinstate_employee`$Trailer$IEA
#> $`834_EX8_reinstate_employee`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`834_EX8_reinstate_employee`$Trailer$IEA$`02`
#> [1] "000000103"
#> 
#> 
#> 
#> 
#> $`834_EX9_reinstate_employee_coverage`
#> $`834_EX9_reinstate_employee_coverage`$Header
#> $`834_EX9_reinstate_employee_coverage`$Header$ISA
#> $`834_EX9_reinstate_employee_coverage`$Header$ISA$`01`
#> [1] "00"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$ISA$`02`
#> [1] NA
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$ISA$`03`
#> [1] "00"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$ISA$`04`
#> [1] NA
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$ISA$`06`
#> [1] "SENDERNAME"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$ISA$`08`
#> [1] "RECEIVERNAME"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$ISA$`09`
#> [1] "041227"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$ISA$`10`
#> [1] "1324"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$ISA$`11`
#> [1] "^"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$ISA$`12`
#> [1] "00501"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$ISA$`13`
#> [1] "000000103"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$ISA$`14`
#> [1] "0"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$ISA$`15`
#> [1] "P"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$ISA$`16`
#> [1] ">"
#> 
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$GS
#> $`834_EX9_reinstate_employee_coverage`$Header$GS$`01`
#> [1] "BE"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$GS$`02`
#> [1] "SENDERNAME"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$GS$`03`
#> [1] "RECEIVERNAME"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$GS$`04`
#> [1] "20041227"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$GS$`05`
#> [1] "1324"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$GS$`06`
#> [1] "000000103"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$GS$`07`
#> [1] "X"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$GS$`08`
#> [1] "005010X220A1"
#> 
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$ST
#> $`834_EX9_reinstate_employee_coverage`$Header$ST$`01`
#> [1] "834"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$ST$`02`
#> [1] "12345"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$ST$`03`
#> [1] "005010X220A1"
#> 
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$BGN
#> $`834_EX9_reinstate_employee_coverage`$Header$BGN$`01`
#> [1] "00"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$BGN$`02`
#> [1] "12456"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$BGN$`03`
#> [1] "20020601"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$BGN$`04`
#> [1] "1200"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$BGN$`05`
#> [1] NA
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$BGN$`06`
#> [1] NA
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$BGN$`07`
#> [1] NA
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$BGN$`08`
#> [1] "2"
#> 
#> 
#> $`834_EX9_reinstate_employee_coverage`$Header$QTY
#> NULL
#> 
#> 
#> $`834_EX9_reinstate_employee_coverage`$Trailer
#> $`834_EX9_reinstate_employee_coverage`$Trailer$SE
#> $`834_EX9_reinstate_employee_coverage`$Trailer$SE$`01`
#> [1] "12"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Trailer$SE$`02`
#> [1] "12345"
#> 
#> 
#> $`834_EX9_reinstate_employee_coverage`$Trailer$GE
#> $`834_EX9_reinstate_employee_coverage`$Trailer$GE$`01`
#> [1] "1"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Trailer$GE$`02`
#> [1] "000000103"
#> 
#> 
#> $`834_EX9_reinstate_employee_coverage`$Trailer$IEA
#> $`834_EX9_reinstate_employee_coverage`$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $`834_EX9_reinstate_employee_coverage`$Trailer$IEA$`02`
#> [1] "000000103"
#> 
#> 
#> 
#> 
#> $sample_834_01
#> $sample_834_01$Header
#> $sample_834_01$Header$ISA
#> $sample_834_01$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_834_01$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_834_01$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_834_01$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_834_01$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $sample_834_01$Header$ISA$`06`
#> [1] "DHCS"
#> 
#> $sample_834_01$Header$ISA$`07`
#> [1] "ZZ"
#> 
#> $sample_834_01$Header$ISA$`08`
#> [1] "HEALTHPLAN"
#> 
#> $sample_834_01$Header$ISA$`09`
#> [1] "250108"
#> 
#> $sample_834_01$Header$ISA$`10`
#> [1] "1430"
#> 
#> $sample_834_01$Header$ISA$`11`
#> [1] "^"
#> 
#> $sample_834_01$Header$ISA$`12`
#> [1] "00501"
#> 
#> $sample_834_01$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $sample_834_01$Header$ISA$`14`
#> [1] "0"
#> 
#> $sample_834_01$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_834_01$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_834_01$Header$GS
#> $sample_834_01$Header$GS$`01`
#> [1] "BE"
#> 
#> $sample_834_01$Header$GS$`02`
#> [1] "DHCS"
#> 
#> $sample_834_01$Header$GS$`03`
#> [1] "HEALTHPLAN"
#> 
#> $sample_834_01$Header$GS$`04`
#> [1] "20250108"
#> 
#> $sample_834_01$Header$GS$`05`
#> [1] "1430"
#> 
#> $sample_834_01$Header$GS$`06`
#> [1] "1"
#> 
#> $sample_834_01$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_834_01$Header$GS$`08`
#> [1] "005010X220A1"
#> 
#> 
#> $sample_834_01$Header$ST
#> $sample_834_01$Header$ST$`01`
#> [1] "834"
#> 
#> $sample_834_01$Header$ST$`02`
#> [1] "0001"
#> 
#> $sample_834_01$Header$ST$`03`
#> [1] "005010X220A1"
#> 
#> 
#> $sample_834_01$Header$BGN
#> $sample_834_01$Header$BGN$`01`
#> [1] "00"
#> 
#> $sample_834_01$Header$BGN$`02`
#> [1] "12345"
#> 
#> $sample_834_01$Header$BGN$`03`
#> [1] "20250108"
#> 
#> $sample_834_01$Header$BGN$`04`
#> [1] "1430"
#> 
#> $sample_834_01$Header$BGN$`05`
#> [1] NA
#> 
#> $sample_834_01$Header$BGN$`06`
#> [1] NA
#> 
#> $sample_834_01$Header$BGN$`07`
#> [1] NA
#> 
#> $sample_834_01$Header$BGN$`08`
#> [1] "2"
#> 
#> 
#> $sample_834_01$Header$QTY
#> NULL
#> 
#> 
#> $sample_834_01$Trailer
#> $sample_834_01$Trailer$SE
#> $sample_834_01$Trailer$SE$`01`
#> [1] "68"
#> 
#> $sample_834_01$Trailer$SE$`02`
#> [1] "0001"
#> 
#> 
#> $sample_834_01$Trailer$GE
#> $sample_834_01$Trailer$GE$`01`
#> [1] "1"
#> 
#> $sample_834_01$Trailer$GE$`02`
#> [1] "1"
#> 
#> 
#> $sample_834_01$Trailer$IEA
#> $sample_834_01$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_834_01$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $sample_834_02
#> $sample_834_02$Header
#> $sample_834_02$Header$ISA
#> $sample_834_02$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_834_02$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_834_02$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_834_02$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_834_02$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $sample_834_02$Header$ISA$`06`
#> [1] "CADHCS_5010_834"
#> 
#> $sample_834_02$Header$ISA$`07`
#> [1] "30"
#> 
#> $sample_834_02$Header$ISA$`08`
#> [1] "999999991"
#> 
#> $sample_834_02$Header$ISA$`09`
#> [1] "250124"
#> 
#> $sample_834_02$Header$ISA$`10`
#> [1] "1927"
#> 
#> $sample_834_02$Header$ISA$`11`
#> [1] "^"
#> 
#> $sample_834_02$Header$ISA$`12`
#> [1] "00501"
#> 
#> $sample_834_02$Header$ISA$`13`
#> [1] "000000001"
#> 
#> $sample_834_02$Header$ISA$`14`
#> [1] "0"
#> 
#> $sample_834_02$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_834_02$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_834_02$Header$GS
#> $sample_834_02$Header$GS$`01`
#> [1] "BE"
#> 
#> $sample_834_02$Header$GS$`02`
#> [1] "CADHCS_5010_834"
#> 
#> $sample_834_02$Header$GS$`03`
#> [1] "999999991"
#> 
#> $sample_834_02$Header$GS$`04`
#> [1] "20250124"
#> 
#> $sample_834_02$Header$GS$`05`
#> [1] "192730"
#> 
#> $sample_834_02$Header$GS$`06`
#> [1] "10000001"
#> 
#> $sample_834_02$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_834_02$Header$GS$`08`
#> [1] "005010X220A1"
#> 
#> 
#> $sample_834_02$Header$ST
#> $sample_834_02$Header$ST$`01`
#> [1] "834"
#> 
#> $sample_834_02$Header$ST$`02`
#> [1] "0001"
#> 
#> $sample_834_02$Header$ST$`03`
#> [1] "005010X220A1"
#> 
#> 
#> $sample_834_02$Header$BGN
#> $sample_834_02$Header$BGN$`01`
#> [1] "00"
#> 
#> $sample_834_02$Header$BGN$`02`
#> [1] "DHCS834-DA-20250124-Sample PACE-001"
#> 
#> $sample_834_02$Header$BGN$`03`
#> [1] "20250124"
#> 
#> $sample_834_02$Header$BGN$`04`
#> [1] "19273000"
#> 
#> $sample_834_02$Header$BGN$`05`
#> [1] NA
#> 
#> $sample_834_02$Header$BGN$`06`
#> [1] NA
#> 
#> $sample_834_02$Header$BGN$`07`
#> [1] NA
#> 
#> $sample_834_02$Header$BGN$`08`
#> [1] "2"
#> 
#> 
#> $sample_834_02$Header$QTY
#> $sample_834_02$Header$QTY$`01`
#> [1] "TO"
#> 
#> $sample_834_02$Header$QTY$`02`
#> [1] "1"
#> 
#> 
#> 
#> $sample_834_02$Trailer
#> $sample_834_02$Trailer$SE
#> $sample_834_02$Trailer$SE$`01`
#> [1] "29"
#> 
#> $sample_834_02$Trailer$SE$`02`
#> [1] "0001"
#> 
#> 
#> $sample_834_02$Trailer$GE
#> $sample_834_02$Trailer$GE$`01`
#> [1] "1"
#> 
#> $sample_834_02$Trailer$GE$`02`
#> [1] "10000001"
#> 
#> 
#> $sample_834_02$Trailer$IEA
#> $sample_834_02$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_834_02$Trailer$IEA$`02`
#> [1] "000000001"
#> 
#> 
#> 
#> 
#> $sample_834_03
#> $sample_834_03$Header
#> $sample_834_03$Header$ISA
#> $sample_834_03$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_834_03$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_834_03$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_834_03$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_834_03$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $sample_834_03$Header$ISA$`06`
#> [1] "CADHCS_5010_834"
#> 
#> $sample_834_03$Header$ISA$`07`
#> [1] "30"
#> 
#> $sample_834_03$Header$ISA$`08`
#> [1] "999999992"
#> 
#> $sample_834_03$Header$ISA$`09`
#> [1] "250812"
#> 
#> $sample_834_03$Header$ISA$`10`
#> [1] "1936"
#> 
#> $sample_834_03$Header$ISA$`11`
#> [1] "^"
#> 
#> $sample_834_03$Header$ISA$`12`
#> [1] "00501"
#> 
#> $sample_834_03$Header$ISA$`13`
#> [1] "000000002"
#> 
#> $sample_834_03$Header$ISA$`14`
#> [1] "0"
#> 
#> $sample_834_03$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_834_03$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_834_03$Header$GS
#> $sample_834_03$Header$GS$`01`
#> [1] "BE"
#> 
#> $sample_834_03$Header$GS$`02`
#> [1] "CADHCS_5010_834"
#> 
#> $sample_834_03$Header$GS$`03`
#> [1] "999999992"
#> 
#> $sample_834_03$Header$GS$`04`
#> [1] "20250812"
#> 
#> $sample_834_03$Header$GS$`05`
#> [1] "193641"
#> 
#> $sample_834_03$Header$GS$`06`
#> [1] "10000002"
#> 
#> $sample_834_03$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_834_03$Header$GS$`08`
#> [1] "005010X220A1"
#> 
#> 
#> $sample_834_03$Header$ST
#> $sample_834_03$Header$ST$`01`
#> [1] "834"
#> 
#> $sample_834_03$Header$ST$`02`
#> [1] "0001"
#> 
#> $sample_834_03$Header$ST$`03`
#> [1] "005010X220A1"
#> 
#> 
#> $sample_834_03$Header$BGN
#> $sample_834_03$Header$BGN$`01`
#> [1] "00"
#> 
#> $sample_834_03$Header$BGN$`02`
#> [1] "DHCS834-DA-20250812-Sample South LA PACE-957-001"
#> 
#> $sample_834_03$Header$BGN$`03`
#> [1] "20250812"
#> 
#> $sample_834_03$Header$BGN$`04`
#> [1] "19364100"
#> 
#> $sample_834_03$Header$BGN$`05`
#> [1] NA
#> 
#> $sample_834_03$Header$BGN$`06`
#> [1] NA
#> 
#> $sample_834_03$Header$BGN$`07`
#> [1] NA
#> 
#> $sample_834_03$Header$BGN$`08`
#> [1] "2"
#> 
#> 
#> $sample_834_03$Header$QTY
#> $sample_834_03$Header$QTY$`01`
#> [1] "TO"
#> 
#> $sample_834_03$Header$QTY$`02`
#> [1] "1"
#> 
#> 
#> 
#> $sample_834_03$Trailer
#> $sample_834_03$Trailer$SE
#> $sample_834_03$Trailer$SE$`01`
#> [1] "32"
#> 
#> $sample_834_03$Trailer$SE$`02`
#> [1] "0001"
#> 
#> 
#> $sample_834_03$Trailer$GE
#> $sample_834_03$Trailer$GE$`01`
#> [1] "1"
#> 
#> $sample_834_03$Trailer$GE$`02`
#> [1] "10000002"
#> 
#> 
#> $sample_834_03$Trailer$IEA
#> $sample_834_03$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_834_03$Trailer$IEA$`02`
#> [1] "000000002"
#> 
#> 
#> 
#> 
#> $sample_834_04
#> $sample_834_04$Header
#> $sample_834_04$Header$ISA
#> $sample_834_04$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_834_04$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_834_04$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_834_04$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_834_04$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $sample_834_04$Header$ISA$`06`
#> [1] "CADHCS_5010_834"
#> 
#> $sample_834_04$Header$ISA$`07`
#> [1] "30"
#> 
#> $sample_834_04$Header$ISA$`08`
#> [1] "999999992"
#> 
#> $sample_834_04$Header$ISA$`09`
#> [1] "251022"
#> 
#> $sample_834_04$Header$ISA$`10`
#> [1] "2000"
#> 
#> $sample_834_04$Header$ISA$`11`
#> [1] "^"
#> 
#> $sample_834_04$Header$ISA$`12`
#> [1] "00501"
#> 
#> $sample_834_04$Header$ISA$`13`
#> [1] "000000003"
#> 
#> $sample_834_04$Header$ISA$`14`
#> [1] "0"
#> 
#> $sample_834_04$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_834_04$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_834_04$Header$GS
#> $sample_834_04$Header$GS$`01`
#> [1] "BE"
#> 
#> $sample_834_04$Header$GS$`02`
#> [1] "CADHCS_5010_834"
#> 
#> $sample_834_04$Header$GS$`03`
#> [1] "999999992"
#> 
#> $sample_834_04$Header$GS$`04`
#> [1] "20251022"
#> 
#> $sample_834_04$Header$GS$`05`
#> [1] "200019"
#> 
#> $sample_834_04$Header$GS$`06`
#> [1] "10000003"
#> 
#> $sample_834_04$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_834_04$Header$GS$`08`
#> [1] "005010X220A1"
#> 
#> 
#> $sample_834_04$Header$ST
#> $sample_834_04$Header$ST$`01`
#> [1] "834"
#> 
#> $sample_834_04$Header$ST$`02`
#> [1] "0001"
#> 
#> $sample_834_04$Header$ST$`03`
#> [1] "005010X220A1"
#> 
#> 
#> $sample_834_04$Header$BGN
#> $sample_834_04$Header$BGN$`01`
#> [1] "00"
#> 
#> $sample_834_04$Header$BGN$`02`
#> [1] "DHCS834-DA-20251022-Sample South LA PACE-957-001"
#> 
#> $sample_834_04$Header$BGN$`03`
#> [1] "20251022"
#> 
#> $sample_834_04$Header$BGN$`04`
#> [1] "20001900"
#> 
#> $sample_834_04$Header$BGN$`05`
#> [1] NA
#> 
#> $sample_834_04$Header$BGN$`06`
#> [1] NA
#> 
#> $sample_834_04$Header$BGN$`07`
#> [1] NA
#> 
#> $sample_834_04$Header$BGN$`08`
#> [1] "2"
#> 
#> 
#> $sample_834_04$Header$QTY
#> $sample_834_04$Header$QTY$`01`
#> [1] "TO"
#> 
#> $sample_834_04$Header$QTY$`02`
#> [1] "1"
#> 
#> 
#> 
#> $sample_834_04$Trailer
#> $sample_834_04$Trailer$SE
#> $sample_834_04$Trailer$SE$`01`
#> [1] "31"
#> 
#> $sample_834_04$Trailer$SE$`02`
#> [1] "0001"
#> 
#> 
#> $sample_834_04$Trailer$GE
#> $sample_834_04$Trailer$GE$`01`
#> [1] "1"
#> 
#> $sample_834_04$Trailer$GE$`02`
#> [1] "10000003"
#> 
#> 
#> $sample_834_04$Trailer$IEA
#> $sample_834_04$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_834_04$Trailer$IEA$`02`
#> [1] "000000003"
#> 
#> 
#> 
#> 
#> $sample_834_05
#> $sample_834_05$Header
#> $sample_834_05$Header$ISA
#> $sample_834_05$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_834_05$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_834_05$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_834_05$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_834_05$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $sample_834_05$Header$ISA$`06`
#> [1] "CADHCS_5010_834"
#> 
#> $sample_834_05$Header$ISA$`07`
#> [1] "30"
#> 
#> $sample_834_05$Header$ISA$`08`
#> [1] "999999992"
#> 
#> $sample_834_05$Header$ISA$`09`
#> [1] "251023"
#> 
#> $sample_834_05$Header$ISA$`10`
#> [1] "1959"
#> 
#> $sample_834_05$Header$ISA$`11`
#> [1] "^"
#> 
#> $sample_834_05$Header$ISA$`12`
#> [1] "00501"
#> 
#> $sample_834_05$Header$ISA$`13`
#> [1] "000000004"
#> 
#> $sample_834_05$Header$ISA$`14`
#> [1] "0"
#> 
#> $sample_834_05$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_834_05$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_834_05$Header$GS
#> $sample_834_05$Header$GS$`01`
#> [1] "BE"
#> 
#> $sample_834_05$Header$GS$`02`
#> [1] "CADHCS_5010_834"
#> 
#> $sample_834_05$Header$GS$`03`
#> [1] "999999992"
#> 
#> $sample_834_05$Header$GS$`04`
#> [1] "20251023"
#> 
#> $sample_834_05$Header$GS$`05`
#> [1] "195928"
#> 
#> $sample_834_05$Header$GS$`06`
#> [1] "10000004"
#> 
#> $sample_834_05$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_834_05$Header$GS$`08`
#> [1] "005010X220A1"
#> 
#> 
#> $sample_834_05$Header$ST
#> $sample_834_05$Header$ST$`01`
#> [1] "834"
#> 
#> $sample_834_05$Header$ST$`02`
#> [1] "0001"
#> 
#> $sample_834_05$Header$ST$`03`
#> [1] "005010X220A1"
#> 
#> 
#> $sample_834_05$Header$BGN
#> $sample_834_05$Header$BGN$`01`
#> [1] "00"
#> 
#> $sample_834_05$Header$BGN$`02`
#> [1] "DHCS834-DA-20251023-Sample South LA PACE-957-001"
#> 
#> $sample_834_05$Header$BGN$`03`
#> [1] "20251023"
#> 
#> $sample_834_05$Header$BGN$`04`
#> [1] "19592800"
#> 
#> $sample_834_05$Header$BGN$`05`
#> [1] NA
#> 
#> $sample_834_05$Header$BGN$`06`
#> [1] NA
#> 
#> $sample_834_05$Header$BGN$`07`
#> [1] NA
#> 
#> $sample_834_05$Header$BGN$`08`
#> [1] "2"
#> 
#> 
#> $sample_834_05$Header$QTY
#> $sample_834_05$Header$QTY$`01`
#> [1] "TO"
#> 
#> $sample_834_05$Header$QTY$`02`
#> [1] "1"
#> 
#> 
#> 
#> $sample_834_05$Trailer
#> $sample_834_05$Trailer$SE
#> $sample_834_05$Trailer$SE$`01`
#> [1] "31"
#> 
#> $sample_834_05$Trailer$SE$`02`
#> [1] "0001"
#> 
#> 
#> $sample_834_05$Trailer$GE
#> $sample_834_05$Trailer$GE$`01`
#> [1] "1"
#> 
#> $sample_834_05$Trailer$GE$`02`
#> [1] "10000004"
#> 
#> 
#> $sample_834_05$Trailer$IEA
#> $sample_834_05$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_834_05$Trailer$IEA$`02`
#> [1] "000000004"
#> 
#> 
#> 
#> 
#> $sample_834_06
#> $sample_834_06$Header
#> $sample_834_06$Header$ISA
#> $sample_834_06$Header$ISA$`01`
#> [1] "00"
#> 
#> $sample_834_06$Header$ISA$`02`
#> [1] NA
#> 
#> $sample_834_06$Header$ISA$`03`
#> [1] "00"
#> 
#> $sample_834_06$Header$ISA$`04`
#> [1] NA
#> 
#> $sample_834_06$Header$ISA$`05`
#> [1] "ZZ"
#> 
#> $sample_834_06$Header$ISA$`06`
#> [1] "CADHCS_5010_834"
#> 
#> $sample_834_06$Header$ISA$`07`
#> [1] "30"
#> 
#> $sample_834_06$Header$ISA$`08`
#> [1] "999999991"
#> 
#> $sample_834_06$Header$ISA$`09`
#> [1] "250206"
#> 
#> $sample_834_06$Header$ISA$`10`
#> [1] "2008"
#> 
#> $sample_834_06$Header$ISA$`11`
#> [1] "^"
#> 
#> $sample_834_06$Header$ISA$`12`
#> [1] "00501"
#> 
#> $sample_834_06$Header$ISA$`13`
#> [1] "000000005"
#> 
#> $sample_834_06$Header$ISA$`14`
#> [1] "0"
#> 
#> $sample_834_06$Header$ISA$`15`
#> [1] "P"
#> 
#> $sample_834_06$Header$ISA$`16`
#> [1] ":"
#> 
#> 
#> $sample_834_06$Header$GS
#> $sample_834_06$Header$GS$`01`
#> [1] "BE"
#> 
#> $sample_834_06$Header$GS$`02`
#> [1] "CADHCS_5010_834"
#> 
#> $sample_834_06$Header$GS$`03`
#> [1] "999999991"
#> 
#> $sample_834_06$Header$GS$`04`
#> [1] "20250206"
#> 
#> $sample_834_06$Header$GS$`05`
#> [1] "200823"
#> 
#> $sample_834_06$Header$GS$`06`
#> [1] "10000005"
#> 
#> $sample_834_06$Header$GS$`07`
#> [1] "X"
#> 
#> $sample_834_06$Header$GS$`08`
#> [1] "005010X220A1"
#> 
#> 
#> $sample_834_06$Header$ST
#> $sample_834_06$Header$ST$`01`
#> [1] "834"
#> 
#> $sample_834_06$Header$ST$`02`
#> [1] "0001"
#> 
#> $sample_834_06$Header$ST$`03`
#> [1] "005010X220A1"
#> 
#> 
#> $sample_834_06$Header$BGN
#> $sample_834_06$Header$BGN$`01`
#> [1] "00"
#> 
#> $sample_834_06$Header$BGN$`02`
#> [1] "DHCS834-DA-20250206-Sample PACE-001"
#> 
#> $sample_834_06$Header$BGN$`03`
#> [1] "20250206"
#> 
#> $sample_834_06$Header$BGN$`04`
#> [1] "20082300"
#> 
#> $sample_834_06$Header$BGN$`05`
#> [1] NA
#> 
#> $sample_834_06$Header$BGN$`06`
#> [1] NA
#> 
#> $sample_834_06$Header$BGN$`07`
#> [1] NA
#> 
#> $sample_834_06$Header$BGN$`08`
#> [1] "2"
#> 
#> 
#> $sample_834_06$Header$QTY
#> $sample_834_06$Header$QTY$`01`
#> [1] "TO"
#> 
#> $sample_834_06$Header$QTY$`02`
#> [1] "2"
#> 
#> 
#> 
#> $sample_834_06$Trailer
#> $sample_834_06$Trailer$SE
#> $sample_834_06$Trailer$SE$`01`
#> [1] "64"
#> 
#> $sample_834_06$Trailer$SE$`02`
#> [1] "0001"
#> 
#> 
#> $sample_834_06$Trailer$GE
#> $sample_834_06$Trailer$GE$`01`
#> [1] "1"
#> 
#> $sample_834_06$Trailer$GE$`02`
#> [1] "10000005"
#> 
#> 
#> $sample_834_06$Trailer$IEA
#> $sample_834_06$Trailer$IEA$`01`
#> [1] "1"
#> 
#> $sample_834_06$Trailer$IEA$`02`
#> [1] "000000005"
#> 
#> 
#> 
#> 
```
