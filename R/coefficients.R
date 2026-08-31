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
      return(
        cheapr::paste_(
          "G",
          cheapr::if_else_(x@dual_full, "F", "NP"),
          cheapr::if_else_(x@age >= 65L, "A", "N"),
          "_"
        )
      )
    }
    # Dialysis case
    return(cheapr::if_else_(x@new_enrollee, "DNE_", "DI_"))
  }
  # Transplant case
  if (in_between(x@esrd_months, 1L, 3L)) {
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
  cheapr::paste_(
    "Rx_CE_",
    cheapr::if_else_(x@low_income, "Low", "NoLow"),
    cheapr::if_else_(x@age >= 65L, "Aged", "NoAged"),
    "_"
  )
}

#' Demographics-Based Coefficient Prefix
#'
#' Get the coefficient prefix based on beneficiary demographics.
#'
#' @param x `<PatientDemographics>` S7 object
#' @param ... dots
#' @returns String prefix used to look up coefficients for beneficiary type
#' @examples
#' coefficient_prefix(
#'   demographics(
#'     age = 70,
#'     sex = "F",
#'     dual_code = "00",
#'     orec_code = "0",
#'     crec_code = "0"
#'   )
#' )
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

S7::method(coefficient_prefix, PatientDemographics) <- function(
  x,
  model = "default"
) {
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

#' Apply risk adjustment coefficients to HCCs and interactions.
#'
#' This function takes demographic information, HCC codes, and interaction
#' variables and returns a dictionary mapping each variable to its
#' corresponding coefficient value based on the specified model.
#'
#' @param demographics Demographics object
#' @param hcc HCC codes present for the patient
#' @param interactions Interaction variables and their values (0 or 1)
#' @param model Risk adjustment model to use; default is "CMS-HCC Model V28"
#' @param coefficients Map of variable/model to coefficient values
#' @param prefix_override Optional prefix to override auto-detected demographic
#'   prefix. Common values:
#'   - `DI_` (ESRD Dialysis)
#'   - `DNE_` (ESRD Dialysis New Enrollee)
#'   - `INS_` (Institutionalized)
#'   - `CFA_` (Community Full Dual Aged), etc.
#' @returns Dictionary mapping HCC codes and interaction variables to their
#'   coefficient values for variables that are present
#' @examplesIf FALSE
#' apply_coefficients(
#'   demographics(
#'     age = 70,
#'     sex = "F",
#'     dual_code = "00",
#'     orec_code = "0",
#'     crec_code = "0",
#'     version = "V2",
#'     new_enrollee = FALSE,
#'     has_snp = FALSE,
#'     low_income = FALSE
#'   )
#' )
#' @export
apply_coefficients <- function(
  demographics,
  interactions,
  coefficients,
  model,
  hcc = NULL,
  prefix_override = NULL
) {
  model <- rlang::arg_match0(model, MODEL)

  prefix <- if (!is.null(prefix_override)) {
    prefix_override
  } else {
    coefficient_prefix(demographics, model)
  }

  demo_key <- cheapr::c_(
    prefix = cheapr::paste_(prefix, demographics@category),
    model = model
  )

  coef <- get_coefficient(
    coefficient = demo_key[["prefix"]],
    model = demo_key[["model"]],
    year = 2025
  )

  output <- list()

  if (!rlang::is_empty(coef)) {
    output$category <- coef$coefficient
  }

  key <- if (perl0(model, "RxHCC")) {
    list(
      hcc = cheapr::c_(cheapr::paste_(prefix, "RxHCC", hcc)),
      model = model
    )
  } else {
    list(
      hcc = cheapr::c_(cheapr::paste_(prefix, "HCC", hcc)),
      model = model
    )
  }

  values <- get_coefficient(
    coefficient = output$category,
    model = key$model
  )

  if (!rlang::is_empty(values)) {
    output$hcc <- rlang::set_names(
      as.list(values$value),
      values$coefficient
    )
  }
  return(output)
}

#' @noRd
get_coefficient <- function(
  coefficient,
  model,
  year = 2026L
) {
  rlang::check_number_whole(
    year,
    min = 2025,
    max = 2026
  )

  model <- rlang::arg_match0(
    model,
    c(
      "CMS-HCC Model V24",
      "CMS-HCC ESRD Model V21",
      "CMS-HCC ESRD Model V24",
      "CMS-HCC Model V22",
      "CMS-HCC Model V28",
      "RxHCC Model V05",
      "RxHCC Model V08",
      "CMS-HCC Model V21",
      "CMS-HCC Model V23"
    )
  )

  # year
  x <- cheapr::sset(
    hcc::ra_coefficients,
    cheapr::which_(year == hcc::ra_coefficients$year)
  )

  # model
  x <- cheapr::sset(x, cheapr::which_(model == x$model_name))

  # coefficient
  cheapr::sset(
    x,
    grep(
      paste0("^", coefficient, "$", collapse = "|"),
      x$coefficient,
      perl = TRUE
    )
  )
}
