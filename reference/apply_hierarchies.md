# Apply hierarchical rules to a set of CCs based on model version.

Apply hierarchical rules to a set of CCs based on model version.

## Usage

``` r
apply_hierarchies(cc, model, year = 2025L)
```

## Arguments

- cc:

  `<chr>` Set of current active CCs

- model:

  `<chr>` HCC model name to use for hierarchy rules; one of:

  - `C22`: CMS-HCC Model V22

  - `C24`: CMS-HCC Model V24

  - `C28`: CMS-HCC Model V28

  - `D21`: CMS-HCC ESRD Model V21

  - `D24`: CMS-HCC ESRD Model V24

  - `R05`: RxHCC Model V05

  - `R08`: RxHCC Model V08

- year:

  `<int>` 2025, 2026

## Value

Set of CCs after applying hierarchies

## Examples

``` r
apply_hierarchies(cc = 17:19, model = "C28")
#> [1] 17
```
