# REF:  https://juliasilge.com/blog/sf-trees-random-tuning/ 


# First, no tidymodel ----
# 1. Install and load the package
library(randomForest)

# 2. Create our tiny fruit dataset (2 predictors)
fruit_data <- data.frame(
  Weight = c(150, 160, 120, 110),
  Texture = c(2, 3, 8, 9),
  Label = as.factor(c("Orange", "Orange", "Lemon", "Lemon"))
)

# 3. Train the Forest (pick just 1 predictor, with replacement pick 4? rows)
# ntree: Number of bootstrap samples (trees)
# mtry: Number of variables to randomly sample at each split
# IDEA: repeating many times, noise will cancel out.
# 
# CREATE TREES; (all dumb)
# BOOTSTRAP: Sample with replacement, so some rows may be repeated, and some may be left out (OOB).
# FEATure SUBSET: Randomly select a subset of features for each tree, which helps to decorrelate the trees and improve performance. 
# EACH tree, minimize impurity (Gini), which gives us a rule.
# REPEAT for each true, 
# ADD a new fruit
# majority wins.

rf_model <- randomForest(Label ~ ., data = fruit_data, ntree = 2, mtry = 1, keep.inbag = TRUE)

# intermediate 
# Look at single tree 
# inbag holds freq a row was used
getTree(rf_model, k = 1, labelVar = TRUE)

show_tree <- function(tree_num) {
  tree <- which(rf_model$inbag[, tree_num] > 0)
  data <- fruit_data[tree, ]
}
(show_tree(1))
(show_tree(2))


# 4. Predict the new fruit (140g, Texture 7)
new_fruit <- data.frame(Weight = 140, Texture = 7)
prediction <- predict(rf_model, new_fruit)

print(prediction)

#

# Tidymodel ----
library(tidyverse)

sf_trees <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-28/sf_trees.csv")

trees_df <- sf_trees %>%
  mutate(
    legal_status = case_when(
      legal_status == "DPW Maintained" ~ legal_status,
      TRUE ~ "Other"
    ),
    plot_size = parse_number(plot_size)
  ) %>%
  select(-address) %>%
  na.omit() %>%
  mutate_if(is.character, factor)

trees_df %>%
  ggplot(aes(longitude, latitude, color = legal_status)) +
  geom_point(size = 0.5, alpha = 0.4) +
  labs(color = NULL)

# caretaker:
trees_df %>%
  count(legal_status, caretaker) %>%
  add_count(caretaker, wt = n, name = "caretaker_count") %>%
  filter(caretaker_count > 50) %>%
  group_by(legal_status) %>%
  mutate(percent_legal = n / sum(n)) %>%
  ggplot(aes(percent_legal, caretaker, fill = legal_status)) +
  geom_col(position = "dodge") +
  labs(
    fill = NULL,
    x = "% of trees in each category"
  )

# split
library(tidymodels)
library(themis)
set.seed(123)
trees_split <- initial_split(trees_df, strata = legal_status)
trees_train <- training(trees_split)
trees_test <- testing(trees_split)


tree_rec <- recipe(legal_status ~ ., data = trees_train) %>%
  update_role(tree_id, new_role = "ID") %>%
  step_other(species, caretaker, threshold = 0.01) %>%
  step_other(site_info, threshold = 0.005) %>%
  step_dummy(all_nominal(), -all_outcomes()) %>%
  step_date(date, features = c("year")) %>%
  step_rm(date) %>%
  themis::step_downsample(legal_status)

tree_prep <- prep(tree_rec)
juiced <- juice(tree_prep)

# hyperparameters (not learned from data); predictors to sample
tune_spec <- rand_forest(
  mtry = tune(),
  trees = 1000,
  min_n = tune()
) %>%
  set_mode("classification") %>%
  set_engine("ranger")

tune_wf <- workflow() %>%
  add_recipe(tree_rec) %>%
  add_model(tune_spec)

# cross validation for tuning
set.seed(234)
trees_folds <- vfold_cv(trees_train)

# tuning, SLOOOOOOOW
library(doParallel)
library(ranger)
doParallel::registerDoParallel()

set.seed(345)
tune_res <- tune_grid(
  tune_wf,
  resamples = trees_folds,
  grid = 20
)

tune_res
