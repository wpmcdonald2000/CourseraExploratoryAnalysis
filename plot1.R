# Plot using base plotting system the total Emissions for each year in the dataset
# Load datasets from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# aggregate the total sum of all Emissions data by year
Emissions_total <- aggregate(NEI$Emissions, by = list(Category = NEI$year), FUN = sum)
# print results
Emissions_total

# open png file device, name file, initialize size
png(file="plot1.png",width=480,height=480)

# Calculate correlation of linear fit.
fit <- cor(Emissions_total$Category, Emissions_total$x)

# plot x
plot(Emissions_total, xlab = "Years", yaxt = 'n',ylab = "Emissions (million tons)", 
     main = expression ("Total Annual PM"[2.5]*" Particulate Emissions"))
abline(lm(x ~ Category, data = Emissions_total))
axis(2, at=axTicks(2), labels = c(.4,.5,.6,.7))
legend('topright', c("linear correlation = ",fit))

# turn off png file device
dev.off()
