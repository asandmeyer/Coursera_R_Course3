library(dplyr)

#read and save test and train data
test_person <- read.table("./subject_test.txt")
test_aktivity <- read.table("./y_test.txt")
test_data <- read.table("./X_test.txt")

train_person <- read.table("./subject_train.txt")
train_aktivity <- read.table("./y_train.txt")
train_data <- read.table("./X_train.txt")

#merge/combine tables
test_all <- cbind(test_person, test_aktivity, test_data)
train_all <- cbind(train_person, train_aktivity, train_data)
all_data <- rbind(test_all, train_all)

#setting column names
data_names <- read.table("./features.txt")
names(all_data) <- c("person", "activity", as.vector(unlist(data_names[2])))

#getting all mean() and std() values
data_mean <- all_data[, grepl("mean\\(\\)", names(all_data))]
data_std <- all_data[, grepl("std\\(\\)", names(all_data))]
data_mean_std <- cbind(select(all_data, 1:2), data_mean, data_std)

#cleaning column names of the data
names(data_mean_std) <- gsub("\\(\\)","", names(data_mean_std))
names(data_mean_std) <- gsub("-","", names(data_mean_std))

# getting activity names
activity <- read.table("./activity_labels.txt")
activity_names <- as.vector(unlist(activity[2]))

#rename activities
data_mean_std$activity[data_mean_std$activity == "1"] <- activity_names[1]
data_mean_std$activity[data_mean_std$activity == "2"] <- activity_names[2]
data_mean_std$activity[data_mean_std$activity == "3"] <- activity_names[3]
data_mean_std$activity[data_mean_std$activity == "4"] <- activity_names[4]
data_mean_std$activity[data_mean_std$activity == "5"] <- activity_names[5]
data_mean_std$activity[data_mean_std$activity == "6"] <- activity_names[6]

#grouping data set and calculating average of each data column
data_grouped <- group_by(data_mean_std, person, activity)
data_grouped_avg <- summarise_all(data_grouped, funs(mean))
write.table(data_grouped_avg, file = "summary_fitness_data.txt", row.name = FALSE)