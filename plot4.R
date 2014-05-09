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

#create plot 4
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

#panel 1
plot(Power$Time, Power$Global_active_power, type= "n", xlab = "", ylab = "Global Active Power")
lines(Power$Time, Power$Global_active_power)

#panel 2
plot(Power$Time, Power$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
lines(Power$Time, Power$Voltage)

#panel 3
plot(Power$Time, Power$Sub_metering_1, type= "n", xlab = "", ylab = "Energy sub metering")
lines(Power$Time, Power$Sub_metering_1)
lines(Power$Time, Power$Sub_metering_2, col="red")
lines(Power$Time, Power$Sub_metering_3, col="blue")
legend(x="topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1), bty="n")

#panel 4
plot(Power$Time, Power$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(Power$Time, Power$Global_reactive_power)

dev.off()