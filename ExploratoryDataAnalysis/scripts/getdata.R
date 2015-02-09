## Download the zip archive containing the Electric Power Consumption
## data set and unzip it in the folder specified by 'destdir'
## (current directory by default).

get_datafile <- function( destdir = "." )
{
    website <- "https://d396qusza40orc.cloudfront.net"
    webfile <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
    weburl <- paste(website, webfile, sep = "/")

    destfile <- "data-household-power-consumption.zip"

    ziparchive <- paste(destdir, destfile, sep = "/" )

    if ( !file.exists( destdir ) )
        dir.create( destdir )

    print( "Downloading data...", quote = FALSE )

    switch( Sys.info()[[ 'sysname' ]],
            Windows = { download_method = "internal" },
            { download_method = "curl" }
    )
    download.file( weburl, ziparchive, download_method, quiet = TRUE )

    print( "Uncompressing the archive..", quote = FALSE )
    archive_info <- unzip( ziparchive, exdir = destdir, list = TRUE )
    file.remove( ziparchive )

    archive_info
}

## Load the data set (CSV format) and returns the dataframe 'data'

load_datafile <- function( datafile, fromDate, toDate )
{
    data <- read.csv( datafile, sep = ';', na.string = '?',
                      stringsAsFactor = FALSE )

    data$Date <- as.Date( data$Date, format = "%d/%m/%Y" )
    data <- subset( data, subset = ( Date >= fromDate & Date <= toDate ) )
}

## Helper function that downloads and unzipps the Electric Power Consumption
## data set and return the required dataframe

getdata <- function( destdir = "." )
{
    archive_info <- get_datafile( destdir = "./data" )

    print( "Loading the CSV file..." )
    datafile <- paste( destdir, archive_info$Name, sep = '/' )

    # select the data from the dates 2007-02-01 and 2007-02-02
    fromDate <- "2007-02-01"; toDate <- "2007-02-02"
    data <- load_datafile( datafile, fromDate, toDate )
}
