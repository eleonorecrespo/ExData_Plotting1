
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




#Plot 2
png(filename="plot2.png")
with(data_extract,plot(newdate,as.numeric(as.vector(data_extract$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kilowatts)"))
dev.off()




