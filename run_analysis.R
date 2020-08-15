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

#5. Creates a second, independent tidy data set with the average of each variable 

## by sample and activity 

avgt <- c(0)

for(a in 1:30)
{
    for ( b in 1:6) {
        
        data <- filter(total,total$sample == a & total$activity == act_label[b,1])
        avg <- sapply(data, mean)
        avgt <- rbind(avg,avgt)
    }
}

total <- as.data.frame(avgt[1:180,])

total$activity <- act_label[total$activity,2]

   
t1 <- total[total$label == 1,]
t2 <- total[total$label == 2,]
t3 <- total[total$label == 3,]
t4 <- total[total$label == 4,]
t5 <- total[total$label == 5,]
t6 <- total[total$label == 6,]

#calculate mean and standard  deviation
mean1 <- sapply(total, mean)
str1  <- sapply(t1, sd)
mean2 <- sapply(t2, mean)
str2  <- sapply(t2, sd)
mean3 <- sapply(t3, mean)
str3  <- sapply(t3, sd)
mean4 <- sapply(t4, mean)
str4  <- sapply(t4, sd)
mean5 <- sapply(t5, mean)
str5  <- sapply(t5, sd)
mean6 <- sapply(t6, mean)
str6  <- sapply(t6, sd)

# to finish I created only one dataset with mean and standard deviation
result <- rbind(mean1,str1,mean2,str2,mean3,str3,mean4,str4,mean5,str5,mean6,str6)
act<-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", sep = "")

rownames(result) <- c(act[,2],act[,2])

result <-  as.data.frame(result)
# write a  table with the results

write.table(result,"C:/Users/javi_/Documents/R/run_analysis/result.txt", sep = " ")

