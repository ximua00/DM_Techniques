source("ReadData.R")
source("Regression_preprocessing.R")
source("Helper_Functions.R")
# source("CreateMovingAverages.R")

PreData_df = as.data.frame(PreData)
##########################################
# convert saturdays to 1; all other days to 0
func_saturday_only <- function (day) {
  if(day == "Saturday") 
    return(1)
  else 
    return(0)

}
PreData_df$saturday = lapply(PreData_df$weekday, func_saturday_only)
PreData_df$weekday = NULL
##########################################

##########################################
# add mav's of 2
PreData_df$ma2_interp_mood<- PreData_df[,.(ma2 = as.numeric(get.mav(interp_mood, n = 2))), by = id] [, 2]
PreData_df$ma2_interp_arousal<- PreData_df[,.(ma2 = as.numeric(get.mav(interp_arousal, n = 2))), by = id] [, 2]
PreData_df$ma2_interp_valence<- PreData_df[,.(ma2 = as.numeric(get.mav(interp_valence, n = 2))), by = id] [, 2]
PreData_df$ma2_agg_office<- PreData_df[,.(ma2 = as.numeric(get.mav(agg_office, n = 2))), by = id] [, 2]
PreData_df$ma2_agg_activity <- PreData_df[,.(ma2 = as.numeric(get.mav(agg_activity, n = 2))), by = id] [, 2]
PreData_df$ma2_agg_utilities<- PreData_df[,.(ma2 = as.numeric(get.mav(agg_utilities, n = 2))), by = id] [, 2]
PreData_df$ma2_agg_count_entertainment <- PreData_df[,.(ma2 = as.numeric(get.mav(agg_count_entertainment, n = 2))), by = id] [, 2]
PreData_df$ma2_agg_count_office <- PreData_df[,.(ma2 = as.numeric(get.mav(agg_count_office, n = 2))), by = id] [, 2]
PreData_df$interp_arousal = NULL
PreData_df$interp_valence = NULL
PreData_df$agg_office = NULL
PreData_df$agg_activity = NULL
PreData_df$agg_utilities = NULL
PreData_df$agg_count_entertainment = NULL
PreData_df$agg_count_office = NULL
##########################################

##########################################
# lag saturday by 1 day: if the day we predict would be saturday, we want to tell it to the model by having the previous day marked with '1'
PreData_df$lag_saturday <- PreData_df[,.(ma2 = as.numeric(get.mav(agg__count_office, n = 1))), by = id] [, 2]
##########################################

##########################################
# # split data
# data = splitdata_id(PreData_df)
# 
# train = data[1]
# valid = data[2]
# test = data[3]
##########################################

##########################################
# perform svm 
PreData_df$date = NULL
PreData_df$id = NULL
PreData_df$saturday = NULL # because I'm getting invalid type (list) for variable saturday all the time

# install.packages("e1071")
library("e1071")

main_var = c("interp_mood")

# x = subset(PreData_df, select = !(names(PreData_df) %in% main_var))
# y = subset(PreData_df, select = main_var)
x = subset(PreData_df, select = -interp_mood)
y = PreData_df$interp_mood

svm_model = svm(interp_mood ~ ., data=PreData_df)
# svm_model = svm(x, y)
# svm_model = svm(y ~ x, PreData_df)
summary(svm_model)

pred = predict(svm_model, x)
table(pred, y)
err = pred - y

# is.na(err)
cc = complete.cases(err)
num_missing = nrow(err) - sum(pred)

# mean(sqrt(err))
##########################################

##########################################
# attach(iris)
# x = subset(iris, select = -Species)
# y = Species
# svm_model = svm(Species ~ ., data=iris)
# summary(svm_model)
# pred = predict(svm_model, x)
# table(pred, y)
##########################################




