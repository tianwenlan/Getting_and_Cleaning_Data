library(dplyr)
#step 0: read files

features <- 'UCI_HAR_Dataset/features.txt'
label_activity_file <- 'UCI_HAR_Dataset/activity_labels.txt'
train_data_file<-'UCI_HAR_Dataset/train/X_train.txt'
train_label_file <- 'UCI_HAR_Dataset/train/y_train.txt'
train_subject_file <- 'UCI_HAR_Dataset/train/subject_train.txt'
test_data_file <-'UCI_HAR_Dataset/test/X_test.txt'
test_label_file <- 'UCI_HAR_Dataset/test/y_test.txt'
test_subject_file <- 'UCI_HAR_Dataset/test/subject_test.txt'

#read features.txt into list
features <- read.csv(features, header = F, sep='')[['V2']]

#read train data
#read train_subject.txt into list
train_subject <- read.csv(train_subject_file, header = F, sep='')
names(train_subject) <- c('subject')

#read X_train.txt
train_dataset <- read.csv(train_data_file, header=F, sep='')
names(train_dataset) <- features

#read y_train.txt
train_label <- read.csv(train_label_file, header=F)
names(train_label) <- c('activity')

#merge train files
train_merged <- cbind(train_subject, train_label)
train_merged <- cbind(train_merged, train_dataset)

# remove individual data tables to save memory
rm(train_subject, train_label, train_dataset)

print(train_merged)

#read test_subject.txt into list
test_subject <- read.csv(test_subject_file, header = F, sep='')
names(test_subject) <- c('subject')

#read X_test.txt
test_dataset <- read.csv(test_data_file, header=F, sep='')
names(test_dataset) <- features

#read y_test.txt
test_label <- read.csv(test_label_file, header=F)
names(test_label) <- c('activity')

test_merged <- cbind(test_subject, test_label)
test_merged <- cbind(test_merged, test_dataset)

data_merged <- rbind(train_merged, test_merged)

# remove individual data tables to save memory
rm(test_subject, test_label, test_dataset, test_merged, train_merged)

print(grep('-mean()', colnames(data_merged), fixed=T))
#Step2: Extracts only the measurements on the mean and standard deviation for each measurement.
selected_columns <- c(c(1,2), grep('-mean()', colnames(data_merged), fixed=T), grep('-std()', colnames(data_merged), fixed=T))

print(selected_columns)
data_selected <- data_merged[, selected_columns]

print(data_selected)

#Step3: Uses descriptive activity names to name the activities in the data set
#read activity_labels.txt
activity_label <- read.csv(label_activity_file, header=F,sep='')
names(activity_label) <-c('label', 'activity')

print(activity_label[,1])
print(activity_label[,2])


data_selected$activity <- factor(data_selected$activity, levels = activity_label[,1], labels = activity_label[,2])


print(data_selected)

#Step4: Appropriately labels the data set with descriptive variable names.

names(data_selected) = gsub('-mean', 'Mean', names(data_selected))
names(data_selected) = gsub('-std', 'Std', names(data_selected))
names(data_selected) <- gsub('[-()]', '', names(data_selected))

#Step5:From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- data_selected %>% group_by(subject,activity) %>% summarise_all(list(mean))

print('tidy_data')
print(tidy_data)

write.table(tidy_data, "TidyData.txt", row.name=FALSE, quote = FALSE)

