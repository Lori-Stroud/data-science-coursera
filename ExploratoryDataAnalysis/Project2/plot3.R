# Explore the National Emissions Inventory database and see what it say about
# fine particulate matter pollution in the United states over the 10-year
# period 1999-2008

# Question 3.
# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in 
# emissions from 1999-2008 for Baltimore City?
# Which have seen increases in emissions from 1999-2008?
# Use the ggplot2 plotting system to make a plot answer this question

library(ggplot2)

plot3 <- function( datadir = "." )
{
    NEI <- load_NEI_data( "data" )
    data <- aggregate( Emissions ~ year + type,
                       NEI[ NEI$fips == 24510, ], sum )

    print( "Plotting the image #3...", quote = FALSE )

    qplot( year, Emissions, data = data, facets = . ~ type,
           geom = c( "point", "smooth" ), method = "lm",
           xlab = "Year", ylab = "Emissions for Baltimore City",
           ggtitle( "Emissions for Baltimore City divided by type" ) )

    dev.copy( png, file = "plot3.png", height = 480, width = 640 )
    dev.off()
}
