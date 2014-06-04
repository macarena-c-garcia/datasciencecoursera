##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## This is a script that reads a data set and creates plot3.png
## Written by Macarena Garcia
## Date: 02 June 2014
## For: Exploratory Data Analysis, Project 1
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## STEP 1: Set working directory
setwd("/Users/usaid/datasciencecoursera/data/") 

## STEP 2: Create a new object 'newFile' and read .txt file into R
newFile <- read.table("course_4_proj_1.txt", header=TRUE, sep=";", na.strings = "?", nrows= 1000000, stringsAsFactors=FALSE)  

## STEP 3: Create a new object 'newFile$Date' and format dates (into date class)
newFile$Date <- as.Date(newFile$Date, format = "%d/%m/%Y")  

## STEP 4: Create a new object 'tidyFile' and subset data based on date range provided in Project 1 instructions
tidyFile <- newFile[newFile$Date >= "2007-02-01" & newFile$Date <= "2007-02-02", ]

## STEP 5: Create field that combines the Date with the Time
require("lubridate")
tidyFile$DtTime <- ymd_hms(paste(tidyFile$Date, tidyFile$Time, sep = "_"))

## STEP 6: Draw a line chart, using sub_metering variables and DateTime variable
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white") ## Open png device
plot(x = tidyFile$DtTime, y = tidyFile$Sub_metering_1, type = "n", main = " ", xlab = " ", ylab = "Energy sub metering") ## Create the plot with no data points, yet
legend("topright", lwd=1, pt.cex=1, cex=0.5, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) ## Create legend
points(x = tidyFile$DtTime, y = tidyFile$Sub_metering_1, col = "black", type = 'l') ## Add sub_meetering_1 data point, with annotations
points(x = tidyFile$DtTime, y = tidyFile$Sub_metering_2, col = "red", type = "l") ## Add sub_meetering_2 data point, with annotations
points(x = tidyFile$DtTime, y = tidyFile$Sub_metering_3, col = "blue", type = "l") ## Add sub_meetering_3 data point, with annotations
               
## STEP 7: Close plot session
dev.off()