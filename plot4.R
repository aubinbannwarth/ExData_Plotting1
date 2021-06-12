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

# We can now generate plot4.png. We open the png device and create the file:

png(filename = "plot4.png")

# We now set the mfcol argument of the par function to c(2,2),
# This will place the plots on a 2x2 grid and fill the grid column wise

par(mfcol = c(2, 2))

# We can just copy our previous code to create the two plots on the left:

# From plot2.R, we have the plot in position (1,1):
with(consumption, 
     plot(Time, 
          Global_active_power, 
          type = "l", 
          ylab = "Global Active Power (kilowatts)",
          xlab = ""))
# From plot3.R, the plot in position (2,1)
with(consumption,
     plot(Time, Sub_metering_1, 
          type = "l", xlab = "", ylab = "Energy sub metering"))

lines(consumption$Time, consumption$Sub_metering_2, col = "red")

lines(consumption$Time, consumption$Sub_metering_3, col = "blue")

# For the legend, we add the argument bty = "n" to remove the box.
legend("topright",
       col = c("black", "red", "blue"),
       lty = "solid",
       bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
)

# The plot in (1,2) is just a time series of Voltage:

with(consumption, 
     plot(Time, 
          Voltage, 
          type = "l", 
          ylab = "Voltage",
          xlab = "datetime"))

# The plot in (2,2) is a time series of Global_reactive_power:

with(consumption, 
     plot(Time, 
          Global_reactive_power, 
          type = "l", 
          ylab = "Global_reactive_power",
          xlab = "datetime"))

# Lastly, we close the device:

dev.off()