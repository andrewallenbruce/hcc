#' @noRd
TextX12 := S7::new_class(
  properties = list(
    type = S7::class_character,
    text = S7::class_character
  )
)

#' @noRd
Text820 := S7::new_class(TextX12)

#' @noRd
Text834 := S7::new_class(TextX12)

#' @noRd
Text837 := S7::new_class(TextX12)

#' @export
X12Index := S7::new_class(
  properties = list(
    type = S7::class_character,
    text = S7::class_character,
    segments = S7::class_integer,
    problems = S7::class_integer,
    index = S7::class_list
  )
)

#' @noRd
fright <- function(x, ...) {
  format(x, justify = "right", ...)
}

#' @noRd
fleft <- function(x, ...) {
  format(x, justify = "left", ...)
}

# S7::method(format, X12Index) <- function(x) {
#   cli::cli_h1("<{attr(x, .c(class))[1]}>")
#
#   probs_ <- if (!is.na(x@problems)) length(x@problems) else NULL
#   names_ <- fright(c(
#     "Type",
#     "Segments",
#     if (!is.null(probs_)) "Problems"
#   ))
#   numbs_ <- fleft(c(
#     x@type,
#     x@segments,
#     if (!is.null(probs_)) cli::col_red(probs_)
#   ))
#
#   cli::cat_line(
#     cheapr::paste_(
#       cli::col_cyan(
#         cli::style_bold(names_)
#       ),
#       ": ",
#       numbs_
#     )
#   )
#   cli::cat_rule()
#
#   numbs_ <- unname(x@index) |>
#     purrr::map_chr(\(x) toString(x, width = 60)) |>
#     fleft()
#
#   names_ <- fright(cheapr::paste_(
#     names(collapse::vlengths(x@index)),
#     "[",
#     collapse::vlengths(x@index, FALSE),
#     "]"
#   ))
#
#   cli::cat_line(
#     cheapr::paste_(
#       cli::style_bold(names_),
#       ": ",
#       numbs_
#     )
#   )
# }
#
# S7::method(print, X12Index) <- function(x) {
#   format(x)
#   invisible(x)
# }

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
