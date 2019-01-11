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

### Convert Date/Time and Global Power to proper units
date_time <- lubridate::dmy_hms(paste(Electricity$Date, Electricity$Time, sep = " "))
global_power <- as.numeric(Electricity$Global.Active.Power)
global_reactive_power <- as.numeric(Electricity$Global.Reactive.Power)

### Set Graphical parameters, open graphical device
png("plot4.png", height = 480, width = 480)
par(mfrow = c(2, 2))

### Plot first graph (Global Active Power by Date/Time)
plot(date_time, global_power, type = "l", 
     ylab = "Global Active Power", xlab = "")
### Plot second graph (Voltage by Date/Time)
plot(date_time, Electricity$Voltage, type = "l", 
     ylab = "Global Active Power", xlab = "datetime")
### Plot third graph (Energy Sub Metering by Date/Time)
plot(date_time, Electricity$Sub.Metering.1, type = "1", ylab = "Energy Sub Metering", xlab = "")
        lines(date_time, Electricity$Sub.Metering.2, type = "l", col = "red")
        lines(date_time, Electricity$Sub.Metering.3, type = "l", col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("gray40", "red", "blue"), lty = 1, cex = .5)
### Plot fourth graph (Global Reactive Power by Time)
plot(date_time, global_reactive_power, type = "l", 
     ylab = "Global_reactive_power", xlab = "datetime")

### Close Graphics Device
dev.off()
