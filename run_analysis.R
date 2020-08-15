library(dplyr)

# 1. Merge test and train data set
## Load the test dataset 
x_test <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", sep = "")
y_test <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt", sep = "")
subject_test <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", sep = "")
## Name to each column with 
features <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", sep = "")
colnames(x_test) <- features[,2]
colnames(y_test) <- "activity"
colnames(subject_test) <- "sample"
# Load the train dataset 
x_train <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", sep = "")
y_train <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt", sep = "")
subject_train <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", sep = "")
# here I put the name to each column
colnames(x_train) <- features[,2]
colnames(y_train) <- "activity"
colnames(subject_train) <- "sample"


# 2. Extracts only the measurements on the mean and standard deviation
## Name to each activity 
act_label <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", sep = "")
## select only the mean and std colums in TEST
xmst <- x_test[grep("mean()|std()", names(x_test))]
## it is merging all  test data sets
total_test <- cbind(subject_test,y_test,xmst)

## select only the mean and std colums in TRAIN
xmstr <- x_train[grep("mean()|std()", names(x_train))]
## it is merging all train data sets
total_train <- cbind(subject_train,y_train,xmstr)
# merge to unique dataset with test and train
total <- rbind(total_test,total_train)

#3. descriptive activity names
## here arrange and names each activity
total <- arrange(total, activity)

#4 Appropriately labels the data set with descriptive variable names
# total$activity <- act_label[total$activity,2]

#5.  , independent tidy data set with the average of each variable 

## by sample and activity 

avgt <- c(0)

for(a in 1:30)
{
    for ( b in 1:6) {
        
        data <- filter(total,total$sample == a & total$activity == act_label[b,1])
        ## calculate average 
        avg <- sapply(data, mean)
        avgt <- rbind(avg,avgt)
    }
}
# convert like data frame
total <- as.data.frame(avgt[1:180,])
# names to to each activity
total$activity <- act_label[total$activity,2]

# write a  table with the results

write.table(total,"C:/Users/javi_/Documents/R/run_analysis/result.txt", sep = " ", row.names = FALSE)

