source("readdata.r")
source("regression_preprocessing.r")
source("helper_functions.r")
# source("CreateMovingAverages.R")

pls = head(PreData)
PreData = PreData_df
##########################################
# split data
# PreData$saturday = NULL # because i'm getting invalid type (list) for variable saturday all the time
data = splitdata_id(PreData)

train = data[[1]]
valid = data[[2]]
test = data[[3]]

train$id = NULL
valid$id = NULL
test$id = NULL
##########################################

##########################################
# perform svm 
library("e1071") # install.packages("e1071")

main_var = c("interp_mood")

train_x = subset(train, select = -interp_mood)
train_y = train$interp_mood
val_x = subset(valid, select = -interp_mood)
val_y = valid$interp_mood
test_x = subset(test, select = -interp_mood)
test_y = test$interp_mood

model = lm(interp_mood ~ ., data=train)

model = lm(interp_mood ~ c("ma2_interp_mood", "lag_mood"), data=train)
# model = svm(interp_mood ~ ., data=train)
summary(model)

pred = predict(model, test_x)

err = pred - test_y
mse = mean(err^2)
perf = Performance(test_y, pred, 0.5)

print(mse)
print(perf)

comparison = as.data.frame(pred)
comparison$truth = as.data.frame(test_y)
##########################################


##########################################
# optimizing linear regression

result = step(model)
# conclusion: nothing except ma2_interp_mood and lag_mood matters
# keeps = c("ma2_interp_mood", "lag_mood")
##########################################

##########################################
# optimizing svm - doesnt work yet

# welp, apparently there is no direct way to measure variable importance in svm's
#   - gotta do this with linear regression
# library(caret) # install.packages("caret)
# varImp(model)
# methods(varImp)

# svm_tune = tune(model, train.x = train_x, train.y = train_y,
                # kernel = "radial", ranges = list(cost=10^(-1:2), gamma=c(.5, 1, 2)))
                
# svm_tune <- tune(svm, train.x=train_x, train.y=train_y, 
#                  kernel="radial", ranges=list(cost=10^(-1:2), gamma=c(.5,1,2)))
# print(svm_tune)

##########################################






