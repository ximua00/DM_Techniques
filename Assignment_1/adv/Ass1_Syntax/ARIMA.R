######################################
# ARIMA MODEL
# (make sure that PreData is in environment - from AggregateData.R)

#This syntax: 
# - splits the data based on ID train -> (train + validation) and test
######################################

######################################
#Load packages
library(forecast)
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
#MESSING ABOUT
test <- trainData[which(trainData$id == "AS14.03"), c("date", "interp_mood")]
test <- ts(data =  as.data.frame(test), start = 1, frequency = 1)

plot(test[, 2])
acf(log(test[, 2]))
pacf(log(test[, 2]))

model <- auto.arima(test[, 2])
model
f = forecast(object = model)
f$mean


HoltWinters(test)


fit <- tbats(diff(log(test[, 2])))
fc <- forecast(fit, h=10)
plot(fc)
