# No need to keep install.packages() in the script once it's in your lockfile!
library(mvtnorm)

# Exercise 3
# Computing the cumulative probability
result <- pmvnorm(
  upper = c(2, 1), # X < 2, Y < 1
  mean = c(1, 1),
  sigma = matrix(
    c(1, 2, 2, 13),
    nrow = 2,
    ncol = 2,
    byrow = TRUE
  )
)

print(as.numeric(result))

# Computing the cumulative probability
result <- pmvnorm(
  upper = c(1, 2), # X < 1, Y < 2
  lower = c(-3, -1), # X > -3, Y > -1
  mean = c(1, 1),
  sigma = matrix(
    c(1, 2, 2, 13),
    nrow = 2,
    ncol = 2,
    byrow = TRUE
  )
)

print(as.numeric(result))

# Exercise 3
# Computing the cumulative probability
result <- pmvnorm(
  upper = c(2, 1), # X < 2, Y < 1
  mean = c(0, 1),
  sigma = matrix(
    c(1, 2, 2, 4),
    nrow = 2,
    ncol = 2,
    byrow = TRUE
  )
)

print(as.numeric(result))

# Computing the cumulative probability
result <- pmvnorm(
  upper = c(1, 2), # X < 1, Y < 2
  mean = c(0, 1),
  sigma = matrix(
    c(1, 2, 2, 4),
    nrow = 2,
    ncol = 2,
    byrow = TRUE
  )
)

print(as.numeric(result))
