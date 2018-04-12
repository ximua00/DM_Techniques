######################################
#Install packages, if not available
# install.packages("data.table")
# install.packages("lubridate")
######################################
#Load packages
library(data.table)
library(lubridate)
######################################
#Load data
Mood <- fread("../dataset_mood_smartphone.csv", na.strings = c("NA"), dec = c("."))
Mood$V1 <- NULL
######################################
str(Mood)
summary(Mood)
newdata = reshape(Mood,
                   timevar = "variable",
                   idvar = c("id", "time"),
                   direction = "wide")

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
#Sort by id and date
newdata <- newdata[order(id, converted.time),]
######################################


######################################
#EXPLORATORY ANALYSIS (MOOD)
######################################
#for how many days each "subject" is tracked
DaysPerID <- c()
for (id_ in unique(newdata$id)) {
  n_days <- length(unique(newdata$date[which(newdata$id == id_)]))
  new_id <- c(id_, n_days)
  DaysPerID <- rbind(DaysPerID, new_id, deparse.level = 0)
}

#Conclusion: Each ID conducts the experiment for a different number of days
######################################
#What time is the 'mood' asked to be rated? 
moodData <- subset(newdata, (!is.na(newdata[, newdata$value.mood])))
#Conclusion: No fixed hours for app to request user to rate 'mood'
######################################
# Distribution of mood
# not aggregated per day!
# table(moodData$value.mood)


##Aggregate mood per day
#Choose relevant variables
aggMood <- moodData[, .(id ,value.mood, date)]
testaggmood <- moodData[, .(id ,value.mood, date)]
#Aggregate by id and day with #count
aggMood <- moodData[, .(mood_count = .N, mood_mean = mean(value.mood)),
                    by = .(id, date)]

#Visualise
#TODO (average mood per user, track mood per user over time, etc…)
#average mood per user
idMood <- aggMood[, .(mood_mean = mean(mood_mean)),
                  by = .(id)]
######################################
#Total number of days the dataset was collected
max(moodData$date) - min(moodData$date)
######################################

#Select only relevant variables for benchmark model
MoodBench <- moodData[, .(id, value.mood, date, time.of.day, week.day)]

#Aggregate by day, taking the daily average of mood
aggMoodDay <- MoodBench[, .(mood_count = .N, mood.daily.mean = mean(value.mood)), 
                        by = .(id, date)]
######################################
#Lag mood variable
aggMoodDay$lag.mood <- aggMoodDay[, .(lag.mood =  shift(mood.daily.mean)), by = id][, 2]





# **********************************************
#                   NEW STUFF
# **********************************************

# install.packages("dplyr")
# install.packages("GGally")
# install.packages("xts")
# library("dplyr")
library("GGlly")
# library("xts")


# aggregate all variables by day
aggData = newdata[, .(agg_mood = mean(value.mood, na.rm=TRUE),
                      agg_arousal = mean(value.circumplex.arousal, na.rm=TRUE),
                      agg_valence = mean(value.circumplex.valence, na.rm=TRUE),
                      agg_activity = mean(value.activity, na.rm=TRUE),
                      agg_screen = mean(value.screen, na.rm=TRUE),
                      agg_call = sum(value.call, na.rm=TRUE),
                      agg_sms = sum(value.sms, na.rm=TRUE),
                      agg_builtin = mean(value.appCat.builtin, na.rm=TRUE),
                      agg_communication = mean(value.appCat.communication, na.rm=TRUE),
                      agg_entertainment = mean(value.appCat.entertainment, na.rm=TRUE),
                      agg_finance = mean(value.appCat.finance, na.rm=TRUE),
                      agg_game = mean(value.appCat.game, na.rm=TRUE),
                      agg_office = mean(value.appCat.office, na.rm=TRUE),
                      agg_other = mean(value.appCat.other, na.rm=TRUE),
                      agg_social = mean(value.appCat.social, na.rm=TRUE),
                      agg_travel = mean(value.appCat.travel, na.rm=TRUE),
                      agg_unknown = mean(value.appCat.unknown, na.rm=TRUE),
                      agg_utilities = mean(value.appCat.utilities, na.rm=TRUE),
                      agg_weather = mean(value.appCat.weather, na.rm=TRUE)
                      ),
                  by = .(id, date)]


# ggpairs(aggData_noNA, 
#         columns = c("agg_mood", "agg_valence", "agg_arousal"), 
#         upper = list(continuous = wrap("cor", 
#                                        size = 10)), 
#         lower = list(continuous = "smooth"))

# add the mood of the previous day
aggData$lag_mood = aggData[, .(lag_mood =  shift(agg_mood)), by = id][, 2]

#Add Weekday as an integer
aggData$weekday = wday(aggData$date)

# correlation matrix visualisation
ggcorr(aggData)





