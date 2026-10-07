#' Apply hierarchical rules to a set of CCs based on model version.
#'
#' @param cc `<chr>` Set of current active CCs
#' @param model `<chr>` HCC model name to use for hierarchy rules; one of:
#'    - `C22`: CMS-HCC Model V22
#'    - `C24`: CMS-HCC Model V24
#'    - `C28`: CMS-HCC Model V28
#'    - `D21`: CMS-HCC ESRD Model V21
#'    - `D24`: CMS-HCC ESRD Model V24
#'    - `R05`: RxHCC Model V05
#'    - `R08`: RxHCC Model V08
#' @param year `<int>` 2025, 2026
#' @returns Set of CCs after applying hierarchies
#' @examples
#' apply_hierarchies(cc = 17:19, model = "C28")
#' @export
apply_hierarchies <- function(cc, model, year = 2025L) {
  if (model == "C28" && 223L %in_% cc) {
    if (!any_hcc(c(221:222, 224:226), cc)) {
      cc <- cheapr::setdiff_(cc, 223L)
    }
  }

  if (model == "E21" && 134L %in_% cc) {
    cc <- cheapr::setdiff_(cc, 134L)
  }

  if (model == "E24" && any_hcc(c(134:137), cc)) {
    cc <- cheapr::setdiff_(cc, c(134:137))
  }

  # if the parent HCC is present, drop the child HCCs
  # hier <- collapse::rsplit(hcc::ra_hierarchies, ~year)[[as.character(year)]]
  # hier <- collapse::rsplit(hcc::ra_hierarchies, ~model_name)[[convert_model(model)]]

  hier <- collapse::ss(
    hcc::ra_hierarchies,
    hcc::ra_hierarchies[["year"]] %iin% year
  )

  hier <- collapse::ss(
    hcc::ra_hierarchies,
    hcc::ra_hierarchies[["model_name"]] %iin% convert_model(model)
  )

  cheapr::setdiff_(
    cc,
    collapse::funique(
      collapse::ss(hier, hier[["cc_parent"]] %iin% cc) |>
        _$cc_child
    )
  )
}
