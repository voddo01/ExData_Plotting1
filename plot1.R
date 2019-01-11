### Download and Unzip Files
library(tidyverse)
path <- getwd()
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url = fileURL, destfile = "household_power_consumption.zip")
unzip(zipfile = "household_power_consumption.zip")

### Read File into R
columns <- c("Date", "Time", "Global Active Power", 
             "Global Reactive Power", "Voltage", "Global Intensity",
             "Sub Metering 1", "Sub Metering 2", "Sub Metering 3")

CleanPower <-  read.table(file = "household_power_consumption.txt", 
                          header = FALSE, sep = ";", 
                          col.names = columns, na.strings = "?", skip = 1)

### Filter for the necessary dates
Electricity <- filter(CleanPower, Date == "1/2/2007" | Date == "2/2/2007")

### Write histogram to .png file
png("plot1.png", height = 480, width = 480)
hist(Electricity$Global.Active.Power, breaks = 13, main = "Global Active Power", 
        xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "orangered2")
dev.off()
