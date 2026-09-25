#' Remittance Line Item
#'
#' A single remittance line item within a member's payment record.
#'
#' @details
#' Each RemittanceEntry corresponds to one RMR segment and its associated REF,
#' DTM, and ADX segments within an ENT loop of an 820 transaction.
#'
#' @param reference_number `<chr>` `RMR-02` Invoice/check reference number
#' @param payment_amount `<chr>` `RMR-04/RMR-05` Net payment amount for this
#'   period; negative = recoupment
#' @param original_amount `<chr>` `RMR-05/RMR-06` Original amount before
#'   adjustment (when present)
#' @param rate_code `<chr>` `REF*18` Rate code (e.g., "957" = PACE rate)
#' @param aid_code `<chr>` `REF*ZZ` California Medi-Cal aid code (e.g., "1H",
#'   "M1", "60")
#' @param plan_type `<chr>` `REF*ZZ` Plan type; Composite aid_code;plan_type
#'    - "1": primary/medical
#'    - "2" = pharmacy/state-only
#' @param payment_description `<chr>` `REF*ZZ` Payment description (e.g., "Primary
#'   Capitation Dual", "Medi-Cal Only-State Only")
#' @param coverage_start `<Date>` `DTM*582` Coverage period begin date
#'   (YYYY-MM-DD)
#' @param coverage_end `<Date>` `DTM*582` Coverage period end date
#'   (YYYY-MM-DD) from DTM*582
#' @param coverage_period `<class_iv>` Coverage period start and end date
#' @param adjustment_amount `<chr>` `ADX-01` Adjustment amount; If negative, it
#'   is a recoupment
#' @param adjustment_reason `<chr>` `ADX-02` Adjustment reason code ("53" =
#'   prior period)
#' @returns A `<RemittanceEntry>` S7 object
#' @usage NULL
#' @examples
#' RemittanceEntry(
#'   reference_number = "TESTPLAN-SREGLR-2602200043000P",
#'   payment_amount = 401.72,
#'   original_amount = 8488.25,
#'   rate_code = "957",
#'   aid_code = "17",
#'   plan_type = "2",
#'   payment_description = "Dual-State Only",
#'   coverage_start = "2026-01-01",
#'   coverage_end = "2026-01-31",
#'   coverage_period = ivs::iv_pairs(c(as.Date("2026-01-01"), as.Date("2026-01-31") + 1L)),
#'   adjustment_amount = -8086.53,
#'   adjustment_reason = "53"
#' )
#' @name RemittanceEntry
#' @export
RemittanceEntry := S7::new_class(
  properties = list(
    reference_number = S7::class_character,
    payment_amount = S7::class_double,
    original_amount = S7::class_double,
    rate_code = S7::class_character,
    aid_code = S7::class_character,
    plan_type = S7::class_character,
    payment_description = S7::class_character,
    coverage_start = prop_date,
    coverage_end = prop_date,
    coverage_period = S7::new_property(
      class_iv,
      default = quote(ivs::iv_pairs(c(Sys.Date(), Sys.Date() + 1L)))
    ),
    adjustment_amount = S7::class_double,
    adjustment_reason = S7::class_character
  )
)

#' Per-Member Payment Record from an X12-820 ENT Loop
#'
#' One PaymentDetail is created per ENT segment. A member may
#' appear in multiple ENT entries within the same transaction
#' (e.g., retroactive adjustments for prior periods).
#'
#' @param entity_number `<chr>` `ENT-01` ENT sequence number
#' @param member_id `<chr>` `NM1-09` Member identifier
#' @param last_name `<chr>` `NM1-03` Member last name
#' @param first_name `<chr>` `NM1-04` Member first name
#' @param middle_name `<chr>` `NM1-05` Member middle name
#' @param remittance_entries List of `<RemittanceEntry>` line items (one per
#'   RMR/DTM set)
#' @returns A `<PaymentDetail>` S7 object
#' @usage NULL
#' @examples
#' PaymentDetail(
#'   entity_number = "1",
#'   member_id = "TESTMBR000000001",
#'   last_name = "LASTNAME01",
#'   first_name = "FIRSTNAME01",
#'   remittance_entries = list(
#'     RemittanceEntry(
#'       reference_number = "TESTPLAN-SREGLR-2602200043000P",
#'       payment_amount = 401.72,
#'       original_amount = 8488.25,
#'       rate_code = "957",
#'       aid_code = "17",
#'       plan_type = "2",
#'       payment_description = "Dual-State Only",
#'       coverage_start = "2026-01-01",
#'       coverage_end = "2026-01-31",
#'       coverage_period = ivs::iv_pairs(c(as.Date("2026-01-01"), as.Date("2026-01-31") + 1L)),
#'       adjustment_amount = -8086.53,
#'       adjustment_reason = "53"
#'     )
#'   )
#' )
#' @name PaymentDetail
#' @export
PaymentDetail := S7::new_class(
  properties = list(
    entity_number = S7::class_character,
    member_id = S7::class_character,
    last_name = S7::class_character,
    first_name = S7::class_character,
    middle_name = S7::class_character,
    remittance_entries = S7::class_list
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
#' @param payee_name `<chr>` `N1*PE` Receiving organization name
#' @param payee_address `<chr>` `N3` Payee street address
#' @param payee_city `<chr>` `N4` Payee city
#' @param payee_state `<chr>` `N4` Payee state
#' @param payee_zip `<chr>` `N4` Payee ZIP code
#' @param payer_name `<chr>` `N1*PR` Paying organization name
#' @param payer_address `<chr>` `N3` Payer street address
#' @param payer_city `<chr>` `N4` Payer city
#' @param payer_state `<chr>` `N4` Payer state
#' @param payer_zip `<chr>` `N4` Payer ZIP code
#' @param payment_details `<PaymentDetail>` List of per-member payment records
#' @returns A `<PaymentData>` S7 object
#' @usage NULL
#' @examples
#' PaymentData(
#'   source = "TEST-PAYER",
#'   report_date = "2026-03-16",
#'   payment_date = "2026-03-12",
#'   total_amount = 91977.81,
#'   check_number = "TESTTRN02000001",
#'   payee_name = "TEST PAYEE ORGANIZATION",
#'   payee_address = "123 TEST STREET",
#'   payee_city = "TESTCITY",
#'   payee_state = "CA",
#'   payee_zip = "00000",
#'   payer_name = "TEST PAYER AGENCY",
#'   payer_address = "123 TEST STREET",
#'   payer_city = "TESTCITY",
#'   payer_state = "CA",
#'   payer_zip = "00000",
#'   payment_details = list(
#'     PaymentDetail(
#'       entity_number = "1",
#'       member_id = "TESTMBR000000001",
#'       last_name = "LASTNAME01",
#'       first_name = "FIRSTNAME01",
#'       remittance_entries = list(
#'         RemittanceEntry(
#'           reference_number = "TESTPLAN-SREGLR-2602200043000P",
#'           payment_amount = 401.72,
#'           original_amount = 8488.25,
#'           rate_code = "957",
#'           aid_code = "17",
#'           plan_type = "2",
#'           payment_description = "Dual-State Only",
#'           coverage_start = "2026-01-01",
#'           coverage_end = "2026-01-31",
#'           coverage_period = ivs::iv_pairs(c(as.Date("2026-01-01"), as.Date("2026-01-31") + 1L)),
#'           adjustment_amount = -8086.53,
#'           adjustment_reason = "53"
#'         )
#'       )
#'     )
#'   )
#' )
#' @name PaymentData
#' @export
PaymentData := S7::new_class(
  properties = list(
    source = S7::class_character,
    report_date = prop_date,
    payment_date = prop_date,
    total_amount = S7::class_double,
    check_number = S7::class_character,
    payee_name = S7::class_character,
    payee_address = S7::class_character,
    payee_city = S7::class_character,
    payee_state = S7::class_character,
    payee_zip = S7::class_character,
    payer_name = S7::class_character,
    payer_address = S7::class_character,
    payer_city = S7::class_character,
    payer_state = S7::class_character,
    payer_zip = S7::class_character,
    payment_details = S7::class_list
  )
)
