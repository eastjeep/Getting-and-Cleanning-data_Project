# How the script works 

The script is divided into 5 parts.

## The first part
Using read.table function to extract training and test data. 
Then using merge function to merge the training and the test sets for creating one data set named as mergeData.

## The second part
Extracts the measurements on the mean and std for each measurement to formulate the new data set.
For the convenience of the next part, the activity and subjects are also extracted to the new data set named as "new_data2".

## The third part
Name the activities in the new_data2 with the use of "for" loop and which function. 

## The fourth part
Name the variables in the new_data2 with understandable descriptions which are referred to features.txt. 

## The fifth part
The new_data2, which are already named with activities and variables, can be splited by two factors,activity and subject. 
Then the new dat set called new_data3 is processed by the function sapply to calculate the average of each variable for each activity and each subject.
Finally the write.table function is applied  to show the results.



