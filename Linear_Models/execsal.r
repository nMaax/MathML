###############
# execsal.r - Analysis of Executive Salary database 
# taken from Mendenhall and Sincich (7th ed)
# A Second Course in Business Statistics: Regression Analysis
#
###############

# reading the data into R
exec <- read.table("Data/execsal.txt", header=T)
str(exec)
attach(exec)

# competitive linear models; notice the log(SALARY) transformation
summary(exec.lm <- lm(SALARY ~ EXP+EDUC+GENDER+NUMSUP+ASSETS))
summary(exec.lm1 <- lm(log(SALARY)~ EXP+EDUC+GENDER+NUMSUP+ASSETS))

# results are not so clear
plot(exec.lm)
plot(exec.lm1)
 
# interpret the estimate of the regression coefficient of EDUC
# (years of education)
coef(exec.lm1)

# including an interaction term GENDER*NUMSUP (results are not clear,
# but the interaction term is somewhat significant)
summary(exec.lm2 <- lm(log(SALARY)~ EXP+EDUC+ASSETS+GENDER+NUMSUP+GENDER*NUMSUP))

# explore residual plots
plot(exec.lm2)
# but again, the results are not so clear

