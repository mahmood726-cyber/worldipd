# Tests for the WorldIPD R core (R/api.R).

test_that("validate_ipd flags a missing required column", {
  df <- data.frame(patient_id = 1:3)  # study_id absent
  res <- validate_ipd(df)
  expect_false(res$ok)
  expect_true(any(grepl("Missing", res$issues)))
  expect_true(any(grepl("study_id", res$issues)))
})

test_that("validate_ipd flags NA patient_id", {
  df <- data.frame(patient_id = c(1L, NA, 3L), study_id = c("a", "b", "c"))
  res <- validate_ipd(df)
  expect_false(res$ok)
  expect_true(any(grepl("NA patient_id", res$issues)))
})

test_that("validate_ipd accepts a complete frame", {
  df <- data.frame(patient_id = 1:2, study_id = c("a", "b"))
  res <- validate_ipd(df)
  expect_true(res$ok)
  expect_length(res$issues, 0)
})

test_that("validate_ipd rejects non-data.frame input", {
  res <- validate_ipd(list(patient_id = 1))
  expect_false(res$ok)
  expect_match(res$issues, "not a data.frame")
})

test_that("get_ipd_dataset errors for a missing dataset", {
  expect_error(get_ipd_dataset("definitely_does_not_exist_123"),
               "Dataset not found")
})

test_that("registry.csv first column parses as 'id' (guards BOM regression F1)", {
  # Locate the packaged registry, or fall back to the source tree layout.
  rp <- system.file("registry", "registry.csv", package = "WorldIPD")
  if (!nzchar(rp)) {
    rp <- testthat::test_path("..", "..", "inst", "registry", "registry.csv")
  }
  skip_if_not(file.exists(rp), "registry.csv not found in this layout")

  # A UTF-8 BOM would make read.csv name the first column 'X.U.FEFF.id'.
  raw <- readBin(rp, what = "raw", n = 3L)
  expect_false(identical(raw, as.raw(c(0xEF, 0xBB, 0xBF))),
               info = "registry.csv must not start with a UTF-8 BOM")

  reg <- utils::read.csv(rp, stringsAsFactors = FALSE)
  expect_true("id" %in% names(reg))
})

test_that("list_ipd_datasets returns a frame whose names include 'id'", {
  d <- list_ipd_datasets()
  expect_s3_class(d, "data.frame")
  expect_true("id" %in% names(d))
})
