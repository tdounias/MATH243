library(MASS)
library(tidyverse)
?Boston

nrow(Boston)
ncol(Boston)
Boston

ggplot(Boston, aes(x = rm, y = medv)) +
  geom_point()

ggplot(Boston, aes(x = crim, y = medv)) +
  geom_point()

ggplot(Boston, aes(x = dis, y = medv)) +
  geom_point()



