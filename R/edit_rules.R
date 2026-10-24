#' Apply CMS Edit Rules
#'
#' Apply age/sex edits to CC mappings based on CMS edit rules. Edits are
#' applied AFTER initial ICD -> CC mapping but BEFORE hierarchies.
#'
#' Edit types:
#'   - `invalid`: Remove the diagnosis (don't assign any CC)
#'   - `override`: Assign a different CC than the default mapping
#'
#' @param icd `<chr>` ICD-10-CM diagnosis code
#' @param age `<int>` Patient's age; Max = 49|17, Min = 2
#' @param sex `<chr>` Patient's sex; 2 rules for Female ("F/2")
#' @param model `<chr>` Only one is "C28"
#' @returns Modified `icd_to_cc()` output with edits applied
#' @examples
#' icd_to_cc(icd = c("D67", "C50522"), model = "C28", year = 2026L)
#' edit_rules(icd = c("D67", "C50522"), age = 56L, sex = "F", model = "C28")
#' @export
edit_rules <- function(icd, age = NULL, sex = NULL, model = "C28") {
  dx_cc <- icd_to_cc(icd = icd, model = model, year = 2026L)
  model <- convert_model(model)

  if (!is.null(age)) {
    age_ <- collapse::ss(
      hcc::ra_dx_edits$age,
      hcc::ra_dx_edits$age$icd %iin% dx_cc$icd_code
    )

    if (nrow(age_) != 0L) {
      if (age_$action == "override") {
        if (age_$bound == "max" && age > age_$age) {
          dx_cc[dx_cc$icd_code %iin% age_$icd, "cc"] <- age_$cc
        }
        if (age_$bound == "min" && age < age_$age) {
          dx_cc[dx_cc$icd_code %iin% age_$icd, "cc"] <- age_$cc
        }
      }

      if (age_$action == "invalid") {
        if (age_$bound == "max" && age > age_$age) {
          dx_cc[dx_cc$icd_code %iin% age_$icd, ] <- NULL
        }
        if (age_$bound == "min" && age < age_$age) {
          dx_cc[dx_cc$icd_code %iin% age_$icd, ] <- NULL
        }
      }
    }
  }

  if (!is.null(sex)) {
    sex <- convert_sex(sex, "V4")
    sex_ <- collapse::ss(
      hcc::ra_dx_edits$sex,
      hcc::ra_dx_edits$sex$icd %iin% dx_cc$icd_code
    )
    if (nrow(sex_) != 0L) {
      if (sex_$action == "override") {
        dx_cc[dx_cc$icd_code %iin% sex_$icd, "cc"] <- sex_$cc
      }
      if (sex_$action == "invalid") {
        dx_cc[dx_cc$icd_code %iin% sex_$icd, ] <- NULL
      }
    }
  }
  dx_cc
}
