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
  d$DateTime <- strptime(ts, "%d/%m/%Y %H:%M:%S")
  d
}

makeplot2 <- function() {
  # Plot to file, by default 480x480 pixels which is what we want so no need to
  # specify dimensions explicitly
  png(filename="plot2.png")
  d <- read.hpc()
  plot(d$DateTime, d$Global_active_power, main="", xlab="",
       ylab="Global Active Power (kilowatts)", type="l")
  dev.off()
}

makeplot2()