#' Get the coefficient prefix based on beneficiary demographics.
#'
#' @param demographics `<PatientDemographics>` object containing beneficiary information
#' @param model_name `<chr>` HCC model name to use for hierarchy rules
#' @returns String prefix used to look up coefficients for this beneficiary type
#' @examplesIf FALSE
#' get_coefficent_prefix(
#'    demographics = PatientDemographics()
#'  )
#' @noRd
get_coefficent_prefix <- function(
  demographics = PatientDemographics(),
  model_name = "CMS-HCC Model V28"
) {
  # Get base prefix based on model type
  if (grepl("ESRD", model_name, fixed = TRUE)) {
    if (demographics@has_esrd) {
      if (demographics@esrd_months > 0L) {
        # Functioning graft case
        if (demographics@is_lti) {
          return("GI_")
        }
        if (demographics@new_enrollee) {
          return("GNE_")
        }

        # Community functioning graft
        prefix = "G"

        # if (demographics@fbd) {
        #   paste0(prefix, "F") else paste0(prefix, "NP")
        # }
        # if (demographics@age >= 65L) {
        #   paste0(prefix, "A") else paste0(prefix, "N")
        # }
        return(paste0(prefix, "_"))
      }
    }
  }
}

# # Dialysis case
# return 'DNE_' if demographics.new_enrollee else 'DI_'
#
# # Transplant case
# if demographics.graft_months in [1, 2, 3]:
#   return f'TRANSPLANT_KIDNEY_ONLY_{demographics.graft_months}M'
#
# elif 'RxHCC' in model_name:
#   if demographics.lti:
#   return 'Rx_NE_LTI_' if demographics.new_enrollee else 'Rx_CE_LTI_'
#
# if demographics.new_enrollee:
#   return 'Rx_NE_Lo_' if demographics.low_income else 'Rx_NE_NoLo_'
#
# # Community case
# prefix = 'Rx_CE_'
# prefix += 'Low' if demographics.low_income else 'NoLow'
# prefix += 'Aged' if demographics.age >= 65 else 'NoAged'
# return prefix + '_'
#
# # Default CMS-HCC Model
# if demographics.lti:
#   return 'INS_'
#
# if demographics.new_enrollee:
#
#   return 'SNPNE_' if demographics.snp else 'NE_'
#
# # Community case
# prefix = 'C'
# prefix += 'F' if demographics.fbd else ('P' if demographics.pbd else 'N')
# prefix += 'A' if demographics.age >= 65 else 'D'
# return prefix + '_'
