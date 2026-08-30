#' Demographics-Based Coefficient Prefix
#'
#' Get the coefficient prefix based on beneficiary demographics.
#'
#' @param x `<PatientDemographics>` S7 object
#' @param ... dots
#' @returns String prefix used to look up coefficients for this beneficiary type
#' @examples
#' coefficient_prefix(
#'   demographics(
#'     age = 70,
#'     sex = "F",
#'     dual_code = "00",
#'     orec_code = "0",
#'     crec_code = "0"
#'   )
#' ) # CNA_
#' coefficient_prefix(
#'   demographics(
#'     age = 45,
#'     sex = "M",
#'     dual_code = "00",
#'     orec_code = "2",
#'     crec_code = "0"
#'   ),
#'   model = "CMS-HCC ESRD Model V24"
#' )
#' @export
coefficient_prefix <- S7::new_generic("coefficient_prefix", "x")

S7::method(coefficient_prefix, PatientDemographics) <- function(x, model = "default") {
  if (perl0(model, "ESRD")) {
    p <- esrd_prefix_(x)
    if (!is.null(p)) {
      return(p)
    }
  }
  if (perl0(model, "RxHCC")) {
    return(rxhcc_prefix_(x))
  }

  # Default CMS-HCC Model
  if (x@is_lti) {
    return("INS_")
  }

  if (x@new_enrollee) {
    return(cheapr::if_else_(x@has_snp, "SNPNE_", "NE_"))
  }

  # Community case
  pre <- cheapr::paste_(
    "C",
    cheapr::case(
      isTRUE(x@dual_full) ~ "F",
      isTRUE(x@dual_part) ~ "P",
      .default = "N"
    )
  )
  pre <- cheapr::paste_(pre, cheapr::if_else_(x@age >= 65L, "A", "D"))
  cheapr::paste_(pre, "_")
}

#' @noRd
esrd_prefix_ <- function(x) {
  if (x@has_esrd) {
    if (x@esrd_months > 0L) {
      # Functioning graft case
      if (x@is_lti) {
        return("GI_")
      }
      if (x@new_enrollee) {
        return("GNE_")
      }
      # Community functioning graft
      pre <- cheapr::paste_("G", cheapr::if_else_(x@dual_full, "F", "NP"))
      pre <- cheapr::paste_(pre, cheapr::if_else_(x@age >= 65L, "A", "N"))
      return(cheapr::paste_(pre, "_"))
    }
    # Dialysis case
    return(cheapr::if_else_(x@new_enrollee, "DNE_", "DI_"))
  }
  # Transplant case
  if (x@esrd_months %in_% 1:3) {
    return(cheapr::paste_("TRANSPLANT_KIDNEY_ONLY_", x@esrd_months, "M"))
  }
  NULL
}

#' @noRd
rxhcc_prefix_ <- function(x) {
  if (x@is_lti) {
    return(cheapr::if_else_(x@new_enrollee, "Rx_NE_LTI_", "Rx_CE_LTI_"))
  }
  if (x@new_enrollee) {
    return(cheapr::if_else_(x@low_income, "Rx_NE_Lo_", "Rx_NE_NoLo_"))
  }
  pre <- cheapr::paste_(
    "Rx_CE_",
    cheapr::if_else_(x@low_income, "Low", "NoLow")
  )
  pre <- cheapr::paste_(
    pre,
    cheapr::if_else_(x@age >= 65L, "Aged", "NoAged")
  )
  cheapr::paste_(pre, "_")
}
