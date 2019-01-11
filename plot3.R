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

### Convert Date/Time to proper units
date_time <- lubridate::dmy_hms(paste(Electricity$Date, Electricity$Time, sep = " "))


### Create plot and fill in with corresponding lines
png("plot3.png", width = 480, height = 480)
plot(date_time, Electricity$Sub.Metering.1, type = "1", ylab = "Energy Sub Metering", xlab = "")
lines(date_time, Electricity$Sub.Metering.2, type = "l", col = "red")
lines(date_time, Electricity$Sub.Metering.3, type = "l", col = "blue")
### Create legend for completed line graph
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("gray40", "red", "blue"), lty = 1)
dev.off()
