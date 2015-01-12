library( data.table )
library( reshape2 )

## Download the zip archive containing the Samsung data and unzip it in the
## folder specified by 'destdir' (current directory by default).

get_rawdata <- function( destdir = "." ) {
    weburl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    ziparchive <- paste(destdir, "getdata-projectfiles-UCI-HAR-Dataset.zip", sep = "/" )

    if ( !file.exists( destdir ) )
        dir.create( destdir )

    print( "Downloading data...", quote = FALSE )
    download.file( weburl, ziparchive, "curl", quiet = TRUE )
    if ( !file.exists( ziparchive ) )
        stop( "Cannot download the zip archive... aborting" )

    print( "Uncompressing the archive..", quote = FALSE )
    unzip( ziparchive, exdir = destdir, junkpaths = TRUE )

    file.remove( ziparchive )
}

## Load the data sets from disc, merge the data, extract the measurements on
## the mean and standard deviation, labels the data set, creates a tidy data
## set with the average of each variable for each activity and each subject.
## Create the output file 'tidydata.txt'.

run_analysis <- function( datadir = "." ) {
    initDir <- getwd( )
    setwd( datadir )

    print( "Loading data from disc...", quote = FALSE )

    # dim( features )            561    2
    features <- read.table( "features.txt", stringsAsFactors = FALSE )

    # dim( training_set     )   7352  561
    #      training_labels      7352    1
    #      training_subject     7352    1
    training_set <- read.table( "X_train.txt" )
    training_labels <- read.table( "y_train.txt" )
    # subject_train.txt: each row identifies the subject who performed the
    #                    activity for each window sample. Number of subjects: 30
    training_subject <- read.table( "subject_train.txt" )

    # dim( test_set         )   2947  561
    #      test_labels          2947    1
    #      test_subject         2947    1
    test_set <- read.table( "X_test.txt" )
    test_labels <- read.table( "y_test.txt" )
    test_subject <- read.table( "subject_test.txt" )

    ## 1. Merges the training and the test sets to create one data set

    print( "Merging training and test data sets...", quote = FALSE )

    training_data <- cbind( training_subject, training_labels, training_set )
    test_data <- cbind( test_subject, test_labels, test_set )
    data <- rbind( training_data, test_data )

    colnames( data ) <- c( "subject", "activity", features[,2] )

    ## 2. Extracts only the measurements on the mean and standard deviation
    ##    for each measurement

    print( "Extracting measurements on the mean and standard deviation ...",
           quote = FALSE )
    data <- data[, grepl( "subject|activity|mean\\(\\)|std\\(\\)",
                         names( data ) )]

    ## 3. Uses descriptive activity names to name the activities in the data set

    print( "Using descriptive activity names to name the activities...",
           quote = FALSE )
    activity_labels <- read.table( "activity_labels.txt" )

    ## 4. Appropriately labels the data set with descriptive variable names

    print( "Appropriately labelling the data set...", quote = FALSE )
    data$activity <- factor( data$activity, labels = activity_labels[,2] )

    ## 5. From the data set in step 4, creates a second, independent tidy
    ##    data set with the average of each variable for each activity and
    ##    each subject

    print( "Creating a tidy data set with averages...", quote = FALSE )
    melted_data <- melt( data, id = c( "subject", "activity" ) )
    tidy_data <- dcast( melted_data, subject + activity ~ variable, mean )

    setwd( initDir )

    print( "Writing the output file tidydata.txt...", quote = FALSE )
    write.table( tidy_data, "tidydata.txt", row.names = FALSE, quote = FALSE )
}
