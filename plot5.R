# Plot using base plotting system the total Emissions for each year in the dataset
# Load datasets from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# merge NEI and SCC
data <- merge(NEI[,c(1,2,4,6)],SCC[,c(1,4)])

# subset for baltimore city
baltEmissions<- data[data$fips == 24510,]

#subset for mobile only
x <- grep("Mobile", baltEmissions$EI.Sector)
balt_mobile_Emissions <- baltEmissions[x,]

# aggregate by year
c <- aggregate(balt_mobile_Emissions$Emissions, by = list(Category = balt_mobile_Emissions$year), FUN = sum)

# open png file device, name file, initialize size
png(file="plot5.png",width=480,height=480)

plot(c, type = 'l', xlab = "Years", ylab = "Emissions (Tons)",
     main = expression ("Baltimore City Annual Mobile PM"[2.5]*" Particulate Emissions"))

# turn off png file device
dev.off()