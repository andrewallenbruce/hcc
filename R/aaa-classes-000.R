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
