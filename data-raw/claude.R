# Illustrative CMS-HCC risk adjustment score calculator

# ---- 1. Reference tables ----------
dx_to_hcc <- tibble::tribble(
  ~icd    , ~hcc ,
  "E119"  ,  38L , # Diabetes, no complications
  "E1122" ,  37L , # Diabetes with chronic complications
  "N184"  , 327L , # CKD, severe (stage 4)
  "I509"  , 226L # Heart failure
)

# Hierarchy: if the "parent" HCC is present, drop the listed "child" HCCs
hierarchy <- tibble::tribble(
  ~cc_parent , ~cc_child ,
  37L        , 38L
)

# Placeholders
hcc_coef <- c(`37` = 0.166, `38` = 0.166, `327` = 0.514, `226` = 0.360)

# Interactions: Age/Sex/Medicaid Segment
demo_factor <- 0.40
interaction_coef <- c(diabetes_hf = 0.100)
count_coef <- function(n) dplyr::case_when(n >= 3 ~ 0.050, TRUE ~ 0L)

# set annually by CMS
normalization <- 1.015
coding_intensity <- 0.059

# ---- 2. Scoring function --------------------------------------------------
calc_raf <- function(icd_codes) {
  # Map diagnoses to unique HCCs (unmapped codes drop out)
  icd <- gsub(".", "", toupper(icd_codes), fixed = TRUE)
  hcc <- icd_to_cc(icd = icd, model = "C28", year = 2026L) |> _$cc
  hierarchy <- cc_to_hierarchy(cc = hcc, model = "C28", year = 2026L)

  # if the "parent" HCC is present, drop the listed "child" HCCs
  drop <- collapse::ss(hierarchy, hierarchy[["cc_parent"]] %iin% hcc)$cc_child
  hcc <- setdiff(hcc, drop)

  # HCC coefficients
  hcc_sum <- collapse::fsum.default(hcc_coef[as.character(hcc)])

  # Interactions (diabetes HCCs 36-38 + heart failure HCC 226)
  has_dm <- any_(hcc %iin% c(36L, 37L, 38L))
  has_hf <- 226L %in_% hcc
  inter <- if (has_dm && has_hf) interaction_coef[["diabetes_hf"]] else 0L

  # Payment HCC count factor
  cnt <- count_coef(length(hcc))
  raw <- demo_factor + hcc_sum + inter + cnt
  final <- raw / normalization * (1L - coding_intensity)

  list(
    icds = icd_codes,
    hccs = hcc,
    raw_score = raw,
    final_score = final
  )
}

# ---- 3. Example -----------------------------------------------------------

calc_raf(icd_codes = c("E11.9", "E11.22", "N18.4", "I50.9"))

# E11.9 is dropped by the hierarchy; E11.22 (HCC 37) is kept.
