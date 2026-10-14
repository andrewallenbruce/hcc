utils::globalVariables(c("value"))

#' @noRd
prop_scalar <- function(class, default = NULL) {
  S7::new_property(
    class,
    validator = function(value) {
      if (!rlang::is_scalar_atomic(value)) {
        "must be a scalar atomic"
      }
    },
    default = default
  )
}

#' @noRd
class_string <- prop_scalar(S7::class_character, default = NA_character_)
#' @noRd
class_boolean <- prop_scalar(S7::class_logical, default = NA)

#' @noRd
Enum := S7::new_class(
  abstract = TRUE,
  properties = list(
    value = class_string,
    variants = S7::class_character
  ),
  validator = function(self) {
    if (cheapr::is_na(self@value)) {
      "@value must not be NA"
    }
    if (self@value %!in_% self@variants) {
      cli::format_inline("@value must be one of {.val {self@variants}}")
    }
  }
)

#' @noRd
new_enum <- function(name, variants, default = NULL) {
  check_string(name, allow_empty = FALSE)
  check_character(variants)
  check_string(default, allow_na = FALSE, allow_null = TRUE)

  if (length(variants) == 0L) {
    cli::cli_abort("{.arg variants} must contain at least one value.")
  }
  if (anyDuplicated(variants)) {
    cli::cli_abort("{.arg variants} must be unique.")
  }

  if (!rlang::is_null(default)) {
    if (cheapr::is_na(default) || default %!in_% variants) {
      cli::cli_abort("{.arg default} must be one of {.val {variants}}.")
    }
  }

  S7::new_class(
    name,
    parent = Enum,
    package = "hcc",
    properties = list(
      value = class_string,
      variants = S7::new_property(
        S7::class_character,
        default = rlang::expr(variants)
      )
    ),
    constructor = rlang::new_function(
      args = if (rlang::is_null(default)) {
        rlang::pairlist2(value = )
      } else {
        rlang::pairlist2(value = default)
      },
      body = rlang::expr({
        S7::new_object(
          S7::S7_object(),
          value = value,
          variants = variants
        )
      }),
      env = rlang::current_env()
    )
  )
}

#' @noRd
class_iv <- S7::new_S3_class(
  c("ivs_iv", "vctrs_rcrd", "vctrs_vctr")
)

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
      cli::cli_abort(
        "Length of {.arg @ISA} must be {.val {16}} not {.val {length(self@ISA)}}."
      )
    } else if (length(self@GS) != 8L) {
      cli::cli_abort(
        "Length of {.arg @GS} must be {.val {8}} not {.val {length(self@GS)}}."
      )
    } else if (length(self@ST) != 3L) {
      cli::cli_abort(
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
      cli::cli_abort(
        "Length of {.arg @SE} must be {.val {2}} not {.val {length(self@SE)}}."
      )
    } else if (length(self@GE) != 2L) {
      cli::cli_abort(
        "Length of {.arg @GE} must be {.val {2}} not {.val {length(self@GE)}}."
      )
    } else if (length(self@IEA) != 2L) {
      cli::cli_abort(
        "Length of {.arg @IEA} must be {.val {2}} not {.val {length(self@IEA)}}."
      )
    }
  }
)

#' @noRd
Parsed820 := S7::new_class(
  properties = list(
    Header = HeaderEDI,
    Details = S7::class_list,
    Entity = S7::class_list,
    Trailer = TrailerEDI
  )
)

#' @noRd
Parsed834 := S7::new_class(
  properties = list(
    Header = HeaderEDI,
    Details = S7::class_list,
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
