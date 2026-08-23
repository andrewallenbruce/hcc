#' Get CC for an ICD-10 code.
#'
#' @param icd `<chr>` ICD-10 diagnosis code(s)
#' @param model `<chr>` HCC model name to use for hierarchy rules; one of:
#'    - CMS-HCC Model V22
#'    - CMS-HCC Model V24
#'    - CMS-HCC Model V28
#'    - RxHCC Model V08
#'    - RxHCC Model V05
#' @param year `<int>` 2025 (default) or 2026
#' @returns `<chr>` CC code if found, NULL otherwise
#' @examples
#' get_cc(icd = "E119", model = "CMS-HCC Model V28", year = 2025)
#' get_cc(icd = "E119", model = "CMS-HCC Model V24", year = 2025)
#' get_cc(icd = "E119", model = "CMS-HCC ESRD Model V21", year = 2025)
#' get_cc(icd = "I5022", model = "CMS-HCC Model V28", year = 2025)
#' get_cc(icd = c("E103213", "I5022", "Z9999"), model = "CMS-HCC Model V28", year = 2025)
#' get_cc(icd = c("E103213", "I5022", "Z9999"), model = "CMS-HCC Model V24", year = 2025)
#' @export
get_cc <- function(
  icd = "E119",
  model = "CMS-HCC Model V28",
  year = 2025L
) {
  icd <- gsub("\\.", "", icd, perl = TRUE)
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
