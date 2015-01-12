# Getting and Cleaning Data Project

## Synopsis

One of the most exciting areas in all of data science right now is wearable 
computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/).
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most 
advanced algorithms to attract new users. 

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This dataset represents data collected from the accelerometers from the Samsung Galaxy S smartphone and is part of the following publication:

> Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
> Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.
> International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The dataset is also subjected to the follow license:

> This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse.
> Any commercial use is prohibited.

## The script run_analysis.R

The R script called `run_analysis.R` does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

It provides the function `get_rawdata()` for downloading the data set and
unzipping it in the folder specified by the parameter `destdir`. Just run:

```r
source( "./run_analysis.R" )
get_rawdata( destdir = "./data" )

run_analysis( datadir = ",/data" )
```

to download the data archive, processing the data, and creating the final tidy
data set that will be saved in the file named *tidydata.txt*.

The content of this text file can be visualised in RStudio by entering the
following commands:

```r
tidydata <- read.table( "tidydata.txt" )
View( tidy )
```

