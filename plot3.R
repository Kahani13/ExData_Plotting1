##Loading the data
setwd("C:/Users/kahan/OneDrive/Desktop/GIPE/Sem VI/MA")

download.file("https://github.com/Kahani13/ExData_Plotting1/raw/refs/heads/master/exdata_data_household_power_consumption.zip", 
              destfile = "exdata_data_household_power_consumption.zip")

# Read the dataset inside the ZIP
data <- read.table(unz("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?")

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

##Plot-3
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

png("plot3.png", width=480, height=480)

plot(subset_data$DateTime, subset_data$Sub_metering_1,
     type="l", col="black",
     ylab="Energy sub metering",
     xlab="",
     xaxt = "n")

lines(subset_data$DateTime, subset_data$Sub_metering_2, col="red")
lines(subset_data$DateTime, subset_data$Sub_metering_3, col="blue")

legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),
       lty=1)

## Manually add Thu / Fri / Sat tick labels
axis.POSIXct(1,
             at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
             labels = c("Thu", "Fri", "Sat"))

dev.off()