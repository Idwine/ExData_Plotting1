
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
png(file = "plot4.png")

# draw graphs
par(mfrow = c(2,2))
with(power_cons, {
    # first graph
    plot(DateTime, Global_active_power, 
                type = "l", xlab = "", ylab = "Global active power (kilowatts)")

    # second graph
    plot(DateTime, Voltage, type = "l", xlab = "")

    # third graph
    plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
    lines(DateTime, Sub_metering_2, type = "l", col = "red")
    lines(DateTime, Sub_metering_3, type = "l", col = "blue")
    legend("topright", pch = "-", col = c("black", "red", "blue"), 
               legend = c("sub metering 1", "sub metering 2", "sub metering 3"))
    
    # fourth graph
    plot(DateTime, Global_reactive_power, type = "l", xlab = "", ylab = "Global reactive power")
})

# close file
dev.off()

