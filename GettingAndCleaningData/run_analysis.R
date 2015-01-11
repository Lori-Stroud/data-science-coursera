## Download the zip archive containing the Samsung data and unzip it in the
## folder specified by 'destdir' (current directory by default)

get_rawdata <- function( destdir = "." ) {
    weburl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    ziparchive <- paste(destdir, "getdata-projectfiles-UCI-HAR-Dataset.zip", sep = "/" )

    if ( !file.exists( destdir ) )
        dir.create( destdir )

    print( "Downloading data...", quote = FALSE )
    download.file( weburl, ziparchive, "curl", quiet = TRUE )

    print( "Uncompressing the archive..", quote = FALSE )
    unzip( ziparchive, exdir = destdir, junkpaths = TRUE )

    file.remove( ziparchive )
}
