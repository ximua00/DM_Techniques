
# Temp <- PreData_df
# 
# 
# 
# # Split dataset with the dummy variable
# SplitData <- splitdata_id(Temp)
# trainingSet <- rbind(SplitData[[1]], SplitData[[2]])
# testingSet <- SplitData[[3]]
# 
# trainingSet$id <- NULL
# trainingSet$date <- NULL
# 
# # Create a Linear model for -c- analysis
# lmModel <- lm(interp_mood ~., data = trainingSet)
# summary(lmModel)
# 
# # Prediction
# predictMood <- predict(lmModel, testingSet)
# 
# # Analysis
# actualPreds <- data.frame(cbind(actuals = testingSet$interp_mood, predicts = predictMood))
# rmse(actual = actualPreds$actuals, predicted = actualPreds$predicts)
# Performance(actual = actualPreds$actuals, predicted = actualPreds$predicts)
# 
# forecast_ARIMA_auto <- function(trainData, testData) {
#   #function trains a time series model per ID 
#   #INPUT: training dataset 
#   #Output: Test dataset with extra column with predicted values
#   
#   #initialise c() with forecasted data
#   finalForecast <- c()
#   totalDays <- 0 
#   
#   for (user_id in unique(trainData$id)) {
#     
#     #Subset user data
#     dfUser <- trainData[which(trainData$id == user_id), c("date", "interp_mood")]
#     
#     #Create a time series frame
#     dfUser <- ts(data =  as.data.frame(dfUser), start = c(1))
#     
#     #Create ARIMA model
#     model <- auto.arima(dfUser[, 2])
#     
#     #Get test data for specific user
#     dfUserTest <- testData[which(testData$id == user_id), c("interp_mood")]
#     
#     #Define how many forecast point necessary
#     f_days <- dim(dfUserTest)[1]
#     totalDays <- totalDays + f_days
#     
#     #
#     print (paste("Forecasting for ID", user_id, "for",  f_days, "days"))
#     #
#     
#     #Forecast model for length of test data (f_days)
#     forecastModel <- forecast(object = model, h = f_days)
#     
#     #unpack forecasts
#     temp <- c()
#     for (i in c(1:length(as.numeric(forecastModel$mean)))) {
#       temp <- rbind(temp, as.numeric(forecastModel$mean)[[i]])
#     }
#     
#     #Concatenate forecast to finalForecast
#     finalForecast <- rbind(finalForecast, temp)
#     
#   }
#   
#   #Append new forecasted values to testData
#   testData$forecast_mood <- finalForecast
#   
#   #
#   print(paste("Total forecasted days across all IDs", totalDays))
#   #
#   
#   return(testData)
# }
# 
# 
# ##########################################################