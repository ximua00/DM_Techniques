######################################
# CREATE MOVING AVERAGES
# (make sure that PreData is in environment - from ReadData.R)

#This syntax: 
# - Create moving averages (2, 5, 7) for all variables
######################################


######################################
#Load helper functions
source("./Helper_Functions.R")
######################################



######################################
#Create MA variables

PreData$ma2_agg_sms<- PreData[,.(ma2 = as.numeric(get.mav(agg_sms, n = 2))), by = id] [, 2]
PreData$ma2_agg_entertainment<- PreData[,.(ma2 = as.numeric(get.mav(agg_entertainment, n = 2))), by = id] [, 2]
PreData$ma2_agg_office<- PreData[,.(ma2 = as.numeric(get.mav(agg_office, n = 2))), by = id] [, 2]
PreData$ma2_agg_travel<- PreData[,.(ma2 = as.numeric(get.mav(agg_travel, n = 2))), by = id] [, 2]
PreData$ma2_agg_weather<- PreData[,.(ma2 = as.numeric(get.mav(agg_weather, n = 2))), by = id] [, 2]
PreData$ma2_agg_count_entertainment<- PreData[,.(ma2 = as.numeric(get.mav(agg_count_entertainment, n = 2))), by = id] [, 2]
PreData$ma2_agg_count_office<- PreData[,.(ma2 = as.numeric(get.mav(agg_count_office, n = 2))), by = id] [, 2]
PreData$ma2_agg_count_travel<- PreData[,.(ma2 = as.numeric(get.mav(agg_count_travel, n = 2))), by = id] [, 2]
PreData$ma2_agg_count_weather<- PreData[,.(ma2 = as.numeric(get.mav(agg_count_weather, n = 2))), by = id] [, 2]
PreData$ma2_interp_mood<- PreData[,.(ma2 = as.numeric(get.mav(interp_mood, n = 2))), by = id] [, 2]
PreData$ma2_agg_screen<- PreData[,.(ma2 = as.numeric(get.mav(agg_screen, n = 2))), by = id] [, 2]

PreData$ma2_agg_finance<- PreData[,.(ma2 = as.numeric(get.mav(agg_finance, n = 2))), by = id] [, 2]
PreData$ma2_agg_other<- PreData[,.(ma2 = as.numeric(get.mav(agg_other, n = 2))), by = id] [, 2]
PreData$ma2_agg_unknown<- PreData[,.(ma2 = as.numeric(get.mav(agg_unknown, n = 2))), by = id] [, 2]
PreData$ma2_agg_count_builtin<- PreData[,.(ma2 = as.numeric(get.mav(agg_count_builtin, n = 2))), by = id] [, 2]
PreData$ma2_agg_count_finance<- PreData[,.(ma2 = as.numeric(get.mav(agg_count_finance, n = 2))), by = id] [, 2]
PreData$ma2_agg_count_other<- PreData[,.(ma2 = as.numeric(get.mav(agg_count_other, n = 2))), by = id] [, 2]
PreData$ma2_agg_count_unknown<- PreData[,.(ma2 = as.numeric(get.mav(agg_count_unknown, n = 2))), by = id] [, 2]
PreData$ma2_interp_arousal<- PreData[,.(ma2 = as.numeric(get.mav(interp_arousal, n = 2))), by = id] [, 2]
PreData$ma2_agg_call<- PreData[,.(ma2 = as.numeric(get.mav(agg_call, n = 2))), by = id] [, 2]
PreData$ma2_agg_communication<- PreData[,.(ma2 = as.numeric(get.mav(agg_communication, n = 2))), by = id] [, 2]
PreData$ma2_agg_game<- PreData[,.(ma2 = as.numeric(get.mav(agg_game, n = 2))), by = id] [, 2]
PreData$ma2_agg_social<- PreData[,.(ma2 = as.numeric(get.mav(agg_social, n = 2))), by = id] [, 2]
PreData$ma2_agg_utilities<- PreData[,.(ma2 = as.numeric(get.mav(agg_utilities, n = 2))), by = id] [, 2]
PreData$ma2_agg_count_communication<- PreData[,.(ma2 = as.numeric(get.mav(agg_count_communication, n = 2))), by = id] [, 2]
PreData$ma2_agg_count_game<- PreData[,.(ma2 = as.numeric(get.mav(agg_count_game, n = 2))), by = id] [, 2]
PreData$ma2_agg_count_social<- PreData[,.(ma2 = as.numeric(get.mav(agg_count_social, n = 2))), by = id] [, 2]
PreData$ma2_agg_count_utilities<- PreData[,.(ma2 = as.numeric(get.mav(agg_count_utilities, n = 2))), by = id] [, 2]
PreData$ma2_interp_valence<- PreData[,.(ma2 = as.numeric(get.mav(interp_valence, n = 2))), by = id] [, 2]


PreData$ma5_agg_sms<- PreData[,.(ma5 = as.numeric(get.mav(agg_sms, n = 5))), by = id] [, 2]
PreData$ma5_agg_entertainment<- PreData[,.(ma5 = as.numeric(get.mav(agg_entertainment, n = 5))), by = id] [, 2]
PreData$ma5_agg_office<- PreData[,.(ma5 = as.numeric(get.mav(agg_office, n = 5))), by = id] [, 2]
PreData$ma5_agg_travel<- PreData[,.(ma5 = as.numeric(get.mav(agg_travel, n = 5))), by = id] [, 2]
PreData$ma5_agg_weather<- PreData[,.(ma5 = as.numeric(get.mav(agg_weather, n = 5))), by = id] [, 2]
PreData$ma5_agg_count_entertainment<- PreData[,.(ma5 = as.numeric(get.mav(agg_count_entertainment, n = 5))), by = id] [, 2]
PreData$ma5_agg_count_office<- PreData[,.(ma5 = as.numeric(get.mav(agg_count_office, n = 5))), by = id] [, 2]
PreData$ma5_agg_count_travel<- PreData[,.(ma5 = as.numeric(get.mav(agg_count_travel, n = 5))), by = id] [, 2]
PreData$ma5_agg_count_weather<- PreData[,.(ma5 = as.numeric(get.mav(agg_count_weather, n = 5))), by = id] [, 2]
PreData$ma5_interp_mood<- PreData[,.(ma5 = as.numeric(get.mav(interp_mood, n = 5))), by = id] [, 2]
PreData$ma5_agg_screen<- PreData[,.(ma5 = as.numeric(get.mav(agg_screen, n = 5))), by = id] [, 2]
PreData$ma5_agg_finance<- PreData[,.(ma5 = as.numeric(get.mav(agg_finance, n = 5))), by = id] [, 2]
PreData$ma5_agg_other<- PreData[,.(ma5 = as.numeric(get.mav(agg_other, n = 5))), by = id] [, 2]
PreData$ma5_agg_unknown<- PreData[,.(ma5 = as.numeric(get.mav(agg_unknown, n = 5))), by = id] [, 2]
PreData$ma5_agg_count_builtin<- PreData[,.(ma5 = as.numeric(get.mav(agg_count_builtin, n = 5))), by = id] [, 2]
PreData$ma5_agg_count_finance<- PreData[,.(ma5 = as.numeric(get.mav(agg_count_finance, n = 5))), by = id] [, 2]
PreData$ma5_agg_count_other<- PreData[,.(ma5 = as.numeric(get.mav(agg_count_other, n = 5))), by = id] [, 2]
PreData$ma5_agg_count_unknown<- PreData[,.(ma5 = as.numeric(get.mav(agg_count_unknown, n = 5))), by = id] [, 2]
PreData$ma5_interp_arousal<- PreData[,.(ma5 = as.numeric(get.mav(interp_arousal, n = 5))), by = id] [, 2]
PreData$ma5_agg_call<- PreData[,.(ma5 = as.numeric(get.mav(agg_call, n = 5))), by = id] [, 2]
PreData$ma5_agg_communication<- PreData[,.(ma5 = as.numeric(get.mav(agg_communication, n = 5))), by = id] [, 2]
PreData$ma5_agg_game<- PreData[,.(ma5 = as.numeric(get.mav(agg_game, n = 5))), by = id] [, 2]
PreData$ma5_agg_social<- PreData[,.(ma5 = as.numeric(get.mav(agg_social, n = 5))), by = id] [, 2]
PreData$ma5_agg_utilities<- PreData[,.(ma5 = as.numeric(get.mav(agg_utilities, n = 5))), by = id] [, 2]
PreData$ma5_agg_count_communication<- PreData[,.(ma5 = as.numeric(get.mav(agg_count_communication, n = 5))), by = id] [, 2]
PreData$ma5_agg_count_game<- PreData[,.(ma5 = as.numeric(get.mav(agg_count_game, n = 5))), by = id] [, 2]
PreData$ma5_agg_count_social<- PreData[,.(ma5 = as.numeric(get.mav(agg_count_social, n = 5))), by = id] [, 2]
PreData$ma5_agg_count_utilities<- PreData[,.(ma5 = as.numeric(get.mav(agg_count_utilities, n = 5))), by = id] [, 2]
PreData$ma5_interp_valence<- PreData[,.(ma5 = as.numeric(get.mav(interp_valence, n = 5))), by = id] [, 2]


PreData$ma7_agg_sms<- PreData[,.(ma7 = as.numeric(get.mav(agg_sms, n = 7))), by = id] [, 2]
PreData$ma7_agg_entertainment<- PreData[,.(ma7 = as.numeric(get.mav(agg_entertainment, n = 7))), by = id] [, 2]
PreData$ma7_agg_office<- PreData[,.(ma7 = as.numeric(get.mav(agg_office, n = 7))), by = id] [, 2]
PreData$ma7_agg_travel<- PreData[,.(ma7 = as.numeric(get.mav(agg_travel, n = 7))), by = id] [, 2]
PreData$ma7_agg_weather<- PreData[,.(ma7 = as.numeric(get.mav(agg_weather, n = 7))), by = id] [, 2]
PreData$ma7_agg_count_entertainment<- PreData[,.(ma7 = as.numeric(get.mav(agg_count_entertainment, n = 7))), by = id] [, 2]
PreData$ma7_agg_count_office<- PreData[,.(ma7 = as.numeric(get.mav(agg_count_office, n = 7))), by = id] [, 2]
PreData$ma7_agg_count_travel<- PreData[,.(ma7 = as.numeric(get.mav(agg_count_travel, n = 7))), by = id] [, 2]
PreData$ma7_agg_count_weather<- PreData[,.(ma7 = as.numeric(get.mav(agg_count_weather, n = 7))), by = id] [, 2]
PreData$ma7_interp_mood<- PreData[,.(ma7 = as.numeric(get.mav(interp_mood, n = 7))), by = id] [, 2]
PreData$ma7_agg_screen<- PreData[,.(ma7 = as.numeric(get.mav(agg_screen, n = 7))), by = id] [, 2]

PreData$ma7_agg_finance<- PreData[,.(ma7 = as.numeric(get.mav(agg_finance, n = 7))), by = id] [, 2]
PreData$ma7_agg_other<- PreData[,.(ma7 = as.numeric(get.mav(agg_other, n = 7))), by = id] [, 2]
PreData$ma7_agg_unknown<- PreData[,.(ma7 = as.numeric(get.mav(agg_unknown, n = 7))), by = id] [, 2]
PreData$ma7_agg_count_builtin<- PreData[,.(ma7 = as.numeric(get.mav(agg_count_builtin, n = 7))), by = id] [, 2]
PreData$ma7_agg_count_finance<- PreData[,.(ma7 = as.numeric(get.mav(agg_count_finance, n = 7))), by = id] [, 2]
PreData$ma7_agg_count_other<- PreData[,.(ma7 = as.numeric(get.mav(agg_count_other, n = 7))), by = id] [, 2]
PreData$ma7_agg_count_unknown<- PreData[,.(ma7 = as.numeric(get.mav(agg_count_unknown, n = 7))), by = id] [, 2]
PreData$ma7_interp_arousal<- PreData[,.(ma7 = as.numeric(get.mav(interp_arousal, n = 7))), by = id] [, 2]
PreData$ma7_agg_call<- PreData[,.(ma7 = as.numeric(get.mav(agg_call, n = 7))), by = id] [, 2]
PreData$ma7_agg_communication<- PreData[,.(ma7 = as.numeric(get.mav(agg_communication, n = 7))), by = id] [, 2]
PreData$ma7_agg_game<- PreData[,.(ma7 = as.numeric(get.mav(agg_game, n = 7))), by = id] [, 2]
PreData$ma7_agg_social<- PreData[,.(ma7 = as.numeric(get.mav(agg_social, n = 7))), by = id] [, 2]
PreData$ma7_agg_utilities<- PreData[,.(ma7 = as.numeric(get.mav(agg_utilities, n = 7))), by = id] [, 2]
PreData$ma7_agg_count_communication<- PreData[,.(ma7 = as.numeric(get.mav(agg_count_communication, n = 7))), by = id] [, 2]
PreData$ma7_agg_count_game<- PreData[,.(ma7 = as.numeric(get.mav(agg_count_game, n = 7))), by = id] [, 2]
PreData$ma7_agg_count_social<- PreData[,.(ma7 = as.numeric(get.mav(agg_count_social, n = 7))), by = id] [, 2]
PreData$ma7_agg_count_utilities<- PreData[,.(ma7 = as.numeric(get.mav(agg_count_utilities, n = 7))), by = id] [, 2]
PreData$ma7_interp_valence<- PreData[,.(ma7 = as.numeric(get.mav(interp_valence, n = 7))), by = id] [, 2]