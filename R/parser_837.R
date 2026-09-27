#' X12-837I (X223A3) & X12-837P (X222A2) Health Care Claim Parser
#'
#' The 837 describes the care event: who (rendering provider, supervising
#' physician, referring), for whom (subscriber, patient), for what (ICD-10
#' diagnosis, CPT/HCPCS procedure), when (service date, units), where (place of
#' service), and how much (charged amount, contractual reference). Three `TR3`s
#' segment the audience:
#'    - `005010X222A1`: **837P** Professional (Physicians, Ambulatory, Telemedicine)
#'    - `005010X223A2`: **837I** Institutional (Hospitals, ED, Hospice)
#'    - `005010X224A2`: **837D** Dental
#'
#' The 837 is the highest-volume transaction in US healthcare EDI. Every
#' commercial and public payer (Medicare, Medicaid, Tricare) consumes hundreds
#' of millions per month.
#'
#' The entire provider-side billing revolves around its generation: from the EHR
#' (Epic, Cerner, Athenahealth, NextGen) or the PMS (Kareo, AdvancedMD,
#' eClinicalWorks), through a clearinghouse (Availity, Change Healthcare,
#' Waystar, Trizetto), with `277CA`, `999`, and ultimately `835` returns.
#'
#' ## Common segments
#' ### Transaction Set Header
#'    - `BHT`: Beginning of Hierarchical Transaction
#'       - Purpose `00` (Original)
#'       - Transaction type `CH` (Chargeable)
#'       - `RP` Reporting
#'       - Submitter `NM1*41`
#'       - Receiver `NM1*40`
#' ### Detail: Three hierarchical levels
#'    - `2000A` Billing Provider (Practice or Facility, with NPI, Taxonomy, TIN)
#'    - `2000B` Subscriber Loop (Contract Holder)
#'       - `SBR`:
#'          - Subscriber Information with relationship code
#'          - Claim filing indicator (`CI` Commercial Insurance, `MB` Medicare Part B, `MC` Medicaid, etc.)
#'    - `2000C` Patient Loop (the Patient when different from the Subscriber).
#'       - At the claim level, `CLM` Claim Information carries the patient account, total charge, facility code, claim frequency.
#'       - `HI` Health Care Information Codes carries ICD-10 diagnoses (qualifier `ABK` Principal Diagnosis, `ABF` Other Diagnosis).
#'       - The service section groups `LX` + `SV1` (Professional) / `SV2` (Institutional) / `SV3` (Dental) detailing each procedure with its CPT / HCPCS / CDT code, modifiers, units, charge, and service date via `DTP`.
#' ### Summary
#'    - a single `SE`
#'
#' @param x `<chr>` string of raw X12-837 text
#' @returns list
#' @examplesIf FALSE
#' purrr::map(hcc::x12_837I, index_x12) |> purrr::map(parse_837)
#' purrr::map(hcc::x12_837P, index_x12) |> purrr::map(parse_837)
#' @export
parse_837 <- function(x) {
  if (!S7::S7_inherits(x, X12Index)) {
    return(NA_character_)
  }

  header <- list(
    ISA = split_7(x, "ISA"),
    GS = split_7(x, "GS"),
    ST = split_7(x, "ST"),
    BHT = split_7(x, "BHT")
  )

  middle <- parse_837_MID(x)
  trailer <- parse_TRAILER(x)

  # .subset(x@text, x@index$HIABK)

  claim <- purrr::map(
    fill_(x@index$CLM, x@index$SE - 1L),
    function(idx) {
      strsplit(.subset(x@text, idx), "*", fixed = TRUE)
    }
  ) |>
    purrr::list_flatten() |>
    purrr::map(set_zchar)

  purrr::compact(c(header, middle, claim, trailer))
}

#' @noRd
parse_837_MID <- function(x) {
  middle <- purrr::map(
    fill_(x@index$NM141, x@index$CLM - 1L),
    function(idx) {
      strsplit(.subset(x@text, idx), "*", fixed = TRUE)
    }
  ) |>
    purrr::list_flatten() |>
    purrr::map(set_zchar)

  rlang::set_names(
    middle,
    purrr::map_chr(middle, \(x) paste0(x[1], x[2]))
  )
}
