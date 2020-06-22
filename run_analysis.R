## This is a script to merge, and clean data from Samsung Galaxy S smartphone accelerometers

##Download and unzip the relevant data
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(data_url, destfile = "./temp.zip")
unzip("./temp.zip")

train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train_X <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_Y <- read.table("./UCI HAR Dataset/train/y_train.txt")

test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test_X <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_Y <- read.table("./UCI HAR Dataset/test/y_test.txt")

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

##Merge train and test data into a single dataset
test_data <- cbind(test_subject, test_Y, test_X)
train_data <- cbind(train_subject, train_Y, train_X)
all_data <- rbind(test_data, train_data)

#Change header names into descriptive variable names
new_names <- c("Subject", "Activity", as.character(features$V2))
names(all_data) <- new_names

##Select only relevant data columns
library(dplyr)
select_data <- select(all_data, matches("Subject|Activity|mean()|std()"))
final_data <- select_data[,1:86]

##Use activity labels to change from numbered activity to descriptive activities
new_activity_headers <- c("Activity", "Activity Label")
names(activity_labels) <- new_activity_headers

labeled_data <- merge(activity_labels, final_data, by="Activity")

##Group and summarize by mean
tidy_data_set <- labeled_data %>%
        group_by(Subject, Activity) %>%
        summarize_if(is.numeric, mean)

##Reorder final dataset by Subject, then by Activity
tidy_data_set <- merge(activity_labels, tidy_data_set, by="Activity")
tidy_data_set <- arrange(tidy_data_set, Subject, Activity)

##Writes the output tidy dataset to a .txt file
write.table(tidy_data_set, file = "./final-tidy-data.txt", append = FALSE, sep = " ", dec = ".",
            row.names = FALSE, col.names = TRUE)
