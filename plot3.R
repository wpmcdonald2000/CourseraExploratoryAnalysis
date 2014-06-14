# Plot using base plotting system the total Emissions for each year in the dataset
# Load datasets from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# separate and aggregate the total sum of all Emissions data by year
baltEmissions<- NEI[NEI$fips == 24510,]
balttype <- aggregate(Emissions ~ type + year, data = baltCty, FUN = sum)

# open png file device, name file, initialize size
png(file="plot3.png",width=640,height=480)

# Calculate correlation of linear fit.
fit <- cor(balt_by_year$Category, balt_by_year$x)

# plot x
g <- ggplot(balttype, aes(year, Emissions))
g + geom_point() + facet_grid(. ~ type) + geom_smooth(method = "lm")

# turn off png file device
dev.off()
