######################################
#Install packages, if not available
# install.packages("data.table")
# install.packages("lubridate")
# install.packages("GGally")
######################################

######################################
#Load packages
library(data.table)
library(lubridate)
library(ggplot2)
library(GGally)
######################################


######################################
#Load data
Mood <- fread("../dataset_mood_smartphone.csv", na.strings = c("NA"), dec = c("."))
######################################


######################################
#Delete useless variables 
# T: I don't think V1 is useless as the values start differing with the serial 
# number from count '143507' onwards. So this part needs be reasoned why you
# think it needs to be deleted if you still think it's useless. 
# K: Because it is a subset of the original dataset. 
Mood$V1 <- NULL
######################################


######################################
#Check out data
str(Mood)
summary(Mood)
#Matches from what is in Excel
######################################


######################################
#Reshape Data
newdata <- reshape(Mood,
                   timevar = "variable",
                   idvar = c("id", "time"),
                   direction = "wide")
######################################


######################################
#Define variable as "time" format - full date and time
newdata$converted.time <- as_datetime(newdata$time)

#Define date variable
newdata$date <- as_date(newdata$time)

#Define hour variable (hour of the day)
newdata$hour <- hour(newdata$converted.time)

#Use hour of the day to define time of day
newdata$time.of.day[newdata$hour <= 6] <- "dawn"
newdata$time.of.day[newdata$hour > 6 & newdata$hour <= 12] <- "morning"
newdata$time.of.day[newdata$hour > 12 & newdata$hour <= 18] <- "afternoon"
newdata$time.of.day[newdata$hour > 18 & newdata$hour <= 24] <- "evening"

#Add Weekday
newdata$week.day <- weekdays(newdata$date)
######################################

######################################
#Sort by id and date
newdata <- newdata[order(id, converted.time),]
######################################

#Add nth day into newdata (column)
min_day <- as.numeric(min(newdata$date))
newdata$nth_day <- as.numeric(unlist(lapply(X = as.numeric(newdata$date), FUN = function(x) x+1-min_day)))
rm(min_day)
