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

with(inputdata, plot(DateTime,Global_active_power, ylab="Global Active Power (kilowatts)",xlab="",type="n"))
lines(inputdata$DateTime,inputdata$Global_active_power)

dev.copy(png,file="plot2.png")
dev.off()