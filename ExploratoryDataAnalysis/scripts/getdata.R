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
    download.file( weburl, ziparchive, "curl", quiet = TRUE )
    if ( !file.exists( ziparchive ) )
        stop( "Cannot download the zip archive... aborting" )

    print( "Uncompressing the archive..", quote = FALSE )
    archive_info <- unzip( ziparchive, exdir = destdir, list = TRUE )
    file.remove( ziparchive )

    archive_info
}

load_datafile <- function( datafile, fromDate, toDate )
{
    data <- read.csv( datafile, sep = ';', na.string = ';',
                      stringsAsFactor = FALSE )
    data$Date <- as.Date( data$Date, format = "%d/%m/%Y" )
    data <- subset( data, subset = ( Date >= fromDate & Date <= toDate ) )
}

getdata <- function( destdir = "." )
{
    archive_info <- get_datafile( destdir = "./data" )

    print( "Loading the CSV file..." )
    datafile <- paste( destdir, archive_info$Name, sep = '/' )
    fromDate <- "2007-02-01"; toDate <- "2007-02-02"
    data <- load_datafile( datafile, fromDate, toDate )
}
