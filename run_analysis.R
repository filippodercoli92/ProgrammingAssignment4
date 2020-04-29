# This is the script I realized for the assignment

library(dplyr)

# Reading all the files containing the data I need. X_train and X_test files have been 
# modified to remove double empty spaces which would prevent correct reading.
trainData <- read.csv("./UCI HAR Dataset/train/X_train.txt", sep = " ", header = FALSE)
trainLabel <- read.csv("./UCI HAR Dataset/train/y_train.txt", sep = " ", header = FALSE)
trainSub <- read.csv("./UCI HAR Dataset/train/subject_train.txt", sep = " ", header = FALSE)
testData <- read.csv("./UCI HAR Dataset/test/X_test.txt", sep = " ", header = FALSE)
testLabel <- read.csv("./UCI HAR Dataset/test/y_test.txt", sep = " ", header = FALSE)
testSub <- read.csv("./UCI HAR Dataset/test/subject_test.txt", sep = " ", header = FALSE)
# Removing first empty columns
testData <- select(testData, -1)
trainData <- select(trainData, -1)

# Creating a data frame for train and test data. A new column has been added and the variable "set" 
# created which distinguish train set from test set.
fullTrain <- cbind(trainLabel,trainSub,"Train",trainData)
names(fullTrain) <- c("activity_id","subject_id", "set", "1":"561")
fullTest <- cbind(testLabel,testSub,"Test",testData)
names(fullTest) <- c("activity_id", "subject_id", "set", "1":"561")

# Point2: Exctracting the mean and std. dev. data
# Creating a counter to extract the correct columns
contT1 <- NULL
contT2 <- NULL
contF1 <- NULL
contF2 <- NULL
t1 <- 0:4
t2 <- 0:4
t3 <- 0:2
t4 <- 0:3
for (i in t1) {
  contT1 <- c(contT1,1+3+i*40,2+3+i*40,3+3+i*40,4+3+i*40,5+3+i*40,6+3+i*40)
}
for (i in t2) {
  contT2 <- c(contT2,201+3+i*13,202+3+i*13)
}
for (i in t3) {
  contF1 <- c(contF1,266+3+i*79,267+3+i*79,268+3+i*79,269+3+i*79,270+3+i*79,271+3+i*79)
}
for (i in t4) {
  contF2 <- c(contF2,503+3+i*13,504+3+i*13)
}
# Creating reduced tables with just means and std deviations
smallTrain <- select(fullTrain, activity_id, subject_id, set, all_of(contT1), all_of(contT2), all_of(contF1), all_of(contF2))
smallTest <- select(fullTest, activity_id, subject_id, set, all_of(contT1), all_of(contT2), all_of(contF1), all_of(contF2))

# Point1: Row binding the 2 tables in single data frame
mergedSmall <- rbind(smallTrain, smallTest)

# Point3: Renaming the activity ids
mergedSmall <- mutate(mergedSmall, activity_id = factor(activity_id, labels = c("walking","walking_upstairs","walking_downstairs","sitting","standing","laying")))

# Point4: Renaming variables
namesVar <- c("tBodyAcc_mean_X","tBodyAcc_mean_Y","tBodyAcc_mean_Z","tBodyAcc_std_X","tBodyAcc_std_Y","tBodyAcc_std_Z",
              "tGravityAcc_mean_X","tGravityAcc_mean_Y","tGravityAcc_mean_Z","tGravityAcc_std_X","tGravityAcc_std_Y","tGravityAcc_std_Z",
              "tBodyAccJerk_mean_X","tBodyAccJerk_mean_Y","tBodyAccJerk_mean_Z","tBodyAccJerk_std_X","tBodyAccJerk_std_Y","tBodyAccJerk_std_Z",
              "tBodyGyro_mean_X","tBodyGyro_mean_Y","tBodyGyro_mean_Z","tBodyGyro_std_X","tBodyGyro_std_Y","tBodyGyro_std_Z",
              "tBodyGyroJerk_mean_X","tBodyGyroJerk_mean_Y","tBodyGyroJerk_mean_Z","tBodyGyroJerk_std_X","tBodyGyroJerk_std_Y","tBodyGyroJerk_std_Z",
              "tBodyAccMag_mean","tBodyAccMag_std",
              "tGravityAccMag_mean","tGravityAccMag_std",
              "tBodyAccJerkMag_mean","tBodyAccJerkMag_std",
              "tBodyGyroMag_mean","tBodyGyroMag_std",
              "tBodyGyroJerkMag_mean","tBodyGyroJerkMag_std",
              "fBodyAcc_mean_X","fBodyAcc_mean_Y","fBodyAcc_mean_Z","fBodyAcc_std_X","fBodyAcc_std_Y","fBodyAcc_std_Z",
              "fBodyAccJerk_mean_X","fBodyAccJerk_mean_Y","fBodyAccJerk_mean_Z","fBodyAccJerk_std_X","fBodyAccJerk_std_Y","fBodyAccJerk_std_Z",
              "fBodyGyro_mean_X","fBodyGyro_mean_Y","fBodyGyro_mean_Z","fBodyGyro_std_X","fBodyGyro_std_Y","fBodyGyro_std_Z",
              "fBodyAccMag_mean","fBodyAccMag_std",
              "fBodyBodyAccJerkMag_mean","fBodyBodyAccJerkMag_std",
              "fBodyBodyGyroMag_mean","fBodyBodyGyroMag_std",
              "fBodyBodyGyroJerkMag_mean","fBodyBodyGyroJerkMag_std")
names(mergedSmall) <- c("activity_id", "subject_id", "set", namesVar)

# Point5: 
mergedSmall <- tbl_df(mergedSmall)
mergedSmallGrouped <- group_by(mergedSmall, activity_id, subject_id)

summary <- summarise_all(mergedSmallGrouped, mean) %>% select(-3)

write.table(summary, "./Project_Filippo", row.names = FALSE)

