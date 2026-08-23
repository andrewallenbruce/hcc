# Map ICD-10 Codes to CC

Map ICD-10 Codes to CC

## Usage

``` r
apply_map(icd, model, year = 2025L)
```

## Arguments

- icd:

  `<chr>` ICD-10 diagnosis code(s)

- model:

  `<chr>` HCC model name to use for hierarchy rules; one of:

  - CMS-HCC Model V22

  - CMS-HCC Model V24

  - CMS-HCC Model V28

  - RxHCC Model V08

  - RxHCC Model V05

- year:

  `<int>` 2025 (default) or 2026

## Value

`<chr>` CCs mapped to diagnosis codes

## Examples

``` r
apply_map(icd = "E119", model = "CMS-HCC Model V28")
#> # A tibble: 1 × 4
#>    year diagnosis_code    cc model_name       
#>   <int> <chr>          <int> <chr>            
#> 1  2025 E119              38 CMS-HCC Model V28
apply_map(icd = "E119", model = "CMS-HCC Model V24")
#> # A tibble: 1 × 4
#>    year diagnosis_code    cc model_name       
#>   <int> <chr>          <int> <chr>            
#> 1  2025 E119              19 CMS-HCC Model V24
apply_map(icd = "E119", model = "CMS-HCC ESRD Model V21")
#> # A tibble: 1 × 4
#>    year diagnosis_code    cc model_name            
#>   <int> <chr>          <int> <chr>                 
#> 1  2025 E119              19 CMS-HCC ESRD Model V21
apply_map(icd = "I5022", model = "CMS-HCC Model V28")
#> # A tibble: 1 × 4
#>    year diagnosis_code    cc model_name       
#>   <int> <chr>          <int> <chr>            
#> 1  2025 I5022            226 CMS-HCC Model V28
apply_map(icd = c("E103213", "I5022", "Z9999"), model = "CMS-HCC Model V28")
#> # A tibble: 3 × 4
#>    year diagnosis_code    cc model_name       
#>   <int> <chr>          <int> <chr>            
#> 1  2025 E103213           37 CMS-HCC Model V28
#> 2  2025 E103213          298 CMS-HCC Model V28
#> 3  2025 I5022            226 CMS-HCC Model V28
apply_map(icd = c("E103213", "I5022", "Z9999"), model = "CMS-HCC Model V24")
#> # A tibble: 2 × 4
#>    year diagnosis_code    cc model_name       
#>   <int> <chr>          <int> <chr>            
#> 1  2025 E103213           18 CMS-HCC Model V24
#> 2  2025 I5022             85 CMS-HCC Model V24
```
