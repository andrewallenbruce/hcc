#' @noRd
Party := S7::new_class(
  properties = list(
    name = S7::class_character,
    address = S7::class_character
  )
)

#' @noRd
Member := S7::new_class(
  properties = list(
    id = S7::class_character,
    last = S7::class_character,
    first = S7::class_character,
    middle = S7::class_character
  )
)

#' Remittance Line Item
#'
#' A single remittance line item within a member's payment record.
#'
#' @details
#' Each Remittance corresponds to one RMR segment and its associated REF,
#' DTM, and ADX segments within an ENT loop of an 820 transaction.
#'
#' @param reference `<chr>` `RMR-02` Invoice/check reference number
#' @param payment `<chr>` `RMR-04/RMR-05` Net payment amount for this
#'   period; negative = recoupment
#' @param original `<chr>` `RMR-05/RMR-06` Original amount before
#'   adjustment (when present)
#' @param rate `<chr>` `REF*18` Rate code (e.g., "957" = PACE rate)
#' @param aid `<chr>` `REF*ZZ` California Medi-Cal aid code (e.g., "1H",
#'   "M1", "60")
#' @param plan `<chr>` `REF*ZZ` Plan type; Composite aid_code;plan_type
#'    - "1": primary/medical
#'    - "2" = pharmacy/state-only
#' @param description `<chr>` `REF*ZZ` Payment description (e.g., "Primary
#'   Capitation Dual", "Medi-Cal Only-State Only")
#' @param coverage `<class_iv>` Coverage period start and end date (YYYY-MM-DD) from DTM*582
#' @param adjustment `<chr>` `ADX-01` Adjustment amount; If negative, it
#'   is a recoupment
#' @param reason `<chr>` `ADX-02` Adjustment reason code ("53" =
#'   prior period)
#' @returns A `<hcc::Remittance>` S7 object
#' @export
Remittance := S7::new_class(
  properties = list(
    reference = S7::class_character,
    original = prop_double,
    adjustment = prop_double,
    payment = prop_double,
    rate = S7::class_character,
    aid = S7::class_character,
    plan = S7::class_character,
    reason = S7::class_character,
    description = S7::class_character,
    coverage = prop_dtm_rd8
  )
)

#' Per-Member Payment Record from an X12-820 ENT Loop
#'
#' One Payment is created per ENT segment. A member may
#' appear in multiple ENT entries within the same transaction
#' (e.g., retroactive adjustments for prior periods).
#'
#' @param order `<int>` `ENT-01` ENT sequence number
#' @param member `<hcc::Member>`
#'    - `NM1-09` Member identifier
#'    - `NM1-03` Member last name
#'    - `NM1-04` Member first name
#'    - `NM1-05` Member middle name
#' @param remits list of `<hcc::Remittance>` objects, line items (one per RMR/DTM set)
#' @returns A `<hcc::Payment>` S7 object
#' @export
Payment := S7::new_class(
  properties = list(
    order = prop_integer,
    member = Member,
    remits = prop_list_of(Remittance)
  )
)

#' X12-820 Transaction Remittance Data
#'
#' Represents one ST*820 transaction, typically a capitation
#' payment remittance from a state Medicaid agency or CMS to
#' a managed care plan.
#'
#' @param source `<chr>` `ISA-06` Interchange sender ID, e.g., "CALIFORNIA-DHCS"
#' @param report_date `<Date>` `GS-04` Transaction date (YYYY-MM-DD)
#' @param total_amount `<chr>` `BPR-02` Total payment amount
#' @param payment_date `<Date>` `BPR-16` EFT effective date (YYYY-MM-DD)
#' @param check_number `<chr>` `TRN-02` EFT/check trace number
#' @param payee `<hcc::Party>` Receiving organization name, street address, city, state, zip
#' @param payer `<hcc::Party>` Paying organization name, street address, city, state, zip
#' @param payments list of `<hcc::Payment>` objects, per-member payment records
#' @returns A `<hcc::PaymentData>` S7 object
#' @examplesIf FALSE
#' x =  hcc:::parse_218(edi_index(hcc::x12_EX$`820`$`218`$sample_820_01))
#' PaymentData(
#'   source = purrr::pluck(x, "header", "ISA", 6L),
#'   report_date = purrr::pluck(x, "header", "GS", 4L),
#'   total_amount = purrr::pluck(x, "details", 1L, 3L),
#'   payment_date = purrr::pluck(x, "details", 1L, 17L),
#'   check_number = purrr::pluck(x, "details", 2L, 3L),
#'   payee = hcc:::Party(
#'     name = purrr::pluck(x, "details", 4L, 3L),
#'     address = c(
#'       purrr::pluck(x, "details", 5L, 2L),
#'       purrr::pluck(x, "details", 6L, 2L),
#'       purrr::pluck(x, "details", 6L, 3L),
#'       purrr::pluck(x, "details", 6L, 4L)
#'     )
#'   ),
#'   payer = hcc:::Party(
#'     name = purrr::pluck(x, "details", 7L, 3L),
#'     address = c(
#'       purrr::pluck(x, "details", 8L, 2L),
#'       purrr::pluck(x, "details", 9L, 2L),
#'       purrr::pluck(x, "details", 9L, 3L),
#'       purrr::pluck(x, "details", 9L, 4L)
#'     )
#'   ),
#'   payments = list(
#'     Payment(
#'       order = purrr::pluck(x, "entity", 1L, 1L, 1L, 2L),
#'       member = hcc:::Member(
#'         id = purrr::pluck(x, "entity", 1L, 1L, 2L, 10L),
#'         last = purrr::pluck(x, "entity", 1L, 1L, 2L, 4L),
#'         first = purrr::pluck(x, "entity", 1L, 1L, 2L, 5L)
#'       ),
#'       remits = list(
#'         Remittance(
#'           reference = purrr::pluck(x, "entity", 1L, 2L, 1L, 3L),
#'           payment = purrr::pluck(x, "entity", 1L, 2L, 1L, 5L, .default = NA_real_),
#'           original = purrr::pluck(x, "entity", 1L, 2L, 1L, 6L, .default = NA_real_),
#'           rate = purrr::pluck(x, "entity", 1L, 2L, 3L, 3L),
#'           aid = substring(purrr::pluck(x, "entity", 1L, 2L, 3L, 3L), 1L, 2L),
#'           plan = substring(purrr::pluck(x, "entity", 1L, 2L, 3L, 3L), 4L),
#'           description = purrr::pluck(x, "entity", 1L, 2L, 4L, 3L),
#'           coverage = purrr::pluck(x, "entity", 1L, 2L, 5L, 7L)
#'         )
#'       )
#'     ),
#'     Payment(
#'       order = purrr::pluck(x, "entity", 7L, 1L, 1L, 2L),
#'       member = hcc:::Member(
#'         id = purrr::pluck(x, "entity", 7L, 1L, 2L, 10L),
#'         last = purrr::pluck(x, "entity", 7L, 1L, 2L, 4L),
#'         first = purrr::pluck(x, "entity", 7L, 1L, 2L, 5L)
#'       ),
#'       remits = list(
#'         Remittance(
#'           reference = purrr::pluck(x, "entity", 7L, 2L, 1L, 3L),
#'           payment = purrr::pluck(x, "entity", 7L, 2L, 1L, 5L, .default = NA_real_),
#'           original = purrr::pluck(x, "entity", 7L, 2L, 1L, 6L, .default = NA_real_),
#'           rate = purrr::pluck(x, "entity", 7L, 2L, 2L, 3L),
#'           aid = substring(purrr::pluck(x, "entity", 7L, 2L, 3L, 3L), 1L, 2L),
#'           plan = substring(purrr::pluck(x, "entity", 7L, 2L, 3L, 3L), 4L),
#'           description = purrr::pluck(x, "entity", 7L, 2L, 4L, 3L),
#'           coverage = purrr::pluck(x, "entity", 7L, 2L, 5L, 7L)
#'         ),
#'         Remittance(
#'           reference = purrr::pluck(x, "entity", 7L, 2L, 6L, 3L),
#'           payment = purrr::pluck(x, "entity", 7L, 2L, 6L, 5L, .default = NA_real_),
#'           original = purrr::pluck(x, "entity", 7L, 2L, 6L, 6L, .default = NA_real_),
#'           rate = purrr::pluck(x, "entity", 7L, 2L, 7L, 3L),
#'           aid = substring(purrr::pluck(x, "entity", 7L, 2L, 8L, 3L), 1L, 2L),
#'           plan = substring(purrr::pluck(x, "entity", 7L, 2L, 8L, 3L), 4L, 4L),
#'           description = purrr::pluck(x, "entity", 7L, 2L, 9L, 3L),
#'           coverage = purrr::pluck(x, "entity", 7L, 2L, 10L, 7L)
#'         )
#'       )
#'     )
#'   )
#' )
#' @export
PaymentData := S7::new_class(
  properties = list(
    source = S7::class_character,
    report_date = prop_date,
    payment_date = prop_date,
    total_amount = prop_double,
    check_number = S7::class_character,
    payee = Party,
    payer = Party,
    payments = prop_list_of(Payment)
  )
)
