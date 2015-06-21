# Introduction
This README describes the process of creating a single tidy dataset with averaged mean and std dev values of signals from the **UCI HAR Dataset** (hereafter "the Dataset").

The script which does the job — ```run_analysis.R``` — produces a single file ```tidy_data.txt``` which should be loaded with the following command:
```r
data <- read.table("tidy_data.txt", header = TRUE, check.names = FALSE)
```

The complete description of the original dataset can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Hopefully, the script should be pretty self-explanatory — however, below is a brief outline of what's going on step by step.

# Data Manipulation
The original archive should be extracted in the same directory where the run_analysis.R script resides.

## Loading feature list and determining which columns to process
First, the script loads all the features from the file ```features.txt``` in the root directory of the Dataset. After that it picks only the features with names containing ```-mean(``` or ```-std(``` — that is, only mean values and standard deviations of signals.

Along the way, the script corrects minor typo (several names contain "BodyBody" instead of just "Body").

In all, there are 66 features/data columns to process.

This part of the script creates two variables:

* ```fnames``` — names of features/data columns;
* ```dcols``` — vector of classes for loading data columns. The fields we don't need are marked with "NULL" so that the script would drop them later.

## Loading and merging of data
The script loads data from train and test directories:

* signals proper — from ```X_*.txt``` files. ```colClasses = dcols``` is used in ```read.table``` so that only necessary fields are loaded. Data from the train subset is ```rbind```-ed with the data from the test subset, thus creating the single ```data``` set;
* activity identifiers (Activity vectors) — from ```y_*.txt``` files;
* subjects (Subject vectors) — from ```subject_*.txt``` files.

Activity labels are read from the ```activity_labels.txt``` in the root directory of the Dataset and merged with activity identifiers.

The Subject and Activity vectors are then ```cbind```-ed with the ```data``` set. The ```names``` function is used to label the columns.

## Aggregation
Aggregation is done with the help of ```dplyr``` package. The data undergoes ```group_by(Subject, Activity)```, after which the ```summarise_each``` function is used with ```funs(mean)``` argument.

The labels of the resulting aggregated set are appended with the ```-mean``` suffix to account for the aggregation.

# Summary of the data
The train subset consists of 7352 rows, the test subset — of 2947 rows. The resulting data set thus consists of 10299 rows.

The tidy data set with aggregated values consists of 40 rows and 66 data columns (not counting Subject and Activity fields). The complete description can be found in ```codebook.txt```.