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
  
  # #Extracting train data
  # x_train <- read.table(paste0(file_train, "X_train.txt"))
  # y_train <- read.table(paste0(file_train, "y_train.txt"), col.names = "activity")
  # subject_train <- read.table(paste0(file_train, "subject_train.txt"), col.names = "subject_id")
  # 
  # names(x_train) <- features[[2]]
  # y_train[[1]] <- as.factor(y_train[[1]])
  # levels(y_train[[1]]) <- activity_labels$activity
  # train <- cbind(subject_train, y_train, x_train)
  #                
  # # Extracting test data
  # x_test <- read.table(paste0(file_test, "X_test.txt"))
  # y_test <- read.table(paste0(file_test, "y_test.txt"), col.names = "activity")
  # subject_test <- read.table(paste0(file_test, "subject_test.txt"), col.names = "subject_id")
  # 
  # names(x_test) <- features[[2]]
  # #x_test <- x_test(grep("[Mm]ean|std", names(x_test)))
  # y_test[[1]] <-  as.factor(y_test[[1]])
  # levels(y_test[[1]]) <- activity_labels$activity
  # test <- cbind(subject_test, y_test, x_test)
  
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
  
  return(extract_data(file_test, "test"))
  
  combine <- rbind(train, test)
  
}