library(tidyverse)

# generate data from model: fair coin, 4 flips
rbinom(4, size = 1, prob = .5)

# Likelihood function for HHHT:

likelihood = function(p) {
  (p^3) * (1-p)
}


outcome = NULL
for(i in 1:10000) {
  outcome = rbind(outcome, rbinom(4, size = 1, prob = .75))
}

data.frame(p = 0:1) |>
  ggplot(aes(x = p)) +
  stat_function(fun = likelihood) +
  labs(y = "L(p)")

colnames(data.frame(outcome))
data.frame(outcome) %>%
  filter(X1 == 1, X2 == 1, X3 == 1, X4 == 0) %>%
  nrow() / 10000


normalDensity = function(y) {
  (2 * pi * sigma^2)^(-1/2) * exp(-(y - mean)^2/(2*sigma^2) )
}

sigma = 1
mean = 3

data.frame(y = -10:10) |>
  ggplot(aes(x = y)) +
  stat_function(fun = normalDensity)