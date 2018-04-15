######################################
#AGGREGATE DATA (DAILY LEVEL)
#make sure that newdata is loaded in environment - from ReadData.R

#This syntax: 
# - creates interesting variables
# - aggregates the data
# - prepares the data for modelling
######################################


######################################
#Install packages, if not available
# install.packages("zoo")
######################################

######################################
#Load package
library(zoo)
######################################



######################################
# Create variables number of times each
# application was open throughout the day (use the sum in aggregation to get this value). 
newdata$count_value.appCat.builtin <- ifelse(is.na(newdata$value.appCat.builtin) == FALSE,
                                             newdata$count_value.appCat.builtin <- 1,
                                             newdata$count_value.appCat.builtin <- 0)

newdata$count_value.appCat.communication <- ifelse(is.na(newdata$value.appCat.communication) == FALSE,
                                                   newdata$count_value.appCat.communication <- 1,
                                                   newdata$count_value.appCat.communication <- 0)

newdata$count_value.appCat.entertainment <- ifelse(is.na(newdata$value.appCat.entertainment) == FALSE,
                                                   newdata$count_value.appCat.entertainment <- 1,
                                                   newdata$count_value.appCat.entertainment <- 0)

newdata$count_value.appCat.finance <- ifelse(is.na(newdata$value.appCat.finance) == FALSE,
                                            newdata$count_value.appCat.finance <- 1,
                                            newdata$count_value.appCat.finance <- 0)

newdata$count_value.appCat.game <- ifelse(is.na(newdata$value.appCat.game) == FALSE,
                                          newdata$count_value.appCat.game <- 1,
                                          newdata$count_value.appCat.game <- 0)

newdata$count_value.appCat.office <- ifelse(is.na(newdata$value.appCat.office) == FALSE,
                                            newdata$count_value.appCat.office <- 1,
                                            newdata$count_value.appCat.office <- 0)

newdata$count_value.appCat.other <- ifelse(is.na(newdata$value.appCat.other) == FALSE,
                                           newdata$count_value.appCat.other <- 1,
                                           newdata$count_value.appCat.other <- 0)

newdata$count_value.appCat.social <- ifelse(is.na(newdata$value.appCat.social) == FALSE,
                                            newdata$count_value.appCat.social <- 1,
                                            newdata$count_value.appCat.social <- 0)

newdata$count_value.appCat.travel <- ifelse(is.na(newdata$value.appCat.travel) == FALSE,
                                            newdata$count_value.appCat.travel <- 1,
                                            newdata$count_value.appCat.travel <- 0)

newdata$count_value.appCat.unknown <- ifelse(is.na(newdata$value.appCat.unknown) == FALSE,
                                             newdata$count_value.appCat.unknown <- 1,
                                             newdata$count_value.appCat.unknown <- 0)

newdata$count_value.appCat.utilities <- ifelse(is.na(newdata$value.appCat.utilities) == FALSE,
                                               newdata$count_value.appCat.utilities <- 1,
                                               newdata$count_value.appCat.utilities <- 0)

newdata$count_value.appCat.weather <- ifelse(is.na(newdata$value.appCat.weather) == FALSE,
                                             newdata$count_value.appCat.weather <- 1,
                                             newdata$count_value.appCat.weather <- 0)


######################################




######################################
# Aggregate data on by day and id. 
aggData = newdata[, .(count = .N, 
                      agg_mood = mean(value.mood, na.rm=TRUE),
                      agg_arousal = mean(value.circumplex.arousal, na.rm=TRUE),
                      agg_valence = mean(value.circumplex.valence, na.rm=TRUE),
                      agg_activity = mean(value.activity, na.rm=TRUE),
                      agg_screen = mean(value.screen, na.rm=TRUE),
                      agg_call = sum(value.call, na.rm=TRUE),
                      agg_sms = sum(value.sms, na.rm=TRUE),
                      agg_builtin = mean(value.appCat.builtin, na.rm=TRUE),
                      agg_communication = mean(value.appCat.communication, na.rm=TRUE),
                      agg_entertainment = mean(value.appCat.entertainment, na.rm=TRUE),
                      agg_finance = mean(value.appCat.finance, na.rm=TRUE),
                      agg_game = mean(value.appCat.game, na.rm=TRUE),
                      agg_office = mean(value.appCat.office, na.rm=TRUE),
                      agg_other = mean(value.appCat.other, na.rm=TRUE),
                      agg_social = mean(value.appCat.social, na.rm=TRUE),
                      agg_travel = mean(value.appCat.travel, na.rm=TRUE),
                      agg_unknown = mean(value.appCat.unknown, na.rm=TRUE),
                      agg_utilities = mean(value.appCat.utilities, na.rm=TRUE),
                      agg_weather = mean(value.appCat.weather, na.rm=TRUE), 
                      agg_count_builtin = sum(count_value.appCat.builtin, na.rm=TRUE), 
                      agg_count_communication = sum(count_value.appCat.communication, na.rm=TRUE), 
                      agg_count_entertainment = sum(count_value.appCat.entertainment, na.rm=TRUE),
                      agg_count_finance = sum(count_value.appCat.finance, na.rm=TRUE),
                      agg_count_game = sum(count_value.appCat.game, na.rm=TRUE),
                      agg_count_office = sum(count_value.appCat.office, na.rm=TRUE),
                      agg_count_other = sum(count_value.appCat.other, na.rm=TRUE),
                      agg_count_social = sum(count_value.appCat.social, na.rm=TRUE),
                      agg_count_travel = sum(count_value.appCat.travel, na.rm=TRUE),
                      agg_count_unknown = sum(count_value.appCat.unknown, na.rm=TRUE),
                      agg_count_utilities = sum(count_value.appCat.utilities, na.rm=TRUE),
                      agg_count_weather = sum(count_value.appCat.weather, na.rm=TRUE)),
                  by = .(id, date)]

######################################
# Include other more interesting variables
# Add weekday
aggData$weekday <- weekdays(aggData$date)

# Count number of different applications used per day
aggData$open_count <- aggData[,apply(X = aggData[, 11:22], MARGIN = 1, FUN = function(x) sum(!is.nan(x)))]
######################################



######################################
#Exclude data with missing Mood
PreData <- subset(aggData, (!is.nan(aggData[, aggData$agg_mood]) | !is.nan(aggData[, aggData$agg_screen]) ))
######################################


######################################
#Interpolate missing values for mood, arousal and valence
PreData$interp_mood <- na.approx(PreData$agg_mood, na.rm = FALSE)
PreData$interp_arousal <- na.approx(PreData$agg_arousal, na.rm = FALSE)
PreData$interp_valence <- na.approx(PreData$agg_valence, na.rm = FALSE)

#remove non interpolated variables
PreData$agg_mood <- NULL
PreData$agg_arousal <- NULL
PreData$agg_valence <- NULL
######################################


######################################
#Visualise correlations
ggcorr(data = PreData, label = TRUE, label_alpha = TRUE, label_size = 2.3, label_round = 2, 
       hjust = 0.9, size = 3)
######################################
