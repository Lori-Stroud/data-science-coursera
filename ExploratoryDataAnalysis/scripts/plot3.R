plot3 <- function()
{
    data <- getdata( destdir = "./data" )
    data[, "DateTime"] <- as.POSIXct( paste( data$Date, data$Time ) )

    # switch to english (disable automatic translations)
    Sys.setlocale("LC_TIME", "C");

    print( "Plotting the image #3...", quote = FALSE )

    par( mar = c( 5, 6, 4, 4 ) )
    with( data, {
          plot( Sub_metering_1 ~ DateTime, type = "l",
                xlab = "", ylab = "Energy sub metering" )
          lines( Sub_metering_2 ~ DateTime, col = 'Red' )
          lines( Sub_metering_3 ~ DateTime, col = 'Blue' )
    })
    legend( "topright", col = c( "black", "red", "blue" ),
            lty = 1, lwd = 2,
            legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))
    
    dev.copy( png, file = "plot3.png", height = 480, width = 480)
    dev.off()
}
