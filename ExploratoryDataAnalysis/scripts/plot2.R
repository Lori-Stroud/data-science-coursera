plot2 <- function()
{
    # switch to english (disable automatic translations)
    Sys.setlocale("LC_TIME", "C");

    data <- getdata( destdir = "./data" )
    data[, "DateTime"] <- as.POSIXct( paste( data$Date, data$Time ) )

    print( "Plotting the image #2...", quote = FALSE )

    par( mar=c( 5, 6, 4, 4 ) )
    plot( data$Global_active_power ~ data$DateTime,
          type = "l",
          xlab = "", ylab = "Global Active Power (kilowatts)" )

    dev.copy( png, file = "plot2.png", height = 480, width = 480)
    dev.off()
}
