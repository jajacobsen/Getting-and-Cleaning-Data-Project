---
title: "README.md"
author: "jajacobsen"
date: "Saturday, February 21, 2015"
output: html_document
---

This readme file contains information about how I downloaded the data and organized it into a tidy dataset.



### Description of the Dataset from the authors:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

### Downloading the data

The data was downloaded into a file in my working directory called "biodataz".  I unzipped the file and stored it in an object called biodata so that I could read any table from the file as an index of biodata.  

### Cleaning up the data

This describes the general strategy of the code in run_analysis.R for cleaning up the data.  For more detail about the individual steps of the analysis, please see the code in run_analysis.R.  For information about the variable measures used, please see CodeBook.md.

The first step was to organize the data so everything I needed was in one table. I started by combining subject IDs, activity types, and reported variable measures for the test and training datasets using cbind.  I then used rbind to combine training and test data.  

Next, I got rid of all the variables except those including "mean" or "std" in the column name.  To do this I first applied labels to the column names by reading in the features.txt file. Using the "grep" function, I then subsetted the table to include only the columns with "mean" or"std" in the column names.  

Then to summarize the means of each column according to both Subject ID and activity type, I created a factor variable that encoded both Subject ID and Activity type. This required the paste function so I could effectively combine information from two columns into one.  I then appended this new factor variable to my table by cbind.  Using the dplyr package and the 'group_by' and  'summarise_each' functions, I summarized the mean of each column by my new factor variable to generate a new table.

The final table was cleaned up by removing the combined factor variable and ordering by subject ID.


