# Dear Reviewer, the first 46 lines of code will identical for the 4 scripts:
# they are used to import the data and prepare it for plotting.

# Feel free to skip ahead after you've checked it once.

# We first construct a character vector named classes.
# This tells R the correct class for each column in the data frame
# classes should have length 9 as there are 9 columns:

classes <- vector("character", 9)

# Columns 1 and 2 will be read as characters:

classes[1:2] <- "character"

# Columns 3 to 9 are numeric:

classes[3:9] <- "numeric"

# After opening the txt file, we see that the separator is ";"
# We are also told that "?" is used to represent missing values.
# We therefore put the data into a variable "consumption", 
# making sure to pass the correct values for "na.strings", "sep" and 
# "colClasses" to the read.csv function.

consumption <- read.csv("household_power_consumption.txt", 
                        na.strings = "?", sep = ";", colClasses = classes)

# Next, we transform the date and time columns to date and time classes.
# We'll first transform the Time column so it contains the full date and time:

consumption <- transform(consumption, 
                         Time = paste(consumption$Date, consumption$Time))

# Next, we'll convert this from a character to an object of class POSIXlt:

consumption <- transform(consumption,
                         Time = strptime(consumption$Time, format = "%d/%m/%Y %H:%M:%S"))
# Similarly we convert the Date column to the correct class:
consumption <- transform(consumption,
                         Date = as.Date(consumption$Date, format = "%d/%m/%Y")) 

# We may now select only the relevant dates by using subset():

consumption <- subset(consumption,
                      Date %in% as.Date(c("2007-02-01", "2007-02-02")))

# We can now create the time series of the sub_metering variables.
# First, we open the png device and create plot3.png:

png(filename = "plot3.png")

# We first plot the time series of Sub_metering_1, and add the y-axis label:

with(consumption,
     plot(Time, Sub_metering_1, 
          type = "l", xlab = "", ylab = "Energy sub metering"))

# Next, add Sub_metering_2 in red:

lines(consumption$Time, consumption$Sub_metering_2, col = "red")

# Sub_metering_3 in blue:

lines(consumption$Time, consumption$Sub_metering_3, col = "blue")

# And the legend:

legend("topright",
       col = c("black", "red", "blue"),
       lty = "solid",
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       )

# Close the png device:

dev.off()
