library(tidyverse)
library(broom)
library(pillar)
data(crickets, package = "modeldata")

names(crickets) # [1] "species" "temp"    "rate"
pillar::glimpse(crickets) # tibble imports from pillar
levels(crickets$species)


##  two species appear to have SAME slope (change in chirp rate per temp),
##    but otherwise only different intercepts
ggplot(
  crickets,
  aes(x = temp, y = rate, color = species, pch = species, lty = species)
) +
  # Plot points for each data point and color by species
  geom_point(size = 2) +
  # Show a simple linear model fit created separately for each species:
  geom_smooth(method = lm, se = FALSE, alpha = 0.5) +
  scale_color_brewer(palette = "Paired") +
  labs(x = "Temperature (C)", y = "Chirp Rate (per minute)")


# model

fit1 <- lm(rate ~ temp, data = crickets)
summary(fit1)

fit2 <- lm(rate ~ temp + species, data = crickets)
summary(fit2)

interaction_fit <- lm(rate ~ (temp + species)^2, data = crickets)
summary(interaction_fit)


# plot

png("interaction.png")
# Place two plots next to one another:
par(mfrow = c(1, 2))

# Show residuals vs predicted values:
plot(interaction_fit, which = 1) # which refers to plots to select

# A normal quantile plot on the residuals:
plot(interaction_fit, which = 2)
dev.off()

# to view ("Xview app)
browseURL("interaction.png")

# design matrix
head(model.matrix(interaction_fit, data = crickets))
