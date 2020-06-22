# Tidy-Data-Project
Getting and Cleaning Data Week 4 Programming Assignment

Data is downloaded and unzipped locally.

Relevant data files within train and test folders are read in and combined
into a single dataset. Test data is first combined with the Subject (test_subject),
Activity (test_Y), and then all accelerometer data (test_X). The same is done for
the training data set and then the two are combined using rbind to form a single
dataset with dimensions of 10299 x 563.

Descriptive variable names are added as column headers using the "features.txt"
file and manually naming "Subject" and "Activity".

From the original accelerometer data, only columns that refer to either mean()
or std() are included (this does not include meanFreq).

The string labels for each activity type are added as an additional column.

The data is then grouped by subject and activity type and the mean of each
measurement column is taken. The labels are activity are added back in to the
file and then it is re-ordered by subject and activity. Since there are 6 possible 
activities and 30 subjects, this produces a dataset with 180 rows and 87 columns. 

Finally, the dataset is written out to a .txt. file.


