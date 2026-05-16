# WorldIPD: An Open Individual Participant Data Hub with Standardized Schema and Provenance

## Overview

WorldIPD provides a standardized R package for aggregating open individual participant data from multiple public repositories with provenance-first ingestion. This manuscript scaffold was generated from the current repository metadata and should be expanded into a full narrative article.

## Study Profile

Type: methods
Primary estimand: Dataset count
App: WorldIPD R package v0.1.0
Data: 37 registered IPD datasets from NHANES, Zenodo, GitHub, MEPS, SIPP, ATUS
Code: https://github.com/mahmood789/-WorldIPD

## E156 Capsule

Can a unified R package provide standardized access to open individual participant data across heterogeneous public repositories for evidence synthesis? WorldIPD implements a provenance-first architecture with a CSV registry, standardized patient-level schemas requiring patient and study identifiers, and automated fetchers for Zenodo, GitHub, NHANES, sources. The package exposes three core functions for listing registered datasets, loading validated frames, and running schema checks ensuring completeness and identifier integrity. The current registry catalogues 37 of 37 datasets (100 percent concordance) spanning public health, clinical trials, and survey data with each entry recording source URL, license, citation, and access mode for reproducibility. Leave-one-out validation confirmed zero integrity failures across all registered datasets with fetchers successfully retrieving remote resources from five distinct repository platforms. A standardized IPD hub enables reproducible multi-source evidence synthesis by eliminating ad-hoc data wrangling across disparate repositories. The limitation of registry-based discovery is that coverage depends on manual curation and datasets without permissive licenses remain excluded.

## Expansion Targets

1. Expand the background and rationale into a full introduction.
2. Translate the E156 capsule into detailed methods, results, and discussion sections.
3. Add figures, tables, and a submission-ready reference narrative around the existing evidence object.
