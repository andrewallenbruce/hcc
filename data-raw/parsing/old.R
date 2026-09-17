EditRule := S7::new_class(
  abstract = TRUE,
  properties = list(
    icd = S7::class_character,
    action = S7::class_character,
    override = S7::class_integer,
    model = S7::class_character,
    description = S7::class_character
  ),
  validator = function(self) {
    if (!rlang::is_empty(self@edit_type)) {
      if (length(self@edit_type) != 1L) {
        return("@edit_type must be length 1")
      }
      if (!self@edit_type %in% c("sex", "age")) {
        return("@edit_type must be either `sex` or `age`")
      }
    }

    if (self@edit_type == "sex") {
      if (length(self@sex) != 1L) {
        return("@sex must be length 1")
      }
      if (!self@sex %in% 1:2) {
        return("@sex must be either `1` or `2`")
      }
    }

    if (self@edit_type == "age") {
      if (length(self@age_min) != 1L) {
        return("@age_min must be length 1")
      }
      if (length(self@age_max) != 1L) {
        return("@age_max must be length 1")
      }
      if (self@age_min >= self@age_max) {
        return("@age_min must be < @age_max")
      }
    }

    if (!rlang::is_empty(self@action)) {
      if (length(self@action) != 1L) {
        return("@action must be length 1")
      }
      if (!self@action %in% c("invalid", "override")) {
        return("@action must be either `invalid` or `override`")
      }

      if (self@action == "override") {
        if (rlang::is_empty(self@cc_override)) {
          return("@cc_override cannot be empty when @action = `override`")
        }
      }
    }
    if (!rlang::is_empty(self@cc_override)) {
      if (length(self@cc_override) != 1L) {
        return("@cc_override must be length 1")
      }
    }
  }
)
