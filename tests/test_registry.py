"""Regression tests for the IPD registry CSV.

Guards the F1 bug: a UTF-8 BOM at the start of inst/registry/registry.csv
corrupts the first header field when read by R's read.csv (without
fileEncoding='UTF-8-BOM'), so list_ipd_datasets()$id returns NULL because
the real column ends up named e.g. 'X.U.FEFF.id'. These checks are the
portable (R-independent) proxy for that contract.
"""
import csv
from pathlib import Path


REGISTRY = Path(__file__).resolve().parents[1] / 'inst' / 'registry' / 'registry.csv'

# Must match the hard-coded empty-registry fallback header in R/api.R.
EXPECTED_HEADER = ['id', 'domain', 'source', 'source_url',
                   'license', 'citation', 'notes', 'access']


def test_registry_has_no_utf8_bom():
    raw = REGISTRY.read_bytes()
    assert not raw.startswith(b'\xef\xbb\xbf'), (
        'registry.csv starts with a UTF-8 BOM; R read.csv would name the '
        "first column 'X.U.FEFF.id' instead of 'id'"
    )


def test_registry_first_column_is_id():
    with REGISTRY.open(encoding='utf-8', newline='') as fh:
        header = next(csv.reader(fh))
    assert header[0] == 'id', header


def test_registry_header_matches_fallback_schema():
    with REGISTRY.open(encoding='utf-8', newline='') as fh:
        header = next(csv.reader(fh))
    assert header == EXPECTED_HEADER, header
