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
Index837 := S7::new_class(
  parent = Text837,
  properties = list(
    Problems = prop_integer,
    Header = prop_integer,
    Details = prop_integer,
    Claims = S7::class_list,
    Trailer = prop_integer
  )
)

#' @noRd
HeaderEDI := S7::new_class(
  properties = list(
    ISA = S7::class_character,
    GS = S7::class_character,
    ST = S7::class_character
  ),
  validator = function(self) {
    if (length(self@ISA) != 16L) {
      cli::format_inline(
        "Length of {.arg @ISA} must be {.val {16}} not {.val {length(self@ISA)}}."
      )
    } else if (length(self@GS) != 8L) {
      cli::format_inline(
        "Length of {.arg @GS} must be {.val {8}} not {.val {length(self@GS)}}."
      )
    } else if (length(self@ST) != 3L) {
      cli::format_inline(
        "Length of {.arg @ST} must be {.val {3}} not {.val {length(self@ST)}}."
      )
    }
  }
)

#' @noRd
TrailerEDI := S7::new_class(
  properties = list(
    SE = S7::class_character,
    GE = S7::class_character,
    IEA = S7::class_character
  ),
  validator = function(self) {
    if (length(self@SE) != 2L) {
      cli::format_inline(
        "Length of {.arg @SE} must be {.val {2}} not {.val {length(self@SE)}}."
      )
    } else if (length(self@GE) != 2L) {
      cli::format_inline(
        "Length of {.arg @GE} must be {.val {2}} not {.val {length(self@GE)}}."
      )
    } else if (length(self@IEA) != 2L) {
      cli::format_inline(
        "Length of {.arg @IEA} must be {.val {2}} not {.val {length(self@IEA)}}."
      )
    }
  }
)

#' @noRd
Detail218 := S7::new_class(
  properties = list(
    BPR = S7::class_character,
    TRN = S7::class_character,
    REF14 = S7::class_character,
    N1PE = S7::class_character,
    N1PR = S7::class_character
  )
)

#' @noRd
Detail306 := S7::new_class(
  properties = list(
    BPR = S7::class_character,
    TRN = S7::class_character,
    REF38 = S7::class_character,
    REFTV = S7::class_character,
    N1PE = S7::class_character,
    N1RM = S7::class_character,
    PER = S7::class_character
  )
)

#' @noRd
Detail834 := S7::new_class(
  properties = list(
    BGN = S7::class_character,
    N1P5 = S7::class_character,
    N1IN = S7::class_character,
    REF38 = S7::class_character,
    QTY = S7::class_character,
    DTP = S7::class_character
  )
)

#' @noRd
Parsed820 := S7::new_class(
  properties = list(
    Header = HeaderEDI,
    Details = Detail218 | Detail306,
    Entity = S7::class_list,
    Trailer = TrailerEDI
  )
)

#' @noRd
Parsed834 := S7::new_class(
  properties = list(
    Header = HeaderEDI,
    Details = Detail834,
    Member = S7::class_list,
    Trailer = TrailerEDI
  )
)

#' @noRd
Parsed837 := S7::new_class(
  properties = list(
    Header = HeaderEDI,
    Details = S7::class_list,
    Claims = S7::class_list,
    Trailer = TrailerEDI
  )
)

#' @noRd
Party := S7::new_class(
  properties = list(
    name = S7::class_character,
    address = S7::class_character
  )
)

#' @noRd
Member := S7::new_class(
  properties = list(
    id = S7::class_character,
    last = S7::class_character,
    first = S7::class_character,
    middle = S7::class_character
  )
)
