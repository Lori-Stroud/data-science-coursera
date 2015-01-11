get_webdata <- function( destdir = ".", quiet = FALSE ) {
    weburl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    ziparchive <- paste(destdir, "getdata-projectfiles-UCI HAR Dataset.zip", sep = "/" )

    if ( !file.exists( destdir ) )
        dir.create( destdir )

    if( !quiet )
        print( "downloading data..." )
    download.file( weburl, ziparchive, "curl", quiet = TRUE )

    if( !quiet )
        print( "uncompressing the archive.." )
    unzip( ziparchive, exdir = destdir, junkpaths = TRUE )
    
    file.remove( ziparchive )
}

get_samsung_data(destdir = "./data")
