#' X12-834 (X220A1) Benefit Enrollment Parser
#'
#' The 834 carries *membership events*:
#'    - new enrollment (qualifier 021)
#'    - change (001)
#'    - termination (024)
#'    - audit/reconciliation (030)
#'
#' It transports member demographics, dependents, chosen plan, effective and end
#' dates, premium amounts, occasionally tax elements and primary care provider.
#' It is the system of record for membership on the payer side.
#'
#' The 834 is heavily used by BPaaS (Benefits Administration as a Service):
#'    - Workday Benefits
#'    - ADP TotalSource
#'    - bswift
#'    - BenefitFocus
#'    - Empyrean
#'
#' It is also the official pipe between ACA state exchanges / marketplaces and
#' payers. The Open Enrollment window (November – December) produces volume
#' spikes that stress overnight batch jobs.
#'
#' Extracts enrollment and demographic data from 834 transactions with focus on:
#'    - Risk adjustment fields (dual eligibility, OREC/CREC, SNP, LTI)
#'    - CA DHCS FAME-specific fields
#'    - HCP (Health Care Plan) coverage history
#'
#' @param x `<chr>` string of raw X12-834 text
#' @returns list
#' @examplesIf FALSE
#' x = purrr::map(hcc::x12_834, index_x12)
#' purrr::map(x, parse_834)
#' @export
parse_834 <- function(x) {
  if (!S7::S7_inherits(x, IndexX12)) {
    return(NA_character_)
  }

  header <- list(
    ISA = split_7(x, "ISA"),
    GS = split_7(x, "GS"),
    ST = split_7(x, "ST"),
    BGN = split_7(x, "BGN"),
    REF38 = split_7(x, "REF38"),
    DTP007 = split_7(x, "DTP007"),
    QTY = split_7(x, "QTY"),
    N1P5 = split_7(x, "N1P5"),
    N1IN = split_7(x, "N1IN")
  )
  entity <- parse_834_INS(x)
  trailer <- parse_TRAILER(x)

  purrr::compact(c(header, entity, trailer))
}

#' @noRd
parse_834_INS <- function(x) {
  ins <- .subset2(x@index, "INS")
  ise <- .subset2(x@index, "SE")
  purrr::map(
    fill_(
      start = ins,
      end = c(.subset(ins, -1L), ise) - 1L,
      as_list = TRUE
    ),
    function(idx) {
      strsplit(.subset(x@text, idx), "[;*]", perl = TRUE)
    }
  ) |>
    rlang::set_names(
      ~ cheapr::paste_(
        "INS_",
        seq_along(.)
      )
    ) |>
    purrr::list_flatten() |>
    purrr::map(set_zchar)
}
