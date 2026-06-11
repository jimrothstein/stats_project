library(ggplot2)

set.seed(123)
p1 <- c(1, 1)
p2 <- c(2, 2)
p3 <- c(3, 4)  # point C
p4 <- c(4, 3)

df <- data.frame(
  x = c(p1[1], p2[1], p3[1], p4[1]),
  y = c(p1[2], p2[2], p3[2], p4[2])
)

labels <- c(1,1,-1,1)

ggplot(df, aes(x, y)) +
  geom_point(size = 3) +
  xlim(0, 5) + ylim(0, 5) +
  ggtitle("Four Points")

