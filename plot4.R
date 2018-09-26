                # Code for plot4.png

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

        # merge both NEI and SCC
if(!exists("NEI_and_SCC")){
        NEI_and_SCC <- merge(NEI, SCC, by="SCC")
}

        # Take data coal Emission for each year for data which contains "coal" in Short.Name
coal_data <- with(NEI_and_SCC,grepl("coal",Short.Name,ignore.case=TRUE))
coal_NEI_and_SCC <- NEI_and_SCC[coal_data, ]

coal_per_Year <- aggregate(Emissions ~ year, coal_NEI_and_SCC, sum)

        # Plot it with ggplot

g <- ggplot(coal_per_Year, aes(year, Emissions)) + geom_line() + geom_point() + xlab("years") + ylab(expression("Total Coal Emission per years")) + ggtitle("Coal Emission per years")
print(g)

        # Save plot in png file and make dev.off()
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()