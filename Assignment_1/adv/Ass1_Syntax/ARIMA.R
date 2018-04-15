######################################
# ARIMA MODEL
# (make sure that PreData is in environment - from AggregateData.R)

#This syntax: 
# - splits the data based on ID train -> (train + validation) and test
######################################

######################################
#Load packages
library(forecast)
library(ModelMetrics)
######################################

######################################
#Load helper functions
source("./Helper_Functions.R")
######################################


######################################
#Select only relevant variables for (univariate) time series modelling
TimeSeriesData <- PreData[, .(id, date, interp_mood)]
TimeSeriesData$date <- as.Date(TimeSeriesData$date)

#Create train, validation and test set.
#Group training and validation data for time series
SplitData <- splitdata_id(TimeSeriesData)
trainData <- rbind(SplitData[[1]], SplitData[[2]])
testData <- SplitData[[3]]
######################################


######################################
#For every ID make a model and forecast that model
testData_a <- forecast_ARIMA_auto(trainData, testData)
testData_m <- forecast_ARIMA_manual(trainData, testData)
######################################


######################################
#Compare using RMSE
rmse(actual = testData_a$interp_mood, predicted = testData_a$forecast_mood)
rmse(actual = testData_m$interp_mood, predicted = testData_m$forecast_mood)

#Compare using neighbour
Performance(actual = testData_a$interp_mood, predicted = testData_a$forecast_mood)
Performance(actual = testData_m$interp_mood, predicted = testData_m$forecast_mood)
######################################



######################################
rm(TimeSeriesData, testData_a, testData_m)
######################################
