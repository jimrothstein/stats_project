## Use simulation to answer questions about squaring the normal distribution
## Show chi-squared

Supose
$X \sim N(0,1)$

\begin{equation}
a = b
\end{equation}

* Simulate k iid random variables, from N(0,1)
* Square and then sum
* Does this look like chi-squared?

```{r setup, include=FALSE		}
knitr::opts_chunk$set(echo = TRUE,  
											comment="      ##",  
											error=TRUE, 
											collapse=FALSE  ) 
```

```{r library, include=FALSE, eval=FALSE		}
library(tibble)
library(ggplot2)

# tinytex -misc 
library(tinytex)
 

# Missing .sty?
# 1. find package where .sty located
tlmgr_search("/lmodern.sty")

# 2. install that package
tlmgr_install("lm")

# ... 3.  update
tlmgr_update()


tinytex::reinstall_tinytex()
``` 

### Examine distribution of X and RV Y=X^2

### Create sample of N(0,1)
```{r one}
set.seed(2020)
N  <- 10000
x  <- rnorm(n = N, mean = 0, sd = 1)

# looks normal
hist(x, main="Histogram of X, sample from N(0,1)",
        xlab= "Are 68% of counts between 0 and 1 sd?")

# Ask, what is P(X < 1)
# 84.1 - 16.9 = 67.2 %
pnorm(q=1)   # 84.1%
pnorm(q=-1)   # 16.9%

# Looks chi-squared !   P(y < 1) approx 2/3
y  <- x^2
hist(y,  main = "Histogram of X^2")


# hist(
#      heights, 
#      col='coral', 
#      main='Heights of Schreiner Students', 
#      ylab='Proportion of Students', 
#      xlab='Height (ft)', 
#      freq=FALSE)
# 
```

$$\Y= \X_{1} + \X_{2}$$
### Create more Xi, with 7
```{r}


x1 = x
x2  <- rnorm(n=N, mean=0, sd=1)
x3  <- rnorm(n=N, mean=0, sd=1)
x4  <- rnorm(n=N, mean=0, sd=1)
x5  <- rnorm(n=N, mean=0, sd=1)
x6  <- rnorm(n=N, mean=0, sd=1)
x7  <- rnorm(n=N, mean=0, sd=1)

y  <- x1^2 + x2^2 + x3^2 + x4^2 + x5^2 + x6^2 + x7^2
hist(y)

```


### use replicate
```{r replicate, eval = FALSE}

# replicate, apply verb repeatedly
# use simplify=FALSE to return list of vectors
# default:  array or matrix
k = 10

# x is list of k vectors, each with N doubles
x  <- replicate(k, rnorm(n=N, mean=0, sd=1), simplify=FALSE)


sq  <- function (x) { x^2}
y  <- lapply(x, sq)
length(y)
str(y)
y[1])

```



```{r exit}
knitr::knit_exit()
```


```{r sampling_k}
library(magrittr)
library(tibble)
k  <- 3
x  <- rnorm(k, 0, 1)
x
v  <- sum(x^2)
v

one_value  <- function(k = 3) {
  x  <- rnorm(k, 0, 1)
  sum(x^2)
}

B  <- 10e4
k  <- 3
# all set to zero
v  <- vector(mode="double", length = B)
v
# slow
v  <- replicate(B, one_value(k))

hist(
     v, 
     col='coral', 
     xlab='value', 
     main=paste0("k = ", k," Chi-squares"))

k  <- 6
v  <- replicate(B, one_value(k))
hist(
     v, 
     density=4,
     col='blue', 
     xlab='value', 
     add = TRUE, 
     main=paste0("k = ", k," Chi-squares"))

```


* Sample average is an `estimator`, is it unbiased? (Chapter 9.3)
* compare to theory, E[sample avg]
* replicate()
```{r estimator}
# take B samples (large)
B  <- 10000
sample_mean  <- function(N=50){
  mean(sample(heights, replace=FALSE , size=N))
}

# store is set of mean heights
store  <- replicate(B, sample_mean(N))
mean(store) # 5.49
sd(store)  # 0.0486 (vs 0.047 - theory)_

theory_sd  <- sqrt( (1/3)^2/N )
theory_sd   # 0.0471
hist(
     store, 
     col='coral', 
     xlab='Sample mean', 
     main='Distribution of Sample Means N=50')

# scale
hist(
     scale(store), 
     col='coral', 
     xlab='Sample mean', 
     main='Distribution of Sample Means N=50')
```

Ch 9.4, qq & normality?
```{r normality}
IQR(store)/sd(store)  # 1.35 (vs 1.3)

qqnorm(store)
qqline(store, col="red")


# What percent are below 5.3, using as above mean= 5.5, sd=4/12
pnorm(q=c(5.3),5.5, 1/3)    #27%
```



```{r knit_exit()} 
knitr::knit_exit() 
```

/newpage

```{r render, eval=FALSE	} 
file  <- "01063_chi_squared_simulation.Rmd"
rmarkdown::render(file,
                  output_format = "pdf_document",
#                  output_format = "html_document",
                  output_file = "~/Downloads/print_and_delete/out")
```
