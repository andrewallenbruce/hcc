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
#' icd_to_cc("E119", "C28", 2026)
#' icd_to_cc("E119", "C24", 2026)
#' icd_to_cc("E119", "D21", 2026)
#' icd_to_cc("I5022", "C28", 2026)
#' icd_to_cc(c("E103213", "I5022", "Z9999"), "C28", 2026)
#' icd_to_cc(c("E103213", "I5022", "Z9999"), "C28", 2026, simplify = TRUE)
#' @export
icd_to_cc <- function(
  icd = NULL,
  model = NULL,
  year = NULL,
  simplify = FALSE
) {
  check_character(icd, allow_na = FALSE, allow_null = TRUE)
  rlang::check_number_whole(year, min = 2025, max = 2026, allow_null = TRUE)

  x <- if (is.null(year)) {
    hcc::ra_dx_to_cc
  } else {
    collapse::ss(hcc::ra_dx_to_cc, whichv_(hcc::ra_dx_to_cc[["year"]], year))
  }

  x <- collapse::roworderv(x, c("cc", "icd_code", "model_name"))

  if (!is.null(model)) {
    x <- collapse::ss(x, x[["model_name"]] %iin% convert_model(model))
  }

  if (!is.null(icd)) {
    x <- collapse::ss(
      x,
      x[["icd_code"]] %iin% toupper(gsub("\\.", "", icd, perl = TRUE))
    )
  }

  if (simplify) {
    return(collapse::rsplit(x[["icd_code"]], x[["cc"]]))
  }
  return(x)
}

# x <- icd_to_cc(c("E1100", "E1022", "E1165", "E119"), "C24", 2025L)
# cc_to_hierarchy(x$cc, "C24", 2025L)
#' @noRd
cc_to_hierarchy <- function(
  cc = NULL,
  model = NULL,
  year = NULL,
  simplify = FALSE
) {
  rlang::check_number_whole(year, min = 2025, max = 2026, allow_null = TRUE)

  x <- if (is.null(year)) {
    hcc::ra_hierarchies
  } else {
    collapse::ss(
      hcc::ra_hierarchies,
      whichv_(hcc::ra_hierarchies[["year"]], year)
    )
  }
  x <- collapse::roworderv(x, c("cc_parent", "cc_child", "model_name"))

  if (!is.null(model)) {
    x <- collapse::ss(x, x[["model_name"]] %iin% convert_model(model))
  }

  if (!is.null(cc)) {
    x <- collapse::ss(x, x[["cc_child"]] %iin% collapse::funique(cc))
  }

  if (simplify) {
    return(collapse::rsplit(x[["cc_child"]], x[["cc_parent"]]))
  }
  return(x)
}

#' @noRd
icd_to_cc_hierarchy <- function(icd = NULL, model = NULL, year = NULL) {
  x <- icd_to_cc(icd, model, year, TRUE)
  y <- cc_to_hierarchy(names(x), model, year, TRUE)

  list(icd = x, cc = y)
}
