##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## This is a script that reads a data set and creates plot1.png
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

## STEP 5: Draw a histogram, using the Global_active_power variable
chart <- hist(tidyFile$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
par(chart, mar = c(5, 5, 2, 1))

## STEP 6: Copy to png file
dev.copy(png, filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")

## STEP 7: Close plot session
dev.off()
