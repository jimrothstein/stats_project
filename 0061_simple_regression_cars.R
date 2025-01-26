## 061_simple_regression_cars.R

## http://r-statistics.co/Linear-Regression.html

library(tidyverse)
head(cars)

g <- cars %>%
  ggplot(aes(x=speed,y=dist)) 
g + geom_point()

##	FIX	
##	note:   must set x="" or error
g + geom_boxplot(aes(x="",y=dist ))

 
boxplot(cars$dist)
boxplot(cars$speed)

## normal?
g + stat_bin(binwidth=2.5)
g + stat_bin(aes(x=dist), binwidth=10)


## cor, 0.807
cor(cars$speed,cars$dist)



## REF: <https://probstatsdata.com/SimpleReg.html>  
## Darrin Speegle and Bryan Clair

library(ggplot2)
Formaldehyde %>%
  ggplot(aes(x = carb, y = optden)) +
  geom_point()


# optden = 0.005 + .877<carb>
lm(optden ~ carb, data = Formaldehyde)

#
Formaldehyde %>% ggplot(aes(x = carb, y = optden)) +
  geom_point() +
  geom_abline(intercept = 0.005086, slope = 0.876286)

# residuals
Formaldehyde_model <- lm(optden ~ carb, data = Formaldehyde)
Formaldehyde_model$residuals

# close to zero
sum(Formaldehyde_model$residuals)

# error squared, 0.000299, which we argue is smallest possible 
sum(Formaldehyde_model$residuals^2)


