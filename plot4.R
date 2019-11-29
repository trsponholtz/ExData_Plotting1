#JHU Exploratory Analysis
#Course project 1

#file path for data file
path <- "C:/Users/Todd/Desktop/CourseraCourses/JhuDataScience/exdata_data_household_power_consumption/household_power_consumption.txt"

#read data into dataframe
powerdata <- read.table(path,sep=";",header=TRUE,na.strings="?")

#subset to dates 02/01/2007 - 02/02/2007
powerdata <- subset(powerdata,Date=="2/2/2007" | Date=="1/2/2007")

#convert variables to numeric
i <- c(3,4,5,6,7,8,9)
j <- c(1,2)
powerdata <- cbind(powerdata[,j],apply(powerdata[,i],2,function(x) as.numeric(as.character(x))))

#combine date and time variables
x <- paste(powerdata$Date,powerdata$Time)
datetime <- as.POSIXct(x,format="%d/%m/%Y %H:%M:%S")
powerdata["datetime"] <- datetime

#drop objects which are no longer needed
rm(path,i,j,x,datetime)

#Plot 4: plot global active power, voltage, energy sub-metering, and global reactive power by date and time in 4 line plots (2x2 by row)
png("plot4.png",width=480,height=480)
par(mfrow=c(2,2))
with(powerdata,plot(datetime,Global_active_power,type="line",ylab="Global Active Power (kilowatts)"))
with(powerdata,plot(datetime,Voltage,type="line",ylab="Voltage"))
plot(powerdata$datetime,powerdata$Sub_metering_1,type="n",xlab="datetime",ylab="Energy sub metering")
lines(powerdata$datetime,powerdata$Sub_metering_1,col="black")
lines(powerdata$datetime,powerdata$Sub_metering_2,col="red")
lines(powerdata$datetime,powerdata$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,cex=0.6)
with(powerdata,plot(datetime,Global_reactive_power,type="line",ylab="Global Reactive Power"))
dev.off()