#' @noRd
class_iv <- S7::new_S3_class(c("ivs_iv", "vctrs_rcrd", "vctrs_vctr"))

#' @noRd
prop_date <- S7::new_property(
  S7::class_Date,
  default = quote(.Date(numeric(0L))),
  setter = function(self, name, value) {
    S7::prop(self, name) <- parse_date(value)
    self
  }
)

#' @noRd
prop_date_range <- S7::new_property(
  class_iv,
  default = quote(c(.Date(numeric(0L)), .Date(numeric(0L)))),
  setter = function(self, name, value) {
    S7::prop(self, name) <- parse_date_range(value[1], value[2])
    self
  }
)

#' @noRd
prop_dtm_rd8 <- S7::new_property(
  class_iv,
  default = quote(c(.Date(numeric(0L)), .Date(numeric(0L)))),
  setter = function(self, name, value) {
    S7::prop(self, name) <- parse_DTM_RD8(value)
    self
  }
)

#' @noRd
prop_integer <- S7::new_property(
  S7::class_integer,
  setter = function(self, name, value) {
    S7::prop(self, name) <- as.integer(value)
    self
  }
)

#' @noRd
prop_double <- S7::new_property(
  S7::class_double,
  setter = function(self, name, value) {
    S7::prop(self, name) <- as.double(value)
    self
  }
)

#' @noRd
prop_list_of <- function(class, names = c("any", "all", "none")) {
  force(class)
  names <- rlang::arg_match(names)

  S7::new_property(
    class = S7::class_list,
    validator = function(value) {
      for (i in seq_along(value)) {
        val <- value[[i]]
        if (!S7::S7_inherits(val, class)) {
          return(paste0(
            "must be a list of <",
            class@name,
            ">s. ",
            "Element ",
            i,
            " is ",
            obj_type_friendly(val),
            "."
          ))
        }
      }
      if (names == "all" && any(rlang::names2(value) == "")) {
        "must be a named list."
      } else if (names == "none" && any(rlang::names2(value) != "")) {
        "must be an unnamed list."
      }
    }
  )
}

#' @noRd
TextEDI := S7::new_class(
  properties = list(
    Type = S7::class_character,
    Text = S7::class_character
  )
)

#' @noRd
Text820 := S7::new_class(TextEDI)

#' @noRd
Text834 := S7::new_class(TextEDI)

#' @noRd
Text837 := S7::new_class(TextEDI)

#' @noRd
IndexEDI := S7::new_class(
  parent = TextEDI,
  properties = list(
    Problems = prop_integer,
    Index = S7::class_list
  )
)

#' @noRd
Index834 := S7::new_class(
  parent = Text834,
  properties = list(
    Problems = prop_integer,
    Header = prop_integer,
    Details = prop_integer,
    Member = S7::class_list,
    Trailer = prop_integer
  )
)

#' @noRd
Index820 := S7::new_class(
  parent = Text820,
  properties = list(
    Problems = prop_integer,
    Header = prop_integer,
    Details = prop_integer,
    Entity = S7::class_list,
    Trailer = prop_integer
  )
)

#' @noRd
SegmentEDI := S7::new_class(
  properties = list(
    Position = prop_integer,
    Element = S7::class_character,
    Meaning = S7::class_character,
    Name = S7::class_character,
    Description = S7::class_character
  )
)

#' @noRd
isa_segment <- function(i, x) {
  SegmentEDI(
    Position = 1:16,
    Element = x$header$ISA,
    # Meaning = ,
    Name = c(
      "Authorization Info Qualifier",
      "Authorization Information",
      "Security Info Qualifier",
      "Security Information",
      "Interchange ID Qualifier",
      "Interchange Sender ID",
      "Interchange ID Qualifier",
      "Interchange Receiver ID",
      "Interchange Date",
      "Interchange Time",
      "Repetition Separator",
      "Interchange Control Version Number",
      "Interchange Control Number",
      "Acknowledgment Requested",
      "Interchange Usage Indicator",
      "Component Element Separator"
    )
    # Description = S7::class_character
  )
}

#' @noRd
Text820 := S7::new_class(TextEDI)

#' @noRd
DetailEDI := S7::new_class(
  properties = list(
    BPR01 = S7::class_character,
    BPR02 = S7::class_character,
    BPR03 = S7::class_character,
    BPR04 = S7::class_character,
    BPR05 = S7::class_character,
    BPR06 = S7::class_character,
    BPR07 = S7::class_character,
    BPR08 = S7::class_character,
    BPR09 = S7::class_character,
    BPR10 = S7::class_character,
    BPR11 = S7::class_character,
    BPR12 = S7::class_character,
    BPR13 = S7::class_character,
    BPR14 = S7::class_character,
    BPR15 = S7::class_character,
    BPR16 = S7::class_character,
    TRN01 = S7::class_character,
    TRN02 = S7::class_character,
    REF14 = S7::class_character,
    N1PE = S7::class_character,
    N1PR = S7::class_character
  )
)

#' @noRd
TrailerEDI := S7::new_class(
  properties = list(
    SE01 = S7::class_character,
    SE02 = S7::class_character,
    GE01 = S7::class_character,
    GE02 = S7::class_character,
    IEA01 = S7::class_character,
    IEA02 = S7::class_character
  )
)

#' @noRd
HeaderEDI := S7::new_class(
  properties = list(
    ISA05 = S7::class_character,
    ISA06 = S7::class_character,
    ISA07 = S7::class_character,
    ISA08 = S7::class_character,
    ISA09 = prop_date,
    ISA10 = prop_integer,
    ISA11 = S7::class_character,
    ISA12 = S7::class_character,
    ISA13 = S7::class_character,
    ISA14 = S7::class_character,
    ISA15 = S7::class_character,
    ISA16 = S7::class_character,
    GS01 = S7::class_character,
    GS02 = S7::class_character,
    GS03 = S7::class_character,
    GS04 = S7::class_character,
    GS05 = S7::class_character,
    GS06 = S7::class_character,
    GS07 = S7::class_character,
    GS08 = S7::class_character,
    ST01 = S7::class_character,
    ST02 = S7::class_character,
    ST03 = S7::class_character
  )
)

#' @noRd
edi_trailer <- function(se, ge, iea) {
  TrailerEDI(
    SE01 = se[1],
    SE02 = se[2],
    GE01 = ge[1],
    GE02 = ge[2],
    IEA01 = iea[1],
    IEA02 = iea[2]
  )
}

#' @noRd
edi_header <- function(isa, gs, st) {
  HeaderEDI(
    # ISA01 = isa[1],
    # ISA02 = isa[2],
    # ISA03 = isa[3],
    # ISA04 = isa[4],
    ISA05 = isa[5],
    ISA06 = isa[6],
    ISA07 = isa[7],
    ISA08 = isa[8],
    ISA09 = isa[9],
    ISA10 = isa[10],
    ISA11 = isa[11],
    ISA12 = isa[12],
    ISA13 = isa[13],
    ISA14 = isa[14],
    ISA15 = isa[15],
    ISA16 = isa[16],
    GS01 = gs[1],
    GS02 = gs[2],
    GS03 = gs[3],
    GS04 = gs[4],
    GS05 = gs[5],
    GS06 = gs[6],
    GS07 = gs[7],
    GS08 = gs[8],
    ST01 = st[1],
    ST02 = st[2],
    ST03 = st[3]
  )
}

#' @noRd
edi_detail <- function(bpr, trn, ref, pe, pr) {
  DetailEDI(
    BPR01 = bpr[1],
    BPR02 = bpr[2],
    BPR03 = bpr[3],
    BPR04 = bpr[4],
    BPR05 = bpr[5],
    BPR06 = bpr[6],
    BPR07 = bpr[7],
    BPR08 = bpr[8],
    BPR09 = bpr[9],
    BPR10 = bpr[10],
    BPR11 = bpr[11],
    BPR12 = bpr[12],
    BPR13 = bpr[13],
    BPR14 = bpr[14],
    BPR15 = bpr[15],
    BPR16 = bpr[16],
    TRN01 = trn[1],
    TRN02 = trn[2],
    REF14 = ref[2],
    N1PE = pe,
    N1PR = pr
  )
}
