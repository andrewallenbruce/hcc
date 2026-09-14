#' Apply age/sex edits to CC mappings based on CMS edit rules.
#'
#' This implements the hard-coded edits from CMS SAS macro V28I0ED (and similar).
#' Edits are applied AFTER initial ICD -> CC mapping but BEFORE hierarchies.
#'
#' Edit types:
#'   - invalid: Remove the diagnosis (don't assign any CC)
#'   - override: Assign a different CC than the default mapping
#'
#' @param cc_to_dx Dictionary mapping CC codes to sets of diagnosis codes
#' @param age Patient's age
#' @param sex Patient's sex (`M`/`F` or `1`/`2`)
#' @param model HCC model name
#' @param edits Dictionary mapping (icd10, model) to `hcc::EditRule` class object
#' @returns Modified cc_to_dx dictionary with edits applied
#' @noRd
apply_edits <- function(cc_to_dx, age, sex, model, edits) {
  sex <- convert_sex(sex, "V4")

  # Collect all diagnoses across all CCs for edit checking
}

#' Single Edit Rule
#'
#' @param edit_type `<chr>` "sex" or "age"
#' @param sex `<int>` For sex edits: 1 (male) or 2 (female)
#' @param age_min `<int>` For age edits: minimum age (inclusive)
#' @param age_max `<int>` For age edits: maximum age (inclusive)
#' @param action `<chr>` "invalid" or "override"
#' @param cc_override `<int>` CC to assign when `action = "override"`
#' @returns An `<EditRule>` S7 object
#' @usage NULL
#' @examples
#' EditRule(
#'   edit_type = "age",
#'   sex = 2L,
#'   action = "invalid",
#'   age_max = 16L,
#'   age_min = 15L,
#'   cc_override = 13L
#' )
#' @name EditRule
#' @export
EditRule := S7::new_class(
  properties = list(
    edit_type = S7::class_character,
    sex = S7::class_integer,
    age_min = S7::class_integer,
    age_max = S7::class_integer,
    action = S7::class_character,
    cc_override = S7::class_integer
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
