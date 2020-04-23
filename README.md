# Peer-graded Assignment: Getting and cleaning data

First, I modified the X_train and X_test files to remove double empty spaces which would prevent correct reading. Then, I read into R the
"X_","y_" and "subject_" files, creating the variables "...Data", "...Label", "...Sub" respectively. I assembled a data frame for each set 
of data (train and test) where the first variable is the activity label, the second thesubject id, the third the set label and the other 
561 columns represent the variables measured for each observation.
Then, I created 4 counters
