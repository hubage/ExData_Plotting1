inputdata <- read.table("household_power_consumption.txt", skip = 66637, nrow = 2880, 
                        sep = ";", na.strings="?", 
                        col.names = colnames(read.table("household_power_consumption.txt",
                                                        nrow = 1, header = TRUE, sep=";"))) 

## convert Date and Time from factor to character 
for( i in 1:2) {
  inputdata[, i] <- as.character(inputdata[, i])
}
inputdata <- within(inputdata, DateTime <- paste(Date, Time, sep = ' '))
inputdata$DateTime <- strptime(paste(inputdata$Date, inputdata$Time), format="%d/%m/%Y %H:%M:%S")


par(mfrow=c(2,2))
plot(inputdata$DateTime,inputdata$Global_active_power, ylab="Global Active Power",xlab="",type="n",cex.lab=.75)
lines(inputdata$DateTime,inputdata$Global_active_power)

plot(inputdata$DateTime,inputdata$Voltage, ylab="Voltage",xlab="datetime",type="n",cex.lab=.75)
lines(inputdata$DateTime,inputdata$Voltage)

xrange <- range(inputdata$DateTime) 
yrange <- range(c(inputdata$Sub_metering_1,inputdata$Sub_metering_2,inputdata$Sub_metering_3))

plot(xrange,yrange, ylab="Energy sub metering",xlab="",type="n",cex.lab=.75)
lines(inputdata$DateTime,inputdata$Sub_metering_1,col="black")
lines(inputdata$DateTime,inputdata$Sub_metering_2,col="red")
lines(inputdata$DateTime,inputdata$Sub_metering_3,col="blue")
legend("topright", col=c("black", "blue", "red"), cex = .75, lty=1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),bty="n" )


xrange <- range(inputdata$DateTime) 
yrange <- range(inputdata$Global_reactive_power)
plot(xrange,yrange, ylab="Global_reactive_power",xlab="datetime",type="n",yaxt="n",cex.lab=.75)
lines(inputdata$DateTime,inputdata$Global_reactive_power)
axis(2,cex.axis=.75)

dev.copy(png,file="plot4.png")
dev.off()