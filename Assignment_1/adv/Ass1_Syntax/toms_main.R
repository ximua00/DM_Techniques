source("ReadData.R")
source("Regression_preprocessing.R")
source("Helper_Functions.R")
# source("CreateMovingAverages.R")

##########################################
# split data
PreData$saturday = NULL # because I'm getting invalid type (list) for variable saturday all the time
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

svm_model = svm(interp_mood ~ ., data=train)
summary(svm_model)

pred = predict(svm_model, val_x)
# table(pred, val_y)
err = pred - val_y

mse = mean(err^2)
perf = Performance(val_y, pred)
##########################################

##########################################
# optimizing svm - doesnt work yet

# welp, apparently there is no direct way to measure variable importance in svm's
#   - gotta do this with linear regression
# library(caret) # install.packages("caret)
# varImp(svm_model)
# methods(varImp)

# svm_tune = tune(svm_model, train.x = train_x, train.y = train_y,
                # kernel = "radial", ranges = list(cost=10^(-1:2), gamma=c(.5, 1, 2)))
                
# svm_tune <- tune(svm, train.x=train_x, train.y=train_y, 
#                  kernel="radial", ranges=list(cost=10^(-1:2), gamma=c(.5,1,2)))
# print(svm_tune)

##########################################






