# Import libraries
library(caret)
library(RANN)

prepare_preprocessing <- function(data, methods = c("knnImpute", "center", "scale"), bounds = c(0,1), k = 5) {
  preProcessor = preProcess(data, method=methods, rangeBounds=bounds, k=k)
  preProcessor
}

run_preprocessing <- function(preProcessor, new_data) {
  predict(preProcessor, newdata=new_data)
}
