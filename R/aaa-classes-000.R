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
prop_integer <- S7::new_property(
  S7::class_integer,
  setter = function(self, name, value) {
    S7::prop(self, name) <- as.integer(value)
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
Index820 := S7::new_class(
  parent = TextEDI,
  properties = list(
    Problems = prop_integer,
    Header = prop_integer,
    Details = prop_integer,
    Entity = S7::class_list,
    Trailer = prop_integer
  )
)
