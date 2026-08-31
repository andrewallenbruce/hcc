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
