#' @noRd
get_coefficient <- function(coefficient, model, year) {
  rlang::check_number_whole(
    year,
    min = 2025,
    max = 2026,
    allow_null = TRUE
  )

  # year
  x <- if (is.null(year)) {
    hcc::ra_coefficients
  } else {
    collapse::ss(
      hcc::ra_coefficients,
      collapse::whichv(
        hcc::ra_coefficients[["year"]],
        year
      )
    )
  }

  # model
  if (!is.null(model)) {
    model <- convert_model(model)
    x <- collapse::ss(x, collapse::whichv(x[["model_name"]], model))
  }

  # coefficient
  if (is.null(coefficient)) {
    return(x)
  }
  collapse::ss(x, collapse::whichv(x[["coefficient"]], coefficient))
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
#' @param year Model year; default is 2026
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
#'     dual = "00",
#'     orec = "0",
#'     crec = "0",
#'     version = "V2",
#'     new = FALSE,
#'     snp = FALSE,
#'     low = FALSE
#'   )
#' )
#' @export
apply_coefficients <- function(
  demographics,
  interactions,
  coefficients = NULL,
  hcc,
  model = "C28",
  year = 2026L,
  prefix_override = NULL
) {
  prefix <- if (!is.null(prefix_override)) {
    prefix_override
  } else {
    prefix(demographics, model)
  }

  model <- convert_model(model)

  # No-prefix lookup for ESRD duration coefficients stored without prefix
  # ESRD V21: GE65_DUR*, LT65_DUR*
  # ESRD V24: FGC_*, FGI_*, LTI_GE65/LT65
  if (
    any(startsWith(interactions, "FGC")) |
      any(startsWith(interactions, "FGI")) |
      any(startsWith(interactions, "GE65_DUR")) |
      any(startsWith(interactions, "LT65_DUR")) |
      any(interactions %in% c("LTI_GE65", "LTI_LT65"))
  ) {
    interactions_key = interactions
  } else {
    interactions_key = cheapr::paste_(prefix, interactions)
  }

  demographics_key = cheapr::paste_(prefix, demographics@category)
  infix = cheapr::if_else_(perl0(model, "RxHCC"), "RxHCC", "HCC")
  key = cheapr::paste_(prefix, infix, hcc)

  if (!is.null(coefficients)) {
    coef = cheapr::sset(
      coefficients,
      cheapr::which_(c(key, interactions_key) %in_% coefficients$coefficient)
    )

    hcc_key = rlang::set_names(c(hcc, interactions), c(key, interactions_key))

    output = rlang::set_names(
      as.list(coef$value),
      unname(hcc_key[coef$coefficient])
    )
  } else {
    coef = get_coefficient(demographics_key, model, year)
    values = get_coefficient(key, model, year)
    output = list()
    if (!rlang::is_empty(coef)) {
      output$category <- coef$coefficient
    }

    if (!rlang::is_empty(values)) {
      output$hcc <- rlang::set_names(
        as.list(values$value),
        values$coefficient
      )
    }
  }

  return(output)
}


#' @noRd
apply_coefficients2 <- function(
  demographics,
  interactions = NA,
  coefficients = NULL,
  hcc = NA,
  model = "C28",
  year = 2026L,
  prefix_override = NULL
) {
  model <- rlang::arg_match0(model, MODEL)

  prefix <- if (!is.null(prefix_override)) {
    prefix_override
  } else {
    prefix(demographics, model)
  }

  # No-prefix lookup for ESRD duration
  # coefficients stored without prefix
  # ESRD V21: GE65_DUR*, LT65_DUR*
  # ESRD V24: FGC_*, FGI_*, LTI_GE65/LT65

  # if (
  #   any(startsWith(interactions, "FGC")) |
  #     any(startsWith(interactions, "FGI")) |
  #     any(startsWith(interactions, "GE65_DUR")) |
  #     any(startsWith(interactions, "LT65_DUR")) |
  #     any(interactions %in% c("LTI_GE65", "LTI_LT65"))
  # ) {
  #   interactions_key = interactions
  # } else {
  #   interactions_key = cheapr::paste_(prefix, interactions)
  # }

  interactions_key = interactions

  if (!cheapr::is_na(interactions)) {
    interactions_key = cheapr::paste_(prefix, interactions)
  }

  demographics_key = cheapr::paste_(prefix, demographics@category)
  coefficients_key = cheapr::paste_(
    prefix,
    cheapr::if_else_(perl0(model, "RxHCC"), "RxHCC", "HCC"),
    if (all(cheapr::is_na(hcc))) NULL else hcc
  )

  if (!is.null(coefficients)) {
    search_ = c(demographics_key, coefficients_key, interactions_key)
    index_ = collapse::fmatch(search_, coefficients$coefficient, nomatch = 0L)
    coef = cheapr::sset(coefficients, index_)

    # all(cheapr::is_na(c(hcc, interactions)))

    hcc_ = rlang::set_names(c(hcc, interactions), search_[index_])

    output = rlang::set_names(
      as.list(coef$value),
      unname(hcc_[coef$coefficient])
    )
  } else {
    # coef = get_coefficient(demographics_key, model, year)
    # values = get_coefficient(key, model, year)
    # output = list()
    # if (!rlang::is_empty(coef)) {
    #   output$category <- coef$coefficient
    # }
    #
    # if (!rlang::is_empty(values)) {
    #   output$hcc <- rlang::set_names(
    #     as.list(values$value),
    #     values$coefficient
    #   )
    # }
  }

  return(output)
}
