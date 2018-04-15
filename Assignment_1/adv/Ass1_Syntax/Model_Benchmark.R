######################################
#CREATE BENCHMARK MODEL
#make sure that PreData is loaded in environment - from AggregateData.R
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
#Load helper functions
source("./Helper_Functions.R")
######################################


######################################
#Select only relevant variables for benchmark model
MoodBench <- PreData[, .(id, date, interp_mood)]
######################################


######################################
#CREATE BENCHMARK VARIABLES

## BENCHMARK 1 - USE LAG(1)
#Lag mood variable
MoodBench$lag.mood <- MoodBench[, .(lag.mood =  shift(interp_mood)), by = id][, 2]


#BENCHMARK MODEL 2 - Predict mood of next day by taking 
#the average for the previous 7 days.
# Create temporary variables
MoodBench <- MoodBench[, .(lag.mood =  shift(interp_mood, n = 1)), 
                                   by = id][, 2]
MoodBench$lag.mood2 <- MoodBench[, .(lag.mood =  shift(interp_mood, n = 2)),
                                   by = id][, 2] 
MoodBench$lag.mood3 <- MoodBench[, .(lag.mood =  shift(interp_mood, n = 3)),
                                   by = id][, 2] 
MoodBench$lag.mood4 <- MoodBench[, .(lag.mood =  shift(interp_mood, n = 4)),
                                   by = id][, 2] 
MoodBench$lag.mood5 <- MoodBench[, .(lag.mood =  shift(interp_mood, n = 5)),
                                   by = id][, 2] 
MoodBench$lag.mood6 <- MoodBench[, .(lag.mood =  shift(interp_mood, n = 6)),
                                   by = id][, 2] 
MoodBench$lag.mood7 <- MoodBench[, .(lag.mood =  shift(interp_mood, n = 7)),
                                   by = id][, 2] 

#Create benchmark variables
MoodBench[,`:=` (mean.2.previousdays = apply(.SD, 1, mean)),
          by = id, 
          .SDcols = c("lag.mood1", "lag.mood2")]

MoodBench[,`:=` (mean.5.previousdays = apply(.SD, 1, mean)),
          by = id, 
          .SDcols = c("lag.mood1", "lag.mood2", "lag.mood3", "lag.mood4", "lag.mood5")]

MoodBench[,`:=` (mean.7.previousdays = apply(.SD, 1, mean)),
          by = id, 
          .SDcols = c("lag.mood1", "lag.mood2", "lag.mood3", "lag.mood4", "lag.mood5", "lag.mood6", "lag.mood7")]



#remove temporary variables
MoodBench <- MoodBench[, c("lag.mood1", "lag.mood2", "lag.mood3", "lag.mood4", "lag.mood5", "lag.mood6", "lag.mood7") := NULL]
######################################


######################################
#Create train, validation and test set.
#Group training and validation data for time series
SplitData <- splitdata_id(MoodBench)
testData <- SplitData[[3]]
######################################


######################################
#Compare using for 4 benchmark models
#RMSE
rmse(actual = testData$interp_mood, predicted = testData$lag.mood)
rmse(actual = testData$interp_mood, predicted = testData$mean.2.previousdays)
rmse(actual = testData$interp_mood, predicted = testData$mean.5.previousdays)
rmse(actual = testData$interp_mood, predicted = testData$mean.7.previousdays)

#Performance
Performance(actual = testData$interp_mood, predicted = testData$lag.mood)
Performance(actual = testData$interp_mood, predicted = testData$mean.2.previousdays)
Performance(actual = testData$interp_mood, predicted = testData$mean.5.previousdays)
Performance(actual = testData$interp_mood, predicted = testData$mean.7.previousdays)
######################################


######################################
#Clean environment
rm(MoodBench, testData)
######################################



