######################################
# HELPER FUNCTIONS

#This syntax: 
# - defines a function for splitting the data based on ID (ordered)
######################################


splitdata_id <- function (dataset) {
  # Function split the data into training, validation and test set (ordered by time) 
  # for different id's. 
  #
  # INPUT: Dataset with variable id
  # OUTPUT: 
  
  datasetTrain <- c()
  datasetValid <- c()
  datasetTest <- c()
  
  #For each user 
  for (user_id in unique(aggData$id)) {
  
    #Create temporary dataset
    df <- dataset[which(dataset$id == user_id), ]
    
    # Fixed Input - Set the fractions of the dataframe you want to split into training, 
    # validation, and test.
    fractionTraining   <- 0.70
    fractionValidation <- 0.15
    fractionTest       <- 0.15
    
    # Compute sample sizes.
    sampleSizeTraining   <- floor(fractionTraining   * nrow(df))
    sampleSizeValidation <- floor(fractionValidation * nrow(df))
    sampleSizeTest       <- floor(fractionTest       * nrow(df))
    
    # Create the randomly-sampled indices for the dataframe. Use setdiff() to
    # avoid overlapping subsets of indices.
    total_indices      <- seq.int(nrow(df))
    indicesTraining    <- total_indices[1: sampleSizeTraining]
    indicesNotTraining <- setdiff(seq_len(nrow(df)), indicesTraining)
    indicesValidation  <- indicesNotTraining[1: sampleSizeValidation]
    indicesTest        <- setdiff(indicesNotTraining, indicesValidation)

    # Create the three dataframes for training, validation and test.
    dfTraining   <- df[indicesTraining, ]
    dfValidation <- df[indicesValidation, ]
    dfTest       <- df[indicesTest, ]
    
    # Append the tables to output
    datasetTrain <- rbind(datasetTrain, dfTraining)
    datasetValid <- rbind(datasetValid, dfValidation)
    datasetTest <- rbind(datasetTest, dfTest)
  }
  
  return(list(datasetTrain, datasetValid, datasetTest ))
  
}