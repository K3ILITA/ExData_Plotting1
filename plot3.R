
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



# 4. PLOT 3: ENERGY SUB-METERING
# ==================================================

# Open PNG graphics device
png("plot3.png", width = 480, height = 480)

# Plot the first energy sub-metering measurement
plot(
  data$DateTime,
  data$Sub_metering_1,
  type = "l",
  col = "black",
  xlab = "",
  ylab = "Energy sub metering",
  xaxt = "n"
)

# Add the second energy sub-metering measurement
lines(
  data$DateTime,
  data$Sub_metering_2,
  col = "red"
)

# Add the third energy sub-metering measurement
lines(
  data$DateTime,
  data$Sub_metering_3,
  col = "blue"
)

# Add weekday labels
axis.POSIXct(
  1,
  at = as.POSIXct(
    c("2007-02-01", "2007-02-02", "2007-02-03"),
    tz = "America/Chicago"
  ),
  labels = c("Thu", "Fri", "Sat")
)

# Identify the three energy sub-metering measurements
legend(
  "topright",
  legend = c(
    "Sub_metering_1",
    "Sub_metering_2",
    "Sub_metering_3"
  ),
  col = c("black", "red", "blue"),
  lty = 1,
  bty = "n"
)

# Save the energy sub-metering plot
dev.off()


