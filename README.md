# Introduction
This README describes the process of creating a single tidy dataset
with averaged mean and std dev values of signals from the UCI HAR Dataset

The script — ```r run_analysis.R``` — produces a single file
```r tidy_data.txt``` which should be loaded with the following command:
```r
data <- read.table("tidy_data.txt", header = TRUE, check.names = FALSE)
```

The complete description of the original dataset can be found at
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Using the result
The resulting file ```r tidy_data.txt``` should be loaded with the 

# Data Manipulation
The original archive should be extracted in the same directory where the
run_analysis.R script resides.

## Loading feature list
The script loads 