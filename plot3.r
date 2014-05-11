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

xrange <- range(inputdata$DateTime) 
yrange <- range(c(inputdata$Sub_metering_1,inputdata$Sub_metering_2,inputdata$Sub_metering_3))

plot(xrange,yrange, ylab="Energy sub metering",xlab="",type="n")
lines(inputdata$DateTime,inputdata$Sub_metering_1,col="black")
lines(inputdata$DateTime,inputdata$Sub_metering_2,col="red")
lines(inputdata$DateTime,inputdata$Sub_metering_3,col="blue")
legend("topright", col=c("black", "blue", "red"), cex = 0.95, lty=1,
      legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png,file="plot3.png")
dev.off()