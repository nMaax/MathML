###############################################################################
# Exercise 1: Binomial Distribution Basics
###############################################################################
# Assume a poll size of 10 people, where the probability of any single person 
# voting for Party A is 0.4.
#   1. Calculate the probability that Party A gets exactly 5 votes (NA=5)
#   2. Calculate the "grouped" probability that Party A gets 6 or more votes (NA≥6)

# Define our poll parameters
n_voters <- 10
p_party_A <- 0.4

# Task 1: Probability that Party A gets EXACTLY 5 votes
# We use dbinom() which stands for "density of the binomial"
#
# Instead of making you memorize completely different function names for every possible math operation on a distribution, R uses a strict **prefix system**.
# Every built-in statistical distribution gets a "base name" (like `binom` for Binomial, `norm` for Normal, or `exp` for Exponential).
# R then attaches one of **four standard prefixes (`d`, `p`, `q`, `r`)** to that base name to tell the software exactly what you want to do with it.
# 
#   1. `d` stands for "Density" (or Probability Mass) --> $P(X = x)$ for discrete, or $f(x)$ for continuous.
#   2. `p` stands for "Probability" (Cumulative Distribution Function) --> $P(X \le x)$.
#   3. `q` stands for "Quantile" (Inverse CDF) --> It is the exact opposite of `p`. Instead of giving R a number and asking for the probability,
#         you give R a probability (like 0.95), and it tells you the number on the x-axis where that cumulative probability is reached.
#   4. `r` stands for "Random" Generation -> It tells R to act as a random number generator and draw simulated samples from that specific distribution.
exact_5_prob <- dbinom(x = 5, size = n_voters, prob = p_party_A)

print(paste("Probability of exactly 5 votes:", exact_5_prob))

# Task 2: Probability that Party A gets 6 OR MORE votes (The 'Grouped' case)
# Method A: Summing individual exact probabilities for 6, 7, 8, 9, and 10
grouped_prob_sum <- sum(dbinom(x = 6:10, size = n_voters, prob = p_party_A))

print(paste("Probability of 6 or more votes (Method A):", grouped_prob_sum))

# Method B: Using the cumulative probability function pbinom()
# pbinom calculates the probability of getting 'q' or fewer successes.
# By setting lower.tail = FALSE, it calculates over the left side, so strictly MORE than 'q' (so, 6 or more).
grouped_prob_cum <- pbinom(q = 5, size = n_voters, prob = p_party_A, lower.tail = FALSE)

print(paste("Probability of 6 or more votes (Method B):", grouped_prob_cum))

# ------------

###############################################################################
# Exercise 2: Multinomial Simulation and Covariance
###############################################################################
# Imagine rolling a fair 6-sided die 10 times. (π=1/6 for all faces).
#   1. Simulate this 10-roll experiment 10,000 times to create a large dataset of outcomes
#   2. Extract the vector of counts for rolling a "1" (X1) and the vector of counts for rolling a "2" (X2)
#   3. Calculate the sample covariance between these two vectors and compare it to our theoretical mathematical formula: -n pi_1 pi_2 -> −10(1/6)(1/6)

# 1. Define our parameters for the die rolls
n_rolls <- 10              # Number of times we roll the die in one experiment (n)
n_simulations <- 10000     # How many times we repeat the whole experiment
probabilities <- rep(1/6, 6) # Creates a vector of six 1/6s for a fair die

# 2. Run the simulation!
# rmultinom generates random multinomial vectors. 
# It outputs a matrix where each COLUMN is one full experiment (10 rolls),
# and each ROW is a category (Face 1, Face 2, ..., Face 6).
simulated_data <- rmultinom(n = n_simulations, size = n_rolls, prob = probabilities)

# 3. Extract the counts for Face "1" (Row 1) and Face "2" (Row 2)
# The comma syntax [row, column] is how we subset matrices in R.
# Leaving the column blank means "give me all columns".
X1 <- simulated_data[1, ]
X2 <- simulated_data[2, ]

# 4. Calculate the Sample Covariance from our 10,000 simulated experiments
sample_cov <- cov(X1, X2)

# 5. Calculate the Theoretical Covariance using our proven formula: -n * pi_l * pi_m
theoretical_cov <- -n_rolls * (1/6) * (1/6)

# 6. Print the results to compare!
print(paste("Simulated Sample Covariance: ", sample_cov))
print(paste("Theoretical Covariance:      ", theoretical_cov))

# ------------

###############################################################################
# Exercise 3: Exponential Distribution and Numerical Integration
###############################################################################
# By the laws of probability, the total area under any valid probability density curve from 0 to ∞ must equal 1.
#     1. Let λ=2. Define the probability density function of the exponential distribution in R.
#     2. Use R's built-in numerical integration tool to integrate your function from 0 to ∞ (infinity) and verify that the result evaluates to exactly 1.

# Define our parameter lambda (R calls this the "rate")
lambda <- 2

# Task 1: Define the probability density function (PDF)
# We wrap the built-in dexp() function inside a custom function so we can pass it to the integrator.
# Notice the 'd' prefix! This calculates the exact height of the curve at any point 'x'.
exponential_pdf <- function(x) {
  dexp(x, rate = lambda)
}

# (Optional) We could also write out the raw math formula we derived! 
# R would treat this exactly the same way:
# math_pdf <- function(x) { lambda * exp(-lambda * x) }

# Task 2: Integrate the function from 0 to infinity
# 'integrate' is R's powerful calculus engine.
# 'Inf' is R's built-in keyword for infinity.
area_result <- integrate(exponential_pdf, lower = 0, upper = Inf)

# Print the final calculus result
print(area_result)

# ------------

###############################################################################
# Exercise 4: Chi-Square Goodness of Fit (Die Test)
###############################################################################
# You suspect a 6-sided die might be loaded. To test this, you roll it 60 times and record the following frequencies for faces 1 through 6:
#
# > Observed Counts: Face 1: 7, Face 2: 14, Face 3: 8, Face 4: 15, Face 5: 6, Face 6: 10.
#
#     1. State the null hypothesis (H0).
#     2. Calculate the expected frequency for each face if the die were completely fair.
#     3. Compute the χ2 statistic using the formula: Chi^2=∑(Oi−Ei)^2/Ei, where E = "expected frequency", and O = "observed frequency"
#     4. Determine the degrees of freedom and whether you would reject the null hypothesis.

# Step 1: Input the observed counts from our 60 die rolls
# The c() function stands for "combine" and creates a vector (a list) of numbers.
observed_counts <- c(7, 14, 8, 15, 6, 10)

# Step 2: Define the expected probabilities for a fair 6-sided die
# Since we expect each face to appear equally, the probability is 1/6 for all 6 faces.
expected_probs <- rep(1/6, 6)

# Step 3: Run the Chi-Square Goodness of Fit test
# The chisq.test() function needs our observed counts (x) and our expected probabilities (p)
result <- chisq.test(x = observed_counts, p = expected_probs)

# Step 4: Print the results!
print(result)

# (Optional) You can also ask R to show you the expected counts it calculated behind the scenes:
print("Expected counts:")
print(result$expected) # p-value 0.22

# Remind: p-value means "if H0 was correct, what is the probability of seeing this data? A too low value (below 0.05) means H0 is probably incorrect"

# ------------

###############################################################################
# Exercise 5: Hardy-Weinberg Equilibrium Test
###############################################################################
#
# A population with a certain gene with three alleles A, B, C with allele frequencies 0.1, 0.6 and 0.3 respectively 
# is in Hardy-Weinberg equilibrium if its genotype frequencies equal:
#
#   pAA = 0.01, pBB = 0.36, pCC = 0.09, pAB = 0.12, pAC = 0.06, pBC = 0.36
#
# A  random sample of 375 individuals from a certain population has been found to have the following frequencies
#
#   NAA = 5, NBB = 130, NCC = 40, NAB = 55, NAC = 25, NBC = 120
#
# calculate the p-value and degrees of freedom of the test of the Hardy-Weinberg hypothesis and make a decision about it

# Same as above
observed_counts <- c(5, 130, 40, 55, 25, 120)
expected_probs <- c(0.01, 0.36, 0.09, 0.12, 0.06, 0.36)
result <- chisq.test(x = observed_counts, p = expected_probs)
print(result)
print("Expected counts:")
print(result$expected) # p-value = 0.31, we do NOT reject H0: "the system is in Hardy equilibium" (our expected probs), thus the system IS in Haerdy-Equilibrium

# Degrees of freedom are the number of classes - 1
# Imagine you have 6 categories (AA, BB, CC, AB, AC, BC). If I tell you the counts for the first 5 categories, you can automatically calculate the 6th one by subtracting the others from 375.
# Because the total is fixed (∑Oi=n), the last category has no freedom; it must be whatever is left over.
# Therefore, only 5 (6−1) categories are truly independent "bits" of information.
print("Degrees of freedom")
print(length(observed_counts)-1)

# ------------

###############################################################################
# Exercise 6: Health Habits - Independence Testing
###############################################################################
#
# Explore the “Health Habits” example of independence testing, i.e., find out if there is a resonable relation between smoking and exercising frequently
#
# Unlike the "Goodness of Fit" tests we just did (which had one row of data), independence testing uses a Contingency Table (or two-way table).
#     Rows: Represent categories of one variable (e.g., Smoker, Non-Smoker).
#     Columns: Represent categories of the second variable (e.g., Sedentary, Active).
#
# For an independence test, the df formula is slightly different because you have constraints on both the rows and the columns:
#
#     df=(Number of Rows−1)×(Number of Columns−1)
#
# R then calculates the expected counts if the variables were independent using the formula:
#
#            E = (Row Total × Column Total)/(Grand Total)
#
#       Which is a direct application of the rule of independece P(A and B)=P(A)×P(B), as
#
#            E = Grand Total × (Row Total/Gran Total) × (Column Total/Grand Total)
#
# Note: Chi-Square is done under the assumption of "independence" of the variables, in this case then H0 is supposed to be "Smoking and being Active are independent"

# Suppose we have a table of 100 people:
# Columns: Exercise (Yes/No) | Rows: Smoking (Yes/No)
health_data <- matrix(c(10, 30,  # Smokers (10 exercise, 30 don't)
                        40, 20), # Non-smokers (40 exercise, 20 don't)
                      nrow = 2, byrow = TRUE)

# Run the independence test
test_result <- chisq.test(health_data)
print(test_result) # p-value 0.000105, we REJECT H0 and thus we conclude there is a correlation between smoking and being physically active

