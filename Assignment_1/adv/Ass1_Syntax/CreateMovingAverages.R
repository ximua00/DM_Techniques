
PreData$lag.1 <- PreData[, .(lag_ =  shift(interp_mood, n = 1)), 
                                 by = id][, 2]
PreData$lag.2 <- PreData[, .(lag_ =  shift(interp_mood, n = 2)),
                                 by = id][, 2] 
PreData$lag.3 <- PreData[, .(lag_ =  shift(interp_mood, n = 3)),
                                 by = id][, 2] 
PreData$lag.4 <- PreData[, .(lag_ =  shift(interp_mood, n = 4)),
                                 by = id][, 2] 
PreData$lag.5 <- PreData[, .(lag_ =  shift(interp_mood, n = 5)),
                                 by = id][, 2] 
PreData$lag.6 <- PreData[, .(lag_ =  shift(interp_mood, n = 6)),
                                 by = id][, 2] 
PreData$lag.7 <- PreData[, .(lag_ =  shift(interp_mood, n = 7)),
                                 by = id][, 2] 

PreData[,`:=` (ma2_interp_mood = apply(.SD, 1, mean)),
          by = id, 
          .SDcols = c("lag.1", "lag.2")]

PreData[,`:=` (ma5_interp_mood = apply(.SD, 1, mean)),
          by = id, 
          .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5")]

PreData[,`:=` (ma7_interp_mood = apply(.SD, 1, mean)),
          by = id, 
          .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7")]

PreData <- PreData[, c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7") := NULL]






PreData$lag.1 <- PreData[, .(lag_ =  shift(agg_activity, n = 1)), 
                         by = id][, 2]
PreData$lag.2 <- PreData[, .(lag_ =  shift(agg_activity, n = 2)),
                         by = id][, 2] 
PreData$lag.3 <- PreData[, .(lag_ =  shift(agg_activity, n = 3)),
                         by = id][, 2] 
PreData$lag.4 <- PreData[, .(lag_ =  shift(agg_activity, n = 4)),
                         by = id][, 2] 
PreData$lag.5 <- PreData[, .(lag_ =  shift(agg_activity, n = 5)),
                         by = id][, 2] 
PreData$lag.6 <- PreData[, .(lag_ =  shift(agg_activity, n = 6)),
                         by = id][, 2] 
PreData$lag.7 <- PreData[, .(lag_ =  shift(agg_activity, n = 7)),
                         by = id][, 2] 

PreData[,`:=` (ma2_agg_activity = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2")]

PreData[,`:=` (ma5_agg_activity = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5")]

PreData[,`:=` (ma7_agg_activity = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7")]

PreData <- PreData[, c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7") := NULL]







PreData$lag.1 <- PreData[, .(lag_ =  shift(agg_screen, n = 1)), 
                         by = id][, 2]
PreData$lag.2 <- PreData[, .(lag_ =  shift(agg_screen, n = 2)),
                         by = id][, 2] 
PreData$lag.3 <- PreData[, .(lag_ =  shift(agg_screen, n = 3)),
                         by = id][, 2] 
PreData$lag.4 <- PreData[, .(lag_ =  shift(agg_screen, n = 4)),
                         by = id][, 2] 
PreData$lag.5 <- PreData[, .(lag_ =  shift(agg_screen, n = 5)),
                         by = id][, 2] 
PreData$lag.6 <- PreData[, .(lag_ =  shift(agg_screen, n = 6)),
                         by = id][, 2] 
PreData$lag.7 <- PreData[, .(lag_ =  shift(agg_screen, n = 7)),
                         by = id][, 2] 

PreData[,`:=` (ma2_agg_screen = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2")]

PreData[,`:=` (ma5_agg_screen = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5")]

PreData[,`:=` (ma7_agg_screen = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7")]

PreData <- PreData[, c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7") := NULL]






PreData$lag.1 <- PreData[, .(lag_ =  shift(agg_call, n = 1)), 
                         by = id][, 2]
PreData$lag.2 <- PreData[, .(lag_ =  shift(agg_call, n = 2)),
                         by = id][, 2] 
PreData$lag.3 <- PreData[, .(lag_ =  shift(agg_call, n = 3)),
                         by = id][, 2] 
PreData$lag.4 <- PreData[, .(lag_ =  shift(agg_call, n = 4)),
                         by = id][, 2] 
PreData$lag.5 <- PreData[, .(lag_ =  shift(agg_call, n = 5)),
                         by = id][, 2] 
PreData$lag.6 <- PreData[, .(lag_ =  shift(agg_call, n = 6)),
                         by = id][, 2] 
PreData$lag.7 <- PreData[, .(lag_ =  shift(agg_call, n = 7)),
                         by = id][, 2] 

PreData[,`:=` (ma2_agg_call = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2")]

PreData[,`:=` (ma5_agg_call = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5")]

PreData[,`:=` (ma7_agg_call = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7")]

PreData <- PreData[, c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7") := NULL]





PreData$lag.1 <- PreData[, .(lag_ =  shift(agg_sms, n = 1)), 
                         by = id][, 2]
PreData$lag.2 <- PreData[, .(lag_ =  shift(agg_sms, n = 2)),
                         by = id][, 2] 
PreData$lag.3 <- PreData[, .(lag_ =  shift(agg_sms, n = 3)),
                         by = id][, 2] 
PreData$lag.4 <- PreData[, .(lag_ =  shift(agg_sms, n = 4)),
                         by = id][, 2] 
PreData$lag.5 <- PreData[, .(lag_ =  shift(agg_sms, n = 5)),
                         by = id][, 2] 
PreData$lag.6 <- PreData[, .(lag_ =  shift(agg_sms, n = 6)),
                         by = id][, 2] 
PreData$lag.7 <- PreData[, .(lag_ =  shift(agg_sms, n = 7)),
                         by = id][, 2] 

PreData[,`:=` (ma2_agg_sms= apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2")]

PreData[,`:=` (ma5_agg_sms = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5")]

PreData[,`:=` (ma7_agg_sms = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7")]

PreData <- PreData[, c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7") := NULL]




PreData$lag.1 <- PreData[, .(lag_ =  shift(agg_communication, n = 1)), 
                         by = id][, 2]
PreData$lag.2 <- PreData[, .(lag_ =  shift(agg_communication, n = 2)),
                         by = id][, 2] 
PreData$lag.3 <- PreData[, .(lag_ =  shift(agg_communication, n = 3)),
                         by = id][, 2] 
PreData$lag.4 <- PreData[, .(lag_ =  shift(agg_communication, n = 4)),
                         by = id][, 2] 
PreData$lag.5 <- PreData[, .(lag_ =  shift(agg_communication, n = 5)),
                         by = id][, 2] 
PreData$lag.6 <- PreData[, .(lag_ =  shift(agg_communication, n = 6)),
                         by = id][, 2] 
PreData$lag.7 <- PreData[, .(lag_ =  shift(agg_communication, n = 7)),
                         by = id][, 2] 

PreData[,`:=` (ma2_agg_communication = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2")]

PreData[,`:=` (ma5_agg_communication = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5")]

PreData[,`:=` (ma7_agg_communication = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7")]

PreData <- PreData[, c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7") := NULL]




PreData$lag.1 <- PreData[, .(lag_ =  shift(agg_entertainment, n = 1)), 
                         by = id][, 2]
PreData$lag.2 <- PreData[, .(lag_ =  shift(agg_entertainment, n = 2)),
                         by = id][, 2] 
PreData$lag.3 <- PreData[, .(lag_ =  shift(agg_entertainment, n = 3)),
                         by = id][, 2] 
PreData$lag.4 <- PreData[, .(lag_ =  shift(agg_entertainment, n = 4)),
                         by = id][, 2] 
PreData$lag.5 <- PreData[, .(lag_ =  shift(agg_entertainment, n = 5)),
                         by = id][, 2] 
PreData$lag.6 <- PreData[, .(lag_ =  shift(agg_entertainment, n = 6)),
                         by = id][, 2] 
PreData$lag.7 <- PreData[, .(lag_ =  shift(agg_entertainment, n = 7)),
                         by = id][, 2] 

PreData[,`:=` (ma2_agg_entertainment = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2")]

PreData[,`:=` (ma5_agg_entertainment = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5")]

PreData[,`:=` (ma7_agg_entertainment = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7")]

PreData <- PreData[, c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7") := NULL]




PreData$lag.1 <- PreData[, .(lag_ =  shift(agg_finance, n = 1)), 
                         by = id][, 2]
PreData$lag.2 <- PreData[, .(lag_ =  shift(agg_finance, n = 2)),
                         by = id][, 2] 
PreData$lag.3 <- PreData[, .(lag_ =  shift(agg_finance, n = 3)),
                         by = id][, 2] 
PreData$lag.4 <- PreData[, .(lag_ =  shift(agg_finance, n = 4)),
                         by = id][, 2] 
PreData$lag.5 <- PreData[, .(lag_ =  shift(agg_finance, n = 5)),
                         by = id][, 2] 
PreData$lag.6 <- PreData[, .(lag_ =  shift(agg_finance, n = 6)),
                         by = id][, 2] 
PreData$lag.7 <- PreData[, .(lag_ =  shift(agg_finance, n = 7)),
                         by = id][, 2] 

PreData[,`:=` (ma2_agg_finance = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2")]

PreData[,`:=` (ma5_agg_finance = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5")]

PreData[,`:=` (ma7_agg_finance = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7")]

PreData <- PreData[, c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7") := NULL]




PreData$lag.1 <- PreData[, .(lag_ =  shift(agg_game, n = 1)), 
                         by = id][, 2]
PreData$lag.2 <- PreData[, .(lag_ =  shift(agg_game, n = 2)),
                         by = id][, 2] 
PreData$lag.3 <- PreData[, .(lag_ =  shift(agg_game, n = 3)),
                         by = id][, 2] 
PreData$lag.4 <- PreData[, .(lag_ =  shift(agg_game, n = 4)),
                         by = id][, 2] 
PreData$lag.5 <- PreData[, .(lag_ =  shift(agg_game, n = 5)),
                         by = id][, 2] 
PreData$lag.6 <- PreData[, .(lag_ =  shift(agg_game, n = 6)),
                         by = id][, 2] 
PreData$lag.7 <- PreData[, .(lag_ =  shift(agg_game, n = 7)),
                         by = id][, 2] 

PreData[,`:=` (ma2_agg_game = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2")]

PreData[,`:=` (ma5_agg_game = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5")]

PreData[,`:=` (ma7_agg_game = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7")]

PreData <- PreData[, c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7") := NULL]



PreData$lag.1 <- PreData[, .(lag_ =  shift(agg_office, n = 1)), 
                         by = id][, 2]
PreData$lag.2 <- PreData[, .(lag_ =  shift(agg_office, n = 2)),
                         by = id][, 2] 
PreData$lag.3 <- PreData[, .(lag_ =  shift(agg_office, n = 3)),
                         by = id][, 2] 
PreData$lag.4 <- PreData[, .(lag_ =  shift(agg_office, n = 4)),
                         by = id][, 2] 
PreData$lag.5 <- PreData[, .(lag_ =  shift(agg_office, n = 5)),
                         by = id][, 2] 
PreData$lag.6 <- PreData[, .(lag_ =  shift(agg_office, n = 6)),
                         by = id][, 2] 
PreData$lag.7 <- PreData[, .(lag_ =  shift(agg_office, n = 7)),
                         by = id][, 2] 

PreData[,`:=` (ma2_agg_office = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2")]

PreData[,`:=` (ma5_agg_office = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5")]

PreData[,`:=` (ma7_agg_office = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7")]

PreData <- PreData[, c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7") := NULL]



PreData$lag.1 <- PreData[, .(lag_ =  shift(agg_other, n = 1)), 
                         by = id][, 2]
PreData$lag.2 <- PreData[, .(lag_ =  shift(agg_other, n = 2)),
                         by = id][, 2] 
PreData$lag.3 <- PreData[, .(lag_ =  shift(agg_other, n = 3)),
                         by = id][, 2] 
PreData$lag.4 <- PreData[, .(lag_ =  shift(agg_other, n = 4)),
                         by = id][, 2] 
PreData$lag.5 <- PreData[, .(lag_ =  shift(agg_other, n = 5)),
                         by = id][, 2] 
PreData$lag.6 <- PreData[, .(lag_ =  shift(agg_other, n = 6)),
                         by = id][, 2] 
PreData$lag.7 <- PreData[, .(lag_ =  shift(agg_other, n = 7)),
                         by = id][, 2] 

PreData[,`:=` (ma2_agg_other = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2")]

PreData[,`:=` (ma5_agg_other = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5")]

PreData[,`:=` (ma7_agg_other = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7")]

PreData <- PreData[, c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7") := NULL]



PreData$lag.1 <- PreData[, .(lag_ =  shift(agg_social, n = 1)), 
                         by = id][, 2]
PreData$lag.2 <- PreData[, .(lag_ =  shift(agg_social, n = 2)),
                         by = id][, 2] 
PreData$lag.3 <- PreData[, .(lag_ =  shift(agg_social, n = 3)),
                         by = id][, 2] 
PreData$lag.4 <- PreData[, .(lag_ =  shift(agg_social, n = 4)),
                         by = id][, 2] 
PreData$lag.5 <- PreData[, .(lag_ =  shift(agg_social, n = 5)),
                         by = id][, 2] 
PreData$lag.6 <- PreData[, .(lag_ =  shift(agg_social, n = 6)),
                         by = id][, 2] 
PreData$lag.7 <- PreData[, .(lag_ =  shift(agg_social, n = 7)),
                         by = id][, 2] 

PreData[,`:=` (ma2_agg_social = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2")]

PreData[,`:=` (ma5_agg_social = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5")]

PreData[,`:=` (ma7_agg_social = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7")]

PreData <- PreData[, c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7") := NULL]



PreData$lag.1 <- PreData[, .(lag_ =  shift(agg_travel, n = 1)), 
                         by = id][, 2]
PreData$lag.2 <- PreData[, .(lag_ =  shift(agg_travel, n = 2)),
                         by = id][, 2] 
PreData$lag.3 <- PreData[, .(lag_ =  shift(agg_travel, n = 3)),
                         by = id][, 2] 
PreData$lag.4 <- PreData[, .(lag_ =  shift(agg_travel, n = 4)),
                         by = id][, 2] 
PreData$lag.5 <- PreData[, .(lag_ =  shift(agg_travel, n = 5)),
                         by = id][, 2] 
PreData$lag.6 <- PreData[, .(lag_ =  shift(agg_travel, n = 6)),
                         by = id][, 2] 
PreData$lag.7 <- PreData[, .(lag_ =  shift(agg_travel, n = 7)),
                         by = id][, 2] 

PreData[,`:=` (ma2_agg_travel = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2")]

PreData[,`:=` (ma5_agg_travel = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5")]

PreData[,`:=` (ma7_agg_travel = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7")]

PreData <- PreData[, c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7") := NULL]


PreData$lag.1 <- PreData[, .(lag_ =  shift(interp_valence, n = 1)), 
                         by = id][, 2]
PreData$lag.2 <- PreData[, .(lag_ =  shift(interp_valence, n = 2)),
                         by = id][, 2] 
PreData$lag.3 <- PreData[, .(lag_ =  shift(interp_valence, n = 3)),
                         by = id][, 2] 
PreData$lag.4 <- PreData[, .(lag_ =  shift(interp_valence, n = 4)),
                         by = id][, 2] 
PreData$lag.5 <- PreData[, .(lag_ =  shift(interp_valence, n = 5)),
                         by = id][, 2] 
PreData$lag.6 <- PreData[, .(lag_ =  shift(interp_valence, n = 6)),
                         by = id][, 2] 
PreData$lag.7 <- PreData[, .(lag_ =  shift(interp_valence, n = 7)),
                         by = id][, 2] 

PreData[,`:=` (ma2_interp_valence = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2")]

PreData[,`:=` (ma5_interp_valence = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5")]

PreData[,`:=` (ma7_interp_valence = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7")]

PreData <- PreData[, c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7") := NULL]




PreData$lag.1 <- PreData[, .(lag_ =  shift(interp_arousal, n = 1)), 
                         by = id][, 2]
PreData$lag.2 <- PreData[, .(lag_ =  shift(interp_arousal, n = 2)),
                         by = id][, 2] 
PreData$lag.3 <- PreData[, .(lag_ =  shift(interp_arousal, n = 3)),
                         by = id][, 2] 
PreData$lag.4 <- PreData[, .(lag_ =  shift(interp_arousal, n = 4)),
                         by = id][, 2] 
PreData$lag.5 <- PreData[, .(lag_ =  shift(interp_arousal, n = 5)),
                         by = id][, 2] 
PreData$lag.6 <- PreData[, .(lag_ =  shift(interp_arousal, n = 6)),
                         by = id][, 2] 
PreData$lag.7 <- PreData[, .(lag_ =  shift(interp_arousal, n = 7)),
                         by = id][, 2] 

PreData[,`:=` (ma2_interp_arousal = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2")]

PreData[,`:=` (ma5_interp_arousal = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5")]

PreData[,`:=` (ma7_interp_arousal = apply(.SD, 1, mean)),
        by = id, 
        .SDcols = c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7")]

PreData <- PreData[, c("lag.1", "lag.2", "lag.3", "lag.4", "lag.5", "lag.6", "lag.7") := NULL]
