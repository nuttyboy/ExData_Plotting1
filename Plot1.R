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

# Note: We can either print the plot and then copy to a PNG file or plot it directly on a PNG file.
#using PNG graphics device to plot the required graph. Pixels set as suggested.
png(
    "Plot1.png",
    width = 480,
    height = 480,
    units = "px",
    bg = NA
)
hist(
    avgsub$Global_active_power,
    main = "Global Active Power",
    col = "Red",
    xlab = "Global Active Power (kilowatts)"
)
dev.off()

#Click on Source and the PNG output will be saved on your working directory
