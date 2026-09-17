# Map ICD-10 Codes to CC

Map ICD-10 Codes to CC

## Usage

``` r
apply_map(icd = NULL, model = NULL, year = NULL)
```

## Arguments

- icd:

  `<chr>` ICD-10 diagnosis code(s)

- model:

  `<chr>` HCC model name to use for hierarchy rules; one of:

  - `v22`: CMS-HCC Model V22

  - `v24`: CMS-HCC Model V24

  - `v28`: CMS-HCC Model V28

  - `e21`: CMS-HCC ESRD Model V21

  - `e24`: CMS-HCC ESRD Model V24

  - `rx5`: RxHCC Model V05

  - `rx8`: RxHCC Model V08

- year:

  `<int>` 2025 (default) or 2026

## Value

`<chr>` CCs mapped to diagnosis codes

## Examples

``` r
apply_map("E119", "v28", 2026)
#> # A tibble: 1 × 4
#>    year diagnosis_code    cc model_name       
#>   <int> <chr>          <int> <chr>            
#> 1  2026 E119              38 CMS-HCC Model V28
apply_map("E119", "v24", 2026)
#> # A tibble: 1 × 4
#>    year diagnosis_code    cc model_name       
#>   <int> <chr>          <int> <chr>            
#> 1  2026 E119              19 CMS-HCC Model V24
apply_map("E119", "e21", 2026)
#> # A tibble: 1 × 4
#>    year diagnosis_code    cc model_name            
#>   <int> <chr>          <int> <chr>                 
#> 1  2026 E119              19 CMS-HCC ESRD Model V21
apply_map("I5022", "v28", 2026)
#> # A tibble: 1 × 4
#>    year diagnosis_code    cc model_name       
#>   <int> <chr>          <int> <chr>            
#> 1  2026 I5022            226 CMS-HCC Model V28
apply_map(c("E103213", "I5022", "Z9999"), "v28", 2026)
#> # A tibble: 3 × 4
#>    year diagnosis_code    cc model_name       
#>   <int> <chr>          <int> <chr>            
#> 1  2026 E103213           37 CMS-HCC Model V28
#> 2  2026 E103213          298 CMS-HCC Model V28
#> 3  2026 I5022            226 CMS-HCC Model V28
apply_map(c("E103213", "I5022", "Z9999"), "v24", 2026)
#> # A tibble: 2 × 4
#>    year diagnosis_code    cc model_name       
#>   <int> <chr>          <int> <chr>            
#> 1  2026 E103213           18 CMS-HCC Model V24
#> 2  2026 I5022             85 CMS-HCC Model V24
```
