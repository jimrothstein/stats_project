---
title: skeleton.qmd
date: last-modified
# Quarto requires title, if want date to appear
# TAGS:  caret, knn3, 
---
### https://statisticallearning.org/nonparametric-classification.html
  ### Dalpiaz - Chapter 7 (generate data, from Chapter 7)
```{r}
library(mlbench)
library(palmerpenguins)
library(tidyverse)
library(gridExtra)
library(caret)
library(data.table)
```

### generate training/testing data
```{r}
# set seed
set.seed(42)


classes = 2
sd = 0.1
x <- rnorm(n=100, mean=0, sd=sd) 
y <- rnorm(n=100, mean=0, sd=sd) 
pos  <- 0.25

data1  <- data.table(x=x + 0.25 , y=y + 0.25, classes = c(1))
data2  <- data.table(x=x + 3*pos, y=y + 3*pos, classes = c(2))
data  <- data.table::rbindlist(list(data1, data2))
plot(y  ~ x, data = data, col = classes, pch = 20, cex = 1.5)
data[, .(.I, x),][I == 2]


# train-test | tst-trn split data
trn_idx = sample(nrow(data), size = 0.8 * nrow(data))
trn_idx
length(trn_idx)                        #800 
## .I numbers and adds column I
trn  <-  data[, .(.I, x, y, classes)][I %in% trn_idx]
tst  <- data[, .(.I, x, y, classes)][!I %in% trn_idx]

## drop the I  (NEED)
trn  <-  trn[, .(x,y, classes)]


```

```{r, eval=F}
# visualize data

p1 = ggplot(data = trn, aes(x = x.1)) +
  geom_density(aes(fill = classes), alpha = 0.5) +
  scale_fill_manual(values=c("grey", 2, 3))

p2 = ggplot(data = trn, aes(x = x.2)) +
  geom_density(aes(fill = classes), alpha = 0.5) +
  scale_fill_manual(values=c("grey", 2, 3))

p3 = ggplot(data = trn, aes(x = x.1)) +
  geom_histogram(aes(fill = classes), alpha = 0.7, position = "identity") +
  scale_fill_manual(values=c("grey", 2, 3))

p4 = ggplot(data = trn, aes(x = x.2)) +
  geom_histogram(aes(fill = classes), alpha = 0.7, position = "identity") +
  scale_fill_manual(values=c("grey", 2, 3))

gridExtra::grid.arrange(p1, p2, p3, p4)
```

#
```{r}
# fit knn model
str(trn)
# need ?
trn$classes  <- as.factor(trn$classes)
mod_knn = knn3(classes ~ ., data = trn, k = 2)
mod_knn
# make "predictions" with knn model
new_obs = data.frame(x=.7, y = .7)

# point is probably class 1 
predict(mod_knn, new_obs, type = "prob")
predict(mod_knn, new_obs, type = "class")

```
### Next:  more knn, or begin tree model
### plot
```{r}
plot(x.2 ~ x.1, data = trn, col = classes, pch = 20, cex = 1.5)
# grid()
```


### helper function to calculate misclassification
```{r}
calc_misclass = function(actual, predicted) {
  mean(actual != predicted)
}

# calculate test metric
mod_knn = knn3(classes ~ ., data = trn, k = 10)
calc_misclass(
  actual = tst$classes,
  predicted = predict(mod_knn, tst, type = "class")
)
```

### simulate
```{r}
library(caret)
# tune knn model ###############################################################

# set seed
set.seed(42)

# est data (3 clusters, lots of overlap)
plot(x.2 ~ x.1, data = est, col = classes, pch = 20, cex = 1.5)

# k values to consider
k_val = seq(1, 101, by = 2)

# function to fit knn to est for various k

fit_knn_to_est = function(k) {
  knn3(classes ~ ., data = est, k = k)
}

# fit models
knn_mods = lapply(k_val, fit_knn_to_est)

# make predictions
knn_preds = lapply(knn_mods, predict, val, type = "class")

# calculate validation misclass
knn_misclass = sapply(knn_preds, calc_misclass, actual = val$classes)
min(knn_misclass)
which(knn_misclass == 0.244)
which(knn_misclass[min(knn_misclass)])

# plot results
plot(k_val, knn_misclass, pch = 20, type = "b")
grid()
```




vim:linebreak:nospell:nowrap:cul tw=78 fo=tqlnrc foldcolumn=1 cc=+1 filetype=r
