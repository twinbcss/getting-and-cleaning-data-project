# Getting and Cleaning Data Project
This project will take in raw data collected from wearable devices such as
fitbits and will clean up the data and place the data into a `tidy` form. You
can learn more about tidy datasets by following the link below.

[How to share data with a statistician](https://github.com/jtleek/datasharing)

The tidy data set for this data must meet the below goals:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each
measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with
the average of each variable for each activity and each subject.

## The source data

The source data for this project is from experiments that have been carried out
with a group of 30 volunteers within an age bracket of 19-48 years. Each person
performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,
SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the
waist. Using its embedded accelerometer and gyroscope, we captured 3-axial
linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The
experiments have been video-recorded to label the data manually. The obtained
dataset has been randomly partitioned into two sets, where 70% of the volunteers
was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying
noise filters and then sampled in fixed-width sliding windows of 2.56 sec and
50% overlap (128 readings/window). The sensor acceleration signal, which has
gravitational and body motion components, was separated using a Butterworth
low-pass filter into body acceleration and gravity. The gravitational force is
assumed to have only low frequency components, therefore a filter with 0.3 Hz
cutoff frequency was used. From each window, a vector of features was obtained
by calculating variables from the time and frequency domain.

More details about the source data can be found at the link below.

[Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The components of the source data used for this project are listed below and are
included in the `source_data` folder of this repository.

| File                | Description |
| ------------------- | ----------- |
| activity_labels.txt | Activity labels for each type of activity ID |
| features.txt        | The features that were measured for each activity |
| subject_test.txt    | The corresponding subject IDs for the test batch |
| subject_train.txt   | The corresponding subject IDs for the training batch |
| X_test.txt          | The data measurements for the test batch |
| X_train.txt         | The data measurements for the training batch |
| y_test.txt          | The corresponding activity IDs for the test batch |
| y_train.txt         | The corresponding activity IDs for the training batch |

## Creating a Tidy data set

This project includes an R script `run_analysis.R` that will read in the source
data and step through the process to put that data into a tidy form. The process
that this script uses is as follows:

1. Read in all the data to their individual data frames
2. Bind the training and test data together
3. Extract only the measurements of concern (means and standard deviations)
4. Break up the data by domain signals (time and frequency)
5. Match up the subject IDs and activities to the two tables (time and
frequency)
6. Combine the two tables together to form one table
7. Clean up the variable names by making them human readable
8. Save the data set to `data1.csv` in the `tidy_data` folder
9. Summarize the data means by groups of `subject`, `activity`, and
`signal domain`
10. Save the summary data set to `data2.csv` in the `tidy_data` folder

### Saved data

The tidy data set is available as defined below after running the
`run_analysis.R` script:

| Object | Type | Description |
| ------ | ------ | ------ |
| tidy_data | tibble data frame | The tidy data set as an R data frame |
| tidy_data/data1.csv | CSV file | The tidy data set exported to a CSV file | 
| summary_data | tibble data frame | The summary data set as an R data frame |
| tidy_data/data2.csv | CSV File | The summary data set exported to a CSV file |

## References

Please reference the `Code Book` found in this repository to learn more about
the source data and the structure of the tidy data set.
