                # Code for plot6.png

        # Library for plotting
library(ggplot2)

        # First download file in actual directory if it is not downloaded
path <- file.path(getwd(), "zipfile")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if (!file.exists(path)) {
        download.file(url, path, mode = "wb")
}

        # Unzip file if it is not unzipped yet 
unzipped <- file.path(getwd(), "summarySCC_PM25.rds")

if (!file.exists(unzipped)) {
        unzip(path)
}

        # Read both rds and save them into variables if they are not defined yet
NEI_PATH <- file.path(getwd(),"summarySCC_PM25.rds")
if (!exists("NEI")){
        NEI <- readRDS(NEI_PATH)
}

SCC_PATH <- file.path(getwd(),"Source_Classification_Code.rds")

if(!exists("SCC")){
        SCC <- readRDS(SCC_PATH)
}

        # Take data from Baltimore and LA for car emissions ("ON-ROAD")
Baltimore_LA_Car <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]
aggregated_by_Year <- aggregate(Emissions ~ year + fips, Baltimore_LA_Car, sum)
aggregated_by_Year$fips[aggregated_by_Year$fips=="24510"] <- "Baltimore"
aggregated_by_Year$fips[aggregated_by_Year$fips=="06037"] <- "LA"

        # Plot it with ggplot

g <- ggplot(aggregated_by_Year, aes(year, Emissions, col = fips)) + geom_line() + geom_point() + xlab("years") + ylab(expression("Total Car Emission per years")) + ggtitle("Car Emission per years in Baltimore and LA")
print(g)

        # Save plot in png file and make dev.off()
dev.copy(png, file="plot6.png", width=480, height=480)
dev.off()