# Peer-graded Assignment: Getting and cleaning data

First, I modified the X_train and X_test files to remove double empty spaces which would prevent correct reading.

Then, I read into R the "X_","y_" and "subject_" files, creating the variables "...Data", "...Label", "...Sub" respectively. I assembled a 
data frame for each set of data ("fullTrain" and "fullTest") where the first variable is the activity label, the second the subject id, 
the third the set label and the other 561 columns represent the variables measured for each observation.

Then, I created 4 counters to extract the mean and std. dev. variables and defined 2 new data frame (smallTrain and smallTest), containing 
the activity ids, the subject ids, the set and the extracted variables. 

Now, I merged the 2 frames by row into "mergedSmall" and renamed 
the activity labels and varibles names with descriptive definitions.

Finally, I grouped the rows by "activity_id" and "subject_id" and summarized the data frame with the mean of each numerical variable.
