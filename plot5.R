                # Code for plot5.png

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

        # Take only data from Baltimore and car emissions ("ON-ROAD")
Baltimore_Car <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]
aggregated_by_Year <- aggregate(Emissions ~ year, Baltimore_Car, sum)

        # Plot it with ggplot

g <- ggplot(aggregated_by_Year, aes(factor(year), Emissions)) + geom_bar(stat="identity") + xlab("years") + ylab(expression("Total Car Emission per years")) + ggtitle("Car Emission per years")
print(g)

        # Save plot in png file and make dev.off()
dev.copy(png, file="plot5.png", width=480, height=480)
dev.off()