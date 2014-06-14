# Plot using base plotting system the total Emissions for each year in the dataset
# Load datasets from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# merge NEI and SCC
data <- merge(NEI[,c(2,4,6)],SCC[,c(1,4)])

# search sector rows related to coal combustion
coaldata <- grep("Coal|Lignite & Combustion", data$EI.Sector)
coalEmissions <- data[coaldata,]
c <- aggregate(coalEmissions$Emissions, by = list(Category = coalEmissions$year), FUN = sum)
 
# open png file device, name file, initialize size
png(file="plot4.png",width=480,height=480)

plot(c, type = 'l', xlab = "Years", ylab = "Emissions (Tons)",
     main = expression ("US Annual PM"[2.5]*" Particulate Emissions from Coal Combustion"))

# turn off png file device     
dev.off()
