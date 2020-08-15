library(dplyr)

# load the test data sets 
x_test <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", sep = "")
y_test <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt", sep = "")
subject_test <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", sep = "")

# Here I put the name to each column
colnames(x_test) <- features[,2]
colnames(y_test) <- "activity"
colnames(subject_test) <- "sample"

#then I merge all test data sets
total_test <- cbind(subject_test,y_test,x_test)

# load the train data sets 
x_train <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", sep = "")
y_train <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt", sep = "")
subject_train <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", sep = "")

# here I put the name to each column
colnames(x_train) <- features[,2]
colnames(y_train) <- "activity"
colnames(subject_train) <- "sample"

#then I merge all train data sets
total_train <- cbind(subject_train,y_train,x_train)

#merge to unique dataset with test and train
total <- rbind(total_test,total_train)

#activity 
t1 <- total[total$label == 1,]
t2 <- total[total$label == 2,]
t3 <- total[total$label == 3,]
t4 <- total[total$label == 4,]
t5 <- total[total$label == 5,]
t6 <- total[total$label == 6,]

#calculate mean and standard  deviation
mean1 <- sapply(t1, mean)
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

