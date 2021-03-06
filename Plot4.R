# Please note: this script loads a dataset called "household_power_consumption.txt"
# that should be present in the working directory of your R session.
#
# Required package: lubridate

# Load libraries
require(lubridate)

# Load data
Data <- read.table("household_power_consumption.txt", header = TRUE,sep = ";", na.strings ="?", skipNul = TRUE, colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
Data$ExtendedTime <- dmy_hms(paste(Data[,1],"",Data[,2]))
Data[,1] <- dmy(Data[,1])
Data[,2] <- hms(Data[,2])
Data <- Data[Data[,1]==dmy("01/02/2007")|Data[,1]==dmy("02/02/2007"),]

# Plot 4
png(file = "Plot4.png", width = 480, height = 480, units = "px")
par(mfcol = c(2, 2))
with(Data, plot(ExtendedTime, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", main = "", type="l"))
with(Data, plot(ExtendedTime, Sub_metering_1, ylab = "Energy sub metering", xlab = "", main = "", type="l"))
with(Data, lines(ExtendedTime, Sub_metering_2, main = "", type="l", col = "red"))
with(Data, lines(ExtendedTime, Sub_metering_3, main = "", type="l", col = "blue"))
legend("topright", lty = 1, col = c("black","blue", "red"), legend = c("Sub_metering_1 ","Sub_metering_2 ", "Sub_metering_3 "), bty="n")
with(Data, plot(ExtendedTime, Voltage, ylab = "Voltage", xlab = "datetime", main = "", type="l"))
with(Data, plot(ExtendedTime, Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", main = "", type="l"))
dev.off()
