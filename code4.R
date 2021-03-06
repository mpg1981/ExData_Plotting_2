setwd(D:/INFOR/Обучалки/Data Science Specialization/010-Exploratory Data Analysis/cource progect 2)

unzip("./exdata-data-NEI_data.zip")

# Check if both data exist. If not, load the data.
if (!"NEI" %in% ls()) {
        NEI <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
        SCC <- readRDS("Source_Classification_Code.rds")
}
head(NEI)
head(SCC)
dim(NEI) # 6497651   6
dim(SCC) # 11717    15
print(object.size(NEI), units = "MB") # 425.5 Mb

### plot 4

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "./plot4.png", 
    width = 480, height = 480, 
    units = "px")
coal <- grep("coal", SCC$Short.Name, ignore.case = T)
coal <- SCC[coal, ]
coal <- NEI[NEI$SCC %in% coal$SCC, ]

coalEmissions <- aggregate(coal$Emissions, list(coal$year), FUN = "sum")
# options(scipen=0)
# options(scipen=999)
plot(coalEmissions, type = "l", xlab = "Year", 
     main = "Total Emissions From Coal Combustion-related\n Sources from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"))

dev.off()