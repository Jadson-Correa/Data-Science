# Carregar os pacotes
pacotes <- c("data.table", "reshape2")
sapply(pacotes, require, character.only=TRUE, quietly=TRUE)
path <- getwd()
link <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(link, file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")

# carregar labels & features
activity_labels <- fread(file.path(path, "UCI HAR Dataset/activity_labels.txt")
                         , col.names = c("classLabels", "activityName"))
carac <- fread(file.path(path, "UCI HAR Dataset/features.txt")
               , col.names = c("index", "featureNames"))
caracWanted <- grep("(mean|std)\\(\\)", carac[, featureNames])
medidas <- carac[caracWanted, featureNames]
medidas <- gsub('[()]', '', medidas)

# Load train datasets
train <- fread(file.path(path, "UCI HAR Dataset/train/X_train.txt"))[, caracWanted, with = FALSE]
data.table::setnames(train, colnames(train), medidas)
train_atividades <- fread(file.path(path, "UCI HAR Dataset/train/Y_train.txt")
                          , col.names = c("Activity"))
train_objetos <- fread(file.path(path, "UCI HAR Dataset/train/subject_train.txt")
                       , col.names = c("SubjectNum"))
train <- cbind(train_objetos, train_atividades, train)

# Load test datasets
test <- fread(file.path(path, "UCI HAR Dataset/test/X_test.txt"))[, caracWanted, with = FALSE]
data.table::setnames(test, colnames(test), medidas)
test_atividades <- fread(file.path(path, "UCI HAR Dataset/test/Y_test.txt")
                         , col.names = c("Activity"))
test_objetos <- fread(file.path(path, "UCI HAR Dataset/test/subject_test.txt")
                      , col.names = c("SubjectNum"))
test <- cbind(test_objetos, test_atividades, test)

# merge datasets
merge <- rbind(train, test)

# Convert classLabels to activityName basically. More explicit. 
merge[["Activity"]] <- factor(merge[, Activity]
                              , levels = activity_labels[["classLabels"]]
                              , labels = activity_labels[["activityName"]])

merge[["SubjectNum"]] <- as.factor(merge[, SubjectNum])
merge <- reshape2::melt(data = merge, id = c("SubjectNum", "Activity"))
merge <- reshape2::dcast(data = merge, SubjectNum + Activity ~ variable, fun.aggregate = mean)

data.table::fwrite(x = merge, file = "tidyData.txt", quote = FALSE)
