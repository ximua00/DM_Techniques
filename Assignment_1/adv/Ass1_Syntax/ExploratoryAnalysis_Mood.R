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
        geom_point(size =2, shape=19, fill = "black", colour = "black")
#Conclusion: Each ID conducts the experiment for a different number of days
######################################



######################################
#What time is the 'mood' asked to be rated? 
moodData <- subset(newdata, (!is.na(newdata[, newdata$value.mood])))

ToDHours <- data.frame(moodData$time.of.day, moodData$hour)
ToDHours <- aggregate(x = ToDHours$moodData.hour, by = ToDHours["moodData.time.of.day"], sum)
colnames(ToDHours) <- c("Time_of_Day", "Total_Hours")
#Visualise
ggplot(ToDHours, aes(x = Time_of_Day, y = Total_Hours)) +
        geom_bar(stat = "identity", width = 0.25, colour = "red")

#Conclusion: No fixed hours for app to request user to rate 'mood'
# Also: Not many users used the app at "Dawn"
######################################



######################################
#Distribution of mood 
#not aggregated per day!
head(moodData$value.mood, n=10)

##Aggregate mood per day
#Choose relevant variables
aggMood <- moodData[, .(id ,value.mood, date)]
#Aggregate by id and day with #count
aggMood <- moodData[, .(mood_count = .N, mood_mean = mean(value.mood)), 
                    by = .(id, date)]

###### Visualise
### (track mood per user over time)

aggMoodHr <- data.frame(moodData[, .(id, value.mood, hour)])
aggMoodHr <- aggregate(x = aggMoodHr$value.mood, 
                       by = aggMoodHr[c("id", "hour")], FUN = mean )
colnames(aggMoodHr)[3] <- "mood_mean"

# avg mood vs. each hour
ggplot(data=aggMoodHr, aes(x=hour, y=id, colour=mood_mean)) +  
        scale_color_continuous(low = "blue", high = "green") + geom_point()

# avg mood vs. each day
ggplot(aggMood, aes(x = id, y = date), label_size = 1.5) +
        geom_bar(stat = "identity", aes(fill = mood_mean), width = 0.5,
                 position = "stack") +
        theme_bw()

# average mood per user
idMood <- aggMood[, .(mood_mean = mean(mood_mean)), 
                  by = .(id)]

idMood$id <- unlist(lapply(idMood$id, FUN = function(x) as.numeric(sub("AS14.", "", x))))
ggplot(data = idMood, mapping = aes(x = id, y = mood_mean)) +
        geom_line() +
        geom_point(size =2, shape=19, fill = "black", colour = "black")
######################################



######################################
#Total number of days the dataset was collected
max(moodData$date) - min(moodData$date)
######################################