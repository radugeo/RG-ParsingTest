# ======== FINAL: Getting and Cleaning Data Course Project =========
library(dplyr)
library(tibble)
library(tidyr)
features <- as_tibble(read.table("features.txt", sep = " ", col.names = c("NR", "FEATURE"), colClasses = c("numeric","character")))
features <- mutate(features, "FeatureName" = paste0(features$NR,"-", features$FEATURE)) # to avoid duplicates
activities <- as_tibble(read.table("activity_labels.txt", sep = " ", col.names = c("Activity", "ActivityName"), colClasses = c("numeric","character")))
w <- rep(16, 561) 
# =================== TEST DATA SET ===============================
test <- as_tibble(read.fwf(file="X_test.txt", widths=w)) # read every 16 columns one number, 561 columns
colnames(test) <- features$FeatureName # set test colnames
test <- test %>% add_column("TestOrTrain" = rep("Test", 2947), .before="1-tBodyAcc-mean()-X") # label rows
y_test <- as_tibble(read.table("y_test.txt")) # read test labels (1-6)
colnames(y_test) <- "Activity"
subject_test <- as_tibble(read.table("subject_test.txt")) # read subject labels (1-30)
colnames(subject_test) <- "Subject"
test <- test %>% add_column("Activity" = y_test$Activity, "Subject"=subject_test$Subject,.before="TestOrTrain") # add Activity column

# =================== TRAIN DATA SET ===============================
train <- as_tibble(read.fwf(file="X_train.txt", widths=w)) # read every 16 columns one number, 561 columns
colnames(train) <- features$FeatureName # set train colnames
train <- train %>% add_column("TestOrTrain" = rep("Train", 7352), .before="1-tBodyAcc-mean()-X") # label rows
y_train <- as_tibble(read.table("y_train.txt")) # read train labels (1-6)
colnames(y_train) <- "Activity"
subject_train <- as_tibble(read.table("subject_train.txt")) # read subject labels (1-30)
colnames(subject_train) <- "Subject"
train <- train %>% add_column("Activity" = y_train$Activity,"Subject"=subject_train$Subject, .before="TestOrTrain")

# =================== Script Goals ===========================
# 1. Merges the training and the test sets to create one data set.
TrainTest1 <- bind_rows(test, train) # bind both train + test data frames
# 3. Uses descriptive activity names to name the activities in the data set
TrainTest3 <- inner_join(TrainTest1, activities, by="Activity") # Add ActivityName
TrainTest3 <- TrainTest3 %>% select(565, 1:564) # Reorder and bring ActivityName first
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
colNames <- colnames(TrainTest3)
colToAdd <- grepl("(-std\\(|-mean\\()", colNames) # Keep these columns
length(grep("(-std\\(|-mean\\()", colNames)) # Nr columns that are mean or std = 33 X 2
colToAdd [1:4] <- TRUE # Keep first 4 columns in addition to mean and std columns
TrainTest2 <- TrainTest3[,colToAdd] # Create new df with the selected columns
# 4. Appropriately labels the data set with descriptive variable names.
# already done with colnames, TrainTest2 has descriptive variable names
TrainTest2
# 5. From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
TrainTest5 <- TrainTest2 %>% gather(key= "Feature", value = "Measurement", 5:70) # Make a tall table keeping 1:4 cols
TrainTest5 <-TrainTest5 %>% group_by(Feature, ActivityName, Subject) %>% summarise(Faverage = mean(Measurement))
TrainTest5 <- TrainTest5 %>%  pivot_wider(names_from = Feature, values_from = Faverage) # Back to tidy data set
write.table(TrainTest5, file = "TrainTest5.txt", row.names=FALSE)


