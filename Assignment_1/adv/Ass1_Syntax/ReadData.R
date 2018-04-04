######################################
#Install packages if not available
install.packages("data.table")
install.packages("lubridate")
######################################

######################################
#Load packages
library(data.table)
library(lubridate)
######################################


######################################
#Load data
Mood <- fread("../dataset_mood_smartphone.csv", na.strings = c("NA"), dec = c("."))
######################################


######################################
#Delete useless variables
Mood$V1 <- NULL
######################################


######################################
#Check out data
str(Mood)
summary(Mood)
#Matches from what is in Excel
######################################


######################################
#Reshape Data
newdata <- reshape(Mood,
                   timevar = "variable",
                   idvar = c("id", "time"),
                   direction = "wide")
######################################


######################################
#Define variable as "time" format




######################################

