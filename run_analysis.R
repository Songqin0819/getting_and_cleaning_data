# Step 1 
# Global options for not converting the strings as factors.
options(stringsAsFactors=FALSE)
# load dplyr package
library(dplyr)
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activity_labels_num", "activity_labels"))
features <- read.table("UCI HAR Dataset/features.txt", col.names=c("features_num","features"))
# for test_data
test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$features)
test_activities <- read.table("UCI HAR Dataset/test/y_test.txt", col.names=c("activity_labels_num"))

test_activities <- merge(test_activities,activity_labels)
test_activities <- test_activities[2]
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names=c("subject"))
test_data <- cbind(test_activities,test_subjects, test)

# for train_data
train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$features)
train_activities <- read.table("UCI HAR Dataset/train/y_train.txt", col.names=c("activity_labels_num"))
train_activities <- merge(train_activities,activity_labels)
train_activities <- train_activities[2]
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names=c("subject"))
train_data <- cbind(train_activities,train_subjects, train)

data<- rbind(test_data,train_data)
# 2. Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
features_of_mean_std <- grep("([Mm]ean|[Ss]td)\\(\\)",features[,2])
# add 2, because first two cols are activities and subject
data_of_mean_std <- data[c(1,2,features_of_mean_std+2)] 
# 5. From the data set in step 4, creates a second, independent tidy data
# set with the average of each variable for each activity and each subject.
final_data <- summarise_each(group_by(data_of_mean_std,activity_labels,subject), funs(mean))
## Please upload the tidy data set created in step 5 of the instructions. 
# Please upload your data set as a txt file created with write.table() using row.name=FALSE 
write.table(final_data, "step5.txt", row.names = FALSE)
