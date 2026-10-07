# Apply hierarchical rules to a set of CCs based on model version.

Apply hierarchical rules to a set of CCs based on model version.

## Usage

``` r
hierarchies(cc, model, year = 2025L)
```

## Arguments

- cc:

  `<chr>` Set of current active CCs

- model:

  `<chr>` HCC model name to use for hierarchy rules; one of:

  - `C20`: CMS-HCC Model V20

  - `C22`: CMS-HCC Model V22

  - `C23`: CMS-HCC Model V23

  - `C24`: CMS-HCC Model V24

  - `C28`: CMS-HCC Model V28

  - `D20`: CMS-HCC ESRD Model V20

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
hierarchies(17:19, "C28")
#> [1] 17
hierarchies(18:19, "C28")
#> [1] 18
hierarchies(223L, "C28")
#> integer(0)
hierarchies(c(221L, 223L), "C28")
#> [1] 221 223
hierarchies(134:135, "D21")
#> [1] 135
hierarchies(134:137, "D24")
#> integer(0)
hierarchies(17L, "C28")
#> [1] 17
```
