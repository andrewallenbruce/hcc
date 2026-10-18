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
#' @param reason `<chr>` `ADX-02` Adjustment reason code ("53" = prior period)
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
#' x = edi_parse(hcc::x12_EX$`820`$`218`$sample_820_01)
#' PaymentData(
#' source = x@Header@ISA[6L],
#' report_date = x@Header@GS[4L],
#' total_amount = x@Details@BPR[2L],
#' payment_date = x@Details@BPR[16L],
#' check_number = x@Details@TRN[2L],
#' payee = hcc:::Party(
#' name = x@Details@N1PE[1L],
#' address = x@Details@N1PE[-1L]),
#' payer = hcc:::Party(
#' name = x@Details@N1PR[1L],
#' address = x@Details@N1PR[-1L]),
#' payments = list(
#' Payment(
#' order = x@Entity[[1L]][[1L]][2L],
#' member = hcc:::Member(
#' id = x@Entity[[1L]][[2L]][10L],
#' last = x@Entity[[1L]][[2L]][4L],
#' first = x@Entity[[1L]][[2L]][5L]),
#' remits = list(
#' Remittance(
#' reference = x@Entity[[2L]][[1L]][3L],
#' payment = x@Entity[[2L]][[1L]][5L],
#' original = x@Entity[[2L]][[1L]][6L],
#' rate = x@Entity[[2L]][[2L]][3L],
#' aid = x@Entity[[2L]][[3L]][3L],
#' plan = x@Entity[[2L]][[3L]][4L],
#' description = x@Entity[[2L]][[4L]][3L],
#' coverage = x@Entity[[2L]][[5L]][7L]))),
#' Payment(
#' order = x@Entity[[7L]][[1L]][2L],
#' member = hcc:::Member(
#' id = x@Entity[[7L]][[2L]][10L],
#' last = x@Entity[[7L]][[2L]][4L],
#' first = x@Entity[[7L]][[2L]][5L]),
#' remits = list(
#' Remittance(
#' reference = x@Entity[[8L]][[1L]][3L],
#' payment = x@Entity[[8L]][[1L]][5L],
#' original = x@Entity[[8L]][[1L]][6L],
#' rate = x@Entity[[8L]][[2L]][3L],
#' aid = x@Entity[[8L]][[3L]][3L],
#' plan = x@Entity[[8L]][[3L]][4L],
#' description = x@Entity[[8L]][[4L]][3L],
#' coverage = x@Entity[[8L]][[5L]][7L])))))
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
