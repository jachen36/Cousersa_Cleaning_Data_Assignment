# Add library that I need to run this problem

run_analysis <- function(){
  file_origin <- "./data/"
  file_train <- "./data/train/"
  file_test <- "./data/test/"
  
  features <- read.table(paste0(file_origin, "features.txt"), 
                         col.names= c("ignore", "label"),
                         stringsAsFactors = FALSE)
  activity_labels <- read.table(paste0(file_origin, "activity_labels.txt"), 
                                col.names = c("ignore", "activity"), 
                                stringsAsFactors = TRUE)
  
  # function that extract data from text file
  extract_data <- function(file_path, name){
    x_temp <- read.table(paste0(file_path, "X_", name, ".txt"))
    y_temp <- read.table(paste0(file_path, "y_", name, ".txt"), col.names = "activity")
    subject_temp <- read.table(paste0(file_path, "subject_", name, ".txt"), col.names = "subject_id")
    
    names(x_temp) <- features$label
    x_temp <- x_temp[,grep("[Mm]ean|std", names(x_temp))]
    y_temp$activity <- as.factor(y_temp$activity)
    levels(y_temp$activity) <- activity_labels$activity
    
    train <- cbind(subject_temp, y_temp, x_temp) 
  }
  
  test <- extract_data(file_test, "test")
  train <- extract_data(file_train, "train")
  
  combine <- rbind(train, test)
  
  pattern <- c("^t", "^f", "Acc", "Mag")
  replacement <- c("time", "frequency", "Acceleration", "Magnitude")
  names <- names(combine)
  
  for(i in seq_along(pattern)){
    names <- sub(pattern[i], replacement[i], names)
  }
  names(combine) <- names
  return(combine)
}