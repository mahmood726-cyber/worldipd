# Fetch NHANES data for IPD-QMA
# This script fetches NHANES demographic data and exports to CSV

# Install required package if needed
if (!require("haven", quietly = TRUE)) {
  install.packages("haven", repos = "https://cloud.r-project.org/")
}

# Define the fetch function
fetch_nhanes_demo <- function(cycles = list(
  list(yr = '2017_2018', suf = 'J'),
  list(yr = '2015_2016', suf = 'I'),
  list(yr = '2013_2014', suf = 'H')
), dest_dir = file.path('inst', 'extdata')) {

  if (!dir.exists(dest_dir)) {
    dir.create(dest_dir, recursive = TRUE, showWarnings = FALSE)
  }

  for (cc in cycles) {
    suf <- cc$suf
    yr <- cc$yr
    id <- sprintf('nhanes_%s_demo', yr)

    # Construct URL
    url <- sprintf('https://wwwn.cdc.gov/Nchs/Nhanes/%s/DEMO_%s.XPT', yr, suf)

    cat(sprintf("Fetching %s from %s\n", id, url))

    # Download
    tf <- tempfile(fileext = '.xpt')
    ok <- try(download.file(url, destfile = tf, mode = 'wb', quiet = TRUE), silent = TRUE)

    if (inherits(ok, 'try-error')) {
      cat(sprintf("  ERROR: Download failed for %s\n", id))
      next
    }

    # Read SAS transport file
    demo <- try(haven::read_xpt(tf), silent = TRUE)

    if (inherits(demo, 'try-error')) {
      cat(sprintf("  ERROR: read_xpt failed for %s\n", id))
      next
    }

    # Standardize column names
    names(demo) <- tolower(names(demo))
    demo$dataset_id <- id

    if (!('seqn' %in% names(demo))) {
      cat(sprintf("  ERROR: seqn column missing in %s\n", id))
      next
    }

    demo$patient_id <- demo$seqn

    # Write to CSV
    out <- file.path(dest_dir, paste0(id, '.csv'))
    write.csv(demo, out, row.names = FALSE)
    cat(sprintf("  SUCCESS: Wrote %s\n", out))
  }

  invisible(TRUE)
}

# Run the fetch
cat("Starting NHANES data fetch...\n")
fetch_nhanes_demo()
cat("Done!\n")
