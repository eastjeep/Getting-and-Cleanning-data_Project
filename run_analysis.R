##1.
train <- read.table("./UCI HAR Dataset/train/X_train.txt")
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
mergeData <- merge(train,test,all=TRUE)

##2.

features <- read.table("./UCI HAR Dataset/features.txt",colClass="character") ## variables'names

fea_1 <- grep("mean()",features[,2])
fea_2 <- grep("meanFreq()",features[,2])
fea_mean <- setdiff(fea_1,fea_2)
fea_std <- grep("std()",features[,2])

act_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
names(act_train) <- "act"
act_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
names(act_test) <- "act"

sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(sub_train) <- "subject"
sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(sub_test) <- "subject"

train$act <- act_train[,1]
test$act <- act_test[,1]
train$subject <- sub_train[,1]
test$subject <- sub_test[,1]

mergeData2 <- merge(train,test,all=TRUE)
library(plyr)
fea_merge <- c(fea_mean,fea_std)
new_data2 <- mergeData2[,fea_merge]

##3. 
new_data2$act <- mergeData2$act
new_data2$subject <- mergeData2$subject

act_label <- read.table("./UCI HAR Dataset/activity_labels.txt",colClass="character")

for (i in 1:length(new_data2$act)) {
	if (new_data2$act[i] %in% act_label[,1]) {
		new_data2$act[i] <- act_label[which(act_label[,1]==new_data2$act[i]),2]
	}
	
}

##4. 
var_names <- names(new_data2)
var_desc <- features[,2][fea_merge]
for (j in 1:length(var_desc)) {
	
	names(new_data2)[j] <- var_desc[j]
}


##5. 
new_data3 <- split(new_data2,list(new_data2$act,new_data2$subject))

new_data4 <- sapply(new_data3,function(x)colMeans(x[,names(new_data2)[1:66]]))

write.table(new_data4,"exp.txt",row.names=F)
