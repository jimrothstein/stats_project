library(tidyverse)
library(dslabs)
if(!exists("mnist")) mnist <- read_mnist()
class(mnist$train$images) #> [1] "matrix" "array"
dim(mnist$train$images) # 60,000  784

x <- mnist$train$images[1:1000,]   # 1000 images x 784 pixels in each image
y <- mnist$train$labels[1:1000]   # actual digits 0-9
dim(x)

# vector to matrix , as.matrix(v)
#                    as.matrix(v, )   # default:   fills by column
