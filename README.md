# Getting-and-Cleaning-DataGetting and Cleaning Data Course Project

run_analysis.R works as described below:

It creates the uci_har folder in working directrory and puts the downloaded uci_har dataset zip file in it, where later the dataset is unziped.
After loading the train and test data sets, using rbind, join the two datasets into one data frame.
Later it calculates the mean and standard deviation from the features data set.
After cleaning the column names, these are applied to the x data frame.
After loading activities data set, it converts it to lower case using tolower and removes underscore using gsub. activity and subject column names are named for y and subj data sets.
The three data sets, x, y and subject, are merged. Then, it is exported as a txt file into the folder, named merged.txt.
The mean of activity and subjects are created into a separate tidy data set which is saved as txt file named tidy_dataset_averages.txt.
