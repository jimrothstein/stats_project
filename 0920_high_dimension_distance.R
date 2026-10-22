##      curse of dimensionality?

##      let k be dimensions
##      Find distance (Euclidean) between any 2 (random) points in unit square (`hypercube`) and also from origin to any random point

##      What is expect value of d as k grows?

# k = dimensions
#
# k=1
set.seed(111)
N <- 10000
x <- runif(N, min = 0, max = 1)
x
y <- runif(N, min = 0, max = 1)

d <- abs(x - y)
d
mean(d)
sqrt(10)

# k = 1
y <- rep(0, N)
y

d <- abs(x - y)
mean(d)
