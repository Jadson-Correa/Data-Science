# Project: Getting and Cleaning Data

### by: Jadson

## Data

The data and the description can be found in this address [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Structure

In the sample has 30 volunteers who performed 6 activities wearing a smartphone in yours waist. For its activities, a gyroscope and a accelerometer captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. This sensors were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. After this, the sample was randomly partitioned in 2 set (70% of the volunteers was selected for generating the training data and 30% the test data). 

## Information

Informations of each variable:
### ID;
### Activity label;
### Angular velecity (gyroscope);
### Total acceleration;
### A 561-feature vector with time and frequency domain variables.

## Steps

### 1. Merge the training and the test sets to create one data set.
### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
### 3. Uses descriptive activity names to name the activities in the data set
### 4. Appropriately labels the data set with descriptive variable names.
### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
