# Script providing methods to display trained models

plot_J48_decisionTree <- function(decisionTree) {
  library("Rgraphviz")
  write_to_dot(decisionTree$finalModel,con="./graph.txt")
  gr1<-agread("./graph.txt")
  plot(gr1) #5 rules
}

plot_RPart_decisionTree <- function(decisionTree) {
  library(rpart)
  par(mar = rep(0.1, 4))
  plot(decisionTree$finalModel, branch = 0.5,uniform = TRUE, compress = TRUE) 
  text(decisionTree$finalModel, use.n = T, all = TRUE)
}

plot_NeuralNet <- function(neuralNet) {
  library(devtools)
  library(clusterGeneration)
  #run script nnet_plot_update.r
  #=> load plot.nnet
  source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')
  plot.nnet(neuralNet$finalModel,neg.col= "red" )
  plot.nnet(neuralNet$finalModel, wts.only = T)
}