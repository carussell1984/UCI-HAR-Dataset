This project shows demonstration of my ability to download a messy disjointed data set and transform it into a tidy data set, whereby the data can be further analzyed.

The orinal data can be found at the following website. 

 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 
Download the files and unzip the files, and then finally set your working directory in R to the file that contains the unzipped file.
 
The run_analysis.R script can be used to download the training set and the test set along with the variable names, and the activity labels in the UI-HAR-DATASET, can you originally downloaded. 

The R Scripts performs the following functions:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 
