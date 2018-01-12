# This works on a Windows machine. You might need to use the appropriate method on another OS.

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download the zip file in the current working directory.
download.file(fileUrl, destfile = "./power_consumption.zip")

# Unzip the file in the current working directory.
unzip("./power_consumption.zip", exdir = getwd())

# Load the data.table package.
if(!require("data.table")) {
  install.packages("data.table")
  library(data.table)
}

# Read in the data.
data <- fread("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Subset the data.
data <- subset(data, data$Date == "1/2/2007" | data$Date == '2/2/2007')

# Load the dplyr package.
if(!require("dplyr")) {
  install.packages("dplyr")
  library(dplyr)
}

# Transform the table to a tibble
data <- tbl_df(data)

# Load the `lubridate` package.
if(!require("lubridate")) {
  install.packages("lubridate")
  library(lubridate)
}

# Convert dates.
data$Date <- dmy(data$Date)

# Plot the data and save it to a 480x480 .png file.
png(file = "plot1.png", bg = "transparent", antialias = "none")
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
