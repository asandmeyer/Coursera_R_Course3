---
title: "CodeBook"
author: "asandmeyer"
date: "26 8 2020"
output: pdf_document
---

# Variables
Short description of the used variables

## Data frames

### Raw data sets
```{r}
test_person # df of numbers describing which row belongs to which person
test_aktivity # df of numbers describing which activity has been done by the person of test_person from the same line
test_data # data sets of the measurements
```

```{r}
train_person # df of numbers describing which row belongs to which person
test_aktivity # df of numbers describing which activity has been done by the person of train_person from the same line
train_data # data sets of the measurements
train_all # merge of all train-data-sets: _person, _activity and _data
```

```{r}
activity # description/key to assign number in test/train_activity to a real activity
```

### Edited sets
```{r}
test_all # merge of all test-data-sets: _person, _activity and _data
train_all # merge of all train-data-sets: _person, _activity and _data
all_data # combination of all data from test and train
data_names # description of the variables from the test and train data set
data_mean # extracted mean-varibales/columns from all_data
data_std # extracted std-variables/columns from all_data
data_mean_std # combination of data_mean and data_std - having all required data
data_grouped # grouped data of data_mean_std by person and activity
data_grouped_avg # mean value of data/measurements for each variable and person
```

## Values

```{r}
activity_names # character vector of the activities
```

# Transformation

Setting column names for the df *all_data*
```{r}
names(all_data) <- c("person", "activity", as.vector(unlist(data_names[2])))
```

Selecting relevant *mean()* columns by *grepl*. Note that bracktets have to be treated special (Same for "data_std")
```{r}
data_mean <- all_data[, grepl("mean\\(\\)", names(all_data))]
```

Removing the brackets and minus signs from the column names
```{r}
names(data_mean_std) <- gsub("\\(\\)","", names(data_mean_std))
names(data_mean_std) <- gsub("-","", names(data_mean_std))
```

Creating a vector of the activity names and assign them to their respective number in the *data_mean_std*
```{r}
activity_names <- as.vector(unlist(activity[2]))
data_mean_std$activity[data_mean_std$activity == "1"] <- activity_names[1]
```

Grouping data set and calculating average of each data column and finally write to a file
```{r}
data_grouped <- group_by(data_mean_std, person, activity)
data_grouped_avg <- summarise_all(data_grouped, funs(mean))
write.table(data_grouped_avg, file = "summary_fitness_data.txt", row.name = FALSE)
```