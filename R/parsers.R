#' @noRd
split_tilde <- function(x) {
  strsplit(x, "~", fixed = TRUE)[[1]]
}

#' @noRd
split_isa <- function(x) {
  x = strsplit(x, " ", fixed = TRUE)[[1]]
  x = unlist_(strsplit(x[nzchar(x)], "*", fixed = TRUE))[c(-1, -8, -11)]
  pad_names(x, replace_na = TRUE)
}

#' @noRd
split_star <- function(x, pad = TRUE, replace_na = FALSE) {
  if (!pad) {
    return(strsplit(x, "*", fixed = TRUE)[[1]][-1])
  }
  pad_names(
    strsplit(x, "*", fixed = TRUE)[[1]][-1],
    replace_na = replace_na
  )
}

#' @noRd
pad_names <- function(x, replace_na = FALSE) {
  if (replace_na) {
    x[!nzchar(x)] <- NA_character_
  }

  N = as.character(seq_along(x))
  i = cheapr::which_(nchar(N) == 1L)
  N[i] = cheapr::paste_("0", N[i])
  rlang::set_names(as.list(x), N)
}

#' X12-820 Payment Order/Remittance Advice Parser
#'
#' Parses X12-820 (005010X218) transactions for Medicaid/Medicare capitation and
#' premium payments. Designed for California DHCS PACE capitation remittances
#' but handles the general 820 format used by state Medicaid agencies.
#'
#' Key segments parsed:
#'    - `ISA/GS`: Interchange and group headers (source ID, report date)
#'    - `BPR`: Payment amount and effective date
#'    - `TRN`: EFT/check trace number
#'    - `N1/N3/N4`: Payer and payee name and address
#'    - `ENT`: Per-member entity loop start
#'    - `NM1`: Member name and ID
#'    - `RMR`: Remittance line item (reference number, payment amount)
#'    - `REF*18`: Rate code (e.g., "957" = PACE rate)
#'    - `REF*ZZ`: Aid code/plan type composite and description
#'    - `DTM*582`: Coverage period date range
#'    - `ADX`: Adjustment amount and reason code
#'
#' Typical loop structure within an 820:
#'    - Header: `ISA` > `GS` > `ST` > `BPR` > `TRN` > `N1*PE` > `N1*PR`
#'    - Per-member: `ENT` > `NM1` > (`RMR` > `REF*18` > `REF*ZZ` > `REF*ZZ` > `DTM*582` > `ADX`)
#'    - Trailer: `SE` > `GE` > `IEA`
#'
#' @param text `<chr>` string of raw X12-820 text
#' @returns list
#' @examples
#' purrr::map(hcc::x12_820[1:3], parse_820)
#' @export
parse_820 <- function(text) {
  x = split_tilde(text)

  header <- list(
    ISA = split_isa(x[1]),
    GS = split_star(x[2]),
    ST = split_star(x[3]),
    BPR = split_star(x[4], replace_na = TRUE),
    TRN = split_star(x[5]),
    REF = split_star(x[6]),
    `N1*PE` = split_star(x[7]),
    `N3*PE` = split_star(x[8]),
    `N4*PE` = split_star(x[9]),
    `N1*PR` = split_star(x[10]),
    `N3*PR` = split_star(x[11]),
    `N4*PR` = split_star(x[12])
  ) |>
  collapse::unlist2d(idcols = "id") |>
    collapse::rnm("id.1" = "SEG", "id.2" = "PT", "V1" = "VALUE")

  start = grep("^ENT", x, perl = TRUE)
  end = c(start[-1], grep("^SE", x, perl = TRUE)) - 1L

  loops <- purrr::map2(start, end, function(x, y) {
    seq.int(x, y)
  })

  loop <- purrr::map(loops, \(i) x[i])
  loop <- rlang::set_names(loop, paste0("L", seq_along(loop)))

  trailer <- list(
    SE = split_star(x[grep("^SE", x)]),
    GE = split_star(x[grep("^GE", x)]),
    IEA = split_star(x[grep("^IEA", x)])
  ) |>
    collapse::unlist2d(idcols = "id") |>
    collapse::rnm("id.1" = "SEG", "id.2" = "PT", "V1" = "VALUE")

  list(
    HEADER = header,
    LOOP = loop,
    TRAILER = trailer
  )
}
