##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## This is a script that reads a data set and creates plot2.png.
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

## STEP 5: Create field that combines the Date with the Time so we can plot it on 
#        	the horizontal x-axis. For the plot function to use this field properly,
#		it needs to be in the POISX data type and not just a "Date".
#		'lubridate' to the rescue again.  This is such an amazing package for dates.
#  		We can use the "ymd_hms" function to take the DATE and TIME fields and convert them to POISX
#		The paste command will put the fields together with an underscore between them so the function will work
require("lubridate")
tidyFile$DtTime <- ymd_hms(paste(tidyFile$Date, tidyFile$Time, sep = "_"))

## STEP 6: Draw a line chart, using the Global_active_power and Days variables
#		The plot command is a base function that takes an x and a y input and plots it
#		We can use "l" to create a line chart, and then provide the labels that we want.
#		Turns out that the plot function already adds the day of the week, so we didn't need that conversion
chart2 <- plot(x = tidyFile$DtTime, y = tidyFile$Global_active_power, type = "l", main = " ", xlab = " ", ylab = "Global Active Power (kilowatts)")

## STEP 7: Copy to png file
dev.copy(png, filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")

## STEP 8: Close plot session
dev.off()