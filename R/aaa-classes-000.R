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
    problems = S7::class_integer,
    index = S7::class_list
  )
)

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
DiagnosticCategories := S7::new_class(
  properties = list(
    model = S7::class_character,
    hcc = prop_integer,
    categories = S7::class_list
  )
)
