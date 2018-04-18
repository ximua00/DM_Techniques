##########################
#KISHAN's MAIN
##########################

##########################
#Call other syntaxes

# 1: Load and aggregate data
source("./ReadData.R")

# 2: Preprocess data for Regression
source("./Regression_Preprocessing.R")

##########################


##########################
#Get Evaluation datasets
SplitData <- splitdata_id(PreData_df)
trainingSet <- SplitData[[1]]
validationSet <- SplitData[[2]]
testingSet <- SplitData[[3]]
##########################


##########################
#Regression for all users
#1: Delete useless variables
trainingSet$id <- NULL
testingSet$id <- NULL
validationSet$id <- NULL
trainingSet$date <- NULL
testingSet$date <- NULL
validationSet$date <- NULL

#2: remove y variable 
valid_x = subset(validationSet, select = -interp_mood)
valid_y = validationSet$interp_mood
test_x = subset(testingSet, select = -interp_mood)
test_y = testingSet$interp_mood

#3: Train Model
model = lm(interp_mood ~lag_arousal + lag_valence + ma7_interp_mood + ma7_interp_valence, data = trainingSet)
summary(model)

#3.1: run step model
model = step(model)

#4: Predict on validation data
pred = predict(model, valid_x)

#5.1: Evaluate Model metrics on Validation
rmse(actual = valid_y, predicted = pred)
Performance(test_y, pred, 0.5)

#5.2: Evaluate Model metrics on Test
pred = predict(model, test_x)
rmse(actual = test_y, predicted = pred)
Performance(test_y, pred, 0.5)

##########################




##########################
#SVM for all users
#1: Train SVM
model = svm(interp_mood ~ ma7_interp_mood + lag_valence + dummy_Saturday, data = trainingSet)

#2: Predict on test data
pred = predict(model, test_x)

#3: Evaluate Model metrics
rmse(actual = test_y, predicted = pred)
Performance(test_y, pred, 0.5)
##########################


