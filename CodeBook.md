
#Introduction
This Codebook describes the structure and the genesis of the two datasets "mergeddataframe.txt" and 
"finalmeanframe.txt". The second dataset is derived from the frist one, so please read the description one 
of the first one at first.

# Description of "mergeddataframe.txt"
## Genesis of dataframe

This dataframe is derived by the original dataframes **"X_test.txt"**, **"X_train.txt"**, **"y_test.txt"**, **"y_train.txt"**, **"subject_test.txt"**, **"subject_train.txt"**, **"activity_labels.txt"**, **"features.txt"**.

Before i explain how it was derived exactly, i just want to summarize what the content of these files are.

* **"X_test.txt"** is the main test dataframes it contains accleration and gyroscope data
and contains some more accleration and gyroscope data. For a more detailed description of the 
genesis of this data please take a look at the README.txt of the original dataset. It has 561 columns and 2947 rows.
* **"features.txt"** contains the 561 feautre names for the preceding dataframes, so every line of this dataframe
fits to one column of the two preceeding dataframe. For the meaning of the feature names please take also a look at 
the original README.txt
* **"y_test.txt"** can be interpreted as an additional column of the "X_test.txt" dataframe - it has also 2947 rows,
that gives the activity of the person, that was carrying the smartphone at the measurement.
* **"activity_labels.txt"** it contains the Labels for the Activity Integer Codes that occurs in "y_test.txt"
* **"subject_test.txt"** it can also interpreted as an additional column of "X_test.txt", that gives a subject 
Integer Code of each measurement of the "X_test.txt", so it has also 2947 rows.
* **"X_train.txt"** has the same structure as "X_test.txt", it contains just some more measurements (7352). It has 
also 561 columns with the same meaning as the "X_test.txt" and "features.txt" as labels.
* **"y_train.txt"** analogous to "y_test.txt", but with 7352 entries corresponding to Y_train.txt.
* **"subject_train.txt"** analogous to "subject_test.txt", but with 7352 entries corresponding to Y_train.txt.


The genesis **"mergeddataframe.txt"** could be explained as a result of the following steps:
(For the steps and their slightly different order, that were actually done by the run_analysis.R script, 
please take a look at the code and the comments in the "run_analysis.R" script.)

* **Step 1a**: The column "y_test.txt" has been added to the X_test.txt dataframe and has the name "ACITIVITY_INT_CODE",
the column "subject_test.txt" has been added and has the name "SUBJECT_INT_CODE" 
* **Step 1b**: The column "y_train.txt" has been added to the X_train.txt dataframe and has the name "ACITIVITY_INT_CODE",
the column "subject_train.txt" was added and has the name "SUBJECT_INT_CODE"
* **Step 2**: The two resulting dataframes from steps 1a and 1b were concatenated, so that the first 2947 lines are 
coincide the test dataframe and the second 7352 lines coincides with the train dataset.
* **Step 3**: In addittion to the "ACITIVITY_INT_CODE" i added a column "ACITIVITY_LABEL" that 
translates the acitivty integer codes to the labels of the activity.
* **Step 4**: Omitting all columns that does not contain mean or standard deviation data.  

## Description of the data variables

 ACTIVITY_INT_CODE:*The integer code of the activity of the involved person.*
 ACITIVITY_LABEL:*The label of the acitivity corresponding to the integer code.*
 SUBJECT_INT_CODE:*The integer code of the involved subject. *
  
  MEAN_OF_BODY_ACCELERATION_X:* Mean of Body-Acceleration in X-direction. *
  MEAN_OF_BODY_ACCELERATION_Y:* Mean of Body-Acceleration in Y-direction. *
  MEAN_OF_BODY_ACCELERATION_Z:* Mean of Body-Acceleration in Z-direction. *
  
  STD_OF_BODY_ACCELERATION_X:* Standarddeviation of Body-Acceleration in X-direction. *
  STD_OF_BODY_ACCELERATION_Y:* Standarddeviation of Body-Acceleration in Y-direction. *
  STD_OF_BODY_ACCELERATION_Z:* Standarddeviation of Body-Acceleration in Z-direction. *
  
  MEAN_OF_GRAVITY_ACCELERATION_X:* Mean of Gravity-Acceleration in X-direction. *
  MEAN_OF_GRAVITY_ACCELERATION_Y:* Mean of Gravity-Acceleration in Y-direction. *
  MEAN_OF_GRAVITY_ACCELERATION_Z:* Mean of Gravity-Acceleration in Z-direction. *
  
 STD_OF_GRAVITY_ACCELERATION_X:*Standarddeviation of Gravity-Acceleration in X-direction.*
 STD_OF_GRAVITY_ACCELERATION_Y:*Standarddeviation of Gravity-Acceleration in Y-direction.*
 STD_OF_GRAVITY_ACCELERATION_Z:*Standarddeviation of Gravity-Acceleration in Z-direction.*
  
 MEAN_OF_BODYJERK_ACCELERATION_X:*Mean of Body-Jerk-Acceleration in X-direction. *
 MEAN_OF_BODYJERK_ACCELERATION_Y:*Mean of Body-Jerk-Acceleration in Y-direction. *
 MEAN_OF_BODYJERK_ACCELERATION_Z:*Mean of Body-Jerk-Acceleration in Z-direction. *
  
  STD_OF_BODYJERK_ACCELERATION_X:*Standarddeviation of Body-Jerk-Acceleration in X-direction. *
  STD_OF_BODYJERK_ACCELERATION_Y:*Standarddeviation of Body-Jerk-Acceleration in Y-direction. *
  STD_OF_BODYJERK_ACCELERATION_Z:*Standarddeviation of Body-Jerk-Acceleration in Z-direction. *
  
  MEAN_OF_BODY_GYROSCOPE_X:* Mean of Body-Gyroscope-Signal in X-direction.*
  MEAN_OF_BODY_GYROSCOPE_Y:* Mean of Body-Gyroscope-Signal in Y-direction.*
  MEAN_OF_BODY_GYROSCOPE_Z:* Mean of Body-Gyroscope-Signal in Z-direction.*
  
  STD_OF_BODY_GYROSCOPE_X:* Standarddeviation of Body-Gyroscope-Signal in X-direction. *
  STD_OF_BODY_GYROSCOPE_Y:* Standarddeviation of Body-Gyroscope-Signal in Y-direction. *
  STD_OF_BODY_GYROSCOPE_Z:* Standarddeviation of Body-Gyroscope-Signal in Z-direction.*
  
  MEAN_OF_BODYJERK_GYROSCOPE_X:* Mean of Body-Jerk-Gyroscope-Signal in X-direction. *
  MEAN_OF_BODYJERK_GYROSCOPE_Y:* Mean of Body-Jerk-Gyroscope-Signal in Y-direction.*
  MEAN_OF_BODYJERK_GYROSCOPE_Z:* Mean of Body-Jerk-Gyroscope-Signal in Z-direction.*
  
  STD_OF_BODYJERK_GYROSCOPE_X: * Standarddeviation of Body-Jerk-Gyroscope-Signal in X-direction. *
  STD_OF_BODYJERK_GYROSCOPE_Y: * Standarddeviation of Body-Jerk-Gyroscope-Signal in Y-direction. *
  STD_OF_BODYJERK_GYROSCOPE_Z: * Standarddeviation of Body-Jerk-Gyroscope-Signal in Z-direction. *
  
  MEAN_OF_BODY_ACCELERATION_MAGNITUDE: * Mean of Body-Acceleration-Magnitude *
  STD_OF_BODY_ACCELERATION_MAGNITUDE: * Standarddeviation of Body-Acceleration-Magnitude *
  
  MEAN_OF_GRAVITY_ACCELERATION_MAGNITUDE:* Mean of Gravity-Acceleration-Magnitude *
  STD_OF_GRAVITY_ACCELERATION_MAGNITUDE: * Standarddeviation of Gravity-Acceleration-Magnitude *
  
  MEAN_OF_BODYJERK_ACCELERATION_MAGNITUDE: * Mean of Body-Jerk-Acceleration-Magnitude *
  STD_OF_BODYJERK_ACCELERATION_MAGNITUDE:  * Standarddeviation of Body-Jerk-Acceleration-Magnitude *
  
  MEAN_OF_BODY_GYROSCOPE_MAGNITUDE: * Mean of Body-Gyroscope-Singal-Magnitude *
  STD_OF_BODY_GYROSCOPE_MAGNITUDE: * Standarddeviation of Body-Gyroscope-Singal-Magnitude *
  
  MEAN_OF_BODY_GYROSCOPEJERK_MAGNITUDE:* Mean of Body-Gyroscope-Jerk-Magnitude* 
  STD_OF_BODY_GYROSCOPEJERK_MAGNITUDE:*Stadandarddeviation of Body-Gyroscope-Jerk-Magnitude*
    
  MEAN_OF_BODY_ACCELERATION_MAGNITUDE:* Mean of Body-Acceleration-Magnitude*
  STD_OF_BODY_ACCELERATION_MAGNITUDE:* Standarddeviation of Body-Acceleration-Magnitude*
  
  FFT_MEAN_OF_BODY_ACCELERATION_X:*Fast Fourier Transform of Mean of Body-Acceleration in X-direction.*
  FFT_MEAN_OF_BODY_ACCELERATION_Y:*Fast Fourier Transform of Mean of Body-Acceleration in Y-direction.*
  FFT_MEAN_OF_BODY_ACCELERATION_Z:*Fast Fourier Transform of Mean of Body-Acceleration in Z-direction.*
  
  FFT_STD_OF_BODY_ACCELERATION_X:*Fast Fourier Transform of Standarddeviation of Body-Acceleration in X-direction.*
  FFT_STD_OF_BODY_ACCELERATION_Y:*Fast Fourier Transform of Standarddeviation of Body-Acceleration in Y-direction*
  FFT_STD_OF_BODY_ACCELERATION_Z:*Fast Fourier Transform of Standarddeviation of Body-Acceleration in Z-direction*
  
  
  FFT_MEANFREQ_OF_BODY_ACCELERATION_X:*Fast Fourier Transform of Mean-Frequence of Body-Acceleration in X-direction.*
  FFT_MEANFREQ_OF_BODY_ACCELERATION_Y:*Fast Fourier Transform of Mean-Frequence of Body-Acceleration in Y-direction.*
  FFT_MEANFREQ_OF_BODY_ACCELERATION_Z:*Fast Fourier Transform of Mean-Frequence of Body-Acceleration in Z-direction.*
  
  FFT_MEAN_OF_BODYJERK_ACCELERATION_X:*Fast Fourier Transform of Mean of Body-Jerk-Acceleration in X-direction.*
  FFT_MEAN_OF_BODYJERK_ACCELERATION_Y:*Fast Fourier Transform of Mean of Body-Jerk-Acceleration in Y-direction.*
  FFT_MEAN_OF_BODYJERK_ACCELERATION_Z:*Fast Fourier Transform of Mean of Body-Jerk-Acceleration in Z-direction.*
  
  FFT_STD_OF_BODYJERK_ACCELERATION_X:*Fast Fourier Transform of Standarddeviation of Body-Jerk-Acceleration in X-direction.*
  FFT_STD_OF_BODYJERK_ACCELERATION_Y:*Fast Fourier Transform of Standarddeviation of Body-Jerk-Acceleration in Y-direction.*
  FFT_STD_OF_BODYJERK_ACCELERATION_Z:*Fast Fourier Transform of Standarddeviation of Body-Jerk-Acceleration in Z-direction.*
  
  FFT_MEANFREQ_OF_BODYJERK_ACCELERATION_X:*Fast Fourier Transform of Mean-Frequence of Body-Jerk-Acceleration in X-direction.* 
  FFT_MEANFREQ_OF_BODYJERK_ACCELERATION_Y: *Fast Fourier Transform of Mean-Frequence of Body-Jerk-Acceleration in Y-direction.* 
  FFT_MEANFREQ_OF_BODYJERK_ACCELERATION_Z: *Fast Fourier Transform of Mean-Frequence of Body-Jerk-Acceleration in Z-direction.* 
  
  FFT_MEAN_OF_BODY_GYROSCOPE_X:*Fast Fourier Transform of Mean of Body-Gyroscope-Signal in X-direction.* 
  FFT_MEAN_OF_BODY_GYROSCOPE_Y:*Fast Fourier Transform of Mean of Body-Gyroscope-Signal in Y-direction.*
  FFT_MEAN_OF_BODY_GYROSCOPE_Z:*Fast Fourier Transform of Mean of Body-Gyroscope-Signal in Z-direction.*
  
  FFT_STD_OF_BODY_GYROSCOPE_X:*Fast Fourier Transform of Standarddeviation of Body-Gyroscope-Signal in X-direction.*
  FFT_STD_OF_BODY_GYROSCOPE_Y:*Fast Fourier Transform of Standarddeviation of Body-Gyroscope-Signal in Y-direction.*
  FFT_STD_OF_BODY_GYROSCOPE_Z:*Fast Fourier Transform of Standarddeviation of Body-Gyroscope-Signal in Z-direction.*
  
  FFT_MEANFREQ_OF_BODY_GYROSCOPE_X:*Fast Fourier Transform of Mean-Frequence of Body-Gyroscope-Signal in X-direction.* 
  FFT_MEANFREQ_OF_BODY_GYROSCOPE_Y:*Fast Fourier Transform of Mean-Frequence of Body-Gyroscope-Signal in Y-direction.*
  FFT_MEANFREQ_OF_BODY_GYROSCOPE_Z:*Fast Fourier Transform of Mean-Frequence of Body-Gyroscope-Signal in Z-direction.*
  
  FFT_MEAN_OF_BODY_ACCELERATION_MAGNITUDE: *Fast Fourier Transform of Mean of Body-Acceleration-Magnitude*
  FFT_STD_OF_BODY_ACCELERATION_MAGNITUDE: *Fast Fourier Transform of Standarddeviation of Body-Acceleration-Magnitude*
  FFT_MEANFREQ_OF_BODY_ACCELERATION_MAGNITUDE: *Fast Fourier Transform of Mean-Frequence of Body-Acceleration-Magnitude*
  
  FFT_MEAN_OF_BODYJERK_ACCELERATION_MAGNITUDE:*Fast Fourier Transform of Mean of Body-Jerk-Acceleration-Magnitude*
  FFT_STD_OF_BODYJERK_ACCELERATION_MAGNITUDE:*Fast Fourier Transform of Standarddeviation of Body-Jerk-Acceleration-Magnitude*
  FFT_MEANFREQ_OF_BODYJERK_ACCELERATION_MAGNITUDE:*Fast Fourier Transform of Mean-Frequence of Body-Jerk-Acceleration-Magnitude*
  
  FFT_MEAN_OF_BODY_GYROSCOPE_MAGNITUDE: *Fast Fourier Transform of Mean of Body-Gyroscope-Sginal-Magnitude*
  FFT_STD_OF_BODY_GYROSCOPE_MAGNITUDE:*Fast Fourier Transform of Standarddeviation of Body-Gyroscope-Sginal-Magnitude*
  FFT_MEANFREQ_OF_BODY_GYROSCOPE_MAGNITUDE: *Fast Fourier Transform of Mean-Frequence of Body-Gyroscope-Sginal-Magnitude*
  
  FFT_MEAN_OF_BODY_GYROSCOPEJERK_MAGNITUDE: *Fast Fourier Transform of Mean of Body-Gyroscope-Jerk-Sginal-Magnitude*
  FFT_STD_OF_BODY_GYROSCOPEJERK_MAGNITUDE:*Fast Fourier Transform of Standarddeviation of Body-Gyroscope-Jerk-Sginal-Magnitude*
  FFT_MEANFREQ_OF_BODY_GYROSCOPEJERK_MAGNITUDE: *Fast Fourier Transform of Mean-Freuqence of Body-Gyroscope-Sginal-Magnitude*
  
  
# Description of "finalmeanframe.txt"

## Genesis of finalmeanframe.txt
The finalmeanframe.txt dataframe is derived from the mergeddataframe.txt. The first two columns "SUBJECT_INT_CODE" and "ACTIVITY_LABEL" just contain every possible combination of the "SUBJECT_INT_CODE" variable and the "ACTIVITY_LABEL" variable of the "mergeddataframe.txt" dataset. The columns after these two contain the average of the columns of the 
"mergeddateframe" dataset, but just over the measurements, that coincides in the "SUBJECT_INT_CODE" and the "ACTIVITY_LABEL" given in the first two columns.


## Description of variables

* SUBJECT_INT_CODE and ACITIVITY_LABEL: This first two varaibles do run through all possible combination of "subject" and "activity_label"

* AVERAGE_OF 'X': Does contain the average of column 'X' of the mergeddataframe dataset, considering exactly the measurements that coincides in the subject and acitivity-label given by the preceding variables of this line. 