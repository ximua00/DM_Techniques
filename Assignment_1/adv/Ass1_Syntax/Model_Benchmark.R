######################################
#CREATE BENCHMARK MODEL
#make sure that moodData is loaded in environment - from ExploratoryAnalysis_Mood.R
######################################


######################################
#Install packages, if not available
# install.packages("ModelMetrics")
######################################

######################################
#Load packages
library(ModelMetrics)
######################################




######################################
#Select only relevant variables for benchmark model
MoodBench <- moodData[, .(id, value.mood, date, time.of.day, week.day)]

#Aggregate by day, taking the daily average of mood
aggMoodDay <- MoodBench[, .(mood_count = .N, mood.daily.mean = mean(value.mood)), 
                      by = .(id, date)]
######################################


######################################
#BENCHMARK MODEL 1 - Predict mood of next 
#day by saying it is equal to the previous day.

#Lag mood variable
aggMoodDay$lag.mood <- aggMoodDay[, .(lag.mood =  shift(mood.daily.mean)), by = id][, 2]

#TODO
#Split training/test data
#Evaluate with e.g. RMSE

#delete rows with missing values
#aggMoodDayTest <- subset(aggMoodDay, (!is.na(aggMoodDay[, aggMoodDay$lag.mood])))
#rmse(aggMoodDayTest$mood.daily.mean, aggMoodDayTest$lag.mood)

######################################


######################################
#BENCHMARK MODEL 2 - Predict mood of next day by taking 
#the average for the previous 7 days.

aggMoodDay$lag.mood1 <- aggMoodDay[, .(lag.mood =  shift(mood.daily.mean, n = 1)), 
                                   by = id][, 2]
aggMoodDay$lag.mood2 <- aggMoodDay[, .(lag.mood =  shift(mood.daily.mean, n = 2)),
                                   by = id][, 2] 
aggMoodDay$lag.mood3 <- aggMoodDay[, .(lag.mood =  shift(mood.daily.mean, n = 3)),
                                   by = id][, 2] 
aggMoodDay$lag.mood4 <- aggMoodDay[, .(lag.mood =  shift(mood.daily.mean, n = 4)),
                                   by = id][, 2] 
aggMoodDay$lag.mood5 <- aggMoodDay[, .(lag.mood =  shift(mood.daily.mean, n = 5)),
                                   by = id][, 2] 
aggMoodDay$lag.mood6 <- aggMoodDay[, .(lag.mood =  shift(mood.daily.mean, n = 6)),
                                   by = id][, 2] 
aggMoodDay$lag.mood7 <- aggMoodDay[, .(lag.mood =  shift(mood.daily.mean, n = 7)),
                                   by = id][, 2] 

aggMoodDay[,`:=` (mean.7.previousdays = apply(.SD, 1, mean)),
           by = id, 
           .SDcols = c("lag.mood1", "lag.mood2", "lag.mood3", "lag.mood4", "lag.mood5", "lag.mood6", "lag.mood7")]


#TODO
#Split training/test data
#Evaluate with e.g. RMSE
#Try with more / less days to average

#delete rows with missing values
#aggMoodDayTest <- subset(aggMoodDay, (!is.na(aggMoodDay[, aggMoodDay$mean.7.previousdays])))
#rmse(aggMoodDayTest$mood.daily.mean, aggMoodDayTest$mean.7.previousdays)
######################################





