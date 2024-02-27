## Chapter 13

## TODO move to jim utils
set_digits <- function(digits = 1) {
        options("digits" = digits)
}
get_digits <- function() {
        options("digits")
}


set_digits(2)
get_digits()

covM <- cov(iris[1:4])

eig <- eigen(covM, symmetric = TRUE, only.values = FALSE)

# --------------------------
eig$values # 4 eigenvalues
# --------------------------
# [1] 4.2282 0.2427 0.0782 0.0238

## Proportion each eigenvalue represents of sum
eig$values / (sum(eig$values))
# [1] 0.92462 0.05307 0.01710 0.00521

# ------------
eig$vectors
# ------------

# this helps
# Label the loadings
rownames(eig$vectors) <- c(colnames(iris[1:4]))
eig$vectors



# ---------
## V*t(V)
# ---------

eig$vectors %*% t(eig$vectors)
#         [,1]     [,2]     [,3]    [,4]
# [1,] 1.0e+00  1.1e-16  2.8e-16 8.3e-17
# [2,] 1.1e-16  1.0e+00 -5.6e-17 8.3e-17
# [3,] 2.8e-16 -5.6e-17  1.0e+00 0.0e+00
# [4,] 8.3e-17  8.3e-17  0.0e+00 1.0e+00
