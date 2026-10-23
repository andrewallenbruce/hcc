#' Apply HCC Rules
#'
#' Applies hierarchical rules to a set of CCs based on the selected model
#' version.
#'
#' @param icd `<chr>` ICD-10 diagnosis code(s)
#' @param cc `<int>` Set of currently active CCs
#' @param model `<chr>` Model name, default is "C28"; one of:
#'    - `C22`: CMS-HCC Model V22
#'    - `C24`: CMS-HCC Model V24
#'    - `C28`: CMS-HCC Model V28
#'    - `D21`: CMS-HCC ESRD Model V21
#'    - `D24`: CMS-HCC ESRD Model V24
#'    - `R05`: RxHCC Model V05
#'    - `R08`: RxHCC Model V08
#' @param year `<int>` 2025 or 2026; default is 2025
#' @param simplify `<lgl>` Return a named list; default is FALSE
#' @returns An `<int>` vector; one of:
#'    - CCs mapped to diagnosis codes
#'    - CCs after applying hierarchies
#'    - Empty vector, indicating the input CCs do not exist in the model/year
#' @examples
#' hierarchies(17:19)
#' hierarchies(18:19)
#' hierarchies(223L)
#' hierarchies(c(221L, 223L))
#' hierarchies(134:135, "D21")
#' hierarchies(134:137, "D24")
#' hierarchies(17L)
#'
#' icd_to_cc("E119")
#' icd_to_cc("E119", "C24")
#' icd_to_cc("E119", "D21")
#' icd_to_cc("I5022")
#' icd_to_cc(c("E103213", "I5022", "Z9999"))
#' @export
hierarchies <- function(cc, model = "C28", year = 2025) {
  rlang::check_required(cc)
  rlang::check_number_whole(
    year,
    min = 2025,
    max = 2026
  )

  if (anyDuplicated(cc)) {
    cc <- collapse::funique(cc)
  }

  if (model == "C28" && 223L %in_% cc) {
    if (!any_hcc(c(221:222, 224:226), cc)) {
      cc <- cheapr::setdiff_(cc, 223L)
    }
  }

  if (model == "D21" && 134L %in_% cc) {
    cc <- cheapr::setdiff_(cc, 134L)
  }

  if (model == "D24" && any_hcc(134:137, cc)) {
    cc <- cheapr::setdiff_(cc, 134:137)
  }

  x <- collapse::ss(
    hcc::ra_hierarchies,
    hcc::ra_hierarchies[["year"]] %iin% year,
    check = FALSE
  )
  x <- collapse::ss(
    x,
    x[["model_name"]] %iin% convert_model(model),
    check = FALSE
  )
  x <- collapse::ss(
    x,
    x[["cc_parent"]] %iin% cc,
    check = FALSE
  )
  cheapr::setdiff_(
    cc,
    collapse::funique(x[["cc_child"]])
  )
}

#' @rdname hierarchies
#' @export
icd_to_cc <- function(
  icd = NULL,
  model = "C28",
  year = 2025,
  simplify = FALSE
) {
  check_character(
    icd,
    allow_na = FALSE,
    allow_null = TRUE
  )
  rlang::check_number_whole(
    year,
    min = 2025,
    max = 2026,
    allow_null = TRUE
  )

  x <- if (is.null(year)) {
    hcc::ra_dx_to_cc
  } else {
    collapse::ss(
      hcc::ra_dx_to_cc,
      hcc::ra_dx_to_cc[["year"]] %iin% year,
      check = FALSE
    )
  }

  x <- collapse::roworderv(x, c("cc", "icd_code", "model_name"))

  if (!is.null(model)) {
    x <- collapse::ss(
      x,
      x[["model_name"]] %iin% convert_model(model),
      check = FALSE
    )
  }

  if (!is.null(icd)) {
    x <- collapse::ss(
      x,
      x[["icd_code"]] %iin% convert_icd(icd),
      check = FALSE
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
  rlang::check_number_whole(
    year,
    min = 2025,
    max = 2026,
    allow_null = TRUE
  )

  x <- if (is.null(year)) {
    hcc::ra_hierarchies
  } else {
    collapse::ss(
      hcc::ra_hierarchies,
      hcc::ra_hierarchies[["year"]] %iin% year,
      check = FALSE
    )
  }
  x <- collapse::roworderv(x, c("cc_parent", "cc_child", "model_name"))

  if (!is.null(model)) {
    x <- collapse::ss(
      x,
      x[["model_name"]] %iin% convert_model(model),
      check = FALSE
    )
  }

  if (!is.null(cc)) {
    x <- collapse::ss(
      x,
      x[["cc_child"]] %iin% collapse::funique(cc),
      check = FALSE
    )
  }

  if (simplify) {
    return(collapse::rsplit(x[["cc_child"]], x[["cc_parent"]]))
  }
  return(x)
}

#' icd_to_cc_hierarchy(c("E1100", "E1022", "E1165", "E119"), "C24", 2025L)
#' @noRd
icd_to_cc_hierarchy <- function(
  icd = NULL,
  model = NULL,
  year = NULL
) {
  x <- icd_to_cc(icd, model, year)

  list(
    icd = x,
    cc = cc_to_hierarchy(x$cc, model, year)
  )
}
