library(reshape2)
library(tidyr)
library(dplyr)

run_analysis <- function(){
  # Location of the files
  file_origin <- "./data/"
  file_train <- "./data/train/"
  file_test <- "./data/test/"
  
  # Extracting the feature labels
  features <- read.table(paste0(file_origin, "features.txt"), 
                         col.names= c("ignore", "label"),
                         stringsAsFactors = FALSE)
  # Extracting the activity labels
  activity_labels <- read.table(paste0(file_origin, "activity_labels.txt"), 
                                col.names = c("ignore", "activity"), 
                                stringsAsFactors = TRUE)
  
  # function that extract data from text file
  # labels the columns
  # add subject_id column
  # add activity column
  extract_data <- function(file_path, name){
    # Reading text file to tables
    x_temp <- read.table(paste0(file_path, "X_", name, ".txt"))
    y_temp <- read.table(paste0(file_path, "y_", name, ".txt"), col.names = "activity")
    subject_temp <- read.table(paste0(file_path, "subject_", name, ".txt"), col.names = "subject_id")
    
    # Adding column labels to table
    names(x_temp) <- features$label
    # Remove features columns that aren't needed
    x_temp <- x_temp[,grep("mean\\(|std\\(", names(x_temp))]
    x_temp <- x_temp[,-grep("BodyBody", names(x_temp))]
    # Add activity labels
    y_temp$activity <- as.factor(y_temp$activity)
    levels(y_temp$activity) <- activity_labels$activity
    # bind all the columns together
    train <- cbind(subject_temp, y_temp, x_temp) 
  }
  
  test <- extract_data(file_test, "test")
  train <- extract_data(file_train, "train")
  # Combine test and train dataset together
  combine <- rbind(train, test)
  
  # Make label usable with separate function by adding -
  pattern <- c("^t", "^f", "Acc", "Gyro", "\\(\\)", "mean$", "std$")
  replacement <- c("time-", "freq-", "-Acc", "-Gyro", "", "mean-NA", "std-NA")
  names <- names(combine)
  
  for(i in seq_along(pattern)){
    names <- sub(pattern[i], replacement[i], names)
  }
  
  # Collapses into key-value pairs
  names(combine) <- names
  combine <- combine %>% gather(features, value, -subject_id, -activity)
  
  # Determine if row has jerk or magnitude data
  combine$jerk <- grepl("Jerk", combine$features)
  combine$magnitude <- grepl("Mag", combine$features)
  # Separate the multiple observation into columns
  combine <- separate(combine, col= features, 
                      into =c("domain", 
                              "acceleration", 
                              "instructment", 
                              "variable",
                              "axis"))
  # Organize columns such that value is at the end
  combine <- combine[,c(setdiff(names(combine), "value"), "value")]
  
  # Convert specific columns into factor
  col_to_factor <- names(combine)[c(1,3:7)]
  combine[,col_to_factor] <- lapply(combine[,col_to_factor], factor)
  
  return(combine)
}

run_summarize<- function(df){
  # Group data by subject_id and activities
  df <- group_by(df, subject_id, activity)
  summarize(df, mean(value))
}