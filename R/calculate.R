#' @noRd
calculate_raf <- function(
  icd,
  model = "C28",
  age = 65,
  sex = "F",
  dual = NA,
  orec = "0",
  crec = "0",
  new = FALSE,
  snp = FALSE,
  low = FALSE,
  lti = FALSE,
  months = NULL,
  dx_to_cc_mapping,
  is_chronic_mapping,
  hierarchies_mapping,
  coefficients_mapping,
  labels_mapping,
  edits_mapping,
  override = NULL,
  maci = 0,
  norm_factor = 1,
  frailty_score = 0
) {
  icd_to_cc(c("E103213", "I5022", "Z9999"), "C28", 2026)
  hierarchies(17L, "C28")
}
