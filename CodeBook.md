# Getting and Cleaning Data Code Book
This code book provides more detailed information about the data sources and how
that data was transformed into the tidy data set that is provided after
executing the `run_analysis.R` script.

## Source Data

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

### Features

The features selected for this database come from the accelerometer and
gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals
(prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they
were filtered using a median filter and a 3rd order low pass Butterworth filter
with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration
signal was then separated into body and gravity acceleration signals
(tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter
with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in
time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the
magnitude of these three-dimensional signals were calculated using the Euclidean
norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag,
tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals
producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag,
fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain
signals). 

These signals were used to estimate variables of the feature vector for each
pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean
frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of
each window.
- angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample.
These are used on the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean

## Tidy Data

To convert the data into a tidy data set, the data was first looked at by the
variables observed, and then the observations.

### Variables

In analyzing the raw data, it was found that there were two types of measurement
performed on the data referred to above by the `domain signal`. These types of
observations will need to be broken out into their own rows so that they can
be distinguished as such.

An example of such a measurement would be the two variables defined below:
- tBodyAcc-mean()-X
- fBodyAcc-mean()-X

These are the exact same measurement, but observed in different ways. The first
was observed by using the `time` domain signal while the later was observed
using the `frequency` domain signal.

To resolve this issue, a new column `domain signal` will be added to the data
set and will be either set to `time` or `frequency` as applicable.

Additionally, the data includes variables that are not necessary for our
use. This includes all the measurements that are not mean or standard deviations
(`mean()`, `std()`) as described above. These unnecessary variables will be
discarded from the tidy data set.

Finally, the variable names are not human readable. The short codes will be
replaced with human readable column names that can be easily understood. Some
examples of replacements will include the below:

| Original Variable | Human Readable Variable |
| ----------------- | ----------------------- |
| tBodyAcc-mean()-X | body accelerometer average x-axis |
| tBodyGyroJerkMag-mean() | body gyroscope jerk magnitude average |

## Observations

In analyzing the raw data, it was found that the test and training raw data
files (`X_test.txt`, `X_train.txt`) would need to be combined to create the
complete data set.

Additionally, the subject IDs (`subject_test.txt`, `subject_train.txt`), need to
be appended to the data set so that the subject could be identified. To resolve
this issue, a new column labeled `subject` will be added to the data set to
properly identify the subject of that observation.

Finally, the activity IDs (`y_test.txt`, `y_train.txt`) will need to be replaced
with their respective labels (`activity_labels.txt`) and those updated values
appended to the data set so that the activity can be identified. This will be
added to the data set as a new column titled `activity`. The labels themselves
will also be cleaned to remove underscores and convert to lowercase.

## Sample

A sample tidy set would look as follows:

| subject | activity | signal domain | body accelerometer average x-axis | body accelerometer average y-axis | body accelerometer average z-axis |
| ------- | -------- | -------- | -------- | -------- | -------- |
| 2 | standing | time | 0.25717778 | -0.02328523 | -0.014653762 |
| 4 | walking upstairs | time | 0.28602671 | -0.013163359 | -0.11908252 |
| 9 | laying | frequency | 0.27548482 | -0.02605042 | -0.11815167 |

A complete example can be found in the `data1.csv` file within the `tidy_data`
folder of the repository.

The summary data will be grouped by the three columns (`subject`, `activity`,
`signal domain`) and will provide the average values across all the measurements
for that group.

A complete example of the summary data can be found in the `data2.csv` file
within the `tidy_data` folder of the repository.
