
# load, unzip and open the first two days of february 2007 from the datafile
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
power_cons <- read.table(unzip(temp), sep = ";", skip = 66637, nrow = 2880, na.strings = "?",
                         col.names = colnames(read.table(unzip(temp), sep =";", nrow=1, header=TRUE)))
unlink(temp)
rm(temp)

# create 1 variable with date and time of POSIXct class
library(lubridate)
power_cons$DateTime <- dmy(power_cons$Date)+hms(power_cons$Time)

# create file to write to
png(file = "plot3.png")

# draw graph
with(power_cons, plot(DateTime, Sub_metering_1, type = "l", 
                      xlab = "", ylab = "Energy sub metering"))
with(power_cons, lines(DateTime, Sub_metering_2, type = "l", col = "red"))
with(power_cons, lines(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", pch = "-", col = c("black", "red", "blue"), 
                      legend = c("sub metering 1", "sub metering 2", "sub metering 3"))     
# close file
dev.off()

