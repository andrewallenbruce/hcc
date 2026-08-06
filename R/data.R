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
