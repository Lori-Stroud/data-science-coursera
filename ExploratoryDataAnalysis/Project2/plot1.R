# Explore the National Emissions Inventory database and see what it say about
# fine particulate matter pollution in the United states over the 10-year
# period 1999-2008

# Question 1.
# Have total emissions from PM2.5 decreased in the United States from 1999 to
# 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission
# from all sources for each of the years 1999, 2002, 2005, and 2008.

plot1 <- function( datadir = "." )
{
    NEI <- load_NEI_data( "data" )
    emissions <- aggregate( Emissions ~ year, NEI, sum )
    emissions$year <- as.factor(emissions$year )

    print( "Plotting the image #1...", quote = FALSE )

    par( mar = c(5, 5, 4, 1 ) )

    df.bar <- barplot(
                emissions$Emissions,
                col = "gray",
                xlab = "Year", ylab = expression( "Amount of " ~ PM[2.5] ),
                names.arg = emissions$year,
                cex.names = 0.75, cex.axis = 0.75,
                main = expression(
                     "Total emissions of " ~ PM[2.5] ~ " per year in tons" ), )

    lines( x = df.bar, y = emissions$Emissions / 2 )
    points( x = df.bar, y = emissions$Emissions / 2 )

    dev.copy( png, file = "plot1.png", height = 480, width = 480 )
    dev.off()
}
