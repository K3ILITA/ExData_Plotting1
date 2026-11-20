
# Exploratory Data Analysis - Course Project 1
# Household Electric Power Consumption
# February 1-2, 2007
#
# Objective:
# Examine household electricity consumption using
# four plots created with the base R graphics system.


# ==================================================
# 1. DOWNLOAD AND PREPARE DATA
# ==================================================

# Download the dataset if it is not already available
data_url <- paste0(
  "https://d396qusza40orc.cloudfront.net/",
  "exdata%2Fdata%2Fhousehold_power_consumption.zip"
)

if (!file.exists("household_power_consumption.txt")) {
  
  if (!file.exists("household_power_consumption.zip")) {
    download.file(
      data_url,
      destfile = "household_power_consumption.zip",
      mode = "wb"
    )
  }
  
  # Extract the dataset
  unzip("household_power_consumption.zip")
}

# Read the household power consumption dataset
power_data <- read.table(
  "household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

# Filter data for February 1 and 2, 2007
data <- subset(
  power_data,
  Date %in% c("1/2/2007", "2/2/2007")
)

# Convert date and time into a single POSIXct variable
data$DateTime <- as.POSIXct(
  paste(data$Date, data$Time),
  format = "%d/%m/%Y %H:%M:%S"
)

# Sort observations chronologically
data <- data[order(data$DateTime), ]

# Verify the dataset contains 2880 observations
print(dim(data))



# 5. PLOT 4: FOUR-PANEL POWER CONSUMPTION OVERVIEW
# ==================================================

# Open PNG graphics device
png("plot4.png", width = 480, height = 480)

# Divide the plotting area into four panels
par(mfrow = c(2, 2))

# --------------------------------------------------
# Upper-left: Global Active Power
# --------------------------------------------------

plot(
  data$DateTime,
  data$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power"
)

# --------------------------------------------------
# Upper-right: Voltage
# --------------------------------------------------

plot(
  data$DateTime,
  data$Voltage,
  type = "l",
  xlab = "",
  ylab = "Voltage"
)

# --------------------------------------------------
# Bottom-left: Energy Sub-Metering
# --------------------------------------------------

# Plot the first sub-metering measurement
plot(
  data$DateTime,
  data$Sub_metering_1,
  type = "l",
  col = "black",
  xlab = "",
  ylab = "Energy sub metering"
)

# Overlay the second measurement
lines(
  data$DateTime,
  data$Sub_metering_2,
  col = "red"
)

# Overlay the third measurement
lines(
  data$DateTime,
  data$Sub_metering_3,
  col = "blue"
)

# Add a smaller legend for the four-panel layout
legend(
  "topright",
  legend = c(
    "Sub_metering_1",
    "Sub_metering_2",
    "Sub_metering_3"
  ),
  col = c("black", "red", "blue"),
  lty = 1,
  bty = "n",
  cex = 0.6
)

# --------------------------------------------------
# Bottom-right: Global Reactive Power
# --------------------------------------------------

plot(
  data$DateTime,
  data$Global_reactive_power,
  type = "l",
  xlab = "",
  ylab = "Global Reactive Power"
)

# Save the four-panel plot
dev.off()


