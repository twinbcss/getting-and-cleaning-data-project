# load required libraries
library(dplyr)
library(stringr)

## PART 1 ##

# read in the test data
x_test <- read.table("source_data/X_test.txt")
y_test <- read.table("source_data/y_test.txt")
subject_test <- read.table("source_data/subject_test.txt")

# read in the training data
x_train <- read.table("source_data/X_train.txt")
y_train <- read.table("source_data/y_train.txt")
subject_train <- read.table("source_data/subject_train.txt")

# read in the metadata
features <- read.table("source_data/features.txt")
activity_labels <- read.table("source_data/activity_labels.txt")

# merge test and training sets
x_merged <- rbind(x_test, x_train)
y_merged <- rbind(y_test, y_train)
subject_merged <- rbind(subject_test, subject_train)

# tidy activity labels (lowercase and replace underscores with spaces)
activity_labels[, 2] <- tolower(str_replace_all(activity_labels[, 2], "_", " "))

# tidy y_merged with appropriate labels
y_merged[, 1] <- activity_labels[y_merged[, 1], 2]
names(y_merged) <- "activity"  # add `activity` label to this data

# add `subject` label to subject vector
names(subject_merged) <- "subject"

# add feature labels to x_merged table
names(x_merged) <- features[, 2]

# select only the columns with `mean()` or `std()` calculations
x_merged <- x_merged[, grepl("mean\\(\\)|std\\(\\)", names(x_merged))]

# select only the columns with time signal domain
x_time <- x_merged[, grepl("^t", names(x_merged))]
# remove leading t from column headers
names(x_time) <- str_replace(names(x_time), "^t", "")
# crate a frame for the signal domain
t <- data.frame(V1 = rep("time", nrow(x_time)))
names(t) <- "signal domain"  # set column name
# add the subject, activity, and signal domain columns
data_time <- cbind(subject_merged, y_merged, t, x_time)

# select only the columns with frequency signal domain
x_frequency <- x_merged[, grepl("^f", names(x_merged))]
# remove leading f from column headers
names(x_frequency) <- str_replace(names(x_frequency), "^f", "")
# crate a frame for the signal domain
f <- data.frame(V1 = rep("frequency", nrow(x_frequency)))
names(f) <- "signal domain"  # set column name
# add the subject, activity, and signal domain columns
data_frequency <- cbind(subject_merged, y_merged, f, x_frequency)

# merge the time and frequency tables together
tidy_data <- bind_rows(data_time, data_frequency)

# tidy up column names
column_names <- names(tidy_data)
column_names <- str_replace(column_names, "Acc", " accelerometer ")
column_names <- str_replace(column_names, "Gyro", " gyroscope ")
column_names <- str_replace(column_names, "Mag", " magnitude ")
column_names <- str_replace(column_names, "Jerk", " jerk ")
column_names <- str_replace_all(column_names, "Body", " body ")
column_names <- str_replace(column_names, "Gravity", " gravity ")
column_names <- str_replace(column_names, "-std\\(\\)", " standard deviation ")
column_names <- str_replace(column_names, "-mean\\(\\)", " average ")
column_names <- str_replace(column_names, "-X", " x-axis")
column_names <- str_replace(column_names, "-Y", " y-axis")
column_names <- str_replace(column_names, "-Z", " z-axis")
column_names <- str_squish(column_names)
column_names <- str_trim(column_names)
names(tidy_data) <- column_names

# save tidy data to csv file
write.csv(tidy_data, "tidy_data/data1.csv")

## PART 2 ##

# convert data frame into tibble
dt <- tibble::as_tibble(tidy_data)

# summarize the data by doing an average on all fields
# group data by subject, activity, and signal domain
summary_data <- group_by(dt, subject, activity, `signal domain`) %>%
  summarize(across(c(-1,-2,-3), mean, na.rm=TRUE), .groups="keep")

# save data to csv file
write.csv(summary_data, "tidy_data/data2.csv")