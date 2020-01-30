# Getting and Cleaning Data - Course Project

This is the course project for `Getting and Cleaning Data` on Coursera.

This repository contains follwoing files:
- `README.md`: provides an overview of the data set and how it was created.
- `tidy_data.txt`: final data set.
- `CodeBook.md`: describes the contents of the data set (data, variables and transformations used to generate the data).
- `run_analysis.R`: R script to create the yidy data set

`run_analysis.R` has following steps: 

- Download and unzip the dataset
- Read the training and test datasets, and merge them to one dataset
- Extracts only the measurements on the mean and standard deviation for each measurement
- Read the activity and subject data for each dataset, and convert the `activity` and `subject` columns into factors
- Creates a tidy dataset `TidyData.txt` that consists of the mean value of each
   variable for each subject and activity.
