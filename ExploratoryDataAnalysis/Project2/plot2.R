# Explore the National Emissions Inventory database and see what it say about
# fine particulate matter pollution in the United states over the 10-year
# period 1999-2008

# Question 2.
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.

plot2 <- function( datadir = "." )
{
    NEI <- load_NEI_data( "data" )
    emissions <- aggregate( Emissions ~ year, NEI[ NEI$fips == 24510, ], sum )
    emissions$year <- as.factor(emissions$year )

    print( "Plotting the image #2...", quote = FALSE )

    par( mar = c(5, 5, 4, 1 ) )
    
    barplot( emissions$Emissions,
             col = "gray",
             xlab = "Year",
             ylab = expression( "Amount of " ~ PM[2.5] ~ " in tons" ),
             names.arg = emissions$year,
             cex.names = 0.75, cex.axis = 0.75,
             main = expression(
                 "Total emissions of " ~ PM[2.5] ~ " in the Baltimore City"), )

    lines( x = df.bar, y = emissions$Emissions / 2 )
    points( x = df.bar, y = emissions$Emissions / 2 )

    dev.copy( png, file = "plot2.png", height = 480, width = 480 )
    dev.off()
}
