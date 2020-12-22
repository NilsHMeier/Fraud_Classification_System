# Data Exploration to get to know to the dataset
library(RColorBrewer)

# Read in the train.txt file
train_data <- read.table('./Data/train.txt', header = TRUE, sep = ';')

# General summary
summary(train_data)

# Count samples and fraud / no fraud
total_samples <- length(train_data$fraud)
no_fraud <- length(subset(train_data, fraud == 0)$fraud)
fraud <- length(subset(train_data, fraud == 1)$fraud)
print(paste("Total samples =",total_samples))
print(paste("Samples without fraud =",no_fraud))
print(paste("Samples with fraud =",fraud))

# Create pie chart of fraud
slices <- c(no_fraud, fraud)
lbls <- c("No Fraud", "Fraud")
pct <- round(slices/sum(slices)*100, 2)
lbls <- paste(lbls, pct)
lbls <- paste(lbls,"%",sep="")
pie(slices,labels = lbls, col=c("orange", "red"),
    main="Distribution of Fraud")

# Check distribution of "trustLevel" respecting missing values
missing_trustLevel = sum(is.na(train_data$trustLevel))
labels <- c("Missing")
values <- c(missing_trustLevel)
for (lvl in seq(1, 6, by = 1)) {
  count_lvl <- length(subset(train_data, trustLevel == lvl)$trustLevel)
  values <- c(values, count_lvl)
  labels <- c(labels, lvl)
}
barplot(height=values, names=labels, col=brewer.pal(7,"Set1"),
        xlab="trustLevel", ylab="Samples", main="Distribution of trustLevel")

# Check statistical key indicators and distribution for all numerical attributes
attributes <- names(train_data)
attributes <- attributes[attributes != "trustLevel" & attributes != "fraud"]
for (att in attributes) {
  att_max <- max(train_data[att])
  att_min <- min(train_data[att])
  att_mean <- mean(train_data[[att]])
  att_std <- sd(train_data[[att]])
  print(paste("Statistical key indicators for attribute", att))
  print(paste("Maximum =", att_max))
  print(paste("Minimum =", att_min))
  print(paste("Mean =", att_mean))
  print(paste("Std =", att_std))
  hist(train_data[[att]], breaks = 150, col = "blue", main = paste("Distribution of attribute", att), xlab=att)
}
