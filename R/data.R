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

#' X12-820 Payment Order/Remittance Advice Examples
#'
#' @format ## `x12_820`
#' A list with 5 elements:
#' \describe{
#'   \item{`sample_820_01`}{X12-820 File}
#'   \item{`sample_820_02`}{X12-820 File}
#'   \item{`sample_820_03`}{X12-820 File}
#'   \item{`sample_820_04`}{X12-820 File}
#'   \item{`sample_820_05`}{X12-820 File}
#'   ...
#' }
#' @keywords internal
"x12_820"

#' X12-834 Benefit Enrollment and Maintenance Examples
#'
#' @format ## `x12_834`
#' A list with 6 elements:
#' \describe{
#'   \item{`sample_834_01`}{X12-834 File}
#'   \item{`sample_834_02`}{X12-834 File}
#'   \item{`sample_834_03`}{X12-834 File}
#'   \item{`sample_834_04`}{X12-834 File}
#'   \item{`sample_834_05`}{X12-834 File}
#'   \item{`sample_834_06`}{X12-834 File}
#'   ...
#' }
#' @keywords internal
"x12_834"

#' X12-837 Health Care Claim Examples
#'
#' @format ## `x12_837`
#' A list with 10 elements:
#' \describe{
#'   \item{`sample_837_0`}{X12-837 File}
#'   \item{`sample_837_1`}{X12-837 File}
#'   \item{`sample_837_2`}{X12-837 File}
#'   \item{`sample_837_3`}{X12-837 File}
#'   \item{`sample_837_4`}{X12-837 File}
#'   \item{`sample_837_5`}{X12-837 File}
#'   \item{`sample_837_6`}{X12-837 File}
#'   \item{`sample_837_7`}{X12-837 File}
#'   \item{`sample_837_8`}{X12-837 File}
#'   \item{`sample_837_9`}{X12-837 File}
#'   ...
#' }
#' @keywords internal
"x12_837"

#' EOB JSON Samples
#'
#' @format ## `eob_json`
#' A list with 3 elements:
#' \describe{
#'   \item{`sample_eob_1`}{EOB File}
#'   \item{`sample_eob_2`}{EOB File}
#'   \item{`sample_eob_3`}{EOB File}
#'   ...
#' }
#' @keywords internal
"eob_json"

#' EOB NDJSON Sample
#'
#' @format ## `eob_ndjson`
#' A large list with 1 element:
#' \describe{
#'   \item{`sample_eob_200`}{EOB File}
#'   ...
#' }
#' @keywords internal
"eob_ndjson"
