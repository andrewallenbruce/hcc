#' Apply hierarchical rules to a set of CCs based on model version.
#'
#' @param cc_set `<chr>` Set of current active CCs
#' @param model_name `<chr>` HCC model name to use for hierarchy rules
#' @param hierarchies `<chr>` Mapping dictionary of (parent_cc, model_name) to child CCs
#' @returns Set of CCs after applying hierarchies
#' @examplesIf FALSE
#' apply_hierarchies(
#'    cc_set = c("17", "18", "19"),
#'    model_name = "CMS-HCC Model V28",
#'    hierarchies = list(
#'    c("17", "CMS-HCC Model V28"), c("18", "19"),
#'    c("18", "CMS-HCC Model V28"), c("19")
#'    )
#'  )
#' @noRd
apply_hierarchies <- function(cc_set, model_name, hierarchies) {
  # Track CCs that should be zeroed out
  to_remove = list()

  # For V28, if none of 221, 222, 224, 225, 226 are present, remove 223
  # if (model_name == "CMS-HCC Model V28") {
  #   if ("223" %in% cc_set &&
  #       any(!cc %in% cc_set for cc %in% c("221", "222", "224", "225", "226")))
  # }
  #
  #   cc_set.remove("223")
  # elif model_name == "CMS-HCC ESRD Model V21":
  #   if "134" in cc_set:
  #   cc_set.remove("134")
  # elif model_name == "CMS-HCC ESRD Model V24":
  #   for cc in ["134", "135", "136", "137"]:
  #   if cc in cc_set:
  #   cc_set.remove(cc)
  #
  # # Apply hierarchies
  # for cc in cc_set:
  #   hierarchy_key = (cc, model_name)
  # if hierarchy_key in hierarchies:
  #   # If parent CC exists, remove all child CCs
  #   child_ccs = hierarchies[hierarchy_key]
  # to_remove.update(child_ccs & cc_set)
  #
  # # Return CCs with hierarchical exclusions removed
  # return cc_set - to_remove
}
