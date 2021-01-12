# Script to predict new unseen samples
library(caret)

# Set required paths
UNSEEN_PATH <- "./Data/unseen.txt"
SAVE_PATH <- "./Data/classified.txt"

# Choose model type: "S" for sampled model, "U" for unsampled model
MODEL_TYPE = "S"
if (MODEL_TYPE == "S") {
  MODEL_PATH = "./Models/Model_Sampled.rds"
  PREPROCESSOR_PATH = "./Models/Preprocessor_Sampled.rds"
} else {
  MODEL_PATH = "./Models/Model_Unsampled.rds"
  PREPROCESSOR_PATH = "./Models/Preprocessor_Unsampled.rds"
}
# Read in model and preprocessor
model <- readRDS(MODEL_PATH)
preprocessor <- readRDS(PREPROCESSOR_PATH)

# Read in unseen data
data <- read.table(UNSEEN_PATH, header = TRUE, sep = ';')

# Run preprocessing on data
data_processed <- predict(preprocessor, data)

# Predict fraud col for unseen data
predictions <- predict(model, data_processed)

# Add predictions to original data
data$fraud <- predictions

# Save data with predictions to txt file
write.table(x = data, file = SAVE_PATH, sep = ";", row.names = FALSE, col.names = TRUE)
