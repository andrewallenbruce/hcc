#'  Map ICD-10 Codes to CC
#'
#' @param icd `<chr>` ICD-10 diagnosis code(s)
#' @param model `<chr>` HCC model name to use for hierarchy rules; one of:
#'    - `v22`: CMS-HCC Model V22
#'    - `v24`: CMS-HCC Model V24
#'    - `v28`: CMS-HCC Model V28
#'    - `e21`: CMS-HCC ESRD Model V21
#'    - `e24`: CMS-HCC ESRD Model V24
#'    - `rx5`: RxHCC Model V05
#'    - `rx8`: RxHCC Model V08
#' @param year `<int>` 2025 (default) or 2026
#' @returns `<chr>` CCs mapped to diagnosis codes
#' @examples
#' apply_map("E119", "v28", 2026)
#' apply_map("E119", "v24", 2026)
#' apply_map("E119", "e21", 2026)
#' apply_map("I5022", "v28", 2026)
#' apply_map(c("E103213", "I5022", "Z9999"), "v28", 2026)
#' apply_map(c("E103213", "I5022", "Z9999"), "v24", 2026)
#' @export
apply_map <- function(
  icd = NULL,
  model = NULL,
  year = NULL
) {
  check_character(icd, allow_na = FALSE)

  if (!is.null(icd)) {
    icd <- toupper(gsub("\\.", "", icd, perl = TRUE))
  }

  rlang::check_number_whole(year, min = 2025, max = 2026, allow_null = TRUE)

  if (!is.null(model)) {
    model <- convert_model(model)
  }

  x <- if (!is.null(year)) {
    collapse::ss(
      hcc::ra_dx_to_cc,
      whichv_(hcc::ra_dx_to_cc[["year"]], year)
    )
  } else {
    hcc::ra_dx_to_cc
  }

  x <- if (!is.null(model)) {
    collapse::ss(x, whichv_(x[["model_name"]], model))
  } else {
    x
  }

  if (!is.null(icd)) {
    collapse::ss(x, x[["diagnosis_code"]] %iin% icd)
  } else {
    x
  }
}

# apply_map(c("E103213", "I5022", "Z9999"), "v28", 2026) |>
#   collapse::rsplit(~diagnosis_code) |>
#   purrr::map(\(x) x[["cc"]])
