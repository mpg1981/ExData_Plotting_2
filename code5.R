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

### plot 5

subset <- NEI[NEI$fips == "24510", ] 

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "./plot5.png", 
    width = 480, height = 480, 
    units = "px")
motor <- grep("motor", SCC$Short.Name, ignore.case = T)
motor <- SCC[motor, ]
motor <- subset[subset$SCC %in% motor$SCC, ]
motorEmissions <- aggregate(motor$Emissions, list(motor$year), FUN = "sum")

plot(motorEmissions, type = "l", xlab = "Year", 
     main = "Total Emissions From Motor Vehicle Sources\n from 1999 to 2008 in Baltimore City", 
     ylab = expression('Total PM'[2.5]*" Emission"))

dev.off()