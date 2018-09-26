                # Code for plot3.png

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

        # Take data only from Baltimore
Baltimore_NEI  <- NEI[NEI$fips=="24510", ]

        # Take data of total PM2.5 for each year but now type is also taken
by_Year_and_Type_Baltimore <- aggregate(Emissions ~ year + type, Baltimore_NEI, sum)

        # Plot it with ggplot

g <- ggplot(by_Year_and_Type_Baltimore, aes(year, Emissions, color = type)) + geom_line() + xlab("years") + ylab(expression("Total PM"[2.5]*" per years")) + ggtitle("Baltimore PM25 per years and type")
print(g)

        # Save plot in png file and make dev.off()
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()