#JHU Exploratory Analysis
#Course project 1
#plot1.R

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

#Plot 1: histogram of global active power
png("plot1.png",width=480,height=480)
hist(powerdata$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()