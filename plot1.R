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
png(filename="./ExData_Plotting1/plot1.png")
hist(data_clean$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power" , col = "red")
dev.off()



