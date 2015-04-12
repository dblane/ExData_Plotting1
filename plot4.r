## Loading in the dataset then subsetting the data. Date's will be wrong so
## So we'll have to convert them.
dataimport <- read.csv("household_power_consumption.txt",header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
dataimport$Date <- as.Date(dataimport$Date,format="%d/%m/%Y")

## This is where we take the dates we need out of all 2 million rows so that we can 
## work with them more effeciently. Then we remove the unused variable.
dataselect <- subset(dataimport, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(dataimport)

## Now, in order to work with our instructions we must change the date format.
dateconv<- paste(as.Date(dataselect$Date), dataselect$Time)
dataselect$Datetime <- as.POSIXct(dateconv)

## Plot using the par (?par) and with (?with) to combine 4 separate graphs into one view. Then we'll output to a .png file.
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(dataselect, {
        plot(Global_active_power~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~Datetime, type="l", ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~Datetime, type="l",  ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

