# Apply HCC Rules

Applies hierarchical rules to a set of CCs based on the selected model
version.

## Usage

``` r
hierarchies(cc, model = "C28", year = 2025)

icd_to_cc(icd = NULL, model = "C28", year = 2025, simplify = FALSE)
```

## Arguments

- cc:

  `<int>` Set of currently active CCs

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

  `<int>` 2025 or 2026; default is 2025

- icd:

  `<chr>` ICD-10 diagnosis code(s)

- simplify:

  `<lgl>` Return a named list; default is FALSE

## Value

An `<int>` vector; one of:

- CCs mapped to diagnosis codes

- CCs after applying hierarchies

- Empty vector, indicating the input CCs do not exist in the model/year

## Examples

``` r
hierarchies(17:19)
#> [1] 17
hierarchies(18:19)
#> [1] 18
hierarchies(223L)
#> integer(0)
hierarchies(c(221L, 223L))
#> [1] 221 223
hierarchies(134:135, "D21")
#> [1] 135
hierarchies(134:137, "D24")
#> integer(0)
hierarchies(17L)
#> [1] 17

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
