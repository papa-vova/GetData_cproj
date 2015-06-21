# reading list of all features
# locating means and stddevs in the list of features
flist_all <- read.table("UCI HAR Dataset/features.txt")
fcols <- grepl("-mean\\(|-std\\(", flist_all$V2)
# ...remembering those field names
fnames <- flist_all[fcols, 2]
# correcting the typo with "BodyBody" in several occasions
fnames <- sub("BodyBody", "Body", fnames)

# preparing colClasses for reading only means and stddevs
# from the measurements
dcols <- sub("FALSE", "NULL", fcols)
dcols <- sub("TRUE", "numeric", dcols)

# reading only required fields from the train and test data files
tr_data <- read.table("UCI HAR Dataset/train/X_train.txt", colClasses = dcols)
ts_data <- read.table("UCI HAR Dataset/test/X_test.txt", colClasses = dcols)
# reading activities and joining them with labels
tr_act <- read.table("UCI HAR Dataset/train/y_train.txt")
ts_act <- read.table("UCI HAR Dataset/test/y_test.txt")
lbl_act <- read.table("UCI HAR Dataset/activity_labels.txt")
tr_act <- merge(tr_act, lbl_act)[2]
ts_act <- merge(ts_act, lbl_act)[2]

# reading subjects
tr_subj <- read.table("UCI HAR Dataset/train/subject_train.txt")
ts_subj <- read.table("UCI HAR Dataset/test/subject_test.txt")
# and merging them
data <- rbind(tr_data, ts_data)
data <- cbind(rbind(tr_act, ts_act), data)
data <- cbind(rbind(tr_subj, ts_subj), data)

# setting appropriate names
names(data) <- c("Subject", "Activity", as.character(fnames))

# cleaning up
rm(tr_data, ts_data, tr_act, ts_act, tr_subj, ts_subj,
   flist_all, dcols, fcols, fnames, lbl_act)

# > dim(tr_data)
# [1] 7352   66
# > dim(ts_data)
# [1] 2947   66
# > dim(ts_act)
# [1] 2947    1
# > dim(tr_act)
# [1] 7352    1
# > dim(data)
# [1] 10299    66

# grouping by subject & activity, and summarizing after that
library(dplyr)
data <- data %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
# adjusting names
fnames <- names(data)
fnames <- paste(fnames, "-mean", sep="")
fnames[1] <- "Subject"
fnames[2] <- "Activity"
names(data) <- fnames

# writing tidy result
write.table(data, "tidy_data.txt", row.names = FALSE)

# > dim(data)
# [1] 40 68

# cleaning up again
rm(fnames, data)