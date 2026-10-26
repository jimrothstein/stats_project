
library(randomForest)

fruit_data <- data.frame(
  Weight = c(150, 160, 120, 110),
  Texture = c(2, 3, 8, 9),
  Label = as.factor(c("Orange", "Orange", "Lemon", "Lemon"))
)

rf_model <- randomForest(Label ~ ., data = fruit_data, ntree = 3, mtry = 1, keep.inbag = TRUE)

# Select random sample (bootstrap)
show_bootstrap <- function(k) {
  idx <- which(rf_model$inbag[, k] > 0)
  fruit_data[idx, ]
}
show_bootstrap(1)
show_bootstrap(2)
show_bootstrap(3)

# Select a (subset) of predictors - Tree 1
getTree(rf_model, k = 1, labelVar = TRUE)

# Entropy at root split for Tree 1
bs <- fruit_data[which(rf_model$inbag[, 1] > 0), ]

tab <- table(bs$Label) / nrow(bs)

entropy_root <- -sum(tab * log2(tab))
entropy_root

# Daughter nodes after split
left <- bs[bs$Texture <= 5, ]
right <- bs[bs$Texture > 5, ]
left
right

# Predict new fruit
new_fruit <- data.frame(Weight = 140, Texture = 7)
predict(rf_model, new_fruit)
