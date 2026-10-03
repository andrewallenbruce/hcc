EditRule := S7::new_class(
  abstract = TRUE,
  properties = list(
    icd = S7::class_character,
    action = S7::class_character,
    override = S7::class_integer,
    model = S7::class_character,
    description = S7::class_character
  ),
  validator = function(self) {
    if (!rlang::is_empty(self@edit_type)) {
      if (length(self@edit_type) != 1L) {
        return("@edit_type must be length 1")
      }
      if (!self@edit_type %in% c("sex", "age")) {
        return("@edit_type must be either `sex` or `age`")
      }
    }

    if (self@edit_type == "sex") {
      if (length(self@sex) != 1L) {
        return("@sex must be length 1")
      }
      if (!self@sex %in% 1:2) {
        return("@sex must be either `1` or `2`")
      }
    }

    if (self@edit_type == "age") {
      if (length(self@age_min) != 1L) {
        return("@age_min must be length 1")
      }
      if (length(self@age_max) != 1L) {
        return("@age_max must be length 1")
      }
      if (self@age_min >= self@age_max) {
        return("@age_min must be < @age_max")
      }
    }

    if (!rlang::is_empty(self@action)) {
      if (length(self@action) != 1L) {
        return("@action must be length 1")
      }
      if (!self@action %in% c("invalid", "override")) {
        return("@action must be either `invalid` or `override`")
      }

      if (self@action == "override") {
        if (rlang::is_empty(self@cc_override)) {
          return("@cc_override cannot be empty when @action = `override`")
        }
      }
    }
    if (!rlang::is_empty(self@cc_override)) {
      if (length(self@cc_override) != 1L) {
        return("@cc_override must be length 1")
      }
    }
  }
)

#' Model-Based Disease Interaction Variables
#'
#' @param diag `<DiagnosticCategories>` object
#' @param demo `<PatientDemographics>` object
#' @returns `<list>` containing disease interaction variables
#' @examples
#' demo = demographics(age = 64, sex = "F", orec = "1")
#' cms = diagnostics("C24", c(17L, 85L))
#' disease_interactions(cms, demo)
#' rx = diagnostics("R08", 130:133)
#' disease_interactions(rx, demo)
#' @export
disease_interactions <- function(diag, demo = NULL) {
  if (is.null(demo)) {
    demo <- PatientDemographics(dis_curr = FALSE, non_aged = FALSE)
  }

  x <- switch(
    diag@model,
    "CMS-HCC Model V28" = disease_V28(diag@categories, demo@dis_curr, diag@hcc),
    "CMS-HCC Model V24" = disease_V24(diag@categories, demo@dis_curr, diag@hcc),
    "CMS-HCC Model V22" = disease_V22(diag@categories, demo@dis_curr, diag@hcc),
    "CMS-HCC ESRD Model V24" = disease_ESRD_V24(
      diag@categories,
      demo@non_aged,
      diag@hcc
    ),
    "CMS-HCC ESRD Model V21" = disease_ESRD_V21(
      diag@categories,
      demo@non_aged,
      diag@hcc
    ),
    "RxHCC Model V08" = disease_RxHCC_V8(demo@non_aged, diag@hcc)
  )

  names(x)[unlist_(x) == 1L]
}


#' Create an EDI Text Object
#'
#' @param x raw X12 text input
#' @returns an `<hcc::TextEDI>` S7 object
#' @examples
#' edi_text(x12_EX$`837`$P222)
#' @export
edi_text <- function(x) {
  if (rlang::is_scalar_character(x)) {
    return(edi_text_(x))
  }
  if (rlang::is_character(x)) {
    return(edi_text_(cheapr::paste_(x, collapse = "")))
  }
  if (rlang::is_bare_list(x)) {
    return(purrr::map(x, \(i) edi_text_(cheapr::paste_(i, collapse = ""))))
  }
  cli::cli_abort("Unknown X12 Type", call = rlang::caller_env())
}

#' @noRd
parse_820_ENT <- function(x) {
  en <- .subset2(x@Index, "ENT")
  ix <- fill_(
    en,
    c(.subset(en, -1L), .subset2(x@Index, "SE")) - 1L,
    as_list = TRUE
  )

  ent <- purrr::map(ix, \(i) {
    x <- .subset(x@Text, i) |>
      strsplit("[*;]", perl = TRUE)

    # x[[1]] <- x[[1]][-1]

    purrr::map(x, \(e) collapse::na_rm(set_zchar(e)))
  })

  rlang::set_names(ent, seq_along(ent)) |>
    vctrs::vec_c(.name_spec = "{outer}.{inner}")
}
