# Apply CMS Edit Rules

Apply age/sex edits to CC mappings based on CMS edit rules. Edits are
applied AFTER initial ICD -\> CC mapping but BEFORE hierarchies.

## Usage

``` r
edit_rules(icd, age = NULL, sex = NULL, model = "C28")
```

## Arguments

- icd:

  `<chr>` ICD-10-CM diagnosis code

- age:

  `<int>` Patient's age; Max = 49\|17, Min = 2

- sex:

  `<chr>` Patient's sex; 2 rules for Female ("F/2")

- model:

  `<chr>` Only one is "C28"

## Value

Modified
[`icd_to_cc()`](https://andrewallenbruce.github.io/hcc/reference/hierarchies.md)
output with edits applied

## Details

Edit types:

- `invalid`: Remove the diagnosis (don't assign any CC)

- `override`: Assign a different CC than the default mapping

## Examples

``` r
icd_to_cc(icd = c("D67", "C50522"), model = "C28", year = 2026L)
#> # A tibble: 2 × 4
#>    year icd_code    cc model_name       
#>   <int> <chr>    <int> <chr>            
#> 1  2026 C50522      23 CMS-HCC Model V28
#> 2  2026 D67        111 CMS-HCC Model V28
edit_rules(icd = c("D67", "C50522"), age = 56L, sex = "F", model = "C28")
#> # A tibble: 2 × 4
#>    year icd_code    cc model_name       
#>   <int> <chr>    <int> <chr>            
#> 1  2026 C50522      22 CMS-HCC Model V28
#> 2  2026 D67        112 CMS-HCC Model V28
```
