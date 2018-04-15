
Temp <- PreData_df


# Split dataset with the dummy variable
SplitData <- splitdata_id(Temp)
trainingSet <- rbind(SplitData[[1]], SplitData[[2]])
testingSet <- SplitData[[3]]

trainingSet$id <- NULL
trainingSet$date <- NULL

# Create a Linear model for -c- analysis
lmModel <- lm(interp_mood ~., data = trainingSet)
summary(lmModel)

# Prediction
predictMood <- predict(lmModel, testingSet)

# Analysis
actualPreds <- data.frame(cbind(actuals = testingSet$interp_mood, predicts = predictMood))
rmse(actual = actualPreds$actuals, predicted = actualPreds$predicts)
Performance(actual = actualPreds$actuals, predicted = actualPreds$predicts)
