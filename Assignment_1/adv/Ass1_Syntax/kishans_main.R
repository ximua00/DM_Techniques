##########################
#KISHAN's MAIN
#Regression for all users
##########################

######################################
#Load helper functions
source("./Helper_Functions.R")
######################################

##########################
#Call other syntaxes
# 1: Load and aggregate data
source("./ReadData.R")

# 2: Preprocess data for Regression
source("./Regression_Preprocessing.R")
##########################
PreData_df$date <- NULL

loopnames <- names(PreData_df)
PreData_df <- Transformations(PreData_df, loopnames)
#PreData_df <- CoTransformations(PreData_df, loopnames)

##########################
#Get Evaluation datasets
SplitData <- splitdata_id(PreData_df)
trainingSet <- SplitData[[1]]
validationSet <- SplitData[[2]]
testingSet <- SplitData[[3]]
##########################

##########################
#Prepare data for modelling
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
##########################


##########################
#Linear regression per variable and save accuracy - for variable selection
#(Single Factor Analysis)
ResultsSingleFactor <- RegressionPerVariable(trainingSet)
##########################


##########################
#Regression for all users - based on results from Single Factor
#3: Train Model
model = lm(interp_mood ~ ma7_interp_mood,
             data = trainingSet)
summary(model)

#3.1: run step model
model = step(model)

#4: Predict on validation data
pred = predict(model, valid_x)

#5.1: Evaluate Model metrics on Validation
rmse(actual = valid_y, predicted = pred)
Performance(actual =  valid_y, predicted = pred, 0.5)

#5.2: Evaluate Model metrics on Test
pred = predict(model, test_x)
rmse(actual = test_y, predicted = pred)
Performance(test_y, pred, 0.5)
##########################


##########################
#SVM for all users - based on same Single Factor Analysis
#1: Train SVM
model = svm(interp_mood ~  ma7_interp_mood + ma2_interp_mood + ma7_interp_valence + lag_mood
            , data = trainingSet)

#4: Predict on validation data
pred = predict(model, valid_x)
rmse(actual = valid_y, predicted = pred)
Performance(actual =  valid_y, predicted = pred, 0.5)

#5: Evaluate Model metrics on Test
pred = predict(model, test_x)
rmse(actual = test_y, predicted = pred)
Performance(test_y, pred, 0.5)
##########################


##########################

##########################
#Run Regression Model per user
#Get Evaluation datasets



IRSplitData <- splitdata_id(PreData_df)
trainingSet <- SplitData[[1]]
validationSet <- SplitData[[2]]
testingSet <- SplitData[[3]]



#Run model per user VALIDATION SET
temp <- linearRegression_perID(trainingSet, validationSet)
rmse(actual = temp$interp_mood, predicted = temp$predicted_RegressionUser)
Performance(actual = temp$interp_mood, predicted = temp$predicted_RegressionUser, 0.5)


#Run model per user TEST SET
temp <- linearRegression_perID(trainingSet, testingSet)
rmse(actual = temp$interp_mood, predicted = temp$predicted_RegressionUser)
Performance(actual = temp$interp_mood, predicted = temp$predicted_RegressionUser, 0.5)


