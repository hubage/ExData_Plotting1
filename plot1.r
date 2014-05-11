inputdata <- read.table("household_power_consumption.txt", skip = 66637, nrow = 2880, 
                  sep = ";", na.strings="?", 
                  col.names = colnames(read.table("household_power_consumption.txt",
                                                  nrow = 1, header = TRUE, sep=";"))) 

## convert Date and Time from factor to character 
for( i in 1:2) {
  inputdata[, i] <- as.character(inputdata[, i])
}

with(inputdata, hist(Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power"))
dev.copy(png,file="plot1.png")
dev.off()