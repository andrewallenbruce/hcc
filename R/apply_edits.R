#' Apply age/sex edits to CC mappings based on CMS edit rules.
#'
#' This implements the hard-coded edits from CMS SAS macro V28I0ED (and similar).
#' Edits are applied AFTER initial ICD -> CC mapping but BEFORE hierarchies.
#'
#' Edit types:
#'   - `invalid`: Remove the diagnosis (don't assign any CC)
#'   - `override`: Assign a different CC than the default mapping
#'
#' @param cc_to_dx Dictionary mapping CC codes to sets of diagnosis codes
#' @param age Patient's age
#' @param sex Patient's sex (`M`/`F` or `1`/`2`)
#' @param model HCC model name
#' @param edits Dictionary mapping (icd10, model) to `hcc::EditRule` class object
#' @returns Modified cc_to_dx dictionary with edits applied
#' @noRd
apply_edits <- function(cc_to_dx, age = 49, sex = "F", model = "C28", edits) {
  model <- convert_model(model)
  sex <- convert_sex(sex, "V4")
}

#' Single Edit Rule
#'
#' @param icd `<chr>` ICD-10-CM diagnosis code
#' @param action `<chr>` "invalid" or "override"
#' @param override `<int>` CC to assign when `action = "override"`
#' @param model `<chr>` Model Name
#' @param description `<chr>` description of Edit Rule
#' @param sex `<int>` `<SexEdit>`: 1 (male) or 2 (female)
#' @param age `<int>` `<AgeEdit>`: patient age
#' @param boundary `<int>` `<AgeEdit>`: maximum or minimum age
#' @returns An `<EditRule>` S7 object
#' @examples
#' SexEdit(
#'   icd = c("D66", "D67"),
#'   sex = 2L,
#'   action = "override",
#'   override = 112L,
#'   model = "C28",
#'   description = "Hemophilia A/B in female - assign to CC 112"
#' )
#'
#' AgeEdit(
#'   icd = "J410",
#'   age = 17L,
#'   boundary = "max",
#'   action = "invalid",
#'   override = NA_integer_,
#'   model = "C28",
#'   description = "Simple chronic bronchitis - invalid if age < 18"
#' )
#' @name EditRule
#' @export
EditRule := S7::new_class(
  abstract = TRUE,
  properties = list(
    icd = S7::class_character,
    action = S7::class_character,
    override = prop_integer,
    model = S7::class_character,
    description = S7::class_character
  )
)

#' @rdname EditRule
#' @name AgeEdit
#' @export
AgeEdit := S7::new_class(
  parent = EditRule,
  properties = list(
    age = prop_integer,
    boundary = S7::class_character
  )
)

#' @rdname EditRule
#' @name SexEdit
#' @export
SexEdit := S7::new_class(
  parent = EditRule,
  properties = list(sex = prop_integer)
)
