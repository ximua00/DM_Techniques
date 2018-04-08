######################################
#Install packages, if not available
# install.packages("data.table")
# install.packages("lubridate")
######################################

######################################
#Load packages
library(data.table)
library(lubridate)
######################################


######################################
#Load data
Mood <- fread("dataset_mood_smartphone.csv", na.strings = c("NA"), dec = c("."))
######################################


######################################
#Delete useless variables 
# I don't think V1 is useless as the values start differing with the serial 
# number from count '143507' onwards. So this part needs be reasoned why you
# think it needs to be deleted if you still think it's useless.
# Mood$V1 <- NULL
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
######################################


######################################
#Sort by id and date
newdata <- newdata[order(id, converted.time),]
######################################



######################################
#EXPLORATORY ANALYSIS
######################################
#for how many days each "subject" is tracked
DaysPerID <- c()
for (id_ in unique(newdata$id)) {
  n_days <- length(unique(newdata$date[which(newdata$id == id_)]))
  new_id <- c(id_, n_days)
  DaysPerID <- rbind(DaysPerID, new_id, deparse.level = 0)
}
plot(DaysPerID[,2])
######################################

######################################
#What time is the 'mood' asked to be rated? 
moodData <- subset(newdata, (!is.na(newdata[, newdata$value.mood])))
table(moodData$hour)
table(moodData$time.of.day)
#No defined hours for app to request user to rate 'mood'
######################################

######################################
#Distribution of mood 
#not aggregated per day!
table(moodData$value.mood)

##Aggregate mood per day
#Choose relevant variables
aggMood <- moodData[, .(id ,value.mood, date)]
#Aggregate by id and day with #count
aggMood <- moodData[, list(mood_count = .N, mood_mean = mean(value.mood)), 
                    by = .(id, date)]
######################################


