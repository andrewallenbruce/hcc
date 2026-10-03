# Document 820 S7 Object

Document 820 S7 Object

## Usage

``` r
Document820(
  Header = HeaderEDI(),
  Details = DetailEDI(),
  Entity = list(),
  Trailer = TrailerEDI()
)
```

## Arguments

- Header:

  `<hcc::HeaderEDI>` object

- Entity:

  list of `<hcc::ENT_Loop>` objects

- Trailer:

  `<hcc::TrailerEDI>` object

- Detail:

  `<hcc::DetailEDI>` object

## Value

`<hcc::Document820>` S7 objects

## Examples

``` r
Document820
#> <hcc::Document820> class
#> @ parent     : <S7_object>
#> @ constructor: function(Header, Details, Entity, Trailer) {...}
#> @ validator  : <NULL>
#> @ properties :
#>  $ Header: <hcc::HeaderEDI> = HeaderEDI()
#>  $ Details: <hcc::DetailEDI> = DetailEDI()
#>  $ Entity: <list> = list()
#>  $ Trailer: <hcc::TrailerEDI> = TrailerEDI()
Document820()
#> <hcc::Document820>
#>  @ Header : <hcc::HeaderEDI>
#>  .. @ ISA01: chr(0) 
#>  .. @ ISA02: chr(0) 
#>  .. @ ISA03: chr(0) 
#>  .. @ ISA04: chr(0) 
#>  .. @ ISA05: chr(0) 
#>  .. @ ISA06: chr(0) 
#>  .. @ ISA07: chr(0) 
#>  .. @ ISA08: chr(0) 
#>  .. @ ISA09: chr(0) 
#>  .. @ ISA10: chr(0) 
#>  .. @ ISA11: chr(0) 
#>  .. @ ISA12: chr(0) 
#>  .. @ ISA13: chr(0) 
#>  .. @ ISA14: chr(0) 
#>  .. @ ISA15: chr(0) 
#>  .. @ ISA16: chr(0) 
#>  .. @ GS01 : chr(0) 
#>  .. @ GS02 : chr(0) 
#>  .. @ GS03 : chr(0) 
#>  .. @ GS04 : chr(0) 
#>  .. @ GS05 : chr(0) 
#>  .. @ GS06 : chr(0) 
#>  .. @ GS07 : chr(0) 
#>  .. @ GS08 : chr(0) 
#>  .. @ ST01 : chr(0) 
#>  .. @ ST02 : chr(0) 
#>  .. @ ST03 : chr(0) 
#>  @ Details: <hcc::DetailEDI>
#>  .. @ BPR01: chr(0) 
#>  .. @ BPR02: chr(0) 
#>  .. @ BPR03: chr(0) 
#>  .. @ BPR04: chr(0) 
#>  .. @ BPR05: chr(0) 
#>  .. @ BPR06: chr(0) 
#>  .. @ BPR07: chr(0) 
#>  .. @ BPR08: chr(0) 
#>  .. @ BPR09: chr(0) 
#>  .. @ BPR10: chr(0) 
#>  .. @ BPR11: chr(0) 
#>  .. @ BPR12: chr(0) 
#>  .. @ BPR13: chr(0) 
#>  .. @ BPR14: chr(0) 
#>  .. @ BPR15: chr(0) 
#>  .. @ BPR16: chr(0) 
#>  .. @ TRN01: chr(0) 
#>  .. @ TRN02: chr(0) 
#>  .. @ REF14: chr(0) 
#>  .. @ N1PE : chr(0) 
#>  .. @ N1PR : chr(0) 
#>  @ Entity : list()
#>  @ Trailer: <hcc::TrailerEDI>
#>  .. @ SE01 : chr(0) 
#>  .. @ SE02 : chr(0) 
#>  .. @ GE01 : chr(0) 
#>  .. @ GE02 : chr(0) 
#>  .. @ IEA01: chr(0) 
#>  .. @ IEA02: chr(0) 
```
