# Plot using base plotting system the total Emissions for each year in the dataset
# Load datasets from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# merge NEI and SCC
data <- merge(NEI[,c(1,2,4,6)],SCC[,c(1,4)])

# subset for LA and Baltimore
# baltEmissions <- data[data$fips == 24510,]
# laEmissions <- data[data$fips == 06037,]
bc <- grep("24510",data$fips)
la <- grep("06037", data$fips)
labc <- c(la, bc)
labc_Emissions <- data[labc,]

#subset for mobile only
labc_mobile <- grep( "Mobile" , labc_Emissions$EI.Sector)
labc_mobile_Emissions <- labc_Emissions[labc_mobile,]

# aggregate Emissions by year and fips
labc_agg <- aggregate(Emissions ~ year + fips, data = labc_mobile_Emissions, FUN = sum)

# open png file device, name file, initialize size
png(file="plot6.png",width=480,height=480)

# plot(labc_agg$year, labc_agg$Emissions, xlab = "Years", ylab = "Emissions (Tons)",
#     main = expression ("LA v Baltimore Mobile PM"[2.5]*" Particulate Emissions"))

qplot(year, Emissions, data = labc_agg, facets = .~ fips , 
      main = expression("LA(06037) v Baltimore(24510) Particulate PM"[2.5]*"Emissions"))

# turn off png file device
dev.off()