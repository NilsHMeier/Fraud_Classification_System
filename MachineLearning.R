# Import required libraries
library(caret)
library(nnet)
library(RWeka)
library(rpart)

decisionTree_J48_default <- function(predictors, labels) {
  # Train model
  fit <- train(x = predictors,
               y = labels,
               method = "J48",
               trControl = trainControl(method = "none"))
  # Return model
  fit
}

decisionTree_J48_pruned <- function(predictors, labels, C = 0.6, M = 3) {
  # Train model
  fit <- train(x = predictors,
               y = labels,
               method = "J48",
               tuneGrid = data.frame(C=C, M=M),
               trControl = trainControl(method="none"))
  # Return model
  fit
}

decisionTree_J48_CV <- function(predictors, labels, tuneLength = 5, cv = 10) {
  # Train model
  fit <- train(x = predictors,
               y = labels,
               method = "J48",
               trControl = trainControl(method="cv", number=cv),
               tuneLength = tuneLength)
  # Return model
  fit
}

decisionTree_RPart <- function(predictors, labels, minSplit = 2) {
  # Train model
  fit <- train(x = predictors,
               y = labels,
               method = "rpart",
               control = rpart.control(minsplit=minSplit, minbucket=1),
               parms = list(split="information"),
               trControl = trainControl(method="none"),
               tuneGrid = data.frame(.cp=0))
  # Return model
  fit
}

decisionTree_RPart_CV <- function(predictors, labels, tuneLength = 5, cv = 10) {
  # Train model
  fit<-train(x = predictors,
             y=labels,
             method = "rpart",
             control=rpart.control(minsplit=2, minbucket=1),
             parms=list(split = "information"),
             trControl=trainControl(method="cv",number=cv),
             tuneLength = tuneLength)
  # Return model
  fit
}

neuralNet <- function(predictors, labels, maxIterations = 5000, tuneGrid) {
  # Train model
  fit <- train(x = predictors,
               y = labels,
               method = "nnet",
               linout = FALSE,
               trace = TRUE,
               maxit = maxIterations,
               trControl = trainControl(method="none"),
               tuneGrid = tuneGrid)
  # Return model
  fit
}

neuralNet_CV <- function(predictors, labels, maxIterations = 5000, tuneGrid) {
  # Train model
  fit <- train(x = predictors,
               y = labels,
               method = "nnet",
               linout = FALSE,
               trace = TRUE,
               maxit = maxIterations,
               trControl = trainControl(method="cv", number=5),
               tuneGrid = tuneGrid)
  # Return model
  fit
}

naiveBayes_default <- function(predictors, labels, tuneGrid) {
  # Train model
  fit<-train(x = predictors,
             y=labels,
             method = "naive_bayes",
             tuneGrid = tuneGrid,
             trControl=trainControl(method="none") 
  )
  # Return model
  fit
}

logisticRegression_default <- function(predictors, labels) {
  # Train model
  fit<-train(x = predictors,
             y = labels,
             method = "nnet",
             linout=F,
             skip=T, 
             trControl=trainControl(method="none"),
             tuneGrid=data.frame(size = 0,decay=0) 
             )
  # Return model
  fit
}

knn_default <- function(predictors, labels, trControl) {
  # Train model
  fit <- train(x = predictors,
               y = labels,
               method = "knn",
               trControl = trControl)
  # Return model
  fit
}