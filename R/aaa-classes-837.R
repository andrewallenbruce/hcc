#' Healthcare Claim Service Level Data
#'
#' @param claim_id `<chr>` Unique identifier for the claim
#' @param procedure_code `<chr>` HCPCS code
#' @param ndc `<chr>` National Drug Code
#' @param linked_diagnosis_codes `<chr>` ICD-10 diagnosis codes linked to this
#'   service
#' @param claim_diagnosis_codes `<chr>` All diagnosis codes on the claim
#' @param claim_type `<chr>` Type of claim (e.g., NCH Claim Type Code, or 837I,
#'   837P)
#' @param provider_specialty `<chr>` Provider taxonomy or specialty code
#' @param performing_provider_npi `<chr>` NPI for performing provider
#' @param billing_provider_npi `<chr>` NPI for billing provider
#' @param patient_id `<chr>` Unique identifier for the patient
#' @param facility_type `<chr>` Type of facility where service was rendered
#' @param service_type `<chr>` Type of service provided (facility type + service
#'   type = Type of Bill)
#' @param service_date `<Date>` Date service was performed (YYYY-MM-DD)
#' @param place_of_service `<chr>` Place of service code
#' @param quantity `<num>` Number of units provided
#' @param quantity_unit `<chr>` Unit of measure for quantity
#' @param modifiers `<chr>` List of procedure code modifiers
#' @param allowed_amount `<num>` Allowed amount for the service
#' @returns A `<ServiceLevelData>` S7 object
#' @usage NULL
#' @examples
#' ServiceLevelData(
#'   claim_id = "756048Q",
#'   procedure_code = c("85025", "93005"),
#'   claim_diagnosis_codes = c("3669", "4019", "79431"),
#'   claim_type = "837I",
#'   provider_specialty = "203BA0200N",
#'   billing_provider_npi = "9876540809",
#'   patient_id = "030005074A",
#'   facility_type = "14",
#'   service_date = "1996-09-11",
#'   quantity = c(1L, 3L),
#'   quantity_unit = "UN",
#'   allowed_amount = 89.93
#' )
#' @name ServiceLevelData
#' @export
ServiceLevelData := S7::new_class(
  properties = list(
    claim_id = S7::class_character,
    procedure_code = S7::class_character,
    ndc = S7::class_character,
    linked_diagnosis_codes = S7::class_character,
    claim_diagnosis_codes = S7::class_character,
    claim_type = S7::class_character,
    provider_specialty = S7::class_character,
    performing_provider_npi = S7::class_character,
    billing_provider_npi = S7::class_character,
    patient_id = S7::class_character,
    facility_type = S7::class_character,
    service_type = S7::class_character,
    service_date = prop_date,
    place_of_service = S7::class_character,
    quantity = S7::class_numeric,
    quantity_unit = S7::class_character,
    modifiers = S7::class_character,
    allowed_amount = S7::class_numeric
  )
)

#' Risk Adjustment Factor score results
#'
#' @param risk_score `<dbl>` Final RAF score
#' @param risk_score_demographics `<dbl>` Demographics-only risk score
#' @param risk_score_chronic_only `<dbl>` Chronic conditions risk score
#' @param risk_score_hcc `<dbl>` HCC conditions risk score
#' @param risk_score_payment `<dbl>` Payment RAF score, adjusted for MACI,
#'   normalization, and frailty
#' @param hcc_list `<chr>` List of active HCC categories
#' @param hcc_details `<chr>` Detailed HCC information with labels and chronic
#'   status
#' @param cc_to_dx Condition categories mapped to diagnosis codes
#' @param coefficients Applied model coefficients
#' @param interactions Disease interaction coefficients
#' @param demographics Patient demographics used in calculation
#' @param model_name `<chr>` HCC model used for calculation
#' @param version `<chr>` Library version
#' @param diagnosis_codes `<chr>` Input diagnosis codes
#' @param service_level_data `<ServiceLevelData>` S7 object; Processed service
#'   records
#' @returns A `<RAFResult>` S7 object
#' @usage NULL
#' @examplesIf FALSE
#' RAFResult()
#' @name RAFResult
#' @export
RAFResult := S7::new_class(
  properties = list(
    risk_score = S7::class_double,
    risk_score_demographics = S7::class_double,
    risk_score_chronic_only = S7::class_double,
    risk_score_hcc = S7::class_double,
    risk_score_payment = S7::class_double,
    hcc_list = S7::class_character,
    hcc_details = S7::class_character,
    cc_to_dx = S7::class_character,
    coefficients = S7::class_double,
    interactions = S7::class_character,
    demographics = S7::class_character,
    model_name = S7::class_character,
    version = S7::class_character,
    diagnosis_codes = S7::class_character,
    service_level_data = ServiceLevelData
  )
)
