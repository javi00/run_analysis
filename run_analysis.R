# first load the features
features <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", sep = "")

# load the test datasets 
x_test <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", sep = "")
y_test <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt", sep = "")
subject_test <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", sep = "")

# here I put the name to each column
colnames(x_test) <- features[,2]
colnames(y_test) <- "label"
colnames(subject_test) <- "sample"

#then I merge all test data sets
total_test <- cbind(subject_test,y_test,x_test)

# load the train data sets 
x_train <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", sep = "")
y_train <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt", sep = "")
subject_train <-  read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", sep = "")

# here I put the name to each column
colnames(x_train) <- features[,2]
colnames(y_train) <- "label"
colnames(subject_train) <- "sample"

#then I merge all train data sets
total_train <- cbind(subject_train,y_train,x_train)

#merge to unique dataset with test and train
total <- rbind(total_test,total_train)

#calculate mean and standard deviation
mean <- sapply(total, mean)
str  <- sapply(total, sd)

# to finish I created only one dataset with mean and standard deviation
result <- rbind(mean,str)
result <-  as.data.frame(result)
# write a  table with the results

write.table(result,"C:/Users/javi_/Documents/R/run_analysis/result.txt", sep = " ",row.name=FALSE)

