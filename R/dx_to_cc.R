#'  Map ICD-10 Codes to CC
#'
#' @param icd `<chr>` ICD-10 diagnosis code(s)
#' @param model `<chr>` HCC model name to use for hierarchy rules; one of:
#'    - CMS-HCC Model V22
#'    - CMS-HCC Model V24
#'    - CMS-HCC Model V28
#'    - RxHCC Model V08
#'    - RxHCC Model V05
#' @param year `<int>` 2025 (default) or 2026
#' @returns `<chr>` CCs mapped to diagnosis codes
#' @examples
#' apply_map(icd = "E119", model = "CMS-HCC Model V28")
#' apply_map(icd = "E119", model = "CMS-HCC Model V24")
#' apply_map(icd = "E119", model = "CMS-HCC ESRD Model V21")
#' apply_map(icd = "I5022", model = "CMS-HCC Model V28")
#' apply_map(icd = c("E103213", "I5022", "Z9999"), model = "CMS-HCC Model V28")
#' apply_map(icd = c("E103213", "I5022", "Z9999"), model = "CMS-HCC Model V24")
#' @export
apply_map <- function(
  icd,
  model,
  year = 2025L
) {
  icd <- toupper(gsub("\\.", "", icd, perl = TRUE))
  rlang::check_number_whole(year, min = 2025, max = 2026)

  model <- rlang::arg_match0(
    model,
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

  # year
  x <- cheapr::sset(
    hcc::ra_dx_to_cc,
    cheapr::which_(year == hcc::ra_dx_to_cc$year)
  )

  # model
  x <- cheapr::sset(x, cheapr::which_(model == x$model_name))

  #icd codes
  cheapr::sset(
    x,
    grep(
      paste0("^", icd, "$", collapse = "|"),
      x$diagnosis_code,
      perl = TRUE
    )
  )
}
