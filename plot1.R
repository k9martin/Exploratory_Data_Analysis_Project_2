                # Code for plot1.png

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


        # Take data of total PM2.5 for each year
aggregated_by_Year <- aggregate(Emissions ~ year, NEI, sum)

        # Barplot it (looks better than just plot, which is commented)
barplot(height=aggregated_by_Year$Emissions, names.arg=aggregated_by_Year$year, xlab="years", ylab=expression("total PM"[2.5]*""),main=expression("Total PM"[2.5]*" per years"))
# plot(aggregated_by_Year$year, aggregated_by_Year$Emissions, xlab="years", ylab="total PM"[2.5]*"", main="Total PM"[2.5]*" per years")

        # Save barplot (or plot) in png file and make dev.off()
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()