# RaduG - TrainTest5
Description of how the script works and the code book describing the variables.

## INTRO SECTION AND LIBRARIES
- Libraries: dplyr, tibble, tidyr
- Read features and activities, set Fixed-width-format columns

## TEST DATA SET LOADING
- Load test data set, activity labels and subject

## TRAIN DATA SET LOADING
- Load train data set, activity labels and subject

# SCRIPT GOALS:
## 1. Merges the training and the test sets to create one data set.
- Using bind_rows to bind two data frames
## 3. Uses descriptive activity names to name the activities in the data set
- Using inner_join to bring in descriptive activity names
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
- Using regular expressions to select only mean and std
## 4. Appropriately labels the data set with descriptive variable names.
- already done with colnames, TrainTest2 has descriptive variable names
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
- Using gather, group_by, and back to pivot_wider to retrieve the tidy data set

# FEATURES: 
These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

# STATISTICS:
The set of variables that were estimated from these signals are: 
mean(): Mean value
std(): Standard deviation

