read.hpc <- function() {
  # First get the column names
  t <- read.csv("household_power_consumption.txt", sep=";", nrows=1)
  # Then read the actual data we need
  d <- read.csv("household_power_consumption.txt", header=FALSE, skip=66637, 
           nrows=60*24*2, sep=";", na.strings="?",
           colClasses=c("character", "character", rep("numeric", 7)))
  # Fix column names
  colnames(d) <- colnames(t)
  # Create a new datetime column with POSIXlt type, get rid of the two
  # original date and time ones
  ts <- paste(d$Date, d$Time)
  d$Date <- NULL
  d$Time <- NULL
  d$datetime <- strptime(ts, "%d/%m/%Y %H:%M:%S")
  d
}

makeplot4 <- function() {
  # Plot to file, by default 480x480 pixels which is what we want so no need to
  # specify dimensions explicitly
  png(filename="plot4.png")
  d <- read.hpc()
  par(mfrow=c(2,2))
  with(d, {
    # top left
    plot(datetime, Global_active_power, main="", xlab="",
         ylab="Global Active Power", type="l")
    
    # top right
    plot(datetime, Voltage, type="l")
    
    # bottom left
    plot(datetime, Sub_metering_1, main="", xlab="",
         ylab="Energy sub metering", type="l")
    mycol <- c("black", "red", "blue")
    lines(datetime, Sub_metering_2, col=mycol[2])
    lines(datetime, Sub_metering_3, col=mycol[3])
    legend("topright", lty=c(1,1,1), col=mycol, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    # bottom right
    plot(datetime, Global_reactive_power, type="l")
  })
  dev.off()
}

makeplot4()