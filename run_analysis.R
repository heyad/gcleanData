## Getting and Cleaning Data
## Course Project 

## Obtain the data
url <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile="./data/data.zip")
######################################################################
## load data into R, testing and training data set
xTrain <- read.csv("./train/X_train.txt",header=FALSE,stringsAsFactors= FALSE, sep='')## training set
yTrain <- read.csv("./train/y_train.txt",header=FALSE,stringsAsFactors= FALSE, sep='')## trainin labels
sTrain <- read.csv("./train/subject_train.txt",header=FALSE,stringsAsFactors= FALSE, sep='')## Subect train

xTest <- read.csv("./test/X_test.txt",header=FALSE,stringsAsFactors= FALSE, sep='')## test set
yTest <- read.csv("./test/y_test.txt",header=FALSE,stringsAsFactors= FALSE, sep='')## test labels 
sTest <- read.csv("./test/subject_test.txt",header=FALSE,stringsAsFactors= FALSE, sep='')## subect test

## load features set to check which column in the above set corresponds to which 
## feature in the fSet below
fSet <- read.csv("features.txt",header=FALSE,stringsAsFactors= FALSE, sep='')## Features set
#####################################################################
## Tiday up data 
## First Add the type of activity 
xTrain$activity <- yTrain[,1]
xTest$activity <- yTest[,1]

## bind the subjects to the data set
xTrain$subject <- sTrain[,1]
xTest$subject <- yTest[,1]

## Next, merge both sets xTrain and xTest based on the subjectID (test/ training labels)
mergedSet <- rbind(xTrain, xTest)

######################################################################
## Next we want to Extract only the measurements 
## on the mean and standard deviation for each measurement. This require us to make use 
## of the fSet set (whcih is loaded from features.txt)

## check all rows that contains the word mean or SD
isMean <- fSet[grep("mean", fSet$V2) , ]
isSTD <- fSet[grep("std()", fSet$V2) , ]
## merge all measurements of interest (mean, std)
isMeanSD <- rbind(isMean, isSTD)
colnames(isMeanSD)[1] <- "measurement"
## rename the values in the extracted vector 
isMeanSD$measurement <- paste("V", isMeanSD$measurement, sep='')

## now extract the measurements from the merged dataset (training/ testng) that exists 
## on the measurement column of the isMeanSD df (this fulfils question 2)

measurementsDF  <- mergedSet[, which(names(mergedSet) %in% c(isMeanSD$measurement))]
## write the extracted data to a file
write.csv(measurementsDF, file="mean_std_measurements.txt", sep='')
#############################################################################

## description of activities ( 1-walking, 2-walking_upstairs, 3-walking_downstairs,
## 3 sitting, 5-standing, 6-laying)

mergedSet[,'activity'==1] <- "WALKING" 
mergedSet[,'activity'==2] <- "WALKING-UPSTAIRS" 
mergedSet[,'activity'==3] <- "WALKING-DOWNSTAIRS"  ## There must be bettter approach?? 
mergedSet[,'activity'==4] <- "SITTING" 
mergedSet[,'activity'==5] <- "STANDING" 
mergedSet[,'activity'==6] <- "LAYING" 

## appropriately lable the data set 
## This is simplistic solution based on the features file 

colnames(mergedSet)[1:561] <- c(fSet$V2)

## 5 a second, independent tidy data set with the 
## average of each variable for each activity and each subject

## Creates a second, independent tidy 
## data set with the average of each variable for each activity and each subject

require (plyr)
subjectActs <- ddply(mergedSet, c(.(activity),.(subject)), summarize, colMeans=colMeans(mergedSet[1:561]))
## write to file
rownames(subjectActs)<- NULL
write.csv(subjectActs, file="subjectsacts.txt", sep='')
