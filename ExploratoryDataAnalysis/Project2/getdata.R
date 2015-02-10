## Download the zip archive containing the National Emissions Inventory (NEI)
## data set and unzip it in the folder specified by 'destdir'
## (current directory by default).

get_datafiles <- function( destdir = "." )
{
    website <- "https://d396qusza40orc.cloudfront.net"
    webfile <- "exdata%2Fdata%2FNEI_data.zip"
    weburl <- paste(website, webfile, sep = "/")

    destfile <- "data-FNEI_data.zip"

    ziparchive <- paste(destdir, destfile, sep = "/" )

    if ( !file.exists( destdir ) )
        dir.create( destdir )

    print( "Downloading data...", quote = FALSE )

    switch( Sys.info()[[ 'sysname' ]],
            Windows = { download_method = "internal" },
            { download_method = "curl" }
    )
    download.file( weburl, ziparchive, download_method, quiet = TRUE )

    if ( !file.exists( ziparchive ) )
        stop( "Cannot download the zip archive... aborting" )

    print( "Uncompressing the archive..", quote = FALSE )
    archive_info <- unzip( ziparchive, exdir = destdir, list = TRUE )
    #file.remove( ziparchive )

    archive_info
}

## Load the SCC RDS database and returns the dataframe 'SCC'
#  File: Source_Classification_Code.rds
#
#  This table provides a mapping from the SCC digit strings in the 
#  Emissions table to the actual name of the PM2.5 source

load_SCC_data <- function( datadir = "." )
{
    print( "Loading the Source Classification Code Table ...", quote = FALSE )
    SCCdbfile <- paste( datadir, "Source_Classification_Code.rds", sep = '/' )
    SCC <- readRDS(SCCdbfile)
}

## Load the SCC RDS database and returns the dataframe 'SCC'
#  File: summarySCC_PM25.rds
#
#  This file contains a data frame with all of the PM2.5 emissions data
#  for 1999, 2002, 2005, and 2008

load_NEI_data <- function( datadir = "." )
{
    print( "Loading the PM2.5 Emissions Data ...", quote = FALSE )
    NEIdbfile <- paste( datadir, "summarySCC_PM25.rds", sep = '/' )
    NEI <- readRDS(NEIdbfile)
}
