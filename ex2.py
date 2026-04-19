import numpy as np
from scipy.stats import multivariate_normal

# --- First Task: P(X < 2, Y < 1) ---
mean = [1, 1]
sigma = [[1, 2], [2, 13]]
dist = multivariate_normal(mean=mean, cov=sigma)

# Python's .cdf calculates from -infinity to the upper bound
prob1 = dist.cdf([2, 1])
print(f"P(X < 2, Y < 1): {prob1:.3f}")


# --- Second Task: Rectangle P(-3 < X < 1, -1 < Y < 2) ---
upper = [1, 2]
lower = [-3, -1]

# Method 1: The 'Inclusion-Exclusion' approach using CDF
# This is how you manually define the box
rect_prob = (
    dist.cdf([upper[0], upper[1]])
    - dist.cdf([lower[0], upper[1]])
    - dist.cdf([upper[0], lower[1]])
    + dist.cdf([lower[0], lower[1]])
)

print(f"P(-3 < X < 1, -1 < Y < 2): {rect_prob:.3f}")
