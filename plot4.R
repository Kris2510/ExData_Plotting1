library(data.table)

data <- fread("./household_power_consumption.txt")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data_clean <- subset(data, data$Date <= "2007/02/02" & data$Date >= "2007/02/01")


## Convert to numeric since I experienced difficulties regarding the ? as NA value with fread
data_clean$Global_active_power <- as.numeric(data_clean$Global_active_power)
data_clean$Global_reactive_power <- as.numeric(data_clean$Global_reactive_power)
data_clean$Voltage<- as.numeric(data_clean$Voltage)
data_clean$Global_intensity <- as.numeric(data_clean$Global_intensity)
data_clean$Sub_metering_1 <- as.numeric(data_clean$Sub_metering_1)
data_clean$Sub_metering_2 <- as.numeric(data_clean$Sub_metering_2)
data_clean$Sub_metering_3 <- as.numeric(data_clean$Sub_metering_3)

## Create a timestamp which combines the date and time variables
data_clean$timestamp <- as.POSIXct(paste(data_clean$Date, data_clean$Time), format="%Y-%m-%d %H:%M:%S")

## Plot the graphs and save a png file
png(filename="./ExData_Plotting1/plot4.png")
par(mfrow= c(2,2))
plot(data_clean$timestamp, data_clean$Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", type = "l" )
plot(data_clean$timestamp, data_clean$Voltage, ylab="Voltage", xlab="datetime", type = "l" )
plot(data_clean$timestamp, data_clean$Sub_metering_1, ylab="Energy Sub Metering", xlab="", type = "l" )
lines(data_clean$timestamp, data_clean$Sub_metering_2, col = "red")
lines(data_clean$timestamp, data_clean$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))
plot(data_clean$timestamp, data_clean$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type = "l" )
dev.off()