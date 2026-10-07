#' Apply hierarchical rules to a set of CCs based on model version.
#'
#' @param cc `<chr>` Set of current active CCs
#' @param model `<chr>` HCC model name to use for hierarchy rules; one of:
#'    - `C20`: CMS-HCC Model V20
#'    - `C22`: CMS-HCC Model V22
#'    - `C23`: CMS-HCC Model V23
#'    - `C24`: CMS-HCC Model V24
#'    - `C28`: CMS-HCC Model V28
#'    - `D20`: CMS-HCC ESRD Model V20
#'    - `D21`: CMS-HCC ESRD Model V21
#'    - `D24`: CMS-HCC ESRD Model V24
#'    - `R05`: RxHCC Model V05
#'    - `R08`: RxHCC Model V08
#' @param year `<int>` 2025, 2026
#' @returns Set of CCs after applying hierarchies
#' @examples
#' hierarchies(17:19, "C28")
#' hierarchies(18:19, "C28")
#' hierarchies(223L, "C28")
#' hierarchies(c(221L, 223L), "C28")
#' hierarchies(134:135, "D21")
#' hierarchies(134:137, "D24")
#' hierarchies(17L, "C28")
#' @export
hierarchies <- function(cc, model, year = 2025L) {
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

  x <- hcc::ra_hierarchies
  x <- collapse::ss(x, x[["year"]] %iin% year)
  x <- collapse::ss(x, x[["model_name"]] %iin% convert_model(model))
  x <- collapse::ss(x, x[["cc_parent"]] %iin% cc)
  cheapr::setdiff_(cc, collapse::funique(x[["cc_child"]]))
}
