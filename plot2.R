# Plot using base plotting system the total Emissions for each year in the dataset
# Load datasets from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# separate and aggregate the total sum of all Emissions data by year
baltEmissions<- NEI[NEI$fips == 24510,]
balt_by_year <- aggregate(baltEmissions$Emissions, by = list(Category = baltEmissions$year), FUN = sum)

# open png file device, name file, initialize size
png(file="plot2.png",width=480,height=480)

# Calculate correlation of linear fit.
fit <- cor(balt_by_year$Category, balt_by_year$x)

# plot x
plot(balt_by_year, xlab = "Years",ylab = "Emissions (thousand tons)", 
     main = expression ("Baltimore Total Annual PM"[2.5]*" Particulate Emissions"))
abline(lm(x ~ Category, data = balt_by_year))
legend('bottomleft', c("linear correlation = ",fit))

# turn off png file device
dev.off()
