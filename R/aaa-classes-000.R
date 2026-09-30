#' @noRd
class_iv <- S7::new_S3_class(c("ivs_iv", "vctrs_rcrd", "vctrs_vctr"))

#' @noRd
prop_date <- S7::new_property(
  S7::class_Date,
  default = quote(Sys.Date()),
  setter = function(self, name, value) {
    S7::prop(self, name) <- parse_date(value)
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
TextEDI := S7::new_class(
  properties = list(
    type = S7::class_character,
    text = S7::class_character
  )
)

#' @noRd
Text820 := S7::new_class(TextEDI)

#' @noRd
Text834 := S7::new_class(TextEDI)

#' @noRd
Text837 := S7::new_class(TextEDI)

#' @export
IndexEDI := S7::new_class(
  parent = TextEDI,
  properties = list(
    problems = prop_integer,
    index = S7::class_list
  )
)

#' @export
Index820 := S7::new_class(
  # parent = TextEDI,
  properties = list(
    type = S7::class_character,
    text = S7::class_character,
    problems = prop_integer,
    header = prop_integer,
    details = prop_integer,
    entity = S7::class_list,
    trailer = prop_integer
  )
)

#' @noRd
DiagnosticCategories := S7::new_class(
  properties = list(
    model = S7::class_character,
    hcc = prop_integer,
    categories = S7::class_list
  )
)
