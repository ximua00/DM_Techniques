######################################
# HELPER FUNCTIONS

#This syntax: 
# - splitdata_id - function for splitting the data based on ID (ordered)
# - forecast_ARIMA_auto - function for ARIMA automatica selection of parameters
# - forecast_ARIMA_manual - function for ARIMA automatica selection of parameters
# - Performance - function for evaluating model
######################################


splitdata_id <- function (dataset) {
  # Function split the data into training, validation and test set (ordered by time) 
  # for different id's. 
  #
  # INPUT: Dataset with variable id
  # OUTPUT: 
  
  datasetTrain <- c()
  datasetValid <- c()
  datasetTest <- c()
  
  #For each user 
  for (user_id in unique(dataset$id)) {
  
    #Create temporary dataset
    df <- dataset[which(dataset$id == user_id), ]
    
    # Fixed Input - Set the fractions of the dataframe you want to split into training, 
    # validation, and test.
    fractionTraining   <- 0.70
    fractionValidation <- 0.15
    fractionTest       <- 0.15
    
    # Compute sample sizes.
    sampleSizeTraining   <- floor(fractionTraining   * nrow(df))
    sampleSizeValidation <- floor(fractionValidation * nrow(df))
    sampleSizeTest       <- floor(fractionTest       * nrow(df))
    
    # Create the randomly-sampled indices for the dataframe. Use setdiff() to
    # avoid overlapping subsets of indices.
    total_indices      <- seq.int(nrow(df))
    indicesTraining    <- total_indices[1: sampleSizeTraining]
    indicesNotTraining <- setdiff(seq_len(nrow(df)), indicesTraining)
    indicesValidation  <- indicesNotTraining[1: sampleSizeValidation]
    indicesTest        <- setdiff(indicesNotTraining, indicesValidation)

    # Create the three dataframes for training, validation and test.
    dfTraining   <- df[indicesTraining, ]
    dfValidation <- df[indicesValidation, ]
    dfTest       <- df[indicesTest, ]
    
    # Append the tables to output
    datasetTrain <- rbind(datasetTrain, dfTraining)
    datasetValid <- rbind(datasetValid, dfValidation)
    datasetTest <- rbind(datasetTest, dfTest)
  }
  
  return(list(datasetTrain, datasetValid, datasetTest ))
  
}



##########################################################


forecast_ARIMA_auto <- function(trainData, testData) {
  #function trains a time series model per ID 
  #INPUT: training dataset 
  #Output: Test dataset with extra column with predicted values
  
  #initialise c() with forecasted data
  finalForecast <- c()
  totalDays <- 0 
  
  for (user_id in unique(trainData$id)) {
    
    #Subset user data
    dfUser <- trainData[which(trainData$id == user_id), c("date", "interp_mood")]
    
    #Create a time series frame
    dfUser <- ts(data =  as.data.frame(dfUser), start = c(1))
    
    #Create ARIMA model
    model <- auto.arima(dfUser[, 2])
    
    #Get test data for specific user
    dfUserTest <- testData[which(testData$id == user_id), c("interp_mood")]
    
    #Define how many forecast point necessary
    f_days <- dim(dfUserTest)[1]
    totalDays <- totalDays + f_days
    
    #
    print (paste("Forecasting for ID", user_id, "for",  f_days, "days"))
    #
    
    #Forecast model for length of test data (f_days)
    forecastModel <- forecast(object = model, h = f_days)
    
    #unpack forecasts
    temp <- c()
    for (i in c(1:length(as.numeric(forecastModel$mean)))) {
      temp <- rbind(temp, as.numeric(forecastModel$mean)[[i]])
    }
    
    #Concatenate forecast to finalForecast
    finalForecast <- rbind(finalForecast, temp)
    
  }
  
  #Append new forecasted values to testData
  testData$forecast_mood <- finalForecast
  
  #
  print(paste("Total forecasted days across all IDs", totalDays))
  #
  
  return(testData)
}


##########################################################

##########################################################


forecast_ARIMA_manual <- function(trainData, testData) {
  #function trains a time series model per ID 
  #INPUT: training dataset 
  #Output: Test dataset with extra column with predicted values
  
  #initialise c() with forecasted data
  finalForecast <- c()
  totalDays <- 0 
  
  for (user_id in unique(trainData$id)) {
    
    #Subset user data
    dfUser <- trainData[which(trainData$id == user_id), c("date", "interp_mood")]
    
    #Create a time series frame
    dfUser <- ts(data =  as.data.frame(dfUser), start = c(1))
    
    #run ARIMA iterations model
    bestAIC <- 99999999
    
    for(p in 0:2){
      for(d in 0:1){
        for(q in 0:2){
          
          #run ARIMA
          model <- arima(dfUser[, 2], order = c(p,d,q), method="ML") 
          tempAIC <- model$aic
          
          #pick best model by checking low AIC
          if (tempAIC < bestAIC)
          {
            bestAIC <- tempAIC
            bestModel <- model
            
            
          }
          
        }
      }
    }
    
    #print (bestModel)
    
    #Get test data for specific user
    dfUserTest <- testData[which(testData$id == user_id), c("interp_mood")]
    
    #Define how many forecast point necessary
    f_days <- dim(dfUserTest)[1]
    totalDays <- totalDays + f_days
    
    #
    print (paste("Forecasting for ID", user_id, "for",  f_days, "days"))
    #
    
    #Forecast BestModel for length of test data (f_days)
    forecastModel <- forecast(object = bestModel, h = f_days)
    
    #unpack forecasts
    temp <- c()
    for (i in c(1:length(as.numeric(forecastModel$mean)))) {
      temp <- rbind(temp, as.numeric(forecastModel$mean)[[i]])
    }
    
    #Concatenate forecast to finalForecast
    finalForecast <- rbind(finalForecast, temp)
    
  }
  
  #Append new forecasted values to testData
  testData$forecast_mood <- finalForecast
  
  #
  print(paste("Total forecasted days across all IDs", totalDays))
  #
  
  return(testData)
}


##########################################################


linearRegression_perID <- function (trainData, testData) {
        # function trains a model per ID
        # i/p: training dataset
        # o/p: test dataset + column with predicted values
predicts <- c()
for (user_id in unique(trainData$id)) {

        dfUser <- trainData[which(trainData$id == user_id), ]
        dfUser_test <- testData[which(testData$id == user_id), ]
        dfUser$id <- NULL
        # create a linear regression model
        lm_Model <- lm(formula = interp_mood ~ dummy_Saturday+interp_valence, data = dfUser)
        
        predictMood <- predict(lm_Model, dfUser_test)
        
        predicts <- rbind(predicts, predictMood)

        r <- rmse(actual = dfUser_test$interp_mood, predicted = predictMood)
        p <- Performance(actual = dfUser_test$interp_mood, predicted = predictMood)
        
        # print statistics per user
        print(paste("Linear Regressing statistics ID ", user_id, " --- RMSE ", r, " & Performance ", p))
}

# TODO: for some weird reason only 216/223 test set values get predicted. wonder why 
predicts <- as.vector(t(predicts))

testData$predicted_mood <- predicts

return(testData)
}


##########################################################

##########################################################


Performance <- function(actual, predicted){
  #Function checks if predicted value is within a certain boundary.
  #if it within the boundary its a one, if not, its a zero.
  
  boundary <- 0.5
  
  temp <- (actual- predicted)^2
  
  accurate <- ifelse(temp <= boundary^2,
                     accurate <- 1, 
                     accurate <- 0)

  return(sum(accurate) / length(accurate))
  
}

##########################################################


