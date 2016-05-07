# Merges the training and the test sets to create one data set
    ## Store all variables
        ### Store "test" subjects and activities
        subjects_test<- read.table("test/subject_test.txt")
        activity_test <- read.table("test/y_test.txt")
        ### Store "test" variables
        features_test <- read.table("test/X_test.txt")
        body_acc_x_test <- read.table("test/Inertial Signals/body_acc_x_test.txt")
        body_acc_y_test <- read.table("test/Inertial Signals/body_acc_y_test.txt")
        body_acc_z_test <- read.table("test/Inertial Signals/body_acc_z_test.txt")
        body_gyro_x_test <- read.table("test/Inertial Signals/body_gyro_x_test.txt")
        body_gyro_y_test <- read.table("test/Inertial Signals/body_gyro_y_test.txt")
        body_gyro_z_test <- read.table("test/Inertial Signals/body_gyro_z_test.txt")
        total_acc_x_test <- read.table("test/Inertial Signals/total_acc_x_test.txt")
        total_acc_y_test <- read.table("test/Inertial Signals/total_acc_y_test.txt")
        total_acc_z_test <- read.table("test/Inertial Signals/total_acc_z_test.txt")
        ### Store "train" subjects and activities
        subjects_train<- read.table("train/subject_train.txt")
        activity_train <- read.table("train/y_train.txt")
        ### Store "train" variables
        features_train <- read.table("train/X_train.txt")
        body_acc_x_train <- read.table("train/Inertial Signals/body_acc_x_train.txt")
        body_acc_y_train <- read.table("train/Inertial Signals/body_acc_y_train.txt")
        body_acc_z_train <- read.table("train/Inertial Signals/body_acc_z_train.txt")
        body_gyro_x_train <- read.table("train/Inertial Signals/body_gyro_x_train.txt")
        body_gyro_y_train <- read.table("train/Inertial Signals/body_gyro_y_train.txt")
        body_gyro_z_train <- read.table("train/Inertial Signals/body_gyro_z_train.txt")
        total_acc_x_train <- read.table("train/Inertial Signals/total_acc_x_train.txt")
        total_acc_y_train <- read.table("train/Inertial Signals/total_acc_y_train.txt")
        total_acc_z_train <- read.table("train/Inertial Signals/total_acc_z_train.txt")

    ## Combine "test" and "train" sets, rename columns and combine into one dataframe
        ### Combine "test" and "train" variables
        subjects <- rbind(subjects_test, subjects_train)
        features <- rbind(features_test, features_train)
        activity <- rbind(activity_test, activity_train)
        body_acc_x <- rbind(body_acc_x_test, body_acc_x_train)
        body_acc_y <- rbind(body_acc_y_test, body_acc_y_train)
        body_acc_z <- rbind(body_acc_z_test, body_acc_z_train)
        body_gyro_x <- rbind(body_gyro_x_test, body_gyro_x_train)
        body_gyro_y <- rbind(body_gyro_y_test, body_gyro_y_train)
        body_gyro_z <- rbind(body_gyro_z_test, body_gyro_z_train)
        total_acc_x <- rbind(total_acc_x_test, total_acc_x_train)
        total_acc_y <- rbind(total_acc_y_test, total_acc_y_train)
        total_acc_z <- rbind(total_acc_z_test, total_acc_z_train)
        ### Rename Columns
        features_labels <- read.table("features.txt")
        colnames(features) <- features_labels$V2
        colnames(subjects) <- "subject"
        colnames(activity) <- "activity"
        for(i in 1:length(names(body_acc_x))){
            names(body_acc_x)[i] <- paste("body_acc_x",i,sep="")
        }
        for(i in 1:length(names(body_acc_y))){
            names(body_acc_y)[i] <- paste("body_acc_x",i,sep="")
        }
        for(i in 1:length(names(body_acc_z))){
            names(body_acc_z)[i] <- paste("body_acc_x",i,sep="")
        }
        for(i in 1:length(names(body_gyro_x))){
            names(body_gyro_x)[i] <- paste("body_acc_x",i,sep="")
        }
        for(i in 1:length(names(body_gyro_y))){
            names(body_gyro_y)[i] <- paste("body_acc_x",i,sep="")
        }
        for(i in 1:length(names(body_gyro_z))){
            names(body_gyro_z)[i] <- paste("body_acc_x",i,sep="")
        }
        for(i in 1:length(names(total_acc_x))){
            names(total_acc_x)[i] <- paste("body_acc_x",i,sep="")
        }
        for(i in 1:length(names(total_acc_y))){
            names(total_acc_y)[i] <- paste("body_acc_x",i,sep="")
        }
        for(i in 1:length(names(total_acc_z))){
            names(total_acc_z)[i] <- paste("body_acc_x",i,sep="")
        }
        ### Combine variables into one dataframe

        UCI <- data.frame(
            subjects,
            activity,
            features,
            body_acc_x,
            body_acc_y,
            body_acc_z,
            body_gyro_x,
            body_gyro_y,
            body_gyro_z,
            total_acc_x,
            total_acc_y,
            total_acc_z
        )
  
#Extracts only the measurements on the mean and standard deviation for each measurement
    ## Have retained the "subject" and "activity"
    UCI_mean_std <- UCI[,c(1,2,grep("std()|mean()",colnames(UCI)))]

#Uses descriptive activity names to name the activities in the data set
    ## This was done in an earlier step before extracting

#Appropriately labels the data set with descriptive variable names
    ## This was done in an earlier step before extracting

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    library(plyr)
    UCI_summary <- ddply(UCI_mean_std,c("subject","activity"),numcolwise(mean))
    ## re-label activities
    UCI_summary$activity <- rep(c("walking", "walking_upstairs","walking_downstairs","sitting","standing","laying"),30)
    
#Create txt file "UCI_tidy_data.txt" using "UCI_summary"
    write.table(UCI_summary,file = "UCI_tidy_data.txt",row.name=FALSE)


