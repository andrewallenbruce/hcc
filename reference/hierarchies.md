# Apply HCC Rules

Applies hierarchical rules to a set of CCs based on the selected model
version.

## Usage

``` r
hierarchies(cc, model = "C28", year = 2025)
```

## Arguments

- cc:

  `<int>` Set of currently active CCs

- model:

  `<chr>` Model name, default is "C28"; one of:

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

  `<int>` 2025 or 2026; default is 2025

## Value

`<int>` vector of CCs after applying hierarchies or an empty integer
vector

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
```
