######################################
# PREPROCESS DATA FOR MODELLING
# (make sure that PreData is in environment - from AggregateData.R)

#This syntax: 
# - Deletes correlated variables
# - deals with missing values
# - makes Lags and Moving Averages Variables
######################################


######################################
#Load helper functions
source("./Helper_Functions.R")
######################################



######################################
# Delete Highly correlated Variables
# 1 - Delete count because no informative values
PreData$count <- NULL

# 2 - Delete either count_built_in or open count
# Choose agg_count_builtin because 
PreData$agg_builtin <- NULL

#Visualise correlations after changes
ggcorr(data = PreData, label = TRUE, label_alpha = TRUE, label_size = 2.3, label_round = 2, 
       hjust = 0.9, size = 3)
######################################


######################################
#Check Variable filling
#Replace with 0's since we are dealing with time
PreData[is.na(PreData)] <- 0
######################################



######################################
#Make lag Variables
PreData$lag_mood = PreData[, .(lag_mood = shift(interp_mood)), by = id][, 2]
PreData$lag_arousal = PreData[, .(lag_arousal = shift(interp_arousal)), by = id][, 2]
PreData$lag_valence = PreData[, .(lag_valence = shift(interp_valence)), by = id][, 2]
PreData$lag_activity = PreData[, .(lag_activity = shift(agg_activity)), by = id][, 2]
PreData$lag_screen = PreData[, .(lag_screen = shift(agg_screen)), by = id][, 2]
PreData$lag_call = PreData[, .(lag_call = shift(agg_call)), by = id][, 2]
PreData$lag_sms = PreData[, .(lag_sms = shift(agg_sms)), by = id][, 2]
PreData$lag_communication = PreData[, .(lag_communication = shift(agg_communication)), by = id][, 2]
PreData$lag_entertainment = PreData[, .(lag_entertainment = shift(agg_entertainment)), by = id][, 2]
PreData$lag_finance = PreData[, .(lag_finance = shift(agg_finance)), by = id][, 2]
PreData$lag_game = PreData[, .(lag_game = shift(agg_game)), by = id][, 2]
PreData$lag_office = PreData[, .(lag_office = shift(agg_office)), by = id][, 2]
PreData$lag_other = PreData[, .(lag_other = shift(agg_other)), by = id][, 2]
PreData$lag_social = PreData[, .(lag_social = shift(agg_social)), by = id][, 2]
PreData$lag_travel = PreData[, .(lag_travel = shift(agg_travel)), by = id][, 2]
PreData$lag_unknown = PreData[, .(lag_unknown = shift(agg_unknown)), by = id][, 2]
PreData$lag_utilities = PreData[, .(lag_utilities = shift(agg_utilities)), by = id][, 2]
PreData$lag_weather = PreData[, .(lag_weather = shift(agg_weather)), by = id][, 2]
PreData$lag_count_builtin = PreData[, .(lag_count_builtin = shift(agg_count_builtin)), by = id][, 2]
PreData$lag_count_communication = PreData[, .(lag_count_communication = shift(agg_count_communication)), by = id][, 2]
PreData$lag_count_entertainment = PreData[, .(lag_count_entertainment = shift(agg_count_entertainment)), by = id][, 2]
PreData$lag_count_finance = PreData[, .(lag_count_finance = shift(agg_count_finance)), by = id][, 2]
PreData$lag_count_game = PreData[, .(lag_count_game = shift(agg_count_game)), by = id][, 2]
PreData$lag_count_office = PreData[, .(lag_count_office = shift(agg_count_office)), by = id][, 2]
PreData$lag_count_other = PreData[, .(lag_count_other = shift(agg_count_other)), by = id][, 2]
PreData$lag_count_social = PreData[, .(lag_count_social = shift(agg_count_social)), by = id][, 2]
PreData$lag_count_travel = PreData[, .(lag_count_travel = shift(agg_count_travek)), by = id][, 2]
PreData$lag_count_unknown = PreData[, .(lag_count_unknown = shift(agg_count_unknown)), by = id][, 2]
PreData$lag_count_utilities = PreData[, .(lag_count_utilities = shift(agg_count_utlities)), by = id][, 2]
PreData$lag_count_weather = PreData[, .(lag_count_weather = shift(agg_count_weather)), by = id][, 2]
PreData$lag_open_count = PreData[, .(lag_open_count = shift(open_count)), by = id][, 2]


#Delete unnecessary (current t) variables
PreData$agg_screen <- NULL
PreData$agg_communication <- NULL
PreData$agg_game <- NULL
PreData$agg_social <- NULL
PreData$agg_utilities <- NULL
PreData$agg_count_entertainment <- NULL
PreData$agg_count_office <- NULL
PreData$agg_count_travel <- NULL
PreData$agg_count_weather <- NULL
PreData$agg_call <- NULL
PreData$agg_entertainment <- NULL
PreData$agg_office <- NULL
PreData$agg_travel <- NULL
PreData$agg_weather <- NULL
PreData$agg_count_finance <- NULL
PreData$agg_count_other <- NULL
PreData$agg_count_unknown <- NULL
PreData$agg_sms <- NULL
PreData$agg_finance <- NULL
PreData$agg_other <- NULL
PreData$agg_unknown <- NULL
PreData$agg_count_communication <- NULL
PreData$agg_count_game <- NULL
PreData$agg_count_social <- NULL
PreData$agg_count_utilities <- NULL


######################################

######################################




######################################
#Make Dummies for weekday
PreData_df <- as.data.frame(PreData)
for(level in unique(PreData_df$weekday)){
  PreData_df[paste("dummy", level, sep = "_")] <- ifelse(PreData_df$weekday == level, 1, 0)
}

#Delete weekday
PreData_df$weekday <- NULL

#Delete one dummy to avoid multicollinearity
PreData_df$dummy_Monday <- NULL
######################################

