## Loading the data
setwd("C:/Users/kahan/OneDrive/Desktop/GIPE/Sem VI/MA")

download.file("https://github.com/Kahani13/ExData_Plotting1/raw/refs/heads/master/exdata_data_household_power_consumption.zip", 
              destfile = "exdata_data_household_power_consumption.zip")

data <- read.table(unz("exdata_data_household_power_consumption.zip", 
                       "household_power_consumption.txt"), 
                   header = TRUE, sep = ";", na.strings = "?")

## Filter for Feb 1–3
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

subset_data <- subset(data,
                      Date >= as.Date("2007-02-01") &
                        Date <= as.Date("2007-02-02"))

## DateTime variable
subset_data$DateTime <- strptime(
  paste(subset_data$Date, subset_data$Time),
  format="%Y-%m-%d %H:%M:%S"
)

## Plot 2
png("plot2.png", width = 480, height = 480)

plot(subset_data$DateTime,
     subset_data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     xaxt = "n")   # suppress default x-axis

## Manually add Thu / Fri / Sat tick labels
axis.POSIXct(1,
             at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
             labels = c("Thu", "Fri", "Sat"))

dev.off()