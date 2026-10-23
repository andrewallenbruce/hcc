# Map ICD-10 Codes to CC

Map ICD-10 Codes to CC

## Usage

``` r
icd_to_cc(icd = NULL, model = "C28", year = 2025, simplify = FALSE)
```

## Arguments

- icd:

  `<chr>` ICD-10 diagnosis code(s)

- model:

  `<chr>` Model name, default is "C28"; one of:

  - `C22`: CMS-HCC Model V22

  - `C24`: CMS-HCC Model V24

  - `C28`: CMS-HCC Model V28

  - `D21`: CMS-HCC ESRD Model V21

  - `D24`: CMS-HCC ESRD Model V24

  - `R05`: RxHCC Model V05

  - `R08`: RxHCC Model V08

- year:

  `<int>` 2025, 2026

- simplify:

  `<lgl>` Return a named list; default is FALSE

## Value

`<chr>` CCs mapped to diagnosis codes

## Examples

``` r
icd_to_cc("E119")
#> # A tibble: 1 × 4
#>    year icd_code    cc model_name       
#>   <int> <chr>    <int> <chr>            
#> 1  2025 E119        38 CMS-HCC Model V28
icd_to_cc("E119", "C24")
#> # A tibble: 1 × 4
#>    year icd_code    cc model_name       
#>   <int> <chr>    <int> <chr>            
#> 1  2025 E119        19 CMS-HCC Model V24
icd_to_cc("E119", "D21")
#> # A tibble: 1 × 4
#>    year icd_code    cc model_name            
#>   <int> <chr>    <int> <chr>                 
#> 1  2025 E119        19 CMS-HCC ESRD Model V21
icd_to_cc("I5022")
#> # A tibble: 1 × 4
#>    year icd_code    cc model_name       
#>   <int> <chr>    <int> <chr>            
#> 1  2025 I5022      226 CMS-HCC Model V28
icd_to_cc(c("E103213", "I5022", "Z9999"))
#> # A tibble: 3 × 4
#>    year icd_code    cc model_name       
#>   <int> <chr>    <int> <chr>            
#> 1  2025 E103213     37 CMS-HCC Model V28
#> 2  2025 I5022      226 CMS-HCC Model V28
#> 3  2025 E103213    298 CMS-HCC Model V28
```
