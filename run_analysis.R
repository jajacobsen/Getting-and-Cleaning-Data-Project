## The file is saved in my wd as biodataz

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./biodataz")
biodata <- unzip("./biodataz")

## 1. Organize subject measurements for train and test
##   a) Label subject(ID), x(features), and y(actlabel)

## Test
        SubIDTest <- read.table(biodata[14])
        FeatTest <- read.table(biodata[15])
        ActLabTest <- read.table(biodata[16])

## Train
        SubIDTrain <- read.table(biodata[26])
        FeatTrain <- read.table(biodata[27])
        ActLabTrain <- read.table(biodata[28])

##   b) combine ID, Feat, Act for Test and Train
        Test <- cbind(SubIDTest, ActLabTest, FeatTest)
        Train <- cbind(SubIDTrain, ActLabTrain, FeatTrain)

##   c) combine Test and Train
        Total <- rbind(Test, Train)



## 2. Add labels across the columns
        FeatureLabels <- read.table(biodata[2])
        colnames(Total) <- c("Subject ID", "Activity Type", as.character(FeatureLabels[, 2]))

##    a) Identify column indices for mean and StdDev measurements
        Mean <- grep("mean", as.character(FeatureLabels[, 2]))
        SD <- grep("std", as.character(FeatureLabels[, 2]))

##    b) Subset Total df with combined indices for mean and StdDev
        MSTotal <- Total[, c(1, 2, (Mean + 2), (SD + 2))]
## Note: I use Mean + 2 and SD + 2 because there are two extra columns in my
## Total dataframe (Subject ID and Activity Type)



## 3. Convert Activity Type and Subject ID to factors and combine into joint category

##    a) Convert Activity Type to factor with labels
        MSTotal[, 2] <- factor(MSTotal[, 2], levels = c(5, 4, 6, 1, 3, 2), 
                labels = c("Standing", "Sitting", "Laying", "Walking", 
                "Walking Down", "Walking Up"))

##    b) Convert Subject ID to factor variable
        MSTotal[, 1] <- as.factor(MSTotal[, 1])

##    c) Create a third factor column that combines Activity Type and Subject ID 
        IDAct <- paste(Total[, 1], Total[, 2], sep = "")
        IDActf <- as.factor(IDAct)
        MSTot <- cbind(IDActf, MSTotal)



## 4. Summarize column means by combined factor 
        library(dplyr)
        SumMSTot <- MSTot %>% group_by(IDActf) %>% summarise_each(funs(mean))
## This operation converts activity type back to numeric



## 5. Clean up final table

## Remove new factor variable
        Tidy <- as.data.frame(SumMSTot[, 2:82])

## Convert activity type back to labels
        Tidy[, 2] <- factor(Tidy[, 2], levels = c(5, 4, 6, 1, 3, 2), 
                labels = c("Standing", "Sitting", "Laying", "Walking", 
                "Walking Down", "Walking Up"))

## Order the table by subject ID
        TidyData <- Tidy[order(Tidy[, 1]), ]

## Write the table to a file
        write.table(TidyData, file = "./TidyData.txt", row.name = F)