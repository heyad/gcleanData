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
## First we want to add the labels to the training and testing observations 
xTrain$subjectID <- sTrain[,1]
xTest$subjectID <- sTest[,1]

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

## now extract the measurements from the merged dataset (training/ testng) that exists 
## on the measurement column of the isMeanSD df









## read gdp data 
gdp <- read.csv("gdp.csv", header = FALSE, skip=4, stringsAsFactors=FALSE)
gdp_data <- gdp[,c(1,2,4,5)]
colnames(gdp_data)=c("code","rank","country","dollar")
gdp_data$rank <- as.numeric(gdp_data$rank)
gdp_data <- gdp_data[2:191,]
rownames(gdp_data)<-NULL

