############################################################################
# PERFORM LINEAR REGRESSION ON EACH USER FOR A BETTER UNDERSTANDING
############################################################################
library(forecast)
library(ModelMetrics)

source("./Helper_Functions.R")

temp <- data.table(experiment)

SplitData <- splitdata_id(temp)
trainingSet <- rbind(SplitData[[1]], SplitData[[2]])
testingSet <- SplitData[[3]]

trainingSet$date <- NULL

testData <- linearRegression_perID(trainingSet, testingSet)

# Analysis
rmse(actual = testData$interp_mood, predicted = testData$predicted_mood)
Performance(actual = testData$interp_mood, predicted = testData$predicted_mood)

