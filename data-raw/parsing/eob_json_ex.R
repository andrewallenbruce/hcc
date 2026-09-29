eob <- zujson::json_parse(hcc::eob_json, data_frame = FALSE)
x <- eob$sample_eob_1
eob$sample_eob_3

list(
  id = x$id,
  resource = x$resourceType,
  patient = x$patient$reference,
  billable_period = list(
    start = x$billablePeriod$start,
    end = x$billablePeriod$start
  ),
  claim_type = list(
    code = x$type$coding[[2]]$code,
    system = x$type$coding[[2]]$system
  ),
  eob_type = list(
    code = x$type$coding[[3]]$code,
    system = x$type$coding[[3]]$system
  ),
  nch_type = list(
    code = x$type$coding[[1]]$code,
    display = x$type$coding[[1]]$display,
    system = x$type$coding[[1]]$system
  ),
  diagnosis = list(
    sequence = x$diagnosis[[1]]$sequence,
    code = x$diagnosis[[1]]$diagnosisCodeableConcept$coding$code,
    display = x$diagnosis[[1]]$diagnosisCodeableConcept$coding$display,
    system = x$diagnosis[[1]]$diagnosisCodeableConcept$coding$system,
    type = list(
      code = x$diagnosis[[1]]$type$coding$code,
      display = x$diagnosis[[1]]$type$coding$display,
      system = x$diagnosis[[1]]$type$coding$system
    )
  ),
  service = list(
    sequence = x$item[[1]]$diagnosisSequence,
    code = x$item[[1]]$productOrService$coding$code,
    system = x$item[[1]]$productOrService$coding$system,
    quantity = x$item[[1]]$quantity$value,
    period = list(
      start = x$item[[1]]$servicedPeriod$start,
      end = x$item[[1]]$servicedPeriod$end
    )
  ),
  care_team = list(
    provider = list(
      identifier = list(
        value = x$careTeam[[1]]$provider$identifier$value,
        code = x$careTeam[[1]]$provider$identifier$type$coding$code,
        display = x$careTeam[[1]]$provider$identifier$type$coding$display,
        system = x$careTeam[[1]]$provider$identifier$type$coding$system
      ),
      qualification = list(
        code = x$careTeam[[1]]$qualification$coding$code,
        display = x$careTeam[[1]]$qualification$coding$display,
        system = x$careTeam[[1]]$qualification$coding$system
      ),
      responsible = x$careTeam[[1]]$responsible,
      role = list(
        code = x$careTeam[[1]]$role$coding$code,
        display = x$careTeam[[1]]$role$coding$display,
        system = x$careTeam[[1]]$role$coding$system
      )
    )
  )
) |>
  str()
