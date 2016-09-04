
#----------------------- SECTION 1: THE "EXECUTE()"-METHOD----------------------------------------

# This is the main method of this script:

execute<-function(){
  
  # All necessary files are read in and provided in a list "vec".
  vec=readIn()
  
  # The following command takes the original Test-Dataframe (X_test.txt) and append the 
  #"subject" column (from "subject_test.txt") and the "activity_level" column (form y_test.txt)
  # to the dataframe.
  
  extendedtestframe<-mergeTestFrame(vec)
  
  # The following command takes the original Test-Dataframe (X_test.txt) and append the 
  #"subject" column (from "subject_test.txt") and the "activity_level" column (form y_test.txt)
  # to the dataframe.
  extendedtrainframe<-mergeTrainFrame(vec)
  
  # The two dataframes of the last step are concatenatet. That is possible and suitable, because 
  # they have the same number of columns with the same column labels and meanings.
  # So as a result the resulting data frame "concatframe" coincide in the first 2947 rows with 
  # the "extendedtestframe" and from row 2948 on with dataframe "extendedtrainframe".
  
  concatframe<-rbind(extendedtestframe,extendedtrainframe)
  
  #val1<-validateConcat(concatframe,extendedtestframe,extendedtrainframe,vec)
  
  # Remove the objects that are no needed any more
  rm(extendedtestframe)
  rm(extendedtrainframe)
  
  # The feature-name-factor is extracted from "features.txt" ...
  
  featurefactor<-vec[["features"]][,2]
  
  # ... and extended by two names "subject" and "activity_level"
  
  featurefactor<-extendlabelfactor(vec,featurefactor)
  
  # This command equipps the concatenated-data-frame "concatframe" with the original 
  # feature-labels.
  # The labels 1...561 are now the original labels form "features.txt"
  # and label 562="subject" and label 563="activity_level".
  
  labeledframe<-labelcolumns(concatframe,featurefactor)
  
  #The following command picks out all columns with "mean" and "std" in the name
  # plus the "subject" and the "activity_level" column.
  subframe<-subsetcols(labeledframe,featurefactor)
  rm(labeledframe)
  
  # The following command does merge the dataframe in "activity_labels.txt" with
  # the "subframe" dataframe by the first column of "activity_labels.txt" and
  # the "activity_level" column of the subframe. The result is an extended dataframe
  # "actlevframe" that has in addition to "subframe" a column "V2" which has the
  # activity-labels in addition to the numbers in the activity_level column.
  
  actlevframe<-mergeActivityLevels(subframe,vec)
  rm(subframe)
  
  # Now we reorder the columns of actlevframe:
  # activity_level | V2 | subject | <Rest of the columns of actlevframe>
  
  reorderedframe<-reorderColumns(actlevframe)
  rm(actlevframe)
  
  # Renaming the columns see the method "rename" for details.
  
  mergeddataframe<-rename(reorderedframe)
  rm(reorderedframe)
  
  #val2<-validateInputframe(mergeddataframe,vec)
  
  # Generates an "empty" meanframe with all combinations of "subject" and
  # "acitvity_label" in the first two rows and "NAs" in the rest of the frame.
  
  emptymeanframe<-generateNewDataFrame(vec,mergeddataframe)
  
  finalmeanframe<-generateData(mergeddataframe,emptymeanframe)
  
  #Some more CROSS-CHECK
  #val3 <- validateFinalMeanFrame(mergeddataframe,emptymeanframe,finalmeanframe)
  
  write.table(mergeddataframe, "mergeddataframe.txt",row.names = FALSE);
  write.table(finalmeanframe, "finalmeanframe.txt",row.names = FALSE);
  
  #val1&val2&val3
  
}

#------------------------SECTION 2: Single methods, that bundle functionality-units---------------

readIn <- function(){
  
  xtest<-read.table("test/X_test.txt")
  ytest<-read.table("test/y_test.txt")
  subtest<- read.table("test/subject_test.txt")
  
  features<- read.table("features.txt")
  ac_labels<-read.table("activity_labels.txt")
  
  xtrain<-read.table("train/X_train.txt")
  ytrain<-read.table("train/y_train.txt")
  subtrain<- read.table("train/subject_train.txt")
  
 list(
    
      "x_test"=xtest,
       "y_test"=ytest,
       "subject_test"=subtest,
       "x_train"=xtrain,
       "y_train"=ytrain,
       "subject_train"=subtrain,
       "features"=features,
        "aclabels"=ac_labels
      
      )
}

mergeTestFrame<-function(vec){
 
  testresultframe<-vec[["x_test"]]
  testresultframe$subject<-vec[["subject_test"]][,1]
  testresultframe$activity_level<-vec[["y_test"]][,1]
  testresultframe
  
}

mergeTrainFrame<-function(vec){
 
  trainresultframe<-vec[["x_train"]]
  trainresultframe$subject<-vec[["subject_train"]][,1]
  trainresultframe$activity_level<-vec[["y_train"]][,1]
  trainresultframe
  
}

extendlabelfactor<- function(vec,feat){
  
  features2<-factor(append(as.character(feat),"subject"))
  features2<-factor(append(as.character(features2),"activity_level"))
  features2
  
}

labelcolumns <- function(labelframe, features){
  
  for(i in 1:length(features)){
    names(labelframe)[i]<-as.character(features[i])
  }
  labelframe
}

subsetcols<-function(dataframe,features){
  indizes<-c(grep("mean|std", features),562,563)
  dataframe[,indizes]
}


mergeActivityLevels <- function(datframe,vec){
  
  datframe$id<-1:nrow(datframe)
  result<-merge(datframe, vec[["aclabels"]],by.x="activity_level", by.y="V1")
  result<-result[order(result$id),]
  index<-match("id",names(result))
  result<-result[,c(1:(index-1),(index+1):ncol(result))]
  
}

reorderColumns <- function(datframe){
  
  resultframe <-datframe[c("activity_level","V2","subject",colnames(datframe)[2:80])]
  
}

rename <- function(datframe){
  
  result<-datframe
  
  colnames(result)[match("activity_level",names(result))]<-"ACTIVITY_INT_CODE"
  colnames(result)[match("V2",names(result))]<-"ACITIVITY_LABEL"
  colnames(result)[match("subject",names(result))]<-"SUBJECT_INT_CODE"
  
  colnames(result)[match("tBodyAcc-mean()-X",names(result))]<-"MEAN_OF_BODY_ACCELERATION_X"
  colnames(result)[match("tBodyAcc-mean()-Y",names(result))]<-"MEAN_OF_BODY_ACCELERATION_Y"
  colnames(result)[match("tBodyAcc-mean()-Z",names(result))]<-"MEAN_OF_BODY_ACCELERATION_Z"
  
  colnames(result)[match("tBodyAcc-std()-X",names(result))]<-"STD_OF_BODY_ACCELERATION_X"
  colnames(result)[match("tBodyAcc-std()-Y",names(result))]<-"STD_OF_BODY_ACCELERATION_Y"
  colnames(result)[match("tBodyAcc-std()-Z",names(result))]<-"STD_OF_BODY_ACCELERATION_Z"
  
  colnames(result)[match("tGravityAcc-mean()-X",names(result))]<-"MEAN_OF_GRAVITY_ACCELERATION_X"
  colnames(result)[match("tGravityAcc-mean()-Y",names(result))]<-"MEAN_OF_GRAVITY_ACCELERATION_Y"
  colnames(result)[match("tGravityAcc-mean()-Z",names(result))]<-"MEAN_OF_GRAVITY_ACCELERATION_Z"
  
  colnames(result)[match("tGravityAcc-std()-X",names(result))]<-"STD_OF_GRAVITY_ACCELERATION_X"
  colnames(result)[match("tGravityAcc-std()-Y",names(result))]<-"STD_OF_GRAVITY_ACCELERATION_Y"
  colnames(result)[match("tGravityAcc-std()-Z",names(result))]<-"STD_OF_GRAVITY_ACCELERATION_Z"
  
  colnames(result)[match("tBodyAccJerk-mean()-X",names(result))]<-"MEAN_OF_BODYJERK_ACCELERATION_X"
  colnames(result)[match("tBodyAccJerk-mean()-Y",names(result))]<-"MEAN_OF_BODYJERK_ACCELERATION_Y"
  colnames(result)[match("tBodyAccJerk-mean()-Z",names(result))]<-"MEAN_OF_BODYJERK_ACCELERATION_Z"
  
  colnames(result)[match("tBodyAccJerk-std()-X",names(result))]<-"STD_OF_BODYJERK_ACCELERATION_X"
  colnames(result)[match("tBodyAccJerk-std()-Y",names(result))]<-"STD_OF_BODYJERK_ACCELERATION_Y"
  colnames(result)[match("tBodyAccJerk-std()-Z",names(result))]<-"STD_OF_BODYJERK_ACCELERATION_Z"
  
  colnames(result)[match("tBodyGyro-mean()-X",names(result))]<-"MEAN_OF_BODY_GYROSCOPE_X"
  colnames(result)[match("tBodyGyro-mean()-Y",names(result))]<-"MEAN_OF_BODY_GYROSCOPE_Y"
  colnames(result)[match("tBodyGyro-mean()-Z",names(result))]<-"MEAN_OF_BODY_GYROSCOPE_Z"
  
  colnames(result)[match("tBodyGyro-std()-X",names(result))]<-"STD_OF_BODY_GYROSCOPE_X"
  colnames(result)[match("tBodyGyro-std()-Y",names(result))]<-"STD_OF_BODY_GYROSCOPE_Y"
  colnames(result)[match("tBodyGyro-std()-Z",names(result))]<-"STD_OF_BODY_GYROSCOPE_Z"
  
  colnames(result)[match("tBodyGyroJerk-mean()-X",names(result))]<-"MEAN_OF_BODYJERK_GYROSCOPE_X"
  colnames(result)[match("tBodyGyroJerk-mean()-Y",names(result))]<-"MEAN_OF_BODYJERK_GYROSCOPE_Y"
  colnames(result)[match("tBodyGyroJerk-mean()-Z",names(result))]<-"MEAN_OF_BODYJERK_GYROSCOPE_Z"
  
  colnames(result)[match("tBodyGyroJerk-std()-X",names(result))]<-"STD_OF_BODYJERK_GYROSCOPE_X"
  colnames(result)[match("tBodyGyroJerk-std()-Y",names(result))]<-"STD_OF_BODYJERK_GYROSCOPE_Y"
  colnames(result)[match("tBodyGyroJerk-std()-Z",names(result))]<-"STD_OF_BODYJERK_GYROSCOPE_Z"
  
  colnames(result)[match("tBodyAccMag-mean()",names(result))]<-"MEAN_OF_BODY_ACCELERATION_MAGNITUDE"
  colnames(result)[match("tBodyAccMag-std()",names(result))]<-"STD_OF_BODY_ACCELERATION_MAGNITUDE"
  
  colnames(result)[match("tGravityAccMag-mean()",names(result))]<-"MEAN_OF_GRAVITY_ACCELERATION_MAGNITUDE"
  colnames(result)[match("tGravityAccMag-std()",names(result))]<-"STD_OF_GRAVITY_ACCELERATION_MAGNITUDE"
  
  colnames(result)[match("tBodyAccJerkMag-mean()",names(result))]<-"MEAN_OF_BODYJERK_ACCELERATION_MAGNITUDE"
  colnames(result)[match("tBodyAccJerkMag-std()",names(result))]<-"STD_OF_BODYJERK_ACCELERATION_MAGNITUDE"
  
  colnames(result)[match("tBodyGyroMag-mean()",names(result))]<-"MEAN_OF_BODY_GYROSCOPE_MAGNITUDE"
  colnames(result)[match("tBodyGyroMag-std()",names(result))]<-"STD_OF_BODY_GYROSCOPE_MAGNITUDE"
  
  colnames(result)[match("tBodyGyroJerkMag-mean()",names(result))]<-"MEAN_OF_BODY_GYROSCOPEJERK_MAGNITUDE"
  colnames(result)[match("tBodyGyroJerkMag-std()",names(result))]<-"STD_OF_BODY_GYROSCOPEJERK_MAGNITUDE"
  
  
  colnames(result)[match("tBodyAccMag-mean()",names(result))]<-"MEAN_OF_BODY_ACCELERATION_MAGNITUDE"
  colnames(result)[match("tBodyAccMag-std()",names(result))]<-"STD_OF_BODY_ACCELERATION_MAGNITUDE"
  
  colnames(result)[match("fBodyAcc-mean()-X",names(result))]<-"FFT_MEAN_OF_BODY_ACCELERATION_X"
  colnames(result)[match("fBodyAcc-mean()-Y",names(result))]<-"FFT_MEAN_OF_BODY_ACCELERATION_Y"
  colnames(result)[match("fBodyAcc-mean()-Z",names(result))]<-"FFT_MEAN_OF_BODY_ACCELERATION_Z"
  
  colnames(result)[match("fBodyAcc-std()-X",names(result))]<-"FFT_STD_OF_BODY_ACCELERATION_X"
  colnames(result)[match("fBodyAcc-std()-Y",names(result))]<-"FFT_STD_OF_BODY_ACCELERATION_Y"
  colnames(result)[match("fBodyAcc-std()-Z",names(result))]<-"FFT_STD_OF_BODY_ACCELERATION_Z"
  
  
  colnames(result)[match("fBodyAcc-meanFreq()-X",names(result))]<-"FFT_MEANFREQ_OF_BODY_ACCELERATION_X"
  colnames(result)[match("fBodyAcc-meanFreq()-Y",names(result))]<-"FFT_MEANFREQ_OF_BODY_ACCELERATION_Y"
  colnames(result)[match("fBodyAcc-meanFreq()-Z",names(result))]<-"FFT_MEANFREQ_OF_BODY_ACCELERATION_Z"
  
  colnames(result)[match("fBodyAccJerk-mean()-X",names(result))]<-"FFT_MEAN_OF_BODYJERK_ACCELERATION_X"
  colnames(result)[match("fBodyAccJerk-mean()-Y",names(result))]<-"FFT_MEAN_OF_BODYJERK_ACCELERATION_Y"
  colnames(result)[match("fBodyAccJerk-mean()-Z",names(result))]<-"FFT_MEAN_OF_BODYJERK_ACCELERATION_Z"
  
  colnames(result)[match("fBodyAccJerk-std()-X",names(result))]<-"FFT_STD_OF_BODYJERK_ACCELERATION_X"
  colnames(result)[match("fBodyAccJerk-std()-Y",names(result))]<-"FFT_STD_OF_BODYJERK_ACCELERATION_Y"
  colnames(result)[match("fBodyAccJerk-std()-Z",names(result))]<-"FFT_STD_OF_BODYJERK_ACCELERATION_Z"
  
  colnames(result)[match("fBodyAccJerk-meanFreq()-X",names(result))]<-"FFT_MEANFREQ_OF_BODYJERK_ACCELERATION_X"
  colnames(result)[match("fBodyAccJerk-meanFreq()-Y",names(result))]<-"FFT_MEANFREQ_OF_BODYJERK_ACCELERATION_Y"
  colnames(result)[match("fBodyAccJerk-meanFreq()-Z",names(result))]<-"FFT_MEANFREQ_OF_BODYJERK_ACCELERATION_Z"
  
  colnames(result)[match("fBodyGyro-mean()-X",names(result))]<-"FFT_MEAN_OF_BODY_GYROSCOPE_X"
  colnames(result)[match("fBodyGyro-mean()-Y",names(result))]<-"FFT_MEAN_OF_BODY_GYROSCOPE_Y"
  colnames(result)[match("fBodyGyro-mean()-Z",names(result))]<-"FFT_MEAN_OF_BODY_GYROSCOPE_Z"
  
  colnames(result)[match("fBodyGyro-std()-X",names(result))]<-"FFT_STD_OF_BODY_GYROSCOPE_X"
  colnames(result)[match("fBodyGyro-std()-Y",names(result))]<-"FFT_STD_OF_BODY_GYROSCOPE_Y"
  colnames(result)[match("fBodyGyro-std()-Z",names(result))]<-"FFT_STD_OF_BODY_GYROSCOPE_Z"
  
  colnames(result)[match("fBodyGyro-meanFreq()-X",names(result))]<-"FFT_MEANFREQ_OF_BODY_GYROSCOPE_X"
  colnames(result)[match("fBodyGyro-meanFreq()-Y",names(result))]<-"FFT_MEANFREQ_OF_BODY_GYROSCOPE_Y"
  colnames(result)[match("fBodyGyro-meanFreq()-Z",names(result))]<-"FFT_MEANFREQ_OF_BODY_GYROSCOPE_Z"
  
  colnames(result)[match("fBodyAccMag-mean()",names(result))]<-"FFT_MEAN_OF_BODY_ACCELERATION_MAGNITUDE"
  colnames(result)[match("fBodyAccMag-std()",names(result))]<-"FFT_STD_OF_BODY_ACCELERATION_MAGNITUDE"
  colnames(result)[match("fBodyAccMag-meanFreq()",names(result))]<-"FFT_MEANFREQ_OF_BODY_ACCELERATION_MAGNITUDE"
  
  colnames(result)[match("fBodyBodyAccJerkMag-mean()",names(result))]<-"FFT_MEAN_OF_BODYJERK_ACCELERATION_MAGNITUDE"
  colnames(result)[match("fBodyBodyAccJerkMag-std()",names(result))]<-"FFT_STD_OF_BODYJERK_ACCELERATION_MAGNITUDE"
  colnames(result)[match("fBodyBodyAccJerkMag-meanFreq()",names(result))]<-"FFT_MEANFREQ_OF_BODYJERK_ACCELERATION_MAGNITUDE"
  
  colnames(result)[match("fBodyBodyGyroMag-mean()",names(result))]<-"FFT_MEAN_OF_BODY_GYROSCOPE_MAGNITUDE"
  colnames(result)[match("fBodyBodyGyroMag-std()",names(result))]<-"FFT_STD_OF_BODY_GYROSCOPE_MAGNITUDE"
  colnames(result)[match("fBodyBodyGyroMag-meanFreq()",names(result))]<-"FFT_MEANFREQ_OF_BODY_GYROSCOPE_MAGNITUDE"
  
  colnames(result)[match("fBodyBodyGyroJerkMag-mean()",names(result))]<-"FFT_MEAN_OF_BODY_GYROSCOPEJERK_MAGNITUDE"
  colnames(result)[match("fBodyBodyGyroJerkMag-std()",names(result))]<-"FFT_STD_OF_BODY_GYROSCOPEJERK_MAGNITUDE"
  colnames(result)[match("fBodyBodyGyroJerkMag-meanFreq()",names(result))]<-"FFT_MEANFREQ_OF_BODY_GYROSCOPEJERK_MAGNITUDE"
  
  result
}

generateNewDataFrame<- function(vec, datframe){
  
  result<-merge(1:30,vec[["aclabels"]][,2])
  for(i in 4:82){
    
    name<-paste("AVERAGE_OF_",names(datframe)[i])
    result[,name]<-NA
    
  }
  names(result)[1]<-"SUBJECT_INT_CODE"
  names(result)[2]<-"ACITIVITY_LABEL"
  result
}

subsetData<-function(sb,actlabel,datframe){
  
  subset(datframe,datframe$ACITIVITY_LABEL==actlabel&datframe$SUBJECT_INT_CODE==sb)
  
}

meanForOneCombination<-function(inputdatframe,resultframe, number){
  
  extract<-subsetData(resultframe[number,1],resultframe[number,2],inputdatframe)
  
  for(i in 4:82){
    resultframe[number,i-1]<-mean(extract[,i])
  }
  
  resultframe
  
}

generateData <-function(inpudatframe,resultframe){
  
  for(i in 1:180){
    resultframe<-meanForOneCombination(inpudatframe,resultframe, i)
  }
  
  resultframe
  
}


#-------------------------SECTION 3: Test-Methods for verifying the results (not part of the solution)----------------


validateConcat <- function(concatframe,extendedtestframe,extendedtrainframe,vec){
  
  dimc<-dim(concatframe)
  dimte<-dim(extendedtestframe)
  dimtr<-dim(extendedtrainframe)
  
  dimensions<-data.frame(c(dimte[1],dimte[2]),c(dimtr[1],dimtr[2]),c(dimc[1],dimc[2]))
  names(dimensions)<-c("Testframe","Trainframe","ConcatFrame")
  row.names(dimensions)<-c("nrows","ncols")
  print(dimensions)
  
  dimval<-(dimc[[1]]==dimte[[1]]+dimtr[[1]])&(dimc[2]==dimte[2])&(dimc[2]==dimtr[2])
  
  cmpval<-TRUE
  for(i in 1:dimte[1]){
    if(!extendedtestframe[i,1]==concatframe[i,1]){
      cmpval<-FALSE
    }
  }
  
  for(i in (dimte[1]+1):dimc[1]){
    if(!extendedtrainframe[i-dimte[1],1]==concatframe[i,1]){
      cmpval<-FALSE
    }
  }
  
  subtest<-vec[["subject_test"]][,1]
  levtest<-vec[["y_test"]][,1]
  
  subtrain<-vec[["subject_train"]][,1]
  levtrain<-vec[["y_train"]][,1]
  
  for(i in 1:dimte[1]){
    if(!subtest[i]==concatframe[i,dimc[2]-1]){
      cmpval<-FALSE
    }
  }
  
  for(i in (dimte[1]+1):dimc[1]){
    if(!subtrain[i-dimte[1]]==concatframe[i,dimc[2]-1]){
      cmpval<-FALSE
    }
  }
  
  for(i in 1:dimte[1]){
    if(!levtest[i]==concatframe[i,dimc[2]]){
      cmpval<-FALSE
    }
  }
  
  for(i in (dimte[1]+1):dimc[1]){
    if(!levtrain[i-dimte[1]]==concatframe[i,dimc[2]]){
      cmpval<-FALSE
    }
  }
  
  cmpval&dimval
}


testMeanCalc<-function(meanframe,inputframe){
  
  sumframe<-meanframe
  nframe<-meanframe
  
  result<-vector("integer")
  
  for(i in 3:81){
    sumframe[,i]<-0
    nframe[,i]<-0
  }
  
  for(i in 1:dim(inputframe)[1]){
    
    
    label<-inputframe$ACITIVITY_LABEL[i]
    sb<-inputframe$SUBJECT_INT_CODE[i]
    vec<-sumframe[,1]==sb&sumframe[,2]==label
    index<-match(TRUE,vec)
    if (!index %in% result){
      result<-append(result,index)
    }
    
    for(j in 4:82){
     
       sumframe[index,j-1]<-sumframe[index,j-1]+inputframe[i,j]
       nframe[index,j-1]<-nframe[index,j-1]+1
    }
    
  }
  
  for(i in 1:180){
    
    
    for(j in 4:82){
      
      sumframe[i,j-1]<-sumframe[i,j-1]/nframe[i,j-1]
      
    }
    
  }
  
  sumframe
  
}

validateInputframe<-function(inputframe,vec){
  
  val<-TRUE
  nms<-names(inputframe)
  val<- length(nms)==82
  val<-sum(nms %in% nms[duplicated(nms)])==0
  
  vc<-inputframe$MEAN_OF_GRAVITY_ACCELERATION_X
  
  origtestvc<-vec[["x_test"]][,41]
  origtrainvc<-vec[["x_train"]][,41]
  
  testvc<-vc[1:length(origtestvc)]
  trainvc<-vc[(length(origtestvc)+1):dim(inputframe)[1]]
  
  for(i in 1:length(origtestvc)){
    if(!testvc[i]==origtestvc[i]){
      val<-FALSE
    }
  }
  
  for(i in 1:length(trainvc)){
    if(!trainvc[i]==origtrainvc[i]){
      val<-FALSE
    }
  }
  
  val
  
}

validateFinalMeanFrame<- function(inputframe,emptymeanframe,finalmeanframe){
  
  testresultframe <- testMeanCalc(emptymeanframe,inputframe)
  
  vecnamesresult<-names(finalmeanframe)
  vecnamesinput<-names(inputframe)
  
  val<-TRUE
  
  for(i in 3:81){
    if(!vecnamesresult[i]==paste("AVERAGE_OF_",vecnamesinput[i+1])){
      val <- FALSE
    }
  }
  
  for(i in 1:180){
    for(j in  3:81){
      if(as.numeric(finalmeanframe[i,j])-as.numeric(testresultframe[i,j])>0.0000001){
        val<-FALSE
      }
    }  
  }
  
  val
  
}