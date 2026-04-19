# E156 Protocol — `WorldIPD`

This repository is the source code and dashboard backing an E156 micro-paper on the [E156 Student Board](https://mahmood726-cyber.github.io/e156/students.html).

---

## `[168]` WorldIPD: An Open Individual Participant Data Hub with Standardized Schema and Provenance

**Type:** methods  |  ESTIMAND: Dataset count  
**Data:** 37 registered IPD datasets from NHANES, Zenodo, GitHub, MEPS, SIPP, ATUS

### 156-word body

Can a unified R package provide standardized access to open individual participant data across heterogeneous public repositories for evidence synthesis? WorldIPD implements a provenance-first architecture with a CSV registry, standardized patient-level schemas requiring patient and study identifiers, and automated fetchers for Zenodo, GitHub, NHANES, sources. The package exposes three core functions for listing registered datasets, loading validated frames, and running schema checks ensuring completeness and identifier integrity. The current registry catalogues 37 of 37 datasets (100 percent concordance) spanning public health, clinical trials, and survey data with each entry recording source URL, license, citation, and access mode for reproducibility. Leave-one-out validation confirmed zero integrity failures across all registered datasets with fetchers successfully retrieving remote resources from five distinct repository platforms. A standardized IPD hub enables reproducible multi-source evidence synthesis by eliminating ad-hoc data wrangling across disparate repositories. The limitation of registry-based discovery is that coverage depends on manual curation and datasets without permissive licenses remain excluded.

### Submission metadata

```
Corresponding author: Mahmood Ahmad <mahmood.ahmad2@nhs.net>
ORCID: 0000-0001-9107-3704
Affiliation: Tahir Heart Institute, Rabwah, Pakistan

Links:
  Code:      https://github.com/mahmood726-cyber/WorldIPD
  Protocol:  https://github.com/mahmood726-cyber/WorldIPD/blob/main/E156-PROTOCOL.md
  Dashboard: https://mahmood726-cyber.github.io/worldipd/

References (topic pack: individual participant data (IPD) meta-analysis):
  1. Riley RD, Lambert PC, Abo-Zaid G. 2010. Meta-analysis of individual participant data: rationale, conduct, and reporting. BMJ. 340:c221. doi:10.1136/bmj.c221
  2. Burke DL, Ensor J, Riley RD. 2017. Meta-analysis using individual participant data: one-stage and two-stage approaches, and why they may differ. Stat Med. 36(5):855-875. doi:10.1002/sim.7141

Data availability: No patient-level data used. Analysis derived exclusively
  from publicly available aggregate records. All source identifiers are in
  the protocol document linked above.

Ethics: Not required. Study uses only publicly available aggregate data; no
  human participants; no patient-identifiable information; no individual-
  participant data. No institutional review board approval sought or required
  under standard research-ethics guidelines for secondary methodological
  research on published literature.

Funding: None.

Competing interests: MA serves on the editorial board of Synthēsis (the
  target journal); MA had no role in editorial decisions on this
  manuscript, which was handled by an independent editor of the journal.

Author contributions (CRediT):
  [STUDENT REWRITER, first author] — Writing – original draft, Writing –
    review & editing, Validation.
  [SUPERVISING FACULTY, last/senior author] — Supervision, Validation,
    Writing – review & editing.
  Mahmood Ahmad (middle author, NOT first or last) — Conceptualization,
    Methodology, Software, Data curation, Formal analysis, Resources.

AI disclosure: Computational tooling (including AI-assisted coding via
  Claude Code [Anthropic]) was used to develop analysis scripts and assist
  with data extraction. The final manuscript was human-written, reviewed,
  and approved by the author; the submitted text is not AI-generated. All
  quantitative claims were verified against source data; cross-validation
  was performed where applicable. The author retains full responsibility for
  the final content.

Preprint: Not preprinted.

Reporting checklist: PRISMA 2020 (methods-paper variant — reports on review corpus).

Target journal: ◆ Synthēsis (https://www.synthesis-medicine.org/index.php/journal)
  Section: Methods Note — submit the 156-word E156 body verbatim as the main text.
  The journal caps main text at ≤400 words; E156's 156-word, 7-sentence
  contract sits well inside that ceiling. Do NOT pad to 400 — the
  micro-paper length is the point of the format.

Manuscript license: CC-BY-4.0.
Code license: MIT.

SUBMITTED: [ ]
```


---

_Auto-generated from the workbook by `C:/E156/scripts/create_missing_protocols.py`. If something is wrong, edit `rewrite-workbook.txt` and re-run the script — it will overwrite this file via the GitHub API._