##Getting and cleaning data - Course Project
## UCI HAR dataset

library(plyr)
library(dplyr)
library(data.table)


# 1. Merge the training and tests to create one data set

# load activitylabels and features
# also create vector of feature labels


activitynumbers <- as.character(read.table("activity_labels.txt")[,1])
activitylabels <- as.character(read.table("activity_labels.txt")[,2])
features <- as.character(read.table("features.txt")[,2])


# load training set
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

# load test set 
subject_test <- read.table("test/subject_test.txt")
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/Y_test.txt")

# combine training set by columns,and then test by columns

trainall <- cbind(subject_train, y_train, x_train)
testall <- cbind(subject_test, y_test, x_test)

# combine traing and test by rows, and rename columns

tidydatadraft <- rbind(trainall, testall)

# 2.Appropriately labels the data set with descriptive variable names
names(tidydatadraft) <- c("subjectID", "activity", features)


# 3.Extracts only the measurements on the mean and the standard deviation for each measurement

tdd2 <- tidydatadraft[,grep("mean|std", names(tidydatadraft))]
tdd3 <- tidydatadraft[,grep("subject|activity", names(tidydatadraft))]

draft <- cbind(tdd3, tdd2)


# 4 Uses descriptive activity names to name the activities in each seact

draft$activity <- mapvalues(draft$activity, from=activitynumbers, to=activitylabels)


# 5. From the data set in step #4, creates a second, independant tidy data set 
#    with the average of each variable for each activity and each subject 

aggregatedmean <- aggregate(draft[,3:81], list(subjectID=draft$subjectID, draft$activity), FUN=mean, na.rm=TRUE)

#clean up the column names a bit

colnames(aggregatedmean) <- gsub("-std", "Std", colnames(aggregatedmean))
colnames(aggregatedmean) <- gsub("-mean", "Mean", colnames(aggregatedmean))
colnames(aggregatedmean) <- gsub("[()]", "", colnames(aggregatedmean))
colnames(aggregatedmean) <- gsub("^t", "time", colnames(aggregatedmean))
colnames(aggregatedmean) <- gsub("^f", "FFT", colnames(aggregatedmean))

colnames(aggregatedmean)[2] <- "activity"

tidydatamean <- aggregatedmean[with(aggregatedmean, order(aggregatedmean[,1], aggregatedmean[,2])),]


names(draft) <- colnames(tidydatamean)

Export tidydata sets:
write.csv(draft, "tidydata.csv", row.names=TRUE)
write.csv(tidydatamean, "tidydatamean.csv", row.names=TRUE)