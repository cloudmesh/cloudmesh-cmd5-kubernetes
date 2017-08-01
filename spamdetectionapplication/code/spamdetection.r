programStart = Sys.time()

#required package for text mining
if(!require("tm"))
  install.packages("tm",repos = "http://cran.us.r-project.org")

#required package for SVM
if(!require("e1071"))
  install.packages("e1071",repos = "http://cran.us.r-project.org")

#required package for Adaboost
if(!require("ada"))
  install.packages("ada",repos = "http://cran.us.r-project.org")

if(!require("rbenchmark"))
  install.packages("rbenchmark",repos = "http://cran.us.r-project.org")

if(!require("gclus"))
  install.packages("gclus",repos = "http://cran.us.r-project.org")

if(!require("MASS"))
  install.packages("MASS",repos = "http://cran.us.r-project.org")

if(!require("class"))
  install.packages("class",repos = "http://cran.us.r-project.org")

library(tm)
library(e1071)
library(ada)
library(rbenchmark)

library(gclus)
library(MASS)
library(class)

#Initialize random generator
set.seed(1245)

############### Method definitions for the learning process ####################

#This function makes vector (Vector Space Model) from text message using highly repeated words
getVectorSpaceModel<-function(message,highlyrepeatedwords){
  
  tokenizedmessage<-strsplit(message, "\\s+")[[1]]
  
  #making vector
  v<-rep(0, length(highlyrepeatedwords))
  
  for(i in 1:length(highlyrepeatedwords)){
    for(j in 1:length(tokenizedmessage)){
      if(highlyrepeatedwords[i]==tokenizedmessage[j]){
        v[i]<-v[i]+1
      }
    }
  }
  return (v)
}

svmLinearAnalysis <- function(vtrdata,vtedata) {
  
  print("Linear Kernel")
  svmlinmodel <- svm(x=vtrdata[,2:length(vtrdata[1,])],y=vtrdata[,1],type='C', kernel='linear');
  summary(svmlinmodel)
  predictionlin <- predict(svmlinmodel, vtedata[,2:length(vtedata[1,])])
  tablinear <- table(pred = predictionlin , true = vtedata[,1]); tablinear
  precisionlin<-sum(diag(tablinear))/sum(tablinear);

  cat(sprintf("General Error using Linear SVM is (in percent): %f",((1-precisionlin)*100)))

  cat(sprintf("Ham Error using Linear SVM is (in percent): %f",((tablinear[1,2]/sum(tablinear[,2]))*100)))

  cat(sprintf("Spam Error using Linear SVM is (in percent): %f",((tablinear[2,1]/sum(tablinear[,1]))*100)))
 
  svmLinearAccuracy <- calculateAccuracy(tablinear)
   
  cat("Test vectors:", dim(vtedata), ", Accuracy =", svmLinearAccuracy, "%\n")
}

convert_count <- function(x) {
  y <- ifelse(x > 0, 1,0)
  y <- factor(y, levels=c(0,1), labels=c("No", "Yes"))
  y
}

svmPolynomialAnalysis <- function(vtrdata,vtedata) {
  
  svmpolymodel <- svm(x=vtrdata[,2:length(vtrdata[1,])],y=vtrdata[,1], kernel='polynomial', probability=FALSE)
  summary(svmpolymodel)
  
  predictionpoly <- predict(svmpolymodel, vtedata[,2:length(vtedata[1,])])
 
   for(i in 1:length(predictionpoly)) {
    
    if(predictionpoly[i] > 0.6)
      predictionpoly[i] = 1
    else
      predictionpoly[i] = 0
   }
  
  print("tabpoly data:")
  tabpoly <- table(pred = predictionpoly , true = vtedata[,1]);tabpoly
  print(tabpoly)
  
  svmPolynomialAccuracy <- calculateAccuracy(tabpoly)
  cat("Test vectors:", dim(vtedata), ", Accuracy =", svmPolynomialAccuracy, "%\n")
  
}

calculateAccuracy <- function(confusionMatrix) {
  
  accuracy = 0
  for (i in 1 : nrow(confusionMatrix)) {
    for (j in 1 : ncol(confusionMatrix)) {
      if (i == j) {
        accuracy = accuracy + confusionMatrix[i, i]
      }
    }
  }
  accuracy = (accuracy / sum(confusionMatrix)) * 100
  
  return(accuracy)
}

svmRadialAnalysis <- function(vtrdata,vtedata) {
  
  svmradmodel <- svm(x=vtrdata[,2:length(vtrdata[1,])],y=vtrdata[,1], kernel = "radial", gamma = 0.09, cost = 1, probability=FALSE)
  summary(svmradmodel)
  predictionrad <- predict(svmradmodel, vtedata[,2:length(vtedata[1,])])
  
  for(i in 1:length(predictionrad)) {
    
    if(predictionrad[i] > 0.6)
      predictionrad[i] = 1
    else
      predictionrad[i] = 0
  }
  
  tabrad <- table(pred = predictionrad, true = vtedata[,1]); tabrad
  
  svmRadialAccuracy <- calculateAccuracy(tabrad)

  cat("Test vectors:", dim(vtedata), ", Accuracy =", svmRadialAccuracy, "%\n")
}

kNearestNeighbourAnalysis <- function(vtrdata,vtedata) {
  
  data<-data.frame(sms=vtrdata[,2:length(vtrdata[1,])],type=vtrdata[,1])
  classifier <- IBk(data, control = Weka_control(K = 20, X = TRUE))
  summary(classifier)
  evaluate_Weka_classifier(classifier, newdata = data.frame(sms=vtedata[,2:length(vtedata[1,])],type=vtedata[,1]))
  predict_res <- predict(classifier, newdata = data.frame(sms=vtedata[,2:length(vtedata[1,])], type = vtedata[,1]), type = ) 

}

naiveBayesAnalysis <-  function(vtrdata,vtedata) {
#---------------------Naive Bayes----------------------------#

sms_train <- apply(vtrdata[,2:length(vtrdata[1,])], 2, convert_count)
sms_test <- apply(vtedata[,2:length(vtedata[1,])], 2, convert_count)
sms_classifier <- naiveBayes(sms_train, factor(vtrdata[,1]))
class(sms_classifier)
sms_test_pred <- predict(sms_classifier, newdata=sms_test)

tab_bayes <- table(sms_test_pred, vtedata[,1])

naiveBayesAccuracy <- calculateAccuracy(tab_bayes)

cat("Test vectors:", dim(vtedata), ", Accuracy =", naiveBayesAccuracy, "%\n")
}

adaBoostAnalysis <-  function(vtrdata,vtedata) {
  
  adaptiveboost<-ada(x=vtrdata[,2:length(vtrdata[1,])],y=vtrdata[,1],test.x=vtedata[,2:length(vtedata[1,])], test.y=vtedata[,1], loss="logistic", type="gentle", iter=100)
  summary(adaptiveboost)
  varplot(adaptiveboost)
}

vectorizeTrainingAndTestData <- function(data, highlyrepeatedwords) {
  
  vectoredData = NULL;
  
  for(i in 1:length(data[,2])){
    if(data[i,1]=="ham"){
      vectoredData=rbind(vectoredData,c(1,getVectorSpaceModel(data[i,2],highlyrepeatedwords)))
    }
    else{
      vectoredData=rbind(vectoredData,c(0,getVectorSpaceModel(data[i,2],highlyrepeatedwords)))
    }
  }
  
  return (vectoredData)
}

############### End - Method definitions for the learning process ####################
ca = c('SMSSpamCollection.txt','SMSSpamCollection1.txt','SMSSpamCollection2.txt')
cb = c("benchmark_comparisions.png","benchmark_comparisions1.png","benchmark_comparisions2.png")
#for (kk in 1:3) #Unsafe editing
#{  		#Unsafe editing
  #loading data. Original data is from http://archive.ics.uci.edu/ml/datasets/SMS+Spam+Collection
  print("Uploading SMS Spam dataset")
  smstable<-read.csv(ca[1], header = FALSE, quote = "", sep = "\t", colClasses=c('character','character'))
  
  
  n = nrow(smstable);
  mysample = sample(1:nrow(smstable),n/2)  # dividing the training and testing set
  
  training_data = smstable[mysample,]
  testing_data = smstable[-mysample,]
  
  #smstabletmp<-smstable
  smstabletmp<-training_data
  
  print("Extracting Ham and Spam Basic Statistics!")
  
  smstabletmp$type[smstabletmp$V1=="ham"] <- 1
  smstabletmp$type[smstabletmp$V1=="spam"] <- 0
  
  #Convert character data ismstanto numeric
  tmp<-as.numeric(smstabletmp$type)
  
  #Basic Statisctics like mean and variance of spam and hams
  hamavg<-mean(tmp)
  print("Average Ham is :");hamavg
  
  hamvariance<-var(tmp)
  print("Var of Ham is :");hamvariance
  
  print("Extract average token of Hams and Spams!")
  
  nohamtokens<-0
  noham<-0
  nospamtokens<-0
  nospam<-0
  
  for(i in 1:length(smstabletmp$type)){
    if(smstabletmp[i,1]=="ham"){
      nohamtokens<-length(strsplit(smstabletmp[i,2], "\\s+")[[1]])+nohamtokens
      noham<-noham+1
    }else{ 
      nospamtokens<-length(strsplit(smstabletmp[i,2], "\\s+")[[1]])+nospamtokens
      nospam<-nospam+1
    }
  }
  
  totaltokens<-nospamtokens+nohamtokens;
  print("total number of tokens is:")
  print(totaltokens)
  
  avgtokenperham<-nohamtokens/noham
  print("Avarage number of tokens per ham message")
  print(avgtokenperham)
  
  avgtokenperspam<-nospamtokens/nospam
  print("Avarage number of tokens per spam message")
  print(avgtokenperspam)
  
  print(" Make two different sets, training data and test data!")
  
  #select the percent of data that you want to use as training set
  trdatapercent<-0.3
  
  #training data set
  
  trdata=NULL
  
  #test data set
  tedata=NULL
  
  for(i in 1:length(smstabletmp$type)){
    if(runif(1)<trdatapercent){
      trdata=rbind(trdata,c(smstabletmp[i,1],tolower(smstabletmp[i,2])))
    }
    else {
      tedata=rbind(tedata,c(smstabletmp[i,1],tolower(smstabletmp[i,2])))
    }
  }
  
  print("Training data size is!")
  dim(trdata)
  
  print("Test data size is!")
  dim(tedata)
  
  # Text feature extraction using tm package
  
  trsmses<-Corpus(VectorSource(trdata[,2]))
  trsmses<-tm_map(trsmses, stripWhitespace)
  trsmses<-tm_map(trsmses, tolower)
  trsmses<-tm_map(trsmses, removeWords, stopwords("english"))
  
  dtm <- DocumentTermMatrix(trsmses)
  
  highlyrepeatedwords<-findFreqTerms(dtm, 80)
  
  #These highly used words are used as an index to make VSM 
  #(vector space model) for trained data and test data
  
  #vectorized training data set
  vtrdata = vectorizeTrainingAndTestData(trdata, highlyrepeatedwords);
  
  #vectorized test data set 
  vtedata = vectorizeTrainingAndTestData(tedata, highlyrepeatedwords);
  
  #Naive Bayes to be added
  
  
  # Run different classification algorithms
  # differnet SVMs with different Kernels
  print("----------------------------------SVM-----------------------------------------")
  svmLinearStart = Sys.time()
  svmLinearAnalysis(vtrdata,vtedata);
  svmLinearEnd = Sys.time()
  cat(sprintf("Time taken by SvmLinearKernel : %f ",(svmLinearEnd - svmLinearStart)))
  
  
  print("Polynomial Kernel")
  svmPolynomialStart = Sys.time()
  svmPolynomialAnalysis(vtrdata,vtedata);
  svmPolynomialEnd = Sys.time()
  cat(sprintf("Time taken by SvmPolynomialKernel : %f ",(svmPolynomialEnd - svmPolynomialStart)))
  
  print("Radial Kernel")
  svmRadialStart = Sys.time()
  svmRadialAnalysis(vtrdata,vtedata);
  svmRadialEnd = Sys.time()
  cat(sprintf("Time taken by SvmRadialKernel : %f ",(svmRadialEnd - svmRadialStart)))
  
  
  #print("----------------------------------AdaBoost-----------------------------------")
  adaBoostStart = Sys.time()
  adaBoostAnalysis(vtrdata,vtedata);
  adaBoostEnd = Sys.time()
  cat(sprintf("Time taken by AdaBoost : %f ",(adaBoostEnd - adaBoostStart)))
  
  #print("----------------------------------NaiveBayes-----------------------------------")
  naiveBayesStart = Sys.time()
  naiveBayesAnalysis(vtrdata,vtedata)
  naiveBayesEnd = Sys.time()
  cat(sprintf("Time taken by NaiveBayes : %f ",(naiveBayesEnd - naiveBayesStart)))
  
  programEnd = Sys.time()
  cat(sprintf("Time taken by the entire application : %f ",(programEnd - programStart)))
