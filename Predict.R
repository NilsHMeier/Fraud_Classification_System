# Script to predict new unseen samples
library(caret)

# Set required paths
path_model <- "./Models/NeuralNetwork_3.rds"
path_preprocessor <- "./Models/Preprocessor_3.rds"
path_unseen <- "./Data/unseen.txt"
path_save_txt <- "./Data/classified.txt"

# Read in model and preprocessor
model <- readRDS(path_model)
model$finalModel
model$bestTune
preprocessor <- readRDS(path_preprocessor)

# Read in unseen data
data <- read.table(path_unseen, header = TRUE, sep = ';')
labels <- as.factor(data[,10])
data <- data[,1:9]

# Run preprocessing on data
data_processed <- predict(preprocessor, data)

# Predict fraud col for unseen data
predictions <- predict(model, data_processed)

# Add predictions to original data
data$fraud <- predictions
confusionMatrix(reference = labels, data = predictions)

# Save data with predictions to txt file
write.table(x = data, file = path_save_txt, sep = ";", row.names = FALSE, col.names = TRUE)
