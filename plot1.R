#download and unzip data file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip", temp, method = "curl")
unzipped <- unzip(temp)

#read data file, subset for dates needed and convert Data/Time to POSIXct format
Power <- read.table("household_power_consumption.txt", header = TRUE, sep=";", colClasses = c("character", "character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric"), na.strings = "?")
Power <- subset(Power, Power$Date == "1/2/2007" | Power$Date == "2/2/2007")
Power$Time <- paste(Power$Date, Power$Time)
Power <- Power[,-1]
Power$Time <- as.POSIXct(Power$Time, format = "%d/%m/%Y %H:%M:%S")

#create plot 1
png("plot1.png", width = 480, height = 480)
hist(Power$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
