# prep_pkap.R
# Produce web-ready, PUBLIC snapshots of the Police Killings and Protest (PKAP) dataset
# for the data-explorer page. Run locally when the data updates; commit ONLY the public
# output CSVs — never the raw working files (see .gitignore).
#
# Current public columns (from the geolocated files):
#   id, lat, lon, name, age, gender, raceethnicity, month, day, year,
#   streetaddress, city, state, classification, lawenforcementagency, armed
# The full PKAP will add a protest-outcome column; extend `select()` when it lands.

library(readr)
library(dplyr)

prep_year <- function(infile, outfile) {
  raw <- read_csv(infile, show_col_types = FALSE)
  public <- raw %>%
    select(
      id, lat, lon, name, age, gender, raceethnicity,
      month, day, year, city, state, classification, armed
      # , protest          # <- add when the protest coding is finalized
    ) %>%
    filter(!is.na(lat), !is.na(lon))
  write_csv(public, outfile)
  message(sprintf("%s -> %s (%d public rows)", infile, outfile, nrow(public)))
}

# The 2015–2016 files are already in the public shape; this script documents the pipeline
# and is the place to strip any non-public fields (e.g., street address) as more years and
# the protest coding are added.
prep_year("data-src/pkap_2015_raw.csv", "data/pkap_geolocated_2015.csv")
prep_year("data-src/pkap_2016_raw.csv", "data/pkap_geolocated_2016.csv")
