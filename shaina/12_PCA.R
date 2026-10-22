## Chapter 12

## TODO move to jim utils
set_digits <- function(digits = 1) {
        options("digits" = digits)
}
get_digits <- function() {
        options("digits")
}


set_digits(2)
get_digits()

(A <- matrix(c(1, 4, 2, 3), nrow = 2))

## eigenvalues, eigenvectors
eigen(A)
# eigen() decomposition
# $values
# [1]  5 -1
#
# $vectors
#       [,1]  [,2]
# [1,] -0.45 -0.71
# [2,] -0.89  0.71


##
(values <- eigen(A)[[1]])
(vectors <- eigen(A)[[2]])

vectors[1, ]
A %*% vectors[1, ]
#      [,1]
# [1,] -1.9
# [2,] -3.9

values[[1]] %*% vectors[1, ]
#      [,1] [,2]
# [1,] -2.2 -3.5
