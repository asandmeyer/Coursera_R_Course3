---
title: "README"
author: "asandmeyer"
date: "26 8 2020"
output: pdf_document
---

#Introduction

For the given task, data sets containing measurements from Fitness Tracker were analyzed. For a very detailed description of the data sets see
[link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

In short, 30 persons have done certain activities such as *walking* or *laying* and acceleration data was recorded. The persons, also called subjects were divided into two groups, namely *test* and *train*. However, for our purpose this does not matter.

The data has been analyzed on different variables and the results were provided which were further analyzed by us.

#Provided Data

Same for *train*:
```{r}
subject_test.txt # Each row identifies the subject/person who performed the activity for each window sample. Its range is from 1 to 30.
y_test.txt # Test labels
X_test.txt # Test sets/measurements
features.txt # List of all features - analyze of the raw data
activity_labels.txt # Links the class labels with their activity name.
```

# Function of *run_analysis.R*

The R script first reads the data and then merges the data sets to one data frame. In short, each line in *subject_test.txt* is linked to the same line in *y_test*, so that an activity can be linked to a person/subject. The corresponding data/measurements are proved in the lines of *X_test.txt* which will be also linked/merged. Same is done for the *train* group. Finally, a large data set *all_data* is created.

However, due to the given task, these data sets were cleaned and tidied up, so that at the end the file *summary_fitness_data.txt* was created. Here, average value of means and stds were calculated according to person/subject and activity.

Further explanations of the code is given in *CodeBook.md* and comments in the R script *run_analysis.R* itself.