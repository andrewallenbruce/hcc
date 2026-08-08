#' DX to CC
#'
#' @format ## `ra_dx_to_cc`
#' A data frame with 112,936 rows and 4 columns:
#' \describe{
#'   \item{Year of Release}{State code}
#'   \item{diagnosis_code}{ICD-10-CM diagnostic codes}
#'   \item{cc}{Condition Codes}
#'   \item{model_name}{Model Name}
#'   ...
#' }
#' @keywords internal
"ra_dx_to_cc"

#' Risk Adjustment Coefficients
#'
#' @format ## `ra_coefficients`
#' A data frame with 14,764 rows and 5 columns:
#' \describe{
#'   \item{year}{Year of Release}
#'   \item{coefficient}{Model Weight Categories}
#'   \item{value}{Model Weights}
#'   \item{model_domain}{Model Domain}
#'   \item{model_version}{Model Version}
#'   ...
#' }
#' @keywords internal
"ra_coefficients"

#' Risk Adjustment Hierarchies
#'
#' @format ## `ra_hierarchies`
#' A data frame with 1,220 rows and 6 columns:
#' \describe{
#'   \item{year}{Year of Release}
#'   \item{cc_parent}{Model Weight Categories}
#'   \item{cc_child}{Model Weights}
#'   \item{model_domain}{Model Domain}
#'   \item{model_version}{Model Version}
#'   \item{model_fullname}{Model Version}
#'   ...
#' }
#' @keywords internal
"ra_hierarchies"

#' 2026 Risk Adjustment Labels
#'
#' @format ## `ra_labels`
#' A data frame with 783 rows and 5 columns:
#' \describe{
#'   \item{cc}{Model Weight Categories}
#'   \item{label}{Model Weights}
#'   \item{model_domain}{Model Domain}
#'   \item{model_version}{Model Version}
#'   \item{model_fullname}{Model Version}
#'   ...
#' }
#' @keywords internal
"ra_labels"

#' Risk Adjustment Eligible CPT and HCPCS
#'
#' @format ## `ra_eligible_hcpcs`
#' A list with 2 elements:
#' \describe{
#'   \item{`2026`}{Model Weight Categories}
#'   \item{`2025`}{Model Weights}
#'   ...
#' }
#' @keywords internal
"ra_eligible_hcpcs"

#' Diagnostic Edit Rules
#'
#' @format ## `ra_dx_edits`
#' A data frame with 107 rows and 9 columns:
#' \describe{
#'   \item{icd10}{Year of Release}
#'   \item{edit_type}{Model Weight Categories}
#'   \item{sex}{Model Weights}
#'   \item{age_min}{Model Domain}
#'   \item{age_max}{Model Domain}
#'   \item{action}{Model Domain}
#'   \item{cc_override}{Model Domain}
#'   \item{model_name}{Model Version}
#'   \item{description}{Model Version}
#'   ...
#' }
#' @keywords internal
"ra_dx_edits"

#' HCC is Chronic
#'
#' @format ## `hcc_is_chronic`
#' A data frame with 1,281 rows and 4 columns:
#' \describe{
#'   \item{hcc}{Hierarchical Condition Codes}
#'   \item{is_chronic}{HCC is Chronic}
#'   \item{model_version}{Model Version}
#'   \item{model_domain}{Model Domain}
#'   ...
#' }
#' @keywords internal
"hcc_is_chronic"

#' HCC is Chronic Without ESRD
#'
#' @format ## `hcc_is_chronic_without_esrd_model`
#' A data frame with 876 rows and 4 columns:
#' \describe{
#'   \item{hcc}{Hierarchical Condition Codes}
#'   \item{is_chronic}{HCC is Chronic}
#'   \item{model_version}{Model Version}
#'   \item{model_domain}{Model Domain}
#'   ...
#' }
#' @keywords internal
"hcc_is_chronic_without_esrd_model"
