#' Map ICD-10 Codes to CC
#'
#' @param icd `<chr>` ICD-10 diagnosis code(s)
#' @param model `<chr>` HCC model name to use for hierarchy rules; one of:
#'    - `C22`: CMS-HCC Model V22
#'    - `C24`: CMS-HCC Model V24
#'    - `C28`: CMS-HCC Model V28
#'    - `D21`: CMS-HCC ESRD Model V21
#'    - `D24`: CMS-HCC ESRD Model V24
#'    - `R05`: RxHCC Model V05
#'    - `R08`: RxHCC Model V08
#' @param year `<int>` 2025, 2026
#' @param simplify `<lgl>` Return a named list; default is FALSE
#' @returns `<chr>` CCs mapped to diagnosis codes
#' @examples
#' icd_to_cc(icd = "E119", model = "C28", year = 2026)
#' icd_to_cc("E119", "C24", 2026)
#' icd_to_cc("E119", "D21", 2026)
#' icd_to_cc("I5022", "C28", 2026)
#' icd_to_cc(c("E103213", "I5022", "Z9999"), "C28", 2026)
#' icd_to_cc(c("E103213", "I5022", "Z9999"), "C24", 2026)
#' @export
icd_to_cc <- function(
  icd = NULL,
  model = NULL,
  year = NULL,
  simplify = FALSE
) {
  x <- if (!is.null(year)) {
    rlang::check_number_whole(year, min = 2025, max = 2026)
    collapse::ss(
      hcc::ra_dx_to_cc,
      whichv_(hcc::ra_dx_to_cc[["year"]], year)
    )
  } else {
    hcc::ra_dx_to_cc
  }

  x <- if (!is.null(model)) {
    model <- convert_model(model)
    collapse::ss(x, x[["model_name"]] %iin% model)
  } else {
    x
  }

  x <- if (!is.null(icd)) {
    check_character(icd, allow_na = FALSE)
    icd <- toupper(gsub("\\.", "", icd, perl = TRUE))
    collapse::ss(x, x[["icd_code"]] %iin% icd)
  } else {
    x
  }

  x <- collapse::roworderv(x, c("icd_code", "cc", "model_name"))

  if (simplify) {
    return(collapse::rsplit(x$cc, x$icd_code))
  }
  return(x)
}
