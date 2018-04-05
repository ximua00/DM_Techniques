######################################
#Install packages, if not available
install.packages("data.table")
install.packages("lubridate")
######################################

######################################
#Load packages
library(data.table)
library(lubridate)
######################################


######################################
#Load data
Mood <- fread("../dataset_mood_smartphone.csv", na.strings = c("NA"), dec = c("."))
######################################


######################################
#Delete useless variables
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
######################################


######################################
#Sort by id and date
newdata <- newdata[order(id, date),]
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
######################################
