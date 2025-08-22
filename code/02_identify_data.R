# ---------------------------------------------------------------------------- #
# Identify relevant data -----
# Author: Jeremy W. Eberle
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
# Notes ----
# ---------------------------------------------------------------------------- #

# Before running script, restart R (CTRL+SHIFT+F10 on Windows) and set working 
# directory to parent folder

# ---------------------------------------------------------------------------- #
# Store working directory, check correct R version, load packages ----
# ---------------------------------------------------------------------------- #

# Store working directory

wd_dir <- getwd()

# Load custom functions

source("./code/01_define_functions.R")

# Check correct R version, load groundhog package, and specify groundhog_day

groundhog_day <- version_control()

# No packages loaded

# ---------------------------------------------------------------------------- #
# Import data ----
# ---------------------------------------------------------------------------- #

# From Zara Mir (on FSM ResFiles; must be connected to VPN to access)

from_zara_path <- "R:/PrevMed/CBITS/Eberle_Jeremy/From Zara/"

  # TODO: Are these raw or clean data?
  # TODO: What is the cleaning script that created "EMA_SENSOR_DATA/all_ema_phq_cleaned.csv"?

ep_dat <- read.csv(paste0(from_zara_path, "EMA_SENSOR_DATA/all_ema_phq_cleaned.csv"))
es_dat <- read.csv(paste0(from_zara_path, "EMA_SENSOR_DATA/merged_EMA_sensor.csv"))





# ---------------------------------------------------------------------------- #
# Explore structure of "ema_phq_dat" ----
# ---------------------------------------------------------------------------- #

# TODO: Identify columns of interest

ep_metadat_cols <- c("pid", "data_source", "study_wk", "generator.id", "time")

ep_affect_cols <- c("stress", "mood", "energetic", "distracted")

ep_phq_cols <- c("pleasure", "depression", "sleep", "energy", "appetite", "feeling.bad", 
                 "concentration", "movement", "difficulty")

ep_sleep_cols <- c("bed.time", "sleep.time", "wake.time", "rise.time", "sleep.quality", "sleep.other.info")

ep_cols_of_interest <- c(ep_metadat_cols, ep_affect_cols, ep_phq_cols, "workday", ep_sleep_cols)
all(ep_cols_of_interest %in% names(ep_dat))





# TODO: Arrange data

ep_dat <- ep_dat[with(ep_dat, order(data_source, pid, time)), ]

View(ep_dat[ep_cols_of_interest])
View(ep_dat[setdiff(names(ep_dat), ep_cols_of_interest)])




# TODO: What is "for_yesterday"? (9202 FALSE, 1468 TRUE)
# TODO: Why does "generator.id" have only two levels (5246 evening_ph8, 5424 morning_phq8)?
# - Maybe these are only PHQ data entries
# - TODO: There seem to be some duplicates
# TODO: Is there a codebook for all these columns?
  # TODO: e.g., In what timezone is "time"?
# TODO: Why are 442 "study_wk" entries NA?
# TODO: Why are 500 "difficulty" entries NA but no other PHQ items are NA?
# TODO: What's the difference between "data_source" values of "wave2" vs. "wave2_grp2"
# TODO: Finish making sense of columns




# ---------------------------------------------------------------------------- #
# Explore structure of "ema_sensor_dat" ----
# ---------------------------------------------------------------------------- #

# TODO: Identify columns of interest

es_metadat_cols <- c("pid", "data_source", "study_wk")

  # TODO: Affect columns have decimals (possibly averaged across entries for each study week)

es_affect_cols <- c("Stress", "Mood", "Energetic", "Distracted")

es_cols_of_interest <- c(es_metadat_cols, es_affect_cols)
all(es_cols_of_interest %in% names(es_dat))





# TODO: Arrange data

es_dat <- es_dat[with(es_dat, order(data_source, pid, study_wk)), ]

View(es_dat[es_cols_of_interest])
View(es_dat[setdiff(names(ema_phq_dat), ep_cols_of_interest)])

# TODO: This seems like an analysis data frame used for multilevel modeling
# (e.g., contains "within" and "between" versions of variables)







