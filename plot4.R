## Loading the data
setwd("C:/Users/kahan/OneDrive/Desktop/GIPE/Sem VI/MA")

download.file("https://github.com/Kahani13/ExData_Plotting1/raw/refs/heads/master/exdata_data_household_power_consumption.zip", 
              destfile = "exdata_data_household_power_consumption.zip")

data <- read.table(unz("exdata_data_household_power_consumption.zip", 
                       "household_power_consumption.txt"), 
                   header = TRUE, sep = ";", na.strings = "?")

head(data)
str(data)

##Fixing and Filtering
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subset_data <- subset(data,
                      Date == as.Date("2007-02-01") |
                        Date == as.Date("2007-02-02"))
head(subset_data)
dim(subset_data)

##Creating an Time Variable
subset_data$DateTime <- strptime(
  paste(subset_data$Date, subset_data$Time),
  format="%Y-%m-%d %H:%M:%S"
)
head(subset_data$DateTime)
str(subset_data$DateTime)

##Plot-4
data <- read.table("household_power_consumption.txt",
                   header = TRUE,
                   sep = ";",
                   na.strings = "?")

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

subset_data <- subset(data,
                      Date == as.Date("2007-02-01") |
                        Date == as.Date("2007-02-02"))

subset_data$DateTime <- strptime(
  paste(subset_data$Date, subset_data$Time),
  format="%Y-%m-%d %H:%M:%S"
)

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))  # THIS LINE CONTROLS THE GRID (don’t mess this up)

# Top-left
plot(subset_data$DateTime,
     subset_data$Global_active_power,
     type="l",
     ylab="Global Active Power",
     xlab="",
     xaxt = "n")

## Manually add Thu / Fri / Sat tick labels
axis.POSIXct(1,
             at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
             labels = c("Thu", "Fri", "Sat"))

# Top-right
plot(subset_data$DateTime,
     subset_data$Voltage,
     type="l",
     ylab="Voltage",
     xlab="datetime", 
     xaxt = "n")

## Manually add Thu / Fri / Sat tick labels
axis.POSIXct(1,
             at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
             labels = c("Thu", "Fri", "Sat"))

# Bottom-left
plot(subset_data$DateTime,
     subset_data$Sub_metering_1,
     type="l",
     ylab="Energy sub metering",
     xlab="",
     xaxt = "n")

## Manually add Thu / Fri / Sat tick labels
axis.POSIXct(1,
             at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
             labels = c("Thu", "Fri", "Sat"))

lines(subset_data$DateTime, subset_data$Sub_metering_2, col="red")
lines(subset_data$DateTime, subset_data$Sub_metering_3, col="blue")

legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),
       lty=1,
       bty="n")

# Bottom-right
plot(subset_data$DateTime,
     subset_data$Global_reactive_power,
     type="l",
     ylab="Global_reactive_power",
     xlab="datetime", 
     xaxt = "n")

## Manually add Thu / Fri / Sat tick labels
axis.POSIXct(1,
             at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
             labels = c("Thu", "Fri", "Sat"))

dev.off()