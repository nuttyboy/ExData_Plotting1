#Reading data from Working Directory
elecavg <- read.csv(
    "household_power_consumption.txt",
    sep = ";",
    na.strings = "?",
    colClasses = c("character", "character", rep("numeric", 7))
)

# Note: Date criteria can be used to subset, but better to read full data and subset later


#Converting first column to date format
elecavg$Date <- as.Date(elecavg$Date, "%d/%m/%Y")

#subsetting data based on Date required for plotting and removing NAs
avgsub <-
    na.omit(subset(elecavg, Date >= "2007-02-01" &
                       Date <= "2007-02-02"))


# Concatenate Date and Time Column
avgsub$Datetime <- paste(avgsub$Date, avgsub$Time, sep = " ")

# Convert the character to Date and Time
avgsub$Datetime <- strptime(avgsub$Datetime, "%Y-%m-%d %H:%M:%S")

# Note: We can either print the plot and then copy to a PNG file or plot it directly on a PNG file.
#using PNG graphics device to plot the required graph. Pixels set as suggested.
png(
    "Plot4.png",
    width = 480,
    height = 480,
    units = "px",
    bg = NA
)
par(mfrow = c(2, 2), mar = c(5, 4, 4, 2))
plot(
    avgsub$Datetime,
    avgsub$Global_active_power,
    type = "l",
    xlab = "",
    ylab = "Global Active Power"
)
plot(
    avgsub$Datetime,
    avgsub$Voltage,
    type = "l",
    xlab = "datetime",
    ylab = "Voltage"
)
plot(
    avgsub$Datetime,
    avgsub$Sub_metering_1,
    type = "l",
    xlab = "",
    ylab = "Energy Sub Metering"
)
points(avgsub$Datetime,
       avgsub$Sub_metering_2,
       type = "l",
       col = "red")
points(avgsub$Datetime,
       avgsub$Sub_metering_3,
       type = "l",
       col = "blue")
legend(
    "topright",
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    lty = 1,
    bty = "n",
    col = c("black", "red", "blue")
)
plot(
    avgsub$Datetime,
    avgsub$Global_reactive_power,
    type = "l",
    xlab = "datetime",
    ylab = "Global_reactive_power"
)
dev.off()

#Click on Source and the PNG output will be saved on your working directory
