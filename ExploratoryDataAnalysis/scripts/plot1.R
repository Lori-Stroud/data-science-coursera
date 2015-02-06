plot1 <- function()
{
    data <- getdata( destdir = "./data" )

    print( "Plotting the image #1...", quote = FALSE )

    hist( data$Global_active_power,
          main = "Global Active Power",
          xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
          col = "Red" )

    dev.copy( png, file = "plot1.png", height = 504, width = 504 )
    dev.off()
}
