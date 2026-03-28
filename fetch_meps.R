# Fetch MEPS data for IPD-QMA
# Medical Expenditure Panel Survey - has continuous outcomes for comparisons

# Install required packages
packages <- c("haven", "readr")
for (pkg in packages) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    install.packages(pkg, repos = "https://cloud.r-project.org/")
    library(pkg, character.only = TRUE)
  }
}

# MEPS FYC data URLs
meps_urls <- list(
  list(year = 2019, id = 'h209', url = 'https://meps.ahrq.gov/data_files/pufs/h209/h209xpt.zip'),
  list(year = 2020, id = 'h224', url = 'https://meps.ahrq.gov/data_files/pufs/h224/h224xpt.zip'),
  list(year = 2021, id = 'h233', url = 'https://meps.ahrq.gov/data_files/pufs/h233/h233xpt.zip')
)

dest_dir <- file.path('inst', 'extdata')
if (!dir.exists(dest_dir)) {
  dir.create(dest_dir, recursive = TRUE, showWarnings = FALSE)
}

cat("Starting MEPS data fetch...\n\n")

for (meps in meps_urls) {
  yr <- meps$year
  id <- paste0('meps_', yr, '_fyc')
  url <- meps$url

  cat(sprintf("Fetching %s from %s\n", id, url))

  # Download zip file
  zf <- tempfile(fileext = '.zip')
  result <- tryCatch({
    download.file(url, destfile = zf, mode = 'wb', quiet = TRUE)
    "downloaded"
  }, error = function(e) {
    cat(sprintf("  ERROR: Download failed - %s\n", e$message))
    NULL
  })

  if (is.null(result)) next

  # Unzip
  ex <- tempfile()
  unzip_result <- tryCatch({
    utils::unzip(zf, exdir = ex)
    "unzipped"
  }, error = function(e) {
    cat(sprintf("  ERROR: Unzip failed - %s\n", e$message))
    NULL
  })

  if (is.null(unzip_result)) next

  # Find XPT file
  xpt <- list.files(ex, pattern = '\\.(xpt|XPT)$', full.names = TRUE)
  if (!length(xpt)) {
    cat("  ERROR: No XPT found in zip\n")
    next
  }

  cat(sprintf("  Found XPT: %s\n", basename(xpt[1])))

  # Read XPT
  dat <- NULL
  tryCatch({
    dat <- haven::read_xpt(xpt[1])
    cat("  Successfully read XPT file\n")
  }, error = function(e) {
    cat(sprintf("  ERROR: read_xpt failed - %s\n", e$message))
  })

  if (is.null(dat)) next

  # Standardize column names
  names(dat) <- tolower(names(dat))
  dat$dataset_id <- id

  # Derive patient_id
  if ('dupersid' %in% names(dat)) {
    dat$patient_id <- dat$dupersid
  } else {
    dat$patient_id <- seq_len(nrow(dat))
  }

  # Write to CSV
  out <- file.path(dest_dir, paste0(id, '.csv'))
  write.csv(dat, out, row.names = FALSE)
  cat(sprintf("  SUCCESS: Wrote %s (%d rows, %d cols)\n\n", out, nrow(dat), ncol(dat)))

  # Cleanup
  unlink(c(zf, ex), recursive = TRUE)
}

cat("Done!\n")
