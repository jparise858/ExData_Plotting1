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
##Create Plot 1 - Histogram
hist(p1$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()