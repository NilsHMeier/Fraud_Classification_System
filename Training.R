# Script to train different models using the algorithms in Reprocessing.R and MachineLearning.R

# Load required libraries
library(caret)
library(doParallel)
registerDoParallel(cores = 6)

# Load functions from Preprocessing.R and MachineLearning.R
source("./Preprocessing.R")
source("./MachineLearning.R")
source("./Plotting.R")


# Load data
data <- read.table('./Data/train.txt', header = TRUE, sep = ';')
data$fraud <- as.factor(data$fraud)
# data$trustLevel <- as.factor(data$trustLevel)
# Check data types of attributes in data
str(data)
summary(data$trustLevel)


# Split the data into train and test partition
set.seed(1897100)
trainRows <- createDataPartition(y=data$fraud, times=1, p = 0.7, list=F) 
train <- data[trainRows,]
test <- data[-trainRows,]

# Sample training set to have 50:50 fraud / no fraud distribution
train <- downSample(x=train[,1:9], y=train[,10], yname='fraud')
summary(train$fraud)

# Run preprocessing
preProcessor = prepare_preprocessing(data=train[,1:9], methods = c("bagImpute", "center", "scale"))
preProcessor

train_processed = run_preprocessing(preProcessor, new_data = train[,1:9])
summary(as.factor(train_processed$trustLevel))

test_processed <- run_preprocessing(preProcessor, new_data = test[,1:9])
summary(as.factor(test_processed$trustLevel))


# Default decision tree J48
decision_tree_default <- decisionTree_J48_default(predictors = train_processed, labels = train[,10])
confusionMatrix(reference = train$fraud, data = predict(decision_tree_default, train_processed))
confusionMatrix(reference = test$fraud, data = predict(decision_tree_default, test_processed))
plot_J48_decisionTree(decisionTree = decision_tree_default)
decision_tree_default$bestTune

# Pruned decision tree J48
decision_tree_pruned <- decisionTree_J48_pruned(predictors = train_processed, labels = train[,10], M=2, C=0.1)
confusionMatrix(reference = train$fraud, data = predict(decision_tree_pruned, train_processed))
confusionMatrix(reference = test$fraud, data = predict(decision_tree_pruned, test_processed))
plot_J48_decisionTree(decisionTree = decision_tree_pruned)
decision_tree_pruned$bestTune

# Cross validated decision tree J48
decision_tree_cv <- decisionTree_J48_CV(predictors = train_processed, labels = train[,10])
confusionMatrix(reference = train$fraud, data = predict(decision_tree_cv, train_processed))
confusionMatrix(reference = test$fraud, data = predict(decision_tree_cv, test_processed))
plot_J48_decisionTree(decisionTree = decision_tree_cv)

# Default naive bayes
tuneGrid <- expand.grid(usekernel=F, laplace=1, adjust=F)
naive_bayes <- naiveBayes_default(predictors = train_processed, labels = train[,10], tuneGrid = tuneGrid)
confusionMatrix(reference = train$fraud, data = predict(naive_bayes, train_processed))
confusionMatrix(reference = test$fraud, data = predict(naive_bayes, test_processed))

# Default logistic regression
logistic_regression <- logisticRegression_default(predictors = train_processed, labels = train[,10])
confusionMatrix(reference = train$fraud, data = predict(logistic_regression, train_processed))
confusionMatrix(reference = test$fraud, data = predict(logistic_regression, test_processed))

# Default knn
trControl <- trainControl(method = "cv", number = 5)
knn <- knn_default(predictors = train_processed, labels = train[,10], trControl = trControl)
confusionMatrix(reference = train$fraud, data = predict(knn, train_processed))
confusionMatrix(reference = test$fraud, data = predict(knn, test_processed))

# Neural net
tuneGrid <- data.frame(size=9, decay=0.001)
neural_net <- neuralNet(train_processed, train[,10], 1500, tuneGrid)
confusionMatrix(reference = train$fraud, data = predict(neural_net, train_processed))
cm <- confusionMatrix(reference = test$fraud, data = predict(neural_net, test_processed))
draw_confusion_matrix(cm)

# Cross validated neural net
tuneGrid <- expand.grid(.size=c(9, 12, 15, 18), .decay=c(0, 0.01, 0.001, 0.0001))
neural_net_cv <- neuralNet_CV(train_processed, train[,10], 1500, tuneGrid)
confusionMatrix(reference = train$fraud, data = predict(neural_net_cv, train_processed))
confusionMatrix(reference = test$fraud, data = predict(neural_net_cv, test_processed))
neural_net_cv$finalModel
neural_net_cv$bestTune
plot_NeuralNet(neural_net_cv)

# Save model and preprocessor to use them in Predict.R
saveRDS(neural_net, "./Models/Sampled_NN_2.rds")
saveRDS(preProcessor, "./Models/Sampled_Pre_BAG_2.rds")
