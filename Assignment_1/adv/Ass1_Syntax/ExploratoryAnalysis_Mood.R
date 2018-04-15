######################################
#EXPLORATORY ANALYSIS (MOOD)
######################################
#for how many days each "subject" is tracked

DaysPerID <- data.frame(newdata$id, newdata$date)
colnames(DaysPerID) <- c("ID", "Date")
DaysPerID <- aggregate(x = DaysPerID$Date, by = DaysPerID["ID"],FUN = function(x) length(unique(x)))

colnames(DaysPerID) <- c("ID", "Days")
DaysPerID$ID <- as.character(DaysPerID$ID)
DaysPerID$Days <- as.numeric(DaysPerID$Days)

DaysPerID$ID <- unlist(lapply(DaysPerID$ID, FUN = function(x) as.numeric(sub("AS14.", "", x))))

#Visualize
ggplot(DaysPerID, aes(x=ID, y=Days)) +
        geom_line() +
        geom_point(size =2, shape=19, fill = "black", colour = "black") +
        labs(title = "Number of days each user participated")
#Conclusion: Each ID conducts the experiment for a different number of days
rm(DaysPerID)
######################################



######################################
#What time is the 'mood' asked to be rated? 
moodData <- subset(newdata, (!is.na(newdata[, newdata$value.mood])))

ToDHours <- data.frame(moodData$time.of.day, moodData$hour)
ToDHours <- aggregate(x = ToDHours$moodData.hour, by = ToDHours["moodData.time.of.day"], sum)
colnames(ToDHours) <- c("Time_of_Day", "Total_Hours")
#Visualise
ggplot(ToDHours, aes(x = Time_of_Day, y = Total_Hours)) +
        geom_bar(stat = "identity", width = 0.25, colour = "red") +
        labs(title = "App usage across different times of day", 
             x = "Time of Day", y = "Total Hours (experiment)")

#Conclusion: No fixed hours for app to request user to rate 'mood'
# Also: Not many users used the app at "Dawn"

rm(ToDHours)
######################################



######################################
#Distribution of mood 
#not aggregated per day!
head(moodData$value.mood, n=10)

##Aggregate mood per day
#Choose relevant variables
aggMood <- moodData[, .(id ,value.mood, date, nth_day, week.day)]
#Aggregate by id and day with #count
aggMood <- moodData[, .(mood_count = .N, mood_mean = mean(value.mood), 
                        nth_day, week.day), by = .(id, date)]

###### Visualise
### (track mood per user over time)

aggMoodHr <- data.frame(moodData[, .(id, value.mood, hour)])
aggMoodHr <- aggregate(x = aggMoodHr$value.mood, 
                       by = aggMoodHr[c("id", "hour")], FUN = mean )
colnames(aggMoodHr)[3] <- "mood_mean"

# avg mood vs. each hour
ggplot(data=aggMoodHr, aes(x=hour, y=id, colour=mood_mean)) +  
        scale_color_continuous(low = "blue", high = "green") + geom_point() +
        theme_bw() +
        labs(title = "Average mood across different hours of the day for each participant", 
             x = "Hours of the day", y = "ID", colour = "Avg Mood")

rm(aggMoodHr)

# avg mood vs. each day
temp <- aggMood[aggMood$id=="AS14.01",]

# For all IDs
ggplot(aggMood, aes(y = nth_day, x = id)) +
        geom_bar(stat = "identity", aes(fill = mood_mean), width = 0.5,
                 position = "dodge") + 
        theme_bw() + 
        labs(title = "Average mood across each day of the experiment for each participant", 
             x = "ID", y = "nth Day of Experiment", fill = "Avg Mood")
        

# For one id say AS14 01 
ggplot(temp, aes(y = nth_day, x = id, colour = mood_mean)) +
        geom_jitter() +
        theme_bw() + 
        labs(title = "Mood distribution for one user", x = "ID", 
             y = " nth Day of the Experiment", colour = "Avg Mood")

rm(temp)

# avg mood vs. weekday
temp <- aggMood[aggMood$id==c("AS14.01", "AS14.16"),]

ggplot(aggMood, aes(x = id, y = mood_mean)) +
        geom_boxplot(mapping = aes(aggMood$week.day), outlier.shape = 4) +
        labs(x = "Days of the Week", y = "Avg Mood", 
             title = "Average mood across days of the week for all participants")
rm(temp)

# average mood per user
idMood <- aggMood[, .(mood_mean = mean(mood_mean)), 
                  by = .(id)]

idMood$id <- unlist(lapply(idMood$id, FUN = function(x) as.numeric(sub("AS14.", "", x))))
ggplot(data = idMood, mapping = aes(x = id, y = mood_mean)) +
        geom_line() +
        geom_point(size =2, shape=19, fill = "black", colour = "black") +
        labs(title = "Distribution of average mood for each user", 
             x = "ID", y = "Avg Mood")

rm(idMood)
######################################

######################################
#Total number of days the dataset was collected
max(moodData$date) - min(moodData$date)
######################################

