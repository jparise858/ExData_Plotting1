##Default attribution
knitr::opts_chunk$set(echo = TRUE, results = "asis")
##Reading the table
p1 <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
##Change date format to process
p1$Date <- as.Date(p1$Date, "%d/%m/%Y")
##Filter for only data set range
p1 <- subset(p1,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
##Remove incomplete
p1 <- p1[complete.cases(p1),]
##Combining date and time to one
dt <- paste(p1$Date, p1$Time)
##Turn into vector
dt <- setNames(dt, "DateTime")
##Remove the extra columns
p1 <- p1[ ,!(names(p1) %in% c("Date","Time"))]
##Add DateTime column
p1 <- cbind(dt, p1)
##Formatting
p1$dt <- as.POSIXct(dt)
##Create Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(p1, {
  plot(Global_active_power~dt, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dt, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dt, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dt,col='Red')
  lines(Sub_metering_3~dt,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dt, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()