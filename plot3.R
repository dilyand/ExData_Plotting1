################################################################################
# This script creates the file plot3.png, which is a required part of the      #
# submission for the Week 1 project of the Exploratory Data Analysis course.   #
#                                                                              #
# By default, the script assumes you already have a file called                #
# 'household_power_consumption.txt'                                            #
# in the current working directory.                                            #
#                                                                              #
# Uncomment the appropriate lines below to download the original dataset to    #
# the current working directory.                                               #
################################################################################



################################################################################
#
#        READING IN THE DATA


### Download and unzip the file. This works on a Windows machine. You might need
### to use the appropriate method on another OS.

 fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download the zip file in the current working directory.
 download.file(fileUrl, destfile = "./power_consumption.zip")

# Unzip the file in the current working directory.
 unzip("./power_consumption.zip", exdir = getwd())

### Read in the dataset.

# Load the data.table package.
if(!require("data.table")) {
  install.packages("data.table")
  library(data.table)
}

# Read in the data.
data <- fread("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")



################################################################################
#
#        TRANSFORMING THE DATA


# Subset the data.
data <- subset(data, data$Date == "1/2/2007" | data$Date == '2/2/2007')

# Load the dplyr package.
if(!require("dplyr")) {
  install.packages("dplyr")
  library(dplyr)
}

# Transform the table to a tibble.
data <- tbl_df(data)

# Load the `lubridate` package.
if(!require("lubridate")) {
  install.packages("lubridate")
  library(lubridate)
}

# Convert dates and times.
data$Date <- dmy(data$Date)
data$Time <- ymd_hms(paste(data$Date, " ", data$Time))




################################################################################
#
#        CREATING THE PLOT


# Plot the data and save it to a 480x480 .png file in the current working directory.
png(file = "plot3.png", bg = "transparent", antialias = "none")
with(data, plot(Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(data, lines(Time, Sub_metering_2, type = "l", col = "red"))
with(data, lines(Time, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.off()

# Print a message to the console.
print(paste("This script has now created a file called 'plot3.png'. Look for it in ", getwd(), "."))
