## Download the Data

filesPath <- "/Users/taejinjo/OneDrive/Data_Analytics/04.Exploratory Data Analysis/Week1/"
setwd(filesPath)
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

###Unzip DataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

##Load required packages
library(ggplot2)
library(lattice)
library(data.table)
library(dplyr)

##Files in folder ./data that will be used are:
##  household_power_consumption.txt

## Read the above files and create data tables.
filesPath <- "/Users/taejinjo/OneDrive/Data_Analytics/04.Exploratory Data Analysis/Week1/data/"

# Read subject files
dataPlot <- tbl_df(read.table(file.path(filesPath, "household_power_consumption.txt"), header = TRUE, sep = ";", colClasses = c("character", "character", rep("numeric", 7)),na = "?"))
dataPlot$Time <- strptime(paste(dataPlot$Date, dataPlot$Time), "%d/%m/%Y %H:%M:%S")
dataPlot$Date <- as.Date(dataPlot$Date, "%d/%m/%Y")
subDateData <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
subDataPlot <- subset(dataPlot, Date %in% subDateData)

# Plot 1
png(filename = "Plot1.png", width = 480, height = 480)
hist(subDataPlot$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

# Plot 2
png(filename = "Plot2.png", width = 480, height = 480)
plot(subDataPlot$Time, subDataPlot$Global_active_power, type = "l", xlab ="", ylab = "Global Active Power (kilowatts)")
dev.off()

# Plot 3
png(filename = "Plot3.png", width = 480, height = 480)
plot(subDataPlot$Time, subDataPlot$Sub_metering_1, type = "l", ylab = "Energy sub metering", col = "black")
lines(subDataPlot$Time, subDataPlot$Sub_metering_2, type = "l", ylab = "Energy sub metering", col = "red")
lines(subDataPlot$Time, subDataPlot$Sub_metering_3, type = "l", ylab = "Energy sub metering", col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=2, col=c("black", "red", "blue"))
dev.off()

# Plot 4
png(filename = "Plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))	
plot(subDataPlot$Time, subDataPlot$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(subDataPlot$Time, subDataPlot$Voltage, type = "l", xlab = "datetime", ylab = "Global Active Power")
plot(subDataPlot$Time, subDataPlot$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(subDataPlot$Time, subDataPlot$Sub_metering_2, type="l", col="red")
lines(subDataPlot$Time, subDataPlot$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=2, col=c("black", "red", "blue"))
plot(subDataPlot$Time, subDataPlot$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Active Power")
dev.off()
