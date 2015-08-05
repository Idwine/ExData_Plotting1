
# load, unzip and open the first two days of february 2007 from the datafile
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
power_cons <- read.table(unzip(temp), sep = ";", skip = 66637, nrow = 2880, na.strings = "?",
                         col.names = colnames(read.table(unzip(temp), sep =";", nrow=1, header=TRUE)))
unlink(temp)
rm(temp)

# create file to write to
png(file = "plot1.png")

# draw histogram of 'Global Active Power'
with(power_cons, hist(Global_active_power, 
                      col = "purple",                                                  # color
                      main = "Global Active Power",                                    # title
                      xlab = "Global active power (kilowatts)", ylab = "Frequency"))   # label names
# close file
dev.off()