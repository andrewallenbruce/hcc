#' @noRd
prefix_esrd <- function(x) {
  if (S7::prop(x, "has_esrd")) {
    if (S7::prop(x, "esrd_months") > 0L) {
      # Functioning graft case
      if (S7::prop(x, "is_lti")) {
        return("GI_")
      }
      if (S7::prop(x, "new_enrollee")) {
        return("GNE_")
      }
      # Community functioning graft
      return(
        cheapr::paste_(
          "G",
          cheapr::if_else_(S7::prop(x, "dual_full"), "F", "NP"),
          cheapr::if_else_(S7::prop(x, "age") >= 65L, "A", "N"),
          "_"
        )
      )
    }
    # Dialysis case
    return(cheapr::if_else_(S7::prop(x, "new_enrollee"), "DNE_", "DI_"))
  }
  # Transplant case
  if (in_between(S7::prop(x, "esrd_months"), 1L, 3L)) {
    return(cheapr::paste_(
      "TRANSPLANT_KIDNEY_ONLY_",
      S7::prop(x, "esrd_months"),
      "M"
    ))
  }
  NA_character_
}

#' @noRd
prefix_rxhcc <- function(x) {
  if (S7::prop(x, "is_lti")) {
    return(cheapr::if_else_(
      S7::prop(x, "new_enrollee"),
      "Rx_NE_LTI_",
      "Rx_CE_LTI_"
    ))
  }
  if (S7::prop(x, "new_enrollee")) {
    return(cheapr::if_else_(
      S7::prop(x, "low_income"),
      "Rx_NE_Lo_",
      "Rx_NE_NoLo_"
    ))
  }
  cheapr::paste_(
    "Rx_CE_",
    cheapr::if_else_(S7::prop(x, "low_income"), "Low", "NoLow"),
    cheapr::if_else_(S7::prop(x, "age") >= 65L, "Aged", "NoAged"),
    "_"
  )
}

#' Demographics-Based Coefficient Prefix
#'
#' Get the coefficient prefix based on beneficiary demographics.
#'
#' @param x `<PatientDemographics>` S7 object
#' @param model `<chr>` model name; default is `"C28"`
#' @returns String prefix used to look up coefficients for beneficiary type
#' @examples
#' x = demographics(age = 70, sex = "F", dual = "00", orec = "0", crec = "0")
#' prefix(x, model = "C28")
#' prefix(x, model = "D24")
#' prefix(x, model = "R05")
#' @export
prefix <- function(x, model = "C28") {
  if (!S7::S7_inherits(x, PatientDemographics)) {
    cli::cli_abort(
      c(
        "{.arg {x}} must be a {.cls hcc::PatientDemographics} object, not {.obj_type_friendly {x}}",
        "i" = "Create one with {.fn hcc::demographics}"
      ),
      call = rlang::caller_env()
    )
  }

  model <- rlang::arg_match0(model, rlang::names2(MODEL))

  if (model %in_% c("D20", "D21", "D24")) {
    return(prefix_esrd(x))
  }
  if (model %in_% c("R05", "R08")) {
    return(prefix_rxhcc(x))
  }

  if (S7::prop(x, "is_lti")) {
    return("INS_")
  }

  if (S7::prop(x, "new_enrollee")) {
    return(cheapr::if_else_(S7::prop(x, "has_snp"), "SNPNE_", "NE_"))
  }

  # Community case
  cheapr::paste_(
    cheapr::paste_(
      "C",
      cheapr::case(
        isTRUE(S7::prop(x, "dual_full")) ~ "F",
        isTRUE(S7::prop(x, "dual_part")) ~ "P",
        .default = "N"
      )
    ),
    cheapr::if_else_(S7::prop(x, "age") >= 65L, "A", "D"),
    "_"
  )
}
