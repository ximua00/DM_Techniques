######################################
#EXPLORATORY ANALYSIS (MOOD)
######################################
#for how many days each "subject" is tracked
# DaysPerID <- c()
# 
# for (id_ in unique(newdata$id)) {
#   n_days <- length(unique(newdata$date[which(newdata$id == id_)]))
#   new_id <- c(id_, n_days)
#   DaysPerID <- rbind(DaysPerID, new_id, deparse.level = 0)
# } 
# --- Modifying this since for loops are inefficent in R ---
DaysPerID <- data.frame(newdata$id, newdata$date)
colnames(DaysPerID) <- c("ID", "Date")
DaysPerID <- aggregate(x = DaysPerID$Date, by = DaysPerID["ID"],FUN = function(x) length(unique(x)))

colnames(DaysPerID) <- c("ID", "Days")
DaysPerID$ID <- as.character(DaysPerID$ID)
DaysPerID$Days <- as.numeric(DaysPerID$Days)

DaysPerID$ID <- unlist(lapply(DaysPerID$ID, FUN = function(x) as.numeric(sub("AS14.", "", x))))

#Visualize
plot(DaysPerID, type="b", xlab = "AS14. IDs", ylab = "Days")
#Conclusion: Each ID conducts the experiment for a different number of days
######################################



######################################
#What time is the 'mood' asked to be rated? 
moodData <- subset(newdata, (!is.na(newdata[, newdata$value.mood])))
table(moodData$hour)
table(moodData$time.of.day)

#Visualise
#TODO

#Conclusion: No fixed hours for app to request user to rate 'mood'
######################################



######################################
#Distribution of mood 
#not aggregated per day!
table(moodData$value.mood)

##Aggregate mood per day
#Choose relevant variables
aggMood <- moodData[, .(id ,value.mood, date)]
#Aggregate by id and day with #count
aggMood <- moodData[, .(mood_count = .N, mood_mean = mean(value.mood)), 
                    by = .(id, date)]

#Visualise
#TODO (average mood per user, track mood per user over time, etc…)
#average mood per user
idMood <- aggMood[, .(mood_mean = mean(mood_mean)), 
                  by = .(id)]
######################################



######################################
#Total number of days the dataset was collected
max(moodData$date) - min(moodData$date)
######################################