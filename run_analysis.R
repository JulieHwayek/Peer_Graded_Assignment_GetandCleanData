setwd("C:\\Users\\JAlHwayek\\RStudio\\Week4Assignment\\getdata%2Fprojectfiles%2FUCI HAR Dataset\\UCI HAR Dataset")
getwd()

list.files(".")
Train = read.table('./train/subject_train.txt',header=FALSE)
xTrain = read.table('./train/x_train.txt',header=FALSE)
yTrain = read.table('./train/y_train.txt',header=FALSE)
Test = read.table('./test/subject_test.txt',header=FALSE)
xTest = read.table('./test/x_test.txt',header=FALSE)
yTest = read.table('./test/y_test.txt',header=FALSE)
xDataSet <- rbind(xTrain, xTest)
yDataSet <- rbind(yTrain, yTest)
DataSet <- rbind(Train, Test)
dim(xDataSet)
dim(yDataSet)
dim(DataSet)
xDataSet_meanandStd <- xDataSet[, grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2])]
names(xDataSet_meanandStd) <- read.table("features.txt")[grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2]), 2] 
View(xDataSet_meanandStd)
dim(xDataSet_meanandStd)

yDataSet[, 1] <- read.table("activity_labels.txt")[yDataSet[, 1], 2]
names(yDataSet) <- "Activity"
View(yDataSet)
names(DataSet) <- "Subject"
summary(DataSet)
SoloDataSet <- cbind(xDataSet_meanandStd, yDataSet, DataSet)
names(SoloDataSet) <- make.names(names(SoloDataSet))
names(SoloDataSet) <- gsub('Acc',"Acceleration",names(SoloDataSet))
names(SoloDataSet) <- gsub('GyroJerk',"AngularAcceleration",names(SoloDataSet))
names(SoloDataSet) <- gsub('Gyro',"AngularSpeed",names(SoloDataSet))
names(SoloDataSet) <- gsub('Mag',"Magnitude",names(SoloDataSet))
names(SoloDataSet) <- gsub('^t',"TimeDomain.",names(SoloDataSet))
names(SoloDataSet) <- gsub('^f',"FrequencyDomain.",names(SoloDataSet))
names(SoloDataSet) <- gsub('\\.mean',".Mean",names(SoloDataSet))
names(SoloDataSet) <- gsub('\\.std',".StandardDeviation",names(SoloDataSet))
names(SoloDataSet) <- gsub('Freq\\.',"Frequency.",names(SoloDataSet))
names(SoloDataSet) <- gsub('Freq$',"Frequency",names(SoloDataSet))

View(SoloDataSet)
IndependentTidyData<-aggregate(. ~Subject + Activity, SoloDataSet, mean)
IndependentTidyData<-IndependentTidyData[order(IndependentTidyData$Subject,IndependentTidyData$Activity),]
write.table(IndependentTidyData, file = "tidydata.txt",row.name=FALSE)
View(IndependentTidyData)
