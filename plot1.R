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

# After opening the .txt file, we see that the separator is ";"
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

# We can now plot the histogram of Global active power.
# First, we open the png device and create plot1.png:

png(filename = "plot1.png")

# Make the histogram, adding title and labels:

hist(consumption$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     ylab = "Frequency",
     xlab = "Global Active Power (kilowatts)" )

# Finally, we close the png device:

dev.off()


