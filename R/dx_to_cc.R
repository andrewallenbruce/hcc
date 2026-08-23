#' Get CC for a single diagnosis code.
#'
#' @param diagnosis_code `<chr>` ICD-10 diagnosis code
#' @param model_name `<chr>` HCC model name to use for hierarchy rules
#' @returns CC code if found, NULL otherwise
#' @examplesIf FALSE
#' get_cc("E119")
#' get_cc("E11.9")
#' @export
get_cc <- function(
  diagnosis_code,
  year,
  model_name
) {
  diagnosis_code <- gsub("\\.", "", diagnosis_code, perl = TRUE)
  rlang::check_number_whole(year, min = 2025, max = 2026)

  model_name <- rlang::arg_match0(
    model_name,
    c(
      "CMS-HCC ESRD Model V21",
      "CMS-HCC ESRD Model V24",
      "CMS-HCC Model V22",
      "CMS-HCC Model V24",
      "CMS-HCC Model V28",
      "RxHCC Model V08",
      "RxHCC Model V05"
    )
  )

  collapse::ss(
    hcc::ra_dx_to_cc,
    hcc::ra_dx_to_cc$year == year &
      hcc::ra_dx_to_cc$model_name == model_name &
      hcc::ra_dx_to_cc$diagnosis_code == diagnosis_code,
    check = FALSE
  )
}
