# Alternative fetcher using foreign package and direct download
# Fetch NHANES data for IPD-QMA

# Try foreign package
if (!require("foreign", quietly = TRUE)) {
  install.packages("foreign", repos = "https://cloud.r-project.org/")
}

library(foreign)

# Also try haven as backup
if (!require("haven", quietly = TRUE)) {
  install.packages("haven", repos = "https://cloud.r-project.org/")
}

# Define cycles to fetch
cycles <- list(
  list(yr = '2017_2018', suf = 'J'),
  list(yr = '2015_2016', suf = 'I'),
  list(yr = '2013_2014', suf = 'H'),
  list(yr = '2011_2012', suf = 'G')
)

dest_dir <- file.path('inst', 'extdata')
if (!dir.exists(dest_dir)) {
  dir.create(dest_dir, recursive = TRUE, showWarnings = FALSE)
}

cat("Starting NHANES data fetch...\n\n")

for (cc in cycles) {
  suf <- cc$suf
  yr <- cc$yr
  id <- sprintf('nhanes_%s_demo', yr)

  # Construct URL
  url <- sprintf('https://wwwn.cdc.gov/Nchs/Nhanes/%s/DEMO_%s.XPT', yr, suf)

  cat(sprintf("Fetching %s from %s\n", id, url))

  # Download
  tf <- tempfile(fileext = '.xpt')
  result <- tryCatch({
    download.file(url, destfile = tf, mode = 'wb', quiet = TRUE)
    "downloaded"
  }, error = function(e) {
    cat(sprintf("  ERROR: Download failed - %s\n", e$message))
    NULL
  })

  if (is.null(result)) next

  # Try reading with haven first
  demo <- NULL
  read_method <- ""

  tryCatch({
    demo <- haven::read_xpt(tf)
    read_method <- "haven"
  }, error = function(e) {
    cat(sprintf("  haven failed: %s\n", e$message))
  })

  # If haven failed, try foreign
  if (is.null(demo)) {
    tryCatch({
      demo <- read.xport(tf)
      read_method <- "foreign"
    }, error = function(e) {
      cat(sprintf("  foreign failed: %s\n", e$message))
    })
  }

  if (is.null(demo)) {
    cat(sprintf("  ERROR: Could not read %s with either method\n", id))
    next
  }

  cat(sprintf("  Read using %s\n", read_method))

  # Standardize column names
  names(demo) <- tolower(names(demo))
  demo$dataset_id <- id

  if (!('seqn' %in% names(demo))) {
    cat(sprintf("  ERROR: seqn column missing\n"))
    next
  }

  demo$patient_id <- demo$seqn

  # Write to CSV
  out <- file.path(dest_dir, paste0(id, '.csv'))
  write.csv(demo, out, row.names = FALSE)
  cat(sprintf("  SUCCESS: Wrote %s (%d rows, %d cols)\n\n", out, nrow(demo), ncol(demo)))
}

cat("Done!\n")
