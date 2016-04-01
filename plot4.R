temp <- tempfile()
download.file("exdata-data-household_power_consumption.zip",temp)


# Unzip data table
unzip_table <- unzip("exdata-data-household_power_consumption.zip")
y<-read.table(unzip_table,header= T, sep=";")



# Transform Date and Time columns into universal format with as.Date and strptime
library(lubridate)
y$Date<-dmy(y$Date)
y$Date<-as.Date(y$Date)

# Create a subset of table filtered on 2 days 
data_extract<-subset(y,Date==as.Date("2007-02-01")|Date==as.Date("2007-02-02"))

# Create a new field in the data_extract table : newdate
datetime<-as.POSIXct(paste(data_extract$Date, data_extract$Time), format="%Y-%m-%d %H:%M:%S")
data_extract$newdate <- datetime


#Plot 4
png(filename="plot4.png")
par(mfrow=c(2,2),cex=.64)
# 1
with(data_extract,plot(newdate,as.numeric(as.vector(data_extract$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kilowatts)"))
# 2
with(data_extract,plot(newdate,as.numeric(as.vector(data_extract$Voltage)),type="l",xlab="datetime",ylab="Voltage"))
# 3
plot(data_extract$newdate,as.numeric(as.vector(data_extract$Sub_metering_1)),col="black",type="l",ylab="Energy Sub Metering",xlab="")
points(data_extract$newdate,as.numeric(as.vector(data_extract$Sub_metering_2)),col="red",type="l")
points(data_extract$newdate,as.numeric(as.vector(data_extract$Sub_metering_3)),col="blue",type="l")
legend("topright",lwd=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n")
# 4
with(data_extract,plot(newdate,as.numeric(as.vector(data_extract$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power"))
dev.off()
