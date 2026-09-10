---
output: html_document
---
# EDI Claim Scrubber — Technical Specification

## Overview

**ANSI X12 Standards**

   - 005010X222A1 (837P)
   - 005010X223A2 (837I)
   - 005010X221A1 (820)
   - 005010X221A1 (835)

**Supported transaction types:**

| Type | Standard | Description |
|---|---|---|
| 837P | 005010X222A1 | Professional claims |
| 837I | 005010X223A2 | Institutional claims |
| 835 | 005010X221A1 | Remittance advice |

---

### Data Flow

```
User input (textarea)
  → parseEDI()        — split on "~", elements on "*", skip blanks
  → detectTxType()    — inspect ST01 + SV2/CL1 presence → 837P | 837I | 835
  → validate()        — run type-specific rules, return { issues, txType }
  → renderStep2()     — display issue list + auto-generate fix forms
  → applyFixes()      — deepCopy(segments) + merge user inputs + auto-corrections
  → validate(fixed)   — re-validate to detect remaining issues
  → renderStep3()     — display corrected EDI with [FIXED] highlights + banner
  → downloadFixed()   — serialize fixedSegments back to EDI text
```

---

## 4. EDI Standards Reference

### Key Syntax Rules

| Concept | Character | Example |
|---|---|---|
| Segment terminator | `~` | `ISA*...*~` |
| Element separator | `*` | `CLM*PAT001*100.00*` |
| Composite separator | `:` | `HC:99213`, `CLM05=11:B:1` |
| Segment identifier | First element | `CLM`, `NM1`, `SV1` |
| Qualifier | Second element | `NM1*85` = Billing Provider |

### Transaction Identifiers

| Transaction | ST01 | GS01 | Standard |
|---|---|---|---|
| 837P Professional Claim | `837` | `HC` | 005010X222A1 |
| 837I Institutional Claim | `837` | `HC` | 005010X223A2 |
| 835 Remittance Advice | `835` | `RA` | 005010X221A1 |

---

## 5. Transaction Type Detection

The detected type determines:
- Which validation rule set to run
- The GS01 expected value (HC vs RA)
- The ST01 expected value (837 vs 835)
- Which fix form fields to generate
- The download filename and button label

---

## 6. Application State Schema

All runtime data is held in a single `state` object. No external storage is used.

```javascript
state = {
  rawText:          string,        // original EDI text from textarea
  segments:         string[][],    // parsed 2D array [segment][element]
  issues:           Issue[],       // validation results
  txType:           string,        // "837P" | "837I" | "835" | "unknown"
  fixedSegments:    string[][],    // deep copy with corrections applied
  fixedIndices:     Set<number>,   // segment indices that were corrected
  remainingIssues:  Issue[]        // issues still present after fixes
}

Issue = {
  segIdx:     number,              // index into segments array (-1 for presence-only checks)
  segLabel:   string,              // e.g. "NM1*85", "CLM", "CLP"
  description: string,            // human-readable error message
  severity:   "ERROR" | "WARNING",
  fixKey:     string | null        // unique key linking to fix form input
}
```

---

## 7. Validation Rules — Shared

These rules apply to all transaction types (837P, 837I, and 835).

### ISA — Interchange Control Header

| Element | Rule | Severity |
|---|---|---|
| ISA (all) | Must have exactly 16 elements | ERROR |
| ISA06 | Sender ID must not be blank (ignoring spaces) | ERROR |
| ISA08 | Receiver ID must not be blank (ignoring spaces) | ERROR |
| ISA09 | Date must be valid 6-digit YYMMDD | ERROR |
| ISA10 | Time must be valid 4-digit HHMM (HH ≤ 23, MM ≤ 59) | ERROR |

### GS — Functional Group Header

| Element | Rule | Severity |
|---|---|---|
| GS01 | Must equal `HC` for 837x transactions; `RA` for 835 | ERROR |
| GS04 | Date must be valid 8-digit YYYYMMDD | ERROR |
| GS05 | Time must be valid 4-digit HHMM | ERROR |

### ST — Transaction Set Header

| Element | Rule | Severity |
|---|---|---|
| ST01 | Must equal `837` for claims; `835` for remittance | ERROR |

### SE — Transaction Set Trailer

| Element | Rule | Severity |
|---|---|---|
| SE01 | Segment count must match actual count from ST through SE (inclusive). Auto-corrected if mismatched. | ERROR + AUTO-FIX |

---

## 8. Validation Rules — 837P Professional Claims

### NM1*85 — Billing Provider

| Element | Rule | Severity |
|---|---|---|
| NM102 | Entity Type Qualifier must be present (1=Individual, 2=Organization) | ERROR |
| NM103 | Provider Name / Organization must not be blank | ERROR |
| NM109 | NPI must be exactly 10 digits | ERROR |

### NM1*QC — Patient Name

| Element | Rule | Severity |
|---|---|---|
| NM103 | Patient Last Name must not be blank | ERROR |
| NM104 | Patient First Name must not be blank | ERROR |

### CLM — Claim Information

| Element | Rule | Severity |
|---|---|---|
| CLM01 | Patient Control Number must not be blank | ERROR |
| CLM02 | Total Charge Amount must be numeric and > 0 | ERROR |
| CLM05 | Place of Service code (composite part 1) must be 1–2 characters | WARNING |

### DTP*472 — Date of Service

| Element | Rule | Severity |
|---|---|---|
| DTP03 | Must be valid YYYYMMDD, or YYYYMMDD-YYYYMMDD range | ERROR |
| DTP02 | Auto-set to `D8` (single date) or `RD8` (range) when user provides DTP03 | AUTO-FIX |

### SV1 — Professional Service Line

| Element | Rule | Severity |
|---|---|---|
| SV101 | Composite must start with `HC` qualifier (e.g. `HC:99213`) | ERROR |
| SV102 | Charge Amount must be numeric and > 0 | ERROR |

---

## 9. Validation Rules — 837I Institutional Claims

837I shares the NM1\*85 and NM1\*QC rules from 837P. CLM02 is validated; CLM05 is **not** validated for institutional claims.

### CL1 — Institutional Claim Code (REQUIRED for 837I)

| Rule | Severity |
|---|---|
| CL1 segment must be present in the transaction | ERROR |
| CL101 (Admission Type) must be one of: 1, 2, 3, 4, 5, 9 | ERROR |
| CL102 (Admission Source) must not be blank | ERROR |
| CL103 (Patient Status / Discharge) must not be blank | ERROR |

### DTP*435 — Admission Date

| Element | Rule | Severity |
|---|---|---|
| DTP03 | Must be valid YYYYMMDD | ERROR |
| DTP02 | Auto-set to `D8` when user provides the date | AUTO-FIX |

### SV2 — Institutional Service Line

| Element | Rule | Severity |
|---|---|---|
| SV201 | Revenue code (composite part before `:`) must be exactly 4 digits, value 100–9999 | ERROR |
| SV202 | Charge Amount must be numeric and > 0 | ERROR |

---

## 10. Validation Rules — 835 Remittance Advice

### BPR — Beginning of Payment (REQUIRED)

| Element | Rule | Severity |
|---|---|---|
| BPR01 | Transaction Handling Code must not be blank | ERROR |
| BPR02 | Payment Amount must be numeric and ≥ 0 (zero is valid for denied-only) | ERROR |
| BPR03 | Credit/Debit flag must be `C` (credit) or `D` (debit) | ERROR |
| BPR04 | Payment Method must be one of: ACH, CHK, FWT, BOP, NON, MCP | ERROR |

### TRN — Reassociation Trace Number (REQUIRED)

| Element | Rule | Severity |
|---|---|---|
| TRN02 | Trace Number must not be blank | ERROR |

### DTM*405 — Payment Date

| Element | Rule | Severity |
|---|---|---|
| DTM02 | If present, must be valid YYYYMMDD | WARNING |

### CLP — Claim Payment Information (at least one REQUIRED)

| Element | Rule | Severity |
|---|---|---|
| CLP01 | Patient Control Number must not be blank | ERROR |
| CLP02 | Claim Status Code must be one of: 1, 2, 3, 4, 19, 20, 21, 22, 23, 24, 25 | ERROR |
| CLP03 | Charge Amount must be numeric and > 0 | ERROR |
| CLP04 | Payment Amount must be numeric and ≥ 0 | ERROR |
| CLP04 vs CLP03 | Payment Amount must not exceed Charge Amount | WARNING |
| CLP05 | Patient Responsibility, if present, must be numeric and ≥ 0 | ERROR |

### CAS — Claim Adjustment

| Element | Rule | Severity |
|---|---|---|
| CAS01 | Adjustment Group Code must be one of: CO, CR, OA, PA, PI, WO | ERROR |

### Presence Checks

| Rule | Severity |
|---|---|
| BPR segment must be present in an 835 transaction | ERROR |
| At least one CLP segment must be present in an 835 transaction | ERROR |

---

## 11. Auto-Fix Rules

These corrections are applied automatically in `applyFixes()` without requiring user input.

| Segment | Element | Auto-Correction Logic |
|---|---|---|
| SE | SE01 | Recount segments from ST through SE inclusive; overwrite SE01 with correct value. Always runs unconditionally. |
| DTP\*472 | DTP02 | If user enters a date range (contains `-`), set qualifier to `RD8`; otherwise set to `D8`. |
| DTP\*435 | DTP02 | When user enters admission date, auto-set qualifier to `D8`. |

---

## 12. Fix Form Fields

For each fixable issue, a labeled input field is dynamically generated in Step 2. All inputs are applied to `fixedSegments` on "Apply Fixes".

### 837P Fields

| Fix Key | Label | Target Element | Format |
|---|---|---|---|
| `clm01_N` | CLM01 — Patient Control Number | CLM[1] | Alphanumeric |
| `clm02_N` | CLM02 — Total Claim Charge Amount | CLM[2] | Numeric > 0 |
| `clm05_N` | CLM05 — Place of Service Code | CLM[5] composite[0] | 1–2 digit code |
| `dtp472_N` | DTP\*472 — Date of Service | DTP[3] + DTP[2] auto | YYYYMMDD or YYYYMMDD-YYYYMMDD |
| `nm185_nm102_N` | NM1\*85 — Entity Type Qualifier | NM1[2] | 1 or 2 |
| `nm185_nm103_N` | NM1\*85 — Billing Provider Name | NM1[3] | Text |
| `nm185_nm109_N` | NM1\*85 — Billing Provider NPI | NM1[9] | 10 digits |
| `nm1qc_nm103_N` | NM1\*QC — Patient Last Name | NM1[3] | Text |
| `nm1qc_nm104_N` | NM1\*QC — Patient First Name | NM1[4] | Text |
| `sv101_N` | SV101 — Procedure Code | SV1[1] | `HC:CPTCODE` |
| `sv102_N` | SV102 — Professional Charge Amount | SV1[2] | Numeric > 0 |

### Shared Envelope Fields

| Fix Key | Label | Target Element | Format |
|---|---|---|---|
| `isa06` | ISA06 — Sender ID | ISA[6] | 15-char padded |
| `isa08` | ISA08 — Receiver ID | ISA[8] | 15-char padded |
| `isa09` | ISA09 — Interchange Date | ISA[9] | YYMMDD |
| `isa10` | ISA10 — Interchange Time | ISA[10] | HHMM |
| `gs01` | GS01 — Functional Identifier | GS[1] | HC or RA |
| `gs04` | GS04 — Date | GS[4] | YYYYMMDD |
| `gs05` | GS05 — Time | GS[5] | HHMM |

### 837I Fields

| Fix Key | Label | Target Element | Format |
|---|---|---|---|
| `cl101_N` | CL101 — Admission Type Code | CL1[1] | 1–5 or 9 |
| `cl102_N` | CL102 — Admission Source Code | CL1[2] | 1–2 chars |
| `cl103_N` | CL103 — Patient Status Code | CL1[3] | 2-char code |
| `dtp435_N` | DTP\*435 — Admission Date | DTP[3] + DTP[2] auto | YYYYMMDD |
| `sv201_N` | SV201 — Revenue Code (composite) | SV2[1] | `XXXX:HCPCS` |
| `sv202_N` | SV202 — Institutional Charge Amount | SV2[2] | Numeric > 0 |

### 835 Fields

| Fix Key | Label | Target Element | Format |
|---|---|---|---|
| `bpr02_N` | BPR02 — Total Payment Amount | BPR[2] | Numeric ≥ 0 |
| `bpr03_N` | BPR03 — Credit/Debit Flag | BPR[3] | C or D |
| `bpr04_N` | BPR04 — Payment Method | BPR[4] | ACH/CHK/FWT/NON |
| `trn02_N` | TRN02 — Trace Number | TRN[2] | Alphanumeric |
| `clp02_N` | CLP02 — Claim Status Code | CLP[2] | Valid status code |
| `clp03_N` | CLP03 — Claim Charge Amount | CLP[3] | Numeric > 0 |
| `clp04_N` | CLP04 — Claim Payment Amount | CLP[4] | Numeric ≥ 0 |
| `clp05_N` | CLP05 — Patient Responsibility | CLP[5] | Numeric ≥ 0 |
| `cas01_N` | CAS01 — Adjustment Group Code | CAS[1] | CO/CR/OA/PA/PI/WO |

*`N` in fix keys represents the segment index in the parsed array.*

---

## 13. Core Functions

| Function | Signature | Responsibility |
|---|---|---|
| `parseEDI` | `(text) → string[][]` | Split on `~`, then on `*`. Trim blanks. Skip empty segments. |
| `detectTxType` | `(segments) → string` | Inspect ST01 + SV2/CL1 presence → return "837P", "837I", "835", or "unknown" |
| `validate` | `(segments) → { issues, txType }` | Run type-specific rule checks. Return all issues and detected type. |
| `validateAndScrub` | `() → void` | Step 1→2 orchestrator: read textarea → parse → validate → render. |
| `renderStep2` | `() → void` | Build issue list, summary bar, and fix forms in DOM. |
| `applyFixes` | `() → void` | deepCopy(segments) → apply user values + auto-corrections → re-validate → render Step 3. |
| `renderStep3` | `() → void` | Display corrected EDI (pipe format, green highlights), remaining issues banner, glossary. |
| `downloadFixed` | `() → void` | Serialize fixedSegments to EDI text (asterisk + tilde). Trigger file download with type-appropriate filename. |
| `fixFieldConfig` | `(issue) → {label, placeholder, hint}` | Return display config for a given fix key. |
| `buildGlossary` | `(seenSegIds) → void` | Filter GLOSSARY by seen segment IDs and render into the glossary table. |
| `triggerAutoDetect` | `() → void` | Parse textarea content and show type badge without full validation. |

---

## 14. Helper Functions

| Function | Signature | Purpose |
|---|---|---|
| `isValidDate8` | `(s) → boolean` | Validate YYYYMMDD — regex + calendar check |
| `isValidDate6` | `(s) → boolean` | Validate YYMMDD — regex + calendar check |
| `isValidTime4` | `(s) → boolean` | Validate HHMM — HH ≤ 23, MM ≤ 59 |
| `isNumericPositive` | `(s) → boolean` | parseFloat > 0 and not NaN |
| `isNumericNonNeg` | `(s) → boolean` | parseFloat ≥ 0 and not NaN |
| `segLabel` | `(elems) → string` | Return "NM1\*85", "DTP\*472", etc. for display |
| `e` | `(idx, elems) → string` | Safe element accessor — returns trimmed value or `""` |
| `deepCopy` | `(segments) → string[][]` | Shallow-clone each segment array |
| `escHtml` | `(str) → string` | Escape `&`, `<`, `>`, `"` for safe DOM insertion |

---

## 15. Segment Glossary

The application includes a built-in glossary rendered in Step 3 for all segment types detected in the submitted file.

| Segment | Category | Description |
|---|---|---|
| ISA | Envelope | Interchange Control Header |
| IEA | Envelope | Interchange Control Trailer |
| GS | Envelope | Functional Group Header (GS01=HC for 837, RA for 835) |
| GE | Envelope | Functional Group Trailer |
| ST | Envelope | Transaction Set Header |
| SE | Envelope | Transaction Set Trailer |
| BPR | Financial | Beginning of Payment / Financial Information |
| TRN | Financial | Reassociation Trace Number |
| NM1\*85 | Provider | Billing Provider Name |
| NM1\*QC | Patient | Patient Name |
| NM1\*PR | Payer | Payer Name (claims) |
| NM1\*PE | Payee | Payee Name (remittance) |
| N1\*PR | Payer | Payer Name Loop (835) |
| N1\*PE | Payee | Payee Name Loop (835) |
| CLM | Claim | Claim Information |
| CL1 | Claim | Institutional Claim Code (837I) |
| CLP | Remittance | Claim Payment Information (835) |
| CAS | Remittance | Claim/Service Adjustment (835) |
| DTP\*472 | Claim | Date of Service (837P) |
| DTP\*435 | Claim | Admission Date (837I) |
| DTP\*434 | Claim | Discharge Date |
| SV1 | Service | Professional Service Line (837P) |
| SV2 | Service | Institutional Service Line (837I) |
| SVD | Remittance | Service Line Adjudication (835) |
| PLB | Remittance | Provider Level Balance (835) |
| HI | Claim | Health Care Diagnosis Codes |
| LX | Claim | Service Line Number |
| REF | Claim | Reference Identification |

---

## 16. Sample Data

Three sample transactions are bundled, each with intentional errors for demonstration. All samples use **synthetic data only** — no real patient, provider, or payer identifiers.

### Sample 837P — 3 intentional errors
- `CLM02` blank (charge amount missing)
- `DTP*472` date `99999999` invalid
- `SE01` count `10` should be `13` (auto-corrected)

### Sample 837I — 4 intentional errors
- `CLM02` blank (charge amount missing)
- `CL1` segment absent (institutional claim code required)
- `DTP*435` date `99999999` invalid (admission date)
- `SV202` blank (institutional charge missing)
- `SE01` count wrong (auto-corrected)

### Sample 835 — 4 intentional errors
- `BPR02` blank (payment amount missing)
- `TRN02` blank (trace number missing)
- `CLP04` (600.00) exceeds `CLP03` (500.00) — payment > charges
- `CAS01` code `ZZ` invalid (must be CO/CR/OA/PA/PI/WO)
- `SE01` count wrong (auto-corrected)

> **PHI Reminder:** Always use synthetic or anonymized test data. Follow your organization's PHI/HIPAA guidance before handling live claim data.

---

## 17. UI Components

### Top Navigation Bar
- VK branding: slate background (#1E293B), indigo logo mark (#4F46E5)
- "Venkatesh Krishnan" wordmark with "EDI Tools" label

### Step Indicator
- 3-step progress bar: Input → Validation → Output
- Pills animate: gray → active indigo → done light-indigo
- Connectors animate green on step completion

### Step 1 — Input Panel
- Large monospace textarea with indigo-light background
- Auto-detect badge appears after 600ms debounce
- Buttons: Validate & Scrub (indigo), Sample 837P (indigo), Sample 837I (cyan), Sample 835 (amber), Clear

### Step 2 — Validation Results
- Summary bar showing: type badge + segments count + ERROR/WARNING counts
- Green "No issues" banner if clean
- Issue cards: left-border red (ERROR) or amber (WARNING), segment label + severity badge + description
- Fix section with dynamically generated labeled inputs
- SE auto-fix noted as info banner (no input needed)

### Step 3 — Output
- Dark-theme panel (slate background) with pipe-separated EDI display
- Green highlighted lines with `[FIXED]` label for corrected segments
- Yellow qualifier highlighting on NM1/DTP/DTM/N1 segments
- Remaining issues banner (green if clean, red/amber if still failing)
- Dynamic download button: "Download Fixed 837P/837I/835"
- Segment glossary filtered to segments present in the file

### Responsive Design
- Max content width: 900px, centered
- Buttons wrap on mobile
- Cards reduce padding at 600px breakpoint

---

## 18. Acceptance Criteria

### Parsing
- [ ] EDI text splits correctly on `~` terminator and `*` element separator
- [ ] Blank/empty segments are silently skipped
- [ ] All three sample buttons populate the textarea with the correct sample

### Type Detection
- [ ] 837P detected when ST01=837 and no SV2/CL1 present
- [ ] 837I detected when ST01=837 and SV2 or CL1 present
- [ ] 835 detected when ST01=835
- [ ] Type badge appears in textarea area after typing (600ms debounce)
- [ ] Type badge shown in Step 2 summary bar

### 837P Validation
- [ ] All ISA, GS, ST, NM1\*85, NM1\*QC, CLM, DTP\*472, SV1, SE rules fire correctly
- [ ] Clean 837P shows green "No issues" banner

### 837I Validation
- [ ] CL1 absence triggers ERROR when txType is 837I
- [ ] CL101 invalid code triggers ERROR
- [ ] DTP\*435 invalid date triggers ERROR
- [ ] SV201 invalid revenue code (non-4-digit) triggers ERROR
- [ ] SV202 blank triggers ERROR
- [ ] CLM05 is NOT validated for 837I

### 835 Validation
- [ ] BPR02 blank triggers ERROR
- [ ] BPR03 non-C/D triggers ERROR
- [ ] BPR04 invalid method triggers ERROR
- [ ] TRN02 blank triggers ERROR
- [ ] CLP04 > CLP03 triggers WARNING
- [ ] CAS01 invalid group code triggers ERROR
- [ ] GS01 not "RA" triggers ERROR for 835

### Fix & Output
- [ ] User fix inputs update corresponding elements in fixedSegments
- [ ] SE count auto-corrected unconditionally
- [ ] DTP qualifiers auto-set based on date format
- [ ] Re-validation fires after applyFixes
- [ ] Green "All issues resolved" banner when re-validation is clean
- [ ] Remaining issues listed when still failing

### Download
- [ ] 837P downloads as `fixed_837p.txt`
- [ ] 837I downloads as `fixed_837i.txt`
- [ ] 835 downloads as `fixed_835.txt`
- [ ] Downloaded file uses `*` separators and `~\n` terminators

### Privacy
- [ ] No network requests after page load (verifiable in DevTools Network tab)
- [ ] No localStorage, sessionStorage, or cookie writes
- [ ] Tab close clears all data

---

## 19. Known Limitations

| Limitation | Impact |
|---|---|
| No loop structure validation | Segments placed outside their required loop pass silently |
| No code set validation | Invalid CPT, HCPCS, ICD-10 codes are not caught |
| No NPI Luhn check | Any 10-digit number passes as a valid NPI |
| No multi-transaction (batch) support | Files with multiple ST/SE pairs are not supported |
| No payer-specific edits | No fee schedule, prior auth, or coordination of benefits logic |
| Offline only | Cannot query NPI registry or real-time payer edits |
| No audit trail | Changes are not logged; downloaded file is the only artifact |
| 835P vs 835I not distinguished | Both use the same 835 validation rule set |
| No 837D dental support | Dental claims are not supported |

---

## 20. Compliance & PHI Guidance

> **PHI Warning:** EDI files may contain Protected Health Information (PHI). Always use synthetic or anonymized test data. Follow your organization's PHI/HIPAA guidance before handling live claim data.

### Privacy Design

| Control | Implementation |
|---|---|
| No network transmission | All processing is client-side JavaScript. Zero HTTP requests after page load. |
| No persistent storage | No localStorage, sessionStorage, IndexedDB, or cookies. |
| Ephemeral memory | All parsed data exists only in the JS heap. Tab close = data gone. |
| No server component | Single static HTML file — no backend, no database, no logging. |
| No analytics | No tracking pixels, scripts, or telemetry of any kind. |
| Synthetic samples only | All bundled sample data uses fabricated identifiers. |
