temp <- tempfile()
download.file("exdata-data-household_power_consumption.zip",temp)


# Unzip data table
unzip_table <- unzip("exdata-data-household_power_consumption.zip")
y<-read.table(unzip_table,sep=";")

# Rename table column names
cc<-y[1,]
names(y)<-t(cc)

# Remove 1st row of table
y<-y[-1,]

# Transform Date and Time columns into universal format with as.Date and strptime
library(lubridate)
y$Date<-dmy(y$Date)
y$Date<-as.Date(y$Date)
y$Time<-strptime(c(y$Date,y$Time),"%H:%M:%S")

# Create a subset of table filtered on 2 days 
data_extract<-subset(y,Date==as.Date("2007-02-01")|Date==as.Date("2007-02-02"))

# Create a new field in the data_extract table : newdate
datetime<-as.POSIXct(paste(data_extract$Date, data_extract$Time), format="%Y-%m-%d %H:%M:%S")
data_extract$newdate <- datetime



#Plot 1 
png(filename="plot1.png")
hist(as.numeric(as.character(data_extract$Global_active_power)),main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")
dev.off()

