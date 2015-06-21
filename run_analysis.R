library(RCurl)

if (!file.exists('uci_har/uci_har.zip')) {
      dataFile <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
      dir.create('uci_har')
      download.file(dataFile, 'uci_har/uci_har.zip', method='wget')
}
unzip('uci_har/uci_har.zip', exdir = "uci_har" )
# 1. Merges the training and the test sets to create one data set.
x.train <- read.table('./uci_har/UCI HAR Dataset/train/X_train.txt')
x.test <- read.table('./uci_har/UCI HAR Dataset/test/X_test.txt')
x <- rbind(x.train, x.test)

subject_train <- read.table('./uci_har/UCI HAR Dataset/train/subject_train.txt')
subject_test <- read.table('./uci_har/UCI HAR Dataset/test/subject_test.txt')
subject <- rbind(subject_train, subject_test)

y.train <- read.table('./uci_har/UCI HAR Dataset/train/y_train.txt')
y.test <- read.table('./uci_har/UCI HAR Dataset/test/y_test.txt')
y <- rbind(y.train, y.test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table('./uci_har/UCI HAR Dataset/features.txt')
mean.sd <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
x.mean.sd <- x[, mean.sd]

# 3. Uses descriptive activity names to name the activities in the data set
names(x.mean.sd) <- features[mean.sd, 2]
names(x.mean.sd) <- tolower(names(x.mean.sd)) 
names(x.mean.sd) <- gsub("\\(|\\)", "", names(x.mean.sd))

activity <- read.table('./uci_har/UCI HAR Dataset/activity_labels.txt')
activity[, 2] <- tolower(as.character(activity[, 2]))
activity[, 2] <- gsub("_", "", activity[, 2])

y[, 1] = activity[y[, 1], 2]
colnames(y) <- 'activity'
colnames(subject) <- 'subject'

# 4. Appropriately labels the data set with descriptive activity names.
dataset <- cbind(subject, x.mean.sd, y)
str(dataset)
write.table(dataset, './uci_har//merged.txt', row.names = F)

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidy_average <- aggregate(x=dataset, by=list(activity=dataset$activity, subject=dataset$subject), FUN=mean)
tidy_average <- tidy_average[, !(colnames(tidy_average) %in% c("subject", "activity"))]
str(tidy_average) 
write.table(tidy_average, './uci_har//tidy_dataset_averages.txt', row.names = F)
