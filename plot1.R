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

##Plot-1
png("plot1.png", width=480, height=480)

hist(subset_data$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

dev.off()