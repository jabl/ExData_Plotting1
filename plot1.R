read.hpc <- function() {
  # First get the column names
  t <- read.csv("household_power_consumption.txt", sep=";", nrows=1)
  # Then read the actual data we need
  d <- read.csv("household_power_consumption.txt", header=FALSE, skip=66637, 
           nrows=60*24*2, sep=";", na.strings="?",
           colClasses=c("character", "character", rep("numeric", 7)))
  # Fix column names
  colnames(d) <- colnames(t)
  # Create a new column with POSIXlt type, get rid of the two original ones
  ts <- paste(d$Date, d$Time)
  d$Date <- NULL
  d$Time <- NULL
  d$DateTime <- strptime(ts, "%d/%m/%Y %H:%M:%S")
  d
}

makeplot1 <- function() {
  png(filename="plot1.png")
  d <- read.hpc()
  hist(d$Global_active_power, main="Global active power", xlab="Global active power",
       col="red")
  dev.off()
}

makeplot1()