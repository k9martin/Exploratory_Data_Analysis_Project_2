                # Code for plot2.png

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

        # Take data of total PM2.5 for each year
by_Year_Baltimore <- aggregate(Emissions ~ year, Baltimore_NEI, sum)

        # Barplot it (looks better than just plot, which is commented)
barplot(height=by_Year_Baltimore$Emissions, names.arg=by_Year_Baltimore$year, xlab="years", ylab=expression("total PM"[2.5]*""),main=expression("Baltimore PM"[2.5]*" per years"))
# plot(by_Year_Baltimore$year, by_Year_Baltimore$Emissions, xlab="years", ylab="total PM"[2.5]*"", main="Baltimore PM"[2.5]*" per years")

        # Save barplot (or plot) in png file and make dev.off()
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()