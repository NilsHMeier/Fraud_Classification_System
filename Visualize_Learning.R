# Script to visualize the impact of different hyperparameters on the balanced accuracy
library(caret)
library(yardstick)
source("./Preprocessing.R")
source("./MachineLearning.R")
source("./Plotting.R")

# Data needs to be load in "Training.R"
# In case of Neural Nets preprocessing needs to be executed!

# Train different pruned decision trees using J48
balanced_accuracies_train = c()
balanced_accuracies_test = c()
Ms = seq(10, 250, by=10)
for (i in Ms) {
  DT <- decisionTree_J48_pruned(predictors = train[,1:9], labels = train[,10], C=0.25, M=i)
  predicted = predict(DT, test[,1:9])
  bal_acc_test = bal_accuracy(data.frame(ref=as.factor(test[,10]),
                                          pred=predicted),
                               ref, pred)$.estimate
  cat("Balanced accuracy with M =", i, "is", bal_acc_test, "\n")
  balanced_accuracies_test = c(balanced_accuracies_test, bal_acc_test)
}
plot(x=Ms, y=balanced_accuracies_test, type="l")


# Train different Neural Nets without weight decay
balanced_accuracies_train = c()
balanced_accuracies_test = c()
hidden_Neurons <- seq(5, 50, by=5)
for (h in hidden_Neurons) {
  tuneGrid <- data.frame(size=h, decay=0.001)
  NN <- neuralNet_CV(predictors = train_processed[,1:9], labels = train[,10], tuneGrid = tuneGrid)
  predicted = predict(NN, test_processed[,1:9])
  bal_acc_test = bal_accuracy(data.frame(ref=as.factor(test[,10]),
                                         pred=predicted),
                              ref, pred)$.estimate
  cat("Balanced accuracy with H =", h, "is", bal_acc_test, "\n")
  balanced_accuracies_test = c(balanced_accuracies_test, bal_acc_test)
}
plot(x=hidden_Neurons, y=balanced_accuracies_test, type="l")
