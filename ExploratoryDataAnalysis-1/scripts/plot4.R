plot4 <- function()
{
    data <- getdata( destdir = "./data" )
    data[, "DateTime"] <- as.POSIXct( paste( data$Date, data$Time ) )

    # switch to english (disable automatic translations)
    Sys.setlocale("LC_TIME", "C");

    print( "Plotting the image #4...", quote = FALSE )
    
    par( mfrow = c(2, 2), mar = c(4, 5, 3, 2), cex = 1 )
    with( data, {
        plot( data$Global_active_power ~ data$DateTime,
              type = "l",
              xlab = "", ylab = "Global Active Power" )
        plot( data$Voltage ~ data$DateTime,
              type = "l",
              xlab = "datetime", ylab = "Voltage" )
        plot( Sub_metering_1 ~ DateTime, type = "l",
              xlab = "", ylab = "Energy sub metering" )
        lines( Sub_metering_2 ~ DateTime, col = 'Red' )
        lines( Sub_metering_3 ~ DateTime, col = 'Blue' )
        legend( "topright", col = c( "black", "red", "blue" ),
                lty = 1, lwd = 1, bty = "n",
                legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))
        plot( data$Global_reactive_power ~ data$DateTime,
              type = "l",
              xlab = "datetime", ylab = "Global_reactive_power" )        
    })

    dev.copy( png, file = "plot4.png", height = 504, width = 504)
    dev.off()
}
